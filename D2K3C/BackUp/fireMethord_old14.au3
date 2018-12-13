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
		Sleep(10)
		Send("{" & $char_Conc & "}")
		Sleep(30)
		TrayTip("", "开始释放bh了..", 1, 16)
		Send("{LSHIFT down}")
		Sleep(10)
		For $i = 0 To $Round Step 1
			MouseClick("left", $X, $Y, Random(1, 4, 1))
			Sleep(50)
		Next
		Send("{LSHIFT up}")
		Sleep(10)
		Send("{LSHIFT}")
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


Func fireMonsterByBlock($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode, $delayTime) ; $kpmode =1 ,表示只打右上角 $delayTime 限定一个时间
	$findrecround = 0 ;  中间往四周找的次数
	$findfourround = 0 ;四个方位找怪

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 100
	$ytop_diff = 100
	$xright_diff = 100
	$ybottom_diff = 100
	
	$firstAttack = 0 ;  定义第一种找怪的方式是否有找到
	
	Local $i = 0 ;变量，用于循环颜色
	;Dim $position[4] ;定义一个记录4个方位的数组
	
	;有好几种颜色，增加一个大循环
	
	
	$FailsCount = 0
	$beginAttackTime = TimerInit()
	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 30, 5, $title)
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
				;在第一个点打怪;中间位置 ，且不停的移动位置打怪
				$find1 = 0
				Do
					$inMiddle = Middle3c()
					If $inMiddle <> -1 Then
						MouseClick("left", $inMiddle[0] - 100, $inMiddle[1] + 80, Random(1, 3, 1))
						Sleep(1000)
						;每次移动一下方位
						$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;2
						If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
							;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
							;MouseMove($tp_Pix[0], $tp_Pix[1], 0)
							;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;移动距离
							If bhfire(30, $tp_Pix[0], $tp_Pix[1]) = 0 Then
								TrayTip("", "攻击失败", 1, 16)
								ExitLoop
							Else; 如果成功，则继续
								$FailsCount =0
								$find1 = 0
							EndIf
						Else; 如果没有找到，就标记下
							$find1 = $find1 + 1
						EndIf
					EndIf
				Until $inMiddle = -1 Or  $find1 >= 10
				TrayTip("", "换地点攻击", 1, 16)
				Sleep(1000)
				
				;走到门上面
				$coord = PixelSearch(150, 50, 700, 520, 0x18FC00, 25, 1, $title)
				If Not @error Then
					MouseClick("left", $coord[0] + 150, $coord[1] - 80, Random(2, 4, 1))
					Sleep(1000)
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;2
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						If bhfire(30, $tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "攻击失败", 1, 16)
							ExitLoop
													Else; 如果成功，则继续
								$FailsCount =0
								$find1 = 0
						EndIf
					EndIf
				EndIf


			WEnd
		Else;即一个红色点都没找到的话，再次查找，如果累计不满足条件，就退出
			
			$FailsCount = $FailsCount + 1
			$dif = TimerDiff($beginAttackTime)
		EndIf
		
;~ 		$i = $i + 1
;~ 		If ($i > 4) Then
;~ 			$i = 0 ;循环颜色，防止超过数组上限溢出
;~ 		EndIf

	Until $FailsCount >= 10 Or $dif >= $delayTime ;搜索失败次数大于5次 或者 总时间超过了50秒
	Return 0
EndFunc   ;==>fireMonsterByBlock


Func Middle3c()
	$coordLeft = PixelSearch(10, 10, 700, 500, 0x18FC00, 25, 1, $title)
	If Not @error Then
		;MouseMove($coordLeft[0]  ,$coordLeft[1] )  ;    x 中间空格  55~ 75 + 80 ,  y 空格 -35~ 40
		$coordRight = PixelSearch($coordLeft[0] + 82, $coordLeft[1] + 42, 700, 500, 0x18FC00, 25, 1, $title)
		If Not @error Then
			;表示找到了标记位，继续判断是下方的，还是上方的
			$coordRightTop = PixelSearch($coordRight[0] + 80, 5, 790, $coordRight[1] - 40, 0x18FC00, 25, 1, $title)
			If Not @error Then ;如果右上角有，表示，人物处在下方位置
				;MouseClick("left", $coordLeftTop[0] - 100, $coordLeftTop[1] + 50, Random(1,5,1),Random(0,8,1)   )
				Return -1 ;$coordRightTop
			Else
				Return $coordRight
				;MouseClick("left", $coordRight[0] - 100, $coordRight[1] + 50, Random(1,5,1) ,Random(0,8,1) )
			EndIf
		Else
			Return -1
		EndIf
	Else
		Return -1
	EndIf
	
EndFunc   ;==>Middle3c

