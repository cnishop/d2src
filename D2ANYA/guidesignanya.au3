
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
Global $usr, $psd, $fire, $cta, $d2path1, $d2path2, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5
Global $pos, $guibhTime, $guiboxing, $guiboxqty, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime
Local $avArray[3], $avArrayP[8], $avArrayName[2]
Global $guiothercheck, $guistaymin
Global $Files = "system.log"   ;��־��¼

#Region ### START Koda GUI section ### Form=d:\autoit3\examples\guo\d2anya\anya.kxf
$Form1_1_2_1 = GUICreate("����2-�һ���-shop�̵��", 641, 556, 192, 124)
$Tab1 = GUICtrlCreateTab(8, 8, 625, 521)
$TabSheet1 = GUICtrlCreateTabItem("ϵͳ����")
$Group1 = GUICtrlCreateGroup("�ʺ���Ϣ(�ɲ�����,�����ѵ�½ս��)", 20, 33, 225, 113)
$Label1 = GUICtrlCreateLabel("վ���ʺ�", 28, 57, 52, 17)
$Label2 = GUICtrlCreateLabel("վ������", 28, 89, 52, 17)
$n1 = GUICtrlCreateInput("", 84, 49, 89, 21)
$n2 = GUICtrlCreateInput("", 84, 81, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("��ɫλ��", 252, 33, 161, 113)
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
$YesID = GUICtrlCreateButton("����", 396, 441, 75, 25)
$Group7 = GUICtrlCreateGroup("����·��(����һ���Ϸ��ݷ�ʽ���)", 20, 280, 593, 89)
$path1 = GUICtrlCreateInput("E:\�����ƻ���II����֮��\D2loader.exe -w -lq -direct -title d2", 112, 304, 473, 21)
$Label16 = GUICtrlCreateLabel("����Ŀ��:", 32, 304, 55, 17)
$Label17 = GUICtrlCreateLabel("��ʼλ�ã�", 32, 336, 64, 17)
$path2 = GUICtrlCreateInput("E:\�����ƻ���II����֮��", 112, 336, 289, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$SaveID = GUICtrlCreateButton("����", 108, 441, 75, 25)
$ExitID = GUICtrlCreateButton("�˳�", 244, 441, 75, 25)
$Label18 = GUICtrlCreateLabel("��������F9����,F10�˳�", 416, 472, 133, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group8 = GUICtrlCreateGroup("��������", 424, 145, 193, 121)
$ckbBagfull = GUICtrlCreateCheckbox("������ػ�", 440, 161, 97, 17)
$ckbBoxing = GUICtrlCreateCheckbox("�������Ƿ�װ��", 440, 181, 121, 17)
$boxQty = GUICtrlCreateInput("8", 576, 201, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label20 = GUICtrlCreateLabel("���ڴ˸���ִ��", 464, 201, 88, 17)
$ckbother = GUICtrlCreateCheckbox("������˽�����", 440, 224, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group9 = GUICtrlCreateGroup("����������", 424, 32, 185, 113)
$RDnameAp = GUICtrlCreateRadio("��ĸ������", 440, 48, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDnameMa = GUICtrlCreateRadio("���ַ�����", 440, 72, 113, 17)
$namelenfr = GUICtrlCreateInput("3", 480, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("��", 512, 104, 16, 17)
$namelento = GUICtrlCreateInput("6", 536, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("λ", 568, 104, 16, 17)
$Label23 = GUICtrlCreateLabel("����:", 440, 104, 31, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group10 = GUICtrlCreateGroup("��������", 19, 152, 393, 113)
$dtshut = GUICtrlCreateDate("2011/06/03 12:13:43", 107, 176, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))

	GUICtrlSendMsg(-1, 0x1032, 0, "yyyy/MM/dd HH:mm:ss") ; DTM_SETFORMATW

$ckbTimeshut = GUICtrlCreateCheckbox("��ʱ�ػ�:", 27, 176, 73, 17)
$Label3 = GUICtrlCreateLabel("���������ͣ�����ӣ�", 24, 208, 124, 17)
$staymin = GUICtrlCreateInput("60", 160, 208, 73, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("��־�鿴")
$edtLog = GUICtrlCreateEdit("", 16, 40, 604, 432)
$readlog = GUICtrlCreateButton("��ȡ", 95, 492, 75, 25)
$deletLog = GUICtrlCreateButton("���", 362, 493, 75, 25)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [400, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "�������κ����ݰ�,�ܿ�Warden������,������Źһ�ʱ��", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036", 1)





TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("����")
TrayCreateItem("")
$aboutitem = TrayCreateItem("����")
TrayCreateItem("")
$exititem = TrayCreateItem("�˳�")

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

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
			Case $msg = $SaveID ;save info
				If saveinfor() Then
					MsgBox(0, "�ɹ�", "����ɹ�")
				EndIf
			Case $msg = $YesID
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
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
				MsgBox(64, "����:", "����2ר��KP�һ�����.")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui

Func saveinfor()

	;check
	$lenNamefr = GUICtrlRead($namelenfr)
	$lenNameto = GUICtrlRead($namelento)
	;$lenbhtime = GUICtrlRead($bhTime)
	$lenboxqty = GUICtrlRead($boxQty)
	;$lenpicktiem = GUICtrlRead($picktime)
	;$lenroundtime = GUICtrlRead($kproundtime)
	;$lenstoptime = GUICtrlRead($ramstoptime)
	;$lenblztime = GUICtrlRead($blztime)
	
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
	#CS	If $lenpicktiem <= 0 Or $lenpicktiem >= 20 Then
		MsgBox(0, "����", "�Ҷ����Ĵ�������Ϊ0,Ҳ��Ҫ����,����5������")
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
		If $lenblztime <= 0 Or $lenblztime >= 10 Then
		MsgBox(0, "����", "����ѩ��������Ϊ��Ϊ0,Ҳ����̫��������3��")
		Return False
		EndIf
	#CE
	
	
	#CS 	$avArray[0] = $Radio1
		$avArray[1] = $Radio2
		$avArray[2] = $Radio3
	#CE
	
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

	For $i = 0 To 1 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayName[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$nameCat = $i + 1
		EndIf
	Next




	If BitAND(GUICtrlRead($ckbBagfull), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$shutdown = 1
	Else
		$shutdown = 0
	EndIf
	

	
	If BitAND(GUICtrlRead($ckbBoxing), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiboxing = 1
	Else
		$guiboxing = 0
	EndIf

	If BitAND(GUICtrlRead($ckbTimeshut), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guisettime = 1
	Else
		$guisettime = 0
	EndIf

	If BitAND(GUICtrlRead($ckbother), $GUI_CHECKED) = $GUI_CHECKED Then ; other in room
		$guiothercheck = 1
	Else
		$guiothercheck = 0
	EndIf
	
	IniWrite("info.dat", "shop", "�ʺ�", GUICtrlRead($n1))
	IniWrite("info.dat", "shop", "����", _StringToHex(GUICtrlRead($n2)))

	IniWrite("info.dat", "shop", "λ��", $pos)
	IniWrite("info.dat", "shop", "����Ŀ��", GUICtrlRead($path1))
	IniWrite("info.dat", "shop", "��ʼλ��", GUICtrlRead($path2))
	IniWrite("info.dat", "shop", "��������ػ�", $shutdown)
	IniWrite("info.dat", "shop", "������װ��", $guiboxing)
	IniWrite("info.dat", "shop", "���ڸ�����ʼװ��", GUICtrlRead($boxQty))
	IniWrite("info.dat", "shop", "��������ʽ", $nameCat)

	IniWrite("info.dat", "shop", "��������������", GUICtrlRead($namelenfr))
	IniWrite("info.dat", "shop", "��������������", GUICtrlRead($namelento))
	IniWrite("info.dat", "shop", "�Ƿ�ʱ�ػ�", $guisettime)
	IniWrite("info.dat", "shop", "��ʱ�ػ�ʱ��", GUICtrlRead($dtshut))

	IniWrite("info.dat", "shop", "��������˽���", $guiothercheck)
	IniWrite("info.dat", "shop", "��������������", GUICtrlRead($staymin))
	
	
	Return True
EndFunc   ;==>saveinfor

Func readinfor()
	$guistaymin =60
	
	$usr = IniRead("info.dat", "shop", "�ʺ�", "")
	$psd = _HexToString(IniRead("info.dat", "shop", "����", "")) ;16����ת���ض�����

	$pos = IniRead("info.dat", "shop", "λ��", "")

	$d2path1 = IniRead("info.dat", "shop", "����Ŀ��", "")
	$d2path2 = IniRead("info.dat", "shop", "��ʼλ��", "")
	$shutdown = IniRead("info.dat", "shop", "��������ػ�", "")
	$nameCat = IniRead("info.dat", "shop", "��������ʽ", "")

	$guiboxing = IniRead("info.dat", "shop", "������װ��", "")
	$guiboxqty = IniRead("info.dat", "shop", "���ڸ�����ʼװ��", "")
	$guinamelenfr = IniRead("info.dat", "shop", "��������������", "")
	$guinamelento = IniRead("info.dat", "shop", "��������������", "")
	$guisettime = IniRead("info.dat", "shop", "�Ƿ�ʱ�ػ�", "")
	$guitimedata = IniRead("info.dat", "shop", "��ʱ�ػ�ʱ��", "")
	$guiothercheck = IniRead("info.dat", "shop", "��������˽���", "")
	$guistaymin = IniRead("info.dat", "shop", "��������������", "")

	
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	GUICtrlSetData($path1, $d2path1)
	GUICtrlSetData($path2, $d2path2)
	;GUICtrlSetData($bhTime, $guibhTime)
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
	
	If $guiothercheck = 1 Then ;����������Ƿ����
		GUICtrlSetState($ckbother, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbother, $GUI_UNCHECKED)
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
