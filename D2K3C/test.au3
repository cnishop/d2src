ToolTip("1111111111111111111",10,10)
Sleep(5000)


TrayTip("1111", "等待执行中..", 1)
Sleep(5000)
#CS finditem()
    Func finditem()
   	Send("{ALT down}")
   	For $i = 1 To 5 Step 1
   		$coord = PixelSearch(20, 20, 800, 520, 0x102404, 20, 1)
   		If Not @error Then
   			TrayTip($i, "捡起需要的物品", 1)
   			Sleep(300)
   			MouseMove($coord[0], $coord[1])
   			;MouseClick("left", $coord[0], $coord[1],1,10)
   			Sleep(1000)
   		EndIf
   		Sleep(100)
   	Next
   	Send("{ALT up}")
   EndFunc   ;==>finditem
   #CE

