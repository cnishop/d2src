#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_Res_Comment=����kp����,��BOT�����������޷���⵽����ȫ
#AutoIt3Wrapper_Res_LegalCopyright=james
#EndRegion ;**** ���������� ACNWrapper_GUI ****

#include <guidesign.au3>
#include <d2�ͻ���.au3>
#include <colormanger.au3>  ;������ɫ�ĺ���
#include <fireMethord.au3>   ;���������еĺ���
#include <imageSearch.au3> 


; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused
Local $ohterImage = 0
$title = "d2"
;$fire = 0   ;/ / ��ɫ��������,��radio button��ѡ��
$titlefiremethord = $title
$titleImageSearch = $title
If Not _IniVer() Then
	gui()
EndIf


creatGui() ; ��ʼ��������

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
	Sleep(100)
	TrayTip("", "������ڷ�����,��ͣ10�룡", 9, 16)
	Sleep(10000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "���˳�����", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	Dim $optcount = 0 ; ��¼�Ƿ������²�������ʱ����Ϊ�������ȣ����ͣ����һ��δ֪�����ϲ���
	activeWindow()
	initialSize() 
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
 	
   	Sleep(1000)
   	MouseClick("left", 400, 300, 1)
   	Sleep(500)
   	MouseClick("left", 700, 560, 1)
   	Sleep(500)
   	MouseClick("left", 400, 360, 1)
   	Sleep(4000)
   	

	
	;�����ǽ�����Ϸ���ƶ������
	Select
		Case isInRoom()
			roomplay()
			$optcount = $optcount + 1
			Sleep(1000)
		Case waitCreatRoom()
			$optcount = $optcount + 1
			TrayTip("", "׼��������Ϸ����.", 1, 16)
			Sleep(5000)
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
			Sleep(1000)
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
			Exit 0
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
	;WinMove($title, "", 0, 0)
	Sleep(50)
EndFunc   ;==>activeWindow

Func roomplay()
	Select
		Case bagisfull()
			Sleep(100)
			;ContinueCase
		Case roleisdead()
			Sleep(100)
			;ContinueCase
		Case notinfive()
			Sleep(100)
			;ContinueCase
		Case astisdead()
			Sleep(100)
			;ContinueCase
		Case Else
			
			checkbagRev()
			Sleep(100)
			
			findpath(Random(1, 3, 1))
			Sleep(100)
			
			If finddoor() Then
				If isInRoom() Then ;��ֹ���������ܶϿ��˷���
					TrayTip("", "׼��ս��.", 1, 16)
					afterReady()
					TrayTip("", "����BOSS.", 1, 16)
					movekp()
					Sleep(100)
					TrayTip("", "�ͷż���.", 1, 16)
					fire($fire)
					TrayTip("", "Ѱ����Ʒ.", 1, 16)
					finditem()
					TrayTip("", "�˳�����.", 1, 16)
					exitRoom()
				EndIf
			EndIf

	EndSelect
EndFunc   ;==>roomplay




Func findpath($pathNumber)
	TrayTip("", "������š���.", 1, 16)
	Sleep(100)
	Send("{TAB}") ;tab ȥ��С��ͼ
	Select
		Case $pathNumber = 1
			MouseClick("left", 310, 530, 1)
			Sleep(1500)
			MouseClick("left", 700, 480, 1)
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
			
		Case Else
	EndSelect
	Return True
EndFunc   ;==>findpath

Func finditem()
	Send("{ALT down}")
	For $i = 1 To 5 Step 1
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
	takefire($var)
EndFunc   ;==>fire
Func isInRoom($color = 0xB08848) ;��鿴�����·��Ƿ��л�ɫ�����������б�ʾ����Ϸ��
#CS 	$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
   	If Not @error Then
   		Return True
   	Else
   		Return False
   	EndIf
#CE
	If findinroom() Then 
		Return True
	Else
		Return False
	EndIf
	
		
EndFunc   ;==>isInRoom
Func waitLoginNet()
	;����ս�����ж��Ƿ�׼����battle
	;If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
	If findConnect() = True Then
	MouseClick("left", 400, 350)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;����ս�����ж��Ƿ�׼����battle
	;If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
	If findConnectError() Then
		MouseClick("left", 360, 430)
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;����ս�����ж��Ƿ�׼�������˺�����
	;If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
	If findinputpsd() Then
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
	;If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") Then
	If findpsderror() Then
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

	
	;If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
	 If findrole() Then
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
	;If findPointColor(45, 585, "040404") And findPointColor(325, 585, "040404") Then
	If findWaitRoom() Then
		;����ҵ�����ʾ���ڴ���
		;�����䣬�ж��Ƿ���ֶԻ������޷�������ͬ������ʾ���м����ֶԻ���
		Sleep(1000)
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
		If findPointColor(350, 250, "040404") = False Then
			Send("{ENTER}")
			Sleep(500)
			Return True
		Else ;��ʼ��������
			createRoom()
			Return True
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
	ControlSend($title, "", "", Random(10000, 99999, 1))
	;ControlSend($title, "", "","fdsfsdg")
	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Send("{ESC}")
	MouseClick("left", 400, 250, 1)
EndFunc   ;==>exitRoom

Func finddoor() ;�Һ��ŵĳ���
	TrayTip("", "Ѱ�Һ���.", 1, 16)
	Sleep(100)
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 100
	$top = 100
	$right = 400
	$bottom = 400
	;Sleep(1000)


	If findredDoor($left, $top, $right, $bottom) Then
		TrayTip("", "�ҵ����Ų����룡.", 1, 16)
		Return True
	Else
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
	If isInRoom() Then
		TrayTip("", "��鱳���Ƿ�����", 1, 16)
		Send("{B}")
		Sleep(800)
		If findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
			;���������Ʒռ�ã���ʾ��������
			Send("{B}")
			Sleep(500)
			;exitRoom()
			;Sleep(1000)
			If $shutdown = 1 Then ;����û�ѡ���˰������˹ػ�,����ʾ
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "����ִ�йػ�", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
			EndIf
			Return False
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
	;If findPointColor(380, 80, "242424") = False Then ; ��Q�� ,�쿴�Ƿ���act5,û�ҵ���ʾ����act5����ʱȥact5
	If findinAct4() Then
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
	Sleep(100)
	If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
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
	Sleep(10)
	Send("{B}")
	Sleep(500)
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
	For $i = 1 To 3 Step 1
#CS 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
   		If Not @error Then
   			MouseClick("right", $coord[0], $coord[1], 1);
   			Sleep(200)
   		EndIf
#CE
		$coord = findRevInBag() 
		If $coord[0]>=0 And $coord[1]>=0 Then
						MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev

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
	Sleep(1000)
	Send("{F5}") ;tab ȥ��С��ͼ
	Sleep(100)
	MouseClick("right", Default, Default, 1)
	Sleep(1000)
	If $cta = 1 Then
		Send("{W}") ;
		Sleep(500)
		Send("{F7}") ;
		Sleep(500)
		MouseClick("right", Default, Default, 1)
		Sleep(500)
		Send("{F8}") ;
		Sleep(500)
		MouseClick("right", Default, Default, 1)
		Sleep(500)
		Send("{W}") ;
		Sleep(500)
	EndIf
EndFunc   ;==>afterReady




