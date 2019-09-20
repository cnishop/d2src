AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;AutoItSetOption("MouseClickDelay", 1)

;#include <colormanger.au3>

Global $titlefiremethord
Local $sanctury
Func takefire($var = 1,$time=3)
	Select
		Case $var = 1
			icesor($time)
		Case $var = 2
			firesor()
		Case Else
			fireicesor()
	EndSelect
EndFunc   ;==>takefire


Func icesor($ctime = 3)
	Send("{F2}") ;攻击技能
	Sleep(50)
	
	If $sanctury = 1 Then
		TrayTip("", "雇佣兵带庇护，远距离攻击", 1, 16)
		For $i = 1 To $ctime
			MouseClick("right", 560 + $i * 18, 140 - $i * 15, 1)
			addBloodtorole()
			Sleep(2000)
		Next
	Else
		
		
		Sleep(50)
		For $i = 1 To $ctime Step 1
			Send("{F2}") ;攻击技能
			MouseClick("right", 560 - $i * 15, 140 + $i * 10, 1)
			addBloodtorole()
			Sleep(100)
			Send("{LSHIFT down}") ;攻击技能
			Sleep(100)
			For $j = 1 To 5
				MouseClick("left", 560 - $i * 15, 140 + $i * 10, 1)
				Sleep(150)
			Next
			Sleep(800)
			Send("{LSHIFT up}") ;攻击技能
		Next
		
	EndIf
	
EndFunc   ;==>icesor

Func firesor()
	Send("{F2}") ;攻击技能
	For $i = 1 To 20 Step 1
		addBloodtorole()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(80)
		MouseClick("right", 560, 120, 1, 0)
		Sleep(80)
		MouseClick("right", 560, 110, 1, 0)
		Sleep(80)
	Next

EndFunc   ;==>firesor

Func fireicesor()
	Send("{F2}") ;攻击技能
	For $i = 1 To 20 Step 1
		addBloodtorole()
		MouseClick("right", 540, 130, 1, 0)
		Sleep(100)
		MouseClick("right", 560, 170, 1, 0)
		Sleep(100)
		MouseClick("right", 590, 140, 1, 0)
		Sleep(100)
	Next

	Send("{F3}") ;攻击技能
	For $i = 1 To 3 Step 1
		addBloodtorole()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(1000)
	Next

EndFunc   ;==>fireicesor


Func fire3c($bhtime)
	Local $drinkcount = 0 ; 定义喝药水的间隔，红蓝是慢慢回复的，等2秒后再喝一下
	#CS 	Local $char_Vigor = "F3"      ;活力
		Local $char_Bh = "F1"       ;Bh
		Local $char_normal_attack = "F2"  ;  普通攻击, 不用突击,可能导致会僵直
		Local $char_Conc  = "F4"               ;专注光环
		Local $char_Shift_Down = "LSHIFT down"
		Local $char_Shift_Up = "LSHIFT up"
		Local $char_Alt_Down = "ALT down"
		Local $char_Alt_Up = "ALT up"
	#CE
	Sleep(10)
	Send("{" & $char_normal_attack & "}")
	MouseClick("left", 420, 280, 1)
	Sleep(50)
	Send("{" & $char_Bh & "}")
	Sleep(30)
	Send("{" & $char_Conc & "}")
	Sleep(30)
	Send("{" & $char_Shift_Down & "}")
	Sleep(10)
	MouseClick("left", 400 , 300, 1)
	Sleep(10)
	MouseDown("left")
	TrayTip("", "原地释放BH技能" & $bhtime & "秒.", 1, 16)
	For $i = 1 To $bhtime Step 1
		;MouseClick("left",410 + $i, 300 + $i,5)
		addmanatorole()
		addBloodtorole()

		;MouseClick("left",410 + $i * 3, 300 + $i * 3,3)
		MouseMove(410 + $i * 3, 300 + $i * 3)
		Sleep(1000) ;
		$drinkcount = $drinkcount + 1
		If $drinkcount >= 4 Then
			$drinkhealok = 0
			$drinkmanaok = 0
			$drinkcount = 0
		EndIf
	Next
	MouseUp("left")
	Sleep(10)
	Send("{" & $char_Shift_Up & "}")
	Sleep(10)
	;移动下位置，继续打
	Send("{" & $char_normal_attack & "}")
	Sleep(50)
	MouseClick("left", 360, 340, 1)
	Sleep(50)
	Send("{" & $char_Bh & "}")
	Sleep(50)
	Send("{" & $char_Conc & "}")
	Sleep(50)
	Send("{" & $char_Shift_Down & "}")
	Sleep(10)
	MouseDown("left")
	TrayTip("", "原地释放BH技能" & $bhtime & "秒.", 1, 16)
	For $i = 1 To $bhtime Step 1
		addmanatorole()
		addBloodtorole()
		MouseMove(410 - $i * 3, 300 + $i * 3)
		Sleep(1000) ;打击10秒
		$drinkcount = $drinkcount + 1
		If $drinkcount >= 4 Then
			$drinkhealok = 0
			$drinkmanaok = 0
			$drinkcount = 0
		EndIf
	Next
	MouseUp("left")
	Sleep(10)
	Send("{" & $char_Shift_Up & "}")
	Sleep(10)
EndFunc   ;==>fire3c


