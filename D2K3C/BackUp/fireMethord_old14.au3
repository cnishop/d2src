AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;AutoItSetOption("MouseClickDelay", 1)

;#include <colormanger.au3>

Global $titlefiremethord
Local $sanctury
Local $monsterColor1 = "0xFC2C00" ; ���﷽����ɫ1�������ɫ   ��FC2C00ԭk3c��   0x012CFD
Local $monsterColor2 = "0x2460D8" ; ���﷽����ɫ2�����类�����к��ɫǳ��ɫ   5c70e4
Local $monsterColor3 = "0x2260D7" ;��ɫ�����������
Local $monsterColor1_hex = "FC2C00"
Local $monsterColor2_hex = "2460D8"
Local $monsterColor2_hex = "2260D7"



Local $monsterColor[5] ;���ڴ����ɫ����
Local $monsterColor_hex[5] ;

$monsterColor[0] = "0xFC2C00"
$monsterColor[1] = "0x2460D8"
$monsterColor[2] = "0x2360D7" ;����ɫ
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
	
	;---------------�ʼ�ȴ�һ��
	If isInRoom() Then
		
		If $testversion = 0 Then ;�������ʽ�棬������ͼƬ
			$coord = finPicPos("images\cui3.bmp", 0.7)
			;$coord = findcui2()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "����λ���ƶ�.", 1, 16)
				;MouseClick("left", $coord[0], $coord[1], 1);
				;Sleep(20)
				MouseClick("left", 500, 200, 2);
				Sleep(Random(400, 600, 1))
			EndIf
			
			$coord = finPicPos("images\cui4.bmp", 0.7)
			;$coord = findcui2()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "3C���ƶ���λ��", 1, 16)
				MouseClick("left", $coord[0] + 30, $coord[1] + 180, 1);
				;Sleep(200)
				;MouseClick("left", 500, 200, 2);
				CheckMove(400)
				;Sleep(Random(400, 600, 1))
			EndIf
		EndIf
		
		bhfire($bhtime, 430, 320)
	EndIf
	;---------------�ʼ�ȴ�һ��
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
		TrayTip("", "��ʼ�ͷ�bh��..", 1, 16)
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
	TrayTip("", "�־��룺" & $xiebian, 1, 16)
	If $xiebian >= $max Then
		TrayTip("", "�������̫Զ�ˣ���һ��������", 1, 16)
		Send("{" & $char_normal_attack & "}")
		Sleep(100)
		MouseClick("left", $X, $Y, 2)
		Sleep(500)
		Send("{" & $char_Bh & "}")
		Sleep(50)
		
	ElseIf $xiebian <= $min Then
		TrayTip("", "����̫���ˣ���һ��������,��΢�ƶ���", 1, 16)
		Sleep(100)
		MouseClick("left", 400 + Random(-100, 100, 1), 300 + Random(-50, 50, 1), 2)
		Sleep(50)
	EndIf
EndFunc   ;==>adjustDistance


Func countFirepointRec($left, $top, $right, $bottom, $mColor, $mColor_hex)
	$postion = PixelSearch($left, $top, $right, $bottom, $mColor, 0, 10, $title)
	;$tp_Pix = PixelSearch(50, 20, 790, 520, "0xFC2C00", 0, 10)
	If Not @error Then
		;TrayTip("", "������Χ�ڲ��ҵ����ܵ�Ŀ�꣬������ȷ�ж�", 1, 16)
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
			TrayTip("", "��⵽����..", 1, 16)
		Else
			$postion[0] = $postion[0] - 800
			$postion[1] = $postion[0] - 600
			TrayTip("", "���ﲻƥ��", 1, 16)
		EndIf
	Else
		Dim $postion[2]
		$postion[0] = $postion[0] - 800
		$postion[1] = $postion[0] - 600
		TrayTip("", "δ��⵽", 1, 16)
	EndIf
	Return $postion
EndFunc   ;==>countFirepointRec


Func fireMonsterByBlock($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode, $delayTime) ; $kpmode =1 ,��ʾֻ�����Ͻ� $delayTime �޶�һ��ʱ��
	$findrecround = 0 ;  �м��������ҵĴ���
	$findfourround = 0 ;�ĸ���λ�ҹ�

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 100
	$ytop_diff = 100
	$xright_diff = 100
	$ybottom_diff = 100
	
	$firstAttack = 0 ;  �����һ���ҹֵķ�ʽ�Ƿ����ҵ�
	
	Local $i = 0 ;����������ѭ����ɫ
	;Dim $position[4] ;����һ����¼4����λ������
	
	;�кü�����ɫ������һ����ѭ��
	
	
	$FailsCount = 0
	$beginAttackTime = TimerInit()
	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 30, 5, $title)
		If Not @error Then
			TrayTip("", "����Ŀ�꣬׼�������蹥���Ĺ���", 1, 16)
			$XBC = 400 ;����������Ϊ���ģ� ̫Զ�룬�϶��϶��򲻵�
			$YBC = 300

			While 1
				;�˴�����һ������һֱ����ǽһֱ��ֵ�����жϣ�����20��Ͳ�����
				$dif = TimerDiff($beginAttackTime)
				;ToolTip("", $dif, 1, 16)
				If $dif >= $delayTime Then
					ExitLoop 2
				EndIf
				
				
				$firstAttack = 0 ;�Ƚ��ҹֱ�־��Ϊ0
;~
				;�ڵ�һ������;�м�λ�� ���Ҳ�ͣ���ƶ�λ�ô��
				$find1 = 0
				Do
					$inMiddle = Middle3c()
					If $inMiddle <> -1 Then
						MouseClick("left", $inMiddle[0] - 100, $inMiddle[1] + 80, Random(1, 3, 1))
						Sleep(1000)
						;ÿ���ƶ�һ�·�λ
						$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;2
						If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
							;TrayTip("", "1�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
							;MouseMove($tp_Pix[0], $tp_Pix[1], 0)
							;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;�ƶ�����
							If bhfire(30, $tp_Pix[0], $tp_Pix[1]) = 0 Then
								TrayTip("", "����ʧ��", 1, 16)
								ExitLoop
							Else; ����ɹ��������
								$FailsCount =0
								$find1 = 0
							EndIf
						Else; ���û���ҵ����ͱ����
							$find1 = $find1 + 1
						EndIf
					EndIf
				Until $inMiddle = -1 Or  $find1 >= 10
				TrayTip("", "���ص㹥��", 1, 16)
				Sleep(1000)
				
				;�ߵ�������
				$coord = PixelSearch(150, 50, 700, 520, 0x18FC00, 25, 1, $title)
				If Not @error Then
					MouseClick("left", $coord[0] + 150, $coord[1] - 80, Random(2, 4, 1))
					Sleep(1000)
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;2
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						If bhfire(30, $tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "����ʧ��", 1, 16)
							ExitLoop
													Else; ����ɹ��������
								$FailsCount =0
								$find1 = 0
						EndIf
					EndIf
				EndIf


			WEnd
		Else;��һ����ɫ�㶼û�ҵ��Ļ����ٴβ��ң�����ۼƲ��������������˳�
			
			$FailsCount = $FailsCount + 1
			$dif = TimerDiff($beginAttackTime)
		EndIf
		
;~ 		$i = $i + 1
;~ 		If ($i > 4) Then
;~ 			$i = 0 ;ѭ����ɫ����ֹ���������������
;~ 		EndIf

	Until $FailsCount >= 10 Or $dif >= $delayTime ;����ʧ�ܴ�������5�� ���� ��ʱ�䳬����50��
	Return 0
EndFunc   ;==>fireMonsterByBlock


Func Middle3c()
	$coordLeft = PixelSearch(10, 10, 700, 500, 0x18FC00, 25, 1, $title)
	If Not @error Then
		;MouseMove($coordLeft[0]  ,$coordLeft[1] )  ;    x �м�ո�  55~ 75 + 80 ,  y �ո� -35~ 40
		$coordRight = PixelSearch($coordLeft[0] + 82, $coordLeft[1] + 42, 700, 500, 0x18FC00, 25, 1, $title)
		If Not @error Then
			;��ʾ�ҵ��˱��λ�������ж����·��ģ������Ϸ���
			$coordRightTop = PixelSearch($coordRight[0] + 80, 5, 790, $coordRight[1] - 40, 0x18FC00, 25, 1, $title)
			If Not @error Then ;������Ͻ��У���ʾ�����ﴦ���·�λ��
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

