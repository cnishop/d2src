#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=D:\autoit3\Aut2Exe\Icons\kde.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=��ע��QQ��123��
#AutoIt3Wrapper_Res_Description=��ע��QQ��123��
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ACN_HASH.au3>

Dim $Cdkey
$KeyPw = "cnishop@126.comk3c" ;����ע����ʱ�õ��� ������!
$RegGUI = GUICreate("��ע��QQ��123��", 283, 157, @DesktopWidth/2-150,@DesktopHeight/2-150)
$Title = GUICtrlCreateLabel(" ����ע��� ", 80, 4, 130, 20)
GUICtrlSetFont(-1, 10, 800, 0, "��ע��QQ��123��")
GUICtrlSetColor(-1, 0xFF0000)
$User = GUICtrlCreateLabel("�û���", 8, 28, 40, 17)
$RegUser = GUICtrlCreateInput("", 55, 25, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 15);������������������
GUICtrlSetBkColor(-1, 0xECE9D8)
$MacKey = GUICtrlCreateLabel("������", 8, 58, 40, 17)
$HdKey = GUICtrlCreateInput("", 55, 55, 217, 21, BitOR($ES_CENTER, $ES_AUTOHSCROLL, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
GUICtrlSetLimit(-1, 32);������������������
GUICtrlSetBkColor(-1, 0xECE9D8)
$RegSn = GUICtrlCreateLabel("ע����", 8, 88, 40, 17)
$RegKey = GUICtrlCreateInput("", 55, 85, 217, 21, BitOR($ES_CENTER, $ES_READONLY, $WS_BORDER, $WS_CLIPSIBLINGS), $WS_EX_STATICEDGE)
;~ GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetLimit(-1, 32);������������������
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetBkColor(-1, 0xECE9D8)
$BtnOK = GUICtrlCreateButton("ȡע����", 104, 120, 75, 25)
GUISetState(@SW_SHOW)
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $BtnOK
			If GUICtrlRead($HdKey) = "" Or GUICtrlRead($RegUser) = "" Then ;�ж������$HdKey ���� $RegUser �Ƿ�Ϊ�� 
				MsgBox(0, "����", "�û����ͻ����붼����Ϊ��")
			Else
				_CdKey()
				GUICtrlSetData($RegKey, $Cdkey, "") ;�������$RegKey д������$Cdkey
				IniWrite("ע���û�.ini", "K3Cע��", GUICtrlRead($RegUser), ' ' & GUICtrlRead($HdKey) & ' = ' & $Cdkey)
				ClipPut($Cdkey) ;��ָ���ؼ�($Cdkey)�е����ݷ��͵����а���,
				MsgBox(0, "��ʾ:", " �Ѿ���ע���뷢�͵����а� " & @CR & " ����ֱ��ճ��ע����! ",3)
			EndIf
	EndSwitch
WEnd
;�������ȫֻ��ע����Ľ��沿�� ������ע������õ�������Ĳ���
Func _CdKey() ;���ܵĹؼ����� ��������MD5����  ����ע����Ĺؼ����־�������, ���Ҫ�Լ�д�����㷨 �Ǿ͸�����
	$Cdkey = StringMid(_MD5(GUICtrlRead($hdKey) & GUICtrlRead($RegUser) & $KeyPw), 3, 34) ;MD5���� û�¿��������ƽ�һ��@!!!!!
	;StringMid����ȡ�ֽ��еĲ����ַ� ,GUICtrlRead��ȡ�ؼ��е�����,
	Return $Cdkey
EndFunc   ;==>_CdKey