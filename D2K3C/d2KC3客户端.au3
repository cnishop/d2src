#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ACN_HASH.au3>
#AutoIt3Wrapper_icon=D:\autoit3\Aut2Exe\Icons\kde.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=【注册QQ:123】
#AutoIt3Wrapper_Res_Description=【注册QQ:123】
#AutoIt3Wrapper_Res_Fileversion=2.0.0
;  2010-08-07 19:27修正  (用户端)
; 智能网维工作室 
;【智能网维工作室】 Http://www.sn189.com 
; 程序编写【土豆】：QQ:825312600 
;#NoTrayIcon 

Global $Cdkey, $cpuid, $hdKey ,$Iname ,$Ihdkey ,$Iregkey , $Diskid, $CpuOrDisk
$RegPW1 = "QQ_1246035036" ;机器码之保护码 1
$RegPW2 = "WWW.MICROSOFT.COM" ;机器码之保护码 2
$KeyPw = "cnishop@126.comk3c" ;计算注册码时用到的 保护码!



$RegGUI = GUICreate(" 暗黑K3C精灵程序注册", 283, 157, @DesktopWidth / 2 - 150, @DesktopHeight / 2 - 150)
$Title = GUICtrlCreateLabel("程序注册", 120, 4, 130, 20)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
$User = GUICtrlCreateLabel("用户名", 8, 28, 40, 17)
$RegUser = GUICtrlCreateInput("D2K3C", 55, 25, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
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
;GUISetState(@SW_SHOW)
Func gui()
	
;ClipPut(_HDkey()) ;把函数_HDkey() 所取得的硬件码并在加密后 发送到剪切板中..
;MsgBox(0, "提示:", " 已经将机器码发送到剪切板 " & @CR & "  可以直接粘贴注册码! " & @CR & "请将用户名和机器码发给作者!", 3)

;_IniVer()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $BtnOK
			If GUICtrlRead($RegUser) = "" Or GUICtrlRead($RegKey) = "" Then
				MsgBox(0, "警告", "用户名和注册码都不能为空")
			Else	
				If GUICtrlRead($RegKey)  =  _CdKey() Then 
					IniWrite("D2K3C.dat", "注册", "用户名 ", GUICtrlRead($RegUser))
					IniWrite("D2K3C.dat", "注册", "机器码 ",  _HDkey()  )
					IniWrite("D2K3C.dat", "注册", "注册码 ", GUICtrlRead($RegKey) )
				    MsgBox(48, "提示", "注册成功，请关闭后重新打开！"  )
				Else
					MsgBox(48, "警告", "注册失败" & @CR & "用户名或注册码错误!"  )
;~ 					ExitLoop
					;失败之后退出程序
				EndIf
				;无论如何都会执行的操作,所以当注册失败后 退出程序或者一直循环注册的界面
			EndIf
	EndSwitch
WEnd
EndFunc

Func _Diskid() ;取得CPU的序列号ID
	If $testversion = 0 And $bindmac = 1 Then ;是正式版才帮定
		$sn = DllCall(@ScriptDir & "\sys2.dll", "int", "GetSerialNumber", "int", "nDrive", "str", "lpBuffer") ;序列号
		If @error Then ;如果绑定失败，就用cpu id
			MsgBox(0, "错误", "缺少文件2了,确认是否在同一个文件夹中" & @LF & "错误代码:" & @error)
			;_Cpuid()
			;Return $cpuid
			Exit 0
		Else
			$Diskid = $sn[2]
			Return $Diskid
		EndIf
	EndIf
EndFunc   ;==>_Diskid

Func _Cpuid() ;取得CPU的序列号ID
	$objWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	$colCPU = $objWMIService.ExecQuery("Select * from Win32_Processor")
	For $object In $colCPU
		$cpuid = StringStripWS($object.ProcessorId, 1)
		Return $cpuid ;可以像象调用内置函数一样调用它们
	Next
EndFunc   ;==>_Cpuid
Func _HDkey() ;把CPU序列号ID加密
		 ;硬盘绑定方式
	_Diskid()
	$hdKey = StringMid(_MD5(StringMid(_MD5($Diskid & $RegPW1), 3, 34) & $RegPW2), 3, 34) ;硬盘
    $CpuOrDisk = "D"
	
	;_Cpuid() 
	;$hdKey = StringMid(_MD5(StringMid(_MD5($cpuid & $RegPW1), 3, 34) & $RegPW2), 3, 34)
	;$CpuOrDisk = "C"
	
	Return $hdKey
;~ 	ClipPut($hdKey)  ;
;~ 	MsgBox(0, "提示:", " 已经将注册码发送到剪切板 " & @CR & " 可以直接粘贴注册码! ")
EndFunc   ;==>_HDkey
Func _CdKey() ;加密的关键部分 这里是用MD5加密  整个注册机的关键部分就是这里, 如果要自己写加密算法 那就复杂了
	_HDkey()
	$Cdkey = StringMid(_MD5($hdKey & GUICtrlRead($RegUser) & $KeyPw), 3, 34) ;MD5加密 没事可以试着破解一下@!!!!!
	;StringMid用来取字节中的部分字符 ,GUICtrlRead读取控件中的内容,
	Return $Cdkey
EndFunc   ;==>_CdKey






Func _IniVer()
$iregkey = IniRead("D2K3C.dat", "注册", "注册码", "")
   If $Iregkey = _Cdkey() Then
	   ;GUISetState(@SW_SHOW)
	   ;GUICtrlSetData($RegKey,"注册成功", "") ;给输入框$RegKey 写入内容$Cdkey
	   Return True
;~  注册成功时 的处理方式
	Else ;如果没有成功注册的话
		GUISetState(@SW_SHOW)
		;MsgBox(0, "提示:", " 已经将机器码发送到剪切板 " & @CR & "  可以直接粘贴注册码! " & @CR & "请将用户名和机器码发给作者!", 3)
		Return False
   EndIf   
;~    这里可以写入没有注册或者过期后的处理方式
EndFunc


