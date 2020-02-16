#region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=暗黑kp精灵,非BOT，服务器端无法检测到，安全
#AutoIt3Wrapper_Res_Description=暗黑kp挂机王，挂机专用
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=潘多拉盒子
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#endregion ;**** 参数创建于 ACNWrapper_GUI ****

#include <guidesignanya.au3>
#include <d2客户端.au3>
#include <include.au3>
#include <colormanger.au3>  ;调用找色的函数
#include <commonUse.au3>
#include <fireMethord.au3>   ;攻击过程中的函数
#include <checkbag.au3>
#include <findpath.au3>    ;跑步路径
#include <approve.au3>
#include <file.au3>    ;写入log 日志

; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused
Local $ohterImage = 0
Local $emptybag
Local $checkbag = 1
Local $istrade = 0 ;设置一个标记位，0 没交易过，1 交易过
Local $round = 0 ; kp次数统计
$title = "d2"
;$fire = 0   ;/ / 角色攻击类型,由radio button来选择，
$titlefiremethord = $title
Local $parm_boxing ;是否装箱
Local $parm_boxqty ;满足条件的格数
Local $parm_namelenfr, $parm_namelento
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime
Local $parm_ramevent, $parm_kprounctime, $parm_rantime

Local $tfcount = 0 ; 切换账号前该账号的累积kp计数 建房间

Local $errCount = 0 ;增加一个没有找到红门，导致乱循环的计数器
Local $parm_firstdate, $parm_kpcount ;总的kp次数，用于限制月付客户
Local $parm_othercheck, $parm_staymin



Local $acountArray[2] ;用于绑定帐号

$bindmac = 1 ;绑定机器
$bindacc = 0 ;绑定帐号
$bindlimitCount = 0 ;  绑定次数  ---可以告知给用户的测试次数,测试版可以用此控制
$limitRound = 5;持续挂机次数
$bindTime = 0 ;数据库中的次数  ;只测试版用到

$ranLimte = Random(-14, 14, 1) ;最大次数限制的前后范围   比如可以 80-20 或者 80+20
;$ranLimte=0


If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "提示", "未知错误，请检查")
	Exit 0
EndIf

If $bindmac = 1 Then
	If Not _IniVer() Then ; 绑定机器
		gui()
	EndIf
EndIf
;$parm_bhtime = $guibhTime



creatGui() ; 开始创建界面

$parm_boxing = $guiboxing
$parm_boxqty = $guiboxqty
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_drinkrej_plus = $guidrinkrej
$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime

$parm_othercheck = $guiothercheck
$parm_staymin = $guistaymin

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
	Sleep(10)
	TrayTip("", "如果已在房间内,暂停30秒！", 9, 16)
	Sleep(30000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "已退出程序！", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	
	;-------------------
	;增加对绑定帐号的限制：                                    1. 绑定帐号的限制
	If $bindacc = 1 Then
		$acountArray[0] = "iamhix"
		$acountArray[1] = "iamhix"
		If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
			;writelog("在第" & $other_traced_round + 1 & "局有人进入房间")
			MsgBox(4096, " ...... 提示 ...... ", "与绑定的帐号不相符，请确认")
			Exit 0
		EndIf
	EndIf
	;------------------                                          绑定每轮最大使用次数
	If $bindlimitCount = 1 Then
		;If $round >= $limitRound + $ranLimte Then
		If $round >= $limitRound Then ;测试版
			writelog("达到循环限制次数")
			MsgBox(4096, " ..... 温馨提示 .........", "已达循环限制次数,请休息下再挂机" & @CRLF & "或使用无限次版")
			Exit 0
		EndIf
	EndIf
	
	;增加对软件使用次数的限制 ----------------                 .数据库中使用次数限制
	;SQLiteFirstUpateDate()
	;SQLiteRead(102)
	$parm_firstdate = $app_date
	$parm_kpcount = $app_kpcount
	
	
	Dim $optcount = 0 ; 记录是否有以下操作，有时候因为网速慢等，造成停留在一个未知界面上不动
	If $parm_settime = 1 Then ;check if set tiem to shutdown
		tiemtoshut($parm_timedata)
	EndIf
	activeWindow()

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

	#CS 		Sleep(1000)
		MouseClick("left", 400, 300, 1)
		Sleep(500)
		MouseClick("left", 700, 560, 1)
		Sleep(500)
		MouseClick("left", 400, 360, 1)
		Sleep(4000)
	#CE


	
	;以下是进入游戏后移动鼠标了
	Select
		Case isInRoom()
			roomplay()
			$optcount = $optcount + 1
			Sleep(1000)
		Case waitCreatRoom()

			$optcount = $optcount + 1
			TrayTip("", "准备进入游戏。。.", 1, 16)
			Sleep(4000)
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
			Sleep(10)
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
			Exit
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
	WinMove($title, "", 20, 20)
	Sleep(50)
EndFunc   ;==>activeWindow

Func roomplay()
	$roombegintime = _NowCalc()
	$inRoomDateCalc = _DateDiff('n', $roombegintime, _NowCalc())
	If $inRoomDateCalc >= $parm_staymin Then
		exitroom()
		writelog("房间内时间---第 " & $round & " 局用时: " & $inRoomDateCalc & " 分退出")
	EndIf
	

	#CS 	If $parm_ramevent = 1 Then
		getRam() ;获取随机事件
		EndIf
	#CE
	
	#CS 	If $guidrinkrej = 1 Then
		checkbagRev()
		;drinksurplusInbag("0x943030")
		;drinksurplusInbag("0x1828A4")
		
		EndIf
	#CE
	#CS 			If $round>= 6 Then
		MsgBox(0, "提示", "循环次数已到，如果满意，请确认付款！正式版将无限制")
		Exit
		EndIf
	#CE
	Select
		Case $istrade = 0 And findleftdoor() = False And findrightdoor() = False ;flag=0 ，如果左右都没红门，则向下方去找红门
			$errCount = $errCount + 1
			TrayTip("", "无红门，没有找到anya次数 " & $errCount, 1, 16)
			If $errCount >= 4 Then
				$errCount = 0 ;重置 0
				exitroom()
				Return
			EndIf
			Sleep(500)
			If $parm_boxing = 1 And bagisfull() Then ;如果需要装箱，则去装箱
				Return
			EndIf
			findpath(20)
			Sleep(100)
			If findleftdoor() = True Then
				;进红门
				$istrade = 1 ; 进红门后，就将标记为改为 1
			Else
				Sleep(500)
				exitRoom()
				Sleep(500)
			EndIf
			
		Case $istrade = 0 And findleftdoor() = True And findanya() = False ;左边有红门，有安亚,找安亚交易
			TrayTip("", "左红门，有安亚", 1, 16)
			clickleftdoor()
			clickAnya()
			Sleep(100)
			clickTrade()
			Sleep(100)
			findanyaItem()
			Sleep(100)
			$round = $round + 1
			$tfcount = $tfcount + 1
			_GUICtrlStatusBar_SetText($StatusBar1, "shop次数: " & $round & "  累计shop次数： " & $parm_kpcount + 1, 1)
			$parm_kpcount = $parm_kpcount + 1
			
;~ 			Sleep(500)
;~ 			If $parm_othercheck = 1 Then ;进红门后检查 他人进入房间
;~ 				If checkotherin() = True Then
;~ 					Return
;~ 				EndIf
;~ 			EndIf
			
		Case $istrade = 0 And findrightdoor() = True And findanya() = True ;右边有红门，有安亚,找安亚交易
			TrayTip("", "右红门，有安亚", 1, 16)
			clickAnya()
			Sleep(50)
			clickTrade()
			Sleep(50)
			findanyaItem()
			Sleep(50)
			$round = $round + 1
			$tfcount = $tfcount + 1
			_GUICtrlStatusBar_SetText($StatusBar1, "shop次数: " & $round & "  累计shop次数： " & $parm_kpcount + 1, 1)
			$parm_kpcount = $parm_kpcount + 1
			
		Case $istrade = 1 And findrightdoor() = True ;flag=1 ,  右边有红门，则进右边红门，设置flag为0
			TrayTip("", "右红门，已交易，去野外", 1, 16)
			clickrightdoor()
			If findleftdoor() = True Then ;表示进左边红门成功
				$istrade = 0
			EndIf
			
			
		Case $istrade = 1 And findleftdoor() = True ;flag=1 ,  左边有红门，进左边红门，设置flag为0
			TrayTip("", "左红门，已交易，去野外", 1, 16)
			clickleftdoor()
			If findleftdoor() = True Then ;表示进左边红门成功
				$istrade = 0
			EndIf
			Sleep(10)
			
		Case Else
			TrayTip("", "其他异常", 1, 16)
			Sleep(10)
	EndSelect
EndFunc   ;==>roomplay



#CS
	Func findpath($pathNumber)
	TrayTip("", "走向红门。。.", 1, 16)
	Sleep(100)
	Send("{TAB}") ;tab 去掉小地图
	Select
	Case $pathNumber = 1
	MouseClick("left", 310, 530, 1)
	Sleep(1500)
	MouseClick("left", 700, 460, 1)
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
	Case $pathNumber = 4
	MouseClick("left", 60, 250, 1)
	Sleep(1400)
	MouseClick("left", 30, 250, 1)
	Sleep(1600)
	MouseClick("left", 190, 480, 1)
	Sleep(1300)
	MouseClick("left", 190, 480, 1)
	Sleep(1300)
	MouseClick("left", 100, 450, 1)
	Sleep(1300)
	MouseClick("left", 210, 500, 1)
	Sleep(1300)
	MouseClick("left", 600, 420, 1)
	Sleep(1300)
	MouseClick("left", 600, 400, 1)
	Sleep(1400)
	Case $pathNumber = 5
	MouseClick("left", 290, 510, 1)
	Sleep(1700)
	MouseClick("left", 620, 340, 1)
	Sleep(1300)
	MouseClick("left", 500, 460, 1)
	Sleep(1000)
	MouseClick("left", 60, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 460, 1)
	Sleep(1100)
	MouseClick("left", 40, 280, 1)
	Sleep(1100)
	Case Else
	EndSelect
	Return True
	EndFunc   ;==>findpath
#CE

Func finditem($parm_picktime)
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
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
	takefire($var, $parm_blztime)
EndFunc   ;==>fire
Func isInRoom($color = 0xB08848) ;检查看人物下方是否有黄色的耐力条，有表示在游戏内
	If findPointColor(30, 585, "040404") = False Then
		$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
		If Not @error Then
			Return True
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>isInRoom
Func waitLoginNet()
	;进入战网，判断是否准备点battle
	If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
		MouseClick("left", 400, 350)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;进入战网，判断是否准备点battle
	If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
		MouseClick("left", 360, 430)
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;进入战网，判断是否准备输入账号密码
	If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
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
	If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") Then
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
	;If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "343434") Then
	
	If findPointColor(700, 45, "040404") = True And findPointColor(60, 560, "585048") And findPointColor(650, 560, "646464") Then
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
	;If findPointColor(30, 585, "040404") And findPointColor(325, 585, "040404") Then
	If findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") And findPointColor(180, 350, "040404") Then ; 109 的测试
		;如果找到，表示是在大厅
		;建房间，判断是否出现对话框，如无法建立，同名等提示，中间会出现对话框
		Sleep(1000)
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
		If findPointColor(385, 250, "040404") = False Then
			Send("{ENTER}")
			Sleep(500)
			Return True
		ElseIf findPointColor(445, 410, "786C60") = True Then
			Send("{ENTER}")
			Sleep(500)
			Return True
		Else
			If isInRoom() = False Then
				createRoom()
				Return True
			Else
				Return False
			EndIf
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
	If $nameCat = 1 Then
		Dim $str = ""
		Dim $roomcount = Random($parm_namelenfr, $parm_namelento, 1)
		;msgbox(0,$roomcount,$roomcount)

		For $i = 1 To $roomcount
			$str = $str & Chr(Random(97, 105, 1))
		Next
		ControlSend($title, "", "", $str)
	Else
		
		ControlSend($title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
	EndIf

	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Send("{ESC}")
	MouseClick("left", 400, 250, 1)
EndFunc   ;==>exitRoom

;下面讲找红门和点击红门分开来，以便做精细的判断
Func findleftdoor() ;找红门的程序
	TrayTip("", "寻找红门.", 1, 16)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 200
	$top = 200
	$right = 400
	$bottom = 300
	;Sleep(1000)
	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;先判断红门是否在左上位置
	If Not @error Then
		TrayTip("", "定位左边红门，第一次！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;Sleep(50)
		;MouseMove(400, 300)
		;MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;为防止单个像素，继续缩小范围，找相同的点
		$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $title)
		If Not @error Then
			TrayTip("", "定位左边红门，第二次！.", 1, 16)
			$x = $coord[0] + 5
			$y = $coord[1] + 5
			;MouseMove($x, $y)
			;Sleep(100)
			Return True
		Else
			Return False
			;左边没找到红门，可以找右边的红门
		EndIf
	Else
		TrayTip("", "左边红门未找到！.", 1, 16)
		;Sleep(50)
		Return False
	EndIf
	
EndFunc   ;==>findleftdoor

Func clickleftdoor() ;找红门的程序
	TrayTip("", "寻找左边红门.", 1, 16)
	;Sleep(10)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 200
	$top = 200
	$right = 400
	$bottom = 300
	;Sleep(1000)
	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;先判断红门是否在左上位置
	If Not @error Then
		TrayTip("", "找到左边红门，进红门！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;MouseMove(400, 300)
		;Sleep(50)
		MouseClick("left", $x + 5, $y + 10, 1)
		Sleep(2000)
		MouseMove(400 + Random(1, 10), 300 + + Random(1, 10))
		Sleep(5)
	Else
		TrayTip("", "进左边红门出错！.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
EndFunc   ;==>clickleftdoor

Func findrightdoor() ;找红门的程序
	TrayTip("", "寻找右边红门.", 1, 16)
	;Sleep(10)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 410
	$top = 310
	$right = 600
	$bottom = 500
	;Sleep(1000)
	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;先判断红门是否在左上位置
	If Not @error Then
		TrayTip("", "定位右边红门，第一次！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;Sleep(50)
		;MouseMove(400, 300)
		;MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;为防止单个像素，继续缩小范围，找相同的点
		$coord = PixelSearch($left - 5, $top - 5, $right, $bottom, 0xFFFFFF, 0, 1, $title)
		If Not @error Then
			TrayTip("", "定位右边红门，第二次！.", 1, 16)
			$x = $coord[0] + 5
			$y = $coord[1] + 5
			;MouseMove($x, $y)
			;Sleep(100)
			Return True
		Else
			Return False
			;左边没找到红门，可以找右边的红门
		EndIf
	Else
		TrayTip("", "右边红门未找到！.", 1, 16)
		Sleep(50)
		Return False
	EndIf
	
EndFunc   ;==>findrightdoor

Func clickrightdoor() ;找红门的程序
	TrayTip("", "寻找右边红门.", 1, 16)
	;Sleep(10)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 410
	$top = 310
	$right = 600
	$bottom = 500
	;Sleep(1000)
	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title) ;先判断红门是否在左上位置
	If Not @error Then
		TrayTip("", "进入右边红门！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		;MouseMove($x, $y)
		;MouseMove(400, 300)
		;Sleep(50)
		MouseClick("left", $x + 5, $y + 10, 1)
		Sleep(2000)
		MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
		Sleep(10)
	Else
		TrayTip("", "进右边红门出错！.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
EndFunc   ;==>clickrightdoor




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
	If isInRoom() = True And $checkbag = 1 Then
		Send("{B}")
		Sleep(100)
		MouseMove(300, 340)
		Sleep(100)
		InitialBagCheck()
		$emptybag = getbagLocation()
		TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
		Sleep(1000)
		

		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;如果都有物品占用，表示包裹满了
			TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{B}")
			Sleep(500)
			If $boxisfull = 0 Then ;如果记录仓库已满的表示 =1 ，表示满了，就不用再存仓库里，0 去存仓库
				gotoBox()
				If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
					movebagtoBox()
					Sleep(100)
					exitRoom()
					Return True
				Else
					exitRoom()
					Return True
				EndIf
			EndIf
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 10 Then ;如果用户选择了包裹满了关机,则提示
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "正在执行关机", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
			
			#CS 			If $shutdown = 1 And isInRoom() And $allfull Then ;如果用户选择了包裹满了关机,则提示
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "正在执行关机", 1, 16)
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
				ElseIf isInRoom() And $allfull Then
				Sleep(500)
				exitRoom()
				$checkbag = 0
				Return True
				ElseIf isInRoom() And $allfull = False Then
				exitRoom()
				Return True
				EndIf
			#CE
			
		Else
			Send("{B}")
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>bagisfull

#CS Func bagisfull()
	If isInRoom() = True And $checkbag = 1 Then
	Send("{B}")
	Sleep(100)
	MouseMove(300, 340)
	Sleep(100)
	$emptybag = getbagLocation()
	TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
	Sleep(100)
	
	;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
	;如果都有物品占用，表示包裹满了
	TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
	Sleep(1000)
	Send("{B}")
	Sleep(500)
	gotoBox()
	If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
	movebagtoBox()
	Else
	exitRoom()
	Return True
	EndIf
	If $shutdown = 1 And isInRoom() And $allfull Then ;如果用户选择了包裹满了关机,则提示
	Sleep(100)
	exitRoom()
	Sleep(2000)
	TrayTip("", "正在执行关机", 1, 16)
	Sleep(1000)
	Shutdown(1)
	Sleep(1000)
	Exit 0
	Return True
	ElseIf isInRoom() And $allfull Then
	TrayTip("", "退出房间", 1, 16)
	Sleep(500)
	exitRoom()
	$checkbag = 0
	Return True
	ElseIf isInRoom() And $allfull = False Then
	TrayTip("", "退出房间", 1, 16)
	Sleep(100)
	exitRoom()
	Return True
	EndIf
	
	Else
	Send("{B}")
	Return False
	EndIf
	Else
	Return False
	EndIf
	EndFunc   ;==>bagisfull
#CE

Func chkbagisfull()
	;Send("{B}")
	Sleep(10)
	MouseMove(300, 100)
	Sleep(00)
	$emptybag = getbagLocation()
	TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
	Sleep(10)
	;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
		;如果都有物品占用，表示包裹满了
		TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
		Sleep(1000)
		;Send("{B}")
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>chkbagisfull


Func notinfive()
	TrayTip("", "检查是否在act4", 1, 16)
	Sleep(100)
	Send("{Q}") ;tab 去掉小地图
	Sleep(200)
	If findPointColor(380, 80, "242424") = False Then ; 按Q键 ,察看是否在act5,没找到表示不在act5，此时去act5
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
	Sleep(50)
	If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
		TrayTip("", "pet挂了，待复活", 1, 16)
		Sleep(500)
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
	Sleep(100)
	Send("{B}")
	Sleep(300)
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
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
		If Not @error Then
			checkzise("0x682070")
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev

Func drinksurplusInbag($color) ;去掉多余的瞬间回复血瓶,省得占用空间
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, $color, 10, 1, $title) ; 在背包空间范围内查找
		If Not @error Then
			checkzise($color)
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusInbag



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
	Sleep(800)
	Send("{F5}") ;tab 去掉小地图
	Sleep(100)
	MouseClick("right", Default, Default, 1)
	Sleep(700)
	If $cta = 1 Then
		Send("{W}") ;
		Sleep(500)
		Send("{F7}") ;
		Sleep(400)
		MouseClick("right", Default, Default, 1)
		Sleep(400)
		Send("{F8}") ;
		Sleep(400)
		MouseClick("right", Default, Default, 1)
		Sleep(800)
		Send("{W}") ;
		Sleep(500)
	EndIf
EndFunc   ;==>afterReady


Func gotoBox()
	Sleep(100)
	MouseClick("left", 200, 500, 1)
	Sleep(1600)
	MouseClick("left", 750, 430, 1)
	Sleep(1600)
	MouseClick("left", 380, 480, 1)
	Sleep(1400)
	MouseMove(150, 240)
	Sleep(100)
	MouseClick("left", 150, 240, 1)
	Sleep(1800)
	
EndFunc   ;==>gotoBox

Func getRam()

	;_GUICtrlStatusBar_SetText($StatusBar1, "KP次数：" & $round & " 随机延迟: " & $tfcount, 1)
	If $tfcount >= $parm_kprounctime Then ; 切换账号后 循环次数也大于规定的
		;此时可以关闭游戏,用循环的下一个账号来登陆
		TrayTip("", "开始随机事件。。.", 1, 16)
		Sleep(1000)
		;以下就是随机发生的事件了，可以延时，可以去act4
		Select
			Case $tfcount >= 0
				MouseClick("left", 400 - Random(30, 400, 1), 300 + Random(10, 50, 1))
				Sleep(Random(200, 1000, 1))
				$sleeptime = $parm_rantime * 1000
				TrayTip("", "随机暂停:" & $parm_rantime & "秒", 1, 16)
				Sleep($sleeptime)
				exitRoom()
				Sleep(1000)
			Case Else

		EndSelect
		
		
		$tfcount = 0 ; 重置为0
		
	EndIf

	
	
	
EndFunc   ;==>getRam

Func backdoortotown()
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(10)
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 250
	$top = 180
	$right = 400
	$bottom = 300
	;Sleep(1000)

	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "找到红门，准备回城！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		Sleep(1000)
		Return True
	Else
		TrayTip("", "红门未找到！.", 1, 16)
		Sleep(500)
		exitRoom()
		Return False
	EndIf
	
	
EndFunc   ;==>backdoortotown

Func clickAnya()
	TrayTip("", "寻找安亚！.", 1, 16)
	;Sleep(10)
	$coord = PixelSearch(100, 30, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		TrayTip("", "找到安亚了，走向安亚！.", 1, 16)
		$x = $coord[0] + 20
		$y = $coord[1] + 50
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", $x, $y, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(2000)
	EndIf
EndFunc   ;==>clickAnya

Func clickTrade() ;找到安亚后，点交易
	$coord = PixelSearch(100, 10, 400, 300, 0x1CC40C, 30, 1, $title) ; 在背包空间范围内查找
	If Not @error Then
		TrayTip("", "进行交易！", 1, 16)
		;MouseClick("right", $coord[0], $coord[1], 1);
		MouseMove($coord[0] + 50, $coord[1] + 40)
		Sleep(50)
		MouseClick("left", Default, Default, 1)
		Sleep(200)
	EndIf
EndFunc   ;==>clickTrade

Func findanyaItem()
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
		$istrade = 1 ;  打开交易窗口的模式下， 标记为改为 1
		If chkbagisfull() Then
			Send("{ESC}")
			Sleep(1000)
			exitRoom()
		EndIf
		TrayTip("", "寻找物品.", 1, 16)
		Sleep(10)
		;MouseMove(400,300)
		;Sleep(100)
		;在安亚的交易窗口中
		$left = 100
		$top = 120
		$right = 380
		$bottom = 410
		;Sleep(1000)

		;针对win7
		$coord = PixelSearch($left, $top, $right, $bottom, 0x682070, 10, 1, $title)
		If Not @error Then
			TrayTip("", "找到好东西了！.", 1, 16)
			Sleep(10)
			$x = $coord[0]
			$y = $coord[1]
			MouseMove($x, $y)
			Sleep(200)
			;将东西买到背包，此处需要多一个判断，如果钱不够或背包满了，该如何处理
			MouseClick("right", Default, Default, 1)
			Sleep(50)
			MouseMove(400, 300)
			Sleep(50)
			;MouseClick("left", $x, $y, 1)
			writelog("物品---在第" & $round & "刷出东西")
			If findPointColor($x, $y, "682070") Then
				TrayTip("", "没有购买成功，包裹已满或是钱不够了！.", 1, 16)
				writelog("物品---在第" & $round & "无法购买")
				Exit
			EndIf
			Send("{ESC}")
			Sleep(1500)
			Return True
		Else
			TrayTip("", "没找到好东西，重新来！.", 1, 16)
			Sleep(10)
			Send("{ESC}")
			Return False
		EndIf
	EndIf
EndFunc   ;==>findanyaItem

Func findanya() ;; 需要看安亚的人物站在安亚的位置来判断
	$coord = PixelSearch(100, 10, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		;$x = $coord[0]
		;$y = $coord[1]
		;MouseMove($x, $y)
		TrayTip("", "找到anya！.", 1, 16)
		Sleep(10)
		Return True
	Else
		TrayTip("", "没有找到anya！.", 1, 16)
		Sleep(500)
		Return False
	EndIf
EndFunc   ;==>findanya

Func findanyadoor()
	$coord = PixelSearch(200, 200, 400, 300, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		;$x = $coord[0]
		;$y = $coord[1]
		;MouseMove($x, $y)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findanyadoor

Func checkotherin()
	;TrayTip("", "检查是否有他人进入", 1, 16)
	Sleep(10)
	MouseMove(400, 300)
	Sleep(50)
	Send("{P}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		Send("{P}") ;关闭队伍界面
		If $b <> 3299051709 Then ;表示有变动了,可能是其他人进入房间了
			
			#CS 			If $parm_otherroundtrace = 1 Then ;是否启用规定局内自动下线功能
				If $round + 1 - $other_traced_round <= 10 Then ;连续10局以内就有两次被追踪，表示有点危险了，
				writelog("其他人进房间---在第" & $round + 1 & "局进入房间，连续10次之内2次进入，停止挂机！")
				exitRoom()
				Sleep(Random(200, 1000, 1))
				Exit 0
				EndIf
				EndIf
			#CE
			
			
			writelog("其他人进房间---在第" & $round & "局进入房间")
			_GUICtrlStatusBar_SetText($StatusBar1, "注意有陌生人在第 " & $round & "  局进入你的房间 ", 0)
			
			exitRoom()
			Sleep(Random(200, 1000, 1))

			Return True
		Else
			TrayTip("", "没有其他人", 1, 16)
			;没找到其他人
			Return False
		EndIf
	Else
		TrayTip("", "没有队伍", 1, 16)
		;按了P后，发现也没有找到队伍界面，则忽略掉
		Send("{P}")
		Return False
	EndIf
	
EndFunc   ;==>checkotherin
Func writelog($str)
	_FileWriteLog(@ScriptDir & "\" & $Files, $str)
EndFunc   ;==>writelog
