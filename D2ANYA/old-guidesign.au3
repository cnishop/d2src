#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#NoTrayIcon
#include <Array.au3>
Opt("TrayMenuMode", 1) ; Ĭ�����̲˵���Ŀ(�ű�����ͣ/�˳��ű�) (Script Paused/Exit) ������ʾ.
Global $usr, $psd, $fire, $cta
Global $pos
Local $avArray[3], $avArrayP[8]




#Region ### START Koda GUI section ### Form=d:\tool\autoit3\examples\guo\d2kp\design.kxf
$Form1_1_1 = GUICreate("����2-KP����-��BOT", 623, 586, 192, 124)
$Group1 = GUICtrlCreateGroup("�ʺ���Ϣ", 8, 0, 225, 113)
$Label1 = GUICtrlCreateLabel("վ���ʺ�", 16, 24, 52, 17)
$Label2 = GUICtrlCreateLabel("վ������", 16, 56, 52, 17)
$n1 = GUICtrlCreateInput("", 72, 16, 89, 21)
$n2 = GUICtrlCreateInput("", 72, 48, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
$ExitID = GUICtrlCreateButton("�˳�", 144, 80, 75, 25)
$SaveID = GUICtrlCreateButton("����", 32, 80, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("��ɫ��������", 240, 0, 377, 113)
$Radio1 = GUICtrlCreateRadio("����ϵ��ʦ F1-����,F2-����ѩ,F5-����װ��", 256, 16, 265, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("����ϵ��ʦ F1-����,F2-�����,F5-����װ��", 256, 40, 305, 17)
$Radio3 = GUICtrlCreateRadio("����˫��(����) F1-����,F2-�����,F3-����ѩ,F5-����װ��", 256, 64, 313, 17)
$Ckbcta = GUICtrlCreateCheckbox("����Я��ս���ٻ� F7-ս��ָ��,F8-ս������ ", 256, 88, 305, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("����ǰ����", 8, 240, 609, 145)
$Label3 = GUICtrlCreateLabel("1.�򿪰���Ŀ¼�µ� d2hackmap.cfg ������Ҫ��ȡ��Ʒ������ɫ����Ϊ 2����ʾ����ɫ(˲��ظ���������)                                           ", 24, 264, 579, 17)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT)
$Label4 = GUICtrlCreateLabel("�Ի�֮����  HackMap2.24 CFG For DIIExp 1.11b  Ϊ���� Item Colours[1116][7]:     2,0x20 //Ȩ�ڣ�                              ", 32, 288, 579, 17)
$Label5 = GUICtrlCreateLabel("2.���ڼ��� -title d2�� ����һ��������Ϸ����ʾģʽ���800*600                                                                                 ", 24, 312, 576, 17)
$Label6 = GUICtrlCreateLabel("3.������Ϸ������Ƿ������õ���Ʒ��ʾΪ����ɫ���Ҵ���Ϊ 800*600                                                                   ", 24, 336, 569, 17)
$Label7 = GUICtrlCreateLabel("4.������Ϸ��ɫ�������ܿ�ݼ�����Ϊ��˳������Ͻǵ�һ��  ", 24, 360, 331, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("��ɫλ��", 8, 120, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 16, 136, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 16, 160, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 16, 184, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 16, 208, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 88, 136, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 88, 160, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 88, 184, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 88, 208, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group6 = GUICtrlCreateGroup("ϵͳ | ��Ϸ��ɫװ������", 176, 120, 441, 113)
$Label8 = GUICtrlCreateLabel("1.������8������,����150���� ", 184, 144, 163, 17)
$Label9 = GUICtrlCreateLabel("2.�������������򣬽�����OAK�����֮�򣨲�׷��MF��Ѹ��ɱ��Ч�ʵ�һ�� ", 184, 168, 413, 17)
$Label10 = GUICtrlCreateLabel("��������װ���ɣ�Ь��25�������ϣ�������wt ", 192, 184, 399, 17)
$Label11 = GUICtrlCreateLabel("3.PET��ɥ�ӣ���ͷ+����׻���㣨PET�����ܶ����Ҳ����׹ң�", 184, 208, 349, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("���з�ʽ", 8, 392, 609, 145)
$Label12 = GUICtrlCreateLabel("2.�˽��������˺����뱣�棬������(��һ�α��棬�Ժ�ÿ�δ򿪣�ֱ�ӵ�����)                                   ", 24, 448, 520, 17)
$Label13 = GUICtrlCreateLabel("3. ������ݼ��� F9 -��ʼ��Ϸ F11-�˳��ű�                                                         ", 24, 472, 400, 17)
$YesID = GUICtrlCreateButton("����", 272, 504, 75, 25)
$Label14 = GUICtrlCreateLabel("Ȼ���˳����䣬���ص�վ�������������     ", 32, 424, 235, 17)
$Label15 = GUICtrlCreateLabel("1.�򿪰�����Ϸ����һ�����ֶ�����һ��������Ϸ������ͣ����act5�������������㹻�ռ䣬                   ", 24, 408, 547, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_1)
Dim $StatusBar1_PartsWidth[2] = [300, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "����2ר��KP�һ����ߣ����������޷���⣬���԰�ȫ", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "��������QQ:1246035036,����:cnishop@126.com", 1)


TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("����")
TrayCreateItem("")
$aboutitem = TrayCreateItem("����")
TrayCreateItem("")
$exititem = TrayCreateItem("�˳�")

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


$mainform = WinGetHandle($Form1_1_1)
Func creatGui()
	TraySetState()
	GUISetState(@SW_SHOW, $mainform)
	readinfor()
	While 1
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		Select
			Case $msg = $SaveID ;save info
				saveinfor()
				MsgBox(0, "�ɹ�", "����ɹ�")
			Case $msg = $YesID
				If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 1
				ElseIf BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 2
				ElseIf BitAND(GUICtrlRead($Radio3), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 3
				EndIf
				
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
				
		EndSelect
		
		$msg1 = TrayGetMsg()
		Select
			Case $msg1 = 0
				ContinueLoop
			Case $msg1 = $prefsitem
				MsgBox(64, "����:", "ϵͳ�汾:" & @OSVersion)
			Case $msg1 = $aboutitem
				MsgBox(64, "����:", "����2ר��KP�һ�����.")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui

Func saveinfor()
	
	$avArray[0] = $Radio1
	$avArray[1] = $Radio2
	$avArray[2] = $Radio3
	
	$avArrayP[0] = $RadP1
	$avArrayP[1] = $RadP2
	$avArrayP[2] = $RadP3
	$avArrayP[3] = $RadP4
	$avArrayP[4] = $RadP5
	$avArrayP[5] = $RadP6
	$avArrayP[6] = $RadP7
	$avArrayP[7] = $RadP8

	
	For $i = 0 To 2 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArray[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$fire = $i + 1
		EndIf
	Next
	
	For $i = 0 To 7 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayP[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$pos = $i + 1
		EndIf
	Next

	If BitAND(GUICtrlRead($Ckbcta), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$cta = 1
	Else
		$cta = 0
	EndIf

	IniWrite("info.dat", "��Ϣ", "�ʺ�", GUICtrlRead($n1))
	IniWrite("info.dat", "��Ϣ", "����", GUICtrlRead($n2))
	IniWrite("info.dat", "��Ϣ", "cta", $cta)
	IniWrite("info.dat", "��Ϣ", "����", $fire)
	IniWrite("info.dat", "��Ϣ", "λ��", $pos)


EndFunc   ;==>saveinfor

Func readinfor()
	$usr = IniRead("info.dat", "��Ϣ", "�ʺ�", "")
	$psd = IniRead("info.dat", "��Ϣ", "����", "")
	$fire = IniRead("info.dat", "��Ϣ", "����", "")
	$pos = IniRead("info.dat", "��Ϣ", "λ��", "")
	$cta = IniRead("info.dat", "��Ϣ", "cta", "")
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	Select
		Case $fire = 1
			GUICtrlSetState($Radio1, $GUI_CHECKED)
		Case $fire = 2
			GUICtrlSetState($Radio2, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($Radio3, $GUI_CHECKED)
	EndSelect
	
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

	If $cta = 1 Then
		GUICtrlSetState($Ckbcta, $GUI_CHECKED)
	Else
		GUICtrlSetState($Ckbcta, $GUI_UNCHECKED)
	EndIf
EndFunc   ;==>readinfor


