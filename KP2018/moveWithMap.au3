AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseClickDelay", 1)

Local $notfixbox ;  设置包裹中左

;Global $bagEmptyCount ;背包剩余数量
;Global $allfull ;记录箱子和包裹都满了
;Global $boxisfull = 0 ;记录box放不下了
Local $bagfullCount
Local $xArray[10][2] ;x
Local $yArray[4][2] ;x
Local $emptyArray[4][10] ;original array -bag
Local $avvArray[4][10]
Local $cmpArray[4][10]
Local $firstcmpArray[4][10] ;移动前包裹满的布局
Local $lastcmpArray[4][10] ;移动后包裹满的布局
Local $itemSizeArray[2][8] ;记录物品形状
Local $xlength
Local $ylength
Local $firstCount
Local $lastCount
Local $itemSize ;item_size
Local $itembaglocation[1][2] ;记录包裹中物品的地点
Local $itembaglocationxy[1][2] ;记录包裹中物品的地点的序列号 x ，y   ;用于记录是否后续装箱忽略
Local $itembagCheck[4][10] ;判断是否检查背包这个格数



Local $findsame


;Global $boxEmptyCount
Local $boxfullCount
Local $xBoxArray[6][2] ;x
Local $yBoxArray[8][2] ;x
Local $emptyBoxArray[8][6] ;original array box
Local $avvBoxArray[8][6]
;~ Local $cmpBoxArray[8][6]
Local $cmpBoxArray[11][7]

$xArray[0][0] = 425
$xArray[0][1] = 440
$xArray[1][0] = 450
$xArray[1][1] = 470
$xArray[2][0] = 480
$xArray[2][1] = 500
$xArray[3][0] = 510
$xArray[3][1] = 530
$xArray[4][0] = 540
$xArray[4][1] = 560
$xArray[5][0] = 570
$xArray[5][1] = 590
$xArray[6][0] = 600
$xArray[6][1] = 615
$xArray[7][0] = 630
$xArray[7][1] = 645
$xArray[8][0] = 660
$xArray[8][1] = 675
$xArray[9][0] = 685
$xArray[9][1] = 700

$yArray[0][0] = 320
$yArray[0][1] = 340
$yArray[1][0] = 350
$yArray[1][1] = 370
$yArray[2][0] = 380
$yArray[2][1] = 400
$yArray[3][0] = 410
$yArray[3][1] = 430
;~    box
$xBoxArray[0][0] = 160
$xBoxArray[0][1] = 175
$xBoxArray[1][0] = 190
$xBoxArray[1][1] = 205
$xBoxArray[2][0] = 220
$xBoxArray[2][1] = 235
$xBoxArray[3][0] = 245
$xBoxArray[3][1] = 260
$xBoxArray[4][0] = 275
$xBoxArray[4][1] = 290
$xBoxArray[5][0] = 305
$xBoxArray[5][1] = 320



$yBoxArray[0][0] = 150
$yBoxArray[0][1] = 165
$yBoxArray[1][0] = 180
$yBoxArray[1][1] = 195
$yBoxArray[2][0] = 201
$yBoxArray[2][1] = 225
$yBoxArray[3][0] = 235
$yBoxArray[3][1] = 255
$yBoxArray[4][0] = 265
$yBoxArray[4][1] = 285
$yBoxArray[5][0] = 295
$yBoxArray[5][1] = 310
$yBoxArray[6][0] = 325
$yBoxArray[6][1] = 340
$yBoxArray[7][0] = 350
$yBoxArray[7][1] = 370




$emptyArray[0][0] = 2128286505
$emptyArray[0][1] = 680075913
$emptyArray[0][2] = 3532990065
$emptyArray[0][3] = 1702763733
$emptyArray[0][4] = 2781226753
$emptyArray[0][5] = 1869491841
$emptyArray[0][6] = 33630009
$emptyArray[0][7] = 2257654813
$emptyArray[0][8] = 3402240693
$emptyArray[0][9] = 3651934153

$emptyArray[1][0] = 1643131837
$emptyArray[1][1] = 4023004801
$emptyArray[1][2] = 1210726313
$emptyArray[1][3] = 1402155425
$emptyArray[1][4] = 3324257933
$emptyArray[1][5] = 1178673873
$emptyArray[1][6] = 1418138221
$emptyArray[1][7] = 3123713197
$emptyArray[1][8] = 4239462497
$emptyArray[1][9] = 262213569


$emptyArray[2][0] = 2849382445
$emptyArray[2][1] = 1649753657
$emptyArray[2][2] = 4055383265
$emptyArray[2][3] = 2840607369
$emptyArray[2][4] = 3396610741
$emptyArray[2][5] = 477177009
$emptyArray[2][6] = 1108484605
$emptyArray[2][7] = 3728482849
$emptyArray[2][8] = 3546356257
$emptyArray[2][9] = 786963093


$emptyArray[3][0] = 4170659101
$emptyArray[3][1] = 2377405565
$emptyArray[3][2] = 751582593
$emptyArray[3][3] = 1710831477
$emptyArray[3][4] = 1604531761
$emptyArray[3][5] = 1116753093
$emptyArray[3][6] = 1294093305
$emptyArray[3][7] = 3129229389
$emptyArray[3][8] = 1964844249
$emptyArray[3][9] = 3822594909


$emptyBoxArray[0][0] = 1382815065
$emptyBoxArray[0][1] = 3962638745
$emptyBoxArray[0][2] = 1280449305
$emptyBoxArray[0][3] = 3908117325
$emptyBoxArray[0][4] = 2494637393
$emptyBoxArray[0][5] = 522915957

$emptyBoxArray[1][0] = 2795513849
$emptyBoxArray[1][1] = 3151307501
$emptyBoxArray[1][2] = 3726776777
$emptyBoxArray[1][3] = 2906200325
$emptyBoxArray[1][4] = 2614496557
$emptyBoxArray[1][5] = 95424209

$emptyBoxArray[2][0] = 3740614401
$emptyBoxArray[2][1] = 1131756889
$emptyBoxArray[2][2] = 278407701
$emptyBoxArray[2][3] = 1658859977
$emptyBoxArray[2][4] = 1727147645
$emptyBoxArray[2][5] = 1785409549

$emptyBoxArray[3][0] = 303766333
$emptyBoxArray[3][1] = 3619035461
$emptyBoxArray[3][2] = 2246645857
$emptyBoxArray[3][3] = 3857263269
$emptyBoxArray[3][4] = 44512509
$emptyBoxArray[3][5] = 1337076465

$emptyBoxArray[4][0] = 4237958009
$emptyBoxArray[4][1] = 785913177
$emptyBoxArray[4][2] = 3493863141
$emptyBoxArray[4][3] = 2436638561
$emptyBoxArray[4][4] = 3162909017
$emptyBoxArray[4][5] = 1680282749

$emptyBoxArray[5][0] = 68691921
$emptyBoxArray[5][1] = 1997611757
$emptyBoxArray[5][2] = 3033143753
$emptyBoxArray[5][3] = 1685657849
$emptyBoxArray[5][4] = 2555514157
$emptyBoxArray[5][5] = 4247850705

$emptyBoxArray[6][0] = 2732531493
$emptyBoxArray[6][1] = 2595823065
$emptyBoxArray[6][2] = 2167345197
$emptyBoxArray[6][3] = 3694859197
$emptyBoxArray[6][4] = 2915963641
$emptyBoxArray[6][5] = 1794380505

$emptyBoxArray[7][0] = 1249123073
$emptyBoxArray[7][1] = 2771523237
$emptyBoxArray[7][2] = 1517623357
$emptyBoxArray[7][3] = 4150142981
$emptyBoxArray[7][4] = 980169437
$emptyBoxArray[7][5] = 4262669041


;检查包裹，得出空余包裹数量
;利用地图功能，先点击占用位置的物品，右击可自动移动到箱子
;再左边鼠标右点击下，如果满了，会自动移动回来
;最后40格全部移动后，
;检查数量，是否和移动前一样



Func mapmoveNew()
	MouseMove(370 + Random(1, 20, 1), 300 + Random(1, 50, 1))
	mapInitialBagCheck() ;初始化，获取包裹的数组空间
	
	$firstbagCount = mapgetbagLocation() ;获取包裹的剩余空间
	TrayTip("", "移动前包裹空间: " & $firstbagCount, 1, 16)
	Sleep(500)
	;---------
	
	$boxisfull = 0 ; 初始化为 0
	For $j = 0 To 3 Step 1
		For $i = 0 To 8 Step 1 ;---最右边一列不移动
			If $cmpArray[$j][$i] = 1 Then
				TrayTip("", "移动中包裹空间: " & $j & " " & $i, 1, 16)
				MouseMove(370 + Random(1, 20, 1), 300 + Random(1, 50, 1))
				;GetMapBagFullCompare() ; 获取实时的包裹内的格子颜色值
				$avvArray[$j][$i] = PixelChecksum($xArray[$i][0], $yArray[$j][0], $xArray[$i][1], $yArray[$j][1], $title)
				If $avvArray[$j][$i] <> $emptyArray[$j][$i] Then
					MouseClick("left", $xArray[$i][0], $yArray[$j][0], 1, Random(1, 5, 1))
					Sleep(100)
					rightmoveNew()
				EndIf
			EndIf
		Next
	Next

	mapInitialBagCheck() ;再初始化，得出最后剩余数量
	$lastbagCount = mapgetbagLocation() ;背包剩余数量
	
	If $firstbagCount = $lastbagCount Then
		$boxisfull = 1 ;设置箱子满了，以后主程序就不装箱了
		TrayTip("", "箱子装不下了", 1, 16)
		Sleep(500)
		If $i = 1 And $firstCount <= 6 Then ;如果是第一次循环就放不下了，表示满了
			TrayTip("", "包裹和箱子都差不多满了：", 1, 16)
			Sleep(1000)
		EndIf
	EndIf
	Sleep(1000)
	Send("{ESC}")
	Sleep(200)
EndFunc   ;==>mapmoveNew



Func mapmove()
	mapInitialBagCheck() ;初始化，获取包裹的数组空间
	
	$firstbagCount = mapgetbagLocation() ;获取包裹的剩余空间
	TrayTip("", "移动前包裹空间: " + $firstbagCount, 1, 16)
	Sleep(2000)
	;---------
	
	$boxisfull = 0 ; 初始化为 0
	For $i = 1 To 40 Step 1
		MouseMove(370 + Random(1, 20, 1), 300 + Random(1, 50, 1))
		$firstCount = mapgetbagLocation() ;背包剩余数量
		TrayTip("", "循环次数: " + $firstCount, 1, 16)
		Sleep(500)
		If $firstCount = 40 Then ;如果背包中空了，即不用装箱了
			TrayTip("", "背包已经空了。", 1, 16)
			Sleep(100)
			;Send("{ESC}")
			ExitLoop
		EndIf
		mapmovebagItem()
		;rightmove() ;用鼠标左键移动
		rightmoveNew()
	Next
	mapInitialBagCheck() ;再初始化，得出最后剩余数量
	$lastbagCount = mapgetbagLocation() ;背包剩余数量
	
	If $firstbagCount = $lastbagCount Then
		$boxisfull = 1 ;设置箱子满了，以后主程序就不装箱了
		TrayTip("", "箱子装不下了", 1, 16)
		Sleep(500)
		If $i = 1 And $firstCount <= 6 Then ;如果是第一次循环就放不下了，表示满了
			TrayTip("", "包裹和箱子都差不多满了：", 1, 16)
			Sleep(1000)
		EndIf
	EndIf
	Sleep(1000)
	Send("{ESC}")
	Sleep(200)
EndFunc   ;==>mapmove


Func mapInitialBagCheck()

	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1 ;最右边一列不看
			$itembagCheck[$j][$i] = 1
		Next
	Next
	;增加对列不装箱的格子，比如右起3列 ,有bug，如果一个物品正好站两列，但我只设置放1列
	#CS 	For $j = 0 To 3 Step 1
		For $i = 9 - $notfixbox + 1 To 9 Step 1
		$itembagCheck[$j][$i] = 0
		Next
		Next
	#CE
	
	
EndFunc   ;==>mapInitialBagCheck

Func GetMapBagFullCompare()

	$avvArray[0][0] = PixelChecksum($xArray[0][0], $yArray[0][0], $xArray[0][1], $yArray[0][1], $title) ;   2128286505
	$avvArray[0][1] = PixelChecksum($xArray[1][0], $yArray[0][0], $xArray[1][1], $yArray[0][1], $title) ;680075913
	$avvArray[0][2] = PixelChecksum($xArray[2][0], $yArray[0][0], $xArray[2][1], $yArray[0][1], $title);3532990065
	$avvArray[0][3] = PixelChecksum($xArray[3][0], $yArray[0][0], $xArray[3][1], $yArray[0][1], $title);1702763733
	$avvArray[0][4] = PixelChecksum($xArray[4][0], $yArray[0][0], $xArray[4][1], $yArray[0][1], $title);2781226753
	$avvArray[0][5] = PixelChecksum($xArray[5][0], $yArray[0][0], $xArray[5][1], $yArray[0][1], $title);1869491841
	$avvArray[0][6] = PixelChecksum($xArray[6][0], $yArray[0][0], $xArray[6][1], $yArray[0][1], $title);33630009
	$avvArray[0][7] = PixelChecksum($xArray[7][0], $yArray[0][0], $xArray[7][1], $yArray[0][1], $title);2257654813
	$avvArray[0][8] = PixelChecksum($xArray[8][0], $yArray[0][0], $xArray[8][1], $yArray[0][1], $title);3402240693
	$avvArray[0][9] = PixelChecksum($xArray[9][0], $yArray[0][0], $xArray[9][1], $yArray[0][1], $title);3651934153

	$avvArray[1][0] = PixelChecksum($xArray[0][0], $yArray[1][0], $xArray[0][1], $yArray[1][1], $title); 1643131837
	$avvArray[1][1] = PixelChecksum($xArray[1][0], $yArray[1][0], $xArray[1][1], $yArray[1][1], $title); 4023004801
	$avvArray[1][2] = PixelChecksum($xArray[2][0], $yArray[1][0], $xArray[2][1], $yArray[1][1], $title);1210726313
	$avvArray[1][3] = PixelChecksum($xArray[3][0], $yArray[1][0], $xArray[3][1], $yArray[1][1], $title);1402155425
	$avvArray[1][4] = PixelChecksum($xArray[4][0], $yArray[1][0], $xArray[4][1], $yArray[1][1], $title);3324257933
	$avvArray[1][5] = PixelChecksum($xArray[5][0], $yArray[1][0], $xArray[5][1], $yArray[1][1], $title);1178673873
	$avvArray[1][6] = PixelChecksum($xArray[6][0], $yArray[1][0], $xArray[6][1], $yArray[1][1], $title);1418138221
	$avvArray[1][7] = PixelChecksum($xArray[7][0], $yArray[1][0], $xArray[7][1], $yArray[1][1], $title);3123713197
	$avvArray[1][8] = PixelChecksum($xArray[8][0], $yArray[1][0], $xArray[8][1], $yArray[1][1], $title);4239462497
	$avvArray[1][9] = PixelChecksum($xArray[9][0], $yArray[1][0], $xArray[9][1], $yArray[1][1], $title);262213569


	$avvArray[2][0] = PixelChecksum($xArray[0][0], $yArray[2][0], $xArray[0][1], $yArray[2][1], $title); 2849382445
	$avvArray[2][1] = PixelChecksum($xArray[1][0], $yArray[2][0], $xArray[1][1], $yArray[2][1], $title); 1649753657
	$avvArray[2][2] = PixelChecksum($xArray[2][0], $yArray[2][0], $xArray[2][1], $yArray[2][1], $title); 4055383265
	$avvArray[2][3] = PixelChecksum($xArray[3][0], $yArray[2][0], $xArray[3][1], $yArray[2][1], $title); 2840607369
	$avvArray[2][4] = PixelChecksum($xArray[4][0], $yArray[2][0], $xArray[4][1], $yArray[2][1], $title); 3396610741
	$avvArray[2][5] = PixelChecksum($xArray[5][0], $yArray[2][0], $xArray[5][1], $yArray[2][1], $title); 477177009
	$avvArray[2][6] = PixelChecksum($xArray[6][0], $yArray[2][0], $xArray[6][1], $yArray[2][1], $title); 1108484605
	$avvArray[2][7] = PixelChecksum($xArray[7][0], $yArray[2][0], $xArray[7][1], $yArray[2][1], $title); 3728482849
	$avvArray[2][8] = PixelChecksum($xArray[8][0], $yArray[2][0], $xArray[8][1], $yArray[2][1], $title); 3546356257
	$avvArray[2][9] = PixelChecksum($xArray[9][0], $yArray[2][0], $xArray[9][1], $yArray[2][1], $title); 786963093


	$avvArray[3][0] = PixelChecksum($xArray[0][0], $yArray[3][0], $xArray[0][1], $yArray[3][1], $title);4170659101
	$avvArray[3][1] = PixelChecksum($xArray[1][0], $yArray[3][0], $xArray[1][1], $yArray[3][1], $title);2377405565
	$avvArray[3][2] = PixelChecksum($xArray[2][0], $yArray[3][0], $xArray[2][1], $yArray[3][1], $title);751582593
	$avvArray[3][3] = PixelChecksum($xArray[3][0], $yArray[3][0], $xArray[3][1], $yArray[3][1], $title);1710831477
	$avvArray[3][4] = PixelChecksum($xArray[4][0], $yArray[3][0], $xArray[4][1], $yArray[3][1], $title);1604531761
	$avvArray[3][5] = PixelChecksum($xArray[5][0], $yArray[3][0], $xArray[5][1], $yArray[3][1], $title);1116753093
	$avvArray[3][6] = PixelChecksum($xArray[6][0], $yArray[3][0], $xArray[6][1], $yArray[3][1], $title);1294093305
	$avvArray[3][7] = PixelChecksum($xArray[7][0], $yArray[3][0], $xArray[7][1], $yArray[3][1], $title);3129229389
	$avvArray[3][8] = PixelChecksum($xArray[8][0], $yArray[3][0], $xArray[8][1], $yArray[3][1], $title);1964844249
	$avvArray[3][9] = PixelChecksum($xArray[9][0], $yArray[3][0], $xArray[9][1], $yArray[3][1], $title);3822594909

EndFunc   ;==>GetMapBagFullCompare
;_ArrayDisplay($avArray, "$avArray 原先的数据 _ArrayAdd()")


;$bagEmptyCount=0
;$bagfullCount =0
;Local $bagfullrepeat = 0  ; 定义一个格子重复有的次数

Func mapgetbagLocation()
	$bagfullCount = 0 ;已满的数量
	$bagEmptyCount = 0 ;空格的数量
	
	GetMapBagFullCompare() ; 获取实时的包裹内的格子颜色值
	
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			$cmpArray[$j][$i] = "" ;先设置为空
			If $avvArray[$j][$i] <> $emptyArray[$j][$i] And $itembagCheck[$j][$i] = 1 Then
				$cmpArray[$j][$i] = 1
				$bagfullCount = $bagfullCount + 1
			EndIf
		Next
	Next
	$bagEmptyCount = 40 - $bagfullCount
	TrayTip("", "背包空数量：" & $bagEmptyCount, 1, 16)
	Sleep(1000)
	Return $bagEmptyCount
	;MsgBox(0,"",$bagEmptyCount & "格剩余" )
	;_ArrayDisplay($cmpArray, "$avArray 添加后的数据 _ArrayAdd()")

EndFunc   ;==>mapgetbagLocation

Func mapmovebagItem()
	TrayTip("", "移动物品检查", 1, 16)
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1 ;---最右边一列不移动
			If $cmpArray[$j][$i] = 1 Then
				$itembagCheck[$j][$i] = 0
				$itembaglocation[0][0] = $xArray[$i][0] ;记录物品的初始位置
				$itembaglocation[0][1] = $yArray[$j][0]
				
				$itembaglocationxy[0][0] = $i ;记录物品的初始位置的 坐标
				$itembaglocationxy[0][1] = $j ;记录物品的初始位置的 坐标
				
				;MouseMove($xArray[$i][0], $yArray[$j][0])
				;Sleep(2000)
				;_ArrayDisplay($itembaglocation, "$avArray 添加后的数据 _ArrayAdd()")
				MouseClick("left", $xArray[$i][0], $yArray[$j][0], 1, Random(1, 5, 1))
				Sleep(100)
				;MouseMove(500, 200)
				ExitLoop 2
			EndIf
		Next
	Next
	
EndFunc   ;==>mapmovebagItem


Func rightmove()
	;MouseClick("right", 500, 200, 2);  先移动到左边物品栏上方，然后右点击，借助地图功能，移动物品
	MouseMove(550 + Random(1, 10, 1), 480 + Random(1, 20, 1), 0)
	Sleep(1000)
	MouseClick("right", Default, Default, 2)
	Sleep(1000)
	MouseMove(300 + Random(1, 10, 1), 500 + Random(1, 20, 1), 0)
	Sleep(1000)
	MouseClick("right", Default, Default, 2);  此时移动到左边,有点击,防止仓库满了,把东西返回原样,放入包裹
	Sleep(1000)
EndFunc   ;==>rightmove

Func rightmoveNew() ;通过判断 仓库整个画面的模式
	;MouseClick("right", 500, 200, 2);  先移动到左边物品栏上方，然后右点击，借助地图功能，移动物品
	$first = PixelChecksum(160, 150, 320, 370, $title)
	;MouseClick("right", Default, Default, Random(1, 3, 1))
	MouseClick("right", 420 + Random(1, 50, 1), 330 + Random(1, 80, 1), Random(1, 3, 1))
	Sleep(500)
	$last = PixelChecksum(160, 150, 320, 370, $title)
	If $first = $last Then ;如果相等，表示这个物品没放得进去
		MouseMove(300 + Random(1, 10, 1), 500 + Random(1, 20, 1), 0)
		Sleep(200)
		MouseClick("right", Default, Default, Random(1, 3, 1), 0);  此时移动到左边,有点击,防止仓库满了,把东西返回原样,放入包裹
		Sleep(200)
	EndIf


EndFunc   ;==>rightmoveNew


