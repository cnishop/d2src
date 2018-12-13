;##############################################################################
;###### mm.BOT global INCLUDES, proceed #Include "mm.BOT.Include.au3"   #######
;###### in your scripts to fully load the basic functions, especially   #######
;###### the calibrate point one and default colors. You must install    #######
;###### Autoit V3 (www.autoitscript.com) to be able to execute scripts. #######
;##############################################################################


; Version 2.0; include these function:
;-------------------------------------

; Note1: Other functions available in /tools.
; Note2: Some of these functions can require specific Globals.
; Note3: In case fast script required load only the necessary fonctions...


;Func CheckIfInGame()
;Func FromBlockClickTo ($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $XBlock, $YBlock, $NBClicks, $BRCMODE)
;Func FromBlockSureClick ($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $XBlock, $YBlock)
;Func ValidateWP()
;Func CheckMove ($Delay)
;Func FastClickAbs($Button, $X, $Y, $R, $N)
;Func SlowClick($Button, $X, $Y, $R, $N)
;Func FastClick($Button, $X, $Y, $R, $N)
;Func LogEvent($EventType, $String)
;Func Unstuck($EscNb)
;Func GetManaPercent()
;Func GetLifePercent()
;Func GetMercLifeStatus()
;Func ($PathName)
;Func DetectInGUI($Width, $Height, $Color1, $Color2, $Color3, $StartX1, $StartY1, $DiffX2, $DiffY2, $DiffX3, $DiffY3)
;Func Search_11_InArea($Area, $Code1, $Code2)
;Func BoxesAreaShot($Area)
;Func SetupActContext($Act)
;Func CheckServerIP()
;Func WaitNotFreeCursor()
;Func WaitFreeCursor()
;Func FreeCursor()
;Func NotFreeCursor()
;Func AreaColorCountCheck($XStart, $YStart, $XStop, $YStop, $Step, $Color, $MiniMatch, $Delay, $Tries)





;======================================
; Constants definition, can be
; defined in the script too...
;======================================
$XDiff = 0
$YDiff = 0
$FastClickMini = 20
$FastClickMaxi = 30
$SlowClickMini = 80
$SlowClickMaxi = 100
$Char_CheckMoveDelay = 120
$D2_SlowIntMDelay = 2
$D2_FastIntMDelay = 1
$D2_IdingMouseSpeed = 1
$D2_MouseClickDelay = 5
$D2_SendKeyDelay = 5

;=================================================================
; Attention some font colors will varies, here default to A5.
; Read the Func SetupActContext($Act) to understand.
; Example: 5933724 in act 2 is the uniques items color font...
;=================================================================
$CurrentAct = 5
; Colors definition
$XUNIQUES_Color = 6521492
$SETS_Color = 1623816
$XRARES_Color = 6535902
$MAGICS_Color = 11358546
$GRAYS_Color = 5394770
$WHITES_Color = 13027270
$NPC_BODY_Color = 16720037
$NPC_MENU_Color = 1623816
$GREEN_BLOCKS_Color = 65304
$MERC_GREEN_BAR_Color = 34304
$MERC_ORANGE_BAR_Color = 2197206
$UNID_RED_Color = 3229109
$CRAFTED_Color = 2197206
$TP_color = 3777263

;======================================
; Options
;======================================
;AutoItSetOption("ColorMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("WinWaitDelay", 250)
AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("MouseCoordMode", 0)
;======================================
#include <Date.au3>





; Functions....







;=================================================
; GET Calibrated point + Confirm we are in game...
;=================================================
;(Consider starting this script from InGame)
Func CheckIfInGame()
	$CPoint = PixelSearch(15, 565, 35, 585, 9750503)
	If @error == 1 Then
		Return 0
	EndIf
	$Xbase = 23
	$Ybase = 574
	$XDiff = $CPoint[0] - $Xbase
	$YDiff = $CPoint[1] - $Ybase
	Return 1
EndFunc   ;==>CheckIfInGame

;======================================================================
; Relative to block click (green block, right up side) take first block
; $XBS_Start X left up scanned area corner
; $YBS_Start Y left up scanned area corner
; $XBS_Stop X right down scanned area corner
; $YBS_Stop Y right down scanned area corner
; $XBlock X relative to block where to click
; $YBlock Y relative to block where to click
; $NBClicks Number of clicks... (can be Zero)
; $BRCMODE Relate to numerous added options:
; 0 = nothing special: avoid these specific options...
; - 1 = avoid to be in focus with $UNID_RED_Color named objects (Avoid TPs in TOWN)
;======================================================================
Func FromBlockClickTo($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $XBlock, $YBlock, $NBClicks, $BRCMODE)
	$XBS_Start = $XBS_Start + $XDiff
	$YBS_Start = $YBS_Start + $YDiff
	$XBS_Stop = $XBS_Stop + $XDiff
	$YBS_Stop = $YBS_Stop + $YDiff
	$FailsCount = 0
	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $GREEN_BLOCKS_Color, 0, 15)
		If Not @error Then
			$XBS = $XYBlock[0]
			$YBS = $XYBlock[1]
			Do
				$XBS = $XBS + 4
				$ApixBS = PixelGetColor($XBS, $YBS)
			Until $ApixBS <> 1637376;65304
			Do
				$YBS = $YBS - 4
				$ApixBS = PixelGetColor($XBS, $YBS)
			Until $ApixBS <> 1637376;65304
			$XBC = $XBS + $XBlock
			$YBC = $YBS + $YBlock
			If $NBClicks > 1 Then
				$NBClicks = $NBClicks + Round(Random(0, 1))
			EndIf
			If $BRCMODE == -1 Then
				While 1
					$tp_Pix = PixelSearch($XBC - 200, $YBC - 200, $XBC + 100, $YBC + 100, $UNID_RED_Color, 0, 10)
					If Not @error Then
						Dim $tp_PixS[9]
						$tp_PixS[1] = PixelGetColor($tp_Pix[0] + 1, $tp_Pix[1])
						$tp_PixS[2] = PixelGetColor($tp_Pix[0] + 3, $tp_Pix[1])
						$tp_PixS[3] = PixelGetColor($tp_Pix[0] - 1, $tp_Pix[1])
						$tp_PixS[4] = PixelGetColor($tp_Pix[0] - 3, $tp_Pix[1])
						$tp_PixS[5] = PixelGetColor($tp_Pix[0], $tp_Pix[1] + 1)
						$tp_PixS[6] = PixelGetColor($tp_Pix[0], $tp_Pix[1] + 3)
						$tp_PixS[7] = PixelGetColor($tp_Pix[0], $tp_Pix[1] - 1)
						$tp_PixS[8] = PixelGetColor($tp_Pix[0], $tp_Pix[1] - 3)
						$SimpleCounter = 0
						For $p = 1 To 8
							If $tp_PixS[$p] == $UNID_RED_Color Then
								$SimpleCounter = $SimpleCounter + 1
							EndIf
						Next
						If $SimpleCounter >= 4 Then
							$XBC = $XBC + 15
							$YBC = $YBC + 15
							ContinueLoop
						Else
							ExitLoop
						EndIf
					Else
						ExitLoop
					EndIf
				WEnd
			EndIf
			
			If $XBC > 795 Then
				$XBC = 795
			EndIf
			If $YBC > 550 Then
				$YBC = 550
			EndIf
			If $XBC < 5 Then
				$XBC = 5
			EndIf
			If $YBC < 35 Then
				$YBC = 35
			EndIf
			FastClickAbs("Left", $XBC, $YBC, 1, $NBClicks)
			;CheckMove($Char_CheckMoveDelay)
			Sleep(1500)
			Return 1
		EndIf
		$FailsCount = $FailsCount + 1
		Sleep(Random(200, 300))
	Until $FailsCount > 2
	LogEvent(3, "FromBlockClickTo Error ID: " & $XBS_Start & ", " & $YBS_Start & ", " & $XBS_Stop & ", " & $YBS_Stop & ", " & $XBlock & ", " & $YBlock & ", " & $NBClicks & ", " & $BRCMODE)
	Return 0
EndFunc   ;==>FromBlockClickTo


;========================================================
; Make a paused click. Nice for Tps.
;========================================================
Func FromBlockSureClick($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $XBlock, $YBlock)
	;CheckMove($Char_CheckMoveDelay)
	Sleep(3000)
	Sleep(Random(150, 200))
	If FromBlockClickTo($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $XBlock, $YBlock, 0, 0) == 0 Then
		Return 0
	EndIf
	Sleep(Random(200, 250))
	MouseDown("Left")
	Sleep(Random(80, 100))
	MouseUp("Left")
	CheckMove($Char_CheckMoveDelay)
	Return 1
EndFunc   ;==>FromBlockSureClick

;==================
; Validate WP menu
;==================
Func ValidateWP()
	For $testWP = 1 To 8

		Sleep(Random(200, 300))
		$ApixVWP1 = PixelGetColor(17 + $XDiff, 391 + $YDiff)
		$ApixVWP2 = PixelGetColor(18 + $XDiff, 337 + $YDiff)
		$ApixVWP3 = PixelGetColor(15 + $XDiff, 253 + $YDiff)
		$ApixVWP4 = PixelGetColor(16 + $XDiff, 142 + $YDiff)
		If (($ApixVWP1 == 10855077) And ($ApixVWP2 == 3234147) And ($ApixVWP3 == 5399931) And ($ApixVWP4 == 8685188)) Then
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>ValidateWP

;=======================================================================
; Wait stop move function, function loop until character is stop moving
;=======================================================================
Func CheckMove($Delay)
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
	Until (TimerStop($Begin) > 3000)
EndFunc   ;==>CheckMove


;================================
; Randomized fast click Absolute
;================================
Func FastClickAbs($Button, $X, $Y, $R, $N)
	MouseMove($X + Random(-$R, $R), $Y + Random(-$R, $R), $D2_FastIntMDelay)
	Sleep(Random($FastClickMini, $FastClickMaxi))
	For $Repeat = 1 To $N
		MouseDown($Button)
		Sleep(Random($FastClickMini, $FastClickMaxi))
		MouseUp($Button)
		Sleep(Random($FastClickMini, $FastClickMaxi))
	Next
EndFunc   ;==>FastClickAbs

;=======================
; Randomized slow click
;=======================
Func SlowClick($Button, $X, $Y, $R, $N)
	MouseMove($X + Random(-$R, $R) + $XDiff, $Y + Random(-$R, $R) + $YDiff, $D2_SlowIntMDelay)
	Sleep(Random($SlowClickMini, $SlowClickMaxi))
	For $Repeat = 1 To $N
		MouseDown($Button)
		Sleep(Random($SlowClickMini, $SlowClickMaxi))
		MouseUp($Button)
		Sleep(Random($SlowClickMini, $SlowClickMaxi))
	Next
EndFunc   ;==>SlowClick

;=======================
; Randomized fast click
;=======================
Func FastClick($Button, $X, $Y, $R, $N)
	MouseMove($X + Random(-$R, $R) + $XDiff, $Y + Random(-$R, $R) + $YDiff, $D2_FastIntMDelay)
	Sleep(Random($FastClickMini, $FastClickMaxi))
	For $Repeat = 1 To $N
		MouseDown($Button)
		Sleep(Random($FastClickMini, $FastClickMaxi))
		MouseUp($Button)
		Sleep(Random($FastClickMini, $FastClickMaxi))
	Next
EndFunc   ;==>FastClick

;=================================
; Provide script events log
; Event type:
; 1 = Information
; 2 = Warning
; 3 = Error
;=================================
Func LogEvent($EventType, $String)
	Select
		Case $EventType == 1
			$EventName = " [I]> "
		Case $EventType == 2
			$EventName = " [W]> "
		Case $EventType == 3
			$EventName = " [E]> "
	EndSelect
	$LogFile = FileOpen(@ScriptDir & "\Events_Script.txt", 1)
	If $LogFile = -1 Then
		Return
	EndIf
	FileWriteLine($LogFile, @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & $EventName & $String)
	FileClose($LogFile)
EndFunc   ;==>LogEvent

;========================================================================
; In game Unstuck function: quit trade/stash/inv/npcmenu/WP/esc/
; $EscNb = 0 for simple unstuck (2 keypress)
; $EscNb = -1 for a minimized unstuck (1 keypress)
;========================================================================
Func Unstuck($EscNb)
	PixelSearch(15, 565, 35, 585, 9750503)
	If @error == 1 Then
		Return 0
	EndIf
	Send("{" & $Char_Key_ClearScreen & "}")
	Sleep(Random(100, 150))
	If $EscNb == -1 Then
		Return 1
	EndIf
	Send("{" & $Char_Key_ClearScreen & "}")
	Sleep(Random(200, 250))
	Return 1
EndFunc   ;==>Unstuck

;=====================================================================================================
; Return mana "percent" available 100>="90">=90 to 20>="10">=10 and 10>="0">=0 for less than 10% mana
;=====================================================================================================
Func GetManaPercent()
	$ManaPercent = 90
	$Ymana = 536 + $YDiff
	While ($ManaPercent >= 20)
		$Pix = PixelGetColor(744 + $XDiff, $Ymana)
		If $Pix == 5898240 Then
			Return $ManaPercent
		Else
			$ManaPercent = $ManaPercent - 10
			$Ymana = $Ymana + 8
		EndIf
	WEnd
	$Pix = PixelGetColor(735 + $XDiff, 601 + $YDiff)
	If $Pix == 2690056 Then
		$ManaPercent = 10
		Return $ManaPercent
	Else
		$ManaPercent = 0
		Return $ManaPercent
	EndIf
EndFunc   ;==>GetManaPercent

;=======================================================================================================
; Return Life "percent" available:  100>="90">=90 to 60>="50">=50 and 50>="0"=>0 for less than 50% life
;=======================================================================================================
Func GetLifePercent()
	$LifePercent = 90
	$Ylife = 537 + $YDiff
	Do
		$Pix = PixelGetColor(84, $Ylife)
		If (($Pix == 90) Or ($Pix == 543000)) Then
			Return $LifePercent
		Else
			$LifePercent = $LifePercent - 10
			$Ylife = $Ylife + 8
		EndIf
	Until ($LifePercent == 40)
	$LifePercent = 0
	Return $LifePercent
EndFunc   ;==>GetLifePercent

;=====================================================================================================
; Return merc/hireling status:
; 1 for green bar
; 0 for alive but 1/3 life (drink need)
; -1 == dead.
;=====================================================================================================
Func GetMercLifeStatus()
	$Pix = PixelGetColor(36 + $XDiff, 36 + $YDiff)
	If $Pix == $MERC_GREEN_BAR_Color Or $Pix == $MERC_ORANGE_BAR_Color Then
		$MercResurrectFailsLoop = 0
		Return 1
	Else
		$Pix1 = PixelGetColor(40 + $XDiff, 36 + $YDiff)
		$Pix2 = PixelGetColor(45 + $XDiff, 36 + $YDiff)
		$Pix3 = PixelGetColor(50 + $XDiff, 36 + $YDiff)
		$Pix4 = PixelGetColor(55 + $XDiff, 36 + $YDiff)
		If ($Pix1 + $Pix2 + $Pix3 + $Pix4) == 0 Then
			Return 0
		Else
			Return -1
		EndIf
	EndIf
EndFunc   ;==>GetMercLifeStatus


;==============================================
; This is the path library
; Using the relative to block trick
; Common point is A5 DownStairs
;==============================================
Func Path($PathName)

	Select

		Case $PathName == "A3StartToOrmus"
			SetupActContext(3)
			If FromBlockClickTo(200, 200, 400, 400, 350, 100, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(450, 50, 700, 300, 215, 20, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(10, 150, 350, 480, 600, -170, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(350, 150, 750, 400, 125, -130, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "A3TownTpToA5WP"
			SetupActContext(3)
			If FromBlockSureClick(400, 80, 700, 300, 130, -30) == 0 Then
				Return 0
			EndIf
			If ValidateWP() Then

				FastClick("left", 360, 90, 5, 2)
				Sleep(Random(200, 300))
				FastClick("left", 115, 155, 5, 1)
				Sleep(Random(1500, 2000))
				If AreaColorCountCheck(600, 125, 795, 340, 15, $GREEN_BLOCKS_Color, 2, 500, 15) == 1 Then
					SetupActContext(5)
					Return 1
				Else
					Return 0
				EndIf
			Else
				Return 0
			EndIf
			
		Case $PathName == "OrmusToA5WP"
			SetupActContext(3)
			If FromBlockClickTo(120, 400, 550, 570, 375, -15, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(450, 270, 720, 510, 300, -130, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockSureClick(420, 80, 780, 340, 100, -10) == 0 Then
				Return 0
			EndIf
			TrayTip(0, "find wp", 1, 16)
			Sleep(2000)
			If ValidateWP() Then

				FastClick("left", 360, 90, 5, 2)
				Sleep(Random(200, 300))
				FastClick("left", 115, 155, 5, 1)
				Sleep(Random(1500, 2000))
				If AreaColorCountCheck(600, 125, 795, 340, 15, $GREEN_BLOCKS_Color, 2, 500, 15) == 1 Then
					SetupActContext(5)
					Return 1
				Else
					Return 0
				EndIf
			Else
				Return 0
			EndIf
			
		Case $PathName == "A3StartToA5WP"
			SetupActContext(3)
			
			If FromBlockClickTo(200, 200, 400, 400, 350, 100, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(450, 50, 700, 300, 215, 20, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(10, 150, 350, 480, 600, -170, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(350, 150, 750, 400, 60, -85, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(500, 150, 750, 400, 115, 115, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(330, 330, 570, 550, 300, -130, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockSureClick(420, 80, 780, 340, 100, -10) == 0 Then
				Return 0
			EndIf
			TrayTip(0, "1111", 1, 16)
			Sleep(2000)

			If ValidateWP()  Then
				FastClick("left", 360, 90, 5, 2)
				Sleep(Random(200, 300))
				FastClick("left", 115, 155, 5, 1)
				Sleep(Random(1500, 2000))
				If AreaColorCountCheck(600, 125, 795, 340, 15, $GREEN_BLOCKS_Color, 2, 500, 15) == 1 Then
					SetupActContext(5)
					Return 1
				Else
					Return 0
				EndIf
			Else
				Return 0
			EndIf

			
			; ================== A 5 =========================
			
			
		Case $PathName == "A5TpToStart"
			SetupActContext(5)
			If FromBlockClickTo(50, 5, 795, 550, 70, 230, 2, -1) == 0 Then
				Return 0
			EndIf

		Case $PathName == "StartToMalah"
			SetupActContext(5)
			If FromBlockClickTo(50, 5, 750, 550, -230, 140, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "StartToDownStairs"
			SetupActContext(5)
			If FromBlockClickTo(50, 5, 750, 550, -140, 380, 3, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(300, 300, 795, 570, -230, -100, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(400, 25, 795, 545, -230, 20, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "MalahToDownStairs"
			SetupActContext(5)
			If FromBlockClickTo(50, 5, 795, 550, -250, 130, 2, 0) == 0 Then
				LogEvent(2, "Failed to found Block after malah interact, make a blind click try")
				FastClick("Left", 595, 345, 5, 2)
				CheckMove($Char_CheckMoveDelay * 2)
			EndIf
			If AreaColorCountCheck(220, 80, 480, 190, 10, $GREEN_BLOCKS_Color, 1, 1, 0) == 1 Then
				UnStuck(-1)
			EndIf
			If FromBlockClickTo(50, 5, 795, 550, 41, 212, 2, -1) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(50, 5, 750, 550, -140, 380, 3, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(300, 300, 795, 570, -230, -100, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(400, 25, 795, 545, -230, 20, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToWP"
			SetupActContext(5)
			If FromBlockClickTo(450, 100, 790, 420, -360, 100, 1, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToStash"
			SetupActContext(5)
			If FromBlockClickTo(450, 100, 790, 420, 0, 60, 1, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "StashToDownStairs"
			SetupActContext(5)
			If FromBlockClickTo(290, 120, 540, 390, -229, 29, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToLarzuk"
			SetupActContext(5)
			If FromBlockClickTo(300, 100, 790, 380, 100, 160, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(50, 5, 750, 280, 362, 236, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "LarzukToDownStairs"
			SetupActContext(5)
			FastClick("Left", 30, 350, 20, 2)
			CheckMove($Char_CheckMoveDelay)
			If FromBlockClickTo(50, 5, 750, 280, 50, 180, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(240, 100, 480, 280, -250, 10, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToQual"
			SetupActContext(5)
			If FromBlockClickTo(30, 200, 300, 550, 30, 110, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(200, 100, 450, 350, -330, 0, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(300, 40, 480, 250, -300, -80, 2, 0) == 0 Then
				Return 0
			EndIf

		Case $PathName == "QualToDownStairs"
			SetupActContext(5)
			FastClick("Left", 718, 388, 20, 2)
			CheckMove($Char_CheckMoveDelay)
			If FromBlockClickTo(100, 100, 550, 270, -50, 230, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(300, 30, 530, 200, 220, 410, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(430, 200, 690, 380, 50, 140, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(180, 70, 380, 280, 270, -110, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToAnya"
			SetupActContext(5)
			If FromBlockClickTo(450, 100, 790, 420, -475, 260, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(200, 50, 470, 425, -100, 360, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(100, 250, 400, 500, -180, -30, 2, 0) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "DownStairsToPindle" Or $PathName == "WPToPindle"
			SetupActContext(5)
			If FromBlockClickTo(450, 100, 790, 420, -475, 260, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockClickTo(200, 50, 470, 425, -100, 360, 2, 0) == 0 Then
				Unstuck(0)
				Sleep(Random(800, 1000))
				LogEvent(2, "DownStairsToPindle. This can be lag or Cain. Retry.")
				If FromBlockClickTo(450, 100, 790, 420, -475, 260, 2, 0) == 0 Then
					Return 0
				EndIf
				If FromBlockClickTo(200, 50, 470, 425, -100, 360, 2, 0) == 0 Then
					Return 0
				EndIf
			EndIf
			If FromBlockClickTo(500, 200, 780, 480, -425, 75, 2, 0) == 0 Then
				Return 0
			EndIf
			If FromBlockSureClick(280, 230, 490, 430, -305, -85) == 0 Then
				Return 0
			EndIf
			
		Case $PathName == "PindleTpRecovery"
			SetupActContext(5)
			If FromBlockSureClick(5, 35, 300, 300, 175, 185) == 0 Then
				Return 0
			EndIf

		Case Else
			LogEvent(2, $PathName & " path doesnt exists...")
			Return 0
	EndSelect
	Return 1
EndFunc   ;==>Path





;=================================================================================================
; Will search for a 1*1 item in inventory, trade, or gamble and return XY string with "|" separator.
; -1 if not found. inv=10*4, stash=6*8, trade=10*10 .Only used for scrolls yet.
; Fast. Deprecated. Used for inventory Id scrolls.
;=================================================================================================
Func DetectInGUI($Width, $Height, $Color1, $Color2, $Color3, $StartX1, $StartY1, $DiffX2, $DiffY2, $DiffX3, $DiffY3)
	Dim $Xinv[$Width]
	Dim $Yinv[$Height]
	$Xinv[0] = ($StartX1 + $XDiff)
	$Yinv[0] = ($StartY1 + $YDiff)
	For $i = 1 To ($Width - 1)
		$Xinv[$i] = ($Xinv[($i - 1)] + 29)
	Next
	For $j = 1 To ($Height - 1)
		$Yinv[$j] = ($Yinv[($j - 1)] + 29)
	Next
	For $i = 0 To ($Width - 1)
		For $j = 0 To ($Height - 1)
			$TestColor = PixelGetColor($Xinv[$i], $Yinv[$j])
			If $TestColor == $Color1 Then
				$TestColor = PixelGetColor(($Xinv[$i] + $DiffX2), ($Yinv[$j] + $DiffY2))
				If $TestColor == $Color2 Then
					$TestColor = PixelGetColor(($Xinv[$i] + $DiffX3), ($Yinv[$j] + $DiffY3))
					If $TestColor == $Color3 Then
						$XY = ($Xinv[$i] & "|" & $Yinv[$j])
						Return $XY
					EndIf
				EndIf
			EndIf
		Next
	Next
	Return 0
EndFunc   ;==>DetectInGUI



;============================================================
; Will search for a 1*1 item in ...
; Generic shot with parameters: 6 pixels sum formula / box.
; "Inventory" = inventory, "Stash" = stash,
; "Npc" = npc, "Cube" = cube, "Beltx" = where x= 1,2,3 or 4
; ( depends of belt rows...)
; Return "$X|$Y" if the 6th pixel coordinates (more middle)
; Absolute to d2 screen string if found.
; Return "NotFound|NotFound" if not found.
; 5000 ms timeout
;============================================================
Func Search_11_InArea($Area, $Code1, $Code2)
	$BoxesXOffset = 29
	$BoxesYOffset = 29
	$InBoxXOffset_1 = 0
	$InBoxYOffset_1 = 0
	$InBoxXOffset_2 = 20
	$InBoxYOffset_2 = 0
	$InBoxXOffset_3 = 20
	$InBoxYOffset_3 = 20
	$InBoxXOffset_4 = 0
	$InBoxYOffset_4 = 20
	$InBoxXOffset_5 = 5
	$InBoxYOffset_5 = 10
	$InBoxXOffset_6 = 10
	$InBoxYOffset_6 = 15
	Select
		Case $Area == "Inventory"
			$NRows = 10
			$NCols = 4
			$X0 = 426
			$Y0 = 341
		Case $Area == "Stash"
			$NRows = 6
			$NCols = 8
			$X0 = 160
			$Y0 = 168
		Case $Area == "Cube"
			$NRows = 3
			$NCols = 4
			$X0 = 204
			$Y0 = 224
		Case $Area == "Npc"
			$NRows = 10
			$NCols = 10
			$X0 = 101
			$Y0 = 149
	EndSelect
	If StringInStr($Area, "Belt") Then
		$BoxesXOffset = 31
		$BoxesYOffset = 32
		$InBoxXOffset_1 = 0
		$InBoxYOffset_1 = 1
		$InBoxXOffset_2 = 0
		$InBoxYOffset_2 = 1
		$InBoxXOffset_3 = 0
		$InBoxYOffset_3 = 1
		$InBoxXOffset_4 = 0
		$InBoxYOffset_4 = 1
		$InBoxXOffset_5 = 0
		$InBoxYOffset_5 = 1
		$InBoxXOffset_6 = 0
		$InBoxYOffset_6 = 1
		$NRows = 4
		$X0 = 442
		Select
			Case $Area == "Belt4"
				$NCols = 4
				$Y0 = 513
			Case $Area == "Belt3"
				$NCols = 3
				$Y0 = 545
			Case $Area == "Belt2"
				$NCols = 2
				$Y0 = 577
			Case $Area == "Belt1"
				$NCols = 1
				$Y0 = 609
		EndSelect
	EndIf
	Dim $X[$NRows]
	Dim $Y[$NCols]
	$X[0] = $X0 + $XDiff
	$Y[0] = $Y0 + $YDiff
	For $i = 1 To ($NRows - 1)
		$X[$i] = ($X[($i - 1)] + $BoxesXOffset)
	Next
	For $j = 1 To ($NCols - 1)
		$Y[$j] = ($Y[($j - 1)] + $BoxesYOffset)
	Next
	Dim $AreaShot[$NRows][$NCols]
	For $i = 0 To ($NRows - 1)
		For $j = 0 To ($NCols - 1)
			$Apix_1 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_1, $Y[$j] + $InBoxYOffset_1)))
			$Apix_2 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_2, $Y[$j] + $InBoxYOffset_2)))
			$Apix_3 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_3, $Y[$j] + $InBoxYOffset_3)))
			$Apix_4 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_4, $Y[$j] + $InBoxYOffset_4)))
			$Apix_5 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_5, $Y[$j] + $InBoxYOffset_5)))
			$Apix_6 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_6, $Y[$j] + $InBoxYOffset_6)))
			$FinalValue = ($Apix_1 + $Apix_2 + $Apix_3 + $Apix_4 + $Apix_5 + $Apix_6)
			If $Code1 == $FinalValue Or $Code2 == $FinalValue Then
				Return (($X[$i] + $InBoxXOffset_6) & "|" & ($Y[$j] + $InBoxYOffset_6))
			EndIf
		Next
	Next
	Return 0
EndFunc   ;==>Search_11_InArea


;============================================================
; Generic shot with parameters: 6 pixels sum formula / box.
; "Inventory" = inventory, "Stash" = stash,
; "Npc" = npc, "Cube" = cube, "Beltx" = where x= 1,2,3 or 4
; ( depends of belt rows...) Return the array  $AreaShot
; note: rejuv OR full potions rejuv alway return 42123954
;============================================================
Func BoxesAreaShot($Area)
	$BoxesXOffset = 29
	$BoxesYOffset = 29
	$InBoxXOffset_1 = 0
	$InBoxYOffset_1 = 0
	$InBoxXOffset_2 = 20
	$InBoxYOffset_2 = 0
	$InBoxXOffset_3 = 20
	$InBoxYOffset_3 = 20
	$InBoxXOffset_4 = 00
	$InBoxYOffset_4 = 20
	$InBoxXOffset_5 = 5
	$InBoxYOffset_5 = 10
	$InBoxXOffset_6 = 10
	$InBoxYOffset_6 = 15
	Select
		Case $Area == "Inventory"
			$NRows = 10
			$NCols = 4
			$X0 = 426
			$Y0 = 341
		Case $Area == "Stash"
			$NRows = 6
			$NCols = 8
			$X0 = 160
			$Y0 = 168
		Case $Area == "Cube"
			$NRows = 3
			$NCols = 4
			$X0 = 204
			$Y0 = 224
		Case $Area == "Npc"
			$NRows = 10
			$NCols = 10
			$X0 = 101
			$Y0 = 149
	EndSelect
	If StringInStr($Area, "Belt") Then
		$BoxesXOffset = 31
		$BoxesYOffset = 32
		$InBoxXOffset_1 = 0
		$InBoxYOffset_1 = 1
		$InBoxXOffset_2 = 0
		$InBoxYOffset_2 = 1
		$InBoxXOffset_3 = 0
		$InBoxYOffset_3 = 1
		$InBoxXOffset_4 = 0
		$InBoxYOffset_4 = 1
		$InBoxXOffset_5 = 0
		$InBoxYOffset_5 = 1
		$InBoxXOffset_6 = 0
		$InBoxYOffset_6 = 1
		$NRows = 4
		$X0 = 442
		Select
			Case $Area == "Belt4"
				$NCols = 4
				$Y0 = 513
			Case $Area == "Belt3"
				$NCols = 3
				$Y0 = 545
			Case $Area == "Belt2"
				$NCols = 2
				$Y0 = 577
			Case $Area == "Belt1"
				$NCols = 1
				$Y0 = 609
		EndSelect
	EndIf
	Dim $X[$NRows]
	Dim $Y[$NCols]
	$X[0] = $X0 + $XDiff
	$Y[0] = $Y0 + $YDiff
	For $i = 1 To ($NRows - 1)
		$X[$i] = ($X[($i - 1)] + $BoxesXOffset)
	Next
	For $j = 1 To ($NCols - 1)
		$Y[$j] = ($Y[($j - 1)] + $BoxesYOffset)
	Next
	Dim $AreaShot[$NRows][$NCols]
	For $i = 0 To ($NRows - 1)
		For $j = 0 To ($NCols - 1)
			$Apix_1 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_1, $Y[$j] + $InBoxYOffset_1)))
			$Apix_2 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_2, $Y[$j] + $InBoxYOffset_2)))
			$Apix_3 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_3, $Y[$j] + $InBoxYOffset_3)))
			$Apix_4 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_4, $Y[$j] + $InBoxYOffset_4)))
			$Apix_5 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_5, $Y[$j] + $InBoxYOffset_5)))
			$Apix_6 = (Int(PixelGetColor($X[$i] + $InBoxXOffset_6, $Y[$j] + $InBoxYOffset_6)))
			$AreaShot[$i][$j] = ($Apix_1 + $Apix_2 + $Apix_3 + $Apix_4 + $Apix_5 + $Apix_6)
		Next
	Next
	Return $AreaShot
EndFunc   ;==>BoxesAreaShot


;========================================================
; This function will setup variables for each ACT context
;========================================================
Func SetupActContext($Act)
	Select
		Case $Act == 3
			$CurrentAct = 3
			; Colors definition
			$XUNIQUES_Color = 6521492; ok
			$SETS_Color = 65304 ; changed
			$XRARES_Color = 6535902 ; ok
			$MAGICS_Color = 11358546 ; ok
			$GRAYS_Color = 5394770 ; ok
			$WHITES_Color = 13027270 ; ok
			$NPC_BODY_Color = 16720037 ; ok
			$NPC_MENU_Color = 1637376 ;65304 ; changed
			$GREEN_BLOCKS_Color = 1637376 ;65304 ;ok
			$MERC_GREEN_BAR_Color = 550168 ; changed
			$MERC_ORANGE_BAR_Color = 2197206 ; ok
			$UNID_RED_Color = 3229109 ; ok
			$CRAFTED_Color = 2197206 ; ok
			$TP_color = 3777263
			
		Case $Act == 5
			$CurrentAct = 5
			; Colors definition
			$XUNIQUES_Color = 6521492
			$SETS_Color = 1623816
			$XRARES_Color = 6535902
			$MAGICS_Color = 11358546
			$GRAYS_Color = 5394770
			$WHITES_Color = 13027270
			$NPC_BODY_Color = 16720037
			$NPC_MENU_Color = 1623816
			$GREEN_BLOCKS_Color = 65304
			$MERC_GREEN_BAR_Color = 34304
			$MERC_ORANGE_BAR_Color = 2197206
			$UNID_RED_Color = 3229109
			$CRAFTED_Color = 2197206
			$TP_color = 3777263

		Case Else
			LogEvent(3, "Failed to define Act context. Exit.")
			Exit
	EndSelect
EndFunc   ;==>SetupActContext


;=======================================
; Return actual d2 game server last BYTE
;=======================================
Func CheckServerIP()
	If $Char_IpFinderLastByte1 == "No" And $Char_IpFinderLastByte2 == "No" And $Char_IpFinderLastByte3 == "No" Then
		Return 0
	EndIf
	$BYTE = 0
	RunWait(@ComSpec & " /c " & 'netstat -n > Config\System\Netstat', "", @SW_HIDE)
	$File = FileOpen(@ScriptDir & "\Config\System\Netstat", 0)
	For $l = 1 To 100
		$Line = FileReadLine($File, $l)
		If @error <> 0 Then
			ExitLoop
		EndIf
		If StringInStr($Line, ":4000") Then
			$Line = StringStripWS($Line, 8)
			$Line = StringReplace($Line, ":4000", "|")
			$Field = StringSplit($Line, "|")
			$BYTE = StringRight($Field[1], 3)
			$BYTE = StringReplace($BYTE, ".", "")
			If $BYTE == $Char_IpFinderLastByte1 Or $BYTE == $Char_IpFinderLastByte2 Or $BYTE == $Char_IpFinderLastByte3 Then
				LogEvent(1, "Server IP last Byte " & $BYTE & " was found ! Entering in infinite precast IDLE mode.")
				If $Char_IpFinderExecutable <> "No" And $Char_IpFinderExecutablePath <> "No" Then
					LogEvent(1, "Execute (RunWait) : " & $Char_IpFinderExecutablePath & "\" & $Char_IpFinderExecutable)
					RunWait($Char_IpFinderExecutablePath & "\" & $Char_IpFinderExecutable, $Char_IpFinderExecutablePath & "\")
					Sleep(1000)
				EndIf
				SplashTextOn("", "########## GOOD SERVER IP WAS FOUND: @" & $BYTE & "!!! ##########", 600, 22, 200, 5, 1, "System", "", "")
				WinActivate($D2_WName, "")
				WinWaitActive($D2_WName, "", 3)
				WinMove($D2_WName, "", (Random(95, 100)), (Random(35, 40)))
				WinActivate($D2_WName, "")
				Sleep(Random(1000, 1500))
				While 1
					Sleep(Random(2000, 6000))
					;Sequencing(0)
				WEnd
			Else
				LogEvent(1, "Game Server IP last Byte was: ." & $BYTE)
			EndIf
		EndIf
	Next
	FileClose($File)
	Return $BYTE
EndFunc   ;==>CheckServerIP




;===============================================================================================
; WAIT UNTIL the cursor is NOT free: return 1 if NOT free, 0 if yes, but with 5 seconds timout
;===============================================================================================
Func WaitNotFreeCursor()
	$CursTimeOut = 0
	Do
		If NotFreeCursor() == 1 Then
			Return 1
		Else
			Sleep(Random(50, 150))
			$CursTimeOut = $CursTimeOut + 1
		EndIf
	Until ($CursTimeOut > 70)
	Return 0
EndFunc   ;==>WaitNotFreeCursor


;===============================================================================================
; WAIT UNTIL the cursor is free: return 1 if free, 0 if not, but with 5 seconds timout
;===============================================================================================
Func WaitFreeCursor()
	$CursTimeOut = 0
	Do
		If FreeCursor() == 1 Then
			Return 1
		Else
			Sleep(Random(50, 150))
			$CursTimeOut = $CursTimeOut + 1
		EndIf
	Until ($CursTimeOut > 70)
	Return 0
EndFunc   ;==>WaitFreeCursor


;===============================================================================================
; VALIDATE if the cursor is Free: return 1 if free, 0 if not
;===============================================================================================
Func FreeCursor()
	$MCoords = MouseGetPos()
	$XM = $MCoords[0]
	$YM = $MCoords[1]
	$MPixel1 = PixelGetColor($XM + 18, $YM + 24)
	$MPixel2 = PixelGetColor($XM + 9, $YM + 13)
	$MPixel3 = PixelGetColor($XM + 17, $YM + 16)
	$MPixel4 = PixelGetColor($XM + 27, $YM + 13)
	$MPixel5 = PixelGetColor($XM + 23, $YM + 19)
	$MPixel6 = PixelGetColor($XM + 23, $YM + 18)
	$MPixel7 = PixelGetColor($XM + 23, $YM + 16)
	If ($MPixel1 == 527368 And $MPixel2 == 1580056 And $MPixel3 == 1582121 And $MPixel4 == 2698281 And $MPixel5 == 3749945 And $MPixel6 == 4868426 And $MPixel7 == 6514019) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>FreeCursor


;===============================================================================================
; VALIDATE if the cursor is NOT free: return 1 if free, 0 if not
;===============================================================================================
Func NotFreeCursor()
	$MCoords = MouseGetPos()
	$XM = $MCoords[0]
	$YM = $MCoords[1]
	$MPixel1 = PixelGetColor($XM + 18, $YM + 24)
	$MPixel2 = PixelGetColor($XM + 9, $YM + 13)
	$MPixel3 = PixelGetColor($XM + 17, $YM + 16)
	$MPixel4 = PixelGetColor($XM + 27, $YM + 13)
	$MPixel5 = PixelGetColor($XM + 23, $YM + 19)
	$MPixel6 = PixelGetColor($XM + 23, $YM + 18)
	$MPixel7 = PixelGetColor($XM + 23, $YM + 16)
	If ( Not ($MPixel1 == 527368 And $MPixel2 == 1580056 And $MPixel3 == 1582121 And $MPixel4 == 2698281 And $MPixel5 == 3749945 And $MPixel6 == 4868426 And $MPixel7 == 6514019)) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>NotFreeCursor


;===========================================================
; Will count the pixel number of passed color in passed area
;===========================================================
Func AreaColorCountCheck($XStart, $YStart, $XStop, $YStop, $Step, $Color, $MiniMatch, $Delay, $Tries)
	$XStart = $XStart + $XDiff
	$YStart = $YStart + $YDiff
	$XStop = $XStop + $XDiff
	$YStop = $YStop + $YDiff
	Do
		Sleep($Delay)
		$Tries = $Tries - 1
		$ColorCount = 0
		For $X = $XStart To $XStop Step $Step
			For $Y = $YStart To $YStop Step $Step
				$Apix = PixelGetColor($X, $Y)
				If $Apix == $Color Then
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

Func TimerStart()
	Return _NowCalc()
EndFunc   ;==>TimerStart


Func TimerStop($beg)
	Return _DateDiff('s', $beg, _NowCalc())
EndFunc   ;==>TimerStop
