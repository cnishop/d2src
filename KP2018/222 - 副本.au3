#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** ���������� ACNWrapper_GUI ****
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

$sn = DllCall(@ScriptDir & "\sys2.dll", "int", "GetSerialNumber", "int", "nDrive", "str", "lpBuffer") ;���к�
		If @error Then ;�����ʧ�ܣ�����cpu id
			MsgBox(0, "����", "ȱ���ļ�2��,ȷ���Ƿ���ͬһ���ļ�����" & @LF & "�������:" & @error)
			;_Cpuid()
			;Return $cpuid
			Exit 0
		Else
			$Diskid = $sn[2]
		EndIf
Msgbox(0, "", "s serial number: " &$Diskid)
