AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
AutoItSetOption("MouseClickDelay", 1)

Local $notfixbox  ;  ���ð�������

Global $bagEmptyCount ;����ʣ������
;Global $allfull ;��¼���ӺͰ���������
Global $boxisfull = 0 ;��¼box�Ų�����
Local $bagfullCount
Local $xArray[9][2] ;x
Local $yArray[4][2] ;x
Local $emptyArray[4][9] ;original array -bag
Local $avvArray[4][9]
Local $cmpArray[4][9]
Local $firstcmpArray[4][9] ;�ƶ�ǰ�������Ĳ���
Local $lastcmpArray[4][9] ;�ƶ���������Ĳ���
Local $itemSizeArray[2][8] ;��¼��Ʒ��״
Local $xlength
Local $ylength
Local $firstCount
Local $lastCount
Local $itemSize ;item_size
Local $itembaglocation[1][2] ;��¼��������Ʒ�ĵص�
Local $itembaglocationxy[1][2] ;��¼��������Ʒ�ĵص�����к� x ��y   ;���ڼ�¼�Ƿ����װ�����
Local $itembagCheck[4][9] ;�ж��Ƿ��鱳���������



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
;$xArray[9][0] = 685
;$xArray[9][1] = 700

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
;$emptyArray[0][9] = 3651934153

$emptyArray[1][0] = 1643131837
$emptyArray[1][1] = 4023004801
$emptyArray[1][2] = 1210726313
$emptyArray[1][3] = 1402155425
$emptyArray[1][4] = 3324257933
$emptyArray[1][5] = 1178673873
$emptyArray[1][6] = 1418138221
$emptyArray[1][7] = 3123713197
$emptyArray[1][8] = 4239462497
;$emptyArray[1][9] = 262213569


$emptyArray[2][0] = 2849382445
$emptyArray[2][1] = 1649753657
$emptyArray[2][2] = 4055383265
$emptyArray[2][3] = 2840607369
$emptyArray[2][4] = 3396610741
$emptyArray[2][5] = 477177009
$emptyArray[2][6] = 1108484605
$emptyArray[2][7] = 3728482849
$emptyArray[2][8] = 3546356257
;$emptyArray[2][9] = 786963093


$emptyArray[3][0] = 4170659101
$emptyArray[3][1] = 2377405565
$emptyArray[3][2] = 751582593
$emptyArray[3][3] = 1710831477
$emptyArray[3][4] = 1604531761
$emptyArray[3][5] = 1116753093
$emptyArray[3][6] = 1294093305
$emptyArray[3][7] = 3129229389
$emptyArray[3][8] = 1964844249
;$emptyArray[3][9] = 3822594909


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



Func InitialBagCheck()

	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			$itembagCheck[$j][$i] = 1
		Next
	Next
	;���Ӷ��в�װ��ĸ��ӣ���������3�� ,��bug�����һ����Ʒ����վ���У�����ֻ���÷�1��
#CS 	For $j = 0 To 3 Step 1
   		For $i = 9 - $notfixbox + 1 To 9 Step 1
   			$itembagCheck[$j][$i] = 0
   		Next
   	Next
#CE
	
	
EndFunc   ;==>InitialBagCheck

;movebagtoBox()
;checkzise()

Func movebagtoBox()
	;----------������Ĭ�ϵ�
	
	;---------
	
	$boxisfull = 0 ; ��ʼ��Ϊ 0
	For $i = 1 To 40 Step 1
		MouseMove(380, 300)
		TrayTip("", "�������������Ʒ", 1, 16)
		$firstCount = getbagLocation() ;����ʣ������
		If $firstCount = 36 Then ;��������п��ˣ�������װ����
			TrayTip("", "�����Ѿ����ˡ�", 1, 16)
			Sleep(100)
			Send("{ESC}")
			ExitLoop
		EndIf
		$firstcmpArray = $cmpArray
		getItemSize()
		$lastcmpArray = $cmpArray
		;_ArrayDisplay($firstcmpArray, "$avArray ԭ�ȵ����� _ArrayAdd()")
		;_ArrayDisplay($lastcmpArray, "$avArray ԭ�ȵ����� _ArrayAdd()")
		writeitemSize() ;ȡ����Ʒ�ĳ���
		getboxLocation() ;��ȡ�ֿ���п������
		moveboxItem($i)
		
		;If $boxnotfix = 1 Then ;�����û����box���ƶ��Ĵ���
		If $boxEmptyCount <= 0 Then
			$boxisfull = 1
			If $i = 1 And $firstCount <= 6 Then ;����ǵ�һ��ѭ���ͷŲ����ˣ���ʾ����
				TrayTip("", "���������Ӷ�������ˣ�", 1, 16)
				Sleep(1000)
			EndIf

			TrayTip("", "����װ������", 1, 16)
			Sleep(1000)
			Send("{ESC}")
			Sleep(200)
			#CS 			exitRoom()
				Sleep(2000)
			#CE
			ExitLoop
		EndIf

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
;	$avvArray[0][9] = PixelChecksum($xArray[9][0], $yArray[0][0], $xArray[9][1], $yArray[0][1], $title);3651934153

	$avvArray[1][0] = PixelChecksum($xArray[0][0], $yArray[1][0], $xArray[0][1], $yArray[1][1], $title); 1643131837
	$avvArray[1][1] = PixelChecksum($xArray[1][0], $yArray[1][0], $xArray[1][1], $yArray[1][1], $title); 4023004801
	$avvArray[1][2] = PixelChecksum($xArray[2][0], $yArray[1][0], $xArray[2][1], $yArray[1][1], $title);1210726313
	$avvArray[1][3] = PixelChecksum($xArray[3][0], $yArray[1][0], $xArray[3][1], $yArray[1][1], $title);1402155425
	$avvArray[1][4] = PixelChecksum($xArray[4][0], $yArray[1][0], $xArray[4][1], $yArray[1][1], $title);3324257933
	$avvArray[1][5] = PixelChecksum($xArray[5][0], $yArray[1][0], $xArray[5][1], $yArray[1][1], $title);1178673873
	$avvArray[1][6] = PixelChecksum($xArray[6][0], $yArray[1][0], $xArray[6][1], $yArray[1][1], $title);1418138221
	$avvArray[1][7] = PixelChecksum($xArray[7][0], $yArray[1][0], $xArray[7][1], $yArray[1][1], $title);3123713197
	$avvArray[1][8] = PixelChecksum($xArray[8][0], $yArray[1][0], $xArray[8][1], $yArray[1][1], $title);4239462497
;	$avvArray[1][9] = PixelChecksum($xArray[9][0], $yArray[1][0], $xArray[9][1], $yArray[1][1], $title);262213569


	$avvArray[2][0] = PixelChecksum($xArray[0][0], $yArray[2][0], $xArray[0][1], $yArray[2][1], $title); 2849382445
	$avvArray[2][1] = PixelChecksum($xArray[1][0], $yArray[2][0], $xArray[1][1], $yArray[2][1], $title); 1649753657
	$avvArray[2][2] = PixelChecksum($xArray[2][0], $yArray[2][0], $xArray[2][1], $yArray[2][1], $title); 4055383265
	$avvArray[2][3] = PixelChecksum($xArray[3][0], $yArray[2][0], $xArray[3][1], $yArray[2][1], $title); 2840607369
	$avvArray[2][4] = PixelChecksum($xArray[4][0], $yArray[2][0], $xArray[4][1], $yArray[2][1], $title); 3396610741
	$avvArray[2][5] = PixelChecksum($xArray[5][0], $yArray[2][0], $xArray[5][1], $yArray[2][1], $title); 477177009
	$avvArray[2][6] = PixelChecksum($xArray[6][0], $yArray[2][0], $xArray[6][1], $yArray[2][1], $title); 1108484605
	$avvArray[2][7] = PixelChecksum($xArray[7][0], $yArray[2][0], $xArray[7][1], $yArray[2][1], $title); 3728482849
	$avvArray[2][8] = PixelChecksum($xArray[8][0], $yArray[2][0], $xArray[8][1], $yArray[2][1], $title); 3546356257
;	$avvArray[2][9] = PixelChecksum($xArray[9][0], $yArray[2][0], $xArray[9][1], $yArray[2][1], $title); 786963093


	$avvArray[3][0] = PixelChecksum($xArray[0][0], $yArray[3][0], $xArray[0][1], $yArray[3][1], $title);4170659101
	$avvArray[3][1] = PixelChecksum($xArray[1][0], $yArray[3][0], $xArray[1][1], $yArray[3][1], $title);2377405565
	$avvArray[3][2] = PixelChecksum($xArray[2][0], $yArray[3][0], $xArray[2][1], $yArray[3][1], $title);751582593
	$avvArray[3][3] = PixelChecksum($xArray[3][0], $yArray[3][0], $xArray[3][1], $yArray[3][1], $title);1710831477
	$avvArray[3][4] = PixelChecksum($xArray[4][0], $yArray[3][0], $xArray[4][1], $yArray[3][1], $title);1604531761
	$avvArray[3][5] = PixelChecksum($xArray[5][0], $yArray[3][0], $xArray[5][1], $yArray[3][1], $title);1116753093
	$avvArray[3][6] = PixelChecksum($xArray[6][0], $yArray[3][0], $xArray[6][1], $yArray[3][1], $title);1294093305
	$avvArray[3][7] = PixelChecksum($xArray[7][0], $yArray[3][0], $xArray[7][1], $yArray[3][1], $title);3129229389
	$avvArray[3][8] = PixelChecksum($xArray[8][0], $yArray[3][0], $xArray[8][1], $yArray[3][1], $title);1964844249
;	$avvArray[3][9] = PixelChecksum($xArray[9][0], $yArray[3][0], $xArray[9][1], $yArray[3][1], $title);3822594909

EndFunc   ;==>bagfullcompare
;_ArrayDisplay($avArray, "$avArray ԭ�ȵ����� _ArrayAdd()")


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



	;_ArrayDisplay($avvBoxArray, "$avArray ԭ�ȵ����� _ArrayAdd()")

EndFunc   ;==>boxfullcompare

;$bagEmptyCount=0
;$bagfullCount =0

Func getbagLocation()
	$bagfullCount = 0 ;����������
	$bagEmptyCount = 0 ;�ո������
	
	bagfullcompare() ; �ȳ�ʼ���հ����µĸ��ӵ���ɫ
	
	For $j = 0 To 3 Step 1
		For $i = 0 To 9 Step 1
			$cmpArray[$j][$i] = "" ;������Ϊ��
			If $avvArray[$j][$i] <> $emptyArray[$j][$i] And $itembagCheck[$j][$i] = 1 Then
				;_ArrayAdd($cmpArray, $j +1 & "��"& $i +1 & "��")
				$cmpArray[$j][$i] = 1
				$bagfullCount = $bagfullCount + 1
			EndIf
		Next
	Next
	$bagEmptyCount = 40 - $bagfullCount
	TrayTip("", "����ʣ��������" & $bagEmptyCount, 1, 16)
	Sleep(10)
	Return $bagEmptyCount
	;MsgBox(0,"",$bagEmptyCount & "��ʣ��" )
	;_ArrayDisplay($cmpArray, "$avArray ��Ӻ������ _ArrayAdd()")

EndFunc   ;==>getbagLocation

Func movebagItem()
	TrayTip("", "�ƶ���Ʒ���", 1, 16)
	For $j = 0 To 3 Step 1
		For $i = 0 To 8 Step 1
			If $cmpArray[$j][$i] = 1 Then
				$itembaglocation[0][0] = $xArray[$i][0] ;��¼��Ʒ�ĳ�ʼλ��
				$itembaglocation[0][1] = $yArray[$j][0]
				
				$itembaglocationxy[0][0] = $i ;��¼��Ʒ�ĳ�ʼλ�õ� ����
				$itembaglocationxy[0][1] = $j ;��¼��Ʒ�ĳ�ʼλ�õ� ����
				
				;MouseMove($xArray[$i][0], $yArray[$j][0])
				;Sleep(2000)
				;_ArrayDisplay($itembaglocation, "$avArray ��Ӻ������ _ArrayAdd()")
				MouseClick("left", $xArray[$i][0], $yArray[$j][0], 1)
				Sleep(30)
				MouseMove(500, 200)
				ExitLoop 2
			EndIf
		Next
	Next
	
EndFunc   ;==>movebagItem

Func getItemSize()
	movebagItem()
	$lastCount = getbagLocation()
	$itemSize = $lastCount - $firstCount
	TrayTip("", "��Ʒռ�ø�����" & $itemSize, 1, 16)
	Sleep(10)
EndFunc   ;==>getItemSize

Func getboxLocation()
	$boxfullCount = 0
	$boxEmptyCount = 0
	
	boxfullcompare() ;            ��ȡĿǰ�ֿ��µ���ɫ �����������ѷ�����Ʒ
	For $j = 0 To 7 Step 1
		For $i = 0 To 5 Step 1
			$cmpBoxArray[$j][$i] = 0
			If $avvBoxArray[$j][$i] <> $emptyBoxArray[$j][$i] Then
				;_ArrayAdd($cmpArray, $j +1 & "��"& $i +1 & "��")
				$cmpBoxArray[$j][$i] = 1
				$boxfullCount = $boxfullCount + 1
			EndIf
		Next
	Next
;~ 	��$cmpBoxArray �������ֵ����ݶ�����Ϊ 1
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
	TrayTip("", "�ֿ�ʣ��������" & $boxEmptyCount, 1, 16)
	Sleep(10)
	
	;MsgBox(0,"",$bagEmptyCount & "��ʣ��" )
	;_ArrayDisplay($cmpBoxArray, "$avArray ��Ӻ������ _ArrayAdd()")
	Return $boxEmptyCount

EndFunc   ;==>getboxLocation

Func moveboxItem($count)
	Dim $presize
	TrayTip("", "׼���ƶ����ֿ�", 1, 16)
	Sleep(10)
	$findsame = False
	
	For $j = 0 To 7 Step 1
		For $i = 0 To 5 Step 1
			;TrayTip("", "�ֿ�" & $j + 1 & " �� " & $i + 1 & " �� Ϊ�� " & $cmpBoxArray[$j][$i], 1, 16)
			;Sleep(500)
			If $cmpBoxArray[$j][$i] = 0 Then
				;MouseClick("left", $xBoxArray[$i][0], $yBoxArray[$j][0], 1)
				;�����ж� box��Χ�Ƿ�������Ʒ
				$presize = 0
				For $x = 0 To $xlength - 1 Step 1
					For $y = 0 To $ylength - 1 Step 1
						If $cmpBoxArray[$j + $y][$i + $x] = 0 Then ;ˮƽ������Ʒ����2λ �����ˮƽ������㣬���жϸ߶�
							$presize = $presize + 1
						EndIf
					Next
				Next
				TrayTip("", "�ֿ��к��ʵĿ��ø�����" & $presize, 1, 16)
				Sleep(10)
				If $presize = $itemSize Then
					MouseMove($xBoxArray[$i][0] + ($xlength - 1) * 15, $yBoxArray[$j][0] + ($ylength - 1) * 15)
					Sleep(30)
					MouseClick("left", Default, Default, 1)
					Sleep(30)
					$findsame = True
					ExitLoop 2
				Else
					$findsame = False
				EndIf
			EndIf
		Next
	Next
	
	If $findsame = False Then
		;��������������û��ƥ���
		;MouseMove($itembaglocation[0][0] , $itembaglocation[0][1] )
		
		MouseMove($itembaglocation[0][0] + ($xlength - 1) * 15, $itembaglocation[0][1] + ($ylength - 1) * 15)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		Sleep(100)
		TrayTip("", "�����ӷŲ����ⶫ���ˣ�", 1, 16)
		
		For $xx = 0 To $xlength - 1 Step 1
			For $yy = 0 To $ylength - 1 Step 1
				$itembagCheck[$itembaglocationxy[0][1] + $yy][$itembaglocationxy[0][0] + $xx] = 0 ;�����λ����Ϊ0���Ա�ʾ��ʹ���ˣ��Դ˿��Լ����������Ʒ
			Next
		Next
		
		

		
		
		#CS  		$boxnotfix = 1
			If $count = 1 And $firstCount <= 6 Then ;����ǵ�һ��ѭ���ͷŲ����ˣ���ʾ����
			TrayTip("", "���������Ӷ�������ˣ�", 1, 16)
			$allfull = True
			EndIf
			Sleep(100)
		#CE

		
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
	TrayTip("", "��Ʒ��ȣ�" & $xlength & " ��Ʒ�߶ȣ�" & $ylength, 1, 16)
	Sleep(10)
EndFunc   ;==>writeitemSize


Func checkziseRej()
	For $j = 0 To 3 Step 1
		For $i = 0 To 8 Step 1
			$coord = PixelSearch($xArray[$i][0], $yArray[$j][0], $xArray[$i][1], $yArray[$j][1], 0x682070, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
			If Not @error Then
				MouseClick("right", $coord[0], $coord[1], 1);
				;MouseMove($coord[0], $coord[1])
				Sleep(50)
				MouseMove(400, 300, 1)
				Sleep(50)
			EndIf
		Next
	Next
EndFunc   ;==>checkziseRej

Func checkzise($color)
	For $j = 0 To 3 Step 1
		For $i = 0 To 8 Step 1
			$coord = PixelSearch($xArray[$i][0], $yArray[$j][0], $xArray[$i][1], $yArray[$j][1], $color, 10, 1, $title) ; �ڱ����ռ䷶Χ�ڲ���
			If Not @error Then
				MouseClick("right", $coord[0], $coord[1], 1);
				;MouseMove($coord[0], $coord[1])
				Sleep(100)
				MouseMove(400, 300, 1)
				Sleep(100)
			EndIf
		Next
	Next
EndFunc   ;==>checkzise



