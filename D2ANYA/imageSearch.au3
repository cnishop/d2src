AutoItSetOption("WinTitleMatchMode", 4)
   AutoItSetOption("MouseCoordMode", 2)
   AutoItSetOption("PixelCoordMode", 2)
   ;#include <fireMethord.au3>

Global $titleImageSearch

Dim $size,$winleft,$winTop,$winright,$winBottom

Func initialSize()
   $size = WinGetPos($titleImageSearch)
   ;MsgBox(0, "�����״̬ (X����,Y����,���,�߶�):", $size[0] & ",    " & $size[1] & ",   " & $size[2] & ",   " & $size[3])
   
   $winleft=$size[0]+ ($size[2]-800)/2
   $winTop = $size[1] + ($size[3]-600)
   $winright= $size[0] + $size[2]-($size[2]-800)/2
   $winBottom = $size[1] + $size[3] 
EndFunc
   ;MsgBox(0,"",$winleft& ",    " & $winTop & ",    " & $winright & ",    " & $winBottom)



Func findConnect()   ;�����Ƿ�ѡ�񵥻���վ������
	TrayTip("", "����Ƿ�׼����½վ��", 1)
		Sleep(500)


	$postion= _FindPic($winleft,$winTop+400,$winright-300,$winBottom,"images\first1.bmp",0.8)
	;MsgBox(0,"",$winleft& ",    " & $winTop & ",    " & $winright & ",    " & $winBottom)
	If $postion[0] >=0 And  $postion[1] >=0 Then
		;$postion= _FindPic($winleft,$winTop,$winright-400,$winBottom,"images\first2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
			;MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;	EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func findConnectError()   ;�����Ƿ�ѡ�񵥻���վ������
$postion= _FindPic($winleft,$winTop+300,$winright,$winBottom,"images\netloginerr1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
		;$postion= _FindPic($winleft,$winTop+200,$winright-100,$winBottom,"images\netloginerr2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;	EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc

Func findinputpsd()   ;�����Ƿ�ѡ�񵥻���վ������
$postion= _FindPic($winleft,$winTop+300,$winright,$winBottom,"images\inputpsd1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
		;$postion= _FindPic($winleft,$winTop,$winright-400,$winBottom,"images\inputpsd2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;EndIf
		Return True
	Else
		Return False
	EndIf

EndFunc

Func findpsderror()   ;�����Ƿ�ѡ�񵥻���վ������
$postion= _FindPic($winleft,$winTop+300,$winright,$winBottom,"images\inputpsd1err1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
		;$postion= _FindPic($winleft,$winTop-300,$winright,$winBottom,"images\inputpsd1err2.bmp",0.8)
		;If $postion[0] >=0 And  $postion[1] >=0 Then
		;	MouseMove($postion[0]-$winleft,$postion[1]-$winTop)
		;EndIf
		Return True
	Else
		Return False
	EndIf

EndFunc

Func findrole()   ;�����Ƿ�ѡ�񵥻���վ������

$postion= _FindPic($winleft,$winTop,$winright-500,$winBottom-400,"images\role1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
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

EndFunc


Func findWaitRoom()   ;wait create room
$postion= _FindPic($winleft,$winTop+400,$winright-400,$winBottom-100,"images\net1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
#CS 		$postion2= _FindPic($winleft,$winTop +400,$winright-100,$winBottom,"images\net2.bmp",0.8)
   		If $postion2[0] >=0 And  $postion2[1] >=0 Then
   			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
   		EndIf
#CE
		Return True
	Else
		Return False
	EndIf
EndFunc

Func findinroom()   ;�����Ƿ�ѡ�񵥻���վ������
$postion= _FindPic($winleft,$winTop+500,$winright-400,$winBottom,"images\inroom1.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
   		If $postion2[0] >=0 And  $postion2[1] >=0 Then
   			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
   		EndIf
#CE
		Return True
	Else
		Return False
	EndIf
EndFunc

Func findRevInBag()   ;�����Ƿ�ѡ�񵥻���վ������  420, 320, 705, 430
	  
$postion= _FindPic($winleft+420,$winTop+320,$winright-95,$winBottom-170,"images\revlife.bmp",0.9)
   
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
        $postion[0]=$postion[0]-$winleft
		$postion[1]=$postion[1]-$winTop
Return $postion
EndFunc

Func findArmar()   ;�����Ƿ�ѡ�񵥻���վ������  420, 320, 705, 430
	  
;$postion= _FindPic($winleft,$winTop,$winright,$winBottom,"images\a1.bmp",0.8)
$postion= _FindPic($winleft,$winTop,$winright,$winBottom,"images\a1.bmp",0.4)
   
        $postion[0]=$postion[0]-$winleft
		$postion[1]=$postion[1]-$winTop
Return $postion
EndFunc

Func findinAct4()   ;�����Ƿ�ѡ�񵥻���վ������
$postion= _FindPic($winleft,$winTop,$winright,$winBottom-300,"images\act4.bmp",0.8)

	If $postion[0] >=0 And  $postion[1] >=0 Then
#CS 		$postion2= _FindPic($winleft,$winTop +500,$winright-500,$winBottom,"images\inroom2.bmp",0.8)
   		If $postion2[0] >=0 And  $postion2[1] >=0 Then
   			MouseMove($postion2[0]-$winleft,$postion2[1]-$winTop)
   		EndIf
#CE
		Return True
	Else
		Return False
	EndIf
EndFunc



   Func _FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar) 
   Dim $pos[2] 
   $obj = ObjCreate("QMDispatch.QMFunction") 
   $foundpixel = $obj.FindPic($iLeft, $iTop, $iRight, $iBottom, $szFileName, $fSimilar) 
   ;MsgBox(0,"",Mod($foundpixel, 8192))
   
   $pos[0] = Int($foundpixel / 8192) 
   $pos[1] = Mod($foundpixel, 8192)
   ;MsgBox(0,"", $pos[0]& "" & $pos[1])
   ; MsgBox(0,"", $winleft & "" & $winright)
   ;MsgBox(0,"",$pos[0]-$winleft & "" & $pos[1]-$winTop)
   ;If $pos[0] >0 And $pos[1] > 0 Then
	;MouseMove($pos[0]-$winleft,$pos[1]-$winTop)
	
   ;EndIf
   Return $pos 
   EndFunc ;==>FindPic

   


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
