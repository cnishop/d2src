#region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=����kp����,��BOT�����������޷���⵽����ȫ
#AutoIt3Wrapper_Res_Description=����kp�һ������һ�ר��
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=�˶�������
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#endregion ;**** ���������� ACNWrapper_GUI ****

#include <guidesignanya.au3>
#include <d2�ͻ���.au3>
#include <include.au3>
#include <colormanger.au3>  ;������ɫ�ĺ���
#include <commonUse.au3>
#include <fireMethord.au3>   ;���������еĺ���
#include <checkbag.au3>
#include <findpath.au3>    ;�ܲ�·��
#include <approve.au3>
#include <file.au3>    ;д��log ��־

; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused
Local $ohterImage = 0
Local $emptybag
Local $checkbag = 1
Local $istrade = 0 ;����һ�����λ��0 û���׹���1 ���׹�
Local $round = 0 ; kp����ͳ��
$title = "d2"
;$fire = 0   ;/ / ��ɫ��������,��radio button��ѡ��
$titlefiremethord = $title
Local $parm_boxing ;�Ƿ�װ��
Local $parm_boxqty ;���������ĸ���
Local $parm_namelenfr, $parm_namelento
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime
Local $parm_ramevent, $parm_kprounctime, $parm_rantime

Local $tfcount = 0 ; �л��˺�ǰ���˺ŵ��ۻ�kp���� ������

Local $errCount = 0 ;����һ��û���ҵ����ţ�������ѭ���ļ�����
Local $parm_firstdate, $parm_kpcount ;�ܵ�kp���������������¸��ͻ�
Local $parm_othercheck, $parm_staymin



Local $acountArray[2] ;���ڰ��ʺ�

$bindmac = 1 ;�󶨻���
$bindacc = 0 ;���ʺ�
$bindlimitCount = 0 ;  �󶨴���  ---���Ը�֪���û��Ĳ��Դ���,���԰�����ô˿���
$limitRound = 5;�����һ�����
$bindTime = 0 ;���ݿ��еĴ���  ;ֻ���԰��õ�

$ranLimte = Random(-14, 14, 1) ;���������Ƶ�ǰ��Χ   ������� 80-20 ���� 80+20
;$ranLimte=0


If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "��ʾ", "δ֪��������")
	Exit 0
EndIf

If $bindmac = 1 Then
	If Not _IniVer() Then ; �󶨻���
		gui()
	EndIf
EndIf
;$parm_bhtime = $guibhTime



creatGui() ; ��ʼ��������

$parm_boxing = $guiboxing
$parm_boxqty = $guiboxqty
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_drinkrej_plus = $guidrinkrej
$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime

$parm_othercheck = $guiothercheck
$parm_staymin = $guistaymin

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
	Sleep(10)
	TrayTip("", "������ڷ�����,��ͣ30�룡", 9, 16)
	Sleep(30000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "���˳�����", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	
	;-------------------
	;���Ӷ԰��ʺŵ����ƣ�                                    1. ���ʺŵ�����
	If $bindacc = 1 Then
		$acountArray[0] = "iamhix"
		$acountArray[1] = "iamhix"
		If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
			;writelog("�ڵ�" & $other_traced_round + 1 & "�����˽��뷿��")
			MsgBox(4096, " ...... ��ʾ ...... ", "��󶨵��ʺŲ��������ȷ��")
			Exit 0
		EndIf
	EndIf
	;------------------                                          ��ÿ�����ʹ�ô���
	If $bindlimitCount = 1 Then
		;If $round >= $limitRound + $ranLimte Then
		If $round >= $limitRound Then ;���԰�
			writelog("�ﵽѭ�����ƴ���")
			MsgBox(4096, " ..... ��ܰ��ʾ .........", "�Ѵ�ѭ�����ƴ���,����Ϣ���ٹһ�" & @CRLF & "��ʹ�����޴ΰ�")
			Exit 0
		EndIf
	EndIf
	
	;���Ӷ����ʹ�ô��������� ----------------                 .���ݿ���ʹ�ô�������
	;SQLiteFirstUpateDate()
	;SQLiteRead(102)
	$parm_firstdate = $app_date
	$parm_kpcount = $app_kpcount
	
	
	Dim $optcount = 0 ; ��¼�Ƿ������²�������ʱ����Ϊ�������ȣ����ͣ����һ��δ֪�����ϲ���
	If $parm_settime = 1 Then ;check if set tiem to shutdown
		tiemtoshut($parm_timedata)
	EndIf
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

	#CS 		Sleep(1000)
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
			roomplay()
			$optcount = $optcount + 1
			Sleep(1000)
		Case waitCreatRoom()

			$optcount = $optcount + 1
			TrayTip("", "׼��������Ϸ����.", 1, 16)
			Sleep(4000)
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
			Sleep(10)
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
				$PID = ProcessExists("D2loader.exe") ; Will return the PID or 0 if the process isn't found.
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
	$size = WinGetClientSize($title)
	If $size <> 0 Then ;�ҵ�����
		If $size[0] <> 800 And $size[1] <> 600 Then
			MsgBox(0, "��ʾ", "���Ƚ��������ó�800*600")
			Exit 0
		EndIf
	Else
		MsgBox(0, "��ʾ", "û���ҵ���Ϸ����.")
	EndIf
	WinMove($title, "", 20, 20)
	Sleep(50)
EndFunc   ;==>activeWindow

Func roomplay()
	$roombegintime = _NowCalc()
	$inRoomDateCalc = _DateDiff('n', $roombegintime, _NowCalc())
	If $inRoomDateCalc >= $parm_staymin Then
		exitroom()
		writelog("������ʱ��---�� " & $round & " ����ʱ: " & $inRoomDateCalc & " ���˳�")
	EndIf
	

	#CS 	If $parm_ramevent = 1 Then
		getRam() ;��ȡ����¼�
		EndIf
	#CE
	
	#CS 	If $guidrinkrej = 1 Then
		checkbagRev()
		;drinksurplusInbag("0x943030")
		;drinksurplusInbag("0x1828A4")
		
		EndIf
	#CE
	#CS 			If $round>= 6 Then
		MsgBox(0, "��ʾ", "ѭ�������ѵ���������⣬��ȷ�ϸ����ʽ�潫������")
		Exit
		EndIf
	#CE
	Select
		Case $istrade = 0 And findleftdoor() = False And findrightdoor() = False ;flag=0 ��������Ҷ�û���ţ������·�ȥ�Һ���
			$errCount = $errCount + 1
			TrayTip("", "�޺��ţ�û���ҵ�anya���� " & $errCount, 1, 16)
			If $errCount >= 4 Then
				$errCount = 0 ;���� 0
				exitroom()
				Return
			EndIf
			Sleep(500)
			If $parm_boxing = 1 And bagisfull() Then ;�����Ҫװ�䣬��ȥװ��
				Return
			EndIf
			findpath(20)
			Sleep(100)
			If findleftdoor() = True Then
				;������
				$istrade = 1 ; �����ź󣬾ͽ����Ϊ��Ϊ 1
			Else
				Sleep(500)
				exitRoom()
				Sleep(500)
			EndIf
			
		Case $istrade = 0 And findleftdoor() = True And findanya() = False ;����к��ţ��а���,�Ұ��ǽ���
			TrayTip("", "����ţ��а���", 1, 16)
			clickleftdoor()
			clickAnya()
			Sleep(100)
			clickTrade()
			Sleep(100)
			findanyaItem()
			Sleep(100)
			$round = $round + 1
			$tfcount = $tfcount + 1
			_GUICtrlStatusBar_SetText($StatusBar1, "shop����: " & $round & "  �ۼ�shop������ " & $parm_kpcount + 1, 1)
			$parm_kpcount = $parm_kpcount + 1
			
;~ 			Sleep(500)
;~ 			If $parm_othercheck = 1 Then ;�����ź��� ���˽��뷿��
;~ 				If checkotherin() = True Then
;~ 					Return
;~ 				EndIf
;~ 			EndIf
			
		Case $istrade = 0 And findrightdoor() = True And findanya() = True ;�ұ��к��ţ��а���,�Ұ��ǽ���
			TrayTip("", "�Һ��ţ��а���", 1, 16)
			clickAnya()
			Sleep(50)
			clickTrade()
			Sleep(50)
			findanyaItem()
			Sleep(50)
			$round = $round + 1
			$tfcount = $tfcount + 1
			_GUICtrlStatusBar_SetText($StatusBar1, "shop����: " & $round & "  �ۼ�shop������ " & $parm_kpcount + 1, 1)
			$parm_kpcount = $parm_kpcount + 1
			
		Case $istrade = 1 And findrightdoor() = True ;flag=1 ,  �ұ��к��ţ�����ұߺ��ţ�����flagΪ0
			TrayTip("", "�Һ��ţ��ѽ��ף�ȥҰ��", 1, 16)
			clickrightdoor()
			If findleftdoor() = True Then ;��ʾ����ߺ��ųɹ�
				$istrade = 0
			EndIf
			
			
		Case $istrade = 1 And findleftdoor() = True ;flag=1 ,  ����к��ţ�����ߺ��ţ�����flagΪ0
			TrayTip("", "����ţ��ѽ��ף�ȥҰ��", 1, 16)
			clickleftdoor()
			If findleftdoor() = True Then ;��ʾ����ߺ��ųɹ�
				$istrade = 0
			EndIf
			Sleep(10)
			
		Case Else
			TrayTip("", "�����쳣", 1, 16)
			Sleep(10)
	EndSelect
EndFunc   ;==>roomplay



#CS
	Func findpath($pathNumber)
	TrayTip("", "������š���.", 1, 16)
	Sleep(100)
	Send("{TAB}") ;tab ȥ��С��ͼ
	Select
	Case $pathNumber = 1
	MouseClick("left", 310, 530, 1)
	Sleep(1500)
	MouseClick("left", 700, 460, 1)
	Sleep(1300)
	MouseClick("left", 110, 460, 1)
	Sleep(1100)
	MouseClick("left", 60, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 280, 1)
	Sleep(1100)
	Case $pathNumber = 2
	MouseClick("left", 60, 250, 1)
	Sleep(1100)
	MouseClick("left", 40, 250, 1)
	Sleep(1100)
	MouseClick("left", 180, 480, 1)
	Sleep(1200)
	MouseClick("left", 180, 480, 1)
	Sleep(1200)
	MouseClick("left", 100, 450, 1)
	Sleep(1200)
	MouseClick("left", 220, 500, 1)
	Sleep(1000)
	MouseClick("left", 600, 420, 1)
	Sleep(800)
	MouseClick("left", 700, 400, 1)
	Sleep(800)
	Case $pathNumber = 3
	MouseClick("left", 200, 500, 1)
	Sleep(1400)
	MouseClick("left", 750, 430, 1)
	Sleep(1400)
	MouseClick("left", 380, 480, 1)
	Sleep(800)
	MouseClick("left", 100, 350, 1)
	Sleep(1000)
	MouseClick("left", 130, 470, 1)
	Sleep(1000)
	MouseClick("left", 50, 430, 1)
	Sleep(1000)
	MouseClick("left", 65, 280, 1)
	Sleep(800)
	Case $pathNumber = 4
	MouseClick("left", 60, 250, 1)
	Sleep(1400)
	MouseClick("left", 30, 250, 1)
	Sleep(1600)
	MouseClick("left", 190, 480, 1)
	Sleep(1300)
	MouseClick("left", 190, 480, 1)
	Sleep(1300)
	MouseClick("left", 100, 450, 1)
	Sleep(1300)
	MouseClick("left", 210, 500, 1)
	Sleep(1300)
	MouseClick("left", 600, 420, 1)
	Sleep(1300)
	MouseClick("left", 600, 400, 1)
	Sleep(1400)
	Case $pathNumber = 5
	MouseClick("left", 290, 510, 1)
	Sleep(1700)
	MouseClick("left", 620, 340, 1)
	Sleep(1300)
	MouseClick("left", 500, 460, 1)
	Sleep(1000)
	MouseClick("left", 60, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 280, 1)
	Sleep(1100)
	Case Else
	EndSelect
	Return True
	EndFunc   ;==>findpath
#CE

Func finditem($parm_picktime)
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		$coord = PixelSearch(0, 0, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
			TrayTip("", "������Ҫ����Ʒ", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			Sleep(1500)
		EndIf
		Sleep(100)
	Next
	Send("{ALT up}")
EndFunc   ;==>finditem
Func movekp()
	Send("{F1}") ;
	Sleep(100)
	MouseClick("right", 740, 120, 1)
	Sleep(600)
	MouseClick("right", 740, 110, 1)
	Sleep(600)
	MouseClick("right", 540, 80, 1)
	Sleep(600)
	MouseClick("right", 590, 140, 1)
	Sleep(600)
EndFunc   ;==>movekp
Func fire($var = 1)
	takefire($var, $parm_blztime)
EndFunc   ;==>fire
Func isInRoom($color = 0xB08848) ;��鿴�����·��Ƿ��л�ɫ�����������б�ʾ����Ϸ��
	If findPointColor(30, 585, "040404") = False Then
		$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
		If Not @error Then
			Return True
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>isInRoom
Func waitLoginNet()
	;����ս�����ж��Ƿ�׼����battle
	If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
		MouseClick("left", 400, 350)
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
		Sleep(1000)
		MouseClick("left", 400, 390, 2)
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

		For $i = 1 To $roomcount
			$str = $str & Chr(Random(97, 105, 1))
		Next
		ControlSend($title, "", "", $str)
	Else
		
		ControlSend($title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
	EndIf

	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Send("{ESC}")
	MouseClick("left", 400, 250, 1)
EndFunc   ;==>exitRoom

;���潲�Һ��ź͵�����ŷֿ������Ա�����ϸ���ж�
Func findleftdoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ�Һ���.", 1, 16)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 200
	$top = 200
	$right = 400
	$bottom = 300
	;Sleep(1000)
	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;���жϺ����Ƿ�������λ��
	If Not @error Then
		TrayTip("", "��λ��ߺ��ţ���һ�Σ�.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;Sleep(50)
		;MouseMove(400, 300)
		;MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;Ϊ��ֹ�������أ�������С��Χ������ͬ�ĵ�
		$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $title)
		If Not @error Then
			TrayTip("", "��λ��ߺ��ţ��ڶ��Σ�.", 1, 16)
			$x = $coord[0] + 5
			$y = $coord[1] + 5
			;MouseMove($x, $y)
			;Sleep(100)
			Return True
		Else
			Return False
			;���û�ҵ����ţ��������ұߵĺ���
		EndIf
	Else
		TrayTip("", "��ߺ���δ�ҵ���.", 1, 16)
		;Sleep(50)
		Return False
	EndIf
	
EndFunc   ;==>findleftdoor

Func clickleftdoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ����ߺ���.", 1, 16)
	;Sleep(10)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 200
	$top = 200
	$right = 400
	$bottom = 300
	;Sleep(1000)
	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;���жϺ����Ƿ�������λ��
	If Not @error Then
		TrayTip("", "�ҵ���ߺ��ţ������ţ�.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;MouseMove(400, 300)
		;Sleep(50)
		MouseClick("left", $x + 5, $y + 10, 1)
		Sleep(2000)
		MouseMove(400 + Random(1, 10), 300 + + Random(1, 10))
		Sleep(5)
	Else
		TrayTip("", "����ߺ��ų���.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
EndFunc   ;==>clickleftdoor

Func findrightdoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ���ұߺ���.", 1, 16)
	;Sleep(10)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 410
	$top = 310
	$right = 600
	$bottom = 500
	;Sleep(1000)
	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;���жϺ����Ƿ�������λ��
	If Not @error Then
		TrayTip("", "��λ�ұߺ��ţ���һ�Σ�.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;Sleep(50)
		;MouseMove(400, 300)
		;MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;Ϊ��ֹ�������أ�������С��Χ������ͬ�ĵ�
		$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $title)
		If Not @error Then
			TrayTip("", "��λ�ұߺ��ţ��ڶ��Σ�.", 1, 16)
			$x = $coord[0] + 5
			$y = $coord[1] + 5
			;MouseMove($x, $y)
			;Sleep(100)
			Return True
		Else
			Return False
			;���û�ҵ����ţ��������ұߵĺ���
		EndIf
	Else
		TrayTip("", "�ұߺ���δ�ҵ���.", 1, 16)
		Sleep(50)
		Return False
	EndIf
	
EndFunc   ;==>findrightdoor

Func clickrightdoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ���ұߺ���.", 1, 16)
	;Sleep(10)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 410
	$top = 310
	$right = 600
	$bottom = 500
	;Sleep(1000)
	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;���жϺ����Ƿ�������λ��
	If Not @error Then
		TrayTip("", "�����ұߺ��ţ�.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;MouseMove(400, 300)
		;Sleep(50)
		MouseClick("left", $x + 5, $y + 10, 1)
		Sleep(2000)
		MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
		Sleep(10)
	Else
		TrayTip("", "���ұߺ��ų���.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
EndFunc   ;==>clickrightdoor




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
		Sleep(1000)
		

		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;���������Ʒռ�ã���ʾ��������
			TrayTip("", "�����ռ����: " & $emptybag & " ���������õĸ���: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{B}")
			Sleep(500)
			If $boxisfull = 0 Then ;�����¼�ֿ������ı�ʾ =1 ����ʾ���ˣ��Ͳ����ٴ�ֿ��0 ȥ��ֿ�
				gotoBox()
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
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 10 Then ;����û�ѡ���˰������˹ػ�,����ʾ
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

#CS Func bagisfull()
	If isInRoom() = True And $checkbag = 1 Then
	Send("{B}")
	Sleep(100)
	MouseMove(300, 340)
	Sleep(100)
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
	gotoBox()
	If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
	movebagtoBox()
	Else
	exitRoom()
	Return True
	EndIf
	If $shutdown = 1 And isInRoom() And $allfull Then ;����û�ѡ���˰������˹ػ�,����ʾ
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
	TrayTip("", "�˳�����", 1, 16)
	Sleep(500)
	exitRoom()
	$checkbag = 0
	Return True
	ElseIf isInRoom() And $allfull = False Then
	TrayTip("", "�˳�����", 1, 16)
	Sleep(100)
	exitRoom()
	Return True
	EndIf
	
	Else
	Send("{B}")
	Return False
	EndIf
	Else
	Return False
	EndIf
	EndFunc   ;==>bagisfull
#CE

Func chkbagisfull()
	;Send("{B}")
	Sleep(10)
	MouseMove(300, 100)
	Sleep(00)
	$emptybag = getbagLocation()
	TrayTip("", "��鱳��ʣ��������" & $emptybag, 1, 16)
	Sleep(10)
	;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
		;���������Ʒռ�ã���ʾ��������
		TrayTip("", "�����ռ����: " & $emptybag & " ���������õĸ���: " & $parm_boxqty, 1, 16)
		Sleep(1000)
		;Send("{B}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>chkbagisfull


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
		Sleep(1000)
		exitRoom()
		Return True
	Else
		Send("{Q}") ;tab ȥ��С��ͼ
		Return False
	EndIf
	
EndFunc   ;==>notinfive


Func astisdead()
	TrayTip("", "���pet����û", 1, 16)
	Sleep(50)
	If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
		TrayTip("", "pet���ˣ�������", 1, 16)
		Sleep(500)
		resumepet()
		exitRoom()
		Return True
	Else
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
	Sleep(300)
	;addrevtobag()
	drinksurplusrev()
	Send("{B}")
	Sleep(100)
	;If 1 = 1 Then
	;	Return True
	;Else
	;	Return False
	;EndIf
EndFunc   ;==>checkbagRev

Func drinksurplusrev() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ�
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
		If Not @error Then
			checkzise("0x682070")
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev

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
	Sleep(800)
	Send("{F5}") ;tab ȥ��С��ͼ
	Sleep(100)
	MouseClick("right", Default, Default, 1)
	Sleep(700)
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


Func gotoBox()
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
	
EndFunc   ;==>gotoBox

Func getRam()

	;_GUICtrlStatusBar_SetText($StatusBar1, "KP������" & $round & " ����ӳ�: " & $tfcount, 1)
	If $tfcount >= $parm_kprounctime Then ; �л��˺ź� ѭ������Ҳ���ڹ涨��
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

Func backdoortotown()
	TrayTip("", "Ѱ�Һ���.", 1, 16)
	Sleep(10)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 250
	$top = 180
	$right = 400
	$bottom = 300
	;Sleep(1000)

	;���win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "�ҵ����ţ�׼���سǣ�.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		Sleep(1000)
		Return True
	Else
		TrayTip("", "����δ�ҵ���.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
	
EndFunc   ;==>backdoortotown

Func clickAnya()
	TrayTip("", "Ѱ�Ұ��ǣ�.", 1, 16)
	;Sleep(10)
	$coord = PixelSearch(100, 30, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		TrayTip("", "�ҵ������ˣ������ǣ�.", 1, 16)
		$x = $coord[0] + 20
		$y = $coord[1] + 50
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", $x, $y, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(2000)
	EndIf
EndFunc   ;==>clickAnya

Func clickTrade() ;�ҵ����Ǻ󣬵㽻��
	$coord = PixelSearch(100, 10, 400, 300, 0x1CC40C, 30, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
	If Not @error Then
		TrayTip("", "���н��ף�", 1, 16)
		;MouseClick("right", $coord[0], $coord[1], 1);
		MouseMove($coord[0] + 50, $coord[1] + 40)
		Sleep(50)
		MouseClick("left", Default, Default, 1)
		Sleep(200)
	EndIf
EndFunc   ;==>clickTrade

Func findanyaItem()
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
		$istrade = 1 ;  �򿪽��״��ڵ�ģʽ�£� ���Ϊ��Ϊ 1
		If chkbagisfull() Then
			Send("{ESC}")
			Sleep(1000)
			exitRoom()
		EndIf
		TrayTip("", "Ѱ����Ʒ.", 1, 16)
		Sleep(10)
		;MouseMove(400,300)
		;Sleep(100)
		;�ڰ��ǵĽ��״�����
		$left = 100
		$top = 120
		$right = 380
		$bottom = 410
		;Sleep(1000)

		;���win7
		$coord = PixelSearch($left, $top, $right, $bottom, 0x682070, 10, 1, $title)
		If Not @error Then
			TrayTip("", "�ҵ��ö����ˣ�.", 1, 16)
			Sleep(10)
			$x = $coord[0]
			$y = $coord[1]
			MouseMove($x, $y)
			Sleep(200)
			;�������򵽱������˴���Ҫ��һ���жϣ����Ǯ�����򱳰����ˣ�����δ���
			MouseClick("right", Default, Default, 1)
			Sleep(50)
			MouseMove(400, 300)
			Sleep(50)
			;MouseClick("left", $x, $y, 1)
			writelog("��Ʒ---�ڵ�" & $round & "ˢ������")
			If findPointColor($x, $y, "682070") Then
				TrayTip("", "û�й���ɹ���������������Ǯ�����ˣ�.", 1, 16)
				writelog("��Ʒ---�ڵ�" & $round & "�޷�����")
				Exit
			EndIf
			Send("{ESC}")
			Sleep(1500)
			Return True
		Else
			TrayTip("", "û�ҵ��ö�������������.", 1, 16)
			Sleep(10)
			Send("{ESC}")
			Return False
		EndIf
	EndIf
EndFunc   ;==>findanyaItem

Func findanya() ;; ��Ҫ�����ǵ�����վ�ڰ��ǵ�λ�����ж�
	$coord = PixelSearch(100, 10, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		;$x = $coord[0]
		;$y = $coord[1]
		;MouseMove($x, $y)
		TrayTip("", "�ҵ�anya��.", 1, 16)
		Sleep(10)
		Return True
	Else
		TrayTip("", "û���ҵ�anya��.", 1, 16)
		Sleep(500)
		Return False
	EndIf
EndFunc   ;==>findanya

Func findanyadoor()
	$coord = PixelSearch(200, 200, 400, 300, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		;$x = $coord[0]
		;$y = $coord[1]
		;MouseMove($x, $y)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findanyadoor

Func checkotherin()
	;TrayTip("", "����Ƿ������˽���", 1, 16)
	Sleep(10)
	MouseMove(400, 300)
	Sleep(50)
	Send("{P}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		Send("{P}") ;�رն������
		If $b <> 3299051709 Then ;��ʾ�б䶯��,�����������˽��뷿����
			
			#CS 			If $parm_otherroundtrace = 1 Then ;�Ƿ����ù涨�����Զ����߹���
				If $round + 1 - $other_traced_round <= 10 Then ;����10�����ھ������α�׷�٣���ʾ�е�Σ���ˣ�
				writelog("�����˽�����---�ڵ�" & $round + 1 & "�ֽ��뷿�䣬����10��֮��2�ν��룬ֹͣ�һ���")
				exitRoom()
				Sleep(Random(200, 1000, 1))
				Exit 0
				EndIf
				EndIf
			#CE
			
			
			writelog("�����˽�����---�ڵ�" & $round & "�ֽ��뷿��")
			_GUICtrlStatusBar_SetText($StatusBar1, "ע����İ�����ڵ� " & $round & "  �ֽ�����ķ��� ", 0)
			
			exitRoom()
			Sleep(Random(200, 1000, 1))

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
