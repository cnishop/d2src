#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ACN_HASH.au3>
#AutoIt3Wrapper_icon=D:\autoit3\Aut2Exe\Icons\kde.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=��ע��QQ:123��
#AutoIt3Wrapper_Res_Description=��ע��QQ:123��
#AutoIt3Wrapper_Res_Fileversion=2.0.0
;  2010-08-07 19:27����  (�û���)
; ������ά������ 
;��������ά�����ҡ� Http://www.sn189.com 
; �����д����������QQ:825312600 
;#NoTrayIcon 

Global $Cdkey, $cpuid, $hdKey ,$Iname ,$Ihdkey ,$Iregkey , $Diskid, $CpuOrDisk
$RegPW1 = "QQ_1246035036" ;������֮������ 1
$RegPW2 = "WWW.MICROSOFT.COM" ;������֮������ 2
$KeyPw = "cnishop@126.comk3c" ;����ע����ʱ�õ��� ������!



$RegGUI = GUICreate(" ����K3C�������ע��", 283, 157, @DesktopWidth / 2 - 150, @DesktopHeight / 2 - 150)
$Title = GUICtrlCreateLabel("����ע��", 120, 4, 130, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
$User = GUICtrlCreateLabel("�û���", 8, 28, 40, 17)
$RegUser = GUICtrlCreateInput("D2K3C", 55, 25, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 15)
GUICtrlSetBkColor(-1, 0xECE9D8)
$MacKey = GUICtrlCreateLabel("������", 8, 58, 40, 17)
$hdKey = GUICtrlCreateInput(_HDkey(), 55, 55, 217, 21, BitOR($ES_CENTER, $ES_READONLY, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 32)
GUICtrlSetBkColor(-1, 0xECE9D8)
$RegSn = GUICtrlCreateLabel("ע����", 8, 88, 40, 17)
$RegKey = GUICtrlCreateInput("", 55, 85, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 32)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0xECE9D8)
$BtnOK = GUICtrlCreateButton(" ע �� ", 104, 120, 75, 25)
;GUISetState(@SW_SHOW)
Func gui()
	
;ClipPut(_HDkey()) ;�Ѻ���_HDkey() ��ȡ�õ�Ӳ���벢�ڼ��ܺ� ���͵����а���..
;MsgBox(0, "��ʾ:", " �Ѿ��������뷢�͵����а� " & @CR & "  ����ֱ��ճ��ע����! " & @CR & "�뽫�û����ͻ����뷢������!", 3)

;_IniVer()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $BtnOK
			If GUICtrlRead($RegUser) = "" Or GUICtrlRead($RegKey) = "" Then
				MsgBox(0, "����", "�û�����ע���붼����Ϊ��")
			Else	
				If GUICtrlRead($RegKey)  =  _CdKey() Then 
					IniWrite("D2K3C.dat", "ע��", "�û��� ", GUICtrlRead($RegUser))
					IniWrite("D2K3C.dat", "ע��", "������ ",  _HDkey()  )
					IniWrite("D2K3C.dat", "ע��", "ע���� ", GUICtrlRead($RegKey) )
				    MsgBox(48, "��ʾ", "ע��ɹ�����رպ����´򿪣�"  )
				Else
					MsgBox(48, "����", "ע��ʧ��" & @CR & "�û�����ע�������!"  )
;~ 					ExitLoop
					;ʧ��֮���˳�����
				EndIf
				;������ζ���ִ�еĲ���,���Ե�ע��ʧ�ܺ� �˳��������һֱѭ��ע��Ľ���
			EndIf
	EndSwitch
WEnd
EndFunc

Func _Diskid() ;ȡ��CPU�����к�ID
	If $testversion = 0 And $bindmac = 1 Then ;����ʽ��Űﶨ
		$sn = DllCall(@ScriptDir & "\sys2.dll", "int", "GetSerialNumber", "int", "nDrive", "str", "lpBuffer") ;���к�
		If @error Then ;�����ʧ�ܣ�����cpu id
			MsgBox(0, "����", "ȱ���ļ�2��,ȷ���Ƿ���ͬһ���ļ�����" & @LF & "�������:" & @error)
			;_Cpuid()
			;Return $cpuid
			Exit 0
		Else
			$Diskid = $sn[2]
			Return $Diskid
		EndIf
	EndIf
EndFunc   ;==>_Diskid

Func _Cpuid() ;ȡ��CPU�����к�ID
	$objWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	$colCPU = $objWMIService.ExecQuery("Select * from Win32_Processor")
	For $object In $colCPU
		$cpuid = StringStripWS($object.ProcessorId, 1)
		Return $cpuid ;��������������ú���һ����������
	Next
EndFunc   ;==>_Cpuid
Func _HDkey() ;��CPU���к�ID����
		 ;Ӳ�̰󶨷�ʽ
	_Diskid()
	$hdKey = StringMid(_MD5(StringMid(_MD5($Diskid & $RegPW1), 3, 34) & $RegPW2), 3, 34) ;Ӳ��
    $CpuOrDisk = "D"
	
	;_Cpuid() 
	;$hdKey = StringMid(_MD5(StringMid(_MD5($cpuid & $RegPW1), 3, 34) & $RegPW2), 3, 34)
	;$CpuOrDisk = "C"
	
	Return $hdKey
;~ 	ClipPut($hdKey)  ;
;~ 	MsgBox(0, "��ʾ:", " �Ѿ���ע���뷢�͵����а� " & @CR & " ����ֱ��ճ��ע����! ")
EndFunc   ;==>_HDkey
Func _CdKey() ;���ܵĹؼ����� ��������MD5����  ����ע����Ĺؼ����־�������, ���Ҫ�Լ�д�����㷨 �Ǿ͸�����
	_HDkey()
	$Cdkey = StringMid(_MD5($hdKey & GUICtrlRead($RegUser) & $KeyPw), 3, 34) ;MD5���� û�¿��������ƽ�һ��@!!!!!
	;StringMid����ȡ�ֽ��еĲ����ַ� ,GUICtrlRead��ȡ�ؼ��е�����,
	Return $Cdkey
EndFunc   ;==>_CdKey






Func _IniVer()
$iregkey = IniRead("D2K3C.dat", "ע��", "ע����", "")
   If $Iregkey = _Cdkey() Then
	   ;GUISetState(@SW_SHOW)
	   ;GUICtrlSetData($RegKey,"ע��ɹ�", "") ;�������$RegKey д������$Cdkey
	   Return True
;~  ע��ɹ�ʱ �Ĵ���ʽ
	Else ;���û�гɹ�ע��Ļ�
		GUISetState(@SW_SHOW)
		;MsgBox(0, "��ʾ:", " �Ѿ��������뷢�͵����а� " & @CR & "  ����ֱ��ճ��ע����! " & @CR & "�뽫�û����ͻ����뷢������!", 3)
		Return False
   EndIf   
;~    �������д��û��ע����߹��ں�Ĵ���ʽ
EndFunc


