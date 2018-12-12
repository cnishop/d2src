#region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.2.8
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** 参数创建于 ACNWrapper_GUI ****

#RequireAdmin




AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
#include <colormanger.au3>  ;调用找色的函数


#include <Array.au3>
;#include<af_search_pic.au3>;包含阿福源代码文件到脚本中


Global $titleImageSearch
Dim $size, $winleft, $winTop, $winright, $winBottom

$title = "d2"


; 得到包括 "this one" 内容的记事本窗口的句柄
$handle = WinGetHandle($title)
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口，请先打开")
	Exit
Else
	WinActivate($title)
	Sleep(1000)
EndIf

$size = WinGetClientSize($title)
If $size[0] <> 800 And $size[1] <> 600 Then
	MsgBox(0, "提示", "请先将窗口设置成800*600")
EndIf
Sleep(1000)

initialSize()

$char_fireFire = "F2"
$char_normal_attack = "F1"

Local $monsterColor[6] ;用于存放颜色数组
Local $monsterColor_hex[6] ;

$monsterColor[0] = "0xFC2C00"
$monsterColor[1] = "0x2460D8"
$monsterColor[2] = "0x2360D7" ;方块色
$monsterColor[3] = "0x6390DF" ;qian lanse
$monsterColor[4] = "0x48F8F7"
$monsterColor[5] = "0xA8CCFA" ;dan lanse

$monsterColor_hex[0] = "FC2C00"
$monsterColor_hex[1] = "2460D8"
$monsterColor_hex[2] = "2360D7"
$monsterColor_hex[3] = "6390DF"
$monsterColor_hex[4] = "48F8F7"
$monsterColor_hex[5] = "A8CCFA"


MouseMove(125, 400,0)

$var = PixelGetColor(125, 595) ;, "2C1008")  

ConsoleWrite(Hex($var, 6) & @CR)
ConsoleWrite(@DesktopDepth& @CR)


;~ 	$coord = PixelSearch(10, 10, 700, 500, 0x18FC00, 25, 1, $title)
;~ 	If Not @error Then
;~ 		MouseMove($coord[0]  ,$coord[1] )  ;    x 中间空格  55~ 75 + 80 ,  y 空格 -35~ 40 
;~ 			$coord1 = PixelSearch($coord[0] +82, $coord[1] +42, 700, 500, 0x18FC00, 25, 1, $title)
;~ 			If Not @error Then
;~ 				;MouseMove($coord1[0]  ,$coord1[1] ) 
;~ 				MouseClick("left", $coord1[0] -100  ,$coord1[1] +20,1 ) 
;~ 			EndIf
;~ 	EndIf

	 
exit

;425 700
;425  430

 

;MouseMove(150,150)



;~ $postion = PixelSearch(10, 100, 700, 350, $monsterColor1, 0, 10, $title)
;~ If Not @error Then
;~ 		;TrayTip("", "攻击范围内查找到可能的目标，继续精确判断", 1, 16)
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
;~ 		$tp_PixS[9] = PixelGetColor($postion[0] + 11, $postion[1])
;~ 		$tp_PixS[10] = PixelGetColor($postion[0] + 12, $postion[1])
;~ 		$tp_PixS[11] = PixelGetColor($postion[0], $postion[1] + 11)
;~ 		$tp_PixS[12] = PixelGetColor($postion[0], $postion[1] + 12)
;~
;~
;~ 		$SimpleCounter = 0
;~ 		For $p = 1 To 12
;~ 			TrayTip("", Hex($tp_PixS[$p], 6) & "  " & $monsterColor1_hex, 1, 16)
;~ 			Sleep(1000)
;~ 			If Hex($tp_PixS[$p], 6) == $monsterColor1_hex Then
;~ 				$SimpleCounter = $SimpleCounter + 1
;~  				;TrayTip("", $p & "  " & $SimpleCounter, 1, 16)
;~ 				TrayTip("", Hex($tp_PixS[$p], 6) & "  " & $monsterColor1_hex, 1, 16)
;~
;~  				Sleep(200)
;~ 			EndIf
;~ 		Next
;~ 		If $SimpleCounter >= 5 Then
;~ 			TrayTip("", "检测到怪物..", 1, 16)
;~ 		Else
;~ 			TrayTip("", "怪物不匹配", 1, 16)
;~ 		EndIf
;~ 	Else
;~ 		TrayTip("", "未检测到", 1, 16)
;~ 	EndIf

$monsterColor1 ="0x18FC00"     ;绿色方块 0x18FC00        ；紫色 0xA420FC
$monsterColor1_hex = "18FC00"

$tp_Pix = countFirepointRec(10, 10, 700, 540, $monsterColor1, $monsterColor1_hex  ) ;2  0x118FB01    ;0x00FC19, "00FC19"
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1], 0)
					EndIf


;~ 	$coord = PixelSearch(150, 300, 400, 500, 0x00FC19, 25, 1, $title)
;~ 	If Not @error Then
;~ 		MouseMove($coord[0],$coord[1])
;~ 	EndIf

;0x016616  0x008400  0x007C00

;~ $var = PixelGetColor(125, 595) ;, "2C1008")

;~ If Hex($var, 6) == '2C1008' Then
;~ 	MsgBox(4096, "错误", Hex($var, 6))
;~ Else
;~ EndIf
;~ Exit
;~ ;2C1008 -内

;~ ;28241C  外
;~ 	$xrd = Random(-2, 2, 1)
;~ 	$yrd = Random(-2, 2, 1)
;~ MouseClick("right", 630 + $xrd, 150 + $yrd, Random(1, 3)) ;50

;~ $findflag = 0
;~ $begin1 = TimerInit()
;~ Do
;~ 	$coord = PixelSearch(100, 300, 400, 500, 0x118FB01, 10, 1, $title)
;~ 	If @error Then
;~ 		MouseMove(300 + $xrd, 530 + $yrd)
;~ 		MouseDown("left")
;~ 		Sleep(50)
;~ 		$findflag = 0
;~ 	Else
;~ 		MouseMove($coord[0] - 50 , $coord[1] )
;~ 		$findflag = 1
;~ 	EndIf
;~ 	$dif = TimerDiff($begin1)
;~ Until $findflag = 1 Or $dif >= 6000
;~ MouseUp("left")


Exit


;MouseClick('left', 410, 310)




;~  $Apix = PixelGetColor(127, 595)
;~ ConsoleWrite(Hex($Apix, 6) & @CR)
;~ $Apix = PixelGetColor(162, 575)
;~ ConsoleWrite(Hex($Apix, 6) & @CR)
;2C1008
;5C1C14

;282828
; 50483C   ;yewai
;Exit

;~ $a = PixelChecksum(10, 300, 60, 400, $title)
;~ ConsoleWrite($a& @CR)   ;;3002911715

;0xCE8523  ;橙色



Func findManaInBag() ;查找是否选择单机或站网界面  420, 320, 705, 430
	
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\czheal.bmp", 0.8)

	#CS 	If $postion[0] >=0 And  $postion[1] >=0 Then
		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
		
		Return True
		Else
		Return False
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;==>findManaInBag

Func findreddoor() ;act3point
	Local $ar[10]
	$ar[0] = "a5aakk1.bmp"
	$ar[1] = "a5aakk2.bmp"
	$ar[2] = "a5aakk3.bmp"
	$ar[3] = "a5aakk4.bmp"
	$ar[4] = "a5aakk5.bmp"
	$ar[5] = "a5aakk6.bmp"
	$ar[6] = "a5aakk7.bmp"
	$ar[7] = "a5aakk8.bmp"
	$ar[8] = "a5aakk9.bmp"
	$ar[9] = "a5aakk10.bmp"
	
	For $i = 0 To 9 Step 1
		$postion = _FindPic($winleft + 10, $winTop + 5, $winright - 300, $winBottom - 80, "images\" & $ar[$i], 0.6)
		If $postion[0] <> -1 Then
			TrayTip("", $ar[$i], 1, 16)
			;Sleep(2000)
			$postion[0] = $postion[0] - $winleft
			$postion[1] = $postion[1] - $winTop
			Return $postion
		EndIf
	Next
EndFunc   ;==>findreddoor

Func test()
	Local $Result
	$Result = FindAllColor(5, 5, 798, 580, "549549")
	If $Result[0][0] <> 0 Then
		For $i = 1 To $Result[0][0] Step +1
			MouseMove($Result[$i][0], $Result[$i][1], 0)
			Sleep(10)
		Next
	Else
		ConsoleWrite("在指定区域未找到目标颜色. " & @CR)
	EndIf
EndFunc   ;==>test

Func FindAllColor($iLeft, $iTop, $iRight, $iBottom, $iColor)
	Local $Rnum[1][1], $s = 0
	For $Top = $iTop To $iBottom Step +20
		For $Left = $iLeft To $iRight Step +20
			$Color = Hex(PixelGetColor($Left, $Top), 6)
			ConsoleWrite($Color & @CR)
			If $Color = $iColor Then
				$s += 1
				ReDim $Rnum[$s + 1][2]
				$Rnum[$s][0] = $Left
				$Rnum[$s][1] = $Top
			EndIf
		Next
	Next
	$Rnum[0][0] = $s
	Return $Rnum
EndFunc   ;==>FindAllColor

;Exit
;~ 						MouseClick("left", 145 + Random(1, 10), 520 + Random(1, 10), 1)
;~ 						Sleep(2000)

;~ 						$coord = PixelSearch(400, 300, 790, 580, 0x118FB01, 10, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", $coord[0] &"  "& $coord[1], 1, 16)
;~ 							MouseMove($coord[0] - Random(180,200), $coord[1]+Random(1,10)  )
;~ 							MouseClick("left",Default,Default,1)
;~ 							Sleep(1500)
;~ 						EndIf

;~ 						$coord = PixelSearch(50, 300, 300, 580, 0x118FB01, 10, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", $coord[0] &"  "& $coord[1], 1, 16)
;~ 							MouseMove($coord[0] +Random(180,200), $coord[1]+Random(80,100)  )
;~ 							MouseClick("left",Default,Default,1)
;~ 							Sleep(2000)
;~ 						EndIf

;~ 												$coord = PixelSearch(50, 200, 300, 500, 0x118FB01, 10, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", $coord[0] &"  "& $coord[1], 1, 16)
;~ 							MouseMove($coord[0] +Random(1,20), $coord[1]+Random(260,290)  )
;~ 							MouseClick("left",Default,Default,1)
;~ 							Sleep(2000)
;~ 						EndIf

;~ 						$coord = PixelSearch(50, 300, 250, 580, 0x118FB01, 10, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", $coord[0] &"  "& $coord[1], 1, 16)
;~ 							MouseMove($coord[0] +Random(150,200), $coord[1]+Random(1,20)  )
;~ 							MouseClick("left",Default,Default,1)
;~ 							Sleep(2000)
;~ 						EndIf
;~ 						$coord = PixelSearch(50, 250, 380, 500, 0x118FB01, 10, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", $coord[0] &"  "& $coord[1], 1, 16)
;~ 							MouseMove($coord[0] -Random(50,100)  , $coord[1]+Random(1,20)  )
;~ 							MouseClick("left",Default,Default,1)
;~ 							Sleep(2000)
;~ 						EndIf
;~

;fireMonsterByColor(20, 20, 790, 560, 0)

Func findtudui1() ;act3point

	$postion = _FindPic($winleft + 50, $winTop + 50, $winright, $winBottom - 300, "images\tudui1.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findtudui1

Func findlouti1() ;act3point

	$postion = _FindPic($winleft, $winTop + 300, $winright - 400, $winBottom - 50, "images\109a5down1.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findlouti1

Func findlcaicao() ;act3point

	$postion = _FindPic($winleft + 300, $winTop + 50, $winright, $winBottom - 300, "images\109a5down3.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findlcaicao

Func findzhuzi() ;act3point

	$postion = _FindPic($winleft + 300, $winTop + 300, $winright, $winBottom, "images\109a5down2.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findzhuzi


Func _FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar)
	Dim $pos[2]
	$obj = ObjCreate("QMDispatch.QMFunction")
	If Not @error Then
		$foundpixel = $obj.FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar)

		$pos[0] = Int($foundpixel / 8192)
		$pos[1] = Mod($foundpixel, 8192)
		;MsgBox(0,"", $pos[0]& "" & $pos[1])
		; MsgBox(0,"", $winleft & "" & $winright)
		;MsgBox(0,"",$pos[0]-$winleft & "" & $pos[1]-$winTop)
		;If $pos[0] >0 And $pos[1] > 0 Then
		;MouseMove($pos[0]-$winleft,$pos[1]-$winTop)
		
		;EndIf
		Return $pos
	Else ;如果创建对象失败，则报错。
		MsgBox(0, "错误提示", "初始化系统组件失败，错误代码: " & Hex(@error, 8))
		Exit 0
	EndIf
EndFunc   ;==>_FindPic


Func initialSize()
	$size = WinGetPos($titleImageSearch)
	;MsgBox(0, "活动窗口状态 (X坐标,Y坐标,宽度,高度):", $size[0] & ",    " & $size[1] & ",   " & $size[2] & ",   " & $size[3])

	$winleft = $size[0] + ($size[2] - 800) / 2
	$winTop = $size[1] + ($size[3] - 600)
	$winright = $size[0] + $size[2] - ($size[2] - 800) / 2
	$winBottom = $size[1] + $size[3]
EndFunc   ;==>initialSize



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
		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), 1)
		Sleep(50)
	EndIf
	$beginAttackTime = TimerInit()
	
	;---------------最开始先打一次
	TrayTip("", "开始准备打击", 1, 16)

	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 30, 10)
		If Not @error Then
			$FailsCount = 0
			TrayTip("", "发现目标，准备锁定需攻击的怪物" & $monsterColor[$i], 1, 16)

			If nowfire($XYBlock[0], $XYBlock[1]) = 0 Then
				TrayTip("", "攻击失败", 1, 16)
				ExitLoop
			EndIf
			
		Else
			$FailsCount = $FailsCount + 1
		EndIf
		
		$i = $i + 1
		If ($i > 5) Then
			$i = 0 ;循环颜色，防止超过数组上限溢出
		EndIf
		$dif = TimerDiff($beginAttackTime)
	Until $dif >= 50000 ;搜索失败次数大于5次 或者 总时间超过了50秒
	Return 0
EndFunc   ;==>fireMonsterByColor


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
	For $i = 1 To 5 Step 1
		MouseClick("right", $X, $Y + 10, 2)
		Sleep(80)
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


Func countFirepointRec($Left, $Top, $right, $bottom, $mColor, $mColor_hex)
	$postion = PixelSearch($Left, $Top, $right, $bottom, $mColor, 30, 10)
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
;~ 			TrayTip("", Hex($tp_PixS[$p], 6)  & "  " & $mColor_hex, 1, 16)
;~ 			Sleep(200)
			If Hex($tp_PixS[$p], 6) == $mColor_hex Then
				$SimpleCounter = $SimpleCounter + 1
				TrayTip("", $p & "  " & $SimpleCounter, 1, 16)
				Sleep(200)
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



