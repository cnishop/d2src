#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_Res_Comment=����K3C����,��BOT�����������޷���⵽����ȫ
#AutoIt3Wrapper_Res_Description=����k3C�һ������һ�ר��
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=�˶�������
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** ���������� ACNWrapper_GUI ****

#include <guidesignk3c.au3>
#include <d2KC3�ͻ���.au3>
#include <include.au3>
#include <colormanger.au3>  ;������ɫ�ĺ���
#include <imageSearch.au3>
#include <commonUse.au3>
#include <fireMethord.au3>   ;���������еĺ���
#include <checkbag.au3>
#include <findpath.au3>    ;�ܲ�·��
#include <approve.au3>
#include <file.au3>    ;д��log ��־
#include <ScreenCapture.au3>


; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused

Local $ohterImage = 0 ;���ֵ�����δ֪����
Local $emptybag
Local $checkbag = 1

Local $handle
$title = "d2"
Local $gameopt = 1 ; ���� 0 ������ 1
;$fire = 0   ;/ / ��ɫ��������,��radio button��ѡ��
$titlefiremethord = $title
$titleImageSearch = $title
Local $ct = 1
Local $repeatrejpet = 0 ; ����һ������pet�ı�־�����Ƿ��ظ�
Local $roombegintime ;��¼���뷿���kp��ʱ�䣬����ͳ��һ��kp�����೤ʱ��

Local $parm_boxing ;�Ƿ�װ��
Local $parm_boxqty ;���������ĸ���
Local $parm_namelenfr, $parm_namelento, $parm_namepre
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime
Local $parm_ramevent, $parm_kprounctime, $parm_rantime
Local $parm_ramclose, $parm_closetime, $parm_closestoptime ;�涨kp�������ߵ�����
Local $parm_path ;������ŵ�·��
Local $parm_othercheck, $parm_otherwhencheck, $parm_othermethord, $parm_otherroundtrace
Local $parm_shopwater
Local $parm_otherimage ;����İ����ͼ��
Local $parm_repair, $parm_repairRound

Local $parm_act ;which act role is in
Local $parm_bhtime ;bh ���ͷ�ʱ��
Local $parm_firemothord ;  $guifiremothord

Local $round = 0 ; kp����ͳ��
Local $tfcount = 0 ; �л��˺�ǰ���˺ŵ��ۻ�kp���� ������
Local $tfclosecount = 0 ; �Զ������ߵ�kp����
Local $trepaircount = 0 ; �Զ������ߵ�kp����

Local $other_traced_round = 0 ;����ڼ��ֱ��˽��뷿��,

Local $authority ;
Local $parm_firstdate, $parm_kpcount ;�ܵ�kp���������������¸��ͻ�


Local $arrayroomName[12] ;����������ĸ������
$arrayroomName[0] = "q"
$arrayroomName[1] = "w"
$arrayroomName[2] = "e"
$arrayroomName[3] = "r"
$arrayroomName[4] = "a"
$arrayroomName[5] = "s"
$arrayroomName[6] = "d"
$arrayroomName[7] = "f"
$arrayroomName[8] = "g"
$arrayroomName[9] = "z"
$arrayroomName[10] = "x"
$arrayroomName[11] = "c"





Local $acountArray[2] ;���ڰ��ʺ�

$bindmac = 1 ;�󶨻���
$bindacc = 0 ;���ʺ�
$bindlimitCount = 1 ;  �󶨴���
$bindTime = 0 ;���ݿ��еĴ���  ;ֻ���԰��õ�

$limitRound = 80 ;�����һ�����

$ranLimte = Random(-14, 14, 1) ;���������Ƶ�ǰ��Χ   ������� 80-20 ���� 80+20




If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "��ʾ", "δ֪��������")
	Exit 0
EndIf

If $bindmac = 1 Then
	If Not _IniVer() Then ; �󶨻���
		gui()
	EndIf
EndIf




creatGui() ; ��ʼ��������


$parm_boxing = $guiboxing
$parm_boxqty = $guiboxqty
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_namepre = $guinamepre
$parm_drinkrej_plus = $guidrinkrej
$parm_drinkheal_plus = $guidrinkheal
$parm_drinkmana_plus = $guidrinkmana

$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime
$parm_ramclose = $guiramclose
$parm_closetime = $guiclosetime
$parm_closestoptime = $guiclosestoptime
$parm_blztime = $guiblztime
$parm_path = $guipath
$parm_othercheck = $guiothercheck
$parm_otherwhencheck = $guiotherwhen
$parm_othermethord = $guiothermetherd
$parm_otherroundtrace = $guiotherroundtrace
$parm_act = $ckact5
$parm_shopwater = $guishopwater

$parm_bhtime = $guibhTime
$parm_firemothord = $guifiremothord
$parm_otherimage = $guiotherimage ;����İ������Ƭ��ͼ��

$parm_repair = $guirepair
$parm_repairRound = $guirepairRound



HotKeySet("{F9}", "TogglePause")
HotKeySet("{F10}", "Terminate")
;;;; Body of program would go here ;;;;

While 1
	Sleep(100)
WEnd

;;;;;;;;
Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		TrayTip("", "�ȴ�ִ����..", 1, 16)
		runGame()
	WEnd
	;Exit
	$checkbag = 1
	$boxisfull = 0
	Sleep(10)
	TrayTip("", "��ͣ��...��", 9, 16)
	Sleep(86400000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "���˳�����", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	Dim $optcount = 0 ; ��¼�Ƿ������²�������ʱ����Ϊ�������ȣ����ͣ����һ��δ֪�����ϲ���
	If $parm_settime = 1 Then ;check if set tiem to shutdown
		tiemtoshut($parm_timedata)
	EndIf
	
	;-------------------
	;���Ӷ԰��ʺŵ����ƣ�                                    1. ���ʺŵ�����
	If $bindacc = 1 Then
		$acountArray[0] = "cnzg"
		$acountArray[1] = "cnzg"
		If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
			;writelog("�ڵ�" & $other_traced_round + 1 & "�����˽��뷿��")
			MsgBox(4096, " ...... ��ʾ ...... ", "��󶨵��ʺŲ��������ȷ��")
			Exit 0
		EndIf
	EndIf
	;------------------                                          ��ÿ�����ʹ�ô���
	If $bindlimitCount = 1 Then
		If $round >= $limitRound + $ranLimte Then
			writelog("�ﵽѭ�����ƴ���")
			MsgBox(4096, " ..... ��ܰ��ʾ .........", "�Ѵ�ѭ�����ƴ���,����Ϣ���ٹһ�" & @CRLF & "��ʹ�����޴ΰ�")
			Exit 0
		EndIf
	EndIf
	
	;���Ӷ����ʹ�ô��������� ----------------                 .���ݿ���ʹ�ô�������
	SQLiteFirstUpateDate(101)
	SQLiteRead(101)
	$parm_firstdate = $app_date
	$parm_kpcount = $app_kpcount
	
	;$iDateCalc = _DateDiff('D', $parm_firstdate, _NowCalc())
	;-------------����Ϊ�������ѣ�
	If $bindTime = 1 Then
		;If $iDateCalc >= 30 Then
		;MsgBox(0, "������ʾ", "�����������ѵ���Ȩ���ޣ�������")
		;Exit 0
		;EndIf
		;30�켴Ϊ2592000��
		;If $parm_kpcount >= 51840 Then   ;��������ô�����
		If $parm_kpcount >= 50 Then
			MsgBox(0, "������ʾ", "�����Ƶ�����ѵ���Ȩ������������")
			Exit 0
		EndIf
	EndIf
	;---------------------------------------
	
	activeWindow()

	#CS //������Ϸ���棬�����ť����ս��
		MouseClick("left", 600, 455, 1)
		//����ս��
		MouseClick("left", 600, 455, 1)
		//������������
		MouseClick("left", 600, 455, 1)
		Sleep(50)
	#CE
	#CS    ;��̨ģ��������
		#Include <ACN_Mouse.au3>
		Opt("MouseCoordMode", 0)
		_MouseClickPlus($title, "left",400,320,1)
	#CE
	
	;����

	#CS 	Sleep(1000)
		MouseClick("left", 400, 300, 1)
		Sleep(500)
		MouseClick("left", 700, 560, 1)
		Sleep(500)
		MouseClick("left", 400, 360, 1)
		Sleep(4000)
	#CE
	



	
	

	
	;�����ǽ�����Ϸ���ƶ������
	Select
		Case isInRoom()
			$ct = $ct + 1
			$roombegintime = _NowCalc()
			roomplay()
			$inRoomDateCalc = _DateDiff('s', $roombegintime, _NowCalc())
			writelog("������ʱ��---�� " & $round & " ����ʱ: " & $inRoomDateCalc & " ��")
			$optcount = $optcount + 1
			;Sleep(1000)
			Sleep(Random(600, 1000, 1))
		Case waitCreatRoom()
			$optcount = $optcount + 1
			TrayTip("", "׼��������Ϸ����.", 1, 16)
			Sleep(Random(2000, 3000, 1))
		Case loginnotConnect()
			$optcount = $optcount + 1
			TrayTip("", "�޷�����ս���������С���.", 1, 16)
			Sleep(1000)
		Case pwderror()
			$optcount = $optcount + 1
			TrayTip("", "����������ԡ���.", 1, 16)
			Sleep(1000)
		Case selectRole()
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ���Ҫ��������.", 1, 16)
			Sleep(2000)
		Case waitInputUsr()
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ�ѡ���ɫ����.", 1, 16)
			Sleep(2000)
		Case waitLoginNet()
			$optcount = $optcount + 1
			TrayTip("", "����Ƿ���Ҫ�����û�������.", 1, 16)
			Sleep(2000)
		Case Else
			TrayTip("", "�ȴ��У����Ժ�", 1, 16)
			Sleep(Random(400, 600, 1))
	EndSelect
	
	;;���$optcount ��Ϊ0����ʾûִ�й��κβ�����ͣ����ĳ��δ֪���棬
	If $optcount = 0 Then
		$ohterImage = $ohterImage + 1 ;����һ��������ͳ�Ƴ�������δ֪������д���
		TrayTip("���Ժ��ʵĲ���", $ohterImage, 1, 16)
		If $ohterImage > 20 Then;ѭ����100��
			TrayTip($ohterImage, "δ�ҵ��ĺ��ʲ�����������", 1, 16)
			Sleep(100)
			Send("{ESC}") ;����δ֪�Ľ���,��ȴ�,��ESC
			Sleep(100)
			If $ohterImage > 22 Then;
				Sleep(100)
				Send("{ENTER}") ;����δ֪�Ľ���,����esc�����еĻ�,�򻻳ɰ��س�����
				Sleep(100)
			EndIf
			If $ohterImage > 25 Then;   �������ϻس�������,��ֱ�ӽ�����Ϸ����,���´�,�����������򱨴�֮��
				Sleep(100)
				$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
				If $PID Then ProcessClose($PID)
				$ohterImage = 0
				Sleep(1000)
			EndIf
		EndIf
	Else
		$ohterImage = 0 ; �ָ���ʼ״̬���������ۻ�
	EndIf
	
EndFunc   ;==>runGame

Func activeWindow()
	
	;�ȹر���Ч�Ĵ����ͼ����
	closeError()
	;----------------����
	If $parm_ramclose = 1 Then
		ramclose() ;��ȡ����
	EndIf
	;
	
	;TrayTip("", "����ڣ�", 1,16)
	; �õ����� "this one" ���ݵļ��±����ڵľ��
	$handle = WinGetHandle($title)
	If @error Then
		;MsgBox(32, "����", "û�ҵ����ڴ��ڳ��򣬵�һ�����ȴ򿪰��ڣ�������ѡ�񵥻���ս���Ľ���")
		;Exit 0
		TrayTip("", "û���ҵ���Ϸ���ڣ����������С�", 1, 16)
		Sleep(1000)
		If Run($d2path1, $d2path2) = 0 Then
			;Run("F:\�����ƻ���II����֮��1.10\D2loader.exe -w -pdir Plugin -title d2 ", "",@SW_MAXIMIZE )
			
			;Sleep(3000)
			;$handle = WinActivate($title)
			;Send("{ENTER}")
			;If @error <> 0 Then
			MsgBox(32, "����", "�������ú���ȷ��·��")
			Exit
		Else
			Sleep(3000)
			$handle = WinGetHandle($title)
			WinActivate($title)
			Send("{ENTER}")
			Sleep(100)
		EndIf
		
	Else
		WinActivate($title)
	EndIf
	WinMove($title, "", 1, 1) ;�ƶ������ϣ���ֹ����������ס
	Sleep(50)
	$size = WinGetClientSize($title)
	If $size <> 0 Then ;�ҵ�����
		If $size[0] <> 800 And $size[1] <> 600 Then
			MsgBox(0, "��ʾ", "����ȷ����Ϸ�Ƿ����Ǵ���ģʽ�����Ƚ���Ϸ���������ó�800*600")
			Exit 0
		EndIf
	Else
		MsgBox(0, "��ʾ", "û���ҵ���Ϸ����.")
	EndIf
	initialSize()
EndFunc   ;==>activeWindow

Func roomplay()
	If $parm_ramevent = 1 Then
		getRam() ;��ȡ����¼�
	EndIf
	
	If $parm_act = 1 And isInRoom() Then
		$act = whichAct()
		If $act = "A4" Then
			a4Toa3()
			Return
		ElseIf $act = "A5" Then
			a5Toa3()
			Return
			
		ElseIf $act = "A3" Then
			
			
		Else
			exitRoom()
			Return
		EndIf
	EndIf

	If $ckroledead = 1 And roleisdead() Then
		writelog("��ɫ---��ɫ����")
		Sleep(Random(150, 220, 1))
		Return
	EndIf

	
	;a3toomous(Random(1, 2, 1)); ��act3������ͷȥomous ��
	If isInRoom() Then
		a3toomous(1)
	Else
		Return
	EndIf
	Sleep(500)
	;a3totownwp(2)
	
	;��Ѫ�������Ƿ���ϣ�������٣�����omous
	clickomous()
	MouseClick("left", 400, 300, 2) ;��������ط��������Ի�omous
	
	If $parm_shopwater = 1 Then
		If findbeltWater("heal", "0xA42818") = 0 Or findbeltWater("mana", "0x303094") = 0 Then;��Ҫ������
			TrayTip("", "׼������", 1, 16)
			Sleep(1000)
			tradeomous()
			If findbeltWater("heal", "0xA42818") = 0 Then
				tradewater(1)
			EndIf
			If findbeltWater("mana", "0x303094") = 0 Then
				tradewater(2)
			EndIf
			MouseClick("left", 430, 460)
			Sleep(600)
		EndIf
	EndIf
	
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;�����޺����Ƿ��������˵�¼
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	a3omousToWp()
	
	;����һ���Ƿ���Ҫ����װ�������
	Dim $faillasuke 
	If $parm_repair = 1 And $parm_repairRound = $trepaircount Then
		a3Toa5()
		a5WpTolasuke()
		Do
			ClickLasuke()
			$faillasuke = $faillasuke + 1
		Until traderepair() = 1 Or $faillasuke >= 5
		$trepaircount = 0
		
		MouseClick("left",400,300)
		exitRoom()
		Return
	EndIf
	
	
	#CS 	$coord = PixelSearch(100, 100, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
		TrayTip("", "�Ƶ�Сվ�Ա�", 1)
		MouseClick("left", $coord[0] - 10, $coord[1] -10, 1)
		Sleep(2000)
		EndIf
	#CE
	
	Sleep(10)
	;�����������Ƿ���������
	
	If $parm_drinkrej_plus = 1 Then
		drinksurplusrev()
		;checkbagRev()
	EndIf
	If $parm_drinkheal_plus = 1 Then
		drinksurplusHeal()
	EndIf
	If $parm_drinkmana_plus = 1 Then
		;drinksurplusMana()
		checkbagRev()
	EndIf
	;addBloodtorole() ;�Ӻ�  ��Ȼǰ���Ѿ���omous �Ի����Ͳ����ټ���
	;addmanatorole() ;����
	If $parm_boxing = 1 Then
		If bagisfull() Then
			writelog("����---��������")
			Sleep(Random(80, 100, 1))
			Return
		EndIf
	EndIf

	#CS 			If checkRejQtyInBelt() <= $rejneedqty Then ; �˴������жϣ����û�к����ˣ���ȥ���򣬻��ߵ�omous �ظ���
		TrayTip("", "û�����ˣ�ȥ����.", 1, 16)
		a3Toa5()
		Return
		EndIf
	#CE
	If $ckass = 1 And astisdead() Then ; �˴�������KPʱ���õĸ��ʽ
		writelog("��Ӷ��---��Ӷ������")
		Sleep(Random(80, 100, 1))
		a3toa4()
		a4wpToYizuer()
		exitRoom()
		Return
	EndIf
	a3townwptocui() ;��act3���޷���
	


	If a3CuiNearPoint() = False Then ;���û�гɹ�����cuifanke Сվ
		TrayTip("", "û�гɹ�����޷��ͣ��˳�����", 1, 16)
		exitRoom()
		Return False
	EndIf
	afterReady() ;cta
	
	Sleep(Random(80, 100, 1))
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;�����޺����Ƿ��������˵�¼
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	TrayTip("", "����3C.", 1, 16)
	goto3cpath(Random(2, 3, 1)) ;�Ӵ޷��˵�Сվ�� 3c��ǰ
	;goto3cpath(3)
	;Sleep(Random(800, 1500, 1))
	Sleep(Random(80, 100, 1))
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;�����޺����Ƿ��������˵�¼
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	
	$coord = finPicPos("images\cui2.bmp", 0.7)
	;$coord = findcui2()
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		TrayTip("", "�����ƶ���", 1, 16)
		;MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(200)
		MouseClick("left", 600, 200, 2);
		Sleep(800)
	EndIf
	
	
	If isInRoom() Then
		
		TrayTip("", "�ҹֲ��ͷż���.", 1, 16)
		
		If $parm_firemothord = 1 Then
			fire3c(50, 20, 790, 520, $parm_bhtime);�����ͷ�
		Else
			fire3cByBlock(50, 20, 790, 520, 5)
		EndIf
		
		If checkNowDead() = 1 Then ;�������
			Send("{ESC}")
			Sleep(500)
			exitRoom()
			Return
		EndIf
		
	EndIf
	
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;�����޺����Ƿ��������˵�¼
		If checkotherin() = True Then
			Return
		EndIf
	EndIf

	If isInRoom() Then
		TrayTip("", "Ѱ����Ʒ.", 1, 16)
		finditem($parm_picktime) ;pick up item
	EndIf
	TrayTip("", "�˳�����.", 1, 16)
	exitRoom()
	Sleep(2000)
	
	$round = $round + 1
	$tfcount = $tfcount + 1
	$tfclosecount = $tfclosecount + 1
	$trepaircount = $trepaircount + 1 ; repair count
	_GUICtrlStatusBar_SetText($StatusBar1, "K3C������" & $round & "  �ۼ�K3C������ " & $parm_kpcount + 1, 1)
	
	$parm_kpcount = $parm_kpcount + 1
	SQLiteInsert(101, "", $parm_kpcount)
	


EndFunc   ;==>roomplay


Func finditem($parm_picktime)
	Sleep(10)
	MouseMove(400, 300)
	Sleep(10)
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		#CS 		$coord = PixelSearch(100, 50, 795, 520, 0x18FC00, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
			If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			Sleep(1200)
			EndIf
			Sleep(100)
		#CE
		
		;��������ж���������Ҫȥ�����������
		$coord = PixelSearch(100, 50, 375, 300, 0x18FC00, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

		
		$coord = PixelSearch(375, 50, 795, 215, 0x18FC00, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(800)
		EndIf

		
		$coord = PixelSearch(425, 215, 795, 520, 0x18FC00, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

		
		$coord = PixelSearch(100, 300, 425, 520, 0x18FC00, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

	Next
	
	Send("{ALT up}")
	Sleep(10)
	
	
EndFunc   ;==>finditem
Func movekp()
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	TrayTip("", "�������·��" & "�����Ի�ƫ��" & $xrd & " " & $yrd, 1, 16)
	Send("{F1}") ;
	Sleep(100)
	MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
EndFunc   ;==>movekp


Func waitLoginNet()
	;����ս�����ж��Ƿ�׼����battle
	If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
		If $gameopt = 1 Then
			MouseClick("left", 400, 350)
		Else
			;����
			MouseClick("left", 400, 300, 1)
			Sleep(500)
			MouseClick("left", 700, 560, 1)
			Sleep(500)
			MouseClick("left", 400, 360, 1)
			Sleep(4000)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;����ս�����ж��Ƿ�׼����battle
	If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
		MouseClick("left", 360, 430)
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;����ս�����ж��Ƿ�׼�������˺�����
	If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
		MouseClick("left", 400, 340, 2)
		Sleep(500)
		ControlSend($title, "", "", $usr)
		Sleep(1500)
		MouseMove(400, 390)
		Sleep(1000)
		MouseClick("left", 400, 390, 2)
		Sleep(500)
		ControlSend($title, "", "", $psd)
		Sleep(1000)
		Send("{ENTER}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitInputUsr

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
	;MouseMove(290, 510)  242424
	;MouseMove(290, 560) 303030
	
	;MouseMove(360, 400) 646464
EndFunc   ;==>pwderror

Func selectRole()
	;select role which is to be used
	;If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "343434") Then
	
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
EndFunc   ;==>selectRole
Func waitCreatRoom()
	;����ս�����ж��Ƿ�׼��������
	;If findPointColor(30, 585, "040404") And findPointColor(325, 585, "040404") Then
	If findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") And findPointColor(180, 350, "040404") Then ; 109 �Ĳ���
		TrayTip("", "����ս������,׼����������..", 1, 16)
		;����ҵ�����ʾ���ڴ���
		;�����䣬�ж��Ƿ���ֶԻ������޷�������ͬ������ʾ���м����ֶԻ���
		Sleep(1000)
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
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
EndFunc   ;==>waitCreatRoom

Func createRoom() ;����ս����Ϸ������
	;/������Ϸ���棬�����ť����ս��
	;MouseClick("left", 600, 455, 1)
	;//����ս��
	MouseClick("left", 700, 455)
	MouseClick("left", 600, 455)
	MouseClick("left", 705, 378) ;ѡ�����Ѷ�
	Sleep(1000)
	; //������������
	If $nameCat = 1 Then
		Dim $str = ""
		Dim $roomcount = Random($parm_namelenfr, $parm_namelento, 1)
		;msgbox(0,$roomcount,$roomcount)

		$str = ""
		For $i = 1 To $roomcount Step 1
			$str = $str & $arrayroomName[Random(0, 11, 1)]
		Next

		#CS 		For $i = 1 To $roomcount
			$str = $str & Chr(Random(97, 104, 1))
			Next
		#CE
		
		
		ControlSend($title, "", "", $str)
	ElseIf $nameCat = 2 Then
		ControlSend($title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
	Else
		ControlSend($title, "", "", $parm_namepre & $ct)
	EndIf

	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Sleep(100)
	Send("{ESC}")
	Sleep(10)
	MouseClick("left", 400, 250, 1)
	Sleep(10)
EndFunc   ;==>exitRoom

Func finddoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ�Һ���.", 1, 16)
	Sleep(Random(50, 300, 1))
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 150
	$top = 150
	$right = 400
	$bottom = 300
	;Sleep(1000)



	#CS    ;xp:
		If findredDoor($left, $top, $right, $bottom) Then
		TrayTip("", "�ҵ����Ų����룡.", 1, 16)
		Return True
		Else
		TrayTip("", "Ѱ�Һ���ʧ�ܣ�.", 1, 16)
		Sleep(500)
		Return False
		EndIf
		
	#CE

	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "�ҵ����ţ�", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(500)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		Sleep(1500)
		Return True
	Else
		TrayTip("", "����δ�ҵ���׼���˳�����", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
	
EndFunc   ;==>finddoor
Func findredDoor($left, $top, $right, $bottom)
	$exit = False
	$errorexit = False
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		If getRightPoint($x, $y) Then
			;MouseMove($x, $y)
			Sleep(1000)
			Return True
			;MsgBox(0, "", "right")
		Else
			For $k = $left To $right Step 100
				For $j = $top To $bottom Step 100
					;MsgBox(0,"","������")
					;TrayTip("", "��ѯ����." & $k & "" & $j, 1)
					If findNext($k, $j, $right, $bottom) Then
						;MsgBox(0, "", "������һ��")
						;TrayTip("", "�ҵ���һ�����ţ�.", 1, 16)
						;MouseMove($k, $j)
						;MouseClick("left", $k, $j, 1)
						;AAA()
						$exit = True
						ExitLoop
					EndIf
					;MsgBox(0, "", "���ң�" & $k & "" & $j)
					If $k >= $right And $j >= $bottom Then
						;MsgBox(0, "", "error")
						TrayTip("", "Ѱ�Һ���ʧ�ܣ��˳�.", 5, 16)
						$errorexit = True
						ExitLoop
					EndIf
				Next
				If $exit = True Then
					ExitLoop
				EndIf
				If $errorexit = True Then
					ExitLoop
				EndIf
			Next
			If $exit = True Then
				Return True
			EndIf
			If $errorexit = True Then
				exitRoom()
				Return False
			EndIf
			
			
		EndIf
	Else
		;MsgBox(0, "", "û��һ���׵�") ���һ���׵�û�ҵ���������û�����ŵ�λ�ã��˳���Ϸ����
		TrayTip("", "û���ҵ��ܺϺ��ű�־.", 1, 16)
		Sleep(400)
		exitRoom()
		Return False
	EndIf
EndFunc   ;==>findredDoor
Func findNext($left, $top, $right, $bottom)
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		Return getRightPoint($x, $y)
	Else
		Return False
	EndIf
EndFunc   ;==>findNext
Func getRightPoint($xx, $yy)
	;TrayTip("", "�Ҵ���20����ɫ�ĵ�.", 1)
	$total = 0
	For $i = -5 To 85 Step 1
		For $j = -5 To 105 Step 1
			$var = PixelGetColor($xx + $i, $yy + $j)
			If Hex($var, 6) = "FFFFFF" Then
				$total = $total + 1
			EndIf
		Next
	Next
	If $total >= 30 Then
		MouseMove($xx, $yy)
		MouseClick("left", $xx, $yy, 1)
		Sleep(500)
		;TrayTip("", "totalΪ��" & $total, 1)
		Return True
		;ElseIf  $total >= 15 Then
		; Return True
	Else
		;TrayTip("", "totalΪ��" & $total, 1)
		Return False
	EndIf
EndFunc   ;==>getRightPoint

Func bagisfull()
	If isInRoom() = True And $checkbag = 1 Then
		Send("{B}")
		Sleep(100)
		MouseMove(300, 340)
		Sleep(100)
		InitialBagCheck()
		$emptybag = getbagLocation()
		TrayTip("", "��鱳��ʣ��������" & $emptybag, 1, 16)
		Sleep(100)
		

		
		
		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;���������Ʒռ�ã���ʾ��������
			TrayTip("", "�����ռ����: " & $emptybag & " ���������õĸ���: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{B}")
			Sleep(500)
			If $boxisfull = 0 Then ;�����¼�ֿ������ı�ʾ =1 ����ʾ���ˣ��Ͳ����ٴ�ֿ��0 ȥ��ֿ�
				;gotoa3Box($act)
				gotoa3Box("A3")
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
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;����û�ѡ���˰������˹ػ�,����ʾ
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "����ִ�йػ�", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
			
			#CS 			If $shutdown = 1 And isInRoom() And $allfull Then ;����û�ѡ���˰������˹ػ�,����ʾ
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "����ִ�йػ�", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
				ElseIf isInRoom() And $allfull Then
				Sleep(500)
				exitRoom()
				$checkbag = 0
				Return True
				ElseIf isInRoom() And $allfull = False Then
				exitRoom()
				Return True
				EndIf
			#CE
			
		Else
			Send("{B}")
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>bagisfull


Func notinfive()
	TrayTip("", "����Ƿ���act4", 1, 16)
	Sleep(100)
	Send("{Q}") ;tab ȥ��С��ͼ
	Sleep(200)
	If findPointColor(380, 80, "242424") = False Then ; ��Q�� ,�쿴�Ƿ���act5,û�ҵ���ʾ����act5����ʱȥact5
		;��ʱ�����act4,��move ȥact5
		Send("{Q}") ;tab ȥ��С��ͼ
		MouseClick("left", 740, 80, 1)
		Sleep(2000)
		MouseClick("left", 340, 80, 1)
		Sleep(200)
		MouseClick("left", 340, 140, 1)
		Sleep(2000)
		exitRoom()
		Return True
	Else
		Send("{Q}") ;tab ȥ��С��ͼ
		Return False
	EndIf
	
EndFunc   ;==>notinfive


Func astisdead()
	TrayTip("", "���pet����û", 1, 16)
	Sleep(100)
	;If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
	;------------------------------ ��һ����������
	Send("{O}")
	Sleep(300)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	Sleep(300)
	Send("{O}")
	If $a <> 3002911715 Then
		; -------------------------
		$repeatrejpet = $repeatrejpet + 1 ;
		TrayTip("", "���Ե�" & $repeatrejpet & " �θ���pet", 1, 16)
		Sleep(500)
		If $repeatrejpet >= 10 Then ;��� �����ظ�ִ�и���Ĵ������� 10�Σ���ʾ����ûǮ�ˡ�
			writelog("��Ӷ��---����10���ظ�����pet��������ûǮ�ˣ��Զ��˳���")
			$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
			If $PID Then ProcessClose($PID)
			Sleep(1000)
			Exit 0
		EndIf
		
		TrayTip("", "pet���ˣ�������", 1, 16)
		Sleep(1000)
		;resumepet()
		;exitRoom()
		Return True
	Else
		$repeatrejpet = 0 ;����Ϊ 0
		Return False
	EndIf
EndFunc   ;==>astisdead

Func resumepet()
	MouseClick("left", 145, 520, 1)
	Sleep(2000)
	;MouseMove(170,520)
	MouseClick("left", 170, 520, 1)
	Sleep(2000)
	MouseClick("left", 310, 80, 1)
	Sleep(200)
	MouseClick("left", 310, 140, 1)
	Sleep(3000)
	;;����act4
	MouseClick("left", 130, 240, 1)
	Sleep(3000)
	MouseClick("left", 280, 60, 1);����̩���
	Sleep(2000)
	MouseClick("left", 380, 130, 1);���и���
	Sleep(1500)
	MouseClick("left", 380, 130, 1);����ǰ��act5
	Sleep(1500)

EndFunc   ;==>resumepet

Func roleisdead()
	TrayTip("", "��������Ƿ����", 1, 16)
	Send("{B}")
	Sleep(500)
	If findPointColor(460, 250, "242424") = True And findPointColor(505, 250, "040404") = True And findPointColor(690, 250, "282828") = True Then
		;�������,��ָ,Ь����������ɫ��ΪĬ����ɫ,���ʾ����û��װ��,������
		Send("{B}")
		Sleep(500)
		MouseClick("left", 400, 285, 1)
		Sleep(1000)
		MouseClick("left", 400, 315, 1)
		Sleep(1000)
		MouseClick("left", 400, 285, 1)
		Sleep(1000)
		MouseClick("left", 400, 315, 1)
		Sleep(1000)
		exitRoom()
		Return True
	Else
		Send("{B}")
		Sleep(100)
		Return False
	EndIf
EndFunc   ;==>roleisdead

Func checkbagRev()
	TrayTip("", "�������˲��ظ�ҩˮ", 1, 16)
	Sleep(100)
	Send("{B}")
	Sleep(100)
	;addrevtobag()
	;drinksurplusrev()
	drinksurplusInbag("0x303094") ;0x702068 zise  ;  0x303094 lanse
	Send("{B}")
	Sleep(100)
	;If 1 = 1 Then
	;	Return True
	;Else
	;	Return False
	;EndIf
EndFunc   ;==>checkbagRev

Func drinksurplusrev1() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ�
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			checkzise("0x682070")
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev1


Func drinksurplusInbag($color) ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ�
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, $color, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			checkzise($color)
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusInbag



Func addrevtobag() ;��������������󸴻�������,��������ϵ�Ѫƿ�ŵ���Ʒ����ȥ
	Send("{LSHIFT down}")
	Sleep(10)
	For $i = 1 To 10 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			Sleep(10)
			MouseClick("left", $coord[0], $coord[1], 1);
			Sleep(200)
		EndIf
	Next
	Send("{LSHIFT up}")
	Sleep(10)
EndFunc   ;==>addrevtobag

Func afterReady() ;���ź��׼������װ�令�ף�CTA ��
	Sleep(500)
	If $cta = 1 Then
		Send("{W}") ;
		Sleep(500)
		Send("{F7}") ;
		Sleep(400)
		MouseClick("right", Default, Default, 1)
		Sleep(400)
		Send("{F8}") ;
		Sleep(400)
		MouseClick("right", Default, Default, 1)
		Sleep(800)
		Send("{W}") ;
		Sleep(500)
	EndIf
EndFunc   ;==>afterReady


Func gotoa3Box($whichAct) ;�������ˣ�Ҫװ�䣬act3 ���� act5 �������
	Select
		Case $whichAct = "A3"
			TrayTip("", "��act3����װ�䣡", 9, 16)
			Sleep(500)
			$coord = finda3box();
			;$coord = findwp()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				MouseClick("left", $coord[0], $coord[1], 1);
				Sleep(2000)
			EndIf
			Sleep(1000)
		Case $whichAct = "A5"
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
		Case Else
	EndSelect
EndFunc   ;==>gotoa3Box

Func getRam()

	;_GUICtrlStatusBar_SetText($StatusBar1, "KP������" & $round & " ����ӳ�: " & $tfcount, 1)
	$ranKp = Random(-4, 4, 1)
	If $tfcount >= $parm_kprounctime + $ranKp Then ; �л��˺ź� ѭ������Ҳ���ڹ涨��
		;��ʱ���Թر���Ϸ,��ѭ������һ���˺�����½
		TrayTip("", "��ʼ����¼�����.", 1, 16)
		Sleep(1000)
		;���¾�������������¼��ˣ�������ʱ������ȥact4
		Select
			Case $tfcount >= 0
				MouseClick("left", 400 - Random(30, 400, 1), 300 + Random(10, 50, 1))
				Sleep(Random(200, 1000, 1))
				$sleeptime = $parm_rantime * 1000
				TrayTip("", "�����ͣ:" & $parm_rantime & "��", 1, 16)
				Sleep($sleeptime)
				exitRoom()
				Sleep(1000)
			Case Else

		EndSelect
		$tfcount = 0 ; ����Ϊ0
	EndIf

	
	
EndFunc   ;==>getRam

Func ramclose()
	;_GUICtrlStatusBar_SetText($StatusBar1, "KP������" & $round & " ����ӳ�: " & $tfcount, 1)
	$ranKp = Random(-4, 4, 1)
	If $tfclosecount >= $parm_closetime + $ranKp Then ; �л��˺ź� ѭ������Ҳ���ڹ涨��
		;��ʱ���Թر���Ϸ,��ѭ������һ���˺�����½
		closeAndWait()
	EndIf
	
EndFunc   ;==>ramclose

Func closeError() ;�رյ�hackmap �ı���
	$errortitle = "Diablo II Fatal Error"
	$errorhandle = WinGetHandle($errortitle)
	If Not @error Then
		writelog("��ͼ����---���Թر�hackmap")
		TrayTip("", "����hackmap Error�����Թرա�", 1, 16)
		Sleep(500)
		WinActivate($errortitle)
		Send("{ENTER}")
		Sleep(500)
		Send("{ENTER}")
		Sleep(2000)
	EndIf
EndFunc   ;==>closeError

Func closeAndWait()
	writelog("���---�� " & $round & " ��: �ر���Ϸ�ʺ�����:" & $parm_closestoptime & "��")
	TrayTip("", "�ر���Ϸ�ʺ����ߣ�����ͣ����������" & $parm_closestoptime, 1, 16)
	Sleep(1000)
	$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
	If $PID Then ProcessClose($PID)
	$sleeptime = $parm_closestoptime * 60 * 1000
	TrayTip("", "�����ͣ:" & $parm_closestoptime & "����", 1, 16)
	_GUICtrlStatusBar_SetText($StatusBar1, "�ʺ�������ͣ��...", 1)
	$tfclosecount = 0 ; ����Ϊ0
	Sleep($sleeptime)
	TrayTip("", "��ͣʱ���ѹ� ,��ʼ�����һ�", 1, 16)
	
EndFunc   ;==>closeAndWait

Func checkotherin()
	TrayTip("", "����Ƿ������˽���", 1, 16)
	Sleep(100)
	MouseMove(400, 300)
	Sleep(50)
	Send("{P}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		Send("{P}") ;�رն������
		If $b <> 3299051709 Then ;��ʾ�б䶯��,�����������˽��뷿����
			If $parm_otherimage = 1 Then
				_ScreenCapture_CaptureWnd(@ScriptDir & "\" & $parm_kpcount & "other.jpg", $handle) ;�ȱ�����ͼƬ
			EndIf
			If $parm_otherroundtrace = 1 Then ;�Ƿ����ù涨�����Զ����߹���
				If $round + 1 - $other_traced_round <= 10 Then ;����10�����ھ������α�׷�٣���ʾ�е�Σ���ˣ�
					writelog("�����˽�����---�ڵ�" & $round + 1 & "�ֽ��뷿�䣬����10��֮��2�ν��룬ֹͣ�һ���")
					exitRoom()
					Sleep(Random(200, 1000, 1))
					Exit 0
				EndIf
			EndIf
			
			$other_traced_round = $round + 1 ;�ѵ�ǰ������¼���� ,��Ϊ round ��һ��Ϊ 0
			writelog("�����˽�����---�ڵ�" & $other_traced_round & "�ֽ��뷿��")
			_GUICtrlStatusBar_SetText($StatusBar1, "ע����İ�����ڵ� " & $other_traced_round & "  �ֽ�����ķ��� ", 0)
			
			Select
				Case $parm_othermethord = 1
					exitRoom()
					Sleep(Random(200, 1000, 1))
					$sleeptime = $parm_rantime * 1000
					TrayTip("", "�����ͣ:" & $parm_rantime & "��", 1, 16)
					Sleep($sleeptime)
				Case $parm_othermethord = 2
					exitRoom()
					Sleep(100)
					closeAndWait()
				Case Else
					;����������
			EndSelect
			Return True
		Else
			TrayTip("", "û��������", 1, 16)
			;û�ҵ�������
			Return False
		EndIf
	Else
		TrayTip("", "û�ж���", 1, 16)
		;����P�󣬷���Ҳû���ҵ�������棬����Ե�
		Send("{P}")
		Return False
	EndIf
	
EndFunc   ;==>checkotherin

Func writelog($str)
	_FileWriteLog(@ScriptDir & "\" & $Files, $str)
EndFunc   ;==>writelog



Func clickomous()
	$coord = PixelSearch(100, 50, 500, 400, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		TrayTip("", "��Ѱomous������omous��.", 1, 16)
		$x = $coord[0] + 5
		$y = $coord[1] + 50
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(1800)
	EndIf
EndFunc   ;==>clickomous


Func tradeomous();ǰ�������Ѿ�����omous�������
	
	$coord = PixelSearch(100, 50, 500, 400, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
	If Not @error Then
		TrayTip("", "��Ѱomous������omous��.", 1, 16)
		$x = $coord[0] + 25
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		Sleep(600)
		
		$coord = PixelSearch($x - 50, $y - 100, $x + 90, $y, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
		If Not @error Then
			TrayTip("", "����ҩˮ��.", 1, 16)
			$x = $coord[0]
			$y = $coord[1] + 13
			MouseMove($x, $y)
			Sleep(200)
			MouseClick("left", Default, Default, 1)
			;MouseMove($coord[0] , $coord[1] )
		EndIf
		;MouseClick("left", Default, Default, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(1800)
	EndIf
	
EndFunc   ;==>tradeomous



Func tradewater($water)
	;If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
	If findPointColor(500, 440, "4C4C4C") = True Then
		TrayTip("", "Ѱ����Ʒ.", 1, 16)
		Sleep(1000)
		;MouseMove(400,300)
		;Sleep(100)
		;�ڰ��ǵĽ��״�����
		If $water = 1 Then ;��
			$coord = findHealInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0], $coord[1], 1);
				Sleep(300)
				Send("{LSHIFT up}")
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
			EndIf
		Else
			$coord = findManaInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0], $coord[1], 1);
				Sleep(300)
				Send("{LSHIFT up}")
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
			EndIf
		EndIf
		#CS 		Send("{ESC}")
			Sleep(600)
		#CE
	EndIf
EndFunc   ;==>tradewater

Func ClickLasuke()
	MouseClick("left", 401, 298)
	Sleep(Random(300, 400, 1))
	$coord = PixelSearch(200, 10, 790, 520, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
	If Not @error Then
		TrayTip("", "����Lasuke��.", 1, 16)
		$x = $coord[0] + 25
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		Sleep(1600)
		MouseMove(400, 300)
		
		$coord = PixelSearch(200, 10, 790, 520, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
		If Not @error Then
			$x = $coord[0]
			$y = $coord[1]
			
			$coord = PixelSearch($x - 50, $y - 100, $x + 90, $y, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
			If Not @error Then
				TrayTip("", "����������.", 1, 16)
				$x = $coord[0]
				$y = $coord[1]
				;MouseMove($x, $y)
				
				$coord = PixelSearch($x - 50, $y + 5, $x - 10, $y + 50, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
				If Not @error Then
					$x = $coord[0]
					$y = $coord[1] + 5
					MouseMove($x, $y)
					MouseClick("left", Default, Default, 1)
				EndIf
				Sleep(200)
				;MouseClick("left", Default, Default, 1)
				;MouseMove($coord[0] , $coord[1] )
			EndIf
		EndIf
		Sleep(1800)
	EndIf
EndFunc   ;==>ClickLasuke


Func traderepair()
	;If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
	If findPointColor(500, 440, "4C4C4C") = True Then
		TrayTip("", "����װ��.", 1, 16)
		MouseClick("left", 370, 460)
		Sleep(600)
		MouseClick("left", 430, 460)
		Sleep(600)
		Return 1
	Else
		Return 0
	EndIf
	
EndFunc   ;==>traderepair

