#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Icon=routo.ico
#AutoIt3Wrapper_Res_Comment=暗黑kp精灵,非BOT，服务器端无法检测到，安全
#AutoIt3Wrapper_Res_Description=暗黑kp挂机王，挂机专用
#AutoIt3Wrapper_Res_FileVersion=0.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=潘多拉盒子
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

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

Local $ohterImage = 0 ;出现的其他未知界面
Local $emptybag
Local $checkbag = 1

$title = "d2"
;$fire = 0   ;/ / 角色攻击类型,由radio button来选择，
$titlefiremethord = $title
Local $ct = 1
Local $repeatrejpet = 0 ; 增加一个复活pet的标志，看是否重复
Local $roombegintime ;记录进入房间后kp的时间，用于统计一次kp用来多长时间

Local $parm_boxing ;是否装箱
Local $parm_boxqty ;满足条件的格数
Local $parm_namelenfr, $parm_namelento, $parm_namepre
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime
Local $parm_ramevent, $parm_kprounctime, $parm_rantime
Local $parm_ramclose, $parm_closetime, $parm_closestoptime ;规定kp次数下线的设置
Local $parm_path ;走向红门的路线
Local $parm_othercheck, $parm_otherwhencheck, $parm_othermethord, $parm_otherroundtrace


Local $round = 0 ; kp次数统计
Local $tfcount = 0 ; 切换账号前该账号的累积kp计数 建房间

Local $other_traced_round = 0 ;定义第几局被人进入房间,

Local $authority ;
Local $parm_firstdate, $parm_kpcount ;总的kp次数，用于限制月付客户

Local $errCount = 0 ;增加一个没有找到红门，导致乱循环的计数器

Local $arrayroomName[12] ;定义用于字母房间名
$arrayroomName[0] = "q"
$arrayroomName[1] = "w"
$arrayroomName[2] = "e"
$arrayroomName[3] = "r"
$arrayroomName[4] = "a"
$arrayroomName[5] = "s"
$arrayroomName[6] = "d"
$arrayroomName[7] = "f"
$arrayroomName[8] = "g"
$arrayroomName[9] = "z"
$arrayroomName[10] = "x"
$arrayroomName[11] = "c"


Local $acountArray[2] ;用于绑定帐号

$bindmac = 1 ;绑定机器
$bindacc = 0 ;绑定帐号
$bindlimitCount = 0 ;  绑定次数
$bindTime = 0 ;数据库中的次数  ;只测试版用到

$limitRound = 100 ;持续挂机次数

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
$parm_namepre = $guinamepre
$parm_drinkrej_plus = $guidrinkrej
$parm_settime = $guisettime
$parm_timedata = $guitimedata
$parm_picktime = $guipicktime
$parm_ramevent = $guiramstop
$parm_kprounctime = $guikpstoptime
$parm_rantime = $guiramtime
$parm_ramclose = $guiramclose
$parm_closetime = $guiclosetime
$parm_closestoptime = $guiclosestoptime
$parm_blztime = $guiblztime
$parm_path = $guipath
$parm_othercheck = $guiothercheck
$parm_otherwhencheck = $guiotherwhen
$parm_othermethord = $guiothermetherd
$parm_otherroundtrace = $guiotherroundtrace

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
	$checkbag = 1
	$boxisfull = 0
	Sleep(10)
	TrayTip("", "暂停中...！", 9, 16)
	Sleep(86400000)
	
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "已退出程序！", 1, 16)
	Sleep(1000)
	Exit 0
EndFunc   ;==>Terminate


Func runGame()
	Dim $optcount = 0 ; 记录是否有以下操作，有时候因为网速慢等，造成停留在一个未知界面上不动
	If $parm_settime = 1 Then ;check if set tiem to shutdown
		tiemtoshut($parm_timedata)
	EndIf
	
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
	SQLiteFirstUpateDate()
	SQLiteRead(101)
	$parm_firstdate = $app_date
	$parm_kpcount = $app_kpcount
	
	;$iDateCalc = _DateDiff('D', $parm_firstdate, _NowCalc())
	;-------------以下为限制提醒：
	If $bindTime = 1 Then
		;If $iDateCalc >= 30 Then
		;MsgBox(0, "到期提示", "您购买的软件已到授权期限，请续费")
		;Exit 0
		;EndIf
		;30天即为2592000秒
		;If $parm_kpcount >= 51840 Then   ;超过了这么多次数
		If $parm_kpcount >= 50 Then
			MsgBox(0, "到期提示", "您定制的软件已到授权次数，请续费")
			Exit 0
		EndIf
	EndIf
	;---------------------------------------
	
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

	#CS 	Sleep(1000)
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
			$ct = $ct + 1
			$roombegintime = _NowCalc()
			roomplay()
			$inRoomDateCalc = _DateDiff('s', $roombegintime, _NowCalc())
			;writelog("房间内时间---第 " & $round & " 局用时: " & $inRoomDateCalc & " 秒")
			$optcount = $optcount + 1
			;Sleep(1000)
			Sleep(Random(600, 1000, 1))
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
				$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
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
	;先关闭无效的错误地图窗口
	closeError()
	;----------------下线
	If $parm_ramclose = 1 Then
		ramclose() ;获取下线
	EndIf
	;
	
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
	WinMove($title, "", 0, 0) ;移动到左上，防止被任务栏挡住
	Sleep(50)
	$size = WinGetClientSize($title)
	If $size <> 0 Then ;找到窗口
		If $size[0] <> 800 And $size[1] <> 600 Then
			MsgBox(0, "提示", "请先确认游戏是否已是窗口模式！并先进游戏将窗口设置成800*600")
			Exit 0
		EndIf
	Else
		MsgBox(0, "提示", "没有找到游戏窗口.")
	EndIf

EndFunc   ;==>activeWindow

Func roomplay()

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
		Case findanya() = False ;如果没有同时发现anya 和 红门 ，则表示位置可能是初始位置
			
			$errCount = $errCount + 1
			TrayTip("", "没有找到anya次数 " & $errCount, 1, 16)
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
			;Return
			;ContinueCase
			;Case $ckroledead = 1 And roleisdead()
			;	Sleep(100)
			;ContinueCase
			;Case $ckact5 = 1 And notinfive()
			;	Sleep(150)
			;ContinueCase
			;Case $ckass = 1 And astisdead()
			;	Sleep(100)
			;ContinueCase
			
			;findpath(Random(1, 8, 1))
			;findpath(8)
			;Sleep(100)
		Case findanya()
			$errCount = 0
			If finddoor() Then ;人物先站在anya旁边
				If isInRoom() Then ;防止网速慢可能断开了房间
					Sleep(800)
					backdoortotown()
					Sleep(100)
					If $parm_othercheck = 1 And $parm_otherwhencheck = 2 Then ;进红门后检查
						If checkotherin() = True Then
							Return
						EndIf
					EndIf
					#CS 					If chkbagisfull() Then
						exitRoom()
						Exit
						EndIf
					#CE
					clickAnya()
					Sleep(100)
					clickTrade()
					Sleep(100)
					findanyaItem()
					Sleep(100)
					$round = $round + 1
					$tfcount = $tfcount + 1
					_GUICtrlStatusBar_SetText($StatusBar1, "刷甲次数：" & $round, 1)
					$parm_kpcount = $parm_kpcount + 1
					SQLiteInsert(102, "", $parm_kpcount)
				EndIf
			EndIf
		Case Else
			
			
	EndSelect
EndFunc   ;==>roomplay


Func finditem($parm_picktime)
	Sleep(10)
	MouseMove(400, 300)
	Sleep(20)
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		$coord = PixelSearch(200, 50, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseMove($coord[0], $coord[1] + 5)
			Sleep(400)
			MouseClick("left", Default, Default, 1)
			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
			Sleep(1500)
		EndIf
		Sleep(100)
	Next
	Send("{ALT up}")
EndFunc   ;==>finditem
Func movekp()
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	TrayTip("", "启用随机路径" & "坐标迷惑偏移" & $xrd & " " & $yrd, 1, 16)
	Send("{F1}") ;
	Sleep(100)
	MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
	;CheckMove(600)
	Sleep(600)
	MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
	;CheckMove(600)
	Sleep(600)
	MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
	;CheckMove(600)
	Sleep(600)
	MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
	;CheckMove(600)
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
		Sleep(1500)
		MouseMove(400, 390)
		Sleep(1000)
		MouseClick("left", 400, 390, 2)
		Sleep(500)
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
		TrayTip("", "进入战网大厅,准备建立房间..", 1, 16)
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

		$str = ""
		For $i = 1 To $roomcount Step 1
			$str = $str & $arrayroomName[Random(0, 11, 1)]
		Next

		#CS 		For $i = 1 To $roomcount
			$str = $str & Chr(Random(97, 104, 1))
			Next
		#CE
		
		
		ControlSend($title, "", "", $str)
	ElseIf $nameCat = 2 Then
		ControlSend($title, "", "", Random(10 ^ $parm_namelenfr - 1, 10 ^ $parm_namelento - 1, 1))
	Else
		ControlSend($title, "", "", $parm_namepre & $ct)
	EndIf

	Sleep(500)
	MouseClick("left", 680, 410, 1)
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Sleep(100)
	Send("{ESC}")
	Sleep(10)
	MouseClick("left", 400, 250, 1)
	Sleep(10)
EndFunc   ;==>exitRoom

Func finddoor() ;找红门的程序
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(Random(50, 300, 1))
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 150
	$top = 150
	$right = 400
	$bottom = 300
	;Sleep(1000)



	#CS    ;xp:
		If findredDoor($left, $top, $right, $bottom) Then
		TrayTip("", "找到红门并进入！.", 1, 16)
		Return True
		Else
		TrayTip("", "寻找红门失败！.", 1, 16)
		Sleep(500)
		Return False
		EndIf
		
	#CE

	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "找到红门！", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(500)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		Sleep(1500)
		Return True
	Else
		TrayTip("", "红门未找到！准备退出房间", 1, 16)
		Sleep(500)
		exitRoom()
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


Func notinfive()
	TrayTip("", "检查是否在act4", 1, 16)
	Sleep(100)
	Send("{Q}") ;tab 去掉小地图
	Sleep(200)
	If findPointColor(380, 80, "242424") = False Then ; 按Q键 ,察看是否在act5,没找到表示不在act5，此时去act5
		;此时如果在act4,则move 去act5
		Send("{Q}") ;tab 去掉小地图
		MouseMove(740, 80)
		Sleep(500)
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", 740, 80, 1)
		Sleep(2000)
		MouseClick("left", 340, 80, 1)
		Sleep(200)
		MouseClick("left", 340, 140, 1)
		Sleep(2000)
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
	;If findAreaColor(0, 0, 100, 100, 0x008400, 0, 1, $title) = False Then
	;------------------------------ 这一段是新增的
	Send("{O}")
	Sleep(300)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	Sleep(300)
	Send("{O}")
	If $a <> 3002911715 Then
		; -------------------------
		$repeatrejpet = $repeatrejpet + 1 ;
		TrayTip("", "尝试第" & $repeatrejpet & " 次复活pet", 1, 16)
		Sleep(500)
		If $repeatrejpet >= 10 Then ;如果 发现重复执行复活的次数大于 10次，表示可能没钱了。
			writelog("雇佣兵---连续10次重复复活pet，可能是没钱了，自动退出。")
			$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
			If $PID Then ProcessClose($PID)
			Sleep(1000)
			Exit 0
		EndIf
		
		TrayTip("", "pet挂了，待复活", 1, 16)
		Sleep(1000)
		resumepet()
		exitRoom()
		Return True
	Else
		$repeatrejpet = 0 ;重置为 0
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
	MouseMove(280, 60)
	Sleep(500)
	MouseClick("left", Default, Default, 1)
	;MouseClick("left", 280, 60, 1);点中泰瑞尔
	Sleep(2000)
	;MouseMove(380, 138)
	MouseMove(380, 130)
	Sleep(500)
	MouseClick("left", Default, Default, 1)
	;MouseClick("left", 380, 130, 1);点中复活
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
	$ranKp = Random(-4, 4, 1)
	If $tfcount >= $parm_kprounctime + $ranKp Then ; 切换账号后 循环次数也大于规定的
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

Func ramclose()
	;_GUICtrlStatusBar_SetText($StatusBar1, "KP次数：" & $round & " 随机延迟: " & $tfcount, 1)
	$ranKp = Random(-4, 4, 1)
	If $tfcount >= $parm_closetime + $ranKp Then ; 切换账号后 循环次数也大于规定的
		;此时可以关闭游戏,用循环的下一个账号来登陆
		closeAndWait()
	EndIf
	
EndFunc   ;==>ramclose

Func closeError() ;关闭掉hackmap 的报错。
	$errortitle = "Diablo II Fatal Error"
	$errorhandle = WinGetHandle($errortitle)
	If Not @error Then
		writelog("地图错误---尝试关闭hackmap")
		TrayTip("", "出现hackmap Error，尝试关闭。", 1, 16)
		Sleep(500)
		WinActivate($errortitle)
		Send("{ENTER}")
		Sleep(500)
		Send("{ENTER}")
		Sleep(2000)
	EndIf
EndFunc   ;==>closeError

Func closeAndWait()
	writelog("自动上下线---关闭游戏帐号下线")
	TrayTip("", "关闭游戏帐号下线，线下停留分钟数：" & $parm_closestoptime, 1, 16)
	Sleep(1000)
	$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
	If $PID Then ProcessClose($PID)
	$sleeptime = $parm_closestoptime * 60 * 1000
	TrayTip("", "软件暂停:" & $parm_closestoptime & "分钟", 1, 16)
	_GUICtrlStatusBar_SetText($StatusBar1, "帐号下线暂停中...", 1)
	$tfcount = 0 ; 重置为0
	Sleep($sleeptime)
	TrayTip("", "暂停时间已过 ,开始继续挂机", 1, 16)
EndFunc   ;==>closeAndWait

Func checkotherin()
	TrayTip("", "检查是否有他人进入", 1, 16)
	Sleep(100)
	MouseMove(400, 300)
	Sleep(50)
	Send("{P}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		Send("{P}") ;关闭队伍界面
		If $b <> 3299051709 Then ;表示有变动了,可能是其他人进入房间了
			
			If $parm_otherroundtrace = 1 Then ;是否启用规定局内自动下线功能
				If $round + 1 - $other_traced_round <= 10 Then ;连续10局以内就有两次被追踪，表示有点危险了，
					writelog("其他人进房间---在第" & $round + 1 & "局进入房间，连续10次之内2次进入，停止挂机！")
					exitRoom()
					Sleep(Random(200, 1000, 1))
					Exit 0
				EndIf
			EndIf
			
			$other_traced_round = $round + 1 ;把当前局数记录下来 ,因为 round 第一局为 0
			writelog("其他人进房间---在第" & $other_traced_round & "局进入房间")
			_GUICtrlStatusBar_SetText($StatusBar1, "注意有陌生人在第 " & $other_traced_round & "  局进入你的房间 ", 0)
			
			Select
				Case $parm_othermethord = 1
					exitRoom()
					Sleep(Random(200, 1000, 1))
					$sleeptime = $parm_rantime * 1000
					TrayTip("", "随机暂停:" & $parm_rantime & "秒", 1, 16)
					Sleep($sleeptime)
				Case $parm_othermethord = 2
					exitRoom()
					Sleep(100)
					closeAndWait()
				Case Else
					;其他处理方案
			EndSelect
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


Func backdoortotown()
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(50)
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
	$coord = PixelSearch(100, 50, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		TrayTip("", "搜寻安亚，走向安亚！.", 1, 16)
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(1800)
	EndIf
EndFunc   ;==>clickAnya

Func clickTrade() ;找到安亚后，点交易
	$coord = PixelSearch(100, 10, 400, 300, 0x1CC40C, 30, 1, $title) ; 在背包空间范围内查找
	If Not @error Then
		TrayTip("", "点击交易！.", 1, 16)
		;MouseClick("right", $coord[0], $coord[1], 1);
		MouseMove($coord[0] + 50, $coord[1] + 40)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		Sleep(200)
	EndIf
EndFunc   ;==>clickTrade

Func findanyaItem()
	If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
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
			If findPointColor($x, $y, "682070") Then
				TrayTip("", "没有购买成功，包裹已满或是钱不够了！.", 1, 16)
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

Func findanya()
	$coord = PixelSearch(100, 10, 380, 280, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		;$x = $coord[0]
		;$y = $coord[1]
		;MouseMove($x, $y)
		TrayTip("", "搜寻到anya！.", 1, 16)
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
