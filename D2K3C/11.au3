#region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** 参数创建于 ACNWrapper_GUI ****
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

;#include <fireMethord.au3>


#include <Array.au3>
#include<af_search_pic.au3>;包含阿福源代码文件到脚本中
#include <moveWithMap.au3>

Global $titleImageSearch
Dim $size, $winleft, $winTop, $winright, $winBottom

Global $title = "d2"


; 得到包括 "this one" 内容的记事本窗口的句柄
$handle = WinGetHandle($title)
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口，请先打开")
	Exit
Else
	WinActivate($title)
	Sleep(3000)
EndIf

$size = WinGetClientSize($title)
If $size[0] <> 800 And $size[1] <> 600 Then
	MsgBox(0, "提示", "请先将窗口设置成800*600")
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
;;然后此处可以调用找下方红门的


;~ 	TrayTip("", "从act3小站去3C的场所.", 9, 16)
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
;~ search_pic($winleft, $winTop -300, $winright, $winBottom , "images\act3point.bmp") ;search_pic($x1,$y1,$x2,$y2,$pic)"当前屏幕找图",说明：$x1:屏幕上的左上角X坐标,$y1:屏幕上的左上角Y坐标,$x2:屏幕上的右下角X坐标,$y2:屏幕上的右下角Y坐标,$pic:要找图的路径及名称,$aPosMsg:返回坐标值(X坐标,Y坐标,长,高)
;~ If $aPosMsg <> "" Then
;~ 	$array = StringSplit($aPosMsg, ",", 2)
;~ 	TrayTip("", $array[0] & $array[1], 9, 16)
;~ 	MouseMove($array[0], $array[1])
;~ 	ConsoleWrite(TimerDiff($t) & @CRLF)
;~ EndIf



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



