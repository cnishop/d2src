;resume pet



AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)



 Func checkwhichact()
   	Send("{Q}") ;tab ȥ��С��ͼ
	Sleep(200)
   	If findPointColor(380, 80, "0x242424") = False Then  ; ��Q�� ,�쿴�Ƿ���act5,�ڵĻ�ȥ ACT4 ����pet
   	  ;��ʱ�����act4,��move ȥact5
	  Send("{Q}") ;tab ȥ��С��ͼ
			MouseClick("left", 740,80, 1)
		Sleep(2000)
		MouseClick("left", 340,80, 1)
		Sleep(200)
		MouseClick("left", 340,140, 1)
		Sleep(1000)
		exitRoom()
	Else
		Send("{Q}") ;tab ȥ��С��ͼ
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
   	;;����act4
   	MouseClick("left", 130,240, 1)
   	Sleep(1000)
   	MouseClick("left", 280,60, 1);����̩���
   	Sleep(1500)
      	MouseClick("left", 380,130, 1);���и���
   	Sleep(1000)
   	      	MouseClick("left", 380,130, 1);����ǰ��act5
   	Sleep(1000)
   

EndFunc 