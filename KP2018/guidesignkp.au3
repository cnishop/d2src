
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <DateTimeConstants.au3>
#include <Date.au3>
#include <string.au3>   ;16����ת�ַ���


#NoTrayIcon
#include <Array.au3>
Opt("TrayMenuMode", 1) ; Ĭ�����̲˵���Ŀ(�ű�����ͣ/�˳��ű�) (Script Paused/Exit) ������ʾ.

Global $Files = "system.log" ;��־��¼
Global $infofiles = "info.dat", $remark = "˵��.txt"
Global $usr, $psd, $fire, $d2path1, $d2path2, $d2path3, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5, $guinamepre, $guinamegd, $guikpmode,$ckred,$ckblue
Global $pos, $guibhTime, $guiboxing, $guiMoveBox, $guiboxqty, $guimoveround, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime, $guipath, $guifirelighttime
Global $guiramclose, $guiclosetime, $guiclosestoptime
Global $guiothercheck ;������˽��룬��ʱ��飬��鵽�Ĵ���������鵽�������ٵĴ��� ,�涨���ν�����ļ������
Global $guisldspeed ;����ѡ��
Global $guiWalkspeedAdjust ;�����ٶȵ���
Global $guiotherimage ;�Ƿ񱣴�İ����ͼƬ
Global $guititle, $guiexeparm3, $guigamemode ;���⣬��������,��Ϸģʽ
Global $guiclosegame, $guiclosegamesec ;�����Ƿ���������Ϸ
Local $avArray[2], $avArrayP[8], $avArrayName[4], $avArrayPath[5], $ArrayOtherWhen[2], $Arrayothermetherd[2]
Local $avGameMode[2] ;��Ϸģʽ����������ս��
Global $ImageMode[2] ,$guiImageMode;��ͼ��ģʽ��������ͨ�� ����ͨ��ͼƬ
Local $avKpMode[4] ;kpģʽ��Ĭ�ϣ���Ч��
Local $avMove[2] ;ת�Ƶ������ķ�ʽ
Global $guiavAlpName[12] ;�Զ����12����ĸ����
Global $guitpFire, $guifireFire, $guiarmFire ;���ܿ�ݼ�


$Form1_1_2_1 = GUICreate("", 531, 614, 489, 42)
$Tab1 = GUICtrlCreateTab(4, 8, 513, 529)
$TabSheet1 = GUICtrlCreateTabItem("ϵͳ")
$Group7 = GUICtrlCreateGroup("��Ϸ·��", 8, 32, 505, 177)
$path1 = GUICtrlCreateInput("e:\�����ƻ���ii����֮��\d2loader.exe -w -lq -direct -title d2", 100, 56, 321, 21, BitOR($GUI_SS_DEFAULT_INPUT,$WS_BORDER), BitOR($WS_EX_CLIENTEDGE,$WS_EX_STATICEDGE))
$Label16 = GUICtrlCreateLabel("����Ŀ��:", 20, 56, 55, 17)
$Label17 = GUICtrlCreateLabel("��ʼλ�ã�", 20, 80, 64, 17)
$path2 = GUICtrlCreateInput("E:\�����ƻ���II����֮��", 100, 80, 289, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label28 = GUICtrlCreateLabel("�������ƣ�", 20, 104, 64, 17)
$path3 = GUICtrlCreateInput(".exe", 100, 104, 225, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$btnPath = GUICtrlCreateButton("���", 428, 52, 43, 25)
$Label3 = GUICtrlCreateLabel("����������", 20, 152, 64, 17)
$ckbexeparm1 = GUICtrlCreateCheckbox("-w (���ڻ�)", 100, 152, 81, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label4 = GUICtrlCreateLabel("���ڱ��⣺", 20, 128, 64, 17)
$exetile = GUICtrlCreateInput("exetile", 100, 128, 97, 21)
$Label5 = GUICtrlCreateLabel("�����  abc  ", 212, 128, 82, 17)
$Label6 = GUICtrlCreateLabel("��������:", 20, 176, 55, 17)
$exeparm3 = GUICtrlCreateInput("-ns", 100, 176, 209, 21)
$Label7 = GUICtrlCreateLabel("(�ɲ���) ", 324, 176, 49, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("�ⲿ����", 8, 400, 505, 129)
$ckbTimeshut = GUICtrlCreateCheckbox("��ʱ�ػ�:", 16, 424, 73, 17)
$dtshut = GUICtrlCreateDate("2017/03/13 12:13:43", 96, 424, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))

	GUICtrlSendMsg(-1, 0x1032, 0, "yyyy/MM/dd HH:mm:ss") ; DTM_SETFORMATW

$Label31 = GUICtrlCreateLabel("����ѡ��:", 20, 482, 55, 17)
$sldspeed = GUICtrlCreateSlider(88, 476, 134, 20)
GUICtrlSetLimit(-1, 2, 0)
GUICtrlSetData(-1, 1)
$Label32 = GUICtrlCreateLabel("��", 92, 504, 16, 17)
$Label33 = GUICtrlCreateLabel("��", 148, 504, 16, 17)
$Label34 = GUICtrlCreateLabel("��", 204, 504, 16, 17)
$ckbRanclosegame = GUICtrlCreateCheckbox("��ʱ���ٷ���������Ϸ��", 16, 448, 161, 17)
$txtranclosegame = GUICtrlCreateInput("60", 180, 448, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label25 = GUICtrlCreateLabel("��ֱ�Ӹ���˲���ٶ�", 236, 480, 112, 17)
$Group16 = GUICtrlCreateGroup("CPU", 368, 416, 137, 81)
$RadNormal = GUICtrlCreateRadio("��ͨ", 396, 436, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadHigh = GUICtrlCreateRadio("��ǿ", 396, 468, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("��Ϸģʽ", 8, 216, 505, 49)
$RadGame1 = GUICtrlCreateRadio("ս��ģʽ", 76, 236, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadGame2 = GUICtrlCreateRadio("����ģʽ", 252, 236, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("KPģʽ(ÿ��ѡ����, ��ص㱣��,����Ч) -������ҽ���ʹ�ø�Чģʽ", 8, 272, 505, 121)
$Radkpmod2 = GUICtrlCreateRadio("��Чģʽ(�Ƽ�)--�������,ǿ��kp,���ʺ����ڵ�����ǰ�Ķ�ʱ���ڹһ�,��ʵ������ֵ��", 12, 320, 489, 17)
$Radkpmod1 = GUICtrlCreateRadio("һ��ģʽ--������б�Ҫ����,ʵ������ֵ��,�ʺ�0-2Сʱ�һ�", 12, 296, 377, 17)
$Radkpmod3 = GUICtrlCreateRadio("����ģʽ(����)--������ʱ,�ʺϳ�ʱ�䲻�ڵ�����ǰ�����", 12, 344, 361, 17)
$Radkpmod4 = GUICtrlCreateRadio("�Զ���ģʽ--������Լ����ù��ܵȽ���,����ѡ�ô�ģʽ", 12, 368, 377, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("��ɫ")
$Group5 = GUICtrlCreateGroup("��ɫλ��", 236, 41, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 244, 57, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 244, 81, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 244, 105, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 244, 129, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 316, 57, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 316, 81, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 316, 105, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 316, 129, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("��ɫ��������", 16, 164, 494, 281)
$Radio1 = GUICtrlCreateRadio("ͨ������", 24, 192, 97, 17)
$Radio2 = GUICtrlCreateRadio("���ⶩ��", 24, 290, 121, 17)
$Group12 = GUICtrlCreateGroup("", 124, 187, 353, 86)
$Label11 = GUICtrlCreateLabel("����", 136, 207, 28, 17)
$cmbTpFire = GUICtrlCreateCombo("", 176, 207, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label13 = GUICtrlCreateLabel("����", 242, 207, 28, 17)
$cmbArmFire = GUICtrlCreateCombo("", 286, 207, 57, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label12 = GUICtrlCreateLabel("��������", 134, 235, 52, 17)
$cmbFireFire = GUICtrlCreateCombo("", 200, 235, 57, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label19 = GUICtrlCreateLabel("����", 278, 235, 28, 17)
$firelighttime = GUICtrlCreateInput("25", 350, 235, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group1 = GUICtrlCreateGroup("�ʺ���Ϣ", 16, 41, 209, 113)
$Label1 = GUICtrlCreateLabel("վ���ʺ�", 24, 65, 52, 17)
$Label2 = GUICtrlCreateLabel("վ������", 24, 97, 52, 17)
$n1 = GUICtrlCreateInput("", 88, 65, 89, 21)
$n2 = GUICtrlCreateInput("", 88, 97, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet3 = GUICtrlCreateTabItem("·��")
$Group11 = GUICtrlCreateGroup("ȥ����·��(Ь���Ƽ� ս��֮ѥ-25����)", 16, 44, 476, 145)
$RDpath1 = GUICtrlCreateRadio("���·��", 120, 68, 89, 17)
$RDpath2 = GUICtrlCreateRadio("���·��", 24, 68, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDpath3 = GUICtrlCreateRadio("��һ·��", 24, 92, 73, 17)
$RDpath5 = GUICtrlCreateRadio("ר�ö���·��", 224, 92, 97, 17)
$RDpath4 = GUICtrlCreateRadio("�ȶ�·��", 120, 92, 81, 17)
$txtSpeed = GUICtrlCreateInput("0", 144, 130, 65, 21)
$Label29 = GUICtrlCreateLabel("�����ٶȵ��ں���:", 32, 132, 103, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet4 = GUICtrlCreateTabItem("����")
$Group8 = GUICtrlCreateGroup("��������", 16, 168, 489, 302)
$ckbBagfull = GUICtrlCreateCheckbox("������ػ�", 32, 184, 97, 17)
$ckbRej = GUICtrlCreateCheckbox("��ȥ������ƿ", 32, 228, 121, 17)
$ckbRoledead = GUICtrlCreateCheckbox("�����ɫ", 32, 248, 145, 17)
$ckbAss = GUICtrlCreateCheckbox("�����Ӷ��", 32, 268, 121, 17)
$ckbBoxing = GUICtrlCreateCheckbox("����װ��ת�Ƶ��ֿ�", 32, 208, 129, 17)
$ckbQinse = GUICtrlCreateCheckbox("��Ӷ�����ӻ�(pet����ɫ��ŭ)", 32, 308, 177, 17)
$ckbAct5 = GUICtrlCreateCheckbox("����Ƿ���ACT5", 32, 288, 145, 17)
$Label24 = GUICtrlCreateLabel("ÿ�ּ�ȡ��Ʒ��������:", 28, 415, 127, 17)
$picktime = GUICtrlCreateInput("5", 172, 415, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Checkbox1 = GUICtrlCreateCheckbox("�Զ��Ӻ���", 32, 372, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Checkbox2 = GUICtrlCreateCheckbox("�Զ�����Ӷ����Ѫ", 32, 392, 121, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Group15 = GUICtrlCreateGroup("ת�Ƶ��ֿⷽʽ:", 184, 184, 169, 89)
$boxQty = GUICtrlCreateInput("8", 312, 208, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$RadMove1 = GUICtrlCreateRadio("���ڴ˰�������:", 192, 208, 113, 17)
$RadMove2 = GUICtrlCreateRadio("ÿ���˾���:", 192, 240, 97, 17)
$txtMoveRound = GUICtrlCreateInput("100", 312, 240, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ckbByRed = GUICtrlCreateCheckbox("���ҩˮ", 32, 328, 145, 17)
$ckbByBlue = GUICtrlCreateCheckbox("����ҩˮ", 32, 352, 145, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group9 = GUICtrlCreateGroup("����������", 16, 33, 265, 129)
$RDnameAp = GUICtrlCreateRadio("��ĸ������", 32, 49, 81, 17)
$RDnameMa = GUICtrlCreateRadio("���ַ�����", 32, 73, 81, 17)
$namelenfr = GUICtrlCreateInput("3", 168, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("��", 200, 65, 16, 17)
$namelento = GUICtrlCreateInput("6", 224, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("λ", 256, 65, 16, 17)
$Label23 = GUICtrlCreateLabel("����:", 128, 65, 31, 17)
$Label27 = GUICtrlCreateLabel("����ǰ׺:", 128, 97, 55, 17)
$namepre = GUICtrlCreateInput("aa", 200, 97, 41, 21)
$RDnameAd = GUICtrlCreateRadio("��������1 :", 32, 97, 89, 17)
$RDnameGd = GUICtrlCreateRadio("�������̶�:", 32, 121, 89, 17)
$namegd = GUICtrlCreateInput("aa", 128, 121, 73, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$grpName = GUICtrlCreateGroup("�Զ�����ĸ��(Сд,���ظ�)", 288, 33, 217, 129)
$txtName1 = GUICtrlCreateInput("a", 296, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName5 = GUICtrlCreateInput("s", 296, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName2 = GUICtrlCreateInput("s", 344, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName3 = GUICtrlCreateInput("d", 392, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName4 = GUICtrlCreateInput("a", 440, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName7 = GUICtrlCreateInput("a", 392, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName6 = GUICtrlCreateInput("d", 344, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName8 = GUICtrlCreateInput("s", 440, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName9 = GUICtrlCreateInput("d", 296, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName10 = GUICtrlCreateInput("s", 344, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName11 = GUICtrlCreateInput("a", 392, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName12 = GUICtrlCreateInput("s", 440, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet5 = GUICtrlCreateTabItem("αװ")
$Group10 = GUICtrlCreateGroup("�����----�����һ�40�������ϱ�������,������������,Ҳ�����鳤ʱ��һ�", 8, 40, 489, 473)
$ckbRamstop = GUICtrlCreateCheckbox("�ﵽ�涨KP����: ", 16, 88, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$kproundtime = GUICtrlCreateInput("30", 144, 87, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$lblstop1 = GUICtrlCreateLabel("��ͣ����:", 184, 87, 55, 17)
$ramstoptime = GUICtrlCreateInput("3600", 272, 87, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbRamclose = GUICtrlCreateCheckbox("�ﵽ�涨KP����:", 16, 111, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$kproundclosetime = GUICtrlCreateInput("50", 144, 111, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$lblstop2 = GUICtrlCreateLabel("����ͣ������", 184, 111, 76, 17)
$closestoptime = GUICtrlCreateInput("30", 272, 111, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbothersin = GUICtrlCreateCheckbox("������˽��뷿��", 16, 64, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$ckbNotfinddoor = GUICtrlCreateCheckbox("�������δ�ҵ����ţ�ֹͣ�һ�", 16, 156, 193, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$ckbConnectError = GUICtrlCreateCheckbox("����������������쳣����ͣ�һ�", 16, 184, 209, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Checkbox3 = GUICtrlCreateCheckbox("������ν������쳣����ͣ�һ�", 16, 212, 193, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetState(-1, $GUI_HIDE)
$TabSheet6 = GUICtrlCreateTabItem("��־")
$edtLog = GUICtrlCreateEdit("", 12, 40, 500, 361)
$readLog = GUICtrlCreateButton("��ȡ", 116, 416, 75, 25)
$deletLog = GUICtrlCreateButton("���", 324, 416, 75, 25)
$TabSheet7 = GUICtrlCreateTabItem("˵��")
$edtRemark = GUICtrlCreateEdit("", 12, 40, 497, 457)
$TabSheet8 = GUICtrlCreateTabItem("����")
$grpKeybord = GUICtrlCreateGroup("��ݼ�����(���д,������Ϸ������һ��):", 8, 41, 473, 137)
$lblTab = GUICtrlCreateLabel("С��ͼ:", 16, 65, 43, 17)
$txtTab = GUICtrlCreateInput("TAB", 72, 65, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
$lblTeam = GUICtrlCreateLabel("����:", 16, 97, 31, 17)
$txtTeam = GUICtrlCreateInput("P", 72, 97, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
$lblBag = GUICtrlCreateLabel("��Ʒ��:", 16, 129, 43, 17)
$txtBag = GUICtrlCreateInput("I", 72, 129, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [300, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "������Źһ�ʱ��,�͵��һ�", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036 �˶�������", 1)
$SaveID = GUICtrlCreateButton("����", 136, 544, 67, 25)
$ExitID = GUICtrlCreateButton("�˳�", 264, 544, 67, 25)
$YesID = GUICtrlCreateButton("����", 413, 544, 67, 25)
$Label18 = GUICtrlCreateLabel("�������� F11����/��ͣ, F10 �˳�     ", 292, 575, 220, 17)
GUICtrlSetColor(-1, 0xFF0000)
$lblversion = GUICtrlCreateLabel("PindleBox-��ʽ��  ", 392, 8, 96, 17)
$btnInitial = GUICtrlCreateButton("�ָ�Ĭ��", 12, 544, 67, 25)
GUICtrlSetState(-1, $GUI_HIDE)






   TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
   $prefsitem = TrayCreateItem("����")
   TrayCreateItem("")
   $aboutitem = TrayCreateItem("����")
   TrayCreateItem("")
   $exititem = TrayCreateItem("�˳�")
   
#EndRegion ### END Koda GUI section ###

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$mainform = WinGetHandle($Form1_1_2_1)
Func creatGui()
	TraySetState()
	GUISetState(@SW_SHOW, $mainform)
	;WinSetTitle($Form1_1_2_1,"","�������йһ������Ժ��ö�����.")
	;WinMove("", "", 10, 10)
	readinfor()
	While 1
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		
		
		Select
			Case $msg = $btnPath
				$folder = FileOpenDialog("���Ұ�����������", "C:Windows", "��ִ���ļ�(*.exe)")
				If Not @error Then
					GUICtrlSetData($path1, $folder)
				Else
					;MsgBox(0, "��ʾ", "��ѡ����ȷ��·��")
				EndIf
				
				$lenstr = StringInStr(GUICtrlRead($path1), "\", 1, -1) ;
				$path22 = StringLeft(GUICtrlRead($path1), $lenstr) ;�õ������·��
				$path32 = StringRight(GUICtrlRead($path1), StringLen(GUICtrlRead($path1)) - $lenstr) ;�õ������·��
				
				GUICtrlSetData($path2, $path22)
				GUICtrlSetData($path3, $path32)
				
			Case $msg = $SaveID ;save info
				If saveinfor() Then
					readinfor()
					MsgBox(0, "��ʾ", "����ɹ�����ر����´򿪲鿴")
				EndIf
			Case $msg = $YesID
				If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 1
				ElseIf BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 2
				EndIf
				GUICtrlSetState($btnInitial, $GUI_DISABLE)
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
				
			Case $msg = $btnInitial
				deletinfo()
				readinfor()
				MsgBox(0, "��ʾ", "�ָ�Ĭ�����óɹ�,��������", 5)
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
			Case $msg = $readLog
				GUICtrlSetData($edtLog, readdate())
			Case $msg = $deletLog
				Setdate()
				
				
		EndSelect
		
		$msg1 = TrayGetMsg()
		Select
			Case $msg1 = 0
				ContinueLoop
			Case $msg1 = $prefsitem
				MsgBox(64, "����:", "ϵͳ�汾:" & @OSVersion)
			Case $msg1 = $aboutitem
				MsgBox(64, "����:", "����2ר��KP�һ�����.QQ��1246035036")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui


Func saveinfor()


	;check
	$lenpath1 = GUICtrlRead($path1)
	$lenpath2 = GUICtrlRead($path2)
	
	$lenNamefr = GUICtrlRead($namelenfr)
	$lenNameto = GUICtrlRead($namelento)
	;$lenbhtime = GUICtrlRead($bhTime)
	$lenboxqty = GUICtrlRead($boxQty)
	$lenpicktiem = GUICtrlRead($picktime)
	$lenroundtime = GUICtrlRead($kproundtime)
	$lenstoptime = GUICtrlRead($ramstoptime)
	$lenroundclosetime = GUICtrlRead($kproundclosetime)
	$lenclosestoptime = GUICtrlRead($closestoptime)
	$lenexetile = GUICtrlRead($exetile)
	
	If $lenpath1 = "" Or $lenpath2 = "" Then
		MsgBox(0, "����", "�������ѡ����Ч�İ��ڳ���")
		Return False
	EndIf
	
	If $lenexetile = "" Then
		MsgBox(0, "����", "��������Ϸ���ڱ��⣬���� d2")
		Return False
	EndIf
	
	
	If $lenNamefr <= 0 Then
		MsgBox(0, "����", "���䳤������Ҫ��1λ�ɣ�")
		Return False
	EndIf
	If $lenNamefr > $lenNameto Then
		MsgBox(0, "����", "��ʼ���ȴ��ڽ��������ˣ�")
		Return False
	EndIf
	If $lenNameto > 10 Then
		MsgBox(0, "����", "û���˻Ὠ10λ���ϵķ����������������8λ���ڣ�")
		Return False
	EndIf
	If $lenboxqty <= 0 Or $lenboxqty >= 40 Then
		MsgBox(0, "����", "����ʣ���������������1 �� 39֮��,����5��10��֮��")
		Return False
	EndIf
	If $lenpicktiem <= 0 Or $lenpicktiem >= 20 Then
		MsgBox(0, "����", "��ȡ��Ʒ��������޲���Ϊ0,Ҳ��Ҫ����,����5��")
		Return False
	EndIf
	If $lenroundtime <= 0 Or $lenroundtime >= 20000 Then
		MsgBox(0, "����", "�涨��ͣ��kp��������Ϊ0,Ҳ�������޴�")
		Return False
	EndIf
	If $lenstoptime <= 0 Or $lenstoptime >= 20000 Then
		MsgBox(0, "����", "��ʱʱ�䲻��Ϊ0,Ҳ�������޴�")
		Return False
	EndIf
	If $lenroundclosetime <= 0 Or $lenroundclosetime >= 20000 Then
		MsgBox(0, "����", "�涨kp���ߵĴ�������С��0,Ҳ�������޴�")
		Return False
	EndIf
	If $lenclosestoptime <= 0 Or $lenclosestoptime >= 20000 Then
		MsgBox(0, "����", "���µȴ�ʱ�䲻��Ϊ0,Ҳ�������޴�")
		Return False
	EndIf

	
	$avGameMode[0] = $RadGame1
	$avGameMode[1] = $RadGame2
	
	$ImageMode[0] = $RadNormal
	$ImageMode[1] = $RadHigh
	
	$avKpMode[0] = $Radkpmod1
	$avKpMode[1] = $Radkpmod2
	$avKpMode[2] = $Radkpmod3
	$avKpMode[3] = $Radkpmod4
	
	$avArray[0] = $Radio1
	$avArray[1] = $Radio2

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
	$avArrayName[2] = $RDnameAd
	$avArrayName[3] = $RDnameGd

	$avMove[0] = $RadMove1
	$avMove[1] = $RadMove2

	$avArrayPath[0] = $RDpath1
	$avArrayPath[1] = $RDpath2
	$avArrayPath[2] = $RDpath3
	$avArrayPath[3] = $RDpath4
	$avArrayPath[4] = $RDpath5
	
	
	For $i = 0 To 1 Step 1 ;��Ϸģʽ
		If BitAND(GUICtrlRead($avGameMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guigamemode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;��ͼģʽ
		If BitAND(GUICtrlRead($ImageMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiImageMode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 3 Step 1 ;KPģʽ
		If BitAND(GUICtrlRead($avKpMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guikpmode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArray[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$fire = $i + 1
		EndIf
	Next
	
	For $i = 0 To 7 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayP[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$pos = $i + 1
		EndIf
	Next

	For $i = 0 To 3 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayName[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$nameCat = $i + 1
		EndIf
	Next
	
	For $i = 0 To 4 Step 1 ;write path
		If BitAND(GUICtrlRead($avArrayPath[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guipath = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;other when in
		If BitAND(GUICtrlRead($ArrayOtherWhen[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiotherwhen = $i + 1
		EndIf
	Next

	For $i = 0 To 1 Step 1 ;other in methord
		If BitAND(GUICtrlRead($Arrayothermetherd[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiothermetherd = $i + 1
		EndIf
	Next

	For $i = 0 To 1 Step 1 ;ת�Ƶ������ķ�ʽ��������ʣ����������Ǽ���̶�����
		If BitAND(GUICtrlRead($avMove[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiMoveBox = $i + 1
		EndIf
	Next
	

	If BitAND(GUICtrlRead($ckbBagfull), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$shutdown = 1
	Else
		$shutdown = 0
	EndIf
	
	If BitAND(GUICtrlRead($ckbRej), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkrej = 1
	Else
		$guidrinkrej = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRoledead), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckroledead = 1
	Else
		$ckroledead = 0
	EndIf
	If BitAND(GUICtrlRead($ckbAss), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckass = 1
	Else
		$ckass = 0
	EndIf
	If BitAND(GUICtrlRead($ckbQinse), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$sanctury = 1
	Else
		$sanctury = 0
	EndIf
	
	If BitAND(GUICtrlRead($ckbBoxing), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiboxing = 1
	Else
		$guiboxing = 0
	EndIf
	#CS 	If BitAND(GUICtrlRead($ckbHeal), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkheal = 1
		Else
		$guidrinkheal = 0
		EndIf
		If BitAND(GUICtrlRead($ckbMana), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkmana = 1
		Else
		$guidrinkmana = 0
		EndIf
	#CE
	If BitAND(GUICtrlRead($ckbTimeshut), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guisettime = 1
	Else
		$guisettime = 0
	EndIf
	If BitAND(GUICtrlRead($ckbAct5), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckact5 = 1
	Else
		$ckact5 = 0
	EndIf
		If BitAND(GUICtrlRead($ckbByRed), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckred = 1
	Else
		$ckred = 0
	EndIf
		If BitAND(GUICtrlRead($ckbByBlue), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckblue = 1
	Else
		$ckblue = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRamstop), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiramstop = 1
	Else
		$guiramstop = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRamclose), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiramclose = 1
	Else
		$guiramclose = 0
	EndIf
	If BitAND(GUICtrlRead($ckbothersin), $GUI_CHECKED) = $GUI_CHECKED Then ; other in room
		$guiothercheck = 1
	Else
		$guiothercheck = 0
	EndIf

	
	
	If BitAND(GUICtrlRead($ckbRanclosegame), $GUI_CHECKED) = $GUI_CHECKED Then ; �Ƿ�������Ϸ
		$guiclosegame = 1
	Else
		$guiclosegame = 0
	EndIf
	

	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ʺ�", GUICtrlRead($n1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", _StringToHex(GUICtrlRead($n2)))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", $fire)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "λ��", $pos)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ŀ��", GUICtrlRead($path1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʼλ��", GUICtrlRead($path2))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������", GUICtrlRead($path3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������", GUICtrlRead($exeparm3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڱ���", GUICtrlRead($exetile))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��Ϸģʽ", $guigamemode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "CPUģʽ", $guiImageMode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "kpģʽ", $guikpmode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�������Ϸ", $guiclosegame)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������Ϸ����", GUICtrlRead($txtranclosegame))
	
	;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʼλ��", $path22)
	;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������", $path32)
		
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�𷨴���", GUICtrlRead($cmbTpFire))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�𷨴����", GUICtrlRead($cmbFireFire))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��װ��", GUICtrlRead($cmbArmFire))
	
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", $shutdown)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������װ��", $guiboxing)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "װ�䷽ʽ", $guiMoveBox)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", GUICtrlRead($boxQty))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���������ʼװ��", GUICtrlRead($txtMoveRound))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", $nameCat)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������ǰ׺", GUICtrlRead($namepre))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�������̶�����", GUICtrlRead($namegd))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", $guidrinkrej)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", $ckroledead)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", $ckass)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������������", GUICtrlRead($namelenfr))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������������", GUICtrlRead($namelento))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�ʱ�ػ�", $guisettime)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʱ�ػ�ʱ��", GUICtrlRead($dtshut))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��Ʒѭ����ȡ����", GUICtrlRead($picktime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��繥������", GUICtrlRead($firelighttime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����ѡ��", GUICtrlRead($sldspeed))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���е���", GUICtrlRead($txtSpeed))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "ȥ����·��", $guipath)
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��Ӷ�����ӻ�", $sanctury)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT5", $ckact5)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ����ҩˮ", $ckred)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�����ҩˮ", $ckblue)
	
	;--������αװ���ܣ�������Ѱ棬�������
	If $testversion = 0 Then
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ������ʱ", $guiramstop)
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ��ʱ����", GUICtrlRead($kproundtime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͣʱ��", GUICtrlRead($ramstoptime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ��ѻ�", $guiramclose)
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ�ѻ�����", GUICtrlRead($kproundclosetime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ѻ�ʱ��", GUICtrlRead($closestoptime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", $guiothercheck)
		
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��1", GUICtrlRead($txtName1))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��2", GUICtrlRead($txtName2))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��3", GUICtrlRead($txtName3))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��4", GUICtrlRead($txtName4))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��5", GUICtrlRead($txtName5))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��6", GUICtrlRead($txtName6))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��7", GUICtrlRead($txtName7))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��8", GUICtrlRead($txtName8))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��9", GUICtrlRead($txtName9))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��10", GUICtrlRead($txtName10))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��11", GUICtrlRead($txtName11))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��12", GUICtrlRead($txtName12))
		
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�С��ͼ", GUICtrlRead($txtTab))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�����", GUICtrlRead($txtTeam))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�����", GUICtrlRead($txtBag))
		
	Else
		$guikpmode = 4
	EndIf
	;�����Ǽ�����kpģʽѡ��д��һЩ��Ҫ�Ĺ���
	Select
		Case $guikpmode = 1
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ǹ̶�����ѩ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������װ��", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT5", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ������ʱ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ��ʱ����", 26)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͣʱ��", 76)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ��ѻ�", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ�ѻ�����", 76)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ѻ�ʱ��", 23)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·�������ʱ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·����ʱ����", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ƽ���ʱ", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�������", 1)
			
			
			
		Case $guikpmode = 2
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ǹ̶�����ѩ", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������װ��", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT5", 0)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ������ʱ", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ��ʱ����", 31)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͣʱ��", 116)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ��ѻ�", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ�ѻ�����", 76)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ѻ�ʱ��", 23)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·�������ʱ", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·����ʱ����", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ƽ���ʱ", 0)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�������", 1)
		Case $guikpmode = 3
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������װ��", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT5", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ������ʱ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ��ʱ����", 23)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͣʱ��", 183)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ��ѻ�", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ�ѻ�����", 83)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ѻ�ʱ��", 37)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·�������ʱ", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���·����ʱ����", 15)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ƽ���ʱ", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�������", 1)
			
		Case $guikpmode = 4
			;�û��Զ��壬����ǿ�Ƹı�
	EndSelect


	Return True
EndFunc   ;==>saveinfor

Func readinfor()
	

	$usr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�ʺ�", "")
	$psd = _HexToString(IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "")) ;16����ת���ض�����
	$fire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "1")
	$pos = IniRead(@ScriptDir & "\" & $infofiles, "KP", "λ��", "1")
	$d2path1 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����Ŀ��", "")
	$d2path2 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʼλ��", "")
	$d2path3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������", "")
	$guiexeparm3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������", "")
	$guititle = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���ڱ���", "d")
	$guigamemode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��Ϸģʽ", "1")
	$guiImageMode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "CPUģʽ", "1")
	$guikpmode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "kpģʽ", "1")
	
	$guiclosegame = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�������Ϸ", "1")
	$guiclosegamesec = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������Ϸ����", "40")
	
	$guitpFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�𷨴���", "F1")
	$guifireFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�𷨴����", "F2")
	$guiarmFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��װ��", "F5")

	
	$shutdown = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", "1")
	$nameCat = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", "1")
	$guinamepre = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������ǰ׺", "mf")
	$guinamegd = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�������̶�����", "asd")
	$guidrinkrej = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", "1")
	$ckroledead = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", "1")
	$ckass = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", "1")
	;$guibhTime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "bh�ͷų���ʱ��", "")
	$guiboxing = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������װ��", "1")
	$guiMoveBox = IniRead(@ScriptDir & "\" & $infofiles, "KP", "װ�䷽ʽ", "2")
	$guiboxqty = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", "10")
	$guimoveround = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���������ʼװ��", "100")
	
	$guinamelenfr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������������", "1")
	$guinamelento = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������������", "5")
	$guisettime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�ʱ�ػ�", "")
	$guitimedata = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʱ�ػ�ʱ��", "")
	$guipicktime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��Ʒѭ����ȡ����", "6")
	$ckact5 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT5", "1")
	$ckred = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ����ҩˮ", "1")
	$ckblue = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�����ҩˮ", "1")
	$sanctury = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��Ӷ�����ӻ�", "")
	$guiramstop = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ������ʱ", "1")
	$guikpstoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ��ʱ����", "30")
	$guiramtime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ͣʱ��", "163")
	
	$guiramclose = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ��ѻ�", "1")
	$guiclosetime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�ﵽ�ѻ�����", "82")
	$guiclosestoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�ѻ�ʱ��", "37")
	
	$char_TAB = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�С��ͼ", "TAB")
	$char_Team = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�����", "P")
	$char_Bag = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ݼ�����", "B")
	
	$guiblztime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����ѩ��������", "3")
	$guifirelighttime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��繥������", "27")
	$guisldspeed = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����ѡ��", "1")
	$guiWalkspeedAdjust = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���е���", "0")
	$guipath = IniRead(@ScriptDir & "\" & $infofiles, "KP", "ȥ����·��", "3")

	$guiothercheck = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", "1")
	$guiotherwhen = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʱ���������", "1")
	$guiothermetherd = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������˴���ʽ", "1")
	$guiotherroundtrace = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����������������ٴ���", "1")
	$guiroundinterval = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�������ν�����ļ������", "8")
	$guiotherimage = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�������", "1")
	
	$guiavAlpName[0] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��1", "a")
	$guiavAlpName[1] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��2", "s")
	$guiavAlpName[2] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��3", "d")
	$guiavAlpName[3] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��4", "f")
	$guiavAlpName[4] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��5", "q")
	$guiavAlpName[5] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��6", "q")
	$guiavAlpName[6] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��7", "z")
	$guiavAlpName[7] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��8", "c")
	$guiavAlpName[8] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��9", "v")
	$guiavAlpName[9] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��10", "a")
	$guiavAlpName[10] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��11", "d")
	$guiavAlpName[11] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ĸ��12", "x")


	If $cheapversion = 1 Then ;������װ汾��������ת�ư�������
		GUICtrlSetState($ckbBagfull, $GUI_DISABLE)
		GUICtrlSetState($ckbBoxing, $GUI_DISABLE)
		$guiboxing = 0
		$shutdown = 0
	EndIf



	If $testversion = 1 Then ;������԰�
		;WinSetTitle($Form1_1_2_1, "", "PindleBox-��������һ�����ӭʹ����ʽ��")
		GUICtrlSetData($lblversion, "PindleBox-��Ѱ�")
		;ϵͳ
		GUICtrlSetState($ckbTimeshut, $GUI_DISABLE)
		GUICtrlSetState($sldspeed, $GUI_DISABLE)
		GUICtrlSetState($ckbRanclosegame, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod1, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod2, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod3, $GUI_DISABLE)
		GUICtrlSetState($RadHigh, $GUI_DISABLE)
		
		$guikpmode = 4
		$guisettime = 0
		$guisldspeed = 2
		$guiclosegame = 0
		$guiImageMode = 1 
		;---��ɫ
		;GUICtrlSetState($Radio2, $GUI_DISABLE)

		;-·��
		GUICtrlSetState($RDpath1, $GUI_DISABLE)
		GUICtrlSetState($RDpath2, $GUI_DISABLE)
		GUICtrlSetState($RDpath3, $GUI_DISABLE)
		
		
		;����
		GUICtrlSetState($grpName, $GUI_HIDE)
		GUICtrlSetState($txtName1, $GUI_HIDE)
		GUICtrlSetState($txtName2, $GUI_HIDE)
		GUICtrlSetState($txtName3, $GUI_HIDE)
		GUICtrlSetState($txtName4, $GUI_HIDE)
		GUICtrlSetState($txtName5, $GUI_HIDE)
		GUICtrlSetState($txtName6, $GUI_HIDE)
		GUICtrlSetState($txtName7, $GUI_HIDE)
		GUICtrlSetState($txtName8, $GUI_HIDE)
		GUICtrlSetState($txtName9, $GUI_HIDE)
		GUICtrlSetState($txtName10, $GUI_HIDE)
		GUICtrlSetState($txtName11, $GUI_HIDE)
		GUICtrlSetState($txtName12, $GUI_HIDE)
		
		GUICtrlSetState($RDnameAp, $GUI_DISABLE)
		GUICtrlSetState($RDnameAd, $GUI_DISABLE)
		GUICtrlSetState($RDnameGd, $GUI_DISABLE)
		GUICtrlSetState($namelenfr, $GUI_DISABLE)
		GUICtrlSetState($namelento, $GUI_DISABLE)
		GUICtrlSetState($namepre, $GUI_DISABLE)
		GUICtrlSetState($namegd, $GUI_DISABLE)
		
		GUICtrlSetState($RadMove1, $GUI_DISABLE)
		GUICtrlSetState($RadMove2, $GUI_DISABLE)
		GUICtrlSetState($boxQty, $GUI_DISABLE)
		GUICtrlSetState($txtMoveRound, $GUI_DISABLE)
		
		GUICtrlSetState($ckbBagfull, $GUI_DISABLE)
		GUICtrlSetState($ckbBoxing, $GUI_DISABLE)
		GUICtrlSetState($ckbRej, $GUI_DISABLE)
		GUICtrlSetState($ckbRoledead, $GUI_DISABLE)
		GUICtrlSetState($ckbAss, $GUI_DISABLE)
		GUICtrlSetState($ckbAct5, $GUI_DISABLE)
		GUICtrlSetState($ckbByRed, $GUI_DISABLE)
		GUICtrlSetState($ckbByBlue, $GUI_DISABLE)
		GUICtrlSetState($ckbQinse, $GUI_DISABLE)
		GUICtrlSetState($picktime, $GUI_DISABLE)
		
		
		$nameCat = 2
		$guinamelenfr = 1
		$guinamelento = 4
		$guinamepre = ""
		
		
		$shutdown = 0
		$guiboxing = 0
		$guidrinkrej = 0
		$ckroledead = 0
		$ckass = 0
		$ckact5 = 0
		$ckred = 0
		$ckblue = 0
		$guipicktime = 5
		
		;αװ
		GUICtrlSetState($ckbRamstop, $GUI_HIDE)
		GUICtrlSetState($ckbRamclose, $GUI_HIDE)
		GUICtrlSetState($kproundtime, $GUI_HIDE)
		GUICtrlSetState($ramstoptime, $GUI_HIDE)
		GUICtrlSetState($lblstop1, $GUI_HIDE)
		GUICtrlSetState($lblstop2, $GUI_HIDE)
		GUICtrlSetState($kproundclosetime, $GUI_HIDE)
		GUICtrlSetState($closestoptime, $GUI_HIDE)
		
		GUICtrlSetState($ckbothersin, $GUI_HIDE)
				
		GUICtrlSetState($grpKeybord, $GUI_HIDE)
		GUICtrlSetState($lblTab, $GUI_HIDE)
		GUICtrlSetState($lblTeam, $GUI_HIDE)
		GUICtrlSetState($lblBag, $GUI_HIDE)
		GUICtrlSetState($txtTab, $GUI_HIDE)
		GUICtrlSetState($txtTeam, $GUI_HIDE)
		GUICtrlSetState($txtBag, $GUI_HIDE)
		
		GUICtrlSetState($ckbNotfinddoor,$GUI_HIDE)
		GUICtrlSetState($ckbConnectError,$GUI_HIDE)
		GUICtrlSetState($Checkbox3,$GUI_HIDE)
		
		$guiramstop = 0
		$guiramclose = 0
		$guiothercheck = 0
		$guiotherroundtrace = 0
		$guiotherimage = 0
		
		
	EndIf
	
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	GUICtrlSetData($path1, $d2path1)
	GUICtrlSetData($path2, $d2path2)
	GUICtrlSetData($path3, $d2path3)
	GUICtrlSetData($exeparm3, $guiexeparm3)
	GUICtrlSetData($exetile, $guititle)
	GUICtrlSetData($txtranclosegame, $guiclosegamesec)
	

	GUICtrlSetData($cmbTpFire, $guitpFire) ;����
	GUICtrlSetData($cmbFireFire, $guifireFire) ;����
	GUICtrlSetData($cmbArmFire, $guiarmFire) ;����
	
	GUICtrlSetData($txtName1, $guiavAlpName[0]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName2, $guiavAlpName[1]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName3, $guiavAlpName[2]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName4, $guiavAlpName[3]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName5, $guiavAlpName[4]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName6, $guiavAlpName[5]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName7, $guiavAlpName[6]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName8, $guiavAlpName[7]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName9, $guiavAlpName[8]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName10, $guiavAlpName[9]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName11, $guiavAlpName[10]) ;�Զ�����ĸ��
	GUICtrlSetData($txtName12, $guiavAlpName[11]) ;�Զ�����ĸ��
	
	
	
	;GUICtrlSetData($bhTime, $guibhTime)
	GUICtrlSetData($boxQty, $guiboxqty)
	GUICtrlSetData($txtMoveRound, $guimoveround)
	
	GUICtrlSetData($namelenfr, $guinamelenfr)
	GUICtrlSetData($namelento, $guinamelento)
	GUICtrlSetData($dtshut, $guitimedata)
	GUICtrlSetData($picktime, $guipicktime)
	GUICtrlSetData($kproundtime, $guikpstoptime)
	GUICtrlSetData($sldspeed, $guisldspeed) ;����
	GUICtrlSetData($txtSpeed, $guiWalkspeedAdjust) ;����
	GUICtrlSetData($ramstoptime, $guiramtime)
	
	
	GUICtrlSetData($kproundclosetime, $guiclosetime)
	GUICtrlSetData($closestoptime, $guiclosestoptime)
	
	GUICtrlSetData($txtTab, $char_TAB) ; ��ݼ�
	GUICtrlSetData($txtTeam, $char_Team) ;��ݼ�
	GUICtrlSetData($txtBag, $char_Bag) ;��ݼ�
	
	GUICtrlSetData($firelighttime, $guifirelighttime)
	GUICtrlSetData($namepre, $guinamepre)
	GUICtrlSetData($namegd, $guinamegd)
	
	Select
		Case $guigamemode = 1
			GUICtrlSetState($RadGame1, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($RadGame2, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guiImageMode = 1
			GUICtrlSetState($RadNormal, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($RadHigh, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guikpmode = 1
			GUICtrlSetState($Radkpmod1, $GUI_CHECKED)
		Case $guikpmode = 2
			GUICtrlSetState($Radkpmod2, $GUI_CHECKED)
		Case $guikpmode = 3
			GUICtrlSetState($Radkpmod3, $GUI_CHECKED)
		Case $guikpmode = 4
			GUICtrlSetState($Radkpmod4, $GUI_CHECKED)
	EndSelect
	
	
	If $guiclosegame = 1 Then
		GUICtrlSetState($ckbRanclosegame, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRanclosegame, $GUI_UNCHECKED)
	EndIf
	
	
	Select
		Case $fire = 1
			GUICtrlSetState($Radio1, $GUI_CHECKED)
		Case $fire = 2
			GUICtrlSetState($Radio2, $GUI_CHECKED)
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
	
	Select
		Case $nameCat = 1
			GUICtrlSetState($RDnameAp, $GUI_CHECKED)
		Case $nameCat = 2
			GUICtrlSetState($RDnameMa, $GUI_CHECKED)
		Case $nameCat = 3
			GUICtrlSetState($RDnameAd, $GUI_CHECKED)
		Case $nameCat = 4
			GUICtrlSetState($RDnameGd, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guipath = 1
			GUICtrlSetState($RDpath1, $GUI_CHECKED)
		Case $guipath = 2
			GUICtrlSetState($RDpath2, $GUI_CHECKED)
		Case $guipath = 3
			GUICtrlSetState($RDpath3, $GUI_CHECKED)
		Case $guipath = 4
			GUICtrlSetState($RDpath4, $GUI_CHECKED)
		Case $guipath = 5
			GUICtrlSetState($RDpath5, $GUI_CHECKED)
			
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
	
	If $guiMoveBox = 1 Then
		GUICtrlSetState($RadMove1, $GUI_CHECKED)
	Else
		GUICtrlSetState($RadMove2, $GUI_CHECKED)
	EndIf
	
	
	If $guidrinkrej = 1 Then
		GUICtrlSetState($ckbRej, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRej, $GUI_UNCHECKED)
	EndIf
	
	If $ckroledead = 1 Then
		GUICtrlSetState($ckbRoledead, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRoledead, $GUI_UNCHECKED)
	EndIf
	If $ckass = 1 Then
		GUICtrlSetState($ckbAss, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbAss, $GUI_UNCHECKED)
	EndIf
	#CS 	If $guidrinkheal = 1 Then
		GUICtrlSetState($ckbHeal, $GUI_CHECKED)
		Else
		GUICtrlSetState($ckbHeal, $GUI_UNCHECKED)
		EndIf
		If $guidrinkmana = 1 Then
		GUICtrlSetState($ckbMana, $GUI_CHECKED)
		Else
		GUICtrlSetState($ckbMana, $GUI_UNCHECKED)
		EndIf
	#CE
	If $guisettime = 1 Then
		GUICtrlSetState($ckbTimeshut, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbTimeshut, $GUI_UNCHECKED)
	EndIf
	If $ckact5 = 1 Then
		GUICtrlSetState($ckbAct5, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbAct5, $GUI_UNCHECKED)
	EndIf
	If $ckred = 1 Then
		GUICtrlSetState($ckbByRed, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbByRed, $GUI_UNCHECKED)
	EndIf
	If $ckblue = 1 Then
		GUICtrlSetState($ckbByBlue, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbByBlue, $GUI_UNCHECKED)
	EndIf
	If $sanctury = 1 Then
		GUICtrlSetState($ckbQinse, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbQinse, $GUI_UNCHECKED)
	EndIf
	If $guiramstop = 1 Then
		GUICtrlSetState($ckbRamstop, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRamstop, $GUI_UNCHECKED)
	EndIf
	If $guiramclose = 1 Then
		GUICtrlSetState($ckbRamclose, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRamclose, $GUI_UNCHECKED)
	EndIf
	If $guiothercheck = 1 Then ;����������Ƿ����
		GUICtrlSetState($ckbothersin, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbothersin, $GUI_UNCHECKED)
	EndIf
	


	GUICtrlSetData($edtRemark, readremark()) ;��ȡtxt�еı�ע ,���������󣬷���Ӱ�����ʱ��
EndFunc   ;==>readinfor

Func Readdate()
	Local $txt, $temp
	$temp = FileOpen($Files, 0)
	$txt = FileRead($temp)
	FileClose($temp)
	Return $txt
EndFunc   ;==>Readdate

Func Setdate()
	Local $txt, $temp
	$temp = FileOpen($Files, 2)
	$txt = GUICtrlRead($edtLog)
	FileDelete($temp)
	;FileWrite($temp,$txt)
	FileClose($temp)
	GUICtrlSetData($edtLog, readdate())
	
EndFunc   ;==>Setdate


Func readremark()
	Local $txt, $temp
	$temp = FileOpen($remark, 0)
	$txt = FileRead($temp)
	FileClose($temp)
	Return $txt
EndFunc   ;==>readremark


Func deletinfo()
	FileDelete(@ScriptDir & "\" & $infofiles)
	FileClose(@ScriptDir & "\" & $infofiles)

	
EndFunc   ;==>deletinfo
