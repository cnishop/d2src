AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;AutoItSetOption("MouseClickDelay", 1)

;#include <colormanger.au3>

#include <Array.au3>

Global $titlefiremethord
Global $fireround
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



Func takefire($var = 1, $time = 3, $blzrnd = 1)
	Select
		Case $var = 1
			icesor($time, $blzrnd)
		Case $var = 2
			firesor()
		Case $var = 4 ;����Ϊ��ɫ���Ƽ���
			sor109($time)
		Case Else
			fireicesor()
	EndSelect
EndFunc   ;==>takefire

Func sor109($ctime = 10)
	#CS
		Send("{F6}") ;��������
		Sleep(20)
		MouseClick("right", 560, 140, 1)
		Sleep(40)
		Send("{F3}") ;��������
		Sleep(50)
		For $i = 1 To $ctime - 4
		MouseClick("right", 560, 140, 1)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
		Sleep(200)
		Next
		
		Send("{F2}") ;��������
		Sleep(50)
		For $i = 1 To $ctime + 5
		MouseClick("right", 560 + $i, 140 - $i, 1)
		addBloodtorole()
		addmanatorole()
		;addBloodtopet()
		Sleep(200)
		Next
		
	#CE

	
	;Send("{F2}") ;��������
	Send("{" & $char_fireFire & "}")
	For $i = $guifirelighttime To 1 Step -1
		TrayTip("", "����ʣ�����" & $i, 1, 16)
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
	
	If $cblzrnd = 1 Then ;����ǹ̶��������Ϊ 2 -4 ֮��
		$ctime = Random(2, 4, 1)
	EndIf

	
	Send("{" & $char_blzIce & "}")
	Sleep(50)
	If $sanctury = 1 Then

		TrayTip("", "��Ӷ�����ӻ���Զ���빥��", 1, 16)
		
		For $i = 1 To $ctime
			If checkNowDead() = 1 Then ;�������
				;ExitLoop 2
				TrayTip("", "�������...", 1, 16)
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
			
			For $i = 1 To $ctime Step 1 ;���� shift ���̵Ĺ���
				Send("{" & $char_blzIce & "}") ;��������
				$clickt1 = Random(1, 5, 1)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				If checkNowDead() = 1 Then ;�������
					;ExitLoop 2
					TrayTip("", "�������...", 1, 16)
					Sleep(500)
					Send("{ESC}")
					Sleep(500)
					Return
				EndIf
				TrayTip("", "���ܴ���" & $ctime - $i + 1, 1, 16)
				addBloodtorole()
				addmanatorole()
				addBloodtopet()
				Sleep(100)
				
				$clickt2 = Random(1, 3, 1)
				Send("{LSHIFT down}") ;��������
				Sleep(100)
				;$a = PixelChecksum(560, 360, 720, 440, 3, $title)
				For $j = 1 To 5
					MouseClick("left", 560 - $i * 15, 140 + $i * 10, $clickt2)
					Sleep(150)
				Next
				Sleep(800)
				
				Send("{LSHIFT up}") ;��������
				
				;$b = PixelChecksum(560, 360, 720, 440, 3, $title)
				#CS 			If $a <> $b Then
					;writelog("����---δtp��ָ��λ�û��ܵ����")
					writelog("�쳣---�� " & $fireround & " ��: δtp��ָ��λ�û��ܵ����")
					TrayTip("", "δtp��ָ��λ�û��յ����", 1, 16)
					Sleep(10)
					ExitLoop
					EndIf
				#CE
			Next
			
		Else
			
			For $i = 1 To $ctime Step 1 ;������ shift ���̵Ĺ���
				Send("{" & $char_blzIce & "}") ;��������
				$clickt1 = Random(1, 5, 1)
				MouseClick("right", 560 - $i * 15 + $clickt1, 140 + $i * 10, $clickt1)
				If checkNowDead() = 1 Then ;�������
					;ExitLoop 2
					TrayTip("", "�������...", 1, 16)
					Sleep(500)
					Send("{ESC}")
					Sleep(500)
					Return
				EndIf
				TrayTip("", "���ܴ���" & $ctime - $i + 1, 1, 16)
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
		TrayTip("", "����ʣ�����" & $i, 1, 16)
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
	Send("{F2}") ;��������
	For $i = 1 To 20 Step 1
		addBloodtorole()
		MouseClick("right", 540, 130, 1, 0)
		Sleep(100)
		MouseClick("right", 560, 170, 1, 0)
		Sleep(100)
		MouseClick("right", 590, 140, 1, 0)
		Sleep(100)
	Next

	Send("{F3}") ;��������
	For $i = 1 To 3 Step 1
		addBloodtorole()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(1000)
	Next

EndFunc   ;==>fireicesor


Func fire3c($bhtime)
	Local $drinkcount = 0 ; �����ҩˮ�ļ���������������ظ��ģ���2����ٺ�һ��
	#CS 	Local $char_Vigor = "F3"      ;����
		Local $char_Bh = "F1"       ;Bh
		Local $char_normal_attack = "F2"  ;  ��ͨ����, ����ͻ��,���ܵ��»Ὡֱ
		Local $char_Conc  = "F4"               ;רע�⻷
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
	TrayTip("", "ԭ���ͷ�BH����" & $bhtime & "��.", 1, 16)
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
	;�ƶ���λ�ã�������
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
	TrayTip("", "ԭ���ͷ�BH����" & $bhtime & "��.", 1, 16)
	For $i = 1 To $bhtime Step 1
		addmanatorole()
		addBloodtorole()
		MouseMove(410 - $i * 3, 300 + $i * 3)
		Sleep(1000) ;���10��
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


Func fireMonsterByColor($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode) ; $kpmode =1 ,��ʾֻ�����Ͻ�
	$findrecround = 0 ;  �м��������ҵĴ���
	$findfourround = 0 ;�ĸ���λ�ҹ�

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 200
	$ytop_diff = 150
	$xright_diff = 200
	$ybottom_diff = 200
	
	$firstAttack = 0 ;  �����һ���ҹֵķ�ʽ�Ƿ����ҵ�
	
	Local $i = 0 ;����������ѭ����ɫ
	;Dim $position[4] ;����һ����¼4����λ������
	
	;�кü�����ɫ������һ����ѭ��
	
	
	$FailsCount = 0
	If ($kpmode = 1) Then
		Send("{" & $char_fireFire & "}")
		Sleep(10)
		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), Random(1, 3, 1))
		Sleep(50)
	EndIf
	$beginAttackTime = TimerInit()
	
	;---------------�ʼ�ȴ�һ��
	;TrayTip("", "��ʼ׼�����", 1, 16)

	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 10, 10, $title)
		If Not @error Then
			$FailsCount = 0
			TrayTip("", "����ģ���㷨�ҹֹ���..."  , 1, 16)   ;

			If nowfire($XYBlock[0], $XYBlock[1]) = 0 Then
				TrayTip("", "����ʧ��", 1, 16)
				ExitLoop
			EndIf
			
		Else
			$FailsCount = $FailsCount + 1
		EndIf
		
		$i = $i + 1
		If ($i >= 5) Then
			$i = 0 ;ѭ����ɫ����ֹ���������������
		EndIf
		$dif = TimerDiff($beginAttackTime)
		;TrayTip("", "����ʱ�� " & $dif, 1, 16)
	Until $FailsCount >= 10 Or $dif >= 30000 ;����ʧ�ܴ�������5�� ���� ��ʱ�䳬����50��
	Return 0
EndFunc   ;==>fireMonsterByColor

Func fireMonsterByBlock($XBS_Start_PARM, $YBS_Start_PARM, $XBS_Stop_PARM, $YBS_Stop_PARM, $kpmode, $delayTime) ; $kpmode =1 ,��ʾֻ�����Ͻ� $delayTime �޶�һ��ʱ��
	$findrecround = 0 ;  �м��������ҵĴ���
	$findfourround = 0 ;�ĸ���λ�ҹ�

	$XBS_Start = $XBS_Start_PARM
	$YBS_Start = $YBS_Start_PARM
	$XBS_Stop = $XBS_Stop_PARM
	$YBS_Stop = $YBS_Stop_PARM
	
	$xleft_diff = 200
	$ytop_diff = 150
	$xright_diff = 200
	$ybottom_diff = 200
	
	$firstAttack = 0 ;  �����һ���ҹֵķ�ʽ�Ƿ����ҵ�
	
	Local $i = 0 ;����������ѭ����ɫ
	;Dim $position[4] ;����һ����¼4����λ������
	
	;�кü�����ɫ������һ����ѭ��
	
	
	$FailsCount = 0
	If ($kpmode = 1) Then
		Send("{" & $char_fireFire & "}")
		Sleep(10)
		MouseClick("right", 500 + Random(1, 10), 200 + Random(1, 10), Random(1, 5))
		Sleep(50)
	EndIf
	$beginAttackTime = TimerInit()
	
	;---------------�ʼ�ȴ�һ��
	;bhfire($bhtime, 430, 320)
	;---------------�ʼ�ȴ�һ��
	;TrayTip("", "��ʼ׼�����", 1, 16)

	Do
		$XYBlock = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $monsterColor[$i], 30, 10, $title)
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
				If ($kpmode = 1) Then
					$tp_Pix = countFirepointRec(400, $YBC - $ytop_diff, $XBC + $xright_diff, 350, $monsterColor[$i], $monsterColor_hex[$i]) ;2
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "1�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						;MouseMove($tp_Pix[0], $tp_Pix[1], 0)
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;�ƶ�����
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "����ʧ��", 1, 16)
							ExitLoop
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						;TrayTip("", "����ѭ�����..", 1, 16)
						$firstAttack = 1
						ContinueLoop
					EndIf
				EndIf
;~
				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec(400, 300, $XBC + $xright_diff, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;3
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "4�㷽��ȷ��λ�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;�ƶ�����
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "����ʧ��", 1, 16)
							Return
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "�������..", 1, 16)
						ContinueLoop
					EndIf
				EndIf
				
				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, 300, 400, $YBC + $ybottom_diff, $monsterColor[$i], $monsterColor_hex[$i]) ;3
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "8�㷽��ȷ��λ�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;�ƶ�����
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "����ʧ��", 1, 16)
							Return
						EndIf
						;$xleft_diff = 0
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "�������..", 1, 16)
						ContinueLoop
					EndIf
				EndIf

				If ($kpmode = 0) Then
					$tp_Pix = countFirepointRec($XBC - $xleft_diff, $YBC - $ytop_diff, 400, 300, $monsterColor[$i], $monsterColor_hex[$i]) ;1
					If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
						;TrayTip("", "10�㷽��ȷ��λ�� " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
						MouseMove($tp_Pix[0], $tp_Pix[1])
						;adjustDistance($tp_Pix[0], $tp_Pix[1], 200, 50) ;�ƶ�����  sor �����ƶ�����
						If nowfire($tp_Pix[0], $tp_Pix[1]) = 0 Then
							TrayTip("", "����ʧ��", 1, 16)
							ExitLoop ;����ѭ������
						EndIf
						;$xleft_diff = 0  ;�ĳ�0�������ƶ����¸�������ɫ
						;$ytop_diff = 0
						;$xright_diff = 0
						;$ybottom_diff = 0
						$firstAttack = 1
						;TrayTip("", "����ѭ�����..", 1, 16)
						ContinueLoop
					EndIf
				EndIf
				
;~ 				If $firstAttack = 1 Then ;��ʾ���Ϲ�����ʽ�ҵ���
;~ 				Else ;����ҵ�����ɫ����ķ�ʽû�ҵ������ܹ��ƶ�̫�죬���ܱ�ĳЩ���ӵ�ס���ĳ��������صķ�ʽ
;~
;~ 					TrayTip("", "����������ⷽʽ", 1, 16)
;~ 					Sleep(1)
;~ 					MouseMove(400, 300)
;~ 					Select


;~ 						Case AreaColorCountCheck(400, 20, 780, 300, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;�������ס�����Լ�������ؿ���
;~ 							TrayTip("", "1�㷽��ä��", 1, 16)

;~ 							If nowfire(600, 150) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop

;~ 						Case AreaColorCountCheck(400, 300, 780, 580, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;�������ס�����Լ�������ؿ���
;~ 							TrayTip("", "4�㷽��ä��", 1, 16)

;~ 							If nowfire(600, 450) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case AreaColorCountCheck(20, 300, 400, 580, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;�������ס�����Լ�������ؿ���
;~ 							TrayTip("", "8�㷽��ä��", 1, 16)

;~ 							If nowfire(200, 450) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop

;~ 						Case AreaColorCountCheck(20, 20, 400, 300, 50, $monsterColor_hex[$i], 5, 1, 5) == 1 ;�������ס�����Լ�������ؿ���
;~ 							TrayTip("", "10�㷽��ä��", 1, 16)
;~ 							If nowfire(200, 150) = False Then
;~ 								Return
;~ 							EndIf

;~ 							$findfourround = 0
;~ 							ContinueLoop
;~ 						Case Else
;~ 							TrayTip("", "Ŀ�겻��������", 1, 16)

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
				
				TrayTip("", "����������Χ.." & $findrecround, 1, 16)
				Sleep(1)
				If $xleft_diff >= 400 Or $ytop_diff >= 300 Or $xright_diff >= 400 Or $ybottom_diff >= 300 Then ;���������Χ�����˳�
					$xleft_diff = 200
					$ytop_diff = 200
					$xright_diff = 200
					$ybottom_diff = 250
					$findrecround = $findrecround + 1
					TrayTip("", "������һ��ѭ��" & $findrecround, 1, 16)
					If $findrecround >= 8 Then
						ExitLoop 1
					EndIf
				EndIf
				
				;EndIf
				

				
			WEnd
		Else;��һ����ɫ�㶼û�ҵ��Ļ����ٴβ��ң�����ۼƲ��������������˳�
			
			$FailsCount = $FailsCount + 1
			$dif = TimerDiff($beginAttackTime)
		EndIf
		$i = $i + 1
		If ($i > 4) Then
			$i = 0 ;ѭ����ɫ����ֹ���������������
		EndIf

	Until $FailsCount >= 6 Or $dif >= $delayTime ;����ʧ�ܴ�������5�� ���� ��ʱ�䳬����50��
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
			TrayTip("", "���������ҹ����㣬���Դ��", 1, 16)
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
	TrayTip("", "�־��룺" & $xiebian, 1, 16)
	If $xiebian >= $max Then
		TrayTip("", "�������̫Զ�ˣ���һ��������", 1, 16)
		Send("{" & $char_normal_attack & "}")
		Sleep(100)
		MouseClick("left", $X, $Y, 2)
		Sleep(500)
		Send("{" & $char_fireFire & "}")
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
