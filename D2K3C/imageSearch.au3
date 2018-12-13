AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;#include <fireMethord.au3>

Global $titleImageSearch

Dim $size, $winleft, $winTop, $winright, $winBottom

Func initialSize()
	$size = WinGetPos($titleImageSearch)
	;MsgBox(0, "活动窗口状态 (X坐标,Y坐标,宽度,高度):", $size[0] & ",    " & $size[1] & ",   " & $size[2] & ",   " & $size[3])

	$winleft = $size[0] + ($size[2] - 800) / 2
	$winTop = $size[1] + ($size[3] - 600)
	$winright = $size[0] + $size[2] - ($size[2] - 800) / 2
	$winBottom = $size[1] + $size[3]
EndFunc   ;==>initialSize
;MsgBox(0,"",$winleft& ",    " & $winTop & ",    " & $winright & ",    " & $winBottom)



Func findConnect() ;查找是否选择单机或站网界面
	TrayTip("", "检查是否准备登陆站网", 1)
	Sleep(500)


	$postion = _FindPic($winleft, $winTop + 400, $winright - 300, $winBottom, "images\first1.bmp", 0.8)
	;MsgBox(0,"",$winleft& ",    " & $winTop & ",    " & $winright & ",    " & $winBottom)
	If $postion[0] >= 0 And $postion[1] >= 0 Then
		;$postion= _FindPic($winleft,$winTop,$winright-400,$winBottom,"images\first2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;	EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findConnect

Func findConnectError() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop + 300, $winright, $winBottom, "images\netloginerr1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		;$postion= _FindPic($winleft,$winTop+200,$winright-100,$winBottom,"images\netloginerr2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;	EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findConnectError

Func findinputpsd() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop + 300, $winright, $winBottom, "images\inputpsd1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		;$postion= _FindPic($winleft,$winTop,$winright-400,$winBottom,"images\inputpsd2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;EndIf
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>findinputpsd

Func findpsderror() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop + 300, $winright, $winBottom, "images\inputpsd1err1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		;$postion= _FindPic($winleft,$winTop-300,$winright,$winBottom,"images\inputpsd1err2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;EndIf
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>findpsderror

Func findrole() ;查找是否选择单机或站网界面

	$postion = _FindPic($winleft, $winTop, $winright - 500, $winBottom - 400, "images\role1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		#CS 		$postion2= _FindPic($winleft,$winTop-300,$winright-500,$winBottom,"images\role2.bmp",0.8)
			If $postion2[0] >=0 And  $postion2[1] >=0 Then
			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
			EndIf
			$postion3= _FindPic($winleft+500,$winTop+300,$winright,$winBottom,"images\role3.bmp",0.8)
			If $postion2[0] >=0 And  $postion2[1] >=0 Then
			MouseMove($postion3[0]-$winleft,$postion3[1]-$winTop)
			EndIf
		#CE
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>findrole


Func findWaitRoom() ;wait create room
	$postion = _FindPic($winleft, $winTop + 400, $winright - 400, $winBottom - 100, "images\net1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		#CS 		$postion2= _FindPic($winleft,$winTop +400,$winright-100,$winBottom,"images\net2.bmp",0.8)
			If $postion2[0] >=0 And  $postion2[1] >=0 Then
			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
			EndIf
		#CE
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findWaitRoom

Func findinroom() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop + 500, $winright - 400, $winBottom, "images\inroom1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
			If $postion2[0] >=0 And  $postion2[1] >=0 Then
			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
			EndIf
		#CE
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findinroom

Func findRevInBag() ;查找是否选择单机或站网界面  420, 320, 705, 430
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\revlife.bmp", 0.9)

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
EndFunc   ;==>findRevInBag

Func findHealInBag() ;查找是否选择单机或站网界面  420, 320, 705, 430
	
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\heal.bmp", 0.8)

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
EndFunc   ;==>findHealInBag

Func findManaInBag() ;查找是否选择单机或站网界面  420, 320, 705, 430
	
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\mana.bmp", 0.8)

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

Func findHealInShop() ;查找是否选择单机或站网界面  420, 320, 705, 430
	
	$postion = _FindPic($winleft + 200, $winTop + 120, $winright - 400 , $winBottom - 190, "images\heal.bmp", 0.8)


	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;==>findHealInBag

Func findManaInShop() ;查找是否选择单机或站网界面  420, 320, 705, 430
	
	$postion = _FindPic($winleft + 200, $winTop + 120, $winright - 400 , $winBottom - 190, "images\mana.bmp", 0.8)

	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;==>findManaInBag


Func findinAct4() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 300, "images\act4.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
		#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
			If $postion2[0] >=0 And  $postion2[1] >=0 Then
			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
			EndIf
		#CE
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findinAct4

Func findwp() ;act3point
    ;	TrayTip("", "找到小站记录.", 9, 16)
	;Sleep(2000)
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 100, "images\act3point.bmp", 0.8)
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
	
EndFunc   ;==>finda3townwp


Func finda3npcOumus() ;查找是否选择单机或站网界面
	Local $ormusarray[7]

	$ormusarray[0] = "images\a3npc1.bmp"
	$ormusarray[1] = "images\a3npc2.bmp"
	$ormusarray[2] = "images\a3npc3.bmp"
	$ormusarray[3] = "images\a3npc4.bmp"
	$ormusarray[4] = "images\a3npc5.bmp"
	$ormusarray[5] = "images\a3npc6.bmp"
	$ormusarray[6] = "images\a3npc7.bmp"
	For $i = 0 To 6 Step 1
		$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 300, $ormusarray[$i], 0.6)

		If $postion[0] >= 0 And $postion[1] >= 0 Then
			ExitLoop
		EndIf
	Next
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
	
EndFunc   ;==>finda3npcOumus



Func a3CuiNearPoint() ; 查找是否在小站附近
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 300, "images\a3c1.bmp", 0.8)

	If $postion[0] >= 0 And $postion[1] >= 0 Then
				TrayTip("", "成功到达崔凡客场景了。。。", 1, 16)
	Sleep(1000)
		Return True
	Else
						TrayTip("", "错误 ，没有找到崔凡客场景了。。。", 1, 16)
	Sleep(2000)
		Return False
	EndIf
	
EndFunc   ;==>a3CuiNearPoint

Func finda3box() ;查找是否选择单机或站网界面
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 300, "images\box.bmp", 0.8)

	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>finda3box

Func findcui2() ;查找3c那的
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 30, "images\cui2.bmp", 0.8)

	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>finda3box


Func finPicPos($picPath, $sim)

	$postion = _FindPic($winleft, $winTop, $winright, $winBottom -100 , $picPath, $sim)

	#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
		If $postion2[0] >=0 And  $postion2[1] >=0 Then
		MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
		EndIf
	#CE
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>finPicPos


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




#CS
	Func _FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar)
	Dim $pos[2]
	$obj = ObjCreate("QMDispatch.QMFunction")
	$foundpixel = $obj.FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar)
	$pos[0] = Int($foundpixel / 8192)
	$pos[1] = Mod($foundpixel, 8192)
	Return $pos
	EndFunc ;==>FindPic
	
#CE
