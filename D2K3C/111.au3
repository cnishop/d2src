AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

#include <imageSearch.au3>
#include <date.au3>
#include <commonUse.au3>
#include <findpath.au3>    ;跑步路径
$title = "d2"
$handle = WinGetHandle($title)
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口，请先打开")
	Exit
Else
	WinActivate($title)
EndIf
$size = WinGetClientSize($title)
If $size[0] <> 800 And $size[1] <> 600 Then
	MsgBox(0, "提示", "请先将窗口设置成800*600")
EndIf
initialSize() 
Sleep(1000)

   $C1 = getredpointPos()
   		$coord = PixelSearch($C1[0] - 100, $C1[1]- 50 ,$C1[0] +100, $C1[1] , 0xC4C4C4, 30, 1, $title)   ; 1   ;找小地图上的红门的点
   		If Not @error Then
   			TrayTip("", "获取小地图门坐标", 1)
			Sleep(300)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]
   			$yy=$coord[1]
		EndIf
			
			Exit
   ;getredpointPos()
   
   

   Dim $findcolor = 0   ;定义是否找到绿线的点  - 一种是地图上没按tab建， 一种是 到站点附近，就没有了
   Dim $closeminmap = 0          ; 定义是否关闭迷你地图
   
   Dim $xx,$yy
   Local $j
   Local $pointps    ;定义线的方位 分 1 2 3 4  5 
   
   If $closeminmap =1 Then
   	Sleep(20)
   	Send("{TAB}")
   	Sleep(20)
EndIf

;tptopoint()

Func tptopoint()

Do 
   	
   		$coord = PixelSearch(100, 50, 375, 300, 0x00FC18, 30, 1, $title)   ; 1 
   		If Not @error Then
   			TrayTip("", "初始化坐标1", 1)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]	
   			$yy=$coord[1]
   			$findcolor =1 
			$pointps = 1 
   		EndIf
   		
		$coord = PixelSearch(375, 50, 795, 215, 0x00FC18, 30, 1, $title)   ; 1 
   		If Not @error Then
   			TrayTip("", "初始化坐标2", 1)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]
   			$yy=$coord[1]
   			$findcolor =1 
			$pointps =2 
   		EndIf
   		
		$coord = PixelSearch(425, 215, 795, 520, 0x00FC18, 30, 1, $title)   ; 1 
   		If Not @error Then
   			TrayTip("", "初始化坐标3", 1)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]
   			$yy=$coord[1]
   			$findcolor =1 
			$pointps =3
   		EndIf
   		
		$coord = PixelSearch(100, 300, 425, 520, 0x00FC18, 30, 1, $title)   ; 1 
   		If Not @error Then
   			TrayTip("", "初始化坐标4", 1)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]
   			$yy=$coord[1]
   			$findcolor =1 
			$pointps =4 
   		EndIf
		
#CS 		$coord = PixelSearch(300, 250, 425, 350, 0x00FC18, 30, 1, $title)   ; 人物四周最近范围
   		If Not @error Then
   			TrayTip("", "初始化坐标5", 1)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )	
   			$xx= $coord[0]
   			$yy=$coord[1]
   			$findcolor =1 	
   			$pointps =5 
   		EndIf	
#CE
			
   		
		If $findcolor = 0 Then
			MsgBox(0 ,"", "初始化坐标失败")
			EndIf
   $x=$xx-408
   $y=$yy-285
   $mousex= $x*1+408
   $mousey= $y*1+285
   
   Dim $mousex,$mousey
   
   $def=1	
   While ($mousex <= 790  and  $mousex >= 10 )  and  ($mousey <=540 and $mousey>=50)
	   
	   
		
		$mousex= $x*$def+408
		$mousey= $y*$def+285
		$def = $def + 1
		TrayTip("", $mousex & " and " & $mousey & " " & $def, 1)
		;Sleep(1000)
		
			If  $mousex >= 790 Or $mousex<= 10 Or ($mousey >=540 or $mousey<=50) Then
				$mousex= $x*($def-2)+408
				$mousey= $y*($def-2)+285
				TrayTip("", $mousex & " and " & $mousey & " " & $def, 1)
   	;Sleep(1000)
   		ExitLoop
   	EndIf
   	
   WEnd   
   	
   	
   	
   	
   MouseMove($mousex,$mousey)
   
   $i = 0
   $notmove = 0 
   $beginAttackTime = TimerInit()
   Do
   ;MouseClick("right", $mousex, $mousey , 1);
   
   If CheckMoved($mousex, $mousey,500) = 0 Then
   	$notmove = $notmove + 1
   	TrayTip("","遇到障碍，无法tp..", 1)
   EndIf
   If $notmove>= 3 Then
		;此处暂停住了，表示可能是无法前进或者被单注
	   adpositon($pointps)
	   
	      $co = getredpointPos()
   If $co[0] >= 0 And $co[1]>=0 Then
    getdistance($co[0], $co[1])
   EndIf

	   MouseMove(408,285)
   		Sleep(20)
   	Send("{TAB}")
   	Sleep(20)
	 $closeminmap = 1  
   	 If findkmdoor() = 1 Then;尝试搜索房间，如果没有找到，应该做后续操作，再尝试
		ExitLoop 2
	Else
		ExitLoop 1
	EndIf
	
	
   	EndIf
   
   
	TrayTip("", $i, 1)
   	$i = $i +1 
   	$dif = TimerDiff($beginAttackTime)
   Until $i >=10  Or $dif >= 20000 
   
   
	Sleep(20)
   	Send("{TAB}")
   	Sleep(20)
	 $closeminmap = 0  
	 $j = $j +1 
   Until  $j >=5
   
   	
EndFunc

   
   
   Func CheckMoved($mousexx,$mouseyy, $Delay)
   	$XDiff = 0
   	$YDiff = 0
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
		 MouseClick("right", $mousexx, $mouseyy , 1);
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
   			Return 0
   			;ExitLoop
   		EndIf
   	Until (TimerStop($Begin) > 3)
   	Return 1
   EndFunc   ;==>CheckMove
   
   
   Func findkmdoor()
   	   $find = 0
   				$coord = finPicPos("images\m301.bmp", 0.7)
   				;$coord = findcui2()
   				If $coord[0] >= 0 And $coord[1] >= 0 Then
   					TrayTip("", "找到了.", 1, 16)
   					MouseClick("left", $coord[0] , $coord[1], 1);
   					Sleep(200)
					$find = 1
					Return 1
   				EndIf
				
				   				$coord = finPicPos("images\m302.bmp", 0.7)
   				;$coord = findcui2()
   				If $coord[0] >= 0 And $coord[1] >= 0 Then
   					TrayTip("", "找到了.", 1, 16)
   					MouseClick("left", $coord[0] +50 , $coord[1], 1);
   					Sleep(200)
					$find = 1
					Return 1
   				EndIf
				
								   				$coord = finPicPos("images\m303.bmp", 0.7)
   				;$coord = findcui2()
   				If $coord[0] >= 0 And $coord[1] >= 0 Then
   					TrayTip("", "找到了.", 1, 16)
   					MouseClick("left", $coord[0] +20 , $coord[1]-50, 1);
   					Sleep(200)
					$find = 1
					Return 1
   				EndIf
				
				$coord = finPicPos("images\m304.bmp", 0.7)
   				;$coord = findcui2()
   				If $coord[0] >= 0 And $coord[1] >= 0 Then
   					TrayTip("", "找到了.", 1, 16)
   					MouseClick("left", $coord[0] +20 , $coord[1]-100, 1);
   					Sleep(200)
					$find = 1
					Return 1
   				EndIf
				
				If $find = 0 Then
					Return 0	
				EndIf
				
					
   EndFunc



 

 
 Func AreaColorCount($XStart, $YStart, $XStop, $YStop, $Step, $Color)
	$XStart = $XStart
	$YStart = $YStart
	$XStop = $XStop
	$YStop = $YStop
	
		$ColorCount = 0
		For $X = $XStart To $XStop Step $Step
			For $Y = $YStart To $YStop Step $Step
				$Apix = PixelGetColor($X, $Y)
				
				If Hex($Apix, 6) == $Color Then ; "FC2C00"
					;If $Apix == $Color Then
					$ColorCount = $ColorCount + 1
					
					;TrayTip("", $ColorCount, 1)
				EndIf
			Next
		Next
			Return $ColorCount



EndFunc   ;==>AreaColorCountCheck


Func adpositon($posion)
	 $a= AreaColorCount(10, 50, 400, 300, 10, "000000")
  $b= AreaColorCount(400, 50, 790, 300, 10, "000000")
   $c= AreaColorCount(400, 300, 790,540, 10, "000000")
    $d= AreaColorCount(10, 300, 400, 540, 10, "000000")
	
	Select 
	Case $posion =1 
		If $a >= $b Then
			CheckMoved(700, 200,500)
		Else
			CheckMoved(200, 200,500)
		EndIf
	Case $posion =2 
		If $a >= $b Then
			CheckMoved(700, 200,500)
		Else
			CheckMoved(200, 200,500)
		EndIf	
	Case $posion =3
		If $a >= $b Then
			CheckMoved(700, 200,500)
		Else
			CheckMoved(200, 200,500)
		EndIf	
	Case $posion =4
		If $a >= $b Then
			CheckMoved(700, 200,500)
		Else
			CheckMoved(200, 200,500)
		EndIf			
		
			
	
	EndSelect
EndFunc

Func getdistance($X, $Y)
	$xx = 0
	$yy = 0
	$xx = $X - 408
	$yy = $Y - 285
	$xiebian = Sqrt($xx * $xx + $yy * $yy)
	TrayTip("", "距离小地图门坐标：" & $xiebian, 1, 16)
	Sleep(500)
	Return $xiebian
EndFunc
	
Func getredpointPos()
		$coord = PixelSearch(10, 10,790, 540, 0xFC2C00, 0, 1, $title)   ; 1   ;找小地图上的红门的点
   		If Not @error Then
   			TrayTip("", "获取小地图门坐标", 1)
			Sleep(300)
   			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
   			MouseMove($coord[0], $coord[1] )
   			$xx= $coord[0]
   			$yy=$coord[1]
		Else
		     Dim $coord[2]
			 $coord[0] = -1
			 $coord[1] = -1
		EndIf
			Return $coord
EndFunc