AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Func findpath($pathNumber)
	TrayTip("", "走向红门。", 1, 16)
	Sleep(100)
	;Send("{" & $char_TAB & "}") ;tab 去掉小地图  ----防止每次都send tab 被后台gm看出，改策划能够
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	TrayTip("", $pathNumber +" 启用随机路径" & "坐标迷惑偏移" & $xrd & $yrd, 1, 16)
	Select
		Case $pathNumber = 1
			
			MouseClick("left", 270 + $xrd, 530 + $yrd, 1)
			Sleep(1500)
			MouseClick("left", 760, 430, 1)
			Sleep(1300)
			MouseClick("left", 160, 460, 1)
			Sleep(1100)
			MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 40 + $xrd, 280 + $yrd, 1)
			Sleep(1100)
			

			#CS
				MouseClick("left", 310 + $xrd, 530 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 700, 460, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 110, 460, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 80 + $xrd, 280 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
			#CE

			
		Case $pathNumber = 2
			
			$xrd = Random(-2, 2, 1)
			$yrd = Random(-2, 2, 1)
			If Random(1, 3) = 1 Then
				MouseClick("left", 60 + $xrd, 250 + $yrd, Random(1, 2))
				Sleep(Random(200, 500) + $guiWalkspeedAdjust)
			Else
				MouseMove(60 + $xrd, 250 + $yrd, Random(1, 20))
				MouseDown("left")
				Sleep(Random(800, 1000) + $guiWalkspeedAdjust)
				MouseUp("left")
			EndIf
			MouseClick("left", 40 + $xrd, 250 + $yrd, 2)
			Sleep(1100)
			MouseClick("left", 180 + $xrd, 480 + $yrd, Random(1, 2))
			Sleep(1100)
			MouseClick("left", 180, 480, 1)
			Sleep(1100)
			MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
			Sleep(1100)
			MouseClick("left", 220 + $xrd, 500 + $yrd, 1)
			Sleep(1000)
			MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
			Sleep(800)
			MouseClick("left", 700 + $xrd, 400 + $yrd, 1)
			Sleep(1000)
			#CS
				MouseClick("left", 60 + $xrd, 250 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 40 + $xrd, 250 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 180 + $xrd, 480 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 180, 480, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 220 + $xrd, 500 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 700 + $xrd, 400 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
			#CE
			
			
		Case $pathNumber = 3
			#CS 			 			MouseClick("left", 200 + $xrd, 500 + $yrd, 1)
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
			#CE
			
			
			MouseClick("left", 200 + $xrd, 500 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 750 + $xrd, 430 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 380 + $xrd, 480 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 100 + $xrd, 350 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 130 + $xrd, 470 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 50 + $xrd, 430 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 65 + $xrd, 280 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			
		Case $pathNumber = 4
			MouseClick("left", 50, 250, 2)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 50 + $xrd, 250 + $yrd, 2)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
			;Sleep(1300)
			Sleep(2000)
			MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
			;Sleep(1300)
			Sleep(2000)
			MouseClick("left", 210 + $xrd, 500 + $yrd, 1)
			;Sleep(1300)
			Sleep(2000)
			MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
			Sleep(1300)
			MouseClick("left", 600 + $xrd, 400 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			#CS
				MouseClick("left", 60, 250, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 30 + $xrd, 250 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 190 + $xrd, 480 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 100 + $xrd, 450 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 210 + $xrd, 500 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 600 + $xrd, 420 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 600 + $xrd, 400 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
			#CE
			
		Case $pathNumber = 5
			MouseClick("left", 290, 510, 1)
			Sleep(1700)
			MouseClick("left", 620, 340, 1)
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
			#CS
				
				MouseClick("left", 290, 510, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 620, 340, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 500 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 60 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 40 + $xrd, 460 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
				MouseClick("left", 80 + $xrd, 280 + $yrd, 1)
				CheckMove($Char_CheckMoveDelay)
			#CE
			
		Case $pathNumber = 6
			#CS 			MouseClick("left", 190, 252, 1)
				Sleep(800)
				MouseClick("left", 140, 310, 1)
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
			#CE
			
			MouseClick("left", 190, 252, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 140, 310, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 185 + $xrd, 240 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 260 + $xrd, 490 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 100 + $xrd, 460 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 190 + $xrd, 460 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 400 + $xrd, 460 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 600 + $xrd, 350 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 700 + $xrd, 300 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			
			
		Case $pathNumber = 7
			
			MouseClick("left", 140 + $xrd, 530 + $yrd, 1)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 300 + $xrd, 450 + $yrd, 1)
			;TrayTip("", "2", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 250 + $xrd, 530 + $yrd, 1)
			;TrayTip("", "3", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 100 + $xrd, 530 + $yrd, 1)
			;TrayTip("", "3", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			;MouseClick("left", 90 + $xrd, 360 + $yrd)
			MouseMove(90 + $xrd, 360 + $yrd)
			MouseDown("left")
			Sleep(200)
			MouseUp("left")
			CheckMove($Char_CheckMoveDelay)
			
		Case $pathNumber = 8
			MouseMove(120 + $xrd, 530 + $yrd)
			MouseDown("left")
			;TrayTip("", "1", 1, 16)
			;Sleep(1000)  ;原来
			CheckMove($Char_CheckMoveDelay);emkb用
			MouseMove(200 + $xrd, 530 + $yrd)
			;TrayTip("", "2", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			MouseMove(200 + $xrd, 530 + $yrd)
			;TrayTip("", "3", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			MouseMove(70 + $xrd, 500 + $yrd)
			;TrayTip("", "4", 1, 16)
			CheckMove($Char_CheckMoveDelay)
			MouseUp("left")
			MouseClick("left", 230 + $xrd, 300 + $yrd, Random(1, 3, 1))
			;Sleep(1000)
			CheckMove($Char_CheckMoveDelay)
			
		Case $pathNumber = 801
			TrayTip("", " 单一路线", 1, 16)
			MouseMove(120 + $xrd, 530 + $yrd)
			MouseDown("left")
			Sleep(1500) ;emkb用
			MouseMove(200 + $xrd, 530 + $yrd)
			;TrayTip("", "2", 1, 16)
			Sleep(1500)
			MouseMove(200 + $xrd, 530 + $yrd)
			;TrayTip("", "3", 1, 16)
			Sleep(1700)
			MouseMove(70 + $xrd, 500 + $yrd)
			;TrayTip("", "4", 1, 16)
			Sleep(800)
			MouseUp("left")
			MouseClick("left", 230 + $xrd, 300 + $yrd, Random(1, 3, 1))
			;Sleep(1000)
			CheckMove($Char_CheckMoveDelay)
			
		Case $pathNumber = 802
			;全靠 block 来走路
			MouseClick("left", 135 + Random(1, 10), 520 + Random(1, 10), 1)
			CheckMove($Char_CheckMoveDelay)

			$coord = PixelSearch(400, 300, 790, 580, 0x18FB01, 10, 1, $title)
			If Not @error Then
				MouseClick("left", $coord[0] - Random(180, 200), $coord[1] - Random(1, 10), 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf
;~
			$coord = PixelSearch(50, 300, 300, 580, 0x18FB01, 10, 1, $title)
			If Not @error Then
				MouseClick("left", $coord[0] + Random(180, 200), $coord[1] + Random(80, 100), 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf
;~
			$coord = PixelSearch(50, 200, 300, 500, 0x18FB01, 10, 1, $title)
			If Not @error Then
				MouseClick("left", $coord[0] + Random(1, 20), $coord[1] + Random(260, 290), 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf

			$coord = PixelSearch(50, 300, 250, 580, 0x18FB01, 10, 1, $title)
			If Not @error Then
				MouseClick("left", $coord[0] + Random(150, 200), $coord[1] + Random(1, 20), 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf
			$coord = PixelSearch(50, 250, 380, 500, 0x18FB01, 10, 1, $title)
			If Not @error Then
				MouseClick("left", $coord[0] - Random(50, 100), $coord[1] + Random(1, 20), 1)
				CheckMove($Char_CheckMoveDelay)
			EndIf
			
		Case $pathNumber = 9
			Sleep(10)
			MouseMove(375, 310)
			MouseDown("left")
			;TrayTip("", "1", 1, 16)
			Sleep(1800)
			MouseMove(385, 310)
			;TrayTip("", "2", 1, 16)
			Sleep(1500)
			MouseMove(380, 310)
			;TrayTip("", "3", 1, 16)
			Sleep(1500)
			MouseMove(380, 310)
			;TrayTip("", "4", 1, 16)
			Sleep($guiWalkspeedAdjust)
			MouseUp("left")
			;MouseClick("left", 230 , 300 )
			;Sleep(1000)
			MouseMove(250, 280)
			Sleep(10)
			MouseDown("left")
			Sleep(400)
			MouseUp("left")
			Sleep(400)
			
		Case $pathNumber = 10
			MouseMove(200 + $xrd, 530 + $yrd)
			MouseDown("left")
			;TrayTip("", "1", 1, 16)
			Sleep(1200)
			MouseMove(600 + $yrd, 330 + $yrd)
			;TrayTip("", "2", 1, 16)
			Sleep(1200)
			MouseMove(60 + $yrd, 460 + $yrd)
			;TrayTip("", "3", 1, 16)
			Sleep(3300)
			MouseUp("left")
			MouseClick("left", 60 + $yrd, 300 + $yrd)
			Sleep(1000)
			CheckMove($Char_CheckMoveDelay)
			
		Case $pathNumber = 11 ;找色走路
			
			a5downLeft1()
			a5downLeft2()
			a5downLeft3()
			
		Case $pathNumber = 1091 ;  一般的109 战网， 红门在门附近
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
			; 						MouseClick("left", 290, 60, 1)      ;增加凯尔旁边
			;	Sleep(1500)
			
			
			;MouseClick("left", 250, 60, 1) ;增加的另外的红门
			;Sleep(1100)
			
			
			;-------------
			MouseClick("left", 180, 60, 1) ;增加的另外的红门
			Sleep(1500)

			;MouseClick("left", 120, 220, 1)
			;Sleep(800)


			;MouseClick("left", 270, 270, 1)
			;Sleep(800)

		Case $pathNumber = 109 ;红门在门附近
			
			
			cnbnpath()
			Sleep(1000) ;针对有的电脑，降低速度
			;找红门旁边的柱子
			;$t1 = TimerInit()
			$coord = findzhuzi()
			;ConsoleWrite(TimerDiff($t1) & @CRLF)
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				MouseMove($coord[0], $coord[1]);
				MouseClick('left', $coord[0], $coord[1] + 20)
				CheckMove($Char_CheckMoveDelay)
				;Sleep(1200)
			Else
				TrayTip("", "找不到红门", 9, 16)
				Sleep(1000)
				Return False;
			EndIf

		Case $pathNumber = 113
			anhei3()
			;下面是踢木桶，可能需要连续踢两次
;~ 	$coord = findtudui1() ;找到柴草的位置
;~ 	;ConsoleWrite(TimerDiff($t1) & @CRLF)
;~ 	If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 		;MouseMove($coord[0], $coord[1]);
;~ 		MouseClick('left', $coord[0] + 5, $coord[1] + 5)
;~ 		CheckMove($Char_CheckMoveDelay)
;~ 		;Sleep(1000)
;~ 	EndIf
			$i = 1
			While $i <= 1 ;;循环一下，踢两次试试
;~ 		If $i = 2 Then ;第2次人物退后下再点
;~ 			MouseClick('left', 410, 310)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		EndIf
				$coord = findtudui1() ;找到土堆的位置
				;ConsoleWrite(TimerDiff($t1) & @CRLF)
				If $coord[0] >= 0 And $coord[1] >= 0 Then
					;MouseMove($coord[0] +150, $coord[1] +30);
					MouseClick('left', $coord[0] + 150, $coord[1] + 30)
					Sleep(1500)
					CheckMove($Char_CheckMoveDelay)
				Else 
					TrayTip("", "没找到。。。。。。", 9, 16)
					MouseClick('left', 360, 170) 
					Sleep(2000)
				EndIf
				$i = $i + 1
			WEnd
			
			
			MouseClick('left', 400, 260) ;再向上方走走方便找红门
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
			
			
		Case $pathNumber = "11301" ; 复活雇佣兵的路线
			anhei3()
			$coord = findtudui1() ;找到柴草的位置
			;ConsoleWrite(TimerDiff($t1) & @CRLF)
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				;MouseMove($coord[0] +150, $coord[1] +30);
				MouseClick('left', $coord[0], $coord[1] + 100)
				Sleep(1800)
				CheckMove($Char_CheckMoveDelay)
			EndIf
			MouseClick("left", 120, 80, 1, 5)
			Sleep(500)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 120, 80, 1, 5)
			Sleep(500)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 350,80, Random(1,2,1), 5)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", 398, 298, Random(2,3,1),5 )
			Sleep(50)
		Case Else
			
			
			
	EndSelect
	Return True
EndFunc   ;==>findpath

Func cnbnpath()
	;--------cnbn 109 订制
	MouseClick('left', 500, 350)
	CheckMove($Char_CheckMoveDelay)
	Sleep(300)
	MouseClick('left', 250, 450)
	CheckMove($Char_CheckMoveDelay)
	Sleep(300)
;~ ;; 此处就可以判断下边是否被堵住了
	;---开始检测下方是否堵住

	$coord = findlouti1()
	If $coord[0] >= 0 And $coord[1] >= 0 Then ;;走右边路径
		TrayTip("", "下方楼梯有被障碍物堵住..", 9, 16)
		Sleep(10)
		MouseClick('left', 450, 400) ;走到中间位置
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1000)
		;$t1 = TimerInit()
		$coord = findlcaicao() ;找到柴草的位置
		;ConsoleWrite(TimerDiff($t1) & @CRLF)
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0], $coord[1] + 20)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(1000)
		Else
			TrayTip("", "其他寻找", 9, 16)
			Sleep(1000)
		EndIf
		;继续往右下
		MouseMove(600, 500)
		MouseClick('left', 600, 500)
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1000)
		MouseMove(80, 360)
		MouseClick('left', 80, 360)
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1000)
		
	Else
		TrayTip("", "路径2规划中...", 9, 16)
		Sleep(800)
		MouseMove(200, 420)
		MouseClick('left', 200, 420)
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1000)
		MouseMove(400, 380)
		MouseClick('left', 400, 380)
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1000)
		MouseMove(600, 380)
		MouseClick('left', 600, 380)
		CheckMove($Char_CheckMoveDelay)
		;Sleep(1500)
	EndIf
EndFunc   ;==>cnbnpath

Func anhei3()

	$coord = finda5both1() ;因开始位置会变，先判断是不是 a5both1 地图
	If $coord[0] >= 0 And $coord[1] >= 0 Then ;;走右边路径
		TrayTip("", "确定坐标", 9, 16)
		MouseMove($coord[0] + 150, $coord[1] + 50);
		Sleep(100)
		MouseClick('left', $coord[0] + 150, $coord[1] + 50)
		Sleep(100)
		CheckMove($Char_CheckMoveDelay)

		MouseClick('left', 380, 540)
		Sleep(300)
		CheckMove($Char_CheckMoveDelay)
		
		$coord = findlcaicao() ;找到柴草的位置
		;ConsoleWrite(TimerDiff($t1) & @CRLF)
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			;MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0] + 50, $coord[1] + 100)
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(1000)
		Else
			TrayTip("", "其他寻找", 9, 16)
			Sleep(1000)
		EndIf
		MouseMove(410, 510)
		MouseClick("left", 410, 510)
		Sleep(200)
		CheckMove($Char_CheckMoveDelay)

		MouseMove(100, 440)
		MouseClick("left", 100, 440)
		Sleep(200)
		CheckMove($Char_CheckMoveDelay)

		MouseMove(100, 440)
		MouseClick("left", 100, 440)
		Sleep(200)
		CheckMove($Char_CheckMoveDelay)


		;Sleep(1000)
	Else
		TrayTip("", "找第二位置试试", 9, 16) ;
		$coord = findlcaicao() ;找到柴草的位置
		;ConsoleWrite(TimerDiff($t1) & @CRLF)
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			;MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0] + 50, $coord[1] + 100)
			Sleep(1000)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(1000)
		Else
			TrayTip("", "其他寻找", 9, 16)
			Sleep(1000)
		EndIf
		MouseMove(410, 510)
		MouseClick("left", 410, 510)
		Sleep(300)
		CheckMove($Char_CheckMoveDelay)

		MouseMove(100, 440)
		MouseClick("left", 100, 440)
		Sleep(300)
		CheckMove($Char_CheckMoveDelay)

		MouseMove(100, 440)
		MouseClick("left", 100, 440)
		Sleep(300)
		CheckMove($Char_CheckMoveDelay)
		
		Sleep(200)
	EndIf
	


EndFunc   ;==>anhei3

Func a5down1() ;到楼梯下方小站附件
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	$i = Random(1, 3, 1)
	Switch $i ;到小站附件， 可以作为转移物品的路径
		Case 1
			TrayTip("", " 单一路线", 1, 16)
			MouseMove(220 + $xrd, 450 + $yrd)
			MouseClick("left", Default, Default, 1)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(800) ;emkb用
			MouseMove(250 + $xrd, 400 + $yrd)
			MouseDown("left")
			Sleep(800)
			MouseUp("left")
		Case 2
			MouseMove(210 + $xrd, 450 + $yrd, Random(1, 20))
			MouseClick("left", Default, Default, Random(1, 3))
			Sleep(800) ;emkb用
			MouseClick("left", 150 + $xrd, 380 + $yrd, Random(1, 3))
			Sleep(500)
			MouseMove(400 + $xrd, 450 + $yrd, Random(1, 20))
			MouseDown("left")
			Sleep(200)
			MouseUp("left")
			Sleep(400)
		Case 3
			MouseClick("left", 300 + $xrd, 400 + $yrd, Random(1, 3))
			Sleep(300)
			MouseClick("left", 260 + $xrd, 400 + $yrd, Random(1, 3))
			Sleep(300)
			MouseClick("left", 270 + $xrd, 400 + $yrd, Random(1, 3))
			CheckMove(300)
			MouseClick("left", 280 + $xrd, 350 + $yrd, Random(1, 3))
			Sleep(200)
			MouseClick("left", 290 + $xrd, 350 + $yrd, Random(1, 3))
			Sleep(200)
		Case Else
	EndSwitch
	$coord = PixelSearch(400, 300, 790, 580, 0x18FB01, 10, 1, $title)
	If Not @error Then
		MouseClick("left", $coord[0] - Random(100, 150), $coord[1] + Random(50, 80), 1)
		Sleep(800)
	EndIf

	
EndFunc   ;==>a5down1


Func a5down2() ; 小站附近往红门的这段
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	$i = Random(1, 3, 1) ;Random(1,3,1)
	Switch $i ;到小站附件， 可以作为转移物品的路径
		Case 1
			MouseMove(70 + $xrd, 500 + $yrd)
			MouseClick("left", Default, Default, Random(1, 3))
			Sleep(800) ;emkb用
			MouseMove(70 + $xrd, 500 + $yrd)
			MouseDown("left")
			Sleep(800)
			MouseUp("left")
			Sleep(800 + $guiWalkspeedAdjust)
		Case 2
			MouseMove(150 + $xrd, 500 + $yrd, Random(1, 20))
			MouseClick("left", Default, Default, Random(1, 3))
			Sleep(800) ;emkb用
			MouseClick("left", 150 + $xrd, 500 + $yrd, 2)
			Sleep(500)
			MouseMove(150 + $xrd, 500 + $yrd, Random(1, 20))
			MouseDown("left")
			Sleep(200)
			MouseUp("left")
			Sleep(1000 + $guiWalkspeedAdjust)
		Case 3
			MouseClick("left", 70 + $xrd, 500 + $yrd, Random(1, 3))
			Sleep(200) ;原来
			MouseClick("left", 300 + $xrd, 400 + $yrd, Random(1, 3))
			Sleep(200)
			MouseClick("left", 110 + $xrd, 500 + $yrd, Random(1, 3))
			Sleep(200)
			MouseClick("left", 70 + $xrd, 500 + $yrd, Random(1, 3))
			Sleep(200)
			MouseClick("left", 70 + $xrd, 500 + $yrd, Random(1, 3))
			Sleep(500 + $guiWalkspeedAdjust)
	EndSwitch
	
	$coord = PixelSearch(10, 300, 400, 580, 0x18FB01, 10, 1, $title)
	If Not @error Then
		TrayTip("", "3", 1, 16)
		MouseClick("left", $coord[0] + Random(50, 60), $coord[1], Random(1, 3))
		CheckMove($Char_CheckMoveDelay)
	EndIf
EndFunc   ;==>a5down2


Func a5downLeft1() ; 小站附近往红门的这段
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0
		$begin1 = TimerInit() ;找到箱子处的方块，并走左边 按住鼠标方式
		Do
			$coord = PixelSearch(400, 300, 700, 400, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseMove(140 + $xrd, 530 + $yrd)
				MouseDown("left")
				Sleep(50)
				$findflag = 0
			Else
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 6000
		MouseUp("left")
	EndIf
EndFunc   ;==>a5downLeft1

Func a5downLeft2()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0
		$begin1 = TimerInit() ;小站左边的方块，按住鼠标方式
		Do
			$coord = PixelSearch(150, 300, 400, 350, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseMove(350 + $xrd, 530 + $yrd)
				MouseDown("left")
				Sleep(50)
				$findflag = 0
			Else
				MouseMove($coord[0] + 100, $coord[1] + 100, Random(0, 15))
				$findflag = 1
				Sleep(2000)
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 6000
		MouseUp("left")
		;Sleep(1000)
	EndIf
EndFunc   ;==>a5downLeft2
Func a5downLeft3()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0
		$begin1 = TimerInit() ;红门右边这个方块，按住鼠标方式
		Do
			$coord = PixelSearch(100, 300, 400, 450, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseMove(350 + $xrd, 530 + $yrd)
				MouseDown("left")
				Sleep(50)
				$findflag = 0
			Else
				MouseMove($coord[0], $coord[1])
				;Sleep(1000)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 5000
		MouseUp("left")
		Sleep(1000)
		CheckMove($Char_CheckMoveDelay)
		;CheckMove($Char_CheckMoveDelay)
	EndIf
EndFunc   ;==>a5downLeft3

Func a5clickRight1()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right down1
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(10, 310, 700, 450, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseClick("left", 270 + $xrd, 500 + $yrd, Random(1, 5, 1))
				Sleep(50)
				$findflag = 0
			Else
				MouseClick("left", $coord[0] + 400, $coord[1] - 50, Random(3, 5, 1))
				Sleep(1500)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 8000
		MouseClick("left", 350, 350, Random(1, 3, 1), Random(5, 10))
		Sleep(300)
	EndIf
EndFunc   ;==>a5clickRight1

Func a5clickRight2()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right ; 到箱子的下方位置
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(150, 200, 400, 350, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseClick("left", 140 + $xrd, 450 + $yrd, Random(1, 5, 1))
				Sleep(50)
				$findflag = 0
			Else
				MouseClick("left", $coord[0] + 80, $coord[1] + 150, Random(3, 5, 1))
				Sleep(500)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 6000
	EndIf
EndFunc   ;==>a5clickRight2

Func a5clickRight3()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right ; 从箱子下方找右边第二个方格
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(400, 300, 700, 400, 0x18FB01, 10, 1, $title)
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
EndFunc   ;==>a5clickRight3

Func a5clickRight4()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right ; 从箱子下方找右边第3个 旗杆右边
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(150, 310, 400, 400, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseClick("left", 180 + $xrd, 500 + $yrd, Random(1, 5, 1))
				Sleep(50)
				$findflag = 0
			Else
				MouseClick("left", $coord[0] - 200, $coord[1] + 50, Random(3, 5, 1))
				Sleep(500)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 5000
	EndIf
EndFunc   ;==>a5clickRight4

Func a5clickRight5()
	If isInRoom() Then
		$xrd = Random(-2, 2, 1)
		$yrd = Random(-2, 2, 1)
		$findflag = 0 ;a5right ; 找红门右边这个方块
		$begin1 = TimerInit()
		Do
			$coord = PixelSearch(150, 250, 400, 400, 0x18FB01, 10, 1, $title)
			If @error Then
				MouseClick("left", 180 + $xrd, 350 + $yrd, Random(1, 5, 1))
				Sleep(50)
				$findflag = 0
			Else
				MouseClick("left", $coord[0] - 20, $coord[1], Random(3, 5, 1))
				Sleep(800)
				$findflag = 1
			EndIf
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 5000
		CheckMove($Char_CheckMoveDelay)
	EndIf
EndFunc   ;==>a5clickRight5


