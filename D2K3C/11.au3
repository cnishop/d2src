#region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** ���������� ACNWrapper_GUI ****
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

;#include <fireMethord.au3>


#include <Array.au3>
#include<af_search_pic.au3>;��������Դ�����ļ����ű���
#include <moveWithMap.au3>

Global $titleImageSearch
Dim $size, $winleft, $winTop, $winright, $winBottom

Global $title = "d2"


; �õ����� "this one" ���ݵļ��±����ڵľ��
$handle = WinGetHandle($title)
If @error Then
	MsgBox(4096, "����", "�����ҵ�ָ�����ڣ����ȴ�")
	Exit
Else
	WinActivate($title)
	Sleep(3000)
EndIf

$size = WinGetClientSize($title)
If $size[0] <> 800 And $size[1] <> 600 Then
	MsgBox(0, "��ʾ", "���Ƚ��������ó�800*600")
EndIf
Sleep(1000)

initialSize()



#CS MouseMove(160, 100)
	MouseMove(160, 150)
	MouseMove(200, 100)
	MouseMove(200, 150)
	Exit
#CE



 MouseMove(685, 320)
;~ MouseClick('left', 430, 480)
;~ Sleep(2000)
;;Ȼ��˴����Ե������·����ŵ�


;~ 	TrayTip("", "��act3Сվȥ3C�ĳ���.", 9, 16)
;~ 	Sleep(500)
;~ 	$coord = findwp()
;~ 	If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 		MouseClick("left", $coord[0], $coord[1], 1);
;~ 		Sleep(1200)
;~ 		MouseClick("left", 120, 380, 1);
;~ 		Sleep(1400)
;~ 	EndIf
;~



;~ Sleep(2000)
;~ $t = TimerInit()
;~ search_pic($winleft, $winTop -300, $winright, $winBottom , "images\act3point.bmp") ;search_pic($x1,$y1,$x2,$y2,$pic)"��ǰ��Ļ��ͼ",˵����$x1:��Ļ�ϵ����Ͻ�X����,$y1:��Ļ�ϵ����Ͻ�Y����,$x2:��Ļ�ϵ����½�X����,$y2:��Ļ�ϵ����½�Y����,$pic:Ҫ��ͼ��·��������,$aPosMsg:��������ֵ(X����,Y����,��,��)
;~ If $aPosMsg <> "" Then
;~ 	$array = StringSplit($aPosMsg, ",", 2)
;~ 	TrayTip("", $array[0] & $array[1], 9, 16)
;~ 	MouseMove($array[0], $array[1])
;~ 	ConsoleWrite(TimerDiff($t) & @CRLF)
;~ EndIf



Func findlouti1() ;act3point

	$postion = _FindPic($winleft, $winTop + 300, $winright - 400, $winBottom - 50, "images\109a5down1.bmp", 0.8)
	;TrayTip("", "�ҵ�Сվ��¼2.", 9, 16)
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
	;TrayTip("", "�ҵ�Сվ��¼2.", 9, 16)
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
	;TrayTip("", "�ҵ�Сվ��¼2.", 9, 16)
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
	Else ;�����������ʧ�ܣ��򱨴�
		MsgBox(0, "������ʾ", "��ʼ��ϵͳ���ʧ�ܣ��������: " & Hex(@error, 8))
		Exit 0
	EndIf
EndFunc   ;==>_FindPic


Func initialSize()
	$size = WinGetPos($titleImageSearch)
	;MsgBox(0, "�����״̬ (X����,Y����,���,�߶�):", $size[0] & ",    " & $size[1] & ",   " & $size[2] & ",   " & $size[3])

	$winleft = $size[0] + ($size[2] - 800) / 2
	$winTop = $size[1] + ($size[3] - 600)
	$winright = $size[0] + $size[2] - ($size[2] - 800) / 2
	$winBottom = $size[1] + $size[3]
EndFunc   ;==>initialSize



