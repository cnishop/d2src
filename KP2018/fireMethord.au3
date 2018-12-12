AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;AutoItSetOption("MouseClickDelay", 1)

;#include <colormanger.au3>

#include <Array.au3>

Global $titlefiremethord
Global $fireround
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



Func takefire($var = 1, $time = 3, $blzrnd = 1)
	Select
		Case $var = 1
			icesor($time, $blzrnd)
		Case $var = 2
			firesor()
		Case $var = 4 ;可以为角色定制技能
			sor109($time)
		Case Else
			fireicesor()
	EndSelect
EndFunc   ;==>takefire

Func sor109($ctime = 10)
	#CS
		Send("{F6}") ;攻击技能
		Sleep(20)
		MouseClick("right", 560, 140, 1)
		Sleep(40)
		Send("{F3}") ;攻击技能
		Sleep(50)
		For $i = 1 To $ctime - 4
		MouseClick("right", 560, 140, 1)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
		Sleep(200)
		Next
		
		Send("{F2}") ;攻击技能
		Sleep(50)
		For $i = 1 To $ctime + 5
		MouseClick("right", 560 + $i, 140 - $i, 1)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
		Sleep(200)
		Next
		
	#CE

	
	;Send("{F2}") ;攻击技能
	Send("{" & $char_fireFire & "}")
	For $i = $guifirelighttime To 1 Step -1
		TrayTip("", "攻击剩余次数" & $i, 1, 16)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(80)
		MouseClick("right", 560, 140, 1, 0)
		Sleep(80)
		MouseClick("right", 560, 140, 1, 0)
		Sleep(80)
	Next

EndFunc   ;==>sor109

Func icesor($ctime = 3, $cblzrnd = 1)
	Dim $clickt1
	Dim $clickt2
	Dim $shiftc
	
	If $cblzrnd = 1 Then ;如果非固定，则次数为 2 -4 之间
		$ctime = Random(2, 4, 1)
	EndIf

	
	Send("{" & $char_blzIce & "}")
	Sleep(50)
	If $sanctury = 1 Then

		TrayTip("", "雇佣兵带庇护，远距离攻击", 1, 16)
		
		For $i = 1 To $ctime
			If checkNowDead() = 1 Then ;如果死亡
				;ExitLoop 2
				TrayTip("", "人物挂了...", 1, 16)
				Sleep(500)
				Send("{ESC}")
				Sleep(500)
				Return
			EndIf
			
			MouseClick("right", 560 + $i * 18, 140 - $i * 15, 1)
			addBloodtorole()
			addmanatorole()
			addBloodtopet()
			Sleep(2000)
		Next
	Else
		
		Sleep(50)
		
		$shiftc = Random(1, 5, 1)
		$shiftc = 1
		If $shiftc = 1 Then
			
			For $i = 1 To $ctime Step 1 ;带按 shift 键盘的攻击
				Send("{" & $char_blzIce & "}") ;攻击技能
				$clickt1 = Random(1, 5, 1)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				If checkNowDead() = 1 Then ;如果死亡
					;ExitLoop 2
					TrayTip("", "人物挂了...", 1, 16)
					Sleep(500)
					Send("{ESC}")
					Sleep(500)
					Return
				EndIf
				TrayTip("", "技能次数" & $ctime - $i + 1, 1, 16)
				addBloodtorole()
				addmanatorole()
				addBloodtopet()
				Sleep(100)
				
				$clickt2 = Random(1, 3, 1)
				Send("{LSHIFT down}") ;攻击技能
				Sleep(100)
				;$a = PixelChecksum(560, 360, 720, 440, 3, $title)
				For $j = 1 To 5
					MouseClick("left", 560 - $i * 15, 140 + $i * 10, $clickt2)
					Sleep(150)
				Next
				Sleep(800)
				
				Send("{LSHIFT up}") ;攻击技能
				
				;$b = PixelChecksum(560, 360, 720, 440, 3, $title)
				#CS 			If $a <> $b Then
					;writelog("攻击---未tp到指定位置或受到打击")
					writelog("异常---第 " & $fireround & " 局: 未tp到指定位置或受到打击")
					TrayTip("", "未tp到指定位置或收到打击", 1, 16)
					Sleep(10)
					ExitLoop
					EndIf
				#CE
			Next
			
		Else
			
			For $i = 1 To $ctime Step 1 ;不带按 shift 键盘的攻击
				Send("{" & $char_blzIce & "}") ;攻击技能
				$clickt1 = Random(1, 5, 1)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				If checkNowDead() = 1 Then ;如果死亡
					;ExitLoop 2
					TrayTip("", "人物挂了...", 1, 16)
					Sleep(500)
					Send("{ESC}")
					Sleep(500)
					Return
				EndIf
				TrayTip("", "技能次数" & $ctime - $i + 1, 1, 16)
				addBloodtorole()
				addmanatorole()
				addBloodtopet()
				Sleep(50)
				$clickt1 = Random(1, 5, 1)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				Sleep(200)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				Sleep(1400)
			Next
			
		EndIf
		
	EndIf
	
EndFunc   ;==>icesor

Func firesor()

	
	Send("{" & $char_fireFire & "}")
	For $i = $guifirelighttime To 1 Step -1
		TrayTip("", "攻击剩余次数" & $i, 1, 16)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
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
	MouseClick("left", 400, 300, 1)
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


Func fireMonsterByColor($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode) ; $kpmode =1 ,表示只打右上角
	$findrecround = 0 ;  中间往四周找的次数
	$findfourround = 0 ;四个方位找怪

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 200
	$ytop_diff = 150
	$xright_diff = 200
	$ybottom_diff = 200
	
	$firstAttack = 0 ;  定义第一种找怪的方式是否有找到
	
	Local $i = 0 ;变量，用于循环颜色
	;Dim $position[4] ;定义一个记录4个方位的数组
	
	;有好几种颜色，增加一个大循环
	
	
	$FailsCount = 0
	If ($kpmode = 1) Then
		Send("{" & $char_fireFire & "}")
		Sleep(10)
		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), Random(1, 3, 1))
		Sleep(50)
	EndIf
	$beginAttackTime = TimerInit()
	
	;---------------最开始先打一次
	;TrayTip("", "开始准备打击", 1, 16)

	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 10, 10, $title)
		If Not @error Then
			$FailsCount = 0
			TrayTip("", "启用模糊算法找怪攻击..."  , 1, 16)   ;

			If nowfire($XYBlock[0], $XYBlock[1]) = 0 Then
				TrayTip("", "攻击失败", 1, 16)
				ExitLoop
			EndIf
			
		Else
			$FailsCount = $FailsCount + 1
		EndIf
		
		$i = $i + 1
		If ($i >= 5) Then
			$i = 0 ;循环颜色，防止超过数组上限溢出
		EndIf
		$dif = TimerDiff($beginAttackTime)
		;TrayTip("", "倒计时： " & $dif, 1, 16)
	Until $FailsCount >= 10 Or $dif >= 30000 ;搜索失败次数大于5次 或者 总时间超过了50秒
	Return 0
EndFunc   ;==>fireMonsterByColor

Func fireMonsterByBlock($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode, $delayTime) ; $kpmode =1 ,表示只打右上角 $delayTime 限定一个时间
	$findrecround = 0 ;  中间往四周找的次数
	$findfourround = 0 ;四个方位找怪

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 200
	$ytop_diff = 150
	$xright_diff = 200
	$ybottom_diff = 200
	
	$firstAttack = 0 ;  定义第一种找怪的方式是否有找到
	
	Local $i = 0 ;变量，用于循环颜色
	;Dim $position[4] ;定义一个记录4个方位的数组
	
	;有好几种颜色，增加一个大循环
	
	
	$FailsCount = 0
	If ($kpmode = 1) Then
		Send("{" & $char_fireFire & "}")
		Sleep(10)
		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), Random(1, 5))
		Sleep(50)
	EndIf
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
				If ($kpmode = 1) Then
					$tp_Pix = countFirepointRec(400, $YBC - $ytop_diff, $XBC + $xright_diff, 350, $monsterColor[$i], $monsterColor_hex[$i]) ;2
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						;MouseMove($tp_Pix[0], $tp_Pix[1], 0)
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
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
				EndIf
;~
				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec(400, 300, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;3
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "4点方向精确定位： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "攻击失败", 1, 16)
							Return
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "继续检测..", 1, 16)
						ContinueLoop
					EndIf
				EndIf
				
				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, 300, 400, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;3
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "8点方向精确定位： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "攻击失败", 1, 16)
							Return
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "继续检测..", 1, 16)
						ContinueLoop
					EndIf
				EndIf

				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, 400, 300, $monsterColor[$i], $monsterColor_hex[$i]) ;1
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "10点方向精确定位： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离  sor 不用移动距离
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "攻击失败", 1, 16)
							ExitLoop ;继续循环尝试
						EndIf
						;$xleft_diff = 0  ;改成0，就是移动到下个区域找色
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "重新循环检测..", 1, 16)
						ContinueLoop
					EndIf
				EndIf
				
;~ 				If $firstAttack = 1 Then ;表示以上攻击方式找到了
;~ 				Else ;如果找单个红色方框的方式没找到，可能怪移动太快，可能被某些柱子挡住，改成找总像素的方式
;~
;~ 					TrayTip("", "启用其他检测方式", 1, 16)
;~ 					Sleep(1)
;~ 					MouseMove(400, 300)
;~ 					Select


;~ 						Case AreaColorCountCheck(400, 20, 780, 300, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "1点方向盲打", 1, 16)

;~ 							If nowfire(600, 150) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop

;~ 						Case AreaColorCountCheck(400, 300, 780, 580, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "4点方向盲打", 1, 16)

;~ 							If nowfire(600, 450) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case AreaColorCountCheck(20, 300, 400, 580, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "8点方向盲打", 1, 16)

;~ 							If nowfire(200, 450) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop

;~ 						Case AreaColorCountCheck(20, 20, 400, 300, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;如果不满住，尝试检查总像素看看
;~ 							TrayTip("", "10点方向盲打", 1, 16)
;~ 							If nowfire(200, 150) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case Else
;~ 							TrayTip("", "目标不满足条件", 1, 16)

;~ 							$findfourround = $findfourround + 1
;~ 							If $findfourround >= 3 Then
;~ 								ExitLoop 2
;~ 							EndIf
;~ 					EndSelect
;~
;~ 				EndIf
				
				If ($kpmode = 1) Then
					$xleft_diff = $xleft_diff
					$ytop_diff = $ytop_diff + 20 ;$ytop_diff + 40
					$xright_diff = $xright_diff + 20 ;$xright_diff + 80
					$ybottom_diff = $ybottom_diff
				Else
					$xleft_diff = $xleft_diff + 40
					$ytop_diff = $ytop_diff + 40
					$xright_diff = $xright_diff + 40
					$ybottom_diff = $ybottom_diff + 40
					
				EndIf
				
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
				TrayTip("", $X & " " & $Y, 1, 16)
				If Hex($Apix, 6) == $Color Then ; "FC2C00"
					;If $Apix == $Color Then
					$ColorCount = $ColorCount + 1
				EndIf
			Next
		Next
		
		If $ColorCount >= $MiniMatch Then
			TrayTip("", "区域像素找怪满足，可以打怪", 1, 16)
			Return 1
		EndIf

	Until ($Tries < 0)
	Return 0
EndFunc   ;==>AreaColorCountCheck

Func nowfire($X = 450, $Y = 350)
	$stopattack = 0
	;If isInRoom() Then
	Sleep(1)
	Send("{" & $char_fireFire & "}")
	For $i = 1 To 20 Step 1
		MouseClick("right", $X + 5, $Y + 15, Random(1, 5, 1), 0)
		Sleep(50)
	Next
	Return 1
	;Else
	;Return 0
	;EndIf
	;MouseUp("left")
EndFunc   ;==>nowfire

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
		Send("{" & $char_fireFire & "}")
		Sleep(50)
		
	ElseIf $xiebian <= $min Then
		TrayTip("", "距离太近了，不一定攻击到,稍微移动下", 1, 16)
		Sleep(100)
		MouseClick("left", 400 + Random(-100, 100, 1), 300 + Random(-50, 50, 1), 2)
		Sleep(50)
	EndIf
EndFunc   ;==>adjustDistance

Func countFirepointRec($left, $top, $right, $bottom, $mColor, $mColor_hex)
	$postion = PixelSearch($left, $top, $right, $bottom, $mColor, 0, 10, $title)
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
