AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

Func whichAct()
;~ 	
;~ 	TrayTip("", "����ڵڼ�Ļ", 1, 16)
;~ 	Sleep(100)
;~ 	Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 	Sleep(200)
;~ 	If findPointColor(260, 430, "141414") And findPointColor(300, 430, "141414") Then
;~ 		Select
;~ 			Case findPointColor(130, 80, "2C2C2C") = True
;~ 				TrayTip("", "��ACT1", 1, 16)
;~ 				Sleep(10)
;~ 				Send("{" & $char_Q & "}")
;~ 				Return "A1"
;~ 			Case findPointColor(200, 80, "303030") = True
;~ 				TrayTip("", "��ACT2", 1, 16)
;~ 				Sleep(10)
;~ 				Send("{" & $char_Q & "}")
;~ 				Return "A2"
;~ 			Case findPointColor(260, 80, "2C2C2C") = True
;~ 				TrayTip("", "��ACT3", 1, 16)
;~ 				Sleep(10)
;~ 				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 				Return "A3"
;~ 			Case findPointColor(320, 80, "404040") = True
;~ 				TrayTip("", "��ACT4", 1, 16)
;~ 				Sleep(10)
;~ 				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 				Return "A4"
;~ 			Case findPointColor(380, 80, "242424") = True
;~ 				TrayTip("", "��ACT5", 1, 16)
;~ 				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 				Sleep(10)
;~ 				Return "A5"
;~ 				
;~ 			Case Else
;~ 				TrayTip("", "�����κ�һĻ", 1, 16)
;~ 				Sleep(10)
;~ 				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 				Return "A6"
;~ 		EndSelect
;~ 	Else
;~ 		TrayTip("", "���ҳ�������", 1, 16)
;~ 		Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
;~ 		Return "A6"
;~ 	EndIf

;����ͨ��ȡ���ж�
	If isInRoom() Then
		
		$coord = PixelSearch(200, 200, 380, 400, 0x118FB01, 25, 2, $title)
		If Not @error Then ;�ҵ���ɫ�� ������ͬһˮƽ���Ƿ��а�ɫ
			; �ٴμ���·���û�зſ��Ŷ�
			Return "A3"
		Else
			Return "A6"
		EndIf
		
	Else
		Return "A6" ;��������ڷ����ڣ��ͷ���
	EndIf
	
EndFunc   ;==>whichAct



Func drinksurplusrev() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ䣬bag
	TrayTip("", "�������˲��ظ�ҩˮ", 1, 16)
	Sleep(10)
	Send("{B}")
	Sleep(300)
	For $i = 1 To 3 Step 1
		#CS 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
			If Not @error Then
			MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
			EndIf
		#CE
		$coord = findRevInBag()
		;$coord = finda3townwp()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
			MouseMove(400, 300)
			Sleep(10)
		EndIf
	Next
	Send("{B}")
	Sleep(100)
EndFunc   ;==>drinksurplusrev

Func drinksurplusHeal() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ䣬bag
	TrayTip("", "������ĺ�ҩˮ", 1, 16)
	Sleep(10)
	Send("{B}")
	Sleep(300)
	For $i = 1 To 10 Step 1

		$coord = findHealInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
			MouseMove(400, 300)
			Sleep(10)
		EndIf
	Next
	Send("{B}")
EndFunc   ;==>drinksurplusHeal

Func drinksurplusMana() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ䣬bag
	TrayTip("", "���������ҩˮ", 1, 16)
	Sleep(10)
	Send("{B}")
	Sleep(300)
	For $i = 1 To 10 Step 1

		$coord = findManaInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
			MouseMove(400, 300)
			Sleep(10)
		EndIf
	Next
	Send("{B}")
EndFunc   ;==>drinksurplusMana

Func checkRejInBeltrow() ;�������һ�����
	$coord = PixelSearch(420, 565, 540, 590, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ�����ƿ
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>checkRejInBeltrow


Func checkRejQtyInBelt()
	;TrayTip("", "��������ڵ���ƿ����", 1, 16)
	Send("{~}")
	Sleep(100)
	For $i = 0 To 3 Step 1
		For $j = 0 To 3 Step 1
			$coord = PixelSearch($xbeltarray[$i][0], $ybeltarray[$j][0], $xbeltarray[$i][1], $ybeltarray[$j][1], 0x682070, 10, 1, $title) ; ��belt�ռ䷶Χ�ڲ���
			If Not @error Then
				;MouseClick("right", $coord[0], $coord[1], 1);
				;MouseMove($coord[0], $coord[1])
				;Sleep(300)
				;MouseMove(400,300,1)
				;Sleep(100)
				$int_beltRej = $int_beltRej + 1
			EndIf
			
			
		Next
	Next
	Send("{~}")
	TrayTip("", "��������ڵ���ƿ������" & $int_beltRej, 1, 16)
	Sleep(1000)
	Return $int_beltRej
	
	
EndFunc   ;==>checkRejQtyInBelt


Func a3clickrade() ;�������һ�����
	$coord = PixelSearch(100, 100, 500, 300, 0xC4C4C4, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ�����ƿ
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(200)
	EndIf
EndFunc   ;==>a3clickrade



Func addBloodtorole() ;0x943030
	; (70, 550) ; 5C0000   50%
	; (70, 530) ; 5C0000   75%
	$drinkheal = 1
	If findPointColor(70, 530, "5C0000") = False And findPointColor(70, 530, "18480C") = False And $drinkhealok = 0 Then
		TrayTip("", "��Ѫ�ˣ��ȵ��ҩˮ..", 1, 16)
		If drinkWater("heal", "0xA42818", "��������û����ͨ�ĺ�ҩˮ") = False Then ;�Ӻ�ʧ��
			If drinkWater("rej", "0x682070", "��������Ҳû����ƿ") = False Then ;�Ӵ�ƿ
				$drinkheal = 0
			EndIf
		EndIf
	EndIf
	If $drinkheal = 0 Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>addBloodtorole

Func addmanatorole() ;0x1828A4
	$drinkmana = 1
	If findPointColor(735, 580, "0C0C28") = False And $drinkmanaok = 0 Then
		TrayTip("", "����û�ˣ��ȵ���ҩˮ..", 1, 16)
		If drinkWater("mana", "0x303094", "��������û����ͨ����ҩˮ") = False Then ;�Ӻ�ʧ��
			If drinkWater("rej", "0x682070", "��������Ҳû����ƿ") = False Then ;�Ӵ�ƿ
				$drinkmana = 0
			EndIf
		EndIf
	EndIf
	
	If $drinkmana = 0 Then
		Return 0
	Else
		Return 1
	EndIf
	
EndFunc   ;==>addmanatorole

Func addBloodtopet() ;��Ӷ����Ҫ��SHIFT +���� ��Ѫ
	;act3 :          FC2C00              ,         D08420              ,     186408
	;If findPointColor(18, 17, "F0041C") = False And findPointColor(18, 17, "D08420") = False And findPointColor(18, 17, "008400") = False Then
	If findPointColor(18, 17, "FC2C00") = False And findPointColor(18, 17, "D08420") = False And findPointColor(18, 17, "186408") = False Then
		;TrayTip("", "û��Ӷ��..", 1, 16)
	Else
		If findPointColor(40, 17, "186408") = False Then
			Send("{LSHIFT down}")
			TrayTip("", "��Ӷ����Ѫ�ˣ��ȵ�ҩˮ..", 1, 16)
			If drinkWater("heal", "0xA42818", "��������û����ͨ�ĺ�ҩˮ") = False Then ;�Ӻ�ʧ��
				drinkWater("rej", "0x682070", "��������û����ƿ") ;�Ӵ�ƿ
			EndIf
			Send("{LSHIFT up}")
		EndIf
	EndIf
EndFunc   ;==>addBloodtopet



Func drinkrej()
	$drink = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    ��һ���촰
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; ��2���촰��
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; ��3���촰��
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; ��4���촰��
		Select
			Case $i = 1 And $drink = 0
				$coord = PixelSearch(420, 565, 450, 590, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{1}")
					$drink = 1
				EndIf
			Case $i = 2 And $drink = 0
				$coord = PixelSearch(455, 565, 480, 590, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{2}")
					$drink = 1
				EndIf
			Case $i = 3 And $drink = 0
				$coord = PixelSearch(485, 565, 510, 590, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{3}")
					$drink = 1
				EndIf
			Case $i = 4 And $drink = 0
				$coord = PixelSearch(515, 565, 540, 590, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{4}")
					$drink = 1
				EndIf
		EndSelect
	Next
	If $drink = 0 Then ;���һ����ظ�ҩˮ��û�ҵ��������ˡ����ҵ�һ��������hackmap����ΪѪ����
		TrayTip("", "������û�д��.", 1, 16)
		Send("{1}")
		Send("{2}")
		Send("{3}")
		Send("{4}")
	EndIf
EndFunc   ;==>drinkrej



Func drinkWater($cat, $color, $message)
	$drink = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    ��һ���촰
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; ��2���촰��
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; ��3���촰��
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; ��4���촰��
		Select
			Case $i = 1 And $drink = 0
				If findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "�ȵ�" & $i & "��", 1, 16)
					Send("{1}")
					$drink = 1
				EndIf
			Case $i = 2 And $drink = 0
				If findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "�ȵ�" & $i & "��", 1, 16)
					Send("{2}")
					$drink = 1
				EndIf
			Case $i = 3 And $drink = 0
				If findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "�ȵ�" & $i & "��", 1, 16)
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{3}")
					$drink = 1
				EndIf
			Case $i = 4 And $drink = 0
				If findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "�ȵ�" & $i & "��", 1, 16)
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{4}")
					$drink = 1
				EndIf
		EndSelect
	Next
	If $drink = 0 Then ;���һ����ظ�ҩˮ��û�ҵ��������ˡ����ҵ�һ��������hackmap����ΪѪ����
		TrayTip("", $message, 1, 16)
		Sleep(500)
		Return False
	Else
		If $cat = "heal" Then
			$drinkhealok = 0
		ElseIf $cat = "mana" Then
			$drinkmanaok = 0
		EndIf
		Return True
	EndIf

EndFunc   ;==>drinkWater


Func findbeltWater($cat, $color)
	$needshop = 0 ;����֪����Ҫshop�ı�־
	$belt1 = 0
	$belt2 = 0
	$belt3 = 0
	$belt4 = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    ��һ���촰
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; ��2���촰��
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; ��3���촰��
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; ��4���촰��
		Select
			Case $i = 1
				If findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt1 = 1
				EndIf
			Case $i = 2
				If findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt2 = 1
				EndIf
			Case $i = 3
				If findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt3 = 1
				EndIf
			Case $i = 4
				If findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "��" & $i & "����ҩˮ", 1, 16)
					$belt4 = 1
				EndIf
		EndSelect
	Next
	
	If $cat = "heal" Then
		If $belt1 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "1����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[0][0] + 5, $ybeltarray[3][0] + 5)
				Sleep(200)
			Next
			$needshop = 1
		EndIf
		
		If $belt2 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "2����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[1][0] + 5, $ybeltarray[3][0] + 5)
				Sleep(200)
			Next
			$needshop = 1
		EndIf
		
		
		
	ElseIf $cat = "mana" Then
		
		If $belt3 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "3����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[2][0] + 5, $ybeltarray[3][0] + 5)
				Sleep(200)
			Next
			$needshop = 1
		EndIf
		
		If $belt4 = 0 Then ;��һ�пգ���ʾ��Ҫ������
			TrayTip("", "4����ҩˮΪ����", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[3][0] + 5, $ybeltarray[3][0] + 5)
				Sleep(200)
			Next
			$needshop = 1
		EndIf
		
	EndIf
	
	If $needshop = 1 Then
		Return 0
	Else
		Return 1
	EndIf



EndFunc   ;==>findbeltWater



Func tiemtoshut($date)
	$nowSec = _DateDiff('n', "2011/01/01 00:00:00", _NowCalc())
	$setSec = _DateDiff('n', "2011/01/01 00:00:00", $date)
	If $setSec >= $nowSec - 2 And $setSec <= $nowSec + 2 Then
		TrayTip("", "ִ�ж�ʱ�ػ�..", 1, 16)
		Sleep(1000)
		Shutdown(1)
		Sleep(1000)
	EndIf
EndFunc   ;==>tiemtoshut





Func TimerStart()
	Return _NowCalc()
EndFunc   ;==>TimerStart

Func TimerStop($parm_firstdate)
	$iDateCalc = _DateDiff('s', $parm_firstdate, _NowCalc())
	Return $iDateCalc
EndFunc   ;==>TimerStop



;=======================================================================
; Wait stop move function, function loop until character is stop moving
;=======================================================================
Func CheckMove($Delay)
	$XDiff = 0
	$YDiff = 0
	$X_Start = 5 + $XDiff ; Left side of area
	$X_Stop = 795 + $XDiff ; Right side of area
	$Y_Start = 35 + $YDiff ; Up side of area
	$Y_Stop = 510 + $YDiff ; Bottom side of area
	$Begin = TimerStart()
	Do
		$CMA0 = PixelGetColor($X_Start, $Y_Start)
		$CMB0 = PixelGetColor($X_Stop, $Y_Start)
		$CMC0 = PixelGetColor($X_Stop, $Y_Stop)
		$CMD0 = PixelGetColor($X_Start, $Y_Stop)
		$CME0 = PixelGetColor(400 + $XDiff, $Y_Start)
		$CMF0 = PixelGetColor(400 + $XDiff, $Y_Stop)
		$CMG0 = PixelGetColor($X_Start, 240 + $YDiff)
		$CMH0 = PixelGetColor($X_Stop, 240 + $YDiff)
		Sleep($Delay)
		$CMA1 = PixelGetColor($X_Start, $Y_Start)
		$CMB1 = PixelGetColor($X_Stop, $Y_Start)
		$CMC1 = PixelGetColor($X_Stop, $Y_Stop)
		$CMD1 = PixelGetColor($X_Start, $Y_Stop)
		$CME1 = PixelGetColor(400 + $XDiff, $Y_Start)
		$CMF1 = PixelGetColor(400 + $XDiff, $Y_Stop)
		$CMG1 = PixelGetColor($X_Start, 240 + $YDiff)
		$CMH1 = PixelGetColor($X_Stop, 240 + $YDiff)
		
		$Check5 = 0
		If $CMA0 == $CMA1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMB0 == $CMB1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMC0 == $CMC1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMD0 == $CMD1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CME0 == $CME1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMF0 == $CMF1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMG0 == $CMG1 Then
			$Check5 = $Check5 + 1
		EndIf
		If $CMH0 == $CMH1 Then
			$Check5 = $Check5 + 1
		EndIf
		If ($Check5 >= 6) Then
			ExitLoop
		EndIf
	Until (TimerStop($Begin) > 3)
EndFunc   ;==>CheckMove

Func checkNowDead()
	$a = PixelChecksum(50, 580, 90, 590, 2, $title) ;   3177914901
	If $a = 3177914901 Then ;�����Ϊ true
		Return 1
	Else
		Return 0
	EndIf
	

EndFunc   ;==>checkNowDead

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

Func isInTown() ; �ڳ�����
	;If findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = True Then
	If isInRoom() = True And findPointColor(125, 595, "2C1008") = True Then ;28241C  ��
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>isInTown


; ===================================================================
; _RefreshSystemTray($nDealy = 1000)
;
; Removes any dead icons from the notification area.
; Parameters:
;   $nDelay - IN/OPTIONAL - The delay to wait for the notification area to expand with Windows XP's
;       "Hide Inactive Icons" feature (In milliseconds).
; Returns:
;   Sets @error on failure:
;       1 - Tray couldn't be found.
;       2 - DllCall error.
; ===================================================================
Func _RefreshSystemTray($nDelay = 1000)
; Save Opt settings
    Local $oldMatchMode = Opt("WinTitleMatchMode", 4)
    Local $oldChildMode = Opt("WinSearchChildren", 1)
    Local $error = 0
    Do; Pseudo loop
        Local $hWnd = WinGetHandle("classname=TrayNotifyWnd")
        If @error Then
            $error = 1
            ExitLoop
        EndIf

        Local $hControl = ControlGetHandle($hWnd, "", "Button1")
        
    ; We're on XP and the Hide Inactive Icons button is there, so expand it
        If $hControl <> "" And ControlCommand($hWnd, "", $hControl, "IsVisible") Then 
            ControlClick($hWnd, "", $hControl)
            Sleep($nDelay)
        EndIf
        
        Local $posStart = MouseGetPos()
        Local $posWin = WinGetPos($hWnd)    
        
        Local $y = $posWin[1]
        While $y < $posWin[3] + $posWin[1]
            Local $x = $posWin[0] 
            While $x < $posWin[2] + $posWin[0]
                DllCall("user32.dll", "int", "SetCursorPos", "int", $x, "int", $y)
                If @error Then
                    $error = 2
                    ExitLoop 3; Jump out of While/While/Do
                EndIf
                $x = $x + 8
            WEnd
            $y = $y + 8
        WEnd
        DllCall("user32.dll", "int", "SetCursorPos", "int", $posStart[0], "int", $posStart[1])
    ; We're on XP so we need to hide the inactive icons again.
        If $hControl <> "" And ControlCommand($hWnd, "", $hControl, "IsVisible") Then 
            ControlClick($hWnd, "", $hControl)
        EndIf
    Until 1
    
; Restore Opt settings
    Opt("WinTitleMatchMode", $oldMatchMode)
    Opt("WinSearchChildren", $oldChildMode)
    SetError($error)
EndFunc; _RefreshSystemTray()

