Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DROPDOWN = 0x2
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Global Const $ES_LEFT = 0
Global Const $ES_CENTER = 1
Global Const $ES_PASSWORD = 32
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $ES_NUMBER = 8192
Global Const $__EDITCONSTANT_WS_VSCROLL = 0x00200000
Global Const $__EDITCONSTANT_WS_HSCROLL = 0x00100000
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Global Const $GUI_SS_DEFAULT_INPUT = BitOR($ES_LEFT, $ES_AUTOHSCROLL)
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_CHECKED = 1
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_DISABLE = 128
Global Const $__STATUSBARCONSTANT_WM_USER = 0X400
Global Const $SB_GETUNICODEFORMAT = 0x2000 + 6
Global Const $SB_ISSIMPLE =($__STATUSBARCONSTANT_WM_USER + 14)
Global Const $SB_SETPARTS =($__STATUSBARCONSTANT_WM_USER + 4)
Global Const $SB_SETTEXTA =($__STATUSBARCONSTANT_WM_USER + 1)
Global Const $SB_SETTEXTW =($__STATUSBARCONSTANT_WM_USER + 11)
Global Const $SB_SETTEXT = $SB_SETTEXTA
Global Const $SB_SIMPLEID = 0xff
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $PAGE_READWRITE = 0x00000004
Global Const $MEM_RELEASE = 0x00008000
Global Const $tagPOINT = "struct;long X;long Y;endstruct"
Global Const $tagTOKEN_PRIVILEGES = "dword Count;align 4;int64 LUID;dword Attributes"
Global Const $PROCESS_VM_OPERATION = 0x00000008
Global Const $PROCESS_VM_READ = 0x00000010
Global Const $PROCESS_VM_WRITE = 0x00000020
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
Func _WinAPI_GetLastError($curErr=@error, $curExt=@extended)
Local $aResult = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($curErr, $curExt, $aResult[0])
EndFunc
Func _Security__AdjustTokenPrivileges($hToken, $fDisableAll, $pNewState, $iBufferLen, $pPrevState = 0, $pRequired = 0)
Local $aResult = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $hToken, "bool", $fDisableAll, "ptr", $pNewState, _
"dword", $iBufferLen, "ptr", $pPrevState, "ptr", $pRequired)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _Security__ImpersonateSelf($iLevel = 2)
Local $aResult = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $iLevel)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _Security__LookupPrivilegeValue($sSystem, $sName)
Local $aResult = DllCall("advapi32.dll", "int", "LookupPrivilegeValueW", "wstr", $sSystem, "wstr", $sName, "int64*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return SetError(0, $aResult[0], $aResult[3])
EndFunc
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $fOpenAsSelf = False)
If $hThread = 0 Then $hThread = DllCall("kernel32.dll", "handle", "GetCurrentThread")
If @error Then Return SetError(@error, @extended, 0)
Local $aResult = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $hThread[0], "dword", $iAccess, "int", $fOpenAsSelf, "ptr*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return SetError(0, $aResult[0], $aResult[4])
EndFunc
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $fOpenAsSelf = False)
Local $hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
If $hToken = 0 Then
If _WinAPI_GetLastError() <> $ERROR_NO_TOKEN Then Return SetError(-3, _WinAPI_GetLastError(), 0)
If Not _Security__ImpersonateSelf() Then Return SetError(-1, _WinAPI_GetLastError(), 0)
$hToken = _Security__OpenThreadToken($iAccess, $hThread, $fOpenAsSelf)
If $hToken = 0 Then Return SetError(-2, _WinAPI_GetLastError(), 0)
EndIf
Return $hToken
EndFunc
Func _Security__SetPrivilege($hToken, $sPrivilege, $fEnable)
Local $iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
If $iLUID = 0 Then Return SetError(-1, 0, False)
Local $tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $pCurrState = DllStructGetPtr($tCurrState)
Local $iCurrState = DllStructGetSize($tCurrState)
Local $tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
Local $pPrevState = DllStructGetPtr($tPrevState)
Local $iPrevState = DllStructGetSize($tPrevState)
Local $tRequired = DllStructCreate("int Data")
Local $pRequired = DllStructGetPtr($tRequired)
DllStructSetData($tCurrState, "Count", 1)
DllStructSetData($tCurrState, "LUID", $iLUID)
If Not _Security__AdjustTokenPrivileges($hToken, False, $pCurrState, $iCurrState, $pPrevState, $pRequired) Then  _
Return SetError(-2, @error, False)
DllStructSetData($tPrevState, "Count", 1)
DllStructSetData($tPrevState, "LUID", $iLUID)
Local $iAttributes = DllStructGetData($tPrevState, "Attributes")
If $fEnable Then
$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
Else
$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
EndIf
DllStructSetData($tPrevState, "Attributes", $iAttributes)
If Not _Security__AdjustTokenPrivileges($hToken, False, $pPrevState, $iPrevState, $pCurrState, $pRequired) Then _
Return SetError(-3, @error, False)
Return True
EndFunc
Global Const $tagMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _MemFree(ByRef $tMemMap)
Local $pMemory = DllStructGetData($tMemMap, "Mem")
Local $hProcess = DllStructGetData($tMemMap, "hProc")
Local $bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hProcess)
If @error Then Return SetError(@error, @extended, False)
Return $bResult
EndFunc
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
Local $aResult = DllCall("User32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Local $iProcessID = $aResult[2]
If $iProcessID = 0 Then Return SetError(1, 0, 0)
Local $iAccess = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
Local $hProcess = __Mem_OpenProcess($iAccess, False, $iProcessID, True)
Local $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
Local $pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
If $pMemory = 0 Then Return SetError(2, 0, 0)
$tMemMap = DllStructCreate($tagMEMMAP)
DllStructSetData($tMemMap, "hProc", $hProcess)
DllStructSetData($tMemMap, "Size", $iSize)
DllStructSetData($tMemMap, "Mem", $pMemory)
Return $pMemory
EndFunc
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "ptr")
If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
Local $aResult = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), _
"ptr", $pDest, $sSrce, $pSrce, "ulong_ptr", $iSize, "ulong_ptr*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
Local $aResult = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iAllocation, "dword", $iProtect)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
Local $aResult = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iFreeType)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func __Mem_OpenProcess($iAccess, $fInherit, $iProcessID, $fDebugPriv=False)
Local $aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $fInherit, "dword", $iProcessID)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return $aResult[0]
If Not $fDebugPriv Then Return 0
Local $hToken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
If @error Then Return SetError(@error, @extended, 0)
_Security__SetPrivilege($hToken, "SeDebugPrivilege", True)
Local $iError = @error
Local $iLastError = @extended
Local $iRet = 0
If Not @error Then
$aResult = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $fInherit, "dword", $iProcessID)
$iError = @error
$iLastError = @extended
If $aResult[0] Then $iRet = $aResult[0]
_Security__SetPrivilege($hToken, "SeDebugPrivilege", False)
If @error Then
$iError = @error
$iLastError = @extended
EndIf
EndIf
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hToken)
Return SetError($iError, $iLastError, $iRet)
EndFunc
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
Global $__gaInProcess_WinAPI[64][2] = [[0, 0]]
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _WinAPI_CreateWindowEx($iExStyle, $sClass, $sName, $iStyle, $iX, $iY, $iWidth, $iHeight, $hParent, $hMenu = 0, $hInstance = 0, $pParam = 0)
If $hInstance = 0 Then $hInstance = _WinAPI_GetModuleHandle("")
Local $aResult = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $iExStyle, "wstr", $sClass, "wstr", $sName, "dword", $iStyle, "int", $iX, _
"int", $iY, "int", $iWidth, "int", $iHeight, "hwnd", $hParent, "handle", $hMenu, "handle", $hInstance, "ptr", $pParam)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Then Return SetError(@error, @extended, False)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_GetModuleHandle($sModuleName)
Local $sModuleNameType = "wstr"
If $sModuleName = "" Then
$sModuleName = 0
$sModuleNameType = "ptr"
EndIf
Local $aResult = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $sModuleNameType, $sModuleName)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
Local $aResult = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
$iPID = $aResult[2]
Return $aResult[0]
EndFunc
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
If $hWnd = $hLastWnd Then Return True
For $iI = $__gaInProcess_WinAPI[0][0] To 1 Step -1
If $hWnd = $__gaInProcess_WinAPI[$iI][0] Then
If $__gaInProcess_WinAPI[$iI][1] Then
$hLastWnd = $hWnd
Return True
Else
Return False
EndIf
EndIf
Next
Local $iProcessID
_WinAPI_GetWindowThreadProcessId($hWnd, $iProcessID)
Local $iCount = $__gaInProcess_WinAPI[0][0] + 1
If $iCount >= 64 Then $iCount = 1
$__gaInProcess_WinAPI[0][0] = $iCount
$__gaInProcess_WinAPI[$iCount][0] = $hWnd
$__gaInProcess_WinAPI[$iCount][1] =($iProcessID = @AutoItPID)
Return $__gaInProcess_WinAPI[$iCount][1]
EndFunc
Func _WinAPI_IsClassName($hWnd, $sClassName)
Local $sSeparator = Opt("GUIDataSeparatorChar")
Local $aClassName = StringSplit($sClassName, $sSeparator)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $sClassCheck = _WinAPI_GetClassName($hWnd)
For $x = 1 To UBound($aClassName) - 1
If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then Return True
Next
Return False
EndFunc
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global Const $__UDFGUICONSTANT_WS_VISIBLE = 0x10000000
Global Const $__UDFGUICONSTANT_WS_CHILD = 0x40000000
Global $_UDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1]
Func __UDF_GetNextGlobalID($hWnd)
Local $nCtrlID, $iUsedIndex = -1, $fAllUsed = True
If Not WinExists($hWnd) Then Return SetError(-1, -1, 0)
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] <> 0 Then
If Not WinExists($_UDF_GlobalIDs_Used[$iIndex][0]) Then
For $x = 0 To UBound($_UDF_GlobalIDs_Used, 2) - 1
$_UDF_GlobalIDs_Used[$iIndex][$x] = 0
Next
$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$fAllUsed = False
EndIf
EndIf
Next
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
If $iUsedIndex = -1 Then
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $_UDF_GlobalIDs_Used[$iIndex][0] = 0 Then
$_UDF_GlobalIDs_Used[$iIndex][0] = $hWnd
$_UDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$fAllUsed = False
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
EndIf
If $iUsedIndex = -1 And $fAllUsed Then Return SetError(16, 0, 0)
If $_UDF_GlobalIDs_Used[$iUsedIndex][1] = $_UDF_STARTID + $_UDF_GlobalID_MAX_IDS Then
For $iIDIndex = $_UDF_GlobalIDs_OFFSET To UBound($_UDF_GlobalIDs_Used, 2) - 1
If $_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = 0 Then
$nCtrlID =($iIDIndex - $_UDF_GlobalIDs_OFFSET) + 10000
$_UDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = $nCtrlID
Return $nCtrlID
EndIf
Next
Return SetError(-1, $_UDF_GlobalID_MAX_IDS, 0)
EndIf
$nCtrlID = $_UDF_GlobalIDs_Used[$iUsedIndex][1]
$_UDF_GlobalIDs_Used[$iUsedIndex][1] += 1
$_UDF_GlobalIDs_Used[$iUsedIndex][($nCtrlID - 10000) + $_UDF_GlobalIDs_OFFSET] = $nCtrlID
Return $nCtrlID
EndFunc
Func __UDF_DebugPrint($sText, $iLine = @ScriptLineNumber, $err=@error, $ext=@extended)
ConsoleWrite( _
"!===========================================================" & @CRLF & _
"+======================================================" & @CRLF & _
"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @CRLF & _
"+======================================================" & @CRLF)
Return SetError($err, $ext, 1)
EndFunc
Func __UDF_ValidateClassName($hWnd, $sClassNames)
__UDF_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
If _WinAPI_IsClassName($hWnd, $sClassNames) Then Return True
Local $sSeparator = Opt("GUIDataSeparatorChar")
$sClassNames = StringReplace($sClassNames, $sSeparator, ",")
__UDF_DebugPrint("Invalid Class Type(s):" & @LF & @TAB & "Expecting Type(s): " & $sClassNames & @LF & @TAB & "Received Type : " & _WinAPI_GetClassName($hWnd))
Exit
EndFunc
Global $__ghSBLastWnd
Global $Debug_SB = False
Global Const $__STATUSBARCONSTANT_ClassName = "msctls_statusbar32"
Global Const $__STATUSBARCONSTANT_WM_SIZE = 0x05
Func _GUICtrlStatusBar_Create($hWnd, $vPartEdge = -1, $vPartText = "", $iStyles = -1, $iExStyles = -1)
If Not IsHWnd($hWnd) Then Return SetError(1, 0, 0)
Local $iStyle = BitOR($__UDFGUICONSTANT_WS_CHILD, $__UDFGUICONSTANT_WS_VISIBLE)
If $iStyles = -1 Then $iStyles = 0x00000000
If $iExStyles = -1 Then $iExStyles= 0x00000000
Local $aPartWidth[1], $aPartText[1]
If @NumParams > 1 Then
If IsArray($vPartEdge) Then
$aPartWidth = $vPartEdge
Else
$aPartWidth[0] = $vPartEdge
EndIf
If @NumParams = 2 Then
ReDim $aPartText[UBound($aPartWidth)]
Else
If IsArray($vPartText) Then
$aPartText = $vPartText
Else
$aPartText[0] = $vPartText
EndIf
If UBound($aPartWidth) <> UBound($aPartText) Then
Local $iLast
If UBound($aPartWidth) > UBound($aPartText) Then
$iLast = UBound($aPartText)
ReDim $aPartText[UBound($aPartWidth)]
For $x = $iLast To UBound($aPartText) - 1
$aPartWidth[$x] = ""
Next
Else
$iLast = UBound($aPartWidth)
ReDim $aPartWidth[UBound($aPartText)]
For $x = $iLast To UBound($aPartWidth) - 1
$aPartWidth[$x] = $aPartWidth[$x - 1] + 75
Next
$aPartWidth[UBound($aPartText) - 1] = -1
EndIf
EndIf
EndIf
If Not IsHWnd($hWnd) Then $hWnd = HWnd($hWnd)
If @NumParams > 3 Then $iStyle = BitOR($iStyle, $iStyles)
EndIf
Local $nCtrlID = __UDF_GetNextGlobalID($hWnd)
If @error Then Return SetError(@error, @extended, 0)
Local $hWndSBar = _WinAPI_CreateWindowEx($iExStyles, $__STATUSBARCONSTANT_ClassName, "", $iStyle, 0, 0, 0, 0, $hWnd, $nCtrlID)
If @error Then Return SetError(@error, @extended, 0)
If @NumParams > 1 Then
_GUICtrlStatusBar_SetParts($hWndSBar, UBound($aPartWidth), $aPartWidth)
For $x = 0 To UBound($aPartText) - 1
_GUICtrlStatusBar_SetText($hWndSBar, $aPartText[$x], $x)
Next
EndIf
Return $hWndSBar
EndFunc
Func _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Return _SendMessage($hWnd, $SB_GETUNICODEFORMAT) <> 0
EndFunc
Func _GUICtrlStatusBar_IsSimple($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Return _SendMessage($hWnd, $SB_ISSIMPLE) <> 0
EndFunc
Func _GUICtrlStatusBar_Resize($hWnd)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
_SendMessage($hWnd, $__STATUSBARCONSTANT_WM_SIZE)
EndFunc
Func _GUICtrlStatusBar_SetParts($hWnd, $iaParts = -1, $iaPartWidth = 25)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $tParts, $iParts = 1
If IsArray($iaParts) <> 0 Then
$iaParts[UBound($iaParts) - 1] = -1
$iParts = UBound($iaParts)
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 0 To $iParts - 2
DllStructSetData($tParts, 1, $iaParts[$x], $x + 1)
Next
DllStructSetData($tParts, 1, -1, $iParts)
ElseIf IsArray($iaPartWidth) <> 0 Then
$iParts = UBound($iaPartWidth)
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 0 To $iParts - 2
DllStructSetData($tParts, 1, $iaPartWidth[$x], $x + 1)
Next
DllStructSetData($tParts, 1, -1, $iParts)
ElseIf $iaParts > 1 Then
$iParts = $iaParts
$tParts = DllStructCreate("int[" & $iParts & "]")
For $x = 1 To $iParts - 1
DllStructSetData($tParts, 1, $iaPartWidth * $x, $x)
Next
DllStructSetData($tParts, 1, -1, $iParts)
Else
$tParts = DllStructCreate("int")
DllStructSetData($tParts, $iParts, -1)
EndIf
Local $pParts = DllStructGetPtr($tParts)
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
_SendMessage($hWnd, $SB_SETPARTS, $iParts, $pParts, 0, "wparam", "ptr")
Else
Local $iSize = DllStructGetSize($tParts)
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iSize, $tMemMap)
_MemWrite($tMemMap, $pParts)
_SendMessage($hWnd, $SB_SETPARTS, $iParts, $pMemory, 0, "wparam", "ptr")
_MemFree($tMemMap)
EndIf
_GUICtrlStatusBar_Resize($hWnd)
Return True
EndFunc
Func _GUICtrlStatusBar_SetText($hWnd, $sText = "", $iPart = 0, $iUFlag = 0)
If $Debug_SB Then __UDF_ValidateClassName($hWnd, $__STATUSBARCONSTANT_ClassName)
Local $fUnicode = _GUICtrlStatusBar_GetUnicodeFormat($hWnd)
Local $iBuffer = StringLen($sText) + 1
Local $tText
If $fUnicode Then
$tText = DllStructCreate("wchar Text[" & $iBuffer & "]")
$iBuffer *= 2
Else
$tText = DllStructCreate("char Text[" & $iBuffer & "]")
EndIf
Local $pBuffer = DllStructGetPtr($tText)
DllStructSetData($tText, "Text", $sText)
If _GUICtrlStatusBar_IsSimple($hWnd) Then $iPart = $SB_SIMPLEID
Local $iRet
If _WinAPI_InProcess($hWnd, $__ghSBLastWnd) Then
$iRet = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $pBuffer, 0, "wparam", "ptr")
Else
Local $tMemMap
Local $pMemory = _MemInit($hWnd, $iBuffer, $tMemMap)
_MemWrite($tMemMap, $pBuffer)
If $fUnicode Then
$iRet = _SendMessage($hWnd, $SB_SETTEXTW, BitOR($iPart, $iUFlag), $pMemory, 0, "wparam", "ptr")
Else
$iRet = _SendMessage($hWnd, $SB_SETTEXT, BitOR($iPart, $iUFlag), $pMemory, 0, "wparam", "ptr")
EndIf
_MemFree($tMemMap)
EndIf
Return $iRet <> 0
EndFunc
Global Const $TCCM_FIRST = 0X2000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_CLIPSIBLINGS = 0x04000000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_STATICEDGE = 0x00020000
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Global Const $DTS_UPDOWN = 1
Global Const $DTS_TIMEFORMAT = 9
Func _DateDiff($sType, $sStartDate, $sEndDate)
$sType = StringLeft($sType, 1)
If StringInStr("d,m,y,w,h,n,s", $sType) = 0 Or $sType = "" Then
Return SetError(1,0,0)
EndIf
If Not _DateIsValid($sStartDate) Then
Return SetError(2,0,0)
EndIf
If Not _DateIsValid($sEndDate) Then
Return SetError(3,0,0)
EndIf
Local $asStartDatePart[4], $asStartTimePart[4], $asEndDatePart[4], $asEndTimePart[4]
_DateTimeSplit($sStartDate, $asStartDatePart, $asStartTimePart)
_DateTimeSplit($sEndDate, $asEndDatePart, $asEndTimePart)
Local $aDaysDiff = _DateToDayValue($asEndDatePart[1], $asEndDatePart[2], $asEndDatePart[3]) - _DateToDayValue($asStartDatePart[1], $asStartDatePart[2], $asStartDatePart[3])
Local $iTimeDiff, $iYearDiff, $iStartTimeInSecs, $iEndTimeInSecs
If $asStartTimePart[0] > 1 And $asEndTimePart[0] > 1 Then
$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
If $iTimeDiff < 0 Then
$aDaysDiff = $aDaysDiff - 1
$iTimeDiff = $iTimeDiff + 24 * 60 * 60
EndIf
Else
$iTimeDiff = 0
EndIf
Select
Case $sType = "d"
Return($aDaysDiff)
Case $sType = "m"
$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
Local $iMonthDiff = $asEndDatePart[2] - $asStartDatePart[2] + $iYearDiff * 12
If $asEndDatePart[3] < $asStartDatePart[3] Then $iMonthDiff = $iMonthDiff - 1
$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
If $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iMonthDiff = $iMonthDiff - 1
Return($iMonthDiff)
Case $sType = "y"
$iYearDiff = $asEndDatePart[1] - $asStartDatePart[1]
If $asEndDatePart[2] < $asStartDatePart[2] Then $iYearDiff = $iYearDiff - 1
If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] < $asStartDatePart[3] Then $iYearDiff = $iYearDiff - 1
$iStartTimeInSecs = $asStartTimePart[1] * 3600 + $asStartTimePart[2] * 60 + $asStartTimePart[3]
$iEndTimeInSecs = $asEndTimePart[1] * 3600 + $asEndTimePart[2] * 60 + $asEndTimePart[3]
$iTimeDiff = $iEndTimeInSecs - $iStartTimeInSecs
If $asEndDatePart[2] = $asStartDatePart[2] And $asEndDatePart[3] = $asStartDatePart[3] And $iTimeDiff < 0 Then $iYearDiff = $iYearDiff - 1
Return($iYearDiff)
Case $sType = "w"
Return(Int($aDaysDiff / 7))
Case $sType = "h"
Return($aDaysDiff * 24 + Int($iTimeDiff / 3600))
Case $sType = "n"
Return($aDaysDiff * 24 * 60 + Int($iTimeDiff / 60))
Case $sType = "s"
Return($aDaysDiff * 24 * 60 * 60 + $iTimeDiff)
EndSelect
EndFunc
Func _DateIsLeapYear($iYear)
If StringIsInt($iYear) Then
Select
Case Mod($iYear, 4) = 0 And Mod($iYear, 100) <> 0
Return 1
Case Mod($iYear, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1,0,0)
EndFunc
Func _DateIsValid($sDate)
Local $asDatePart[4], $asTimePart[4]
Local $sDateTime = StringSplit($sDate, " T")
If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
If UBound($asDatePart) <> 4 Then Return(0)
If $asDatePart[0] <> 3 Then Return(0)
If Not StringIsInt($asDatePart[1]) Then Return(0)
If Not StringIsInt($asDatePart[2]) Then Return(0)
If Not StringIsInt($asDatePart[3]) Then Return(0)
$asDatePart[1] = Number($asDatePart[1])
$asDatePart[2] = Number($asDatePart[2])
$asDatePart[3] = Number($asDatePart[3])
Local $iNumDays = _DaysInMonth($asDatePart[1])
If $asDatePart[1] < 1000 Or $asDatePart[1] > 2999 Then Return(0)
If $asDatePart[2] < 1 Or $asDatePart[2] > 12 Then Return(0)
If $asDatePart[3] < 1 Or $asDatePart[3] > $iNumDays[$asDatePart[2]] Then Return(0)
If $sDateTime[0] > 1 Then
$asTimePart = StringSplit($sDateTime[2], ":")
If UBound($asTimePart) < 4 Then ReDim $asTimePart[4]
Else
Dim $asTimePart[4]
EndIf
If $asTimePart[0] < 1 Then Return(1)
If $asTimePart[0] < 2 Then Return(0)
If $asTimePart[0] = 2 Then $asTimePart[3] = "00"
If Not StringIsInt($asTimePart[1]) Then Return(0)
If Not StringIsInt($asTimePart[2]) Then Return(0)
If Not StringIsInt($asTimePart[3]) Then Return(0)
$asTimePart[1] = Number($asTimePart[1])
$asTimePart[2] = Number($asTimePart[2])
$asTimePart[3] = Number($asTimePart[3])
If $asTimePart[1] < 0 Or $asTimePart[1] > 23 Then Return(0)
If $asTimePart[2] < 0 Or $asTimePart[2] > 59 Then Return(0)
If $asTimePart[3] < 0 Or $asTimePart[3] > 59 Then Return(0)
Return 1
EndFunc
Func _DateTimeSplit($sDate, ByRef $asDatePart, ByRef $iTimePart)
Local $sDateTime = StringSplit($sDate, " T")
If $sDateTime[0] > 0 Then $asDatePart = StringSplit($sDateTime[1], "/-.")
If $sDateTime[0] > 1 Then
$iTimePart = StringSplit($sDateTime[2], ":")
If UBound($iTimePart) < 4 Then ReDim $iTimePart[4]
Else
Dim $iTimePart[4]
EndIf
If UBound($asDatePart) < 4 Then ReDim $asDatePart[4]
For $x = 1 To 3
If StringIsInt($asDatePart[$x]) Then
$asDatePart[$x] = Number($asDatePart[$x])
Else
$asDatePart[$x] = -1
EndIf
If StringIsInt($iTimePart[$x]) Then
$iTimePart[$x] = Number($iTimePart[$x])
Else
$iTimePart[$x] = 0
EndIf
Next
Return 1
EndFunc
Func _DateToDayValue($iYear, $iMonth, $iDay)
If Not _DateIsValid(StringFormat("%04d/%02d/%02d", $iYear, $iMonth, $iDay)) Then
Return SetError(1,0,"")
EndIf
If $iMonth < 3 Then
$iMonth = $iMonth + 12
$iYear = $iYear - 1
EndIf
Local $i_aFactor = Int($iYear / 100)
Local $i_bFactor = Int($i_aFactor / 4)
Local $i_cFactor = 2 - $i_aFactor + $i_bFactor
Local $i_eFactor = Int(1461 *($iYear + 4716) / 4)
Local $i_fFactor = Int(153 *($iMonth + 1) / 5)
Local $iJulianDate = $i_cFactor + $iDay + $i_eFactor + $i_fFactor - 1524.5
Return($iJulianDate)
EndFunc
Func _NowCalc()
Return(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
EndFunc
Func _DaysInMonth($iYear)
Local $aiDays[13] = [ 0, 31,28,31,30,31,30,31,31,30,31,30,31]
If _DateIsLeapYear($iYear) Then $aiDays[2] = 29
Return $aiDays
EndFunc
Func _HexToString($strHex)
If StringLeft($strHex, 2) = "0x" Then Return BinaryToString($strHex)
Return BinaryToString("0x" & $strHex)
EndFunc
Func _StringToHex($strChar)
Return Hex(StringToBinary($strChar))
EndFunc
Func _ArrayAdd(ByRef $avArray, $vValue)
If Not IsArray($avArray) Then Return SetError(1, 0, -1)
If UBound($avArray, 0) <> 1 Then Return SetError(2, 0, -1)
Local $iUBound = UBound($avArray)
ReDim $avArray[$iUBound + 1]
$avArray[$iUBound] = $vValue
Return $iUBound
EndFunc
Opt("TrayMenuMode", 1)
Global $usr, $psd, $fire, $cta, $d2path1, $d2path2, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5
Global $pos, $guibhTime, $guiboxing, $guiboxqty, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime
Local $avArray[3], $avArrayP[8], $avArrayName[2]
Global $guiothercheck, $guistaymin
Global $Files = "system.log"
$Form1_1_2_1 = GUICreate("暗黑2-挂机王-shop商店版", 641, 556, 192, 124)
$Tab1 = GUICtrlCreateTab(8, 8, 625, 521)
$TabSheet1 = GUICtrlCreateTabItem("系统设置")
$Group1 = GUICtrlCreateGroup("帐号信息(可不输入,但需已登陆战网)", 20, 33, 225, 113)
$Label1 = GUICtrlCreateLabel("站网帐号", 28, 57, 52, 17)
$Label2 = GUICtrlCreateLabel("站网密码", 28, 89, 52, 17)
$n1 = GUICtrlCreateInput("", 84, 49, 89, 21)
$n2 = GUICtrlCreateInput("", 84, 81, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("角色位置", 252, 33, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 260, 49, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 260, 73, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 260, 97, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 260, 121, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 332, 49, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 332, 73, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 332, 97, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 332, 121, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$YesID = GUICtrlCreateButton("锁定", 396, 441, 75, 25)
$Group7 = GUICtrlCreateGroup("暗黑路径(鼠标右击游戏快捷方式获得)", 20, 280, 593, 89)
$path1 = GUICtrlCreateInput("E:\暗黑破坏神II毁灭之王\D2loader.exe -w -lq -direct -title d2", 112, 304, 473, 21)
$Label16 = GUICtrlCreateLabel("程序目标:", 32, 304, 55, 17)
$Label17 = GUICtrlCreateLabel("起始位置：", 32, 336, 64, 17)
$path2 = GUICtrlCreateInput("E:\暗黑破坏神II毁灭之王", 112, 336, 289, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$SaveID = GUICtrlCreateButton("保存", 108, 441, 75, 25)
$ExitID = GUICtrlCreateButton("退出", 244, 441, 75, 25)
$Label18 = GUICtrlCreateLabel("点锁定后F9运行,F10退出", 416, 472, 133, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group8 = GUICtrlCreateGroup("功能设置", 424, 145, 193, 121)
$ckbBagfull = GUICtrlCreateCheckbox("包满后关机", 440, 161, 97, 17)
$ckbBoxing = GUICtrlCreateCheckbox("包裹满是否装箱", 440, 181, 121, 17)
$boxQty = GUICtrlCreateInput("8", 576, 201, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label20 = GUICtrlCreateLabel("少于此格数执行", 464, 201, 88, 17)
$ckbother = GUICtrlCreateCheckbox("检查他人进房间", 440, 224, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group9 = GUICtrlCreateGroup("房间名设置", 424, 32, 185, 113)
$RDnameAp = GUICtrlCreateRadio("字母房间名", 440, 48, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDnameMa = GUICtrlCreateRadio("数字房间名", 440, 72, 113, 17)
$namelenfr = GUICtrlCreateInput("3", 480, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("到", 512, 104, 16, 17)
$namelento = GUICtrlCreateInput("6", 536, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("位", 568, 104, 16, 17)
$Label23 = GUICtrlCreateLabel("长度:", 440, 104, 31, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group10 = GUICtrlCreateGroup("附加设置", 19, 152, 393, 113)
$dtshut = GUICtrlCreateDate("2011/06/03 12:13:43", 107, 176, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))
GUICtrlSendMsg(-1, 0x1032, 0, "yyyy/MM/dd HH:mm:ss")
$ckbTimeshut = GUICtrlCreateCheckbox("定时关机:", 27, 176, 73, 17)
$Label3 = GUICtrlCreateLabel("房间内最大停留分钟：", 24, 208, 124, 17)
$staymin = GUICtrlCreateInput("60", 160, 208, 73, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("日志查看")
$edtLog = GUICtrlCreateEdit("", 16, 40, 604, 432)
$readlog = GUICtrlCreateButton("读取", 95, 492, 75, 25)
$deletLog = GUICtrlCreateButton("清空", 362, 493, 75, 25)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [400, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "不发送任何数据包,避开Warden检测机制,请合理安排挂机时间", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036", 1)
TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("参数")
TrayCreateItem("")
$aboutitem = TrayCreateItem("关于")
TrayCreateItem("")
$exititem = TrayCreateItem("退出")
$mainform = WinGetHandle($Form1_1_2_1)
Func creatGui()
TraySetState()
GUISetState(@SW_SHOW, $mainform)
readinfor()
While 1
$msg = GUIGetMsg()
$usr = GUICtrlRead($n1)
$psd = GUICtrlRead($n2)
Select
Case $msg = $SaveID
If saveinfor() Then
MsgBox(0, "成功", "保存成功")
EndIf
Case $msg = $YesID
GUICtrlSetState($SaveID, $GUI_DISABLE)
GUICtrlSetState($ExitID, $GUI_DISABLE)
ExitLoop
Case $msg = $ExitID
Exit 0
Case $msg = $GUI_EVENT_CLOSE
Exit 0
Case $msg = $readlog
GUICtrlSetData($edtLog, Readdate())
Case $msg = $deletLog
Setdate()
EndSelect
$msg1 = TrayGetMsg()
Select
Case $msg1 = 0
ContinueLoop
Case $msg1 = $prefsitem
MsgBox(64, "参数:", "系统版本:" & @OSVersion)
Case $msg1 = $aboutitem
MsgBox(64, "关于:", "暗黑2专用KP挂机工具.")
Case $msg1 = $exititem
Exit 0
EndSelect
WEnd
EndFunc
Func saveinfor()
$lenNamefr = GUICtrlRead($namelenfr)
$lenNameto = GUICtrlRead($namelento)
$lenboxqty = GUICtrlRead($boxQty)
If $lenNamefr <= 0 Then
MsgBox(0, "错误", "房间长度至少要有1位吧！")
Return False
EndIf
If $lenNamefr > $lenNameto Then
MsgBox(0, "错误", "起始长度大于结束长度了！")
Return False
EndIf
If $lenNameto > 10 Then
MsgBox(0, "错误", "没有人会建10位以上的房间名，建议控制在8位以内！")
Return False
EndIf
If $lenboxqty <= 0 Or $lenboxqty >= 40 Then
MsgBox(0, "警告", "包裹剩余数量必须控制在1 到 39之间,建议5或10格之间")
Return False
EndIf
$avArrayP[0] = $RadP1
$avArrayP[1] = $RadP2
$avArrayP[2] = $RadP3
$avArrayP[3] = $RadP4
$avArrayP[4] = $RadP5
$avArrayP[5] = $RadP6
$avArrayP[6] = $RadP7
$avArrayP[7] = $RadP8
$avArrayName[0] = $RDnameAp
$avArrayName[1] = $RDnameMa
For $i = 0 To 2 Step 1
If BitAND(GUICtrlRead($avArray[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
$fire = $i + 1
EndIf
Next
For $i = 0 To 7 Step 1
If BitAND(GUICtrlRead($avArrayP[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
$pos = $i + 1
EndIf
Next
For $i = 0 To 1 Step 1
If BitAND(GUICtrlRead($avArrayName[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
$nameCat = $i + 1
EndIf
Next
If BitAND(GUICtrlRead($ckbBagfull), $GUI_CHECKED) = $GUI_CHECKED Then
$shutdown = 1
Else
$shutdown = 0
EndIf
If BitAND(GUICtrlRead($ckbBoxing), $GUI_CHECKED) = $GUI_CHECKED Then
$guiboxing = 1
Else
$guiboxing = 0
EndIf
If BitAND(GUICtrlRead($ckbTimeshut), $GUI_CHECKED) = $GUI_CHECKED Then
$guisettime = 1
Else
$guisettime = 0
EndIf
If BitAND(GUICtrlRead($ckbother), $GUI_CHECKED) = $GUI_CHECKED Then
$guiothercheck = 1
Else
$guiothercheck = 0
EndIf
IniWrite("info.dat", "shop", "帐号", GUICtrlRead($n1))
IniWrite("info.dat", "shop", "密码", _StringToHex(GUICtrlRead($n2)))
IniWrite("info.dat", "shop", "位置", $pos)
IniWrite("info.dat", "shop", "程序目标", GUICtrlRead($path1))
IniWrite("info.dat", "shop", "起始位置", GUICtrlRead($path2))
IniWrite("info.dat", "shop", "包裹满后关机", $shutdown)
IniWrite("info.dat", "shop", "包裹满装箱", $guiboxing)
IniWrite("info.dat", "shop", "少于格数开始装箱", GUICtrlRead($boxQty))
IniWrite("info.dat", "shop", "房间名格式", $nameCat)
IniWrite("info.dat", "shop", "房间名长度下限", GUICtrlRead($namelenfr))
IniWrite("info.dat", "shop", "房间名长度上限", GUICtrlRead($namelento))
IniWrite("info.dat", "shop", "是否定时关机", $guisettime)
IniWrite("info.dat", "shop", "定时关机时间", GUICtrlRead($dtshut))
IniWrite("info.dat", "shop", "检查其他人进入", $guiothercheck)
IniWrite("info.dat", "shop", "房间内最大分钟数", GUICtrlRead($staymin))
Return True
EndFunc
Func readinfor()
$guistaymin =60
$usr = IniRead("info.dat", "shop", "帐号", "")
$psd = _HexToString(IniRead("info.dat", "shop", "密码", ""))
$pos = IniRead("info.dat", "shop", "位置", "")
$d2path1 = IniRead("info.dat", "shop", "程序目标", "")
$d2path2 = IniRead("info.dat", "shop", "起始位置", "")
$shutdown = IniRead("info.dat", "shop", "包裹满后关机", "")
$nameCat = IniRead("info.dat", "shop", "房间名格式", "")
$guiboxing = IniRead("info.dat", "shop", "包裹满装箱", "")
$guiboxqty = IniRead("info.dat", "shop", "少于格数开始装箱", "")
$guinamelenfr = IniRead("info.dat", "shop", "房间名长度下限", "")
$guinamelento = IniRead("info.dat", "shop", "房间名长度上限", "")
$guisettime = IniRead("info.dat", "shop", "是否定时关机", "")
$guitimedata = IniRead("info.dat", "shop", "定时关机时间", "")
$guiothercheck = IniRead("info.dat", "shop", "检查其他人进入", "")
$guistaymin = IniRead("info.dat", "shop", "房间内最大分钟数", "")
GUICtrlSetData($n1, $usr)
GUICtrlSetData($n2, $psd)
GUICtrlSetData($path1, $d2path1)
GUICtrlSetData($path2, $d2path2)
GUICtrlSetData($boxQty, $guiboxqty)
GUICtrlSetData($namelenfr, $guinamelenfr)
GUICtrlSetData($namelento, $guinamelento)
GUICtrlSetData($dtshut, $guitimedata)
GUICtrlSetData($staymin, $guistaymin)
Select
Case $pos = 1
GUICtrlSetState($RadP1, $GUI_CHECKED)
Case $pos = 2
GUICtrlSetState($RadP2, $GUI_CHECKED)
Case $pos = 3
GUICtrlSetState($RadP3, $GUI_CHECKED)
Case $pos = 4
GUICtrlSetState($RadP4, $GUI_CHECKED)
Case $pos = 5
GUICtrlSetState($RadP5, $GUI_CHECKED)
Case $pos = 6
GUICtrlSetState($RadP6, $GUI_CHECKED)
Case $pos = 7
GUICtrlSetState($RadP7, $GUI_CHECKED)
Case Else
GUICtrlSetState($RadP8, $GUI_CHECKED)
EndSelect
Select
Case $nameCat = 1
GUICtrlSetState($RDnameAp, $GUI_CHECKED)
Case $nameCat = 2
GUICtrlSetState($RDnameMa, $GUI_CHECKED)
EndSelect
If $shutdown = 1 Then
GUICtrlSetState($ckbBagfull, $GUI_CHECKED)
Else
GUICtrlSetState($ckbBagfull, $GUI_UNCHECKED)
EndIf
If $guiboxing = 1 Then
GUICtrlSetState($ckbBoxing, $GUI_CHECKED)
Else
GUICtrlSetState($ckbBoxing, $GUI_UNCHECKED)
EndIf
If $guisettime = 1 Then
GUICtrlSetState($ckbTimeshut, $GUI_CHECKED)
Else
GUICtrlSetState($ckbTimeshut, $GUI_UNCHECKED)
EndIf
If $guiothercheck = 1 Then
GUICtrlSetState($ckbother, $GUI_CHECKED)
Else
GUICtrlSetState($ckbother, $GUI_UNCHECKED)
EndIf
EndFunc
Func Readdate()
Local $txt, $temp
$temp = FileOpen($Files, 0)
$txt = FileRead($temp)
FileClose($temp)
Return $txt
EndFunc
Func Setdate()
Local $txt, $temp
$temp = FileOpen($Files, 2)
$txt = GUICtrlRead($edtLog)
FileDelete($temp)
FileClose($temp)
GUICtrlSetData($edtLog, Readdate())
EndFunc
Global $_MD5Opcode = '0xC85800005356576A006A006A008D45A850E8280000006A00FF750CFF75088D45A850E8440000006A006A008D45A850FF7510E8710700005F5E5BC9C210005589E58B4D0831C0894114894110C70101234567C7410489ABCDEFC74108FEDCBA98C7410C765432105DC21000C80C0000538B5D088B4310C1E80383E03F8945F88B4510C1E0030143103943107303FF43148B4510C1E81D0143146A40582B45F88945F4394510724550FF750C8B45F88D44031850E8A00700008D43185053E84E0000008B45F48945FC8B45FC83C03F39451076138B450C0345FC5053E8300000008345FC40EBE28365F800EB048365FC008B45102B45FC508B450C0345FC508B45F88D44031850E84D0700005BC9C21000C84000005356576A40FF750C8D45C050E8330700008B45088B088B50048B70088B780C89D021F089D3F7D321FB09D801C1034DC081C178A46AD7C1C10701D189C821D089CBF7D321F309D801C7037DC481C756B7C7E8C1C70C01CF89F821C889FBF7D321D309D801C60375C881C6DB702024C1C61101FE89F021F889F3F7D321CB09D801C20355CC81C2EECEBDC1C1C21601F289D021F089D3F7D321FB09D801C1034DD081C1AF0F7CF5C1C10701D189C821D089CBF7D321F309D801C7037DD481C72AC68747C1C70C01CF89F821C889FBF7D321D309D801C60375D881C6134630A8C1C61101FE89F021F889F3F7D321CB09D801C20355DC81C2019546FDC1C21601F289D021F089D3F7D321FB09D801C1034DE081C1D8988069C1C10701D189C821D089CBF7D321F309D801C7037DE481C7AFF7448BC1C70C01CF89F821C889FBF7D321D309D801C60375E881C6B15BFFFFC1C61101FE89F021F889F3F7D321CB09D801C20355EC81C2BED75C89C1C21601F289D021F089D3F7D321FB09D801C1034DF081C12211906BC1C10701D189C821D089CBF7D321F309D801C7037DF481C7937198FDC1C70C01CF89F821C889FBF7D321D309D801C60375F881C68E4379A6C1C61101FE89F021F889F3F7D321CB09D801C20355FC81C22108B449C1C21601F289D021F889FBF7D321F309D801C1034DC481C162251EF6C1C10501D189C821F089F3F7D321D309D801C7037DD881C740B340C0C1C70901CF89F821D089D3F7D321CB09D801C60375EC81C6515A5E26C1C60E01FE89F021C889CBF7D321FB09D801C20355C081C2AAC7B6E9C1C21401F289D021F889FBF7D321F309D801C1034DD481C15D102FD6C1C10501D189C821F089F3F7D321D309D801C7037DE881C753144402C1C70901CF89F821D089D3F7D321CB09D801C60375FC81C681E6A1D8C1C60E01FE89F021C889CBF7D321FB09D801C20355D081C2C8FBD3E7C1C21401F289D021F889FBF7D321F309D801C1034DE481C1E6CDE121C1C10501D189C821F089F3F7D321D309D801C7037D'
$_MD5Opcode &= 'F881C7D60737C3C1C70901CF89F821D089D3F7D321CB09D801C60375CC81C6870DD5F4C1C60E01FE89F021C889CBF7D321FB09D801C20355E081C2ED145A45C1C21401F289D021F889FBF7D321F309D801C1034DF481C105E9E3A9C1C10501D189C821F089F3F7D321D309D801C7037DC881C7F8A3EFFCC1C70901CF89F821D089D3F7D321CB09D801C60375DC81C6D9026F67C1C60E01FE89F021C889CBF7D321FB09D801C20355F081C28A4C2A8DC1C21401F289D031F031F801C1034DD481C14239FAFFC1C10401D189C831D031F001C7037DE081C781F67187C1C70B01CF89F831C831D001C60375EC81C622619D6DC1C61001FE89F031F831C801C20355F881C20C38E5FDC1C21701F289D031F031F801C1034DC481C144EABEA4C1C10401D189C831D031F001C7037DD081C7A9CFDE4BC1C70B01CF89F831C831D001C60375DC81C6604BBBF6C1C61001FE89F031F831C801C20355E881C270BCBFBEC1C21701F289D031F031F801C1034DF481C1C67E9B28C1C10401D189C831D031F001C7037DC081C7FA27A1EAC1C70B01CF89F831C831D001C60375CC81C68530EFD4C1C61001FE89F031F831C801C20355D881C2051D8804C1C21701F289D031F031F801C1034DE481C139D0D4D9C1C10401D189C831D031F001C7037DF081C7E599DBE6C1C70B01CF89F831C831D001C60375FC81C6F87CA21FC1C61001FE89F031F831C801C20355C881C26556ACC4C1C21701F289F8F7D009D031F001C1034DC081C1442229F4C1C10601D189F0F7D009C831D001C7037DDC81C797FF2A43C1C70A01CF89D0F7D009F831C801C60375F881C6A72394ABC1C60F01FE89C8F7D009F031F801C20355D481C239A093FCC1C21501F289F8F7D009D031F001C1034DF081C1C3595B65C1C10601D189F0F7D009C831D001C7037DCC81C792CC0C8FC1C70A01CF89D0F7D009F831C801C60375E881C67DF4EFFFC1C60F01FE89C8F7D009F031F801C20355C481C2D15D8485C1C21501F289F8F7D009D031F001C1034DE081C14F7EA86FC1C10601D189F0F7D009C831D001C7037DFC81C7E0E62CFEC1C70A01CF89D0F7D009F831C801C60375D881C6144301A3C1C60F01FE89C8F7D009F031F801C20355F481C2A111084EC1C21501F289F8F7D009D031F001C1034DD081C1827E53F7C1C10601D189F0F7D009C831D001C7037DEC81C735F23ABDC1C70A01CF89D0F7D009F831C801C60375C881C6BBD2D72AC1C60F01FE89C8F7D009F031F801C20355E481C291D386EBC1C21501F28B4508010801500401700801780C5F5E5BC9C20800C814000053E840000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008F45EC8B5D0C6A088D4310508D'
$_MD5Opcode &= '45F850E8510000008B4310C1E80383E03F8945F483F838730B6A38582B45F48945F0EB096A78582B45F48945F0FF75F0FF75ECFF750CE831F8FFFF6A088D45F850FF750CE823F8FFFF6A1053FF7508E8050000005BC9C210005589E55156578B7D088B750C8B4D10FCF3A45F5E595DC20C00'
Global $_MD5CodeBuffer='',$_SHA1CodeBuffer='',$CodeBuffer
If @AutoItX64 Then
MsgBox(32,"ACN_HASH","此加密函数不能用于64位AutoIt版本,请编译为32位版本.",5)
Exit
EndIf
Func _MD5($Data)
Local $CodeBuffer = DllStructCreate("byte[" & BinaryLen($_MD5Opcode) & "]")
DllStructSetData($CodeBuffer, 1, $_MD5Opcode)
Local $Input = DllStructCreate("byte[" & BinaryLen($Data) & "]")
DllStructSetData($Input, 1, $Data)
Local $Digest = DllStructCreate("byte[16]")
DllCall("user32.dll", "none", "CallWindowProc", "ptr", DllStructGetPtr($CodeBuffer), _
"ptr", DllStructGetPtr($Input), _
"int", BinaryLen($Data), _
"ptr", DllStructGetPtr($Digest), _
"int", 0)
Local $Ret = DllStructGetData($Digest, 1)
$Input = 0
$Digest = 0
$CodeBuffer = 0
Return $Ret
EndFunc
Global $Cdkey, $cpuid, $hdKey ,$Iname ,$Ihdkey ,$Iregkey
$RegPW1 = "QQ_1246035036"
$RegPW2 = "WWW.MICROSOFT.COM"
$KeyPw = "cnishop@126.comanya"
$RegGUI = GUICreate(" 暗黑KP精灵程序注册", 283, 157, @DesktopWidth / 2 - 150, @DesktopHeight / 2 - 150)
$Title = GUICtrlCreateLabel("程序注册", 120, 4, 130, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
$User = GUICtrlCreateLabel("用户名", 8, 28, 40, 17)
$RegUser = GUICtrlCreateInput("D2shop", 55, 25, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 15)
GUICtrlSetBkColor(-1, 0xECE9D8)
$MacKey = GUICtrlCreateLabel("机器码", 8, 58, 40, 17)
$hdKey = GUICtrlCreateInput(_HDkey(), 55, 55, 217, 21, BitOR($ES_CENTER, $ES_READONLY, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 32)
GUICtrlSetBkColor(-1, 0xECE9D8)
$RegSn = GUICtrlCreateLabel("注册码", 8, 88, 40, 17)
$RegKey = GUICtrlCreateInput("", 55, 85, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 32)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0xECE9D8)
$BtnOK = GUICtrlCreateButton(" 注 册 ", 104, 120, 75, 25)
Func gui()
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
Exit
Case $BtnOK
If GUICtrlRead($RegUser) = "" Or GUICtrlRead($RegKey) = "" Then
MsgBox(0, "警告", "用户名和注册码都不能为空")
Else
If GUICtrlRead($RegKey) =  _CdKey() Then
IniWrite("D2shop.dat", "注册", "用户名 ", GUICtrlRead($RegUser))
IniWrite("D2shop.dat", "注册", "机器码 ",  _HDkey() )
IniWrite("D2shop.dat", "注册", "注册码 ", GUICtrlRead($RegKey) )
MsgBox(48, "提示", "注册成功，请关闭后重新打开！" )
Else
MsgBox(48, "警告", "注册失败" & @CR & "用户名或注册码错误!" )
EndIf
EndIf
EndSwitch
WEnd
EndFunc
Func _Cpuid()
$objWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
$colCPU = $objWMIService.ExecQuery("Select * from Win32_Processor")
For $object In $colCPU
$cpuid = StringStripWS($object.ProcessorId, 1)
Return $cpuid
Next
EndFunc
Func _HDkey()
_Cpuid()
$hdKey = StringMid(_MD5(StringMid(_MD5($cpuid & $RegPW1), 3, 34) & $RegPW2), 3, 34)
Return $hdKey
EndFunc
Func _CdKey()
_HDkey()
$Cdkey = StringMid(_MD5($hdKey & GUICtrlRead($RegUser) & $KeyPw), 3, 34)
Return $Cdkey
EndFunc
Func _IniVer()
$Iregkey = IniRead("D2shop.dat", "注册", "注册码", "")
If $Iregkey = _CdKey() Then
Return True
Else
GUISetState(@SW_SHOW)
Return False
EndIf
EndFunc
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
$Title = ""
$char_Q = "Q"
$char_TAB = "TAB"
$char_Wave = "~"
$char_ESC = "ESC"
$char_Vigor = "F3"
$char_Bh = "F1"
$char_normal_attack = "F2"
$char_Conc = "F4"
$char_Shield = "F5"
$char_Shift_Down = "LSHIFT down"
$char_Shift_Up = "LSHIFT up"
$char_Alt_Down = "ALT down"
$char_Alt_Up = "ALT up"
$itemcolor = "0x00FC18"
$drinkhealok = 0
$drinkmanaok = 0
$int_beltRej = 0
Global $xbeltarray[4][2]
Global $ybeltarray[4][2]
$xbeltarray[0][0] = 420
$xbeltarray[0][1] = 450
$xbeltarray[1][0] = 455
$xbeltarray[1][1] = 480
$xbeltarray[2][0] = 485
$xbeltarray[2][1] = 510
$xbeltarray[3][0] = 515
$xbeltarray[3][1] = 540
$ybeltarray[0][0] = 465
$ybeltarray[0][1] = 470
$ybeltarray[1][0] = 505
$ybeltarray[1][1] = 525
$ybeltarray[2][0] = 535
$ybeltarray[2][1] = 560
$ybeltarray[3][0] = 565
$ybeltarray[3][1] = 590
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
Func findPointColor($x, $y, $color)
$var = PixelGetColor($x, $y)
If Hex($var, 6) = $color Then
Return True
Else
Return False
EndIf
EndFunc
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
Func tiemtoshut($date)
$nowSec = _DateDiff('n', "2011/01/01 00:00:00", _NowCalc())
$setSec = _DateDiff('n', "2011/01/01 00:00:00", $date)
If $setSec >= $nowSec - 2 And $setSec <= $nowSec + 2 Then
TrayTip("", "执行定时关机..", 1, 16)
Sleep(1000)
Shutdown(1)
Sleep(1000)
EndIf
EndFunc
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
Global $titlefiremethord
Local $sanctury
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseClickDelay", 1)
Local $notfixbox
Global $bagEmptyCount
Global $boxisfull = 0
Local $bagfullCount
Local $xArray[10][2]
Local $yArray[4][2]
Local $emptyArray[4][10]
Local $avvArray[4][10]
Local $cmpArray[4][10]
Local $firstcmpArray[4][10]
Local $lastcmpArray[4][10]
Local $itemSizeArray[2][8]
Local $xlength
Local $ylength
Local $firstCount
Local $lastCount
Local $itemSize
Local $itembaglocation[1][2]
Local $itembaglocationxy[1][2]
Local $itembagCheck[4][10]
Local $findsame
Global $boxEmptyCount
Local $boxfullCount
Local $xBoxArray[6][2]
Local $yBoxArray[8][2]
Local $emptyBoxArray[8][6]
Local $avvBoxArray[8][6]
Local $cmpBoxArray[11][7]
$xArray[0][0] = 425
$xArray[0][1] = 440
$xArray[1][0] = 450
$xArray[1][1] = 470
$xArray[2][0] = 480
$xArray[2][1] = 500
$xArray[3][0] = 510
$xArray[3][1] = 530
$xArray[4][0] = 540
$xArray[4][1] = 560
$xArray[5][0] = 570
$xArray[5][1] = 590
$xArray[6][0] = 600
$xArray[6][1] = 615
$xArray[7][0] = 630
$xArray[7][1] = 645
$xArray[8][0] = 660
$xArray[8][1] = 675
$xArray[9][0] = 685
$xArray[9][1] = 700
$yArray[0][0] = 320
$yArray[0][1] = 340
$yArray[1][0] = 350
$yArray[1][1] = 370
$yArray[2][0] = 380
$yArray[2][1] = 400
$yArray[3][0] = 410
$yArray[3][1] = 430
$xBoxArray[0][0] = 160
$xBoxArray[0][1] = 175
$xBoxArray[1][0] = 190
$xBoxArray[1][1] = 205
$xBoxArray[2][0] = 220
$xBoxArray[2][1] = 235
$xBoxArray[3][0] = 245
$xBoxArray[3][1] = 260
$xBoxArray[4][0] = 275
$xBoxArray[4][1] = 290
$xBoxArray[5][0] = 305
$xBoxArray[5][1] = 320
$yBoxArray[0][0] = 150
$yBoxArray[0][1] = 165
$yBoxArray[1][0] = 180
$yBoxArray[1][1] = 195
$yBoxArray[2][0] = 201
$yBoxArray[2][1] = 225
$yBoxArray[3][0] = 235
$yBoxArray[3][1] = 255
$yBoxArray[4][0] = 265
$yBoxArray[4][1] = 285
$yBoxArray[5][0] = 295
$yBoxArray[5][1] = 310
$yBoxArray[6][0] = 325
$yBoxArray[6][1] = 340
$yBoxArray[7][0] = 350
$yBoxArray[7][1] = 370
$emptyArray[0][0] = 2128286505
$emptyArray[0][1] = 680075913
$emptyArray[0][2] = 3532990065
$emptyArray[0][3] = 1702763733
$emptyArray[0][4] = 2781226753
$emptyArray[0][5] = 1869491841
$emptyArray[0][6] = 33630009
$emptyArray[0][7] = 2257654813
$emptyArray[0][8] = 3402240693
$emptyArray[0][9] = 3651934153
$emptyArray[1][0] = 1643131837
$emptyArray[1][1] = 4023004801
$emptyArray[1][2] = 1210726313
$emptyArray[1][3] = 1402155425
$emptyArray[1][4] = 3324257933
$emptyArray[1][5] = 1178673873
$emptyArray[1][6] = 1418138221
$emptyArray[1][7] = 3123713197
$emptyArray[1][8] = 4239462497
$emptyArray[1][9] = 262213569
$emptyArray[2][0] = 2849382445
$emptyArray[2][1] = 1649753657
$emptyArray[2][2] = 4055383265
$emptyArray[2][3] = 2840607369
$emptyArray[2][4] = 3396610741
$emptyArray[2][5] = 477177009
$emptyArray[2][6] = 1108484605
$emptyArray[2][7] = 3728482849
$emptyArray[2][8] = 3546356257
$emptyArray[2][9] = 786963093
$emptyArray[3][0] = 4170659101
$emptyArray[3][1] = 2377405565
$emptyArray[3][2] = 751582593
$emptyArray[3][3] = 1710831477
$emptyArray[3][4] = 1604531761
$emptyArray[3][5] = 1116753093
$emptyArray[3][6] = 1294093305
$emptyArray[3][7] = 3129229389
$emptyArray[3][8] = 1964844249
$emptyArray[3][9] = 3822594909
$emptyBoxArray[0][0] = 1382815065
$emptyBoxArray[0][1] = 3962638745
$emptyBoxArray[0][2] = 1280449305
$emptyBoxArray[0][3] = 3908117325
$emptyBoxArray[0][4] = 2494637393
$emptyBoxArray[0][5] = 522915957
$emptyBoxArray[1][0] = 2795513849
$emptyBoxArray[1][1] = 3151307501
$emptyBoxArray[1][2] = 3726776777
$emptyBoxArray[1][3] = 2906200325
$emptyBoxArray[1][4] = 2614496557
$emptyBoxArray[1][5] = 95424209
$emptyBoxArray[2][0] = 3740614401
$emptyBoxArray[2][1] = 1131756889
$emptyBoxArray[2][2] = 278407701
$emptyBoxArray[2][3] = 1658859977
$emptyBoxArray[2][4] = 1727147645
$emptyBoxArray[2][5] = 1785409549
$emptyBoxArray[3][0] = 303766333
$emptyBoxArray[3][1] = 3619035461
$emptyBoxArray[3][2] = 2246645857
$emptyBoxArray[3][3] = 3857263269
$emptyBoxArray[3][4] = 44512509
$emptyBoxArray[3][5] = 1337076465
$emptyBoxArray[4][0] = 4237958009
$emptyBoxArray[4][1] = 785913177
$emptyBoxArray[4][2] = 3493863141
$emptyBoxArray[4][3] = 2436638561
$emptyBoxArray[4][4] = 3162909017
$emptyBoxArray[4][5] = 1680282749
$emptyBoxArray[5][0] = 68691921
$emptyBoxArray[5][1] = 1997611757
$emptyBoxArray[5][2] = 3033143753
$emptyBoxArray[5][3] = 1685657849
$emptyBoxArray[5][4] = 2555514157
$emptyBoxArray[5][5] = 4247850705
$emptyBoxArray[6][0] = 2732531493
$emptyBoxArray[6][1] = 2595823065
$emptyBoxArray[6][2] = 2167345197
$emptyBoxArray[6][3] = 3694859197
$emptyBoxArray[6][4] = 2915963641
$emptyBoxArray[6][5] = 1794380505
$emptyBoxArray[7][0] = 1249123073
$emptyBoxArray[7][1] = 2771523237
$emptyBoxArray[7][2] = 1517623357
$emptyBoxArray[7][3] = 4150142981
$emptyBoxArray[7][4] = 980169437
$emptyBoxArray[7][5] = 4262669041
Func InitialBagCheck()
For $j = 0 To 3 Step 1
For $i = 0 To 9 Step 1
$itembagCheck[$j][$i] = 1
Next
Next
EndFunc
Func movebagtoBox()
$boxisfull = 0
For $i = 1 To 40 Step 1
MouseMove(380, 300)
TrayTip("", "检查包裹里面的物品", 1, 16)
$firstCount = getbagLocation()
If $firstCount = 40 Then
TrayTip("", "背包已经空了。", 1, 16)
Sleep(100)
Send("{ESC}")
ExitLoop
EndIf
$firstcmpArray = $cmpArray
getItemSize()
$lastcmpArray = $cmpArray
writeitemSize()
getboxLocation()
moveboxItem($i)
If $boxEmptyCount <= 0 Then
$boxisfull = 1
If $i = 1 And $firstCount <= 6 Then
TrayTip("", "包裹和箱子都差不多满了：", 1, 16)
Sleep(1000)
EndIf
TrayTip("", "箱子装不下了", 1, 16)
Sleep(1000)
Send("{ESC}")
Sleep(200)
ExitLoop
EndIf
Next
EndFunc
Func bagfullcompare()
$avvArray[0][0] = PixelChecksum($xArray[0][0], $yArray[0][0], $xArray[0][1], $yArray[0][1], $Title)
$avvArray[0][1] = PixelChecksum($xArray[1][0], $yArray[0][0], $xArray[1][1], $yArray[0][1], $Title)
$avvArray[0][2] = PixelChecksum($xArray[2][0], $yArray[0][0], $xArray[2][1], $yArray[0][1], $Title)
$avvArray[0][3] = PixelChecksum($xArray[3][0], $yArray[0][0], $xArray[3][1], $yArray[0][1], $Title)
$avvArray[0][4] = PixelChecksum($xArray[4][0], $yArray[0][0], $xArray[4][1], $yArray[0][1], $Title)
$avvArray[0][5] = PixelChecksum($xArray[5][0], $yArray[0][0], $xArray[5][1], $yArray[0][1], $Title)
$avvArray[0][6] = PixelChecksum($xArray[6][0], $yArray[0][0], $xArray[6][1], $yArray[0][1], $Title)
$avvArray[0][7] = PixelChecksum($xArray[7][0], $yArray[0][0], $xArray[7][1], $yArray[0][1], $Title)
$avvArray[0][8] = PixelChecksum($xArray[8][0], $yArray[0][0], $xArray[8][1], $yArray[0][1], $Title)
$avvArray[0][9] = PixelChecksum($xArray[9][0], $yArray[0][0], $xArray[9][1], $yArray[0][1], $Title)
$avvArray[1][0] = PixelChecksum($xArray[0][0], $yArray[1][0], $xArray[0][1], $yArray[1][1], $Title)
$avvArray[1][1] = PixelChecksum($xArray[1][0], $yArray[1][0], $xArray[1][1], $yArray[1][1], $Title)
$avvArray[1][2] = PixelChecksum($xArray[2][0], $yArray[1][0], $xArray[2][1], $yArray[1][1], $Title)
$avvArray[1][3] = PixelChecksum($xArray[3][0], $yArray[1][0], $xArray[3][1], $yArray[1][1], $Title)
$avvArray[1][4] = PixelChecksum($xArray[4][0], $yArray[1][0], $xArray[4][1], $yArray[1][1], $Title)
$avvArray[1][5] = PixelChecksum($xArray[5][0], $yArray[1][0], $xArray[5][1], $yArray[1][1], $Title)
$avvArray[1][6] = PixelChecksum($xArray[6][0], $yArray[1][0], $xArray[6][1], $yArray[1][1], $Title)
$avvArray[1][7] = PixelChecksum($xArray[7][0], $yArray[1][0], $xArray[7][1], $yArray[1][1], $Title)
$avvArray[1][8] = PixelChecksum($xArray[8][0], $yArray[1][0], $xArray[8][1], $yArray[1][1], $Title)
$avvArray[1][9] = PixelChecksum($xArray[9][0], $yArray[1][0], $xArray[9][1], $yArray[1][1], $Title)
$avvArray[2][0] = PixelChecksum($xArray[0][0], $yArray[2][0], $xArray[0][1], $yArray[2][1], $Title)
$avvArray[2][1] = PixelChecksum($xArray[1][0], $yArray[2][0], $xArray[1][1], $yArray[2][1], $Title)
$avvArray[2][2] = PixelChecksum($xArray[2][0], $yArray[2][0], $xArray[2][1], $yArray[2][1], $Title)
$avvArray[2][3] = PixelChecksum($xArray[3][0], $yArray[2][0], $xArray[3][1], $yArray[2][1], $Title)
$avvArray[2][4] = PixelChecksum($xArray[4][0], $yArray[2][0], $xArray[4][1], $yArray[2][1], $Title)
$avvArray[2][5] = PixelChecksum($xArray[5][0], $yArray[2][0], $xArray[5][1], $yArray[2][1], $Title)
$avvArray[2][6] = PixelChecksum($xArray[6][0], $yArray[2][0], $xArray[6][1], $yArray[2][1], $Title)
$avvArray[2][7] = PixelChecksum($xArray[7][0], $yArray[2][0], $xArray[7][1], $yArray[2][1], $Title)
$avvArray[2][8] = PixelChecksum($xArray[8][0], $yArray[2][0], $xArray[8][1], $yArray[2][1], $Title)
$avvArray[2][9] = PixelChecksum($xArray[9][0], $yArray[2][0], $xArray[9][1], $yArray[2][1], $Title)
$avvArray[3][0] = PixelChecksum($xArray[0][0], $yArray[3][0], $xArray[0][1], $yArray[3][1], $Title)
$avvArray[3][1] = PixelChecksum($xArray[1][0], $yArray[3][0], $xArray[1][1], $yArray[3][1], $Title)
$avvArray[3][2] = PixelChecksum($xArray[2][0], $yArray[3][0], $xArray[2][1], $yArray[3][1], $Title)
$avvArray[3][3] = PixelChecksum($xArray[3][0], $yArray[3][0], $xArray[3][1], $yArray[3][1], $Title)
$avvArray[3][4] = PixelChecksum($xArray[4][0], $yArray[3][0], $xArray[4][1], $yArray[3][1], $Title)
$avvArray[3][5] = PixelChecksum($xArray[5][0], $yArray[3][0], $xArray[5][1], $yArray[3][1], $Title)
$avvArray[3][6] = PixelChecksum($xArray[6][0], $yArray[3][0], $xArray[6][1], $yArray[3][1], $Title)
$avvArray[3][7] = PixelChecksum($xArray[7][0], $yArray[3][0], $xArray[7][1], $yArray[3][1], $Title)
$avvArray[3][8] = PixelChecksum($xArray[8][0], $yArray[3][0], $xArray[8][1], $yArray[3][1], $Title)
$avvArray[3][9] = PixelChecksum($xArray[9][0], $yArray[3][0], $xArray[9][1], $yArray[3][1], $Title)
EndFunc
Func boxfullcompare()
$avvBoxArray[0][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[0][0], $xBoxArray[0][1], $yBoxArray[0][1], $Title)
$avvBoxArray[0][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[0][0], $xBoxArray[1][1], $yBoxArray[0][1], $Title)
$avvBoxArray[0][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[0][0], $xBoxArray[2][1], $yBoxArray[0][1], $Title)
$avvBoxArray[0][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[0][0], $xBoxArray[3][1], $yBoxArray[0][1], $Title)
$avvBoxArray[0][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[0][0], $xBoxArray[4][1], $yBoxArray[0][1], $Title)
$avvBoxArray[0][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[0][0], $xBoxArray[5][1], $yBoxArray[0][1], $Title)
$avvBoxArray[1][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[1][0], $xBoxArray[0][1], $yBoxArray[1][1], $Title)
$avvBoxArray[1][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[1][0], $xBoxArray[1][1], $yBoxArray[1][1], $Title)
$avvBoxArray[1][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[1][0], $xBoxArray[2][1], $yBoxArray[1][1], $Title)
$avvBoxArray[1][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[1][0], $xBoxArray[3][1], $yBoxArray[1][1], $Title)
$avvBoxArray[1][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[1][0], $xBoxArray[4][1], $yBoxArray[1][1], $Title)
$avvBoxArray[1][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[1][0], $xBoxArray[5][1], $yBoxArray[1][1], $Title)
$avvBoxArray[2][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[2][0], $xBoxArray[0][1], $yBoxArray[2][1], $Title)
$avvBoxArray[2][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[2][0], $xBoxArray[1][1], $yBoxArray[2][1], $Title)
$avvBoxArray[2][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[2][0], $xBoxArray[2][1], $yBoxArray[2][1], $Title)
$avvBoxArray[2][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[2][0], $xBoxArray[3][1], $yBoxArray[2][1], $Title)
$avvBoxArray[2][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[2][0], $xBoxArray[4][1], $yBoxArray[2][1], $Title)
$avvBoxArray[2][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[2][0], $xBoxArray[5][1], $yBoxArray[2][1], $Title)
$avvBoxArray[3][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[3][0], $xBoxArray[0][1], $yBoxArray[3][1], $Title)
$avvBoxArray[3][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[3][0], $xBoxArray[1][1], $yBoxArray[3][1], $Title)
$avvBoxArray[3][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[3][0], $xBoxArray[2][1], $yBoxArray[3][1], $Title)
$avvBoxArray[3][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[3][0], $xBoxArray[3][1], $yBoxArray[3][1], $Title)
$avvBoxArray[3][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[3][0], $xBoxArray[4][1], $yBoxArray[3][1], $Title)
$avvBoxArray[3][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[3][0], $xBoxArray[5][1], $yBoxArray[3][1], $Title)
$avvBoxArray[4][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[4][0], $xBoxArray[0][1], $yBoxArray[4][1], $Title)
$avvBoxArray[4][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[4][0], $xBoxArray[1][1], $yBoxArray[4][1], $Title)
$avvBoxArray[4][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[4][0], $xBoxArray[2][1], $yBoxArray[4][1], $Title)
$avvBoxArray[4][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[4][0], $xBoxArray[3][1], $yBoxArray[4][1], $Title)
$avvBoxArray[4][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[4][0], $xBoxArray[4][1], $yBoxArray[4][1], $Title)
$avvBoxArray[4][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[4][0], $xBoxArray[5][1], $yBoxArray[4][1], $Title)
$avvBoxArray[5][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[5][0], $xBoxArray[0][1], $yBoxArray[5][1], $Title)
$avvBoxArray[5][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[5][0], $xBoxArray[1][1], $yBoxArray[5][1], $Title)
$avvBoxArray[5][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[5][0], $xBoxArray[2][1], $yBoxArray[5][1], $Title)
$avvBoxArray[5][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[5][0], $xBoxArray[3][1], $yBoxArray[5][1], $Title)
$avvBoxArray[5][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[5][0], $xBoxArray[4][1], $yBoxArray[5][1], $Title)
$avvBoxArray[5][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[5][0], $xBoxArray[5][1], $yBoxArray[5][1], $Title)
$avvBoxArray[6][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[6][0], $xBoxArray[0][1], $yBoxArray[6][1], $Title)
$avvBoxArray[6][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[6][0], $xBoxArray[1][1], $yBoxArray[6][1], $Title)
$avvBoxArray[6][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[6][0], $xBoxArray[2][1], $yBoxArray[6][1], $Title)
$avvBoxArray[6][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[6][0], $xBoxArray[3][1], $yBoxArray[6][1], $Title)
$avvBoxArray[6][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[6][0], $xBoxArray[4][1], $yBoxArray[6][1], $Title)
$avvBoxArray[6][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[6][0], $xBoxArray[5][1], $yBoxArray[6][1], $Title)
$avvBoxArray[7][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[7][0], $xBoxArray[0][1], $yBoxArray[7][1], $Title)
$avvBoxArray[7][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[7][0], $xBoxArray[1][1], $yBoxArray[7][1], $Title)
$avvBoxArray[7][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[7][0], $xBoxArray[2][1], $yBoxArray[7][1], $Title)
$avvBoxArray[7][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[7][0], $xBoxArray[3][1], $yBoxArray[7][1], $Title)
$avvBoxArray[7][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[7][0], $xBoxArray[4][1], $yBoxArray[7][1], $Title)
$avvBoxArray[7][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[7][0], $xBoxArray[5][1], $yBoxArray[7][1], $Title)
EndFunc
Func getbagLocation()
$bagfullCount = 0
$bagEmptyCount = 0
bagfullcompare()
For $j = 0 To 3 Step 1
For $i = 0 To 9 Step 1
$cmpArray[$j][$i] = ""
If $avvArray[$j][$i] <> $emptyArray[$j][$i] And $itembagCheck[$j][$i] = 1 Then
$cmpArray[$j][$i] = 1
$bagfullCount = $bagfullCount + 1
EndIf
Next
Next
$bagEmptyCount = 40 - $bagfullCount
TrayTip("", "背包剩余数量：" & $bagEmptyCount, 1, 16)
Sleep(10)
Return $bagEmptyCount
EndFunc
Func movebagItem()
TrayTip("", "移动物品检查", 1, 16)
For $j = 0 To 3 Step 1
For $i = 0 To 9 Step 1
If $cmpArray[$j][$i] = 1 Then
$itembaglocation[0][0] = $xArray[$i][0]
$itembaglocation[0][1] = $yArray[$j][0]
$itembaglocationxy[0][0] = $i
$itembaglocationxy[0][1] = $j
MouseClick("left", $xArray[$i][0], $yArray[$j][0], 1)
Sleep(30)
MouseMove(500, 200)
ExitLoop 2
EndIf
Next
Next
EndFunc
Func getItemSize()
movebagItem()
$lastCount = getbagLocation()
$itemSize = $lastCount - $firstCount
TrayTip("", "物品占用格数：" & $itemSize, 1, 16)
Sleep(10)
EndFunc
Func getboxLocation()
$boxfullCount = 0
$boxEmptyCount = 0
boxfullcompare()
For $j = 0 To 7 Step 1
For $i = 0 To 5 Step 1
$cmpBoxArray[$j][$i] = 0
If $avvBoxArray[$j][$i] <> $emptyBoxArray[$j][$i] Then
$cmpBoxArray[$j][$i] = 1
$boxfullCount = $boxfullCount + 1
EndIf
Next
Next
For $j = 0 To 7 Step 1
For $i = 6 To 6 Step 1
$cmpBoxArray[$j][$i] = 1
Next
Next
For $j = 8 To 10 Step 1
For $i = 0 To 6 Step 1
$cmpBoxArray[$j][$i] = 1
Next
Next
$boxEmptyCount = 48 - $boxfullCount
TrayTip("", "仓库剩余数量：" & $boxEmptyCount, 1, 16)
Sleep(10)
Return $boxEmptyCount
EndFunc
Func moveboxItem($count)
Dim $presize
TrayTip("", "准备移动到仓库", 1, 16)
Sleep(10)
$findsame = False
For $j = 0 To 7 Step 1
For $i = 0 To 5 Step 1
If $cmpBoxArray[$j][$i] = 0 Then
$presize = 0
For $x = 0 To $xlength - 1 Step 1
For $y = 0 To $ylength - 1 Step 1
If $cmpBoxArray[$j + $y][$i + $x] = 0 Then
$presize = $presize + 1
EndIf
Next
Next
TrayTip("", "仓库中合适的可用格数：" & $presize, 1, 16)
Sleep(10)
If $presize = $itemSize Then
MouseMove($xBoxArray[$i][0] +($xlength - 1) * 15, $yBoxArray[$j][0] +($ylength - 1) * 15)
Sleep(30)
MouseClick("left", Default, Default, 1)
Sleep(30)
$findsame = True
ExitLoop 2
Else
$findsame = False
EndIf
EndIf
Next
Next
If $findsame = False Then
MouseMove($itembaglocation[0][0] +($xlength - 1) * 15, $itembaglocation[0][1] +($ylength - 1) * 15)
Sleep(100)
MouseClick("left", Default, Default, 1)
Sleep(100)
TrayTip("", "大箱子放不下这东西了：", 1, 16)
For $xx = 0 To $xlength - 1 Step 1
For $yy = 0 To $ylength - 1 Step 1
$itembagCheck[$itembaglocationxy[0][1] + $yy][$itembaglocationxy[0][0] + $xx] = 0
Next
Next
EndIf
EndFunc
Func writeitemSize()
Dim $xbeg, $xmid, $ybeg, $ymid
$xbeg = -1
$ybeg = -1
$xmid = 0
$ymid = 0
For $j = 0 To 3 Step 1
For $i = 0 To 9 Step 1
If $firstcmpArray[$j][$i] <> $lastcmpArray[$j][$i] Then
If $xbeg < $i Then
$xmid = $xmid + 1
$xbeg = $i
EndIf
If $ybeg < $j Then
$ymid = $ymid + 1
$ybeg = $j
EndIf
EndIf
Next
Next
$xlength = $xmid
$ylength = $ymid
TrayTip("", "物品宽度：" & $xlength & " 物品高度：" & $ylength, 1, 16)
Sleep(10)
EndFunc
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
Func findpath($pathNumber)
TrayTip("", "走向红门。", 1, 16)
Sleep(100)
Send("{TAB}")
$xrd = Random(-2, 2, 1)
$yrd = Random(-2, 2, 1)
TrayTip("", "启用随机路径" & "坐标迷惑偏移" & $xrd & " " & $yrd, 1, 16)
Select
Case $pathNumber = 1
MouseClick("left", 310 + $xrd, 530 + $yrd, 1)
Sleep(1400)
MouseClick("left", 700, 460, 1)
Sleep(1100)
MouseClick("left", 110, 460, 1)
Sleep(1000)
MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
Sleep(1000)
MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 40 + $xrd, 280 + $yrd, 1)
Sleep(1000)
Case $pathNumber = 2
MouseClick("left", 60 + $xrd, 250 + $yrd, 1)
Sleep(1100)
MouseClick("left", 40 + $xrd, 250 + $yrd, 1)
Sleep(1100)
MouseClick("left", 180 + $xrd, 480 + $yrd, 1)
Sleep(1100)
MouseClick("left", 180, 480, 1)
Sleep(1100)
MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
Sleep(1100)
MouseClick("left", 220 + $xrd, 500 + $yrd, 1)
Sleep(1000)
MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
Sleep(800)
MouseClick("left", 700 + $xrd, 400 + $yrd, 1)
Sleep(1000)
Case $pathNumber = 3
MouseClick("left", 200 + $xrd, 500 + $yrd, 1)
Sleep(1400)
MouseClick("left", 750 + $xrd, 430 + $yrd, 1)
Sleep(1400)
MouseClick("left", 380 + $xrd, 480 + $yrd, 1)
Sleep(800)
MouseClick("left", 100 + $xrd, 350 + $yrd, 1)
Sleep(1000)
MouseClick("left", 130 + $xrd, 470 + $yrd, 1)
Sleep(1000)
MouseClick("left", 50 + $xrd, 430 + $yrd, 1)
Sleep(1000)
MouseClick("left", 65 + $xrd, 280 + $yrd, 1)
Sleep(800)
Case $pathNumber = 4
MouseClick("left", 60, 250, 1)
Sleep(1400)
MouseClick("left", 30 + $xrd, 250 + $yrd, 1)
Sleep(1600)
MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
Sleep(1300)
MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
Sleep(1300)
MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
Sleep(1300)
MouseClick("left", 210 + $xrd, 500 + $yrd, 1)
Sleep(1300)
MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
Sleep(1300)
MouseClick("left", 600 + $xrd, 400 + $yrd, 1)
Sleep(1400)
Case $pathNumber = 5
MouseClick("left", 290 + $xrd, 510 + $yrd, 1)
Sleep(1700)
MouseClick("left", 620 + $xrd, 340 + $yrd, 1)
Sleep(1300)
MouseClick("left", 500 + $xrd, 460 + $yrd, 1)
Sleep(1000)
MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 40 + $xrd, 280 + $yrd, 1)
Sleep(1100)
Case $pathNumber = 6
MouseClick("left", 190 + $xrd, 252 + $yrd, 1)
Sleep(800)
MouseClick("left", 140 + $xrd, 310 + $yrd, 1)
Sleep(800)
MouseClick("left", 185 + $xrd, 240 + $yrd, 1)
Sleep(1000)
MouseClick("left", 260 + $xrd, 490 + $yrd, 1)
Sleep(1100)
MouseClick("left", 100 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
Sleep(1200)
MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
Sleep(1200)
MouseClick("left", 400 + $xrd, 460 + $yrd, 1)
Sleep(1100)
MouseClick("left", 600 + $xrd, 350 + $yrd, 1)
Sleep(1100)
MouseClick("left", 700 + $xrd, 300 + $yrd, 1)
Sleep(1100)
Case $pathNumber = 7
Sleep(10)
MouseMove(120, 530)
MouseDown("left")
Sleep(1000)
MouseMove(200, 530)
Sleep(1500)
MouseMove(200, 530)
Sleep(1500)
MouseMove(50, 530)
Sleep(1000)
MouseUp("left")
MouseClick("left", 250, 300)
Sleep(1000)
Case $pathNumber = 8
MouseMove(200, 530)
MouseDown("left")
Sleep(1200)
MouseMove(600, 330)
Sleep(1200)
MouseMove(60, 460)
Sleep(3300)
MouseUp("left")
MouseClick("left", 60, 300)
Sleep(1000)
Case $pathNumber = 20
MouseClick("left", 200 + $xrd, 500 + $yrd, 1)
Sleep(1400)
MouseClick("left", 750 + $xrd, 430 + $yrd, 1)
Sleep(1400)
MouseClick("left", 380 + $xrd, 480 + $yrd, 1)
Sleep(800)
MouseClick("left", 100 + $xrd, 350 + $yrd, 1)
Sleep(1000)
MouseClick("left", 130 + $xrd, 470 + $yrd, 1)
Sleep(1000)
MouseClick("left", 50 + $xrd, 430 + $yrd, 1)
Sleep(1000)
MouseClick("left", 65 + $xrd, 280 + $yrd, 1)
Sleep(800)
Case Else
EndSelect
Return True
EndFunc
#IgnoreFunc __SQLite_Inline_Version, __SQLite_Inline_Modified
Func _FileWriteLog($sLogPath, $sLogMsg, $iFlag = -1)
Local $iOpenMode = $FO_APPEND
Local $sDateNow = @YEAR & "-" & @MON & "-" & @MDAY
Local $sTimeNow = @HOUR & ":" & @MIN & ":" & @SEC
Local $sMsg = $sDateNow & " " & $sTimeNow & " : " & $sLogMsg
If $iFlag <> -1 Then
$sMsg &= @CRLF & FileRead($sLogPath)
$iOpenMode = $FO_OVERWRITE
EndIf
Local $hOpenFile = FileOpen($sLogPath, $iOpenMode)
If $hOpenFile = -1 Then Return SetError(1, 0, 0)
Local $iWriteFile = FileWriteLine($hOpenFile, $sMsg)
Local $iRet = FileClose($hOpenFile)
If $iWriteFile = -1 Then Return SetError(2, $iRet, 0)
Return $iRet
EndFunc
Func _TempFile($s_DirectoryName = @TempDir, $s_FilePrefix = "~", $s_FileExtension = ".tmp", $i_RandomLength = 7)
If IsKeyword($s_FilePrefix) Then $s_FilePrefix = "~"
If IsKeyword($s_FileExtension) Then $s_FileExtension = ".tmp"
If IsKeyword($i_RandomLength) Then $i_RandomLength = 7
If Not FileExists($s_DirectoryName) Then $s_DirectoryName = @TempDir
If Not FileExists($s_DirectoryName) Then $s_DirectoryName = @ScriptDir
If StringRight($s_DirectoryName, 1) <> "\" Then $s_DirectoryName = $s_DirectoryName & "\"
Local $s_TempName
Do
$s_TempName = ""
While StringLen($s_TempName) < $i_RandomLength
$s_TempName = $s_TempName & Chr(Random(97, 122, 1))
WEnd
$s_TempName = $s_DirectoryName & $s_FilePrefix & $s_TempName & $s_FileExtension
Until Not FileExists($s_TempName)
Return $s_TempName
EndFunc
Global Const $SQLITE_OK = 0
Global Const $SQLITE_CORRUPT = 11
Global Const $SQLITE_MISMATCH = 20
Global $g_hDll_SQLite = 0
Global $g_bUTF8ErrorMsg_SQLite = False
Global $__ghMsvcrtDll_SQLite = 0
Global $__gaTempFiles_SQLite[1] = ['']
Func _SQLite_Startup($sDll_Filename = "", $bUTF8ErrorMsg = False, $bForceLocal = 0)
If IsKeyword($bUTF8ErrorMsg) Then $bUTF8ErrorMsg = False
$g_bUTF8ErrorMsg_SQLite = $bUTF8ErrorMsg
If IsKeyword($sDll_Filename) Or $bForceLocal Or $sDll_Filename = "" Or $sDll_Filename = -1 Then
Local $bDownloadDLL = True
Local $vInlineVersion = Call('__SQLite_Inline_Version')
If $bForceLocal Then
If @AutoItX64 And StringInStr($sDll_Filename, "_x64") Then $sDll_Filename = StringReplace($sDll_Filename, ".dll", "_x64.dll")
$bDownloadDLL =($bForceLocal<0)
Else
If @AutoItX64 = 0 Then
$sDll_Filename = "sqlite3.dll"
Else
$sDll_Filename = "sqlite3_x64.dll"
EndIf
If @error Then $bDownloadDLL = False
If __SQLite_VersCmp(@ScriptDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
$sDll_Filename = @ScriptDir & "\" & $sDll_Filename
$bDownloadDLL = False
ElseIf __SQLite_VersCmp(@SystemDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
$sDll_Filename = @SystemDir & "\" & $sDll_Filename
$bDownloadDLL = False
ElseIf __SQLite_VersCmp(@WindowsDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
$sDll_Filename = @WindowsDir & "\" & $sDll_Filename
$bDownloadDLL = False
ElseIf __SQLite_VersCmp(@WorkingDir & "\" & $sDll_Filename, $vInlineVersion) = $SQLITE_OK Then
$sDll_Filename = @WorkingDir & "\" & $sDll_Filename
$bDownloadDLL = False
EndIf
EndIf
If $bDownloadDLL Then
If FileExists($sDll_Filename) Or $sDll_Filename = "" Then
$sDll_Filename = _TempFile(@TempDir, "~", ".dll")
_ArrayAdd($__gaTempFiles_SQLite, $sDll_Filename)
OnAutoItExitRegister("_SQLite_Shutdown")
Else
$sDll_Filename = @SystemDir & "\" & $sDll_Filename
EndIf
If $bForceLocal Then
$vInlineVersion = ""
Else
$vInlineVersion = "_" & $vInlineVersion
EndIf
__SQLite_Download_SQLite3Dll($sDll_Filename, $vInlineVersion)
EndIf
EndIf
Local $hDll = DllOpen($sDll_Filename)
If $hDll = -1 Then
$g_hDll_SQLite = 0
Return SetError(1, 0, "")
Else
$g_hDll_SQLite = $hDll
Return $sDll_Filename
EndIf
EndFunc
Func _SQLite_Shutdown()
If $g_hDll_SQLite > 0 Then DllClose($g_hDll_SQLite)
$g_hDll_SQLite = 0
If $__ghMsvcrtDll_SQLite > 0 Then DllClose($__ghMsvcrtDll_SQLite)
$__ghMsvcrtDll_SQLite = 0
For $sTempFile In $__gaTempFiles_SQLite
If FileExists($sTempFile) Then FileDelete($sTempFile)
Next
OnAutoItExitUnRegister("_SQLite_Shutdown")
EndFunc
Func __SQLite_VersCmp($sFile, $sVersion)
Local $avRval = DllCall($sFile, "str:cdecl", "sqlite3_libversion")
If @error Then Return $SQLITE_CORRUPT
Local $szFileVersion = StringSplit($avRval[0], ".")
Local $MaintVersion = 0
If $szFileVersion[0] = 4 Then $MaintVersion = $szFileVersion[4]
$szFileVersion =(($szFileVersion[1]*1000 + $szFileVersion[2])*1000 + $szFileVersion[3])*100 + $MaintVersion
If $sVersion < 10000000 Then $sVersion = $sVersion * 100
If $szFileVersion >= $sVersion Then Return $SQLITE_OK
Return $SQLITE_MISMATCH
EndFunc
Func __SQLite_Download_SQLite3Dll($tempfile, $version)
Local $URL = "http://www.autoitscript.com/autoit3/files/beta/autoit/archive/sqlite/SQLite3" & $version
Local $Ret
If @AutoItX64 = 0 Then
$Ret = InetGet($URL & ".dll", $tempfile, 1)
Else
$Ret = InetGet($URL & "_x64.dll", $tempfile, 1)
EndIf
Local $error = @error
FileSetTime($tempfile, __SQLite_Inline_Modified(), 0)
Return SetError($error, 0, $Ret)
EndFunc
Func __SQLite_Inline_Modified()
Return "20100830083416"
EndFunc
Func __SQLite_Inline_Version()
Return "300700200"
EndFunc
Global $SQLite_Data_Path
Global $msg, $hQuery, $aRow
Global $temp, $a, $b, $c
Global $app_date,$app_kpcount
$SQLite_Data_Path = "a01.dll"
_SQLite_Startup()
If Not FileExists($SQLite_Data_Path) Then
MsgBox(0,"错误提示","丢失所需文件，请重新安装！")
Exit
EndIf
If Not FileExists("a02.df") Then
MsgBox(0,"错误提示","丢失所需文件，请重新安装！")
Exit
EndIf
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
Global $Paused
Local $ohterImage = 0
Local $emptybag
Local $checkbag = 1
Local $istrade = 0
Local $round = 0
$Title = "d2"
$titlefiremethord = $Title
Local $parm_boxing
Local $parm_boxqty
Local $parm_namelenfr, $parm_namelento
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime
Local $parm_ramevent, $parm_kprounctime, $parm_rantime
Local $tfcount = 0
Local $errCount = 0
Local $parm_firstdate, $parm_kpcount
Local $parm_othercheck, $parm_staymin
Local $acountArray[2]
$bindmac = 1
$bindacc = 0
$bindlimitCount = 0
$limitRound = 5
$bindTime = 0
$ranLimte = Random(-14, 14, 1)
If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
MsgBox(0, "提示", "未知错误，请检查")
Exit 0
EndIf
If $bindmac = 1 Then
If Not _IniVer() Then
gui()
EndIf
EndIf
creatGui()
$parm_boxing = $guiboxing
$parm_boxqty = $guiboxqty
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_drinkrej_plus = $guidrinkrej
$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime
$parm_othercheck = $guiothercheck
$parm_staymin = $guistaymin
HotKeySet("{F9}", "TogglePause")
HotKeySet("{F10}", "Terminate")
While 1
Sleep(100)
WEnd
Func TogglePause()
$Paused = Not $Paused
While $Paused
Sleep(100)
TrayTip("", "等待执行中..", 1, 16)
runGame()
WEnd
Sleep(10)
TrayTip("", "如果已在房间内,暂停30秒！", 9, 16)
Sleep(30000)
EndFunc
Func Terminate()
TrayTip("", "已退出程序！", 1, 16)
Sleep(1000)
Exit 0
EndFunc
Func runGame()
If $bindacc = 1 Then
$acountArray[0] = "iamhix"
$acountArray[1] = "iamhix"
If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
MsgBox(4096, " ...... 提示 ...... ", "与绑定的帐号不相符，请确认")
Exit 0
EndIf
EndIf
If $bindlimitCount = 1 Then
If $round >= $limitRound Then
writelog("达到循环限制次数")
MsgBox(4096, " ..... 温馨提示 .........", "已达循环限制次数,请休息下再挂机" & @CRLF & "或使用无限次版")
Exit 0
EndIf
EndIf
$parm_firstdate = $app_date
$parm_kpcount = $app_kpcount
Dim $optcount = 0
If $parm_settime = 1 Then
tiemtoshut($parm_timedata)
EndIf
activeWindow()
Select
Case isInRoom()
roomplay()
$optcount = $optcount + 1
Sleep(1000)
Case waitCreatRoom()
$optcount = $optcount + 1
TrayTip("", "准备进入游戏。。.", 1, 16)
Sleep(4000)
Case loginnotConnect()
$optcount = $optcount + 1
TrayTip("", "无法连接战网，重试中。。.", 1, 16)
Sleep(1000)
Case pwderror()
$optcount = $optcount + 1
TrayTip("", "密码错误，重试。。.", 1, 16)
Sleep(1000)
Case selectRole()
$optcount = $optcount + 1
TrayTip("", "检查是否需要创建房间.", 1, 16)
Sleep(2000)
Case waitInputUsr()
$optcount = $optcount + 1
TrayTip("", "检查是否选择角色界面.", 1, 16)
Sleep(2000)
Case waitLoginNet()
$optcount = $optcount + 1
TrayTip("", "检查是否需要输入用户名密码.", 1, 16)
Sleep(2000)
Case Else
TrayTip("", "等待中，请稍后", 1, 16)
Sleep(10)
EndSelect
If $optcount = 0 Then
$ohterImage = $ohterImage + 1
TrayTip("尝试合适的操作", $ohterImage, 1, 16)
If $ohterImage > 20 Then
TrayTip($ohterImage, "未找到的合适操作，重试中", 1, 16)
Sleep(100)
Send("{ESC}")
Sleep(100)
If $ohterImage > 22 Then
Sleep(100)
Send("{ENTER}")
Sleep(100)
EndIf
If $ohterImage > 25 Then
Sleep(100)
$PID = ProcessExists("D2loader.exe")
If $PID Then ProcessClose($PID)
$ohterImage = 0
Sleep(1000)
EndIf
EndIf
Else
$ohterImage = 0
EndIf
EndFunc
Func activeWindow()
$handle = WinGetHandle($Title)
If @error Then
TrayTip("", "没有找到游戏窗口，尝试启动中。", 1, 16)
Sleep(1000)
If Run($d2path1, $d2path2) = 0 Then
MsgBox(32, "错误", "请先设置好正确的路径")
Exit
Else
Sleep(3000)
$handle = WinGetHandle($Title)
WinActivate($Title)
Send("{ENTER}")
Sleep(100)
EndIf
Else
WinActivate($Title)
EndIf
$size = WinGetClientSize($Title)
If $size <> 0 Then
If $size[0] <> 800 And $size[1] <> 600 Then
MsgBox(0, "提示", "请先将窗口设置成800*600")
Exit 0
EndIf
Else
MsgBox(0, "提示", "没有找到游戏窗口.")
EndIf
WinMove($Title, "", 20, 20)
Sleep(50)
EndFunc
Func roomplay()
$roombegintime = _NowCalc()
$inRoomDateCalc = _DateDiff('n', $roombegintime, _NowCalc())
If $inRoomDateCalc >= $parm_staymin Then
exitRoom()
writelog("房间内时间---第 " & $round & " 局用时: " & $inRoomDateCalc & " 分退出")
EndIf
Select
Case $istrade = 0 And findleftdoor() = False And findrightdoor() = False
$errCount = $errCount + 1
TrayTip("", "无红门，没有找到anya次数 " & $errCount, 1, 16)
If $errCount >= 4 Then
$errCount = 0
exitRoom()
Return
EndIf
Sleep(500)
If $parm_boxing = 1 And bagisfull() Then
Return
EndIf
findpath(20)
Sleep(100)
If findleftdoor() = True Then
$istrade = 1
Else
Sleep(500)
exitRoom()
Sleep(500)
EndIf
Case $istrade = 0 And findleftdoor() = True And findanya() = False
TrayTip("", "左红门，有安亚", 1, 16)
clickleftdoor()
clickAnya()
Sleep(100)
clickTrade()
Sleep(100)
findanyaItem()
Sleep(100)
$round = $round + 1
$tfcount = $tfcount + 1
_GUICtrlStatusBar_SetText($StatusBar1, "shop次数: " & $round & "  累计shop次数： " & $parm_kpcount + 1, 1)
$parm_kpcount = $parm_kpcount + 1
Case $istrade = 0 And findrightdoor() = True And findanya() = True
TrayTip("", "右红门，有安亚", 1, 16)
clickAnya()
Sleep(50)
clickTrade()
Sleep(50)
findanyaItem()
Sleep(50)
$round = $round + 1
$tfcount = $tfcount + 1
_GUICtrlStatusBar_SetText($StatusBar1, "shop次数: " & $round & "  累计shop次数： " & $parm_kpcount + 1, 1)
$parm_kpcount = $parm_kpcount + 1
Case $istrade = 1 And findrightdoor() = True
TrayTip("", "右红门，已交易，去野外", 1, 16)
clickrightdoor()
If findleftdoor() = True Then
$istrade = 0
EndIf
Case $istrade = 1 And findleftdoor() = True
TrayTip("", "左红门，已交易，去野外", 1, 16)
clickleftdoor()
If findleftdoor() = True Then
$istrade = 0
EndIf
Sleep(10)
Case Else
TrayTip("", "其他异常", 1, 16)
Sleep(10)
EndSelect
EndFunc
Func isInRoom($color = 0xB08848)
If findPointColor(30, 585, "040404") = False Then
$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $Title)
If Not @error Then
Return True
Else
Return False
EndIf
Else
Return False
EndIf
EndFunc
Func waitLoginNet()
If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
MouseClick("left", 400, 350)
Return True
Else
Return False
EndIf
EndFunc
Func loginnotConnect()
If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
MouseClick("left", 360, 430)
Sleep(100)
Return True
Else
Return False
EndIf
EndFunc
Func waitInputUsr()
If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
MouseClick("left", 400, 340, 2)
Sleep(500)
ControlSend($Title, "", "", $usr)
Sleep(1000)
MouseClick("left", 400, 390, 2)
ControlSend($Title, "", "", $psd)
Sleep(1000)
Send("{ENTER}")
Return True
Else
Return False
EndIf
EndFunc
Func pwderror()
If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") Then
If findPointColor(360, 400, "646464") Then
Send("{ENTER}")
Sleep(500)
Return True
Else
Send("{ENTER}")
Sleep(500)
Return True
EndIf
Else
Return False
EndIf
EndFunc
Func selectRole()
If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
Select
Case $pos = 1
Case $pos = 2
Send("{DOWN}")
Case $pos = 3
Send("{DOWN 2}")
Case $pos = 4
Send("{DOWN 3}")
Case $pos = 5
Send("{RIGHT}")
Case $pos = 6
Send("{RIGHT}")
Send("{DOWN}")
Case $pos = 7
Send("{RIGHT}")
Send("{DOWN 2}")
Case $pos = 8
Send("{RIGHT}")
Send("{DOWN 3}")
EndSelect
Send("{ENTER}")
Return True
Else
Return False
EndIf
EndFunc
Func waitCreatRoom()
If findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") And findPointColor(180, 350, "040404") Then
Sleep(1000)
If findPointColor(385, 250, "040404") = False Then
Send("{ENTER}")
Sleep(500)
Return True
ElseIf findPointColor(445, 410, "786C60") = True Then
Send("{ENTER}")
Sleep(500)
Return True
Else
If isInRoom() = False Then
createRoom()
Return True
Else
Return False
EndIf
EndIf
Else
Return False
EndIf
EndFunc
Func createRoom()
MouseClick("left", 700, 455)
MouseClick("left", 600, 455)
MouseClick("left", 705, 378)
Sleep(1000)
If $nameCat = 1 Then
Dim $str = ""
Dim $roomcount = Random($parm_namelenfr, $parm_namelento, 1)
For $i = 1 To $roomcount
$str = $str & Chr(Random(97, 105, 1))
Next
ControlSend($Title, "", "", $str)
Else
ControlSend($Title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
EndIf
Sleep(500)
MouseClick("left", 680, 410, 1)
Sleep(50)
EndFunc
Func exitRoom()
Send("{ESC}")
MouseClick("left", 400, 250, 1)
EndFunc
Func findleftdoor()
TrayTip("", "寻找红门.", 1, 16)
$left = 200
$top = 200
$right = 400
$bottom = 300
$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "定位左边红门，第一次！.", 1, 16)
$x = $coord[0]
$y = $coord[1]
$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "定位左边红门，第二次！.", 1, 16)
$x = $coord[0] + 5
$y = $coord[1] + 5
Return True
Else
Return False
EndIf
Else
TrayTip("", "左边红门未找到！.", 1, 16)
Return False
EndIf
EndFunc
Func clickleftdoor()
TrayTip("", "寻找左边红门.", 1, 16)
$left = 200
$top = 200
$right = 400
$bottom = 300
$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "找到左边红门，进红门！.", 1, 16)
$x = $coord[0]
$y = $coord[1]
MouseClick("left", $x + 5, $y + 10, 1)
Sleep(2000)
MouseMove(400 + Random(1, 10), 300 + + Random(1, 10))
Sleep(5)
Else
TrayTip("", "进左边红门出错！.", 1, 16)
Sleep(500)
exitRoom()
Return False
EndIf
EndFunc
Func findrightdoor()
TrayTip("", "寻找右边红门.", 1, 16)
$left = 410
$top = 310
$right = 600
$bottom = 500
$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "定位右边红门，第一次！.", 1, 16)
$x = $coord[0]
$y = $coord[1]
$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "定位右边红门，第二次！.", 1, 16)
$x = $coord[0] + 5
$y = $coord[1] + 5
Return True
Else
Return False
EndIf
Else
TrayTip("", "右边红门未找到！.", 1, 16)
Sleep(50)
Return False
EndIf
EndFunc
Func clickrightdoor()
TrayTip("", "寻找右边红门.", 1, 16)
$left = 410
$top = 310
$right = 600
$bottom = 500
$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $Title)
If Not @error Then
TrayTip("", "进入右边红门！.", 1, 16)
$x = $coord[0]
$y = $coord[1]
MouseClick("left", $x + 5, $y + 10, 1)
Sleep(2000)
MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
Sleep(10)
Else
TrayTip("", "进右边红门出错！.", 1, 16)
Sleep(500)
exitRoom()
Return False
EndIf
EndFunc
Func bagisfull()
If isInRoom() = True And $checkbag = 1 Then
Send("{B}")
Sleep(100)
MouseMove(300, 340)
Sleep(100)
InitialBagCheck()
$emptybag = getbagLocation()
TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
Sleep(1000)
If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
Sleep(1000)
Send("{B}")
Sleep(500)
If $boxisfull = 0 Then
gotoBox()
If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
movebagtoBox()
Sleep(100)
exitRoom()
Return True
Else
exitRoom()
Return True
EndIf
EndIf
If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 10 Then
Sleep(100)
exitRoom()
Sleep(2000)
TrayTip("", "正在执行关机", 1, 16)
Sleep(1000)
Shutdown(1)
Sleep(1000)
Exit 0
Return True
EndIf
Else
Send("{B}")
Return False
EndIf
Else
Return False
EndIf
EndFunc
Func chkbagisfull()
Sleep(10)
MouseMove(300, 100)
Sleep(00)
$emptybag = getbagLocation()
TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
Sleep(10)
If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
Sleep(1000)
Return True
Else
Return False
EndIf
EndFunc
Func gotoBox()
Sleep(100)
MouseClick("left", 200, 500, 1)
Sleep(1600)
MouseClick("left", 750, 430, 1)
Sleep(1600)
MouseClick("left", 380, 480, 1)
Sleep(1400)
MouseMove(150, 240)
Sleep(100)
MouseClick("left", 150, 240, 1)
Sleep(1800)
EndFunc
Func clickAnya()
TrayTip("", "寻找安亚！.", 1, 16)
$coord = PixelSearch(100, 30, 380, 280, 0xA420FC, 30, 1, $Title)
If Not @error Then
TrayTip("", "找到安亚了，走向安亚！.", 1, 16)
$x = $coord[0] + 20
$y = $coord[1] + 50
MouseMove($x, $y)
Sleep(100)
MouseClick("left", $x, $y, 1)
Sleep(2000)
EndIf
EndFunc
Func clickTrade()
$coord = PixelSearch(100, 10, 400, 300, 0x1CC40C, 30, 1, $Title)
If Not @error Then
TrayTip("", "进行交易！", 1, 16)
MouseMove($coord[0] + 50, $coord[1] + 40)
Sleep(50)
MouseClick("left", Default, Default, 1)
Sleep(200)
EndIf
EndFunc
Func findanyaItem()
If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
$istrade = 1
If chkbagisfull() Then
Send("{ESC}")
Sleep(1000)
exitRoom()
EndIf
TrayTip("", "寻找物品.", 1, 16)
Sleep(10)
$left = 100
$top = 120
$right = 380
$bottom = 410
$coord = PixelSearch($left, $top, $right, $bottom, 0x682070, 10, 1, $Title)
If Not @error Then
TrayTip("", "找到好东西了！.", 1, 16)
Sleep(10)
$x = $coord[0]
$y = $coord[1]
MouseMove($x, $y)
Sleep(200)
MouseClick("right", Default, Default, 1)
Sleep(50)
MouseMove(400, 300)
Sleep(50)
writelog("物品---在第" & $round & "刷出东西")
If findPointColor($x, $y, "682070") Then
TrayTip("", "没有购买成功，包裹已满或是钱不够了！.", 1, 16)
writelog("物品---在第" & $round & "无法购买")
Exit
EndIf
Send("{ESC}")
Sleep(1500)
Return True
Else
TrayTip("", "没找到好东西，重新来！.", 1, 16)
Sleep(10)
Send("{ESC}")
Return False
EndIf
EndIf
EndFunc
Func findanya()
$coord = PixelSearch(100, 10, 380, 280, 0xA420FC, 30, 1, $Title)
If Not @error Then
TrayTip("", "找到anya！.", 1, 16)
Sleep(10)
Return True
Else
TrayTip("", "没有找到anya！.", 1, 16)
Sleep(500)
Return False
EndIf
EndFunc
Func writelog($str)
_FileWriteLog(@ScriptDir & "\" & $Files, $str)
EndFunc
