AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

Func whichAct()
	TrayTip("", "����ڵڼ�Ļ", 1, 16)
	Sleep(100)
	Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
	Sleep(200)
	If findPointColor(260, 430, "141414") And findPointColor(300, 430, "141414") Then
		Select
			Case findPointColor(130, 80, "2C2C2C") = True
				TrayTip("", "��ACT1", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}")
				Return "A1"
			Case findPointColor(200, 80, "303030") = True
				TrayTip("", "��ACT2", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}")
				Return "A2"
			Case findPointColor(260, 80, "2C2C2C") = True
				TrayTip("", "��ACT3", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
				Return "A3"
			Case findPointColor(320, 80, "404040") = True
				TrayTip("", "��ACT4", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
				Return "A4"
			Case findPointColor(380, 80, "242424") = True
				TrayTip("", "��ACT5", 1, 16)
				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
				Sleep(10)
				Return "A5"
				
			Case Else
				TrayTip("", "�����κ�һĻ", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
				Return "A6"
		EndSelect
	Else
		TrayTip("", "���ҳ�������", 1, 16)
		Send("{" & $char_Q & "}") ;tab ȥ��С��ͼ
		Return "A6"
	EndIf

EndFunc   ;==>whichAct


#CS 
   Func drinksurplusrev() ;ȥ�������˲��ظ�Ѫƿ,ʡ��ռ�ÿռ䣬bag
   	TrayTip("", "�������˲��ظ�ҩˮ", 1, 16)
   	Sleep(10)
   	Send("{B}")
   	Sleep(300)
   	For $i = 1 To 3 Step 1
   		 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
   			If Not @error Then
   			MouseClick("right", $coord[0], $coord[1], 1);
   			Sleep(200)
   			EndIf
   		
		
        $coord = findRevInBag()
   		If $coord[0] >= 0 And $coord[1] >= 0 Then
   			MouseClick("right", $coord[0], $coord[1], 1);
   			Sleep(200)
   		EndIf
   	Next
   	Send("{B}")
   	Sleep(100)
   EndFunc   ;==>drinksurplusrev
#CE

#CS 
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
   		EndIf
   	Next
   	Send("{B}")
   EndFunc   ;==>drinksurplusMana
#CE

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



Func addBloodtorole()
	; (70, 550) ; 5C0000   50%
	; (70, 530) ; 5C0000   75%
	If findPointColor(70, 530, "5C0000") = False And findPointColor(70, 530, "18480C") = False And $drinkhealok = 0 Then
		TrayTip("", "��Ѫ�ˣ��ȵ��ҩˮ..", 1, 16)
		If drinkWater("heal", "0x943030", "��������û����ͨ�ĺ�ҩˮ") = False Then ;�Ӻ�ʧ��
			drinkWater("rej", "0x682070", "��������Ҳû����ƿ") ;�Ӵ�ƿ
		EndIf
	EndIf
EndFunc   ;==>addBloodtorole

Func addmanatorole()
	If findPointColor(735, 580, "0C0C28") = False And $drinkmanaok = 0 Then
		TrayTip("", "����û�ˣ��ȵ���ҩˮ..", 1, 16)
		If drinkWater("mana", "0x1828A4", "��������û����ͨ����ҩˮ") = False Then ;�Ӻ�ʧ��
			;drinkWater("rej", "0x682070", "��������Ҳû����ƿ") ;�Ӵ�ƿ
		EndIf
	EndIf
EndFunc   ;==>addmanatorole




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
		Sleep(1000)
		Return False
	Else
		If $cat = "heal" Then
			$drinkhealok = 1
		ElseIf $cat = "mana" Then
			$drinkmanaok = 1
		EndIf
		
		Return True
		#CS 		Send("{1}")
			Send("{2}")
			Send("{3}")
			Send("{4}")
		#CE
	EndIf
EndFunc   ;==>drinkWater

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
