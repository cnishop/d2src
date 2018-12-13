#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_Res_Comment=暗黑kp精灵,非BOT，服务器端无法检测到，安全
#AutoIt3Wrapper_Res_LegalCopyright=james
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

#include <guidesign.au3>
#include <d2客户端.au3>
#include <colormanger.au3>  ;调用找色的函数
#include <fireMethord.au3>   ;攻击过程中的函数
#include <imageSearch.au3> 


; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused
Local $ohterImage = 0
$title = "d2"
;$fire = 0   ;/ / 角色攻击类型,由radio button来选择，
$titlefiremethord = $title
$titleImageSearch = $title
If Not _IniVer() Then
	gui()
EndIf


creatGui() ; 开始创建界面

HotKeySet("{F9}", "TogglePause")
HotKeySet("{F10}", "Terminate")
;;;; Body of program would go here ;;;;
 
While 1
	Sleep(100)
WEnd

;;;;;;;;
Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		TrayTip("", "等待执行中..", 1, 16)
		runGame()
	WEnd
	;Exit
	Sleep(100)
	TrayTip("", "如果已在房间内,暂停10秒！", 9, 16)
	Sleep(10000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "已退出程序！", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	Dim $optcount = 0 ; 记录是否有以下操作，有时候因为网速慢等，造成停留在一个未知界面上不动
	activeWindow()
	initialSize() 
	#CS //进入游戏界面，点击按钮进入战网
		MouseClick("left", 600, 455, 1)
		//进入战网
		MouseClick("left", 600, 455, 1)
		//创建房间名称
		MouseClick("left", 600, 455, 1)
		Sleep(50)
	#CE
	#CS    ;后台模拟的鼠标点击
		#Include <ACN_Mouse.au3>
		Opt("MouseCoordMode", 0)
		_MouseClickPlus($title, "left",400,320,1)
	#CE
	
	;单机
 	
   	Sleep(1000)
   	MouseClick("left", 400, 300, 1)
   	Sleep(500)
   	MouseClick("left", 700, 560, 1)
   	Sleep(500)
   	MouseClick("left", 400, 360, 1)
   	Sleep(4000)
   	

	
	;以下是进入游戏后移动鼠标了
	Select
		Case isInRoom()
			roomplay()
			$optcount = $optcount + 1
			Sleep(1000)
		Case waitCreatRoom()
			$optcount = $optcount + 1
			TrayTip("", "准备进入游戏。。.", 1, 16)
			Sleep(5000)
		Case loginnotConnect()
			$optcount = $optcount + 1
			TrayTip("", "无法连接战网，重试中。。.", 1, 16)
			Sleep(1000)
		Case pwderror()
			$optcount = $optcount + 1
			TrayTip("", "密码错误，重试。。.", 1, 16)
			Sleep(1000)
		Case selectRole()
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要创建房间.", 1, 16)
			Sleep(2000)
		Case waitInputUsr()
			$optcount = $optcount + 1
			TrayTip("", "检查是否选择角色界面.", 1, 16)
			Sleep(2000)
		Case waitLoginNet()
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要输入用户名密码.", 1, 16)
			Sleep(2000)
		Case Else
			TrayTip("", "等待中，请稍后", 1, 16)
			Sleep(1000)
	EndSelect
	
	;;如果$optcount 还为0，表示没执行过任何操作，停留在某个未知界面，
	If $optcount = 0 Then
		$ohterImage = $ohterImage + 1 ;增加一个变量来统计出现其他未知界面的中次数
		TrayTip("尝试合适的操作", $ohterImage, 1, 16)
		If $ohterImage > 20 Then;循环了100次
			TrayTip($ohterImage, "未找到的合适操作，重试中", 1, 16)
			Sleep(100)
			Send("{ESC}") ;遇到未知的界面,向等待,按ESC
			Sleep(100)
			If $ohterImage > 22 Then;
				Sleep(100)
				Send("{ENTER}") ;遇到未知的界面,若按esc还不行的话,则换成按回车看看
				Sleep(100)
			EndIf
			If $ohterImage > 25 Then;   若按以上回车还不行,则直接结束游戏进程,重新打开,比如遇到程序报错之类
				Sleep(100)
				$PID = ProcessExists("D2loader.exe") ; Will return the PID or 0 if the process isn't found.
				If $PID Then ProcessClose($PID)
				$ohterImage = 0
				Sleep(1000)
			EndIf
		EndIf
	Else
		$ohterImage = 0 ; 恢复初始状态，不进行累积
	EndIf
	
EndFunc   ;==>runGame

Func activeWindow()
	;TrayTip("", "激活窗口！", 1,16)
	; 得到包括 "this one" 内容的记事本窗口的句柄
	$handle = WinGetHandle($title)
	If @error Then
		;MsgBox(32, "错误", "没找到暗黑窗口程序，第一次请先打开暗黑，并进入选择单机或战网的界面")
		;Exit 0
		TrayTip("", "没有找到游戏窗口，尝试启动中。", 1, 16)
		Sleep(1000)
		If Run($d2path1, $d2path2) = 0 Then
			;Run("F:\暗黑破坏神II毁灭之王1.10\D2loader.exe -w -pdir Plugin -title d2 ", "",@SW_MAXIMIZE )
			
			;Sleep(3000)
			;$handle = WinActivate($title)
			;Send("{ENTER}")
			;If @error <> 0 Then
			MsgBox(32, "错误", "请先设置好正确的路径")
			Exit 0
		Else
			Sleep(3000)
			$handle = WinGetHandle($title)
			WinActivate($title)
			Send("{ENTER}")
			Sleep(100)
		EndIf
		
	Else
		WinActivate($title)
	EndIf
	$size = WinGetClientSize($title)
	If $size <> 0 Then ;找到窗口
		If $size[0] <> 800 And $size[1] <> 600 Then
			MsgBox(0, "提示", "请先将窗口设置成800*600")
			Exit 0
		EndIf
	Else
		MsgBox(0, "提示", "没有找到游戏窗口.")
	EndIf
	;WinMove($title, "", 0, 0)
	Sleep(50)
EndFunc   ;==>activeWindow

Func roomplay()
	Select
		Case bagisfull()
			Sleep(100)
			;ContinueCase
		Case roleisdead()
			Sleep(100)
			;ContinueCase
		Case notinfive()
			Sleep(100)
			;ContinueCase
		Case astisdead()
			Sleep(100)
			;ContinueCase
		Case Else
			
			checkbagRev()
			Sleep(100)
			
			findpath(Random(1, 3, 1))
			Sleep(100)
			
			If finddoor() Then
				If isInRoom() Then ;防止网速慢可能断开了房间
					TrayTip("", "准备战斗.", 1, 16)
					afterReady()
					TrayTip("", "移向BOSS.", 1, 16)
					movekp()
					Sleep(100)
					TrayTip("", "释放技能.", 1, 16)
					fire($fire)
					TrayTip("", "寻找物品.", 1, 16)
					finditem()
					TrayTip("", "退出房间.", 1, 16)
					exitRoom()
				EndIf
			EndIf

	EndSelect
EndFunc   ;==>roomplay




Func findpath($pathNumber)
	TrayTip("", "走向红门。。.", 1, 16)
	Sleep(100)
	Send("{TAB}") ;tab 去掉小地图
	Select
		Case $pathNumber = 1
			MouseClick("left", 310, 530, 1)
			Sleep(1500)
			MouseClick("left", 700, 480, 1)
			Sleep(1300)
			MouseClick("left", 110, 460, 1)
			Sleep(1100)
			MouseClick("left", 60, 460, 1)
			Sleep(1100)
			MouseClick("left", 40, 460, 1)
			Sleep(1100)
			MouseClick("left", 40, 280, 1)
			Sleep(1100)
		Case $pathNumber = 2
			MouseClick("left", 60, 250, 1)
			Sleep(1100)
			MouseClick("left", 40, 250, 1)
			Sleep(1100)
			MouseClick("left", 180, 480, 1)
			Sleep(1200)
			MouseClick("left", 180, 480, 1)
			Sleep(1200)
			MouseClick("left", 100, 450, 1)
			Sleep(1200)
			MouseClick("left", 220, 500, 1)
			Sleep(1000)
			MouseClick("left", 600, 420, 1)
			Sleep(800)
			MouseClick("left", 700, 400, 1)
			Sleep(800)
		Case $pathNumber = 3
			MouseClick("left", 200, 500, 1)
			Sleep(1400)
			MouseClick("left", 750, 430, 1)
			Sleep(1400)
			MouseClick("left", 380, 480, 1)
			Sleep(800)
			MouseClick("left", 100, 350, 1)
			Sleep(1000)
			MouseClick("left", 130, 470, 1)
			Sleep(1000)
			MouseClick("left", 50, 430, 1)
			Sleep(1000)
			MouseClick("left", 65, 280, 1)
			Sleep(800)
			
		Case Else
	EndSelect
	Return True
EndFunc   ;==>findpath

Func finditem()
	Send("{ALT down}")
	For $i = 1 To 5 Step 1
		$coord = PixelSearch(0, 0, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			Sleep(1500)
		EndIf
		Sleep(100)
	Next
	Send("{ALT up}")
EndFunc   ;==>finditem
Func movekp()
	Send("{F1}") ;
	Sleep(100)
	MouseClick("right", 740, 120, 1)
	Sleep(600)
	MouseClick("right", 740, 110, 1)
	Sleep(600)
	MouseClick("right", 540, 80, 1)
	Sleep(600)
	MouseClick("right", 590, 140, 1)
	Sleep(600)
EndFunc   ;==>movekp
Func fire($var = 1)
	takefire($var)
EndFunc   ;==>fire
Func isInRoom($color = 0xB08848) ;检查看人物下方是否有黄色的耐力条，有表示在游戏内
#CS 	$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
   	If Not @error Then
   		Return True
   	Else
   		Return False
   	EndIf
#CE
	If findinroom() Then 
		Return True
	Else
		Return False
	EndIf
	
		
EndFunc   ;==>isInRoom
Func waitLoginNet()
	;进入战网，判断是否准备点battle
	;If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
	If findConnect() = True Then
	MouseClick("left", 400, 350)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;进入战网，判断是否准备点battle
	;If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
	If findConnectError() Then
		MouseClick("left", 360, 430)
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;进入战网，判断是否准备输入账号密码
	;If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
	If findinputpsd() Then
		MouseClick("left", 400, 340, 2)
		Sleep(500)
		ControlSend($title, "", "", $usr)
		Sleep(1000)
		MouseClick("left", 400, 390, 2)
		ControlSend($title, "", "", $psd)
		Sleep(1000)
		Send("{ENTER}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitInputUsr

Func pwderror()
	;If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") Then
	If findpsderror() Then
		If findPointColor(360, 400, "646464") Then
			Send("{ENTER}")
			Sleep(500)
			Return True
		Else
			Send("{ENTER}")
			Sleep(500)
			Return True
		EndIf
	Else
		Return False
	EndIf
	;MouseMove(290, 510)  242424
	;MouseMove(290, 560) 303030
	
	;MouseMove(360, 400) 646464
EndFunc   ;==>pwderror

Func selectRole()
	;select role which is to be used

	
	;If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
	 If findrole() Then
		Select
			Case $pos = 1
			Case $pos = 2
				Send("{DOWN}")
			Case $pos = 3
				Send("{DOWN 2}")
			Case $pos = 4
				Send("{DOWN 3}")
			Case $pos = 5
				Send("{RIGHT}")
			Case $pos = 6
				Send("{RIGHT}")
				Send("{DOWN}")
			Case $pos = 7
				Send("{RIGHT}")
				Send("{DOWN 2}")
			Case $pos = 8
				Send("{RIGHT}")
				Send("{DOWN 3}")
		EndSelect
		Send("{ENTER}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>selectRole
Func waitCreatRoom()
	;进入战网，判断是否准备建房间
	;If findPointColor(45, 585, "040404") And findPointColor(325, 585, "040404") Then
	If findWaitRoom() Then
		;如果找到，表示是在大厅
		;建房间，判断是否出现对话框，如无法建立，同名等提示，中间会出现对话框
		Sleep(1000)
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
		If findPointColor(350, 250, "040404") = False Then
			Send("{ENTER}")
			Sleep(500)
			Return True
		Else ;开始建立房间
			createRoom()
			Return True
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>waitCreatRoom

Func createRoom() ;建立战网游戏房间名
	;/进入游戏界面，点击按钮进入战网
	;MouseClick("left", 600, 455, 1)
	;//进入战网
	MouseClick("left", 700, 455)
	MouseClick("left", 600, 455)
	MouseClick("left", 705, 378) ;选地狱难度
	Sleep(1000)
	; //创建房间名称
	ControlSend($title, "", "", Random(10000, 99999, 1))
	;ControlSend($title, "", "","fdsfsdg")
	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Send("{ESC}")
	MouseClick("left", 400, 250, 1)
EndFunc   ;==>exitRoom

Func finddoor() ;找红门的程序
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(100)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 100
	$top = 100
	$right = 400
	$bottom = 400
	;Sleep(1000)


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
				exitRoom()
				Return False
			EndIf
			
			
		EndIf
	Else
		;MsgBox(0, "", "没有一个白点") 如果一个白点没找到，可能是没到红门的位置，退出游戏重来
		TrayTip("", "没有找到很合红门标志.", 1, 16)
		Sleep(400)
		exitRoom()
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
		Next
	Next
	If $total >= 30 Then
		MouseMove($xx, $yy)
		MouseClick("left", $xx, $yy, 1)
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

Func bagisfull()
	If isInRoom() Then
		TrayTip("", "检查背包是否已满", 1, 16)
		Send("{B}")
		Sleep(800)
		If findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
			;如果都有物品占用，表示包裹满了
			Send("{B}")
			Sleep(500)
			;exitRoom()
			;Sleep(1000)
			If $shutdown = 1 Then ;如果用户选择了包裹满了关机,则提示
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "正在执行关机", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
			EndIf
			Return False
		Else
			Send("{B}")
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>bagisfull


Func notinfive()
	TrayTip("", "检查是否在act4", 1, 16)
	Sleep(100)
	Send("{Q}") ;tab 去掉小地图
	Sleep(200)
	;If findPointColor(380, 80, "242424") = False Then ; 按Q键 ,察看是否在act5,没找到表示不在act5，此时去act5
	If findinAct4() Then
		;此时如果在act4,则move 去act5
		Send("{Q}") ;tab 去掉小地图
		MouseClick("left", 740, 80, 1)
		Sleep(2000)
		MouseClick("left", 340, 80, 1)
		Sleep(200)
		MouseClick("left", 340, 140, 1)
		Sleep(1000)
		exitRoom()
		Return True
	Else
		Send("{Q}") ;tab 去掉小地图
		Return False
	EndIf
	
EndFunc   ;==>notinfive


Func astisdead()
	TrayTip("", "检查pet挂了没", 1, 16)
	Sleep(100)
	If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
		resumepet()
		exitRoom()
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>astisdead

Func resumepet()
	MouseClick("left", 145, 520, 1)
	Sleep(2000)
	;MouseMove(170,520)
	MouseClick("left", 170, 520, 1)
	Sleep(2000)
	MouseClick("left", 310, 80, 1)
	Sleep(200)
	MouseClick("left", 310, 140, 1)
	Sleep(3000)
	;;来到act4
	MouseClick("left", 130, 240, 1)
	Sleep(3000)
	MouseClick("left", 280, 60, 1);点中泰瑞尔
	Sleep(2000)
	MouseClick("left", 380, 130, 1);点中复活
	Sleep(1500)
	MouseClick("left", 380, 130, 1);点中前往act5
	Sleep(1500)

EndFunc   ;==>resumepet

Func roleisdead()
	TrayTip("", "检查人物是否挂了", 1, 16)
	Send("{B}")
	Sleep(500)
	If findPointColor(460, 250, "242424") = True And findPointColor(505, 250, "040404") = True And findPointColor(690, 250, "282828") = True Then
		;如果手套,戒指,鞋子三个点颜色都为默认颜色,则表示人物没有装备,死亡了
		Send("{B}")
		Sleep(500)
		MouseClick("left", 400, 285, 1)
		Sleep(1000)
		MouseClick("left", 400, 315, 1)
		Sleep(1000)
		MouseClick("left", 400, 285, 1)
		Sleep(1000)
		MouseClick("left", 400, 315, 1)
		Sleep(1000)
		exitRoom()
		Return True
	Else
		Send("{B}")
		Sleep(100)
		Return False
	EndIf
EndFunc   ;==>roleisdead

Func checkbagRev()
	TrayTip("", "检查多余的瞬间回复药水", 1, 16)
	Sleep(10)
	Send("{B}")
	Sleep(500)
	;addrevtobag()
	drinksurplusrev()
	Send("{B}")
	Sleep(100)
	;If 1 = 1 Then
	;	Return True
	;Else
	;	Return False
	;EndIf
EndFunc   ;==>checkbagRev

Func drinksurplusrev() ;去掉多余的瞬间回复血瓶,省得占用空间
	For $i = 1 To 3 Step 1
#CS 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
   		If Not @error Then
   			MouseClick("right", $coord[0], $coord[1], 1);
   			Sleep(200)
   		EndIf
#CE
		$coord = findRevInBag() 
		If $coord[0]>=0 And $coord[1]>=0 Then
						MouseClick("right", $coord[0], $coord[1], 1);
			Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev

Func addrevtobag() ;如果是人物死亡后复活的情况下,则需把身上的血瓶放到物品篮中去
	Send("{LSHIFT down}")
	Sleep(10)
	For $i = 1 To 10 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
		If Not @error Then
			Sleep(10)
			MouseClick("left", $coord[0], $coord[1], 1);
			Sleep(200)
		EndIf
	Next
	Send("{LSHIFT up}")
	Sleep(10)
EndFunc   ;==>addrevtobag

Func afterReady() ;进门后的准备，如装配护甲，CTA 波
	Sleep(1000)
	Send("{F5}") ;tab 去掉小地图
	Sleep(100)
	MouseClick("right", Default, Default, 1)
	Sleep(1000)
	If $cta = 1 Then
		Send("{W}") ;
		Sleep(500)
		Send("{F7}") ;
		Sleep(500)
		MouseClick("right", Default, Default, 1)
		Sleep(500)
		Send("{F8}") ;
		Sleep(500)
		MouseClick("right", Default, Default, 1)
		Sleep(500)
		Send("{W}") ;
		Sleep(500)
	EndIf
EndFunc   ;==>afterReady




