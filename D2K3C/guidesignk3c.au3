
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
Global $usr, $psd, $fire, $guitp , $cta, $d2path1, $d2path2, $d2path3, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5, $guinamepre,$guinameNoChange
Global $pos, $guibhTime, $guiboxing, $guiboxqty, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime, $guipath
Global $guiramclose, $guiclosetime, $guiclosestoptime
Global $guiothercheck, $guiotherwhen, $guiothermetherd, $guiotherroundtrace, $guiroundinterval ;������˽��룬��ʱ��飬��鵽�Ĵ���������鵽�������ٵĴ��� ,�涨���ν�����ļ������
Global $guishopwater ;�Ƿ������
Global $guifiremothord ;3c���Ĺ�����ʽ
Global $guiotherimage
Global $guirepair, $guirepairRound ;����װ��
Global $guiatBh, $guiatNA, $guiatVIG, $guiatCON, $guiatSHD, $guiatTP;���ܿ�ݼ�
Global $guititle, $guiexeparm3, $guigamemode ;���⣬��������,��Ϸģʽ

Local $avGameMode[2] ;��Ϸģʽ����������ս��
Local $avArray[2], $avArrayP[8], $avArrayName[4], $avArrayPath[2], $ArrayOtherWhen[2], $Arrayothermetherd[2], $ArrayFiremethord[2]




#Region ### START Koda GUI section ### Form=c:\guo\other\d2src\d2k3c\newk3c.kxf
$Form1_1_2_1 = GUICreate("", 523, 576, 262, 146)
$Tab1 = GUICtrlCreateTab(8, 8, 497, 545)
$TabSheet1 = GUICtrlCreateTabItem("ϵͳ")
$YesID = GUICtrlCreateButton("����", 404, 465, 75, 25)
$SaveID = GUICtrlCreateButton("����", 148, 465, 75, 25)
$ExitID = GUICtrlCreateButton("�˳�", 284, 465, 75, 25)
$Label18 = GUICtrlCreateLabel("�������� F9 ����/��ͣ, F10 �˳�", 280, 512, 174, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group6 = GUICtrlCreateGroup("��Ϸģʽ", 12, 224, 481, 49)
$RadGame1 = GUICtrlCreateRadio("ս��ģʽ", 80, 244, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadGame2 = GUICtrlCreateRadio("����ģʽ", 256, 244, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group12 = GUICtrlCreateGroup("�ⲿ����", 12, 280, 481, 129)
$ckbTimeshut = GUICtrlCreateCheckbox("��ʱ�ػ�:", 20, 304, 73, 17)
$dtshut = GUICtrlCreateDate("2017/07/24 12:13:43", 100, 304, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))

	GUICtrlSendMsg(-1, 0x1005, 0, "yyyy/MM/dd HH:mm:ss") ; DTM_SETFORMAT

GUICtrlCreateGroup("", -99, -99, 1, 1)
$btnInitial = GUICtrlCreateButton("�ָ�Ĭ��", 24, 465, 67, 25)
$Group7 = GUICtrlCreateGroup("��Ϸ·��", 12, 32, 481, 185)
$path1 = GUICtrlCreateInput("e:\�����ƻ���ii����֮��\d2loader.exe -w -lq -direct -title d2", 104, 56, 321, 21, BitOR($GUI_SS_DEFAULT_INPUT,$WS_BORDER), BitOR($WS_EX_CLIENTEDGE,$WS_EX_STATICEDGE))
$Label16 = GUICtrlCreateLabel("����Ŀ��:", 24, 56, 55, 17)
$Label17 = GUICtrlCreateLabel("��ʼλ�ã�", 24, 80, 64, 17)
$path2 = GUICtrlCreateInput("E:\�����ƻ���II����֮��", 104, 80, 289, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label28 = GUICtrlCreateLabel("�������ƣ�", 24, 104, 64, 17)
$path3 = GUICtrlCreateInput(".exe", 104, 104, 225, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$btnPath = GUICtrlCreateButton("���", 432, 56, 43, 25)
$Label8 = GUICtrlCreateLabel("����������", 24, 152, 64, 17)
$ckbexeparm1 = GUICtrlCreateCheckbox("-W", 104, 152, 33, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label9 = GUICtrlCreateLabel("���ڱ��⣺", 24, 128, 64, 17)
$exetile = GUICtrlCreateInput("exetile", 104, 128, 97, 21)
$Label10 = GUICtrlCreateLabel("�����  abc  ", 216, 128, 82, 17)
$Label11 = GUICtrlCreateLabel("��������:", 24, 176, 55, 17)
$exeparm3 = GUICtrlCreateInput("-ns", 104, 176, 209, 21)
$Label12 = GUICtrlCreateLabel("(�ɲ���) ", 328, 176, 49, 17)
$ckbexeparm2 = GUICtrlCreateCheckbox("-direct", 152, 152, 73, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("��ɫ")
$Group1 = GUICtrlCreateGroup("�ʺ���Ϣ", 12, 33, 209, 113)
$Label1 = GUICtrlCreateLabel("վ���ʺ�", 20, 57, 52, 17)
$Label2 = GUICtrlCreateLabel("վ������", 20, 89, 52, 17)
$n1 = GUICtrlCreateInput("", 76, 57, 89, 21)
$n2 = GUICtrlCreateInput("", 76, 89, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("��ɫλ��", 232, 33, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 240, 49, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 240, 73, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 240, 97, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 240, 121, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 312, 49, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 312, 73, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 312, 97, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 312, 121, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("��ɫ��������", 12, 148, 422, 225)
$Radio1 = GUICtrlCreateRadio("Bh Pal ", 28, 164, 57, 17)
$Ckbcta = GUICtrlCreateCheckbox("����Я��ս���ٻ� F7-ս��ָ��,F8-ս������ ", 48, 296, 305, 17)
$Radio2 = GUICtrlCreateRadio("ר�ö��Ƽ���", 28, 274, 121, 17)
$Label3 = GUICtrlCreateLabel("BH:", 96, 168, 22, 17)
$cmbBH = GUICtrlCreateCombo("", 120, 168, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label4 = GUICtrlCreateLabel("��ͨ����:", 176, 168, 55, 17)
$cmbNA = GUICtrlCreateCombo("", 240, 168, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F2")
$Label5 = GUICtrlCreateLabel("����:", 304, 168, 31, 17)
$cmbVIG = GUICtrlCreateCombo("", 352, 168, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label6 = GUICtrlCreateLabel("רע:", 176, 200, 31, 17)
$cmbCON = GUICtrlCreateCombo("", 240, 200, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label7 = GUICtrlCreateLabel("ʥ��:", 304, 200, 31, 17)
$cmbSHD = GUICtrlCreateCombo("", 352, 200, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label13 = GUICtrlCreateLabel("TP:", 176, 240, 21, 17)
$cmbTP = GUICtrlCreateCombo("", 240, 240, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$ckbTp = GUICtrlCreateCheckbox("��TP��", 48, 240, 97, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("��ַ�ʽ", 12, 388, 217, 81)
$rdAttack1 = GUICtrlCreateRadio("�����ͷż��ܹ涨����:", 24, 412, 153, 17)
$rdAttack2 = GUICtrlCreateRadio("��Χ�ҹֹ���", 24, 436, 89, 17)
$blztime = GUICtrlCreateInput("3", 184, 412, 33, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet4 = GUICtrlCreateTabItem("·��")
$Group11 = GUICtrlCreateGroup("ȥ����·��", 16, 44, 244, 89)
$RDpath1 = GUICtrlCreateRadio("���·��", 24, 68, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDpath2 = GUICtrlCreateRadio("ר�ö���·��", 24, 92, 89, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet5 = GUICtrlCreateTabItem("����")
$Group9 = GUICtrlCreateGroup("����������", 12, 33, 329, 129)
$RDnameAp = GUICtrlCreateRadio("��ĸ������", 28, 49, 81, 17)
$RDnameMa = GUICtrlCreateRadio("���ַ�����", 28, 73, 81, 17)
$namelenfr = GUICtrlCreateInput("3", 164, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("��", 196, 65, 16, 17)
$namelento = GUICtrlCreateInput("6", 220, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("λ", 252, 65, 16, 17)
$Label23 = GUICtrlCreateLabel("����:", 124, 65, 31, 17)
$Label27 = GUICtrlCreateLabel("����ǰ׺:", 124, 97, 55, 17)
$namepre = GUICtrlCreateInput("aa", 196, 97, 41, 21)
$RDnameAd = GUICtrlCreateRadio("��������1 :", 28, 97, 89, 17)
$RDnameNoChange = GUICtrlCreateRadio("�̶����� :", 28, 121, 89, 17)
$nameNoChange = GUICtrlCreateInput("aa", 124, 121, 41, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group8 = GUICtrlCreateGroup("��������", 12, 176, 329, 342)
$ckbBagfull = GUICtrlCreateCheckbox("������ػ�", 28, 192, 97, 17)
$ckbRej = GUICtrlCreateCheckbox("��ȥ������ƿ", 28, 236, 121, 17)
$ckbRoledead = GUICtrlCreateCheckbox("�����ɫ", 28, 320, 97, 17)
$ckbAss = GUICtrlCreateCheckbox("�����Ӷ��", 28, 340, 89, 17)
$ckbBoxing = GUICtrlCreateCheckbox("�������Ƿ�ת�Ƶ��ֿ�", 28, 212, 137, 17)
$boxQty = GUICtrlCreateInput("8", 276, 208, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label20 = GUICtrlCreateLabel("���ڴ˸���ִ��", 180, 208, 88, 17)
$ckbAct5 = GUICtrlCreateCheckbox("����Ƿ���ACT3", 28, 360, 145, 17)
$ckbHeal = GUICtrlCreateCheckbox("��ȥ�����ƿ", 28, 256, 137, 17)
$ckbMana = GUICtrlCreateCheckbox("��ȥ������ƿ", 28, 276, 129, 17)
$ckbShopWater = GUICtrlCreateCheckbox("�̵������", 28, 296, 89, 17)
$Label24 = GUICtrlCreateLabel("�����Ʒ��ȡ����:", 32, 423, 103, 17)
$picktime = GUICtrlCreateInput("5", 160, 423, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbRepair = GUICtrlCreateCheckbox("����װ���������:", 28, 384, 121, 17)
$repairRound = GUICtrlCreateInput("100", 160, 384, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet6 = GUICtrlCreateTabItem("αװ")
$Group10 = GUICtrlCreateGroup("��BOT�������", 12, 40, 385, 129)
$ckbRamstop = GUICtrlCreateCheckbox("�ﵽ������ͣ����", 20, 72, 113, 17)
$Label19 = GUICtrlCreateLabel("K3C����:", 148, 71, 51, 17)
$kproundtime = GUICtrlCreateInput("30", 212, 71, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label25 = GUICtrlCreateLabel("��ͣ����:", 244, 71, 55, 17)
$ramstoptime = GUICtrlCreateInput("3600", 316, 71, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbRamclose = GUICtrlCreateCheckbox("�涨�����Զ�����", 20, 96, 121, 17)
$kproundclosetime = GUICtrlCreateInput("50", 148, 96, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label29 = GUICtrlCreateLabel("����ͣ������", 212, 98, 76, 17)
$closestoptime = GUICtrlCreateInput("20", 316, 96, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbothersin = GUICtrlCreateCheckbox("������˽��뷿��", 20, 128, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet7 = GUICtrlCreateTabItem("��־")
$edtLog = GUICtrlCreateEdit("", 16, 40, 481, 401)
$readLog = GUICtrlCreateButton("��ȡ", 88, 472, 75, 25)
$deletLog = GUICtrlCreateButton("���", 400, 472, 75, 25)
$TabSheet8 = GUICtrlCreateTabItem("˵��")
$edtRemark = GUICtrlCreateEdit("", 16, 40, 481, 457)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [350, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "�������κ����ݰ�,�ܿ�Warden������,������Źһ�ʱ��", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036", 1)
$lblversion = GUICtrlCreateLabel("�һ�����K3C-��ʽ��  ", 350, 10, 117, 17)
 

 
;---���Ϸ�ͼ�ν������

TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("����")
TrayCreateItem("")
$aboutitem = TrayCreateItem("����")
TrayCreateItem("")
$exititem = TrayCreateItem("�˳�")

;GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

$mainform = WinGetHandle($Form1_1_2_1)
Func creatGui()
	TraySetState()
	GUISetState(@SW_SHOW, $mainform)
	;WinMove("����2-K3C�һ���-��ʽ��", "", 20, 20)
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
					MsgBox(0, "��ʾ", "����ɹ�����ر����´򿪲鿴")
				EndIf
			Case $msg = $YesID
				If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 1
				ElseIf BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 4
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
				MsgBox(64, "����:", "����2ר��K3C�һ�����.")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui


Func saveinfor()

	$lenpath1 = GUICtrlRead($path1)
	$lenpath2 = GUICtrlRead($path2)
	$lenexetile = GUICtrlRead($exetile)
	;check
	$lenNamefr = GUICtrlRead($namelenfr)
	$lenNameto = GUICtrlRead($namelento)
	;$lenbhtime = GUICtrlRead($bhTime)
	$lenboxqty = GUICtrlRead($boxQty)
	$lenpicktiem = GUICtrlRead($picktime)
	$lenroundtime = GUICtrlRead($kproundtime)
	$lenstoptime = GUICtrlRead($ramstoptime)
	$lenblztime = GUICtrlRead($blztime)
	$lenroundclosetime = GUICtrlRead($kproundclosetime)
	$lenclosestoptime = GUICtrlRead($closestoptime)
	
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
	If $lenpicktiem <= 0 Or $lenpicktiem >= 30 Then
		MsgBox(0, "����", "�Ҷ����Ĵ�������Ϊ0,Ҳ��Ҫ����,����5��")
		Return False
	EndIf
	If $lenroundtime <= 0 Or $lenroundtime >= 20000 Then
		MsgBox(0, "����", "kp��������Ϊ0,Ҳ�������޴�")
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
	
	If $lenblztime <= 0 Or $lenblztime >= 60 Then
		MsgBox(0, "����", "BH�Ĺ���ʱ�䷶Χ��0-60��֮�䣬����20������")
		Return False
	EndIf
	
	$a1 = GUICtrlRead($cmbBH)
	$a2 = GUICtrlRead($cmbNA)
	$a3 = GUICtrlRead($cmbVIG)
	$a4 = GUICtrlRead($cmbCON)
	$a5 = GUICtrlRead($cmbSHD)
	
	If $a1 = $a2 Or $a1 = $a3 Or $a1 = $a4 Or $a1 = $a5 Or $a2 = $a3 Or $a2 = $a4 Or $a2 = $a5 Or $a3 = $a4 Or $a3 = $a5 Or $a4 = $a5 Then
		MsgBox(0, "����", "��������ͬ�Ŀ�ݼ�����������Ϸ�Ŀ������һ��")
		Return False
	EndIf
	
	$avGameMode[0] = $RadGame1
	$avGameMode[1] = $RadGame2
	
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
	$avArrayName[3] = $RDnameNoChange

	$avArrayPath[0] = $RDpath1
	$avArrayPath[1] = $RDpath2

	
	
	$ArrayFiremethord[0] = $rdAttack1
	$ArrayFiremethord[1] = $rdAttack2
	
	For $i = 0 To 1 Step 1 ;write cati
		If BitAND(GUICtrlRead($avGameMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guigamemode = $i + 1
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
	
	For $i = 0 To 1 Step 1 ;write path
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
	
	If BitAND(GUICtrlRead($ckbTp), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guitp = 1
	Else
		$guitp  = 0
	EndIf

	If BitAND(GUICtrlRead($Ckbcta), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$cta = 1
	Else
		$cta = 0
	EndIf

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
	If BitAND(GUICtrlRead($ckbHeal), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkheal = 1
	Else
		$guidrinkheal = 0
	EndIf
	If BitAND(GUICtrlRead($ckbMana), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkmana = 1
	Else
		$guidrinkmana = 0
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

	
	If BitAND(GUICtrlRead($ckbShopWater), $GUI_CHECKED) = $GUI_CHECKED Then ; �Ƿ������
		$guishopwater = 1
	Else
		$guishopwater = 0
	EndIf
	
	For $i = 0 To 1 Step 1 ;bh�Ĺ�����ʽ
		If BitAND(GUICtrlRead($ArrayFiremethord[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guifiremothord = $i + 1
		EndIf
	Next
	
	
	If BitAND(GUICtrlRead($ckbRepair), $GUI_CHECKED) = $GUI_CHECKED Then ; �Ƿ񱣴�İ����ͼ��
		$guirepair = 1
	Else
		$guirepair = 0
	EndIf
	
	
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�ʺ�", GUICtrlRead($n1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", _StringToHex(GUICtrlRead($n2)))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "cta", $cta)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", $fire)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "λ��", $pos)

	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ŀ��", GUICtrlRead($path1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʼλ��", GUICtrlRead($path2))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������", GUICtrlRead($path3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������", GUICtrlRead($exeparm3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڱ���", GUICtrlRead($exetile))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��Ϸģʽ", $guigamemode)
	
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", $shutdown)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������װ��", $guiboxing)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", GUICtrlRead($boxQty))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", $nameCat)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������ǰ׺", GUICtrlRead($namepre))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�̶�����", GUICtrlRead($nameNoChange))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", $guidrinkrej)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ�����ƿ", $guidrinkheal)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", $guidrinkmana)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�̵������", $guishopwater)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", $ckroledead)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", $ckass)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "bh�ͷų���ʱ��", GUICtrlRead($blztime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������������", GUICtrlRead($namelenfr))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������������", GUICtrlRead($namelento))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�ʱ�ػ�", $guisettime)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʱ�ػ�ʱ��", GUICtrlRead($dtshut))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��Ʒѭ����ȡ����", GUICtrlRead($picktime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT3", $ckact5)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�涨��������¼�", $guiramstop)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "kp����", GUICtrlRead($kproundtime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͣ����", GUICtrlRead($ramstoptime))

	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�涨�����ѻ�", $guiramclose)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "�涨�ѻ�����", GUICtrlRead($kproundclosetime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "������ͣ����", GUICtrlRead($closestoptime))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "ȥ����·��", $guipath)
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", $guiothercheck)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ʱ���������", $guiotherwhen)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��������˴���ʽ", $guiothermetherd)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����������������ٴ���", $guiotherroundtrace)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "3C��������ʽ", $guifiremothord)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����İ����ͼ��", $guiotherimage)
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����װ��", $guirepair)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����װ���������", GUICtrlRead($repairRound))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "ף��֮��", GUICtrlRead($cmbBH))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "��ͨ����", GUICtrlRead($cmbNA))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", GUICtrlRead($cmbVIG))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "רע", GUICtrlRead($cmbCON))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "ʥ��", GUICtrlRead($cmbSHD))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "����", GUICtrlRead($cmbTP))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "���ô���", $guitp)
	Return True
EndFunc   ;==>saveinfor

Func readinfor()
	GUICtrlSetData($edtRemark, readremark()) ;��ȡtxt�еı�ע
	
	$usr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�ʺ�", "")
	$psd = _HexToString(IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "")) ;16����ת���ض�����
	$fire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "1")
	$pos = IniRead(@ScriptDir & "\" & $infofiles, "KP", "λ��", "1")
	$cta = IniRead(@ScriptDir & "\" & $infofiles, "KP", "cta", "")
	$d2path1 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����Ŀ��", "")
	$d2path2 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʼλ��", "")
	$d2path3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������", "")
	$guiexeparm3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������", "")
	$guititle = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���ڱ���", "d")
	$guigamemode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��Ϸģʽ", "1")
	
	
	
	$shutdown = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������ػ�", "1")
	$nameCat = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������ʽ", "1")
	$guinamepre = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������ǰ׺", "")
	$guinameNoChange= IniRead(@ScriptDir & "\" & $infofiles, "KP", "�̶�����", "")
	$guidrinkrej = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", "1")
	$guidrinkheal = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ȥ�����ƿ", "1")
	$guidrinkmana = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ȥ������ƿ", "1")
	$guishopwater = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�̵������", "1")
	
	$ckroledead = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�����ɫ", "1")
	$ckass = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�����Ӷ��", "")
	$guibhTime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "bh�ͷų���ʱ��", "16")
	$guiboxing = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������װ��", "1")
	$guiboxqty = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���ڸ�����ʼװ��", "6")
	$guinamelenfr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������������", "1")
	$guinamelento = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������������", "4")
	$guisettime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�Ƿ�ʱ�ػ�", "")
	$guitimedata = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʱ�ػ�ʱ��", "")
	$guipicktime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��Ʒѭ����ȡ����", "15")
	$ckact5 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����Ƿ���ACT3", "1")
	$guiramstop = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�涨��������¼�", "1")
	$guikpstoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "kp����", "20")
	$guiramtime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ͣ����", "100")
	
	$guiramclose = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�涨�����ѻ�", "1")
	$guiclosetime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�涨�ѻ�����", "35")
	$guiclosestoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "������ͣ����", "21")
	
	$guiblztime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����ѩ��������", "")
	$guipath = IniRead(@ScriptDir & "\" & $infofiles, "KP", "ȥ����·��", "1")

	$guiothercheck = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������˽���", "1")
	$guiotherwhen = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ʱ���������", "1")
	$guiothermetherd = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��������˴���ʽ", "1")
	$guiotherroundtrace = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����������������ٴ���", "1")
	$guiroundinterval = IniRead(@ScriptDir & "\" & $infofiles, "KP", "�������ν�����ļ������", "8")
	$guifiremothord = IniRead(@ScriptDir & "\" & $infofiles, "KP", "3C��������ʽ", "2")
	$guiotherimage = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����İ����ͼ��", "1")
	
	$guirepair = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����װ��", "")
	$guirepairRound = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����װ���������", "20")

	$guiatBh = IniRead(@ScriptDir & "\" & $infofiles, "KP", "ף��֮��", "F1")
	$guiatNA = IniRead(@ScriptDir & "\" & $infofiles, "KP", "��ͨ����", "F2")
	$guiatVIG = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "F3")
	$guiatCON = IniRead(@ScriptDir & "\" & $infofiles, "KP", "רע", "F4")
	$guiatSHD = IniRead(@ScriptDir & "\" & $infofiles, "KP", "ʥ��", "F5")
	$guiatTP = IniRead(@ScriptDir & "\" & $infofiles, "KP", "����", "F6")
	$guitp = IniRead(@ScriptDir & "\" & $infofiles, "KP", "���ô���", "0")
	
	If $testversion = 1 Then ;������԰�
		WinSetTitle($Form1_1_2_1, "", "���Ĺҹһ�")
		GUICtrlSetData($lblversion, "�һ�����K3C-��Ѱ� ")
		;ϵͳ
		GUICtrlSetState($ckbTimeshut, $GUI_DISABLE)
		;GUICtrlSetState($sldspeed,$GUI_DISABLE)
		$guisettime = 0
		$guisldspeed = 2
		;---��ɫ
		;GUICtrlSetState($Radio2, $GUI_DISABLE)
		;GUICtrlSetState($Radio3, $GUI_DISABLE)
		;GUICtrlSetState($Radio4, $GUI_DISABLE)
		;GUICtrlSetState($blztime, $GUI_DISABLE)
		;GUICtrlSetState($Ckbcta, $GUI_DISABLE)
		;GUICtrlSetState($rdAttack1, $GUI_CHECKED)
		;GUICtrlSetState($rdAttack2, $GUI_UNCHECKED)
		GUICtrlSetState($rdAttack2, $GUI_DISABLE)
		;$cta = 0
		$fire = 1
		;$guiblztime = 4
		$guifiremothord = 1

		
		;-·��

		
		;����
		GUICtrlSetState($RDnameAp, $GUI_DISABLE)
		GUICtrlSetState($RDnameAd, $GUI_DISABLE)
		GUICtrlSetState($RDnameNoChange, $GUI_DISABLE)
		GUICtrlSetState($namelenfr, $GUI_DISABLE)
		GUICtrlSetState($namelento, $GUI_DISABLE)
		GUICtrlSetState($namepre, $GUI_DISABLE)
		GUICtrlSetState($nameNoChange, $GUI_DISABLE)
		
		GUICtrlSetState($boxQty, $GUI_DISABLE)
		GUICtrlSetState($ckbBagfull, $GUI_DISABLE)
		GUICtrlSetState($ckbBoxing, $GUI_DISABLE)
		GUICtrlSetState($ckbRej, $GUI_DISABLE)
		GUICtrlSetState($ckbRoledead, $GUI_DISABLE)
		GUICtrlSetState($ckbAss, $GUI_DISABLE)
		GUICtrlSetState($ckbAct5, $GUI_DISABLE)
		;GUICtrlSetState($ckbQinse, $GUI_DISABLE)
		GUICtrlSetState($picktime, $GUI_DISABLE)
		
		GUICtrlSetState($ckbHeal, $GUI_DISABLE)
		GUICtrlSetState($ckbMana, $GUI_DISABLE)
		GUICtrlSetState($ckbShopWater, $GUI_DISABLE)
		GUICtrlSetState($ckbRepair, $GUI_DISABLE)
		GUICtrlSetState($repairRound, $GUI_DISABLE)
		
		
		$nameCat = 2
		$guinamelenfr = 2
		$guinamelento = 5
		$guinamepre = ""
		$guinameNoChange =""
		
		
		$shutdown = 0
		$guiboxing = 0
		$guidrinkrej = 0
		$ckroledead = 0
		$ckass = 0
		$ckact5 = 0
		$guipicktime = 15
		$guishopwater = 0
		$guidrinkheal = 0
		$guidrinkmana = 0
		$guirepair = 0
		;αװ
		GUICtrlSetState($ckbRamstop, $GUI_DISABLE)
		GUICtrlSetState($ckbRamclose, $GUI_DISABLE)
		GUICtrlSetState($kproundtime, $GUI_DISABLE)
		GUICtrlSetState($ramstoptime, $GUI_HIDE)
		;GUICtrlSetState($lblstop1, $GUI_HIDE)
		;GUICtrlSetState($lblstop2, $GUI_HIDE)
		GUICtrlSetState($kproundclosetime, $GUI_HIDE)
		GUICtrlSetState($closestoptime, $GUI_HIDE)
		
		GUICtrlSetState($ckbothersin, $GUI_DISABLE)

		
		GUICtrlSetState($ckbRamclose, $GUI_HIDE)
		GUICtrlSetState($Label29, $GUI_HIDE)
		
		
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
	
	GUICtrlSetData($blztime, $guibhTime)
	GUICtrlSetData($boxQty, $guiboxqty)
	GUICtrlSetData($namelenfr, $guinamelenfr)
	GUICtrlSetData($namelento, $guinamelento)
	GUICtrlSetData($dtshut, $guitimedata)
	GUICtrlSetData($picktime, $guipicktime)
	GUICtrlSetData($kproundtime, $guikpstoptime)
	GUICtrlSetData($ramstoptime, $guiramtime)
	GUICtrlSetData($kproundclosetime, $guiclosetime)
	GUICtrlSetData($closestoptime, $guiclosestoptime)
	
	GUICtrlSetData($namepre, $guinamepre)
	GUICtrlSetData($nameNoChange, $guinameNoChange)
	
	GUICtrlSetData($repairRound, $guirepairRound)
	
	GUICtrlSetData($cmbBH, $guiatBh) ;����
	GUICtrlSetData($cmbNA, $guiatNA) ;����
	GUICtrlSetData($cmbVIG, $guiatVIG) ;����
	GUICtrlSetData($cmbCON, $guiatCON) ;����
	GUICtrlSetData($cmbSHD, $guiatSHD) ;����
	GUICtrlSetData($cmbTP, $guiatTP) ;����
	Select
		Case $guigamemode = 1
			GUICtrlSetState($RadGame1, $GUI_CHECKED)

		Case Else
			GUICtrlSetState($RadGame2, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $fire = 1
			GUICtrlSetState($Radio1, $GUI_CHECKED)
		Case Else
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
		Case Else
			GUICtrlSetState($RDnameNoChange, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guipath = 1
			GUICtrlSetState($RDpath1, $GUI_CHECKED)
		Case $guipath = 2
			GUICtrlSetState($RDpath2, $GUI_CHECKED)
	EndSelect
	


	
	If $guitp = 1 Then
		GUICtrlSetState($ckbTp, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbTp, $GUI_UNCHECKED)
	EndIf	
	
	If $cta = 1 Then
		GUICtrlSetState($Ckbcta, $GUI_CHECKED)
	Else
		GUICtrlSetState($Ckbcta, $GUI_UNCHECKED)
	EndIf
	
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
	If $guidrinkheal = 1 Then
		GUICtrlSetState($ckbHeal, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbHeal, $GUI_UNCHECKED)
	EndIf
	If $guidrinkmana = 1 Then
		GUICtrlSetState($ckbMana, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbMana, $GUI_UNCHECKED)
	EndIf
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
	
	
	If $guishopwater = 1 Then ;�̵������
		GUICtrlSetState($ckbShopWater, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbShopWater, $GUI_UNCHECKED)
	EndIf
	
	Select ;3c��������ʽ
		Case $guifiremothord = 1
			GUICtrlSetState($rdAttack1, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($rdAttack2, $GUI_CHECKED)
	EndSelect
	
	
	If $guirepair = 1 Then ;����װ��
		GUICtrlSetState($ckbRepair, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRepair, $GUI_UNCHECKED)
	EndIf
	
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
