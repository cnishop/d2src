#include <Array.au3>

AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
;#include <fireMethord.au3>


$title = "d2"


; 得到包括 "this one" 内容的记事本窗口的句柄
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
Sleep(1000)
; ---------------------- 425, 320, 705, 430 bag area
;~     1,1 x:  425, 440   yTop: 320
;~ 	   1,2 x   450, 470
;~ 1,3   480 500
;~ 1,4 510 530
;~ 1,5 540 560
;~ 1,6 570 590
;~  1,7 600 615
;~ 1,8  630 645
;~ 1,9 660 675
;~ 1,10 685 700
; top:
;1: 320 340
;~ 2 350 370
;~ 3 380 400
;~ 4 410 430
#CS
	;~     第一行
	;~  (425,320,440,340)  1
	450,320,470,340
	480,320,500,340
	510,320,530,340
	540,320,560,340
	570,320,590,340
	600,320,615,340
	630,320,645,340
	660,320,675,340
	685,320,700,340
	;~     第二行
	425,350,440,370  2
	450,350,470,370
	480,350,500,370
	510,350,530,370
	540,350,560,370
	570,350,590,370
	600,350,615,370
	630,350,645,370
	660,350,675,370
	685,350,700,370
	;~     第二行
	425,380,440,400)  3
	450,380,470,400
	480,380,500,400
	510,380,530,400
	540,380,560,400
	570,380,590,400
	600,380,615,400
	630,380,645,400
	660,380,675,400
	685,380,700,400
	;~     第二行
	425,410,440,430)  4
	450,410,470,430
	480,410,500,430
	510,410,530,430
	540,410,560,430
	570,410,590,430
	600,410,615,430
	630,410,645,430
	660,410,675,430
	685,410,700,430
	
#CE
;~     160 , 175     x
;~        190 205
;~ 220 235
;~ 245  260
;~ 275 290
;~ 305 320
;~         y

;~   150 165
;~ 180 195
;~ 201 225
;~ 235 255
;~ 265 285
;~ 295 310
;~ 325 340
;~ 350 370
;MouseMove(50, 50)




Global $bagEmptyCount
Global $allfull ;记录箱子和包裹都满了
Global $boxnotfix = 0 ;记录box放不下了
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
Local $itembaglocation[1][2]
Local $findsame


Global $boxEmptyCount
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


movebagtoBox()
;checkzise()

Func movebagtoBox()
	For $i = 1 To 40 Step 1
		MouseMove(50, 50)
		TrayTip("", "检查包裹里面的物品", 1, 16)
		$firstCount = getbagLocation()

		$firstcmpArray = $cmpArray
		getItemSize()
		$lastcmpArray = $cmpArray
		;_ArrayDisplay($firstcmpArray, "$avArray 原先的数据 _ArrayAdd()")
		;_ArrayDisplay($lastcmpArray, "$avArray 原先的数据 _ArrayAdd()")
		writeitemSize()
		getboxLocation()
		moveboxItem($i)
		If $boxnotfix = 1 Then
			TrayTip("", "箱子装不下了", 1, 16)
			Sleep(1000)
			ExitLoop
		EndIf

		Sleep(10)
	Next
EndFunc   ;==>movebagtoBox

Func bagfullcompare()

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

EndFunc   ;==>bagfullcompare
;_ArrayDisplay($avArray, "$avArray 原先的数据 _ArrayAdd()")


Func boxfullcompare()
	$avvBoxArray[0][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[0][0], $xBoxArray[0][1], $yBoxArray[0][1], $title);
	$avvBoxArray[0][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[0][0], $xBoxArray[1][1], $yBoxArray[0][1], $title);
	$avvBoxArray[0][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[0][0], $xBoxArray[2][1], $yBoxArray[0][1], $title);
	$avvBoxArray[0][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[0][0], $xBoxArray[3][1], $yBoxArray[0][1], $title);
	$avvBoxArray[0][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[0][0], $xBoxArray[4][1], $yBoxArray[0][1], $title);
	$avvBoxArray[0][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[0][0], $xBoxArray[5][1], $yBoxArray[0][1], $title);


	$avvBoxArray[1][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[1][0], $xBoxArray[0][1], $yBoxArray[1][1], $title);
	$avvBoxArray[1][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[1][0], $xBoxArray[1][1], $yBoxArray[1][1], $title);
	$avvBoxArray[1][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[1][0], $xBoxArray[2][1], $yBoxArray[1][1], $title);
	$avvBoxArray[1][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[1][0], $xBoxArray[3][1], $yBoxArray[1][1], $title);
	$avvBoxArray[1][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[1][0], $xBoxArray[4][1], $yBoxArray[1][1], $title);
	$avvBoxArray[1][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[1][0], $xBoxArray[5][1], $yBoxArray[1][1], $title);


	$avvBoxArray[2][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[2][0], $xBoxArray[0][1], $yBoxArray[2][1], $title);
	$avvBoxArray[2][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[2][0], $xBoxArray[1][1], $yBoxArray[2][1], $title);
	$avvBoxArray[2][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[2][0], $xBoxArray[2][1], $yBoxArray[2][1], $title);
	$avvBoxArray[2][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[2][0], $xBoxArray[3][1], $yBoxArray[2][1], $title);
	$avvBoxArray[2][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[2][0], $xBoxArray[4][1], $yBoxArray[2][1], $title);
	$avvBoxArray[2][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[2][0], $xBoxArray[5][1], $yBoxArray[2][1], $title);


	$avvBoxArray[3][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[3][0], $xBoxArray[0][1], $yBoxArray[3][1], $title);
	$avvBoxArray[3][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[3][0], $xBoxArray[1][1], $yBoxArray[3][1], $title);
	$avvBoxArray[3][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[3][0], $xBoxArray[2][1], $yBoxArray[3][1], $title);
	$avvBoxArray[3][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[3][0], $xBoxArray[3][1], $yBoxArray[3][1], $title);
	$avvBoxArray[3][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[3][0], $xBoxArray[4][1], $yBoxArray[3][1], $title);
	$avvBoxArray[3][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[3][0], $xBoxArray[5][1], $yBoxArray[3][1], $title);


	$avvBoxArray[4][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[4][0], $xBoxArray[0][1], $yBoxArray[4][1], $title);
	$avvBoxArray[4][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[4][0], $xBoxArray[1][1], $yBoxArray[4][1], $title);
	$avvBoxArray[4][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[4][0], $xBoxArray[2][1], $yBoxArray[4][1], $title);
	$avvBoxArray[4][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[4][0], $xBoxArray[3][1], $yBoxArray[4][1], $title);
	$avvBoxArray[4][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[4][0], $xBoxArray[4][1], $yBoxArray[4][1], $title);
	$avvBoxArray[4][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[4][0], $xBoxArray[5][1], $yBoxArray[4][1], $title);


	$avvBoxArray[5][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[5][0], $xBoxArray[0][1], $yBoxArray[5][1], $title);
	$avvBoxArray[5][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[5][0], $xBoxArray[1][1], $yBoxArray[5][1], $title);
	$avvBoxArray[5][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[5][0], $xBoxArray[2][1], $yBoxArray[5][1], $title);
	$avvBoxArray[5][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[5][0], $xBoxArray[3][1], $yBoxArray[5][1], $title);
	$avvBoxArray[5][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[5][0], $xBoxArray[4][1], $yBoxArray[5][1], $title);
	$avvBoxArray[5][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[5][0], $xBoxArray[5][1], $yBoxArray[5][1], $title);


	$avvBoxArray[6][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[6][0], $xBoxArray[0][1], $yBoxArray[6][1], $title);
	$avvBoxArray[6][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[6][0], $xBoxArray[1][1], $yBoxArray[6][1], $title);
	$avvBoxArray[6][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[6][0], $xBoxArray[2][1], $yBoxArray[6][1], $title);
	$avvBoxArray[6][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[6][0], $xBoxArray[3][1], $yBoxArray[6][1], $title);
	$avvBoxArray[6][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[6][0], $xBoxArray[4][1], $yBoxArray[6][1], $title);
	$avvBoxArray[6][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[6][0], $xBoxArray[5][1], $yBoxArray[6][1], $title);


	$avvBoxArray[7][0] = PixelChecksum($xBoxArray[0][0], $yBoxArray[7][0], $xBoxArray[0][1], $yBoxArray[7][1], $title);
	$avvBoxArray[7][1] = PixelChecksum($xBoxArray[1][0], $yBoxArray[7][0], $xBoxArray[1][1], $yBoxArray[7][1], $title);
	$avvBoxArray[7][2] = PixelChecksum($xBoxArray[2][0], $yBoxArray[7][0], $xBoxArray[2][1], $yBoxArray[7][1], $title);
	$avvBoxArray[7][3] = PixelChecksum($xBoxArray[3][0], $yBoxArray[7][0], $xBoxArray[3][1], $yBoxArray[7][1], $title);
	$avvBoxArray[7][4] = PixelChecksum($xBoxArray[4][0], $yBoxArray[7][0], $xBoxArray[4][1], $yBoxArray[7][1], $title);
	$avvBoxArray[7][5] = PixelChecksum($xBoxArray[5][0], $yBoxArray[7][0], $xBoxArray[5][1], $yBoxArray[7][1], $title);



	;_ArrayDisplay($avvBoxArray, "$avArray 原先的数据 _ArrayAdd()")

EndFunc   ;==>boxfullcompare

;$bagEmptyCount=0
;$bagfullCount =0

Func getbagLocation()
	$bagfullCount = 0
	$bagEmptyCount = 0
	
	bagfullcompare() ;compare
	
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			$cmpArray[$j][$i] = "" ;先设置为空
			If $avvArray[$j][$i] <> $emptyArray[$j][$i] Then
				;_ArrayAdd($cmpArray, $j +1 & "行"& $i +1 & "列")
				$cmpArray[$j][$i] = 1
				$bagfullCount = $bagfullCount + 1
			EndIf
		Next
	Next
	$bagEmptyCount = 40 - $bagfullCount
	TrayTip("", "背包剩余数量：" & $bagEmptyCount, 1, 16)
	Sleep(500)
	Return $bagEmptyCount
	;MsgBox(0,"",$bagEmptyCount & "格剩余" )
	;_ArrayDisplay($cmpArray, "$avArray 添加后的数据 _ArrayAdd()")

EndFunc   ;==>getbagLocation

Func movebagItem()
	TrayTip("", "移动物品检查", 1, 16)
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			If $cmpArray[$j][$i] = 1 Then
				$itembaglocation[0][0] = $xArray[$i][0] ;记录物品的初始位置
				$itembaglocation[0][1] = $yArray[$j][0]
				;MouseMove($xArray[$i][0], $yArray[$j][0])
				;Sleep(2000)
				;_ArrayDisplay($itembaglocation, "$avArray 添加后的数据 _ArrayAdd()")
				MouseClick("left", $xArray[$i][0], $yArray[$j][0], 1)
				Sleep(200)
				MouseMove(500, 200)
				ExitLoop 2
			EndIf
		Next
	Next
	
EndFunc   ;==>movebagItem

Func getItemSize()
	movebagItem()
	Sleep(200)
	$lastCount = getbagLocation()
	$itemSize = $lastCount - $firstCount
	TrayTip("", "物品占用格数：" & $itemSize, 1, 16)
	Sleep(1000)
EndFunc   ;==>getItemSize

Func getboxLocation()
	$boxfullCount = 0
	$boxEmptyCount = 0
	
	boxfullcompare() ;compare
	For $j = 0 To 7 Step 1
		For $i = 0 To 5 Step 1
			If $avvBoxArray[$j][$i] <> $emptyBoxArray[$j][$i] Then
				;_ArrayAdd($cmpArray, $j +1 & "行"& $i +1 & "列")
				$cmpBoxArray[$j][$i] = 1
				$boxfullCount = $boxfullCount + 1
			EndIf
		Next
	Next
;~ 	把$cmpBoxArray 超过部分的内容都设置为 1
	For $j = 0 To 7 Step 1
		For $i = 6 To 6 Step 1
			$cmpBoxArray[$j][$i] = 1
		Next
	Next
	For $j = 8 To 10 Step 1
		For $i = 0 To 6 Step 1
			$cmpBoxArray[$j][$i] = 1
		Next
	Next

	
	
	
	$boxEmptyCount = 48 - $boxfullCount
	TrayTip("", "仓库剩余数量：" & $boxEmptyCount, 1, 16)
	Sleep(2000)
	
	;MsgBox(0,"",$bagEmptyCount & "格剩余" )
	;_ArrayDisplay($cmpBoxArray, "$avArray 添加后的数据 _ArrayAdd()")
	Return $boxEmptyCount

EndFunc   ;==>getboxLocation

Func moveboxItem($count)
	Dim $presize
	TrayTip("", "准备移动到仓库", 1, 16)
	$findsame = False
	
	For $j = 0 To 7 Step 1
		For $i = 0 To 5 Step 1
			If $cmpBoxArray[$j][$i] = 0 Then
				;MouseClick("left", $xBoxArray[$i][0], $yBoxArray[$j][0], 1)
				;下面判断 box范围是否满足物品
				$presize = 0
				For $x = 0 To $xlength - 1 Step 1
					For $y = 0 To $ylength - 1 Step 1
						If $cmpBoxArray[$j + $y][$i + $x] = 0 Then ;水平方向物品最多才2位 ，如果水平宽度满足，则判断高度
							$presize = $presize + 1
						EndIf
					Next
				Next
				TrayTip("", "仓库中合适的可用格数：" & $presize, 1, 16)
				Sleep(500)
				If $presize = $itemSize Then
					MouseMove($xBoxArray[$i][0] + ($xlength - 1) * 15, $yBoxArray[$j][0] + ($ylength - 1) * 15)
					Sleep(200)
					MouseClick("left", Default, Default, 1)
					Sleep(200)
					$findsame = True
					ExitLoop 2
				Else
					$findsame = False
				EndIf
			EndIf
		Next
	Next
	
	If $findsame = False Then
		;如果搜索到最后还是没有匹配的
		;MouseMove($itembaglocation[0][0] , $itembaglocation[0][1] )
		
		MouseMove($itembaglocation[0][0] + ($xlength - 1) * 15, $itembaglocation[0][1] + ($ylength - 1) * 15)
		Sleep(200)
		MouseClick("left", Default, Default, 1)
		Sleep(100)
		TrayTip("", "大箱子放不下这东西了：", 1, 16)
		$boxnotfix = 1
		If $count = 1 Then ;如果是第一次循环就放不下了，表示满了
			$allfull = True
		EndIf
		Sleep(1000)
		
	EndIf

EndFunc   ;==>moveboxItem



Func writeitemSize()
	Dim $xbeg, $xmid, $ybeg, $ymid
	$xbeg = -1
	$ybeg = -1
	$xmid = 0
	$ymid = 0
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			If $firstcmpArray[$j][$i] <> $lastcmpArray[$j][$i] Then
				If $xbeg < $i Then
					$xmid = $xmid + 1
					$xbeg = $i
				EndIf
				If $ybeg < $j Then
					$ymid = $ymid + 1
					$ybeg = $j
				EndIf
			EndIf
		Next
	Next
	$xlength = $xmid
	$ylength = $ymid
	TrayTip("", "物品宽度：" & $xlength & " 物品高度：" & $ylength, 1, 16)
	Sleep(1000)
EndFunc   ;==>writeitemSize


Func checkzise()
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			$coord = PixelSearch($xArray[$i][0], $yArray[$j][0], $xArray[$i][1], $yArray[$j][1], 0x682070, 10, 1, $title) ; 在背包空间范围内查找
			If Not @error Then
				;MouseClick("right", $coord[0], $coord[1], 1);
				MouseMove($coord[0], $coord[1])
				Sleep(200)
			EndIf
		Next
	Next
EndFunc   ;==>checkzise

#CS
	[0]|2128286505|680075913|3532990065|1702763733|2781226753|1869491841|33630009|2257654813|3402240693|3651934153
	[1]|1643131837|4023004801|1210726313|1402155425|3324257933|1178673873|1418138221|3123713197|4239462497|262213569
	[2]|2849382445|1649753657|4055383265|2840607369|3396610741|477177009|1108484605|3728482849|3546356257|786963093
	[3]|4170659101|2377405565|751582593|1710831477|1604531761|1116753093|1294093305|3129229389|1964844249|3822594909
	
	
	
	
	
	
#CE












Exit

$var = PixelGetColor(500, 280) ;646464
MsgBox(0, "", Hex($var, 6))
Sleep(50)




;takefire(1)

Func takefire($var = 1)
	Select
		Case $var = 1
			icesor()
		Case $var = 2
			firesor()
		Case Else
			fireicesor()
	EndSelect
EndFunc   ;==>takefire


Func icesor()
	
	Sleep(50)
	For $i = 1 To 3 Step 1
		Send("{F2}") ;攻击技能
		MouseClick("right", 560 - $i * 15, 140 + $i * 10, 1)
		addBloodtorole()
		Sleep(100)
		Send("{LSHIFT down}") ;攻击技能
		Sleep(100)
		For $j = 1 To 5
			MouseClick("left", 560 - $i * 15, 140 + $i * 10, 1)
			Sleep(150)
		Next
		Sleep(800)
		Send("{LSHIFT up}") ;攻击技能
	Next




EndFunc   ;==>icesor

Func firesor()
	Send("{F2}") ;攻击技能
	For $i = 1 To 20 Step 1
		addBloodtorole()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(100)
		MouseClick("right", 540, 200, 1, 0)
		Sleep(100)
	Next

EndFunc   ;==>firesor

Func fireicesor()
	Send("{F2}") ;攻击技能
	For $i = 1 To 20 Step 1
		addBloodtorole()
		MouseClick("right", 540, 120, 1, 0)
		Sleep(100)
		MouseClick("right", 560, 160, 1, 0)
		Sleep(100)
		MouseClick("right", 590, 100, 1, 0)
		Sleep(100)
	Next

	Send("{F3}") ;攻击技能
	For $i = 1 To 3 Step 1
		addBloodtorole()
		MouseClick("right", 540, 140, 1, 0)
		Sleep(1000)
	Next

EndFunc   ;==>fireicesor
#CS
	MouseMove(290, 510)  ;2C2C2C
	MouseMove(290, 560) ;2C2C2C
#CE

;MouseMove(360, 430) ;585048


; findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858")

; If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
;WinMove($title, "", 0, 0)

#CS
	MouseMove(460, 380) ;040404
	
	MouseMove(500, 380) ;040404
	MouseMove(540, 380) ;040404
	MouseMove(580, 380) ;040404
	MouseMove(610, 380) ;040404
#CE
;MouseMove(460, 250) ;242424  没带手套的颜色
;MouseMove(505, 250) ;040404  没带戒指的颜色
;MouseMove(690, 250) ;282828  没带鞋子的颜色
;包裹中4角的位置
;MouseMove(420, 320)
;MouseMove(705, 320)
;MouseMove(420, 430)
;MouseMove(705, 430)
;Exit 0

;blood positon
;MouseMove(420, 565)
;MouseMove(450, 565)    第一个红窗
;MouseMove(455, 565)
;MouseMove(480, 565)   ; 第2个红窗口
;MouseMove(485, 565)
;MouseMove(510, 565)   ; 第3个红窗口
;MouseMove(515, 565)
;MouseMove(540, 565)   ; 第4个红窗口

;MouseMove(540, 590)       3444B0 普通红    0x682070
;Sleep(10)
;Exit
#CS
	
#CE
#CS
	$coord = PixelSearch(0, 0 ,800, 590, 0x285074, 20, 1, $title) ; 在背包空间范围内查找
	If Not @error Then
	;MouseClick("right", $coord[0], $coord[1], 1);
	MouseMove($coord[0], $coord[1]+100)
	Sleep(200)
	EndIf
	
#CE
;addBloodtorole()
;drinksurplusrev()
Func drinksurplusrev() ;去掉多余的瞬间回复血瓶,省得占用空间
	For $i = 1 To 3 Step 1
		$coord = PixelSearch(420, 565, 540, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
		If Not @error Then
			;MouseClick("right", $coord[0], $coord[1], 1);
			MouseMove($coord[0], $coord[1])
			Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev


Func finditem()
	;Send("{ALT down}")
	MouseMove(460, 340)
	Sleep(200)
	For $i = 1 To 5 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x102404, 20, 1)
		If Not @error Then
			TrayTip($i, $coord[0] & "" & $coord[1], 1)
			Sleep(300)
			MouseMove($coord[0], $coord[1])
			;MouseClick("left", $coord[0], $coord[1]+5,1)
			Sleep(1000)
		EndIf
		Sleep(100)
	Next
	;Send("{ALT up}")
EndFunc   ;==>finditem

Exit 0
Func findpath($pathNumber)
	Select
		Case $pathNumber = 1
			MouseClick("left", 310, 530, 1)
			Sleep(1800)
			MouseClick("left", 700, 480, 1)
			Sleep(1800)
			MouseClick("left", 110, 460, 1)
			Sleep(1400)
			MouseClick("left", 60, 460, 1)
			Sleep(1500)
			MouseClick("left", 40, 460, 1)
			Sleep(1600)
			MouseClick("left", 40, 280, 1)
			Sleep(1400)
		Case $pathNumber = 2
			MouseClick("left", 60, 250, 1)
			Sleep(1500)
			MouseClick("left", 40, 250, 1)
			Sleep(1800)
			MouseClick("left", 180, 480, 1)
			Sleep(1400)
			MouseClick("left", 180, 480, 1)
			Sleep(1400)
			MouseClick("left", 100, 450, 1)
			Sleep(1400)
			MouseClick("left", 220, 500, 1)
			Sleep(1400)
			MouseClick("left", 600, 420, 1)
			Sleep(1400)
			MouseClick("left", 700, 400, 1)
			Sleep(1400)
		Case $pathNumber = 3
			MouseClick("left", 200, 500, 1)
			Sleep(1500)
			MouseClick("left", 750, 430, 1)
			Sleep(1800)
			MouseClick("left", 380, 480, 1)
			Sleep(1400)
			MouseClick("left", 100, 350, 1)
			Sleep(1400)
			MouseClick("left", 130, 470, 1)
			Sleep(1400)
			MouseClick("left", 50, 430, 1)
			Sleep(1400)
			MouseClick("left", 65, 280, 1)
			Sleep(1400)
		Case Else
	EndSelect
EndFunc   ;==>findpath



#CS 		If findAreaColor(420, 320, 705, 430, 0x682070, 10, 1, $title) Then
	
	
	Else ;开始建立房间
	
	EndIf
#CE

;isInRoom()
#CS 			For $k =100 To 620 Step 1
	For $j = 150 To 520 Step 4
	MouseMove($k,$j,1)
	finddoor()
	Next
	Next
#CE


Func finddoor() ;找红门的程序
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(100)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 100
	$top = 100
	$right = 400
	$bottom = 400
	;Sleep(1000)
	;TrayTip("", "开始寻找红门.", 1)
	If findredDoor($left, $top, $right, $bottom) Then
		TrayTip("", "找到红门并进入！.", 1, 16)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>finddoor
Func findredDoor($left, $top, $right, $bottom)
	$exit = False
	$errorexit = False
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Return True
		If getRightPoint($x, $y) Then
			;MouseMove($x, $y)
			Sleep(1000)
			Return True
			;MsgBox(0, "", "right")
		Else
			For $k = $left To $right Step 100
				For $j = $top To $bottom Step 100
					;MsgBox(0,"","查找中")
					;TrayTip("", "查询坐标." & $k & "" & $j, 1)
					If findNext($k, $j, $right, $bottom) Then
						;MsgBox(0, "", "查找下一个")
						;TrayTip("", "找到了一个红门！.", 1, 16)
						;MouseMove($k, $j)
						;MouseClick("left", $k, $j, 1)
						;AAA()
						$exit = True
						ExitLoop
					EndIf
					;MsgBox(0, "", "查找：" & $k & "" & $j)
					If $k >= $right And $j >= $bottom Then
						;MsgBox(0, "", "error")
						TrayTip("", "寻找红门失败，退出.", 5, 16)
						$errorexit = True
						ExitLoop
					EndIf
				Next
				If $exit = True Then
					ExitLoop
				EndIf
				If $errorexit = True Then
					ExitLoop
				EndIf
			Next
			If $exit = True Then
				Return True
			EndIf
			If $errorexit = True Then
				;exitRoom()
				Return False
			EndIf
			
			
		EndIf
	Else
		;MsgBox(0, "", "没有一个白点") 如果一个白点没找到，可能是没到红门的位置，退出游戏重来
		TrayTip("", "没有找到很合红门标志.", 1, 16)
		Sleep(400)
		;exitRoom()
		Return False
	EndIf
EndFunc   ;==>findredDoor
Func findNext($left, $top, $right, $bottom)
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		Return getRightPoint($x, $y)
	Else
		Return False
	EndIf
EndFunc   ;==>findNext
Func getRightPoint($xx, $yy)
	;TrayTip("", "找大于20个颜色的点.", 1)
	$total = 0
	For $i = -5 To 85 Step 1
		For $j = -5 To 105 Step 1
			$var = PixelGetColor($xx + $i, $yy + $j)
			If Hex($var, 6) = "FFFFFF" Then
				$total = $total + 1
			EndIf
			;TrayTip($i, $j , 1)
		Next
	Next
	TrayTip("", $total, 1)
	
	If $total >= 200 Then
		MouseMove($xx, $yy)
		;MouseClick("left", $xx, $yy, 1)
		Sleep(500)
		;TrayTip("", "total为：" & $total, 1)
		Return True
		;ElseIf  $total >= 15 Then
		; Return True
	Else
		;TrayTip("", "total为：" & $total, 1)
		Return False
	EndIf
EndFunc   ;==>getRightPoint

Func findAreaColor($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	$coord = PixelSearch($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	If Not @error Then
		MouseMove($coord[0], $coord[1])
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findAreaColor
Func findPointColor($x, $y, $color)
	$var = PixelGetColor($x, $y)
	If Hex($var, 6) = $color Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findPointColor

Func addBloodtorole()
	If findPointColor(70, 530, "5C0000") = False Then
		$drink = 0
		For $i = 1 To 4 Step 1
			;MouseMove(420, 565)
			;MouseMove(450, 565)    第一个红窗
			;MouseMove(455, 565)
			;MouseMove(480, 565)   ; 第2个红窗口
			;MouseMove(485, 565)
			;MouseMove(510, 565)   ; 第3个红窗口
			;MouseMove(515, 565)
			;MouseMove(540, 565)   ; 第4个红窗口
			Select
				Case $i = 1 And $drink = 0
					$coord = PixelSearch(420, 565, 450, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
					If Not @error Then
						;MouseClick("right", $coord[0], $coord[1], 1);
						Send("{1}")
						$drink = 1
					EndIf
				Case $i = 2 And $drink = 0
					$coord = PixelSearch(455, 565, 480, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
					If Not @error Then
						;MouseClick("right", $coord[0], $coord[1], 1);
						Send("{2}")
						$drink = 1
					EndIf
				Case $i = 3 And $drink = 0
					$coord = PixelSearch(485, 565, 510, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
					If Not @error Then
						;MouseClick("right", $coord[0], $coord[1], 1);
						Send("{3}")
						$drink = 1
					EndIf
				Case $i = 4 And $drink = 0
					$coord = PixelSearch(515, 565, 540, 590, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
					If Not @error Then
						;MouseClick("right", $coord[0], $coord[1], 1);
						Send("{4}")
						$drink = 1
					EndIf
			EndSelect
		Next
		If $drink = 0 Then
			Send("{1}")
		EndIf
	EndIf
EndFunc   ;==>addBloodtorole


