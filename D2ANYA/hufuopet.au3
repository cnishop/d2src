;resume pet



AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)



 Func checkwhichact()
   	Send("{Q}") ;tab 去掉小地图
	Sleep(200)
   	If findPointColor(380, 80, "0x242424") = False Then  ; 按Q键 ,察看是否在act5,在的话去 ACT4 复活pet
   	  ;此时如果在act4,则move 去act5
	  Send("{Q}") ;tab 去掉小地图
			MouseClick("left", 740,80, 1)
		Sleep(2000)
		MouseClick("left", 340,80, 1)
		Sleep(200)
		MouseClick("left", 340,140, 1)
		Sleep(1000)
		exitRoom()
	Else
		Send("{Q}") ;tab 去掉小地图
   	EndIf
   	
   	
   	
   EndFunc


Func assistantdead($title)
		If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
			resumepet()
		EndIf
	EndFunc
	
Func resumepet()
   	MouseClick("left", 145, 520, 1)
   	Sleep(2000)
   	;MouseMove(170,520)
   	MouseClick("left", 170, 520, 1)
   	Sleep(2000)
   	MouseClick("left", 310, 80, 1)
   	Sleep(100)
   	MouseClick("left", 310, 140, 1)
   	Sleep(1000)
   	;;来到act4
   	MouseClick("left", 130,240, 1)
   	Sleep(1000)
   	MouseClick("left", 280,60, 1);点中泰瑞尔
   	Sleep(1500)
      	MouseClick("left", 380,130, 1);点中复活
   	Sleep(1000)
   	      	MouseClick("left", 380,130, 1);点中前往act5
   	Sleep(1000)
   

EndFunc 