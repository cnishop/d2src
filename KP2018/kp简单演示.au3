
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_Res_Comment=����kpרҵ���һ�����ʾ
#AutoIt3Wrapper_Res_LegalCopyright=QQ:1246035036 *�˶���֮��
#EndRegion ;**** ���������� ACNWrapper_GUI ****

#include <GUIConstantsEx.au3>
Opt("TrayMenuMode", 1) 
; d2
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
$title = "d2"
$usr = ""
$psd = ""
creatGui()
Global $Paused
HotKeySet("{F9}", "TogglePause")
HotKeySet("{F11}", "Terminate")
;;;; Body of program would go here ;;;;
While 1
	Sleep(100)
WEnd
;;;;;;;;
Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		TrayTip("", "ִ���У�", 5)
		runGame()
	WEnd
	TrayTip("", "��ִͣ�У�", 5)
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "�ű������ˣ�", 5)
	Sleep(2000)
	Exit 0
EndFunc   ;==>Terminate
Func creatGui()
	Local $menu1, $n1, $n2, $msg, $menustate, $menutext
	GUICreate("����kpרҵ������ʾ",340,150,400,250) ; ����һ��������ʾ�� GUI ����
	$YesID = GUICtrlCreateButton("����", 80, 20, 50, 20)
	$ExitID = GUICtrlCreateButton("�˳�", 180, 20, 50, 20)
	GUICtrlCreateLabel("���з������ȵ��������������F9��ʼ/��ͣ��F11�˳�", 10, 80, 300, 40)
	GUICtrlCreateLabel("ʹ�÷���:", 10, 50, 300, 20)


	GUICtrlCreateLabel("������Ϸ���������䲢�������겻Ҫ������ʱ��F9", 10, 100, 350, 30)

	GUISetState() ; ��ʾһ���հ׵Ĵ���

	; ���н��棬ֱ�����ڱ��ر�
	Do
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		Select
			Case $msg = $YesID
				ExitLoop
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
		EndSelect
	Until $msg = $GUI_EVENT_CLOSE Or $msg = $ExitID
EndFunc   ;==>creatGui
Func runGame()
	acitveWindow()
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
	#CS
		;����
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
			Sleep(2000)

		Case Else 
			TrayTip("", "���Լ��������������Ϸ��", 5)
			Sleep(6000)

	EndSelect
EndFunc   ;==>runGame

Func acitveWindow()
	; �õ����� "this one" ���ݵļ��±����ڵľ��
	$handle = WinGetHandle($title)
	If @error Then
		MsgBox(32, "����", "û�ҵ����ڴ��ڳ��򣬵�һ�����ȴ򿪰��ڣ�������ѡ�񵥻���ս���Ľ���")
		;Run(@WindowsDir & "\Notepad.exe", "", @SW_MAXIMIZE)
		Exit
	Else
		WinActivate($title)
	EndIf
	$size = WinGetClientSize($title)
	If $size[0] <> 800 And $size[1] <> 600 Then
		MsgBox(0, "��ʾ", "���Ƚ��������ó�800*600")
	EndIf
	;WinMove($title, "", 0, 0)
	Sleep(50)
EndFunc   ;==>acitveWindow

Func roomplay()
	;If isInRoom() Then
	
	findpath(1)
	;finddoor()
	finddoor()
	
	TrayTip("", "��ʾ�����ˣ���", 5, 16)
	Sleep(3000)
	Exit 0
	;EndIf
EndFunc   ;==>roomplay

Func findpath($pathNumber)
	Select
		Case $pathNumber = 1
			TrayTip("", "�ƶ�������..", 5, 16)
			MouseClick("left", 60, 250, 1)
			Sleep(2000)
			MouseClick("left", 40, 250, 1)
			Sleep(2000)
			MouseClick("left", 180, 480, 1)
			Sleep(2000)
			MouseClick("left", 180, 480, 1)
			Sleep(2000)
			MouseClick("left", 100, 450, 1)
			Sleep(2000)
			MouseClick("left", 220, 500, 1)
			Sleep(2000)
			MouseClick("left", 600, 420, 1)
			Sleep(2000)
			MouseClick("left", 700, 400, 1)
			Sleep(2000)
		Case Else 
			TrayTip("", "�ȴ��У����Ժ�", 1, 16)
			Sleep(100)
	EndSelect
EndFunc   ;==>findpath


Func isInRoom($color = 0xB08848) ;��鿴�����·��Ƿ��л�ɫ�����������б�ʾ����Ϸ��
	$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>isInRoom


Func findAreaColor($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	$coord = PixelSearch($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	If Not @error Then
		;MouseMove($coord[0],$coord[1])
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findAreaColor
Func findPointColor($x, $y, $color)
	$var = PixelGetColor($x, $y)
	If Hex($var, 6) = $color Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findPointColor

Func finddoor() ;�Һ��ŵĳ���
	;ѭ���ҳ������ڴ���ָ����������ͬ��ɫ�ĵ�
	$left = 100
	$top = 100
	$right = 500
	$bottom = 400
	Sleep(1000)
	;TrayTip("", "��ʼѰ�Һ���.", 1)
	findredDoor($left, $top, $right, $bottom)
EndFunc   ;==>finddoor
Func findredDoor($left, $top, $right, $bottom)
	$exit = False
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		If getRightPoint($x, $y) Then
			TrayTip("", "�ҵ������ˣ�.", 1,16)
			;MouseMove($x, $y)
			Sleep(1000)
			;MsgBox(0, "", "right")
		Else
			For $k = $left To $right Step 100
				For $j = $top To $bottom Step 100
					;MsgBox(0,"","������")
					;TrayTip("", "��ѯ����." & $k & "" & $j, 1)
					If findNext($k, $j, $right, $bottom) Then
						;MsgBox(0, "", "������һ��")
						TrayTip("", "�ҵ������ˣ�.", 1)
						;MouseMove($k, $j)
						;MouseClick("left", $k, $j, 1)
						;AAA()
						$exit = True
						ExitLoop
					EndIf
					;MsgBox(0, "", "���ң�" & $k & "" & $j)
					If $k >= $right And $j >= $bottom Then
						;MsgBox(0, "", "error")
						TrayTip("", "Ѱ�Һ���ʧ�ܣ��˳�.", 5)
						$exit = True
						ExitLoop
					EndIf
				Next
				If $exit = True Then
					ExitLoop
				EndIf
			Next
		EndIf
	Else
		MsgBox(0, "", "Ѱ�Һ���ʧ��")
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
	If $total >= 20 Then
		MouseMove($xx, $yy)
		MouseClick("left", $xx, $yy, 1)
		Sleep(1000)
		;TrayTip("", "totalΪ��" & $total, 1)
		Return True
		;ElseIf  $total >= 15 Then
		; Return True
	Else
		;TrayTip("", "totalΪ��" & $total, 1)
		Return False
	EndIf
EndFunc   ;==>getRightPoint



