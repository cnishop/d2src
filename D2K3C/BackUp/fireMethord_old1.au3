AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;AutoItSetOption("MouseClickDelay", 1)

;#include <colormanger.au3>

Global $titlefiremethord
Local $sanctury
Local $monsterColor1 = "0xFC2C00" ; 怪物方块颜色1，比如红色   ；FC2C00原k3c的   0x012CFD
Local $monsterColor2 = "0x2460D8" ; 怪物方块颜色2，比如被冰击中后变色浅蓝色   5c70e4
Local $monsterColor3 = "0x2260D7" ;蓝色，比如矫正者
Local $monsterColor1_hex = "FC2C00"
Local $monsterColor2_hex = "2460D8"
Local $monsterColor2_hex = "2260D7"



Local $monsterColor[5] ;用于存放颜色数组
Local $monsterColor_hex[5] ;

$monsterColor[0] = "0xFC2C00"
$monsterColor[1] = "0x2460D8"
$monsterColor[2] = "0x2360D7" ;方块色
$monsterColor[3] = "0x6390DF"
$monsterColor[4] = "0x48F8F7"

$monsterColor_hex[0] = "FC2C00"
$monsterColor_hex[1] = "2460D8"
$monsterColor_hex[2] = "2360D7"
$monsterColor_hex[3] = "6390DF"
$monsterColor_hex[4] = "48F8F7"

Func takefire($var = 1)
	Select
		Case $var = 1
			icesor()
		Case $var = 2
			firesor()
		Case Else
			fireicesor()
	EndSelect
EndFunc   ;==>takefire


Func icesor()
	Send("{F2}") ;攻击技能
	Sleep(50)
	
	If $sanctury = 1 Then
		TrayTip("", "雇佣兵带庇护，远距离攻击", 1, 16)
		For $i = 1 To 3
			MouseClick("right", 560 + $i * 18, 140 - $i * 15, 1)
			addBloodtorole()
			Sleep(2000)
		Next
	Else
		
		
		Sleep(50)
		For $i = 1 To 3 Step 1
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


Func fire3c($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $bhtime)
	$count = 0
	$FailsCount = 0
	Sleep(50)
	Send("{" & $char_Bh & "}")
	Sleep(30)
	Send("{" & $char_Conc & "}")
	Sleep(30)
	$beginAttackTime = TimerInit()
	
	;---------------最开始先打一次
	If isInRoom() Then
		
		If $testversion = 0 Then ;如果是正式版，可以找图片
			$coord = finPicPos("images\cui3.bmp", 0.7)
			;$coord = findcui2()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "调整位置移动.", 1, 16)
				;MouseClick("left", $coord[0], $coord[1], 1);
				;Sleep(20)
				MouseClick("left", 500, 200, 2);
				Sleep(Random(400, 600, 1))
			EndIf
			
			$coord = finPicPos("images\cui4.bmp", 0.7)
			;$coord = findcui2()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "3C点移动下位置", 1, 16)
				MouseClick("left", $coord[0] + 30, $coord[1] + 180, 1);
				;Sleep(200)
				;MouseClick("left", 500, 200, 2);
				CheckMove(400)
				;Sleep(Random(400, 600, 1))
			EndIf
		EndIf
		
		bhfire($bhtime, 430, 320)
	EndIf
	;---------------最开始先打一次
	#CS 	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, "0xFC2C00", 0, 10)
		If Not @error Then
		
		Sleep(Random(100, 200))
		If bhfire($bhtime, 430, 320) = False Then
		Return
		EndIf
		Else
		$FailsCount = $FailsCount + 1
		EndIf
		$count = $count + 1
		$dif = TimerDiff($beginAttackTime)
		Until $FailsCount > 5 Or $dif > 40000 Or $count > 5
	#CE
	
EndFunc   ;==>fire3c


;~ Func fire3cByBlock($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $bhtime)
;~ 	$findrecround = 0 ;  中间往四周找的次数
;~ 	$findfourround = 0 ;四个方位找怪

;~ 	$XBS_Start = $XBS_Start
;~ 	$YBS_Start = $YBS_Start
;~ 	$XBS_Stop = $XBS_Stop
;~ 	$YBS_Stop = $YBS_Stop
;~ 	
;~ 	$xleft_diff = 200
;~ 	$ytop_diff = 150
;~ 	$xright_diff = 200
;~ 	$ybottom_diff = 150
;~ 	
;~ 	$firstAttack = 0 ;  定义第一种找怪的方式是否有找到
;~ 	
;~ 	;Dim $position[4] ;定义一个记录4个方位的数组
;~ 	
;~ 	
;~ 	#CS
;~ 		$xleft_diff = 0
;~ 		$ytop_diff = 0
;~ 		$xright_diff = 0
;~ 		$ybottom_diff = 0
;~ 	#CE
;~ 	
;~ 	
;~ 	
;~ 	$FailsCount = 0
;~ 	Sleep(50)
;~ 	Send("{" & $char_Bh & "}")
;~ 	Sleep(30)
;~ 	Send("{" & $char_Conc & "}")
;~ 	Sleep(30)
;~ 	$beginAttackTime = TimerInit()
;~ 	
;~ 	;---------------最开始先打一次
;~ 	bhfire($bhtime, 430, 320)
;~ 	;---------------最开始先打一次
;~ 	
;~ 	Do
;~ 		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, "0xFC2C00", 0, 10)
;~ 		If Not @error Then
;~ 			TrayTip("", "发现类似目标，锁定需攻击的3C.", 1, 16)
;~ 			Sleep(20)
;~ 			$XBC = 400 ;以人物坐标为中心， 太远离，肯定肯定打不到
;~ 			$YBC = 300

;~ 			While 1
;~ 				
;~ 				$coord = finPicPos("images\cui3.bmp", 0.7)
;~ 				;$coord = findcui2()
;~ 				If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 					TrayTip("", "调整位置移动.", 1, 16)
;~ 					;MouseClick("left", $coord[0], $coord[1], 1);
;~ 					;Sleep(20)
;~ 					MouseClick("left", 500, 200, 2);
;~ 					Sleep(Random(400, 600, 1))
;~ 				EndIf
;~ 				
;~ 				$coord = finPicPos("images\cui4.bmp", 0.7)
;~ 				;$coord = findcui2()
;~ 				If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 					TrayTip("", "3C点移动下位置", 1, 16)
;~ 					MouseClick("left", $coord[0] + 30, $coord[1] + 180, 1);
;~ 					;Sleep(200)
;~ 					;MouseClick("left", 500, 200, 2);
;~ 					CheckMove(40)
;~ 					;Sleep(Random(400, 600, 1))
;~ 				EndIf
;~ 				
;~ 				
;~ 				If addBloodtorole() = 0 Or addmanatorole() = 0 Then
;~ 					TrayTip("", "腰带没药了..", 1, 16)
;~ 					;Sleep(500)
;~ 					Return
;~ 				EndIf
;~ 				addBloodtopet() ;给pet 加的
;~ 				
;~ 				If checkNowDead() = 1 Then ;如果死亡
;~ 					;ExitLoop 2
;~ 					TrayTip("", "人物挂了...", 1, 16)
;~ 					Sleep(100)
;~ 					Return
;~ 				EndIf
;~ 				
;~ 				#CS 				$position[0] = "$XBC - $xleft_diff, $YBC - $ytop_diff, 400, 300"
;~ 					$position[1] = "400, $YBC - $ytop_diff, $XBC + $xright_diff, 300"
;~ 					$position[2] = "400, 300, $XBC + $xright_diff, $YBC + $ybottom_diff"
;~ 					$position[3] = "$XBC - $xleft_diff, 300, 400, $YBC + $ybottom_diff"
;~ 				#CE
;~ 				$firstAttack = 0 ;先将找怪标志置为0
;~ 				
;~ 				$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, 400, 300) ;1
;~ 				If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 					TrayTip("", "10点方向", 1, 16)
;~ 					MouseMove($tp_Pix[0], $tp_Pix[1])
;~ 					adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
;~ 					If bhfire($bhtime, $tp_Pix[0], $tp_Pix[1]) = 0 Then
;~ 						TrayTip("", "腰带没药了..", 1, 16)
;~ 						Return
;~ 					EndIf
;~ 					$xleft_diff = 0
;~ 					$ytop_diff = 0
;~ 					$xright_diff = 0
;~ 					$ybottom_diff = 0
;~ 					$firstAttack = 1
;~ 					TrayTip("", "继续检测3C..", 1, 16)
;~ 					ContinueLoop
;~ 				EndIf
;~ 				
;~ 				$tp_Pix = countFirepointRec(400, $YBC - $ytop_diff, $XBC + $xright_diff, 300) ;2
;~ 				If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 					TrayTip("", "1点方向", 1, 16)
;~ 					MouseMove($tp_Pix[0], $tp_Pix[1])
;~ 					adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
;~ 					If bhfire($bhtime, $tp_Pix[0], $tp_Pix[1]) = 0 Then
;~ 						TrayTip("", "腰带没药了..", 1, 16)
;~ 						Return
;~ 					EndIf
;~ 					$xleft_diff = 0
;~ 					$ytop_diff = 0
;~ 					$xright_diff = 0
;~ 					$ybottom_diff = 0
;~ 					TrayTip("", "继续检测3C..", 1, 16)
;~ 					$firstAttack = 1
;~ 					ContinueLoop
;~ 				EndIf
;~ 				
;~ 				$tp_Pix = countFirepointRec(400, 300, $XBC + $xright_diff, $YBC + $ybottom_diff) ;3
;~ 				If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 					TrayTip("", "4点方向", 1, 16)
;~ 					MouseMove($tp_Pix[0], $tp_Pix[1])
;~ 					adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
;~ 					If bhfire($bhtime, $tp_Pix[0], $tp_Pix[1]) = 0 Then
;~ 						TrayTip("", "腰带没药了..", 1, 16)
;~ 						Return
;~ 					EndIf
;~ 					$xleft_diff = 0
;~ 					$ytop_diff = 0
;~ 					$xright_diff = 0
;~ 					$ybottom_diff = 0
;~ 					$firstAttack = 1
;~ 					TrayTip("", "继续检测3C..", 1, 16)
;~ 					ContinueLoop
;~ 				EndIf
;~ 				
;~ 				$tp_Pix = countFirepointRec($XBC - $xleft_diff, 300, 400, $YBC + $ybottom_diff) ;3
;~ 				If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 					TrayTip("", "8点方向", 1, 16)
;~ 					MouseMove($tp_Pix[0], $tp_Pix[1])
;~ 					adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
;~ 					If bhfire($bhtime, $tp_Pix[0], $tp_Pix[1]) = 0 Then
;~ 						TrayTip("", "腰带没药了..", 1, 16)
;~ 						Return
;~ 					EndIf
;~ 					$xleft_diff = 0
;~ 					$ytop_diff = 0
;~ 					$xright_diff = 0
;~ 					$ybottom_diff = 0
;~ 					$firstAttack = 1
;~ 					TrayTip("", "继续检测3C..", 1, 16)
;~ 					ContinueLoop
;~ 				EndIf
;~ 				
;~ 				If $firstAttack = 1 Then ;表示以上攻击方式找到了
;~ 					
;~ 				Else
;~ 					If addBloodtorole() = 0 Or addmanatorole() = 0 Then
;~ 						Return
;~ 					EndIf
;~ 					addBloodtopet()
;~ 					
;~ 					TrayTip("", "启用其他检测方式", 1, 16)
;~ 					MouseMove(400, 300)
;~ 					Select
;~ 						Case AreaColorCountCheck($XBC - $xleft_diff, $YBC - $ytop_diff, 400, 300, 100, "FC2C00", 15, 0, 15) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "10点方向", 1, 16)

;~ 							If bhfire($bhtime, 500, 300) = False Then
;~ 								Return
;~ 							EndIf
;~ 							$xleft_diff = 0
;~ 							$ytop_diff = 0
;~ 							$xright_diff = 0
;~ 							$ybottom_diff = 0
;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 							
;~ 						Case AreaColorCountCheck(400, $YBC - $ytop_diff, $XBC + $xright_diff, 300, 100, "FC2C00", 15, 0, 15) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "1点方向", 1, 16)
;~ 							
;~ 							If bhfire($bhtime, 500, 300) = False Then
;~ 								Return
;~ 							EndIf
;~ 							$xleft_diff = 0
;~ 							$ytop_diff = 0
;~ 							$xright_diff = 0
;~ 							$ybottom_diff = 0
;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case AreaColorCountCheck(400, 300, $XBC + $xright_diff, $YBC + $ybottom_diff, 100, "FC2C00", 15, 0, 15) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "4点方向", 1, 16)

;~ 							If bhfire($bhtime, 500, 300) = False Then
;~ 								Return
;~ 							EndIf
;~ 							$xleft_diff = 0
;~ 							$ytop_diff = 0
;~ 							$xright_diff = 0
;~ 							$ybottom_diff = 0
;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case AreaColorCountCheck($XBC - $xleft_diff, 300, 400, $YBC + $ybottom_diff, 100, "FC2C00", 15, 0, 15) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "8点方向", 1, 16)

;~ 							If bhfire($bhtime, 500, 300) = False Then
;~ 								Return
;~ 							EndIf
;~ 							$xleft_diff = 0
;~ 							$ytop_diff = 0
;~ 							$xright_diff = 0
;~ 							$ybottom_diff = 0
;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case Else
;~ 							TrayTip("", "目标不满足条件", 1, 16)

;~ 							$findfourround = $findfourround + 1
;~ 							If $findfourround >= 5 Then
;~ 								ExitLoop 2
;~ 							EndIf
;~ 							
;~ 							
;~ 					EndSelect
;~ 					
;~ 					;ExitLoop
;~ 				EndIf
;~ 				;Else ;如果规定的矩形区域内没有找到点
;~ 				Sleep(1)
;~ 				$xleft_diff = $xleft_diff + 100
;~ 				$ytop_diff = $ytop_diff + 50
;~ 				$xright_diff = $xright_diff + 100
;~ 				$ybottom_diff = $ybottom_diff + 50
;~ 				TrayTip("", "没有合适的目标.继续找" & $findrecround, 1, 16)
;~ 				Sleep(1)
;~ 				If $xleft_diff >= 400 Or $ytop_diff >= 250 Or $xright_diff >= 400 Or $ybottom_diff >= 250 Then ;如果超过范围，就退出
;~ 					$xleft_diff = 200
;~ 					$ytop_diff = 150
;~ 					$xright_diff = 200
;~ 					$ybottom_diff = 150
;~ 					$findrecround = $findrecround + 1
;~ 					If $findrecround >= 3 Then
;~ 						ExitLoop 1
;~ 					EndIf
;~ 				EndIf
;~ 				
;~ 				;EndIf
;~ 				
;~ 				;此处增加一个可能一直隔着墙一直打怪的情况判断
;~ 				$dif = TimerDiff($beginAttackTime)
;~ 				If $dif >= 60000 Then
;~ 					ExitLoop 2
;~ 				EndIf
;~ 				
;~ 			WEnd
;~ 		Else;即一个红色点都没找到的话，再次查找，如果累计不满足条件，就退出
;~ 			
;~ 			$FailsCount = $FailsCount + 1
;~ 			Sleep(Random(100, 200))
;~ 			$dif = TimerDiff($beginAttackTime)
;~ 		EndIf
;~ 	Until $FailsCount >= 3 Or $dif >= 50000 ;搜索失败次数大于5次 或者 超过了30秒
;~ 	Return 0
;~ EndFunc   ;==>fire3cByBlock


;===========================================================
; Will count the pixel number of passed color in passed area
;===========================================================
Func AreaColorCountCheck($XStart, $YStart, $XStop, $YStop, $Step, $Color, $MiniMatch, $Delay, $Tries)
	$XStart = $XStart
	$YStart = $YStart
	$XStop = $XStop
	$YStop = $YStop
	Do
		Sleep($Delay)
		$Tries = $Tries - 1
		$ColorCount = 0
		For $X = $XStart To $XStop Step $Step
			For $Y = $YStart To $YStop Step $Step
				$Apix = PixelGetColor($X, $Y)
				
				If Hex($Apix, 6) == $Color Then ; "FC2C00"
					;If $Apix == $Color Then
					$ColorCount = $ColorCount + 1
				EndIf
			Next
		Next
		If $ColorCount >= $MiniMatch Then
			;DebugLog('AreaColorCountCheck: $MiniMatch: ' & $MiniMatch)
			Return 1
		EndIf

	Until ($Tries < 0)
	Return 0
EndFunc   ;==>AreaColorCountCheck

Func bhfire($Round, $X = 450, $Y = 350)
	$stopattack = 0
	
	If isInRoom() Then
		Send("{" & $char_Bh & "}")
		Sleep(30)
		Send("{" & $char_Conc & "}")
		Sleep(30)
		For $i = 0 To $Round Step 1
			TrayTip("", "开始释放bh了.." & $Round - $i, 1, 16)
			Send("{LSHIFT down}")
			Sleep(10)
				MouseClick("left", $X, $Y, 1)
				Sleep(10)
			Send("{LSHIFT up}")
			Sleep(1)
		Next
		
		If $stopattack = 1 Then
			Return 0
		Else
			Return 1
		EndIf
		
	Else
		Return 0
	EndIf
	;MouseUp("left")
EndFunc   ;==>bhfire

Func adjustDistance($X, $Y, $max, $min)
	$xx = 0
	$yy = 0
	$xx = $X - 401
	$yy = $Y - 298
	$xiebian = Sqrt($xx * $xx + $yy * $yy)
	TrayTip("", "怪距离：" & $xiebian, 1, 16)
	If $xiebian >= $max Then
		TrayTip("", "距离怪物太远了，不一定攻击到", 1, 16)
		Send("{" & $char_normal_attack & "}")
		Sleep(100)
		MouseClick("left", $X, $Y, 2)
		Sleep(500)
		Send("{" & $char_Bh & "}")
		Sleep(50)
		
	ElseIf $xiebian <= $min Then
		TrayTip("", "距离太近了，不一定攻击到,稍微移动下", 1, 16)
		Sleep(100)
		MouseClick("left", 400 + Random(-100, 100, 1), 300 + Random(-50, 50, 1), 2)
		Sleep(50)
	EndIf
EndFunc   ;==>adjustDistance

;~ Func countFirepointRec($left, $top, $right, $bottom)
;~ 	$postion = PixelSearch($left, $top, $right, $bottom, "0xFC2C00", 0, 10)
;~ 	;$tp_Pix = PixelSearch(50, 20, 790, 520, "0xFC2C00", 0, 10)
;~ 	If Not @error Then
;~ 		TrayTip("", "攻击范围内查找到可能的目标，准备检测", 1, 16)
;~ 		Dim $tp_PixS[13]
;~ 		$tp_PixS[1] = PixelGetColor($postion[0] + 10, $postion[1])
;~ 		$tp_PixS[2] = PixelGetColor($postion[0] + 13, $postion[1])
;~ 		$tp_PixS[3] = PixelGetColor($postion[0] - 10, $postion[1])
;~ 		$tp_PixS[4] = PixelGetColor($postion[0] - 13, $postion[1])
;~ 		$tp_PixS[5] = PixelGetColor($postion[0], $postion[1] + 10)
;~ 		$tp_PixS[6] = PixelGetColor($postion[0], $postion[1] + 13)
;~ 		$tp_PixS[7] = PixelGetColor($postion[0], $postion[1] - 10)
;~ 		$tp_PixS[8] = PixelGetColor($postion[0], $postion[1] - 13)
;~ 		
;~ 		$tp_PixS[9] = PixelGetColor($postion[0] + 30, $postion[1])
;~ 		$tp_PixS[10] = PixelGetColor($postion[0] + 40, $postion[1])
;~ 		$tp_PixS[11] = PixelGetColor($postion[0], $postion[1] + 33)
;~ 		$tp_PixS[12] = PixelGetColor($postion[0], $postion[1] + 50)
;~ 		
;~ 		
;~ 		$SimpleCounter = 0
;~ 		For $p = 1 To 12
;~ 			If Hex($tp_PixS[$p], 6) == "FC2C00" Then
;~ 				$SimpleCounter = $SimpleCounter + 1
;~ 			EndIf
;~ 		Next
;~ 		If $SimpleCounter >= 5 Then
;~ 			
;~ 		Else
;~ 			$postion[0] = $postion[0] - 800
;~ 			$postion[1] = $postion[0] - 600
;~ 		EndIf
;~ 	Else
;~ 		Dim $postion[2]
;~ 		$postion[0] = $postion[0] - 800
;~ 		$postion[1] = $postion[0] - 600
;~ 	EndIf
;~ 	Return $postion
;~ EndFunc   ;==>countFirepointRec


Func countFirepointRec($left, $top, $right, $bottom, $mColor, $mColor_hex)
	$postion = PixelSearch($left, $top, $right, $bottom, $mColor, 0, 10,$title)
	;$tp_Pix = PixelSearch(50, 20, 790, 520, "0xFC2C00", 0, 10)
	If Not @error Then
		;TrayTip("", "攻击范围内查找到可能的目标，继续精确判断", 1, 16)
		Dim $tp_PixS[13]
		$tp_PixS[1] = PixelGetColor($postion[0] + 10, $postion[1])
		$tp_PixS[2] = PixelGetColor($postion[0] + 13, $postion[1])
		$tp_PixS[3] = PixelGetColor($postion[0] - 10, $postion[1])
		$tp_PixS[4] = PixelGetColor($postion[0] - 13, $postion[1])
		$tp_PixS[5] = PixelGetColor($postion[0], $postion[1] + 10)
		$tp_PixS[6] = PixelGetColor($postion[0], $postion[1] + 13)
		$tp_PixS[7] = PixelGetColor($postion[0], $postion[1] - 10)
		$tp_PixS[8] = PixelGetColor($postion[0], $postion[1] - 13)
		
		$tp_PixS[9] = PixelGetColor($postion[0] + 11, $postion[1])
		$tp_PixS[10] = PixelGetColor($postion[0] + 12, $postion[1])
		$tp_PixS[11] = PixelGetColor($postion[0], $postion[1] + 11)
		$tp_PixS[12] = PixelGetColor($postion[0], $postion[1] + 12)
		
		
		$SimpleCounter = 0
		For $p = 1 To 12
			If Hex($tp_PixS[$p], 6) == $mColor_hex Then
				$SimpleCounter = $SimpleCounter + 1
;~ 				TrayTip("", $p & "  " & $SimpleCounter, 1, 16)
;~ 				Sleep(200)
			EndIf
		Next
		If $SimpleCounter >= 5 Then
			TrayTip("", "检测到怪物..", 1, 16)
		Else
			$postion[0] = $postion[0] - 800
			$postion[1] = $postion[0] - 600
			TrayTip("", "怪物不匹配", 1, 16)
		EndIf
	Else
		Dim $postion[2]
		$postion[0] = $postion[0] - 800
		$postion[1] = $postion[0] - 600
		TrayTip("", "未检测到", 1, 16)
	EndIf
	Return $postion
EndFunc   ;==>countFirepointRec


Func fireMonsterByBlock($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode, $delayTime) ; $kpmode =1 ,表示只打右上角 $delayTime 限定一个时间
	$findrecround = 0 ;  中间往四周找的次数
	$findfourround = 0 ;四个方位找怪

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 50
	$ytop_diff = 50
	$xright_diff = 50
	$ybottom_diff = 50
	
	$firstAttack = 0 ;  定义第一种找怪的方式是否有找到
	
	Local $i = 0 ;变量，用于循环颜色
	;Dim $position[4] ;定义一个记录4个方位的数组
	
	;有好几种颜色，增加一个大循环
	
	
	$FailsCount = 0
;~ 	If ($kpmode = 1) Then
;~ 		Send("{" & $char_fireFire & "}")
;~ 		Sleep(10)
;~ 		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), Random(1, 5))
;~ 		Sleep(50)
;~ 	EndIf
	$beginAttackTime = TimerInit()
	
	;---------------最开始先打一次
	;bhfire($bhtime, 430, 320)
	;---------------最开始先打一次
	;TrayTip("", "开始准备打击", 1, 16)

	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 30, 10, $title)
		If Not @error Then
			TrayTip("", "发现目标，准备锁定需攻击的怪物", 1, 16)
			$XBC = 400 ;以人物坐标为中心， 太远离，肯定肯定打不到
			$YBC = 300

			While 1
				;此处增加一个可能一直隔着墙一直打怪的情况判断，超过20秒就不打了
				$dif = TimerDiff($beginAttackTime)
				;ToolTip("", $dif, 1, 16)
				If $dif >= $delayTime Then
					ExitLoop 2
				EndIf
				
				
				$firstAttack = 0 ;先将找怪标志置为0
;~

					$tp_Pix = countFirepointRec(400, $YBC - $ytop_diff, $XBC + $xright_diff, 350, $monsterColor[$i], $monsterColor_hex[$i]) ;2
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						;MouseMove($tp_Pix[0], $tp_Pix[1], 0)
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
						If bhfire(5, $tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "攻击失败", 1, 16)
							ExitLoop
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						;TrayTip("", "重新循环检测..", 1, 16)
						$firstAttack = 1
						ContinueLoop
					EndIf

;~
;~ 					$xleft_diff = $xleft_diff + 50
;~ 					$ytop_diff = $ytop_diff + 50
;~ 					$xright_diff = $xright_diff + 50
;~ 					$ybottom_diff = $ybottom_diff + 50
					
				
				
				TrayTip("", "扩大搜索范围.." & $findrecround, 1, 16)
				Sleep(1)
				If $xleft_diff >= 400 Or $ytop_diff >= 300 Or $xright_diff >= 400 Or $ybottom_diff >= 300 Then ;如果超过范围，就退出
					$xleft_diff = 200
					$ytop_diff = 200
					$xright_diff = 200
					$ybottom_diff = 250
					$findrecround = $findrecround + 1
					TrayTip("", "继续新一轮循环" & $findrecround, 1, 16)
					If $findrecround >= 8 Then
						ExitLoop 1
					EndIf
				EndIf
				
				;EndIf
				

				
			WEnd
		Else;即一个红色点都没找到的话，再次查找，如果累计不满足条件，就退出
			
			$FailsCount = $FailsCount + 1
			$dif = TimerDiff($beginAttackTime)
		EndIf
		$i = $i + 1
		If ($i > 4) Then
			$i = 0 ;循环颜色，防止超过数组上限溢出
		EndIf

	Until $FailsCount >= 6 Or $dif >= $delayTime ;搜索失败次数大于5次 或者 总时间超过了50秒
	Return 0
EndFunc   ;==>fireMonsterByBlock