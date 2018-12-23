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
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\revlife.bmp", 0.8)

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
	
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 90, $winBottom - 160, "images\czheal.bmp", 0.8)

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
	
	$postion = _FindPic($winleft + 420, $winTop + 310, $winright - 95, $winBottom - 170, "images\czmana.bmp", 0.8)

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

Func findHealInShop() ; 
	
	$postion = _FindPic($winleft + 200, $winTop + 100, $winright - 400, $winBottom - 190, "images\czheal.bmp", 0.8)


	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;==>findHealInShop

Func findManaInShop() ; 
	
	$postion = _FindPic($winleft + 200, $winTop + 100, $winright - 400, $winBottom - 190, "images\czmana.bmp", 0.8)

	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;==>findManaInShop

Func findTomeTownInShop() ;  回城卷书 20本一卷
	
	$postion = _FindPic($winleft + 2, $winTop + 1, $winright - 400, $winBottom - 100, "images\tometown.bmp", 0.8)

	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;

Func findScrollownInShop() ;  单个回城卷轴
	
	$postion = _FindPic($winleft + 200, $winTop + 100, $winright - 400, $winBottom - 190, "images\scrolltwon.bmp", 0.8)

	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
EndFunc   ;

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
	
EndFunc   ;==>findwp


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
	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 300, "images\box.bmp", 0.7)

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
	
EndFunc   ;==>findcui2



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


Func finda5xiaozhan() ;act3point

	$postion = _FindPic($winleft, $winTop + 50, $winright - 10, $winBottom - 50, "images\a5xiaozhan.bmp", 0.8)
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
	
EndFunc   ;==>finda5both1

Func finda5both1() ;act3point

	$postion = _FindPic($winleft, $winTop + 50, $winright - 10, $winBottom - 50, "images\a5both1.bmp", 0.8)
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
	
EndFunc   ;==>finda5both1

Func findlcaicao() ;act3point

	$postion = _FindPic($winleft + 50, $winTop + 50, $winright, $winBottom - 300, "images\109a5down3.bmp", 0.8)
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

Func findmutong1() ;act3point

	$postion = _FindPic($winleft + 50, $winTop + 50, $winright, $winBottom - 300, "images\mutong1.bmp", 0.8)
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
	
EndFunc   ;==>findmutong1

Func findxiangzi1() ;act3point

	$postion = _FindPic($winleft + 50, $winTop + 50, $winright, $winBottom - 300, "images\xiangzi1.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findxiangzi1

Func findtudui1() ;act3point

	$postion = _FindPic($winleft + 50, $winTop + 50, $winright, $winBottom - 300, "images\tudui1.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findtudui1

Func findreddoor1() ;act3point

	$postion = _FindPic($winleft + 20, $winTop + 10, $winright, $winBottom - 300, "images\reddoor.bmp", 0.8)
	;TrayTip("", "找到小站记录2.", 9, 16)
	;Sleep(2000)
	$postion[0] = $postion[0] - $winleft
	$postion[1] = $postion[1] - $winTop
	Return $postion
	
EndFunc   ;==>findreddoor1

Func findzhuzi() ;act3point

	$postion = _FindPic($winleft + 300, $winTop + 300, $winright, $winBottom, "images\109a5down2.bmp", 0.7)
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

Func findtianshi() ;act3point

	$postion = _FindPic($winleft, $winTop, $winright - 300, $winBottom - 200, "images\109a5down4.bmp", 0.6)
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
	
EndFunc   ;==>findtianshi

Func finda5aakkByPicture() ; 通过图片的方式，找act5 的艾尔夸克
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
	If $postion[0] = -1 Then ;如果没找到，则返回一个 -1 ，可以重新查找一遍
		Return $postion
	EndIf
EndFunc   ;==>finda5aakkByPicture

Func finPicPos($picPath, $sim)

	$postion = _FindPic($winleft, $winTop, $winright, $winBottom - 100, $picPath, $sim)

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
