AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Func findpath($pathNumber)
	TrayTip("", "走向红门。。.", 1, 16)
	Sleep(100)
	Send("{TAB}") ;tab 去掉小地图
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	Select
		Case $pathNumber = 1
			MouseClick("left", 310 + $xrd, 530 + $yrd, 1)
			Sleep(1500)
			MouseClick("left", 700, 460, 1)
			Sleep(1300)
			MouseClick("left", 110, 460, 1)
			Sleep(1100)
			MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 280 + $yrd, 1)
			Sleep(1100)
		Case $pathNumber = 2
			MouseClick("left", 60 + $xrd, 250 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 250 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 180 + $xrd, 480 + $yrd, 1)
			Sleep(1200)
			MouseClick("left", 180, 480, 1)
			Sleep(1200)
			MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
			Sleep(1200)
			MouseClick("left", 220 + $xrd, 500 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
			Sleep(800)
			MouseClick("left", 700 + $xrd, 400 + $yrd, 1)
			Sleep(800)
		Case $pathNumber = 3
			MouseClick("left", 200 + $xrd, 500 + $yrd, 1)
			Sleep(1400)
			MouseClick("left", 750 + $xrd, 430 + $yrd, 1)
			Sleep(1400)
			MouseClick("left", 380 + $xrd, 480 + $yrd, 1)
			Sleep(800)
			MouseClick("left", 100 + $xrd, 350 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 130 + $xrd, 470 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 50 + $xrd, 430 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 65 + $xrd, 280 + $yrd, 1)
			Sleep(800)
		Case $pathNumber = 4
			MouseClick("left", 60, 250, 1)
			Sleep(1400)
			MouseClick("left", 30 + $xrd, 250 + $yrd, 1)
			Sleep(1600)
			MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 210 + $xrd, 500 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 600 + $xrd, 400 + $yrd, 1)
			Sleep(1400)
		Case $pathNumber = 5
			MouseClick("left", 290 + $xrd, 510 + $yrd, 1)
			Sleep(1700)
			MouseClick("left", 630 + $xrd, 340 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 500 + $xrd, 460 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 280 + $yrd, 1)
			Sleep(1100)
		Case $pathNumber = 6
			MouseClick("left", 190 + $xrd, 252 + $yrd, 1)
			Sleep(800)
			MouseClick("left", 140 + $xrd, 310 + $yrd, 1)
			Sleep(800)
			MouseClick("left", 185 + $xrd, 240 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 260 + $xrd, 490 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 100 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
			Sleep(1200)
			MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
			Sleep(1200)
			MouseClick("left", 400 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 600 + $xrd, 350 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 700 + $xrd, 300 + $yrd, 1)
			Sleep(1100)
		Case Else
			
	EndSelect
	Return True
EndFunc   ;==>findpath

Func a3totownwp($path)
	TrayTip("", "走向act3小站", 1, 16)
	Sleep(100)
	Send("{" & $char_TAB & "}") ;tab 去掉小地图
	Sleep(100)
	Send("{" & $char_normal_attack & "}")
	Sleep(50)
	Send("{" & $char_Vigor & "}")
	Sleep(10)
	Select
		Case $path = 1
			MouseMove(700, 300)
			Sleep(100)
			MouseClick("left", 700, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 600, 260, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 600, 200, 1)
			CheckMove($Char_CheckMoveDelay)
		Case $path = 2
			MouseMove(700, 300)
			Sleep(10)
			MouseDown("left")
			Sleep(1000)
			MouseMove(760, 100)
			Sleep(3500)
			MouseUp("left")
			MouseClick("left", 760, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 550, 180, 1)
			CheckMove($Char_CheckMoveDelay)
		Case Else
	EndSelect
EndFunc   ;==>a3totownwp


Func goto3cpath($path)
	TrayTip("", "走向路径" & $path, 1, 16)
	Select
		Case $path = 1
			MouseClick("left", 600, 450, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 760, 100, 2)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 600, 300, 1)
			CheckMove($Char_CheckMoveDelay)

			MouseClick("left", 600, 450, 1)
			CheckMove($Char_CheckMoveDelay)
			For $i = 1 To 5 Step 1
				MouseClick("left", 600, 390, 1)
				CheckMove($Char_CheckMoveDelay)
			Next
			Sleep(500)
			
			$coord = finPicPos("images\a33cdoor2.bmp", 0.6)
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "找到路径", 9, 16)
				MouseClick("left", $coord[0] + 150, $coord[1] + 100, 3);
				;MouseMove($coord[0], $coord[1])
				Sleep(500)
			Else
				TrayTip("", "随机移动", 9, 16)
				MouseClick("left", 500, 390, 1)
				Sleep(500)
			EndIf
			
			MouseMove(760, 100)
			MouseDown("left")
			Sleep(1000)
			;CheckMove($Char_CheckMoveDelay)
			MouseUp("left")
		Case $path = 2
			MouseClick("left", 600, 450, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 520, 300, 2)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 720, 130, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 720, 110, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 720, 110, 3)
			CheckMove($Char_CheckMoveDelay)

			MouseClick("left", 620, 390, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 390, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 410, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 410, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 410, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 200, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 620, 200, 1)
			CheckMove($Char_CheckMoveDelay)
			;MouseMove(620,200)
			Sleep(700)
		Case $path = 3
			MouseClick("left", 600, 450, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 520, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseMove(720, 130)
			Sleep(50)
			MouseDown("left")
			Sleep(3000)
			MouseUp("left")
			Sleep(10)
			MouseClick("left", 520, 390, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 520, 390, 1)
			CheckMove($Char_CheckMoveDelay)
			For $i = 1 To 8 Step 1
				MouseClick("left", 520, 340, 1)
				CheckMove($Char_CheckMoveDelay)
			Next
			
			If $testversion = 0 Then
				$coord = finPicPos("images\a33cdoor1.bmp", 0.6)
				;$coord = finda3box()
				If $coord[0] >= 0 And $coord[1] >= 0 Then
					MouseClick("left", $coord[0] + 100, $coord[1] + 100, 3);
					;MouseMove($coord[0], $coord[1])
					Sleep(Random(500, 1000, 1))
					MouseClick("left", 620, 200, 1)
					Sleep(500)
				Else ;没有找到标志的情况，可能是未走到
					Sleep(10)
					MouseClick("left", 620, 200, 1)
					CheckMove($Char_CheckMoveDelay)
				EndIf
			Else
				Sleep(10)
				MouseClick("left", 620, 200, 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf
			
		Case $path = 4
			Send("{" & $char_tp & "}")
			Sleep(500)
			MouseClick("right", 730, 300)
			Sleep(1700)
			MouseClick("right", 730, 300)
			Sleep(1400)
			MouseClick("right", 730, 300)
			Sleep(1300)
			MouseClick("right", 730, 300)
			Sleep(1300)
			MouseClick("right", 730, 300)
			Sleep(1400)
			MouseClick("right", 730, 300)
			Sleep(1300)
			MouseClick("right", 730, 300)
			Sleep(1300)
			MouseClick("right", 730, 300)
			Sleep(1300)
			MouseClick("right", 700, 300)
			Sleep(700)
			;MouseClick("right", 690, 100)
			;Sleep(700)

		Case Else

	EndSelect
EndFunc   ;==>goto3cpath

Func a4Toa5() ;act4 去act5
	TrayTip("", "从act4到act5", 1, 16)
	Sleep(10)
	MouseClick("left", 740, 80, 1) ; click wp
	Sleep(2000)
	MouseClick("left", 340, 80, 1)
	Sleep(200)
	MouseClick("left", 340, 140, 1)
	Sleep(1000)
	exitRoom()
EndFunc   ;==>a4Toa5

Func a4Toa3() ;act4 去act5
	TrayTip("", "从act4到act3", 1, 16)
	Sleep(10)
	MouseClick("left", 740, 80, 1) ; click wp
	Sleep(2000)
	MouseClick("left", 260, 80, 1)
	Sleep(200)
	MouseClick("left", 260, 140, 1)
	Sleep(2500)
	exitRoom()
EndFunc   ;==>a4Toa3

Func a4wpToYizuer() ; 到yizhuer ，复活pet，并去act5
	TrayTip("", "点中大天使", 1, 16)
	Sleep(500)
	MouseClick("left", 130, 240, 1)
	Sleep(3000)
	MouseClick("left", 280, 60, 1);点中泰瑞尔
	Sleep(2000)
	MouseClick("left", 380, 130, 1);点中复活
	Sleep(1500)
	MouseClick("left", 380, 130, 1);点中前往act5
	Sleep(1500)
EndFunc   ;==>a4wpToYizuer


Func a3toa4()
	TrayTip("", "从act3到act4", 1, 16)
	Sleep(500)
	$coord = findwp()
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(1000)
		MouseClick("left", 310, 80, 1)
		Sleep(200)
		MouseClick("left", 310, 140, 1)
		Sleep(1000)
		;exitRoom()
	Else
		TrayTip("", "没有找到小站！", 9, 16)
		Sleep(1000)
		exitRoom()
		Return
	EndIf

EndFunc   ;==>a3toa4

Func a3Toa5() ;act4 去act5
	TrayTip("", "从act3到act5", 1, 16)
	Sleep(500)
	$coord = findwp()
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(1000)
		MouseClick("left", 340, 80, 1)
		Sleep(200)
		MouseClick("left", 340, 140, 1)
		Sleep(2000)
		;exitRoom()
	Else
		TrayTip("", "没有找到小站！", 9, 16)
		Sleep(1000)
		exitRoom()
		Return
	EndIf
	
EndFunc   ;==>a3Toa5


Func a5Toa3() ;act4 去act5
	TrayTip("", "从act5到act3", 1, 16)
	Sleep(500)
	MouseClick("left", 145, 520, 1)
	Sleep(2000)
	;MouseMove(170,520)
	MouseClick("left", 170, 520, 1)
	Sleep(2000)
	MouseClick("left", 260, 80, 1)
	Sleep(200)
	MouseClick("left", 260, 140, 1) ;到a3了
	Sleep(3000)
	exitRoom()
	
EndFunc   ;==>a5Toa3

Func a5WpTolasuke() ;act4 去act5
	TrayTip("", "从act5 wp到拉苏克", 1, 16)
	Sleep(500)
	MouseMove(500, 300)
	MouseDown("left")
	Sleep(1500)
	;MouseMove(170,520)
	MouseUp("left")
	MouseClick("left", 500, 300, 1) ;到a3了
	Sleep(1500)
	;exitRoom()
	
EndFunc   ;==>a5WpTolasuke



Func a3townwptocui()
	TrayTip("", "从act3小站去3C的场所.", 9, 16)
	Sleep(500)
	$coord = findwp()
	If $coord[0] >= 0 And $coord[1] >= 0 Then
		MouseClick("left", $coord[0], $coord[1], 1);
		Sleep(1200)
		MouseClick("left", 120, 380, 1);
		Sleep(1400)
	Else
		TrayTip("", "其他寻找", 9, 16)
		MouseClick("left", 700, 270, 1);
		Sleep(1200)
		MouseClick("left", 120, 380, 1);
		Sleep(1500)
		Return
	EndIf

EndFunc   ;==>a3townwptocui


Func gotoBox($whichAct) ;包裹满了，要装箱，act3 和在 act5 两种情况
	Select
		Case $whichAct = "A3"
			TrayTip("", "在act3进行装箱！", 9, 16)
			$coord = finda3box()
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
EndFunc   ;==>gotoBox


Func a3toomous($path)
	TrayTip("", "走向act3 omous 处", 1, 16)
	;Sleep(100)
	;Send("{" & $char_TAB & "}") ;tab 去掉小地图
	Sleep(100)
	Send("{" & $char_normal_attack & "}")
	Sleep(50)
	Send("{" & $char_Vigor & "}")
	Sleep(10)
	Select
		Case $path = 1
			MouseMove(700, 300)
			Sleep(100)
			MouseClick("left", 700, 300, 1)
			CheckMove($Char_CheckMoveDelay)
			Sleep(100)
			MouseClick("left", 600, 260, 1)
			CheckMove($Char_CheckMoveDelay)
			Sleep(100)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			Sleep(100)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			Sleep(500)
			MouseClick("left", 760, 100, 1)
			CheckMove($Char_CheckMoveDelay)
			Sleep(500)

			#CS 			MouseClick("left", 760, 300, 1)
				Sleep(1200)
				MouseClick("left", 760, 300, 1)
				Sleep(1200)
				MouseClick("left", 600, 200, 1)
				Sleep(1200)
			#CE
		Case $path = 2
			MouseMove(700, 300)
			Sleep(10)
			MouseDown("left")
			Sleep(1000)
			MouseMove(760, 100)
			Sleep(3500)
			MouseUp("left")
			#CS 			MouseClick("left", 760, 300, 1)
				Sleep(1200)
				MouseClick("left", 760, 300, 1)
				Sleep(1200)
				MouseClick("left", 550, 180, 1)
				Sleep(1200)
			#CE
		Case Else
				If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right ; 从箱子下方找右边第二个方格
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(400, 300, 700, 400, 0x118FB01, 10, 1, $title)
			If @error Then
				MouseClick("left", 150 + $xrd, 500 + $yrd, Random(1, 5, 1))
				Sleep(50)
				$findflag = 0
			Else
				MouseClick("left", $coord[0] - 250, $coord[1] + 50, Random(3, 5, 1))
				Sleep(500)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 6000
	EndIf
	
	EndSelect
EndFunc   ;==>a3toomous

Func a3omousToWp()
	TrayTip("", "走向act3 小站处", 1, 16)
	Sleep(100)
	MouseClick("left", 760, 300, 2)
	CheckMove($Char_CheckMoveDelay)
	MouseClick("left", 760, 300, 1)
	CheckMove($Char_CheckMoveDelay)
	MouseClick("left", 760, 250, 1)
	CheckMove($Char_CheckMoveDelay)
	MouseClick("left", 760, 250, 2)
	CheckMove($Char_CheckMoveDelay)
	MouseClick("left", 760, 250, 2)
	CheckMove($Char_CheckMoveDelay)
	MouseDown("left")
	Sleep(1000)
	CheckMove($Char_CheckMoveDelay)
	MouseUp("left")
	Sleep(100)
	;回到箱子和站点中间
	MouseClick("left", 10, 300, 2)
	CheckMove($Char_CheckMoveDelay)
	
EndFunc   ;==>a3omousToWp
