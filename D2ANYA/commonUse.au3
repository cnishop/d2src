AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

Func whichAct()
	TrayTip("", "检查在第几幕", 1, 16)
	Sleep(100)
	Send("{" & $char_Q & "}") ;tab 去掉小地图
	Sleep(200)
	If findPointColor(260, 430, "141414") And findPointColor(300, 430, "141414") Then
		Select
			Case findPointColor(130, 80, "2C2C2C") = True
				TrayTip("", "在ACT1", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}")
				Return "A1"
			Case findPointColor(200, 80, "303030") = True
				TrayTip("", "在ACT2", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}")
				Return "A2"
			Case findPointColor(260, 80, "2C2C2C") = True
				TrayTip("", "在ACT3", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab 去掉小地图
				Return "A3"
			Case findPointColor(320, 80, "404040") = True
				TrayTip("", "在ACT4", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab 去掉小地图
				Return "A4"
			Case findPointColor(380, 80, "242424") = True
				TrayTip("", "在ACT5", 1, 16)
				Send("{" & $char_Q & "}") ;tab 去掉小地图
				Sleep(10)
				Return "A5"
				
			Case Else
				TrayTip("", "不在任何一幕", 1, 16)
				Sleep(10)
				Send("{" & $char_Q & "}") ;tab 去掉小地图
				Return "A6"
		EndSelect
	Else
		TrayTip("", "查找场所出错", 1, 16)
		Send("{" & $char_Q & "}") ;tab 去掉小地图
		Return "A6"
	EndIf

EndFunc   ;==>whichAct


#CS 
   Func drinksurplusrev() ;去掉多余的瞬间回复血瓶,省得占用空间，bag
   	TrayTip("", "检查多余的瞬间回复药水", 1, 16)
   	Sleep(10)
   	Send("{B}")
   	Sleep(300)
   	For $i = 1 To 3 Step 1
   		 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
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
   Func drinksurplusHeal() ;去掉多余的瞬间回复血瓶,省得占用空间，bag
   	TrayTip("", "检查多余的红药水", 1, 16)
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
   
   Func drinksurplusMana() ;去掉多余的瞬间回复血瓶,省得占用空间，bag
   	TrayTip("", "检查多余的蓝药水", 1, 16)
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

Func checkRejInBeltrow() ;检查最下一层包裹
	$coord = PixelSearch(420, 565, 540, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找紫瓶
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>checkRejInBeltrow


Func checkRejQtyInBelt()
	;TrayTip("", "检查腰带内的紫瓶数量", 1, 16)
	Send("{~}")
	Sleep(100)
	For $i = 0 To 3 Step 1
		For $j = 0 To 3 Step 1
			$coord = PixelSearch($xbeltarray[$i][0], $ybeltarray[$j][0], $xbeltarray[$i][1], $ybeltarray[$j][1], 0x682070, 10, 1, $title) ; 在belt空间范围内查找
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
	TrayTip("", "检查腰带内的紫瓶数量：" & $int_beltRej, 1, 16)
	Sleep(1000)
	Return $int_beltRej
	
	
EndFunc   ;==>checkRejQtyInBelt


Func a3clickrade() ;检查最下一层包裹
	$coord = PixelSearch(100, 100, 500, 300, 0xC4C4C4, 10, 1, $title) ; 在背包空间范围内查找紫瓶
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(200)
	EndIf
EndFunc   ;==>a3clickrade



Func addBloodtorole()
	; (70, 550) ; 5C0000   50%
	; (70, 530) ; 5C0000   75%
	If findPointColor(70, 530, "5C0000") = False And findPointColor(70, 530, "18480C") = False And $drinkhealok = 0 Then
		TrayTip("", "少血了，喝点红药水..", 1, 16)
		If drinkWater("heal", "0x943030", "腰带里面没有普通的红药水") = False Then ;加红失败
			drinkWater("rej", "0x682070", "腰带里面也没有紫瓶") ;加大瓶
		EndIf
	EndIf
EndFunc   ;==>addBloodtorole

Func addmanatorole()
	If findPointColor(735, 580, "0C0C28") = False And $drinkmanaok = 0 Then
		TrayTip("", "蓝快没了，喝点蓝药水..", 1, 16)
		If drinkWater("mana", "0x1828A4", "腰带里面没有普通的蓝药水") = False Then ;加红失败
			;drinkWater("rej", "0x682070", "腰带里面也没有紫瓶") ;加大瓶
		EndIf
	EndIf
EndFunc   ;==>addmanatorole




Func drinkrej()
	$drink = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    第一个红窗
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; 第2个红窗口
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; 第3个红窗口
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; 第4个红窗口
		Select
			Case $i = 1 And $drink = 0
				$coord = PixelSearch(420, 565, 450, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{1}")
					$drink = 1
				EndIf
			Case $i = 2 And $drink = 0
				$coord = PixelSearch(455, 565, 480, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{2}")
					$drink = 1
				EndIf
			Case $i = 3 And $drink = 0
				$coord = PixelSearch(485, 565, 510, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{3}")
					$drink = 1
				EndIf
			Case $i = 4 And $drink = 0
				$coord = PixelSearch(515, 565, 540, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
				If Not @error Then
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{4}")
					$drink = 1
				EndIf
		EndSelect
	Next
	If $drink = 0 Then ;如果一个大回复药水都没找到，悲剧了。。乱点一个，或者hackmap设置为血保护
		TrayTip("", "腰带中没有大回.", 1, 16)
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
		;MouseMove(450, 565)    第一个红窗
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; 第2个红窗口
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; 第3个红窗口
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; 第4个红窗口
		Select
			Case $i = 1 And $drink = 0
				If findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "喝第" & $i & "列", 1, 16)
					Send("{1}")
					$drink = 1
				EndIf
			Case $i = 2 And $drink = 0
				If findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "喝第" & $i & "列", 1, 16)
					Send("{2}")
					$drink = 1
				EndIf
			Case $i = 3 And $drink = 0
				If findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "喝第" & $i & "列", 1, 16)
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{3}")
					$drink = 1
				EndIf
			Case $i = 4 And $drink = 0
				If findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "喝第" & $i & "列", 1, 16)
					;MouseClick("right", $coord[0], $coord[1], 1);
					Send("{4}")
					$drink = 1
				EndIf
		EndSelect
	Next
	If $drink = 0 Then ;如果一个大回复药水都没找到，悲剧了。。乱点一个，或者hackmap设置为血保护
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
		TrayTip("", "执行定时关机..", 1, 16)
		Sleep(1000)
		Shutdown(1)
		Sleep(1000)
	EndIf
EndFunc   ;==>tiemtoshut
