#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <diskserial.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ACN_HASH.au3>

Dim $ss

$ss=$sSerialNum1


Msgbox(0, "", "s serial number: " & $ss)

$sn = DllCall(@ScriptDir & "\sys2.dll", "int", "GetSerialNumber", "int", "nDrive", "str", "lpBuffer") ;序列号
		If @error Then ;如果绑定失败，就用cpu id
			MsgBox(0, "错误", "缺少文件2了,确认是否在同一个文件夹中" & @LF & "错误代码:" & @error)
			;_Cpuid()
			;Return $cpuid
			Exit 0
		Else
			$Diskid = $sn[2]
		EndIf
Msgbox(0, "", "s serial number: " &$Diskid)
