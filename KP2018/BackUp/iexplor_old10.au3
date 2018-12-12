#region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** 参数创建于 ACNWrapper_GUI ****

#RequireAdmin

Global $testversion = 0;  是测试版 1   0 为正式版
Global $dingZhiFlag = 111 ;  没订制 0 ， 109 ，111 ,  113 ，    每个战网npc，出身地可能都不同，加入订制flag
Local $onlykp = 0 ;
Global $cheapversion = 0 ; 1 是简易版本，不装箱， 0 为全功能
Local $debugmode = 0 ;   1 打开 0 关闭 手动调试模式，用于游戏内控制

Local $acountArray[2] ;用于绑定帐号
$acountArray[0] = "whenzl4"
$acountArray[1] = "whenzl4"

Global $bindmac = 1;绑定机器
Global $bindacc = 0;绑定帐号

Local $killQuery  ;Random(1, 3, 1)      ;1 ;设定一个打怪队列，比如  1 kp， 2杀督军山克上面的怪， 3 杀督军山克


$bindlimitCount = 0 ;  绑定次数
$bindTime = 0 ;    数据库中的次数  ;只测试版用到,防止有人购买后不付款，此处可以设置数字使用户达到次数后不能再使用

If $testversion = 1 Then ;如果是免费版，就绑定次数
	$bindlimitCount = 1
	$bindTime = 1
EndIf
$limitRound = 2 ;持续挂机次数

$ranLimte = Random(-10, 13, 1) ;最大次数限制的前后范围   比如可以 80-20 或者 80+20
;$ranLimte = 0
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////各种版本
#include <guidesignkp.au3>
#include <d2客户端.au3>
#include <include.au3>
#include <colormanger.au3>  ;调用找色的函数
#include <imageSearch.au3>
#include <commonUse.au3>
#include <fireMethord.au3>   ;攻击过程中的函数
#include <checkbag.au3>
#include <moveWithMap.au3>
#include <findpath.au3>    ;跑步路径
;#include <approve.au3>
#include <file.au3>    ;写入log 日志
#include <ScreenCapture.au3>
#include <string.au3>   ;16进制转字符串

#include "CoProc.au3"



; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused = True ; 设定一个热键状态， true= 暂停

Local $ohterImage = 0 ;出现的其他未知界面
Local $emptybag
Local $checkbag = 1

Local $handle
;$title = "d2"
$titlefiremethord = $title
$titleImageSearch = $title

Local $ct = 1 ;房间名加1
Local $repeatrejpet = 0 ; 增加一个复活pet的标志，看是否重复
Local $repeatbuyred = 0 ; 增加一个复活pet的标志，看是否重复
Local $notfinddoorCount = 0 ;增加一个未找到红门的次数情况，如果一直没找到红门，则需要停止挂机了
Local $repeatCreatroom = 0 ;增加一个重复建房间的计数，如果排队的情况下，不停的建房间，则停止
Local $roombegintime ;记录进入房间后kp的时间，用于统计一次kp用来多长时间
Local $begintime ;记录开始运行的时间,用作结束程序用


Local $parm_boxing, $parm_MoveBox ;是否装箱 ,装箱方式
Local $parm_boxqty, $parm_moveround ;满足条件的格数,固定kp局数
Local $parm_shopred ;买红药水
Local $parm_shopblue ;买蓝药水

Local $parm_namelenfr, $parm_namelento, $parm_namepre, $parm_namegd
Local $parm_drinkheal_plus, $parm_drinkmana_plus, $parm_drinkrej_plus
Local $parm_settime, $parm_timedata
Local $parm_picktime, $parm_blztime, $parm_blzrnd
Local $parm_ramevent, $parm_kprounctime, $parm_rantime
Local $parm_ramclose, $parm_closetime, $parm_closestoptime ;规定kpt的设置
Local $parm_path ;走向红门的路线
Local $parm_othercheck, $parm_otherwhencheck, $parm_othermethord, $parm_otherroundtrace, $parm_otheroundinterval
Local $parm_sldspeed, $parm_speeddelay;网速
Local $parm_otherimage; 保存其他人的图片
Local $title ;窗口标题
Global $parm_path1, $parm_path2, $parm_path3 ;  路径
Local $parm_exeparm3 ;其他参数
Local $parm_gamemode ; 单机 0 ，网络 1
Local $parm_imageMode ; 找图的方式 普通 0， 图像和变色 1
;Local $parm_kpmode ;kp模式，默认，高效等
Local $parm_closegame, $parm_closegamesec ;重起暗黑
;Local $parm_tpIce, $parm_blzIce, $parm_armIce, $parm_tpFire, $parm_fireFire,$parm_armFire,$parm_cta1, $parm_cta2

Global $round = 0 ; kp次数统计
Local $tfcount = 0 ; 切换账号前该账号的累积kp计数 建房间 ,延时次数
Local $tfclosecount = 0 ; 自动上下线的kp局数
Local $other_traced_round = 0 ;定义第几局被人进入房间,
Local $ranclosecount = 0 ; 定义自动关闭暗黑，防止机器死机的功能
Local $movebagcount = 0 ;  定义一个固定多少局自动转移包裹的


Local $authority ;
Local $parm_firstdate, $parm_kpcount ;总的kp次数，用于限制月付客户
Local $connectfailcount = 0 ;增加一个无法连接战网的几次，比如帐号服务器停机时，就不能一直尝试连接
Local $createroominqueecount = 0 ;增加一个建房间等待排队
Local $autshortdelaysec = 0, $short1 = 0, $short2 = 0, $short3 = 0 ;红门前路径延时的时间    ，  0秒档， 4-5秒档 ， 9-12秒档

Local $biaojicolor1 = 0x18FB01 ; 淡绿色 0x118FB01
Local $childmsg[8] ;定义多进程收到的消息
Local $PidChild1 ;子进程id
Local $childWaringFlag = 1 ;增加一个子进程传递过来的异常标志，比如有人进房间，或者m你

Local $arrayroomName[12] ;定义用于字母房间名 ,现在有用户界面上自定义
#CS $arrayroomName[0] = "q"
	$arrayroomName[1] = "e" ;w
	$arrayroomName[2] = "e"
	$arrayroomName[3] = "t"
	$arrayroomName[4] = "a"
	$arrayroomName[5] = "s"
	$arrayroomName[6] = "d"
	$arrayroomName[7] = "f"
	$arrayroomName[8] = "g"
	$arrayroomName[9] = "z"
	$arrayroomName[10] = "x"
	$arrayroomName[11] = "c"
#CE




If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "提示", "未知错误，请检查")
	Exit 0
EndIf


;If $bindmac = 1 And $testversion = 0 Then
If $testversion = 0 Then
	If $bindmac = 1 Then
		_GUICtrlStatusBar_SetText($StatusBar1, "绑定机器", 0)
		If $cheapversion = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar1, "绑定机器" & "-全功能版", 0)
		EndIf
	Else
		_GUICtrlStatusBar_SetText($StatusBar1, "绑定账号", 0)
		If $cheapversion = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar1, "绑定账号" & "-全功能版", 0)
		EndIf
	EndIf
	If Not _IniVer() Then ; 绑定机器
		gui()
	EndIf
EndIf
;$parm_bhtime = $guibhTime


If @OSVersion = "WIN_XP" And @DesktopDepth <> 32 Then
	MsgBox(0, "初始化错误", "请先右点击桌面-属性，将颜色质量改为32")
	Exit 0
EndIf




creatGui() ; 开始创建界面


$title = $guititle
$parm_path1 = $d2path1 ;程序目标
$parm_path2 = $d2path2 ; 程序位置
$parm_path3 = $d2path3 ;可执行EXE
$parm_exeparm3 = $guiexeparm3 ;其他参数
$parm_gamemode = $guigamemode
$parm_imageMode = $guiImageMode
;$parm_kpmode = $guikpmode ;Kp 模式
$parm_closegame = $guiclosegame
$parm_closegamesec = $guiclosegamesec

$parm_boxing = $guiboxing ;是否启用装箱功能
$parm_MoveBox = $guiMoveBox ;用哪种方式装箱
$parm_boxqty = $guiboxqty ;少于包裹格数
$parm_moveround = $guimoveround ;每个多少局数执行装箱

$parm_buyred = $ckred
$parm_buyblue = $ckblue
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_namepre = $guinamepre
$parm_namegd = $guinamegd
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
$parm_path = $guipath
$parm_othercheck = $guiothercheck ;检查他人进房间
$parm_sldspeed = $guisldspeed ;网速选择



$char_tpFire = $guitpFire ;技能快捷键
$char_fireFire = $guifireFire ;技能快捷键
$char_armFire = $guiarmFire ;技能快捷键


$arrayroomName[0] = $guiavAlpName[0]
$arrayroomName[1] = $guiavAlpName[1]
$arrayroomName[2] = $guiavAlpName[2]
$arrayroomName[3] = $guiavAlpName[3]
$arrayroomName[4] = $guiavAlpName[4]
$arrayroomName[5] = $guiavAlpName[5]
$arrayroomName[6] = $guiavAlpName[6]
$arrayroomName[7] = $guiavAlpName[7]
$arrayroomName[8] = $guiavAlpName[8]
$arrayroomName[9] = $guiavAlpName[9]
$arrayroomName[10] = $guiavAlpName[10]
$arrayroomName[11] = $guiavAlpName[10]




$parm_speeddelay = $parm_sldspeed * 500 ;0-2  快中慢分别为 0 300 600



HotKeySet("{F11}", "TogglePause")
HotKeySet("{F10}", "Terminate")
;;;; Body of program would go here ;;;;

While 1
	Sleep(100)
WEnd


;;;;;;;;
Func TogglePause()
	
	If $parm_imageMode = 2 Then
		_RefreshSystemTray()
	EndIf
	$Paused = Not $Paused
	
	If $parm_imageMode = 2 Then
		If $Paused = False Then
			$PidChild1 = _CoProc("child1") ;;加了多进程，判断血，蓝，雇佣兵，他人进房间等
			_CoProcReciver("Reciver")
		Else
			If ProcessExists($PidChild1) Then
				ProcessClose($PidChild1) ;结束子进程
			EndIf
		EndIf
	EndIf

	While $Paused = False
		Sleep(10)
		TrayTip("", "等待执行中..", 1, 16)

		runGame()
	WEnd


	;Exit
	$checkbag = 1
	$boxisfull = 0
	$connectfailcount = 0
	$createroominqueecount = 0
	$notfinddoorCount = 0
	$repeatCreatroom = 0
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
	;-------------------- 定时关闭
	If $parm_closegame = 1 Then
		If $ranclosecount = 0 Then ;
			$begintime = _NowCalc()
			$ranclosecount = $ranclosecount + 1
		EndIf
		$endDateCalc = _DateDiff('n', $begintime, _NowCalc())
		If $endDateCalc >= $parm_closegamesec Then
			$ranclosecount = 0
			WinKill($title)
			TrayTip("", "定时重启游戏,释放资源..", 1, 16)
			writelog("随机---第 " & $round & " 局: 重启游戏,释放资源.")
			Sleep(5000)
		EndIf
	EndIf
	;-------------------
	;增加对绑定帐号的限制：                                    1. 绑定帐号的限制
	If $bindacc = 1 Then
		_GUICtrlStatusBar_SetText($StatusBar1, "正式版-绑定账号", 0)
		#CS 		If $usr <> $acountArray[0] And $usr <> $acountArray[1] Then
			;writelog("在第" & $other_traced_round + 1 & "局有人进入房间")
			MsgBox(4096, " ...... 提示 ...... ", "与绑定的帐号不相符，请确认")
			Exit 0
			EndIf
		#CE
		
		;增加一个绑定账号和本地账号的对比
		If $usr <> $Usrid Then
			MsgBox(4096, " ...... 提示 ...... ", "与绑定的帐号不相符，请确认")
			Exit 0
		EndIf
		
		If Not _IniVer() Then
			MsgBox(4096, " ...... 提示 ...... ", "读取绑定账号信息失败，请确认")
			Exit 0
		EndIf
		
	EndIf
	;------------------                                          绑定每轮最大使用次数
	If $bindlimitCount = 1 Then
		;If $round >= $limitRound + $ranLimte Then
		If $round >= $limitRound Then ;测试版
			writelog("达到循环限制次数")
			MsgBox(4096, " ..... 温馨提示 .........", "测试结束,请休息下再挂机" & @CRLF & "或使用不限次数版")
			Exit 0
		EndIf
	EndIf
	
	;增加对软件使用次数的限制 ----------------                 .数据库中使用次数限制,使用的数据库
	;SQLiteFirstUpateDate(101)
	;SQLiteRead(101)
	;$parm_firstdate = $app_date
	;$parm_kpcount = $app_kpcount
	
	;改成使用文本文件来记录
	$parm_kpcount = _HexToString(IniRead("D2KP.dat", "注册", "序号", "0"))
	
	
	
	;$iDateCalc = _DateDiff('D', $parm_firstdate, _NowCalc())
	;-------------以下为限制提醒：
	If $bindTime = 1 Then
		;If $iDateCalc >= 30 Then
		;MsgBox(0, "到期提示", "您购买的软件已到授权期限，请续费")
		;Exit 0
		;EndIf
		;30天即为2592000秒
		;If $parm_kpcount >= 51840 Then   ;超过了这么多次数
		If $parm_kpcount >= 200 Then
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

	#CS 	 	Sleep(1000)
		MouseClick("left", 400, 300, 1)
		Sleep(500)
		MouseClick("left", 700, 560, 1)
		Sleep(500)
		MouseClick("left", 400, 360, 1)
		Sleep(4000)
		
	#CE


	If $testversion = 0 And $connectfailcount >= Random(1, 2) Then
		TrayTip("", "连续多次无法登陆战网或者密码错误，准备暂停..", 1, 16)
		writelog("异常---第 " & $round & " 局连续多次无法登陆战网或者密码错误，系统暂停一段时间！")
		
		$errtime = Random(15, 25) * 60
		For $aa = $errtime To 1 Step -1
			TrayTip("", "挂机下线暂停剩余秒数:" & Round($aa / 60, 1), 1, 16)
			Sleep(1000)
			If $parm_settime = 1 Then ;check if set tiem to shutdown
				tiemtoshut($parm_timedata)
			EndIf
		Next
		$connectfailcount = 0
	EndIf


	
	;以下是进入游戏后移动鼠标了
	Select
		Case isInRoom() And $debugmode = 0
			;$roombegintime = _NowCalc()
			roomplay()
			;$inRoomDateCalc = _DateDiff('s', $roombegintime, _NowCalc())
			;writelog("房间内时间---第 " & $round & " 局用时: " & $inRoomDateCalc & " 秒")
			$optcount = $optcount + 1
			$repeatCreatroom = 0 ; 如果一旦在房间内的话，重复建房间的次数就重置未0
			;Sleep(1000)
			Sleep(Random(200, 400, 1) + $parm_speeddelay)
		Case waitCreatRoom()
			$optcount = $optcount + 1
			$repeatCreatroom = $repeatCreatroom + 1
			
			If $repeatCreatroom = 10 Then ;如果总是重复建房间，到10次的时候按esc 试下
				Send("{ESC}") ;遇到未知的界面,向等待,按ESC
				Sleep(2000)
				Send("{ESC}") ;遇到未知的界面,向等待,按ESC
				Sleep(2000)
				Return
			EndIf
			
			If $repeatCreatroom >= 20 Then ;如果总是重复建房间，但不进游戏
				writelog("异常---第 " & $round & " 局出现建立房间异常，系统暂停挂机！")
				closeAndWait(0)
				$repeatCreatroom = 0
				Return
			EndIf
			TrayTip("", "准备进入游戏。。.", 1, 16)
			Sleep(Random(2000, 3000, 1) + $parm_speeddelay)
			;Sleep(10)
		Case loginnotConnect()
			$connectfailcount = $connectfailcount + 1 ;无法连接战网
			$optcount = $optcount + 1
			TrayTip("", "无法连接战网，重试中。。.", 1, 16)
			;Sleep(1000)
			Sleep(Random(200, 400, 1) + $parm_speeddelay)
		Case pwderror()
			$connectfailcount = $connectfailcount + 1 ;无法连接战网
			$optcount = $optcount + 1
			TrayTip("", "密码错误，重试。。.", 1, 16)
			Sleep(1000)
		Case selectRole()
			$repeatCreatroom = 0 ; 如果退回到选择角色的界面，重复建房间的次数就重置未0
			$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要创建房间.", 1, 16)
			Sleep(2000)
		Case waitInputUsr()
			;$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "检查是否选择角色界面.", 1, 16)
			Sleep(2000)
		Case waitLoginNet()
			;$connectfailcount = $connectfailcount + 1 ;无法连接战网
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要输入用户名密码.", 1, 16)
			Sleep(2000)
		Case waitInGame()
			$optcount = $optcount + 1
			TrayTip("", "等待进入游戏中.", 1, 16)
			Sleep(2000)
		Case $debugmode = 1
			TrayTip("", "手动调试模式中.", 1, 16)
			Sleep(10)
			TrayTip("", "子进程id: " & $PidChild1 & @CR & "不加血：" & $childmsg[0] & @CR & "不加法力：" & $childmsg[1] & @CR & "不加雇佣兵血：" & $childmsg[2] & @CR & "有血瓶：" & $childmsg[3] & @CR & "有蓝瓶：" & $childmsg[4] & @CR & "有紫瓶：" & $childmsg[5] & @CR & "无人进房间：" & $childmsg[6] & @CR & "无人m你：" & $childmsg[7], 1, 16)
			Sleep(2000)
			
		Case Else
			;$optcount = 0
			
			TrayTip("", "等待中，请稍后", 1, 16)
			;Sleep(Random(400, 600, 1) + $parm_speeddelay)
			Sleep(10)
	EndSelect
	
	;;如果$optcount 还为0，表示没执行过任何操作，停留在某个未知界面，
	If $optcount = 0 And $debugmode = 0 Then
		;activeWindow() ;尝试激活界面
		WinActivate($title)
		$ohterImage = $ohterImage + 1 ;增加一个变量来统计出现其他未知界面的中次数
		TrayTip("游戏界面假死或其他异常，等待中", $ohterImage, 1, 16)
		If $ohterImage > 20 Then;循环了100次
			TrayTip($ohterImage, "未找到的合适操作，重试中", 1, 16)
			Sleep(100)
			Send("{ESC}") ;遇到未知的界面,向等待,按ESC
			Sleep(100)
			If $ohterImage > 22 Then;
				Sleep(100)
				Send("{ESC}") ;遇到未知的界面,若按esc还不行的话,则换成按回车看看
				Sleep(1000)
			EndIf
			If $ohterImage > 25 Then;   若按以上回车还不行,则直接结束游戏进程,重新打开,比如遇到程序报错之类
				Sleep(100)
				WinKill($title)
				writelog("异常---第 " & $round & " 局出现未知界面假死或是其他异常，尝试关闭重新开启！")
				#CS 				$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
					If $PID Then ProcessClose($PID)
				#CE
				$ohterImage = 0
				Sleep(1000)
			EndIf
		EndIf
	Else
		$ohterImage = 0 ; 恢复初始状态，不进行累积
	EndIf
	
EndFunc   ;==>runGame

Func activeWindow()
	
	closeError() ;先关闭无效的错误地图窗口

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
		If Run($parm_path1 & " -w -title " & $title & " " & $parm_exeparm3, $parm_path2) = 0 Then
			;Run("F:\暗黑破坏神II毁灭之王1.10\D2loader.exe -w -pdir Plugin -title d2 ", "",@SW_MAXIMIZE )
			
			;Sleep(3000)
			;$handle = WinActivate($title)
			;Send("{ENTER}")
			;If @error <> 0 Then
			MsgBox(32, "错误", "请先设置好正确的路径", 10)
			Exit
		Else
			Sleep(3000)
			$handle = WinGetHandle($title)
			WinWait($title, "")
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
			WinActivate($title)
			;MsgBox(0, "提示", "请先确认游戏是否已是窗口模式！并先进游戏将窗口设置成800*600")
			;Exit 0
		EndIf
	Else
		;MsgBox(0, "提示", "没有找到游戏窗口.")
	EndIf
	initialSize()
EndFunc   ;==>activeWindow

Func roomplay() ;房间内运行的主程序
	$killQuery = 1 ; 每次先固定从kp开始
	If $parm_ramevent = 1 Then
		getRam() ;获取随机事件
	EndIf
	
	If isInRoom() And $guidrinkrej = 1 Then
		;加入随机值，不是每局都检测喝掉紫萍，而是隔几局喝掉
		If Mod($round + 1, 8) = 0 Then
			checkbagRev()
		EndIf
		If Mod($round + 1, 20) = 0 Then
			;a5bianshi()
			;Return
		EndIf
		;drinksurplusInbag("0x943030")
		;drinksurplusInbag("0x1828A4")
	EndIf
	
	If isInRoom() Then
		Select
			Case isInRoom() And $parm_boxing = 1 And bagisfull()
				writelog("包裹---第 " & $round & " 局: " & "包裹已满")
				;Sleep(50)
			Case isInRoom() And $ckroledead = 1 And roleisdead() ;先判断雇佣斌是否死亡。
				writelog("角色---第 " & $round & " 局: " & "角色死亡")
				;Sleep(Random(1, 100, 1))
			Case isInRoom() And $ckact5 = 1 And notinfive() = False ;
				exitRoomWithMap(); 退出房间
			Case isInRoom() And $ckass = 1 And astisdead()
				$repeatrejpet = $repeatrejpet + 1 ;
				TrayTip("", "尝试第" & $repeatrejpet & " 次复活pet", 1, 16)
				Sleep(500)
				If $repeatrejpet >= 2 Then
					Send("{LSHIFT}")
				EndIf
				If $repeatrejpet >= 6 Then ;如果 发现重复执行复活的次数大于 10次，表示可能没钱了。
					writelog("雇佣兵---第 " & $round & " 局: " & "连续多次次重复复活pet，可能是没钱了，自动退出。")
					WinClose($title)
					Sleep(1000)
					Exit 0
				EndIf
				
				TrayTip("", "pet挂了，待复活", 1, 16)
				Sleep(1000)
				resumepet() ;复活雇佣兵
				;exitRoom()
				;exitRoomWithMap()
				writelog("雇佣兵---第 " & $round & " 局: " & "雇佣兵死亡")
				;Sleep(Random(80, 100, 1))
			Case isInRoom() And $parm_imageMode = 2 And ($parm_buyred = 1 Or $parm_buyblue = 1);---是否需要买红药水
				TrayTip("", "检查是否需要买红药水", 1, 16)
				;--先看是否有紫药水，有的话，就不购买
				If CheckpurpleBottle() = 0 And (ChecklifeBottle() = 0 Or CheckmanaBottle() = 0) Then ;如果没找到紫瓶，就交易，有紫瓶就不买
					$repeatbuyred = $repeatbuyred + 1
					If $repeatbuyred >= 3 Then ;如果 发现重复执行复活的次数大于 10次，表示可能没钱了。
						writelog("药水---第 " & $round & " 局: " & "连续多次买红药失败，可能是没钱了，自动退出。")
						WinClose($title)
						Sleep(1000)
						Exit 0
					EndIf
					
					Send("{N}")
					clikcTradeMaraInAct5() ; 点击马拉交易
					Sleep(500)
					MouseMove(400 + Random(1, 10), 300 + Random(1, 5), Random(0, 5, 1))
					Sleep(300)
					If ChecklifeBottle() = 0 Then ;检查红药水
						TrayTip("", "没有红药水，准备购买", 1, 16)
						findbeltWater("heal", "0xA42818")
						tradewater(1)
					EndIf

					If CheckmanaBottle() = 0 Then
						TrayTip("", "没有蓝药水，准备购买", 1, 16)
						findbeltWater("mana", "0x303094")
						tradewater(2)
					EndIf
					MouseClick("left", 430, 460)
					Sleep(600)
					exitRoom()
					
					
				Else
					$repeatbuyred = 0
					TrayTip("", "有药水.", 1, 16)
					ContinueCase
				EndIf
				;Sleep(Random(200, 350, 1))
			Case Else ;比如kp，k山克等
				
				Switch $killQuery ;
					Case 1 ;1先kp
						;检查是否按到了b
						If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
							Send("{ESC}")
							Sleep(500)
						EndIf
						$armrnd = Random(1, 10, 1) ;加入随即，可放，或者不放装甲技能
						If $armrnd = 1 Then
							MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
							armShied()
						EndIf
						
						$shortpath = 0
						If ($parm_path = 1) Then ;如果是随机路线
							;findpath(Random(1, 10, 1))
							TrayTip("", "parm,....1", 1, 16)
							$i = Random(1, 5, 1)
							If $i = 1 Then
								;findpath(11)
								a5clickRight1()
								a5clickRight2()
								a5clickRight3()
								a5clickRight4()
								a5clickRight5()
								
							ElseIf $i = 2 Then
								a5down1()
								If Random(1, 10, 1) = 1 Then
									MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
									armShied()
								EndIf
								a5down2()
							ElseIf $i = 3 Then
								a5downLeft1()
								a5downLeft2()
								;a5clickRight4()
								a5clickRight5()
								
							Else
								a5downLeft1()
								a5downLeft2()
								a5downLeft3()
							EndIf
							
						ElseIf ($parm_path = 2) Then
							TrayTip("", "parm,....2", 1, 16)
							If $parm_imageMode <> 2 Then
								$shortpath = Random(7, 9, 1)
								;$shortpath = 9
								findpath($shortpath) ;最短路线，就是从小站那直线下去
							Else
								$shortpath = Random(7, 9, 1)
								;$shortpath = 9
								;findpath($shortpath) ;最短路线，就是从小站那直线下去
								a5downLeft1()
								a5downLeft2()
								a5downLeft3()
							EndIf
						ElseIf ($parm_path = 3) Then
							TrayTip("", "parm,....3", 1, 16)
							;$shortpath = 11 ;text
							If $testversion = 1 Then ;如果是测试版，就指定一个左边的路径
								findpath(2) ;801 是直接- 测试版本的时候改为走最左边的路线
							Else ;否则，用往下的路线
								If $parm_imageMode <> 2 Then
									TrayTip("", "路径8.........", 1, 16)
									findpath(9) ;
								Else
									;findpath(801)
									$i = Random(1, 5, 1)
									If $i = 1 Then
										a5clickRight1()
										a5clickRight2()
										a5clickRight3()
										a5clickRight4()
										a5clickRight5()
										
									ElseIf $i = 2 Then
										a5down1()
										If Random(1, 10, 1) = 1 Then
											MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
											armShied()
										EndIf
										a5down2()
									ElseIf $i = 3 Then
										a5downLeft1()
										a5downLeft2()
										;a5clickRight4()
										a5clickRight5()
										
									Else
										a5downLeft1()
										a5downLeft2()
										a5downLeft3()
									EndIf
								EndIf
							EndIf
							;findpath(801) 单一路线，就是从小站那直线下去 ，
							;findpath($shortpath) ;
						ElseIf ($parm_path = 4) Then
							TrayTip("", "parm,....4", 1, 16)
							findpath(4) ;  左边稳定的路线，适合对鞋子要求不高的，或是wt也不行的
							
						ElseIf ($parm_path = 5) Then
							;findpath(2) ; 此处可用于定制如109的路线
							TrayTip("", "专用订制路径规划中", 1, 16)
							If $dingZhiFlag = "109" And findpath("109") = False Then
								exitRoom()
							EndIf
							If $dingZhiFlag = "113" And findpath("113") = False Then
								exitRoom()
							EndIf
						EndIf
						
						
						If isInRoom() And finddoor() Then
							If isInRoom() Then ;防止网速慢可能断开了房间
								;CheckMove($Char_CheckMoveDelay)
								If $parm_imageMode = 2 Then
;~ 									CheckMove($Char_CheckMoveDelay)
;~
;~
									;	$coord = PixelSearch(150, 300, 400, 500, 0x18FC00, 30, 2, $title) ;判断是否确实有进红门，下方有标记色  0x18FB01 18FC00 0x00FC19
									;	If Not @error Then
									;	$monsterColor1 = "0x18FC00" ;绿色方块 0x18FC00        ；紫色 0xA420FC
									;	$monsterColor1_hex = "18FC00"
									;	$tp_Pix = countFirepointRec(150, 300, 400, 550, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
									;	If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then

;~ 									$findflag = 0 ;a5right ; 找红门右边这个方块
;~ 									$begin1 = TimerInit()
;~ 									Do
;~ 										If isInTown() == False Then
;~ 											$findflag = 1
;~ 										Else
;~ 											CheckMove($Char_CheckMoveDelay)
;~ 										EndIf
;~ 										$dif = TimerDiff($begin1)
;~ 									Until $findflag = 1 Or $dif >= 3000
;~ 									If isInTown() == False Then ;看是否在城内
;~ 									Else ;没找到的情况下，退出房间
;~ 										WinActivate($title)
;~ 										Sleep(1000)
;~ 										exitRoomWithMap()
;~ 										Return
;~ 									EndIf
									
								EndIf
;~

								TrayTip("", "战斗前准备.", 1, 16)
								;afterReady()
								TrayTip("", "向暴躁外皮移动.", 1, 16)
								movekp() ;路径需要优化，防止同一落脚点
								Sleep(Random(20, 50, 1))
								CheckMove($Char_CheckMoveDelay)
								TrayTip("", "释放技能.", 1, 16)
								$fireround = $round ;把局数传个 fire
								
								If $parm_imageMode <> 2 Then
									fire(2) ;109 方式
								Else
									If $dingZhiFlag = "109" Then
										fire(2)
									Else
										fireMonsterByBlock(400, 20, 790, 520, 1, 10000) ; 借助mod，锁定红色方框的攻击方式
									EndIf
								EndIf
								;fire("109")
								
								TrayTip("", "寻找物品.", 1, 16)
								finditem($parm_picktime)
								TrayTip("", "退出房间.", 1, 16)
								If $onlykp = 1 Then ;如果109，就不k其他的
									If $dingZhiFlag = "109" Then
										exitRoom()
									Else
										exitRoomWithMap()
									EndIf
								Else
									ReturnToTownWithMap()
									Sleep(Random(1500, 1800, 1) + $parm_speeddelay)
								EndIf

								$round = $round + 1
								$tfcount = $tfcount + 1
								$tfclosecount = $tfclosecount + 1
								$movebagcount = $movebagcount + 1
								
								
								_GUICtrlStatusBar_SetText($StatusBar1, "KP次数: " & $round & "  累计kp次数： " & $parm_kpcount + 1, 1)
								$parm_kpcount = $parm_kpcount + 1
								;SQLiteInsert(101, "", $parm_kpcount)
								IniWrite("D2KP.dat", "注册", "序号", _StringToHex($parm_kpcount))
								If $onlykp <> 1 Then
									$killQuery = 2 ; 把标记位改为其他，就下局就可以k其他怪了
								Else
									$killQuery = 1
								EndIf
							EndIf
						EndIf
						If $onlykp <> 1 Then
							ContinueCase
						EndIf
						
					Case 2 ;杀督军山克上面的怪
						TrayTip("", "杀2.。。。。。。。.", 1, 16)
						$topleft = False
						$bottomright = False
						
						MouseClick("left", 135 + Random(1, 10), 400 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						MouseClick("left", 280 + Random(1, 10), 400 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						MouseClick("left", 380 + Random(1, 10), 350 + Random(1, 10), Random(1, 2, 1))
						CheckMove($Char_CheckMoveDelay)
						;找小站的图片
						$coord = finda5xiaozhan() ;找到柴草的位置
						;ConsoleWrite(TimerDiff($t1) & @CRLF)
						If $coord[0] >= 0 And $coord[1] >= 0 Then
							TrayTip("", "进入小站", 9, 16)
							Sleep(50)
							MouseMove($coord[0], $coord[1]);
							MouseClick('left', $coord[0] + 10, $coord[1] + 20)
							CheckMove($Char_CheckMoveDelay)
							;Sleep(1000)
						Else
							exitRoom()
							TrayTip("", "找小站失败。。。。", 9, 16)
							Sleep(1000)
						EndIf
						
						MouseClick("left", 160 + Random(1, 10), 165 + Random(1, 10), 1)
						Sleep(3000)
						;到达第二个小站后，开始判断是否到达
						$outtown = 0
						$begin1 = TimerInit()
						Do
						If isInTown() = true Then
							Sleep(1000)
						Else
							Break
						EndIf
						$dif = TimerDiff($begin1)
						Until $outtown = 1 Or $dif >= 3000
					
						MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
						$coord1 = PixelSearch(20, 20, 400, 300, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$topleft = True
							TrayTip("", "上方标记点", 1, 16)
							;MouseMove($coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5))
						EndIf
						
;~ 						$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 30, 1, $title)
;~ 						If Not @error Then
;~ 							$bottomright = True
;~ 							TrayTip("", "下方标记点", 1, 16)
;~ 							;MouseMove($coord[0] + Random(1, 5), $coord[1] + Random(1, 5))
;~ 						EndIf
						
						If $topleft = True And $bottomright = True Then ;;上下都有标记位，到达指定地点，可以杀怪
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							Else
								Send("{" & $char_tpFire & "}")
							EndIf
							$a = Random(1, 3)
							If $a = 1 Then
								MouseClick("right", $coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5), 1)
								CheckMove($Char_CheckMoveDelay)
								Sleep(200)
								MouseClick("right", 420 + Random(1, 10), 80 + Random(1, 10), Random(1, 2))
								CheckMove($Char_CheckMoveDelay)
								Sleep(200)
								MouseClick("right", 420 + Random(1, 10), 120 + Random(1, 10), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
							Else
								MouseClick("right", $coord1[0] + Random(1, 10), $coord1[1] + Random(1, 20), 1)
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
								MouseClick("right", 420 + Random(1, 20), 100 + Random(1, 20), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
								MouseClick("right", 420 + Random(1, 20), 100 + Random(1, 20), Random(1, 2))
								Sleep(200)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							;fireMonsterByBlock(100, 20, 790, 520, 0) ; 借助mod，锁定红色方框的攻击方式
							fireMonsterByColor(20, 20, 790, 560, 0)
							TrayTip("", "寻找物品.", 1, 16)
							finditem($parm_picktime)
							;TrayTip("", "退出房间.", 1, 16)
							;ReturnToTownWithMap()
							;exitRoom()
							$killQuery = 3 ; 改为1，就可以kp去了
						Else
							exitRoom() ;
						EndIf
						
						ContinueCase
						
					Case 3 ;杀山克
						;检查是否按到了b
						If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
							Send("{ESC}")
							Sleep(500)
						EndIf
						$topleft = False
						$bottomright = False
						
						Send("{" & $char_tpFire & "}")
						$xrd = Random(-2, 2, 1)
						$yrd = Random(-2, 2, 1)
						$findflag = 0
						$begin1 = TimerInit()
						Do
							If isInRoom() Then
								$coord = PixelSearch(10, 300, 700, 400, 0x18FC00, 10, 1, $title) ;0x118FB01
								If @error Then
									TrayTip("", "瞬移中...", 1, 16)
									$i = Random(1, 2, 1)
									If $i = 1 Then
										MouseClick("right", 380 + $xrd, 400 + $yrd, Random(1, 3)) ;50
									Else
										MouseClick("right", 370 + $xrd, 450 + $yrd, Random(1, 3)) ;50
									EndIf
									Sleep(200)
									$findflag = 0
								Else
									$findflag = 1
									MouseClick("right", $coord[0], $coord[1], Random(1, 3)) ;50
									Sleep(500)
								EndIf
							Else
								Return
							EndIf
							$dif = TimerDiff($begin1)
						Until $findflag = 1 Or $dif >= 10000
						
						MouseClick("right", 500, 500, 1) ;50
						Sleep(500)
						
						;到达第二个小站后，开始判断是否到达
						MouseMove(400 + Random(1, 10), 300 + Random(1, 10))
						$coord1 = PixelSearch(20, 20, 400, 300, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$topleft = True
							TrayTip("", "上方标记点", 1, 16)
							;MouseMove($coord1[0] + Random(1, 5), $coord1[1] + Random(1, 5))
						EndIf
						
						$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 30, 1, $title)
						If Not @error Then
							$bottomright = True
							TrayTip("", "下方标记点", 1, 16)
							;MouseMove($coord[0] + Random(1, 5), $coord[1] + Random(1, 5))
						EndIf
						
						If $topleft = True And $bottomright = True Then ;;上下都有标记位，到达指定地点，可以杀怪
							
							;fireMonsterByBlock(400, 200, 790, 585, 0) ; 到达目的地后先检查四周，有怪就先释放技能
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf


							$coord = PixelSearch(400, 300, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(20, 25), $coord[1] + Random(20, 25))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(400, 10, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(40, 45), $coord[1] + Random(180, 190))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(500, 300, 780, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(100, 120), $coord[1] + Random(40, 45))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(410, 300, 750, 560, $biaojicolor1, 10, 1, $title)
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(5, 12), $coord[1] + Random(200, 220))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(500, 300, 780, 560, $biaojicolor1, 10, 1, $title) ;达到楼梯下方的打怪点，可以打怪
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] - Random(55, 60), $coord[1] + Random(40, 45))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf

							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(420, 250, 600, 500, $biaojicolor1, 10, 1, $title) ;到达中间打怪点
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(150, 160), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0)
							Sleep(10)
							If $fire = 1 Then
								Send("{" & $char_tpFire & "}")
							ElseIf $fire = 2 Then
								
							EndIf
							$coord = PixelSearch(420, 200, 790, 500, $biaojicolor1, 10, 1, $title) ;到达最右边一个标志点
							If Not @error Then
								$bottomright = True
								TrayTip("", "到达指定地点", 1, 16)
								MouseMove($coord[0] + Random(10, 15), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							;此处可增加捡东西，比如线判断左边，左边捡完，再回到标志点，再判断右边捡东西
							finditembyzone(50, 50, 400, 500, $parm_picktime)
							$coord = PixelSearch(420, 200, 790, 500, $biaojicolor1, 10, 1, $title) ;到达最右边一个标志点
							If Not @error Then
								$bottomright = True
								TrayTip("", $coord[0] & "  " & $coord[1], 1, 16)
								MouseMove($coord[0] + Random(10, 15), $coord[1] + Random(130, 140))
								MouseClick("right", Default, Default, 1)
								CheckMove($Char_CheckMoveDelay)
							EndIf
							
							fireMonsterByColor(20, 20, 790, 560, 0) ;可以打怪
							TrayTip("", "寻找物品.", 1, 16)
							finditem($parm_picktime)
							TrayTip("", "退出房间.", 1, 16)
							exitRoom()
							$killQuery = 1 ; 改为1，就可以kp去了

						Else
							exitRoom() ;
						EndIf
						
						
				EndSwitch
		EndSelect
	EndIf
EndFunc   ;==>roomplay


Func finditem($parm_picktime)
	Sleep(10)
	MouseMove(400 + Random(1, 80, 1), 300 + Random(1, 80, 1), Random(1, 8, 1))
	;此处增加一个对91d2垃圾信息的判断功能，先检测垃圾信息，如果有，就缩小范围
	
	
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		
		If $parm_path <> 5 Then
			$coord = PixelSearch(20, 80, 50, 90, 0x1CC40C, 30, 2, $title)
			If Not @error Then
				TrayTip("", "其他信息....", 1, 16)
				Send("{N}")
				Sleep(10)
				Send("{N}")
				Sleep(20)
			EndIf
		EndIf
		
		$coord = PixelSearch(200, 20, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1, 16)
			MouseMove($coord[0], $coord[1] + 5, Random(1, 10, 1))
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
			MouseClick("left", Default, Default, 1) ;鼠标左建点东西
			Sleep(1500)
			CheckMove($Char_CheckMoveDelay)
			;此处有心灵传送检东西
			#CS 				 				Send("{F6}")
				Sleep(100)
				MouseClick("right", Default, Default, 1)
				Sleep(500)
			#CE
			;MouseClick("left", $coord[0], $coord[1] + 5, 1)
			
		EndIf
		Sleep(10)
	Next
	Send("{ALT up}")
	Sleep(10)
	For $i = Random(2, 4, 1) To 1 Step -1
		Send("{LALT}")
	Next

EndFunc   ;==>finditem

Func finditembyzone($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, $parm_picktime)
	Sleep(10)
	MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 50, 1))
	Sleep(20)
	;此处增加一个对91d2垃圾信息的判断功能，先检测垃圾信息，如果有，就缩小范围
	$coord = PixelSearch(200, 50, 300, 100, 0x1CC40C, 30, 1, $title)
	If Not @error Then
		TrayTip("", "出现战网发布信息，请留意", 1, 16)
		;MouseClick("left", 450, 100, 2) ;往左上走下
		Send("{N}")
		Sleep(500)
	Else ;如果没出现
		
		Send("{ALT down}")
		For $i = 1 To $parm_picktime Step 1
			$coord = PixelSearch($XBS_Start, $YBS_Start, $XBS_Stop, $YBS_Stop, 0x1CC40C, 30, 1, $title)
			If Not @error Then
				TrayTip("", "捡起需要的物品", 1, 16)
				MouseMove($coord[0], $coord[1] + 5)
				Sleep(50)
				MouseClick("left", Default, Default, 1) ;鼠标左建点东西
				Sleep(1500)
			EndIf
			Sleep(100)
		Next
		Send("{ALT up}")
		
	EndIf
EndFunc   ;==>finditembyzone

Func movekp()
	$xrd = Random(-3, 3, 1)
	$yrd = Random(-3, 3, 1)
	;TrayTip("", "启用随机路径" & "坐标迷惑偏移" & $xrd & $yrd, 1, 16)
	TrayTip("", "启用随机路径", 1, 16)
	If $fire = 1 Then
		Send("{" & $char_tpFire & "}")
	ElseIf $fire = 2 Then
		
	EndIf
	
	; 如果路径是用专用订制，就指定
	If $parm_path = 5 Or $parm_imageMode <> 2 Then
		MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
		;CheckMove(600)
		Sleep(350 + $parm_speeddelay)
		;Sleep(600)
		MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
		;MouseClick("right", 590 + $xrd, 110 + $yrd, 1)
		;CheckMove(600)
		Sleep(350)
		Return
	EndIf
	
	
	;如果不是专用订制，就用1.11的
	Sleep(Random(10, 50))
	$kppath = 4 ;Random(1, 10, 1)
	If $testversion = 1 Then
		$kppath = 1
	EndIf
	;以下是tp的路径，1是tp 4次。
	;Sleep(350 + $parm_speeddelay)
	;MouseMove(740 + $xrd, 120 + $yrd)  ;对cpu虚拟机不行的
	;Sleep(350 + $parm_speeddelay)     ;对cpu虚拟机不行的
	Switch $kppath ;gm 可能会根据tp次数来查日志，需改为不固定的为好
		Case 1
			MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
			;CheckMove(600)
			Sleep(350 + $parm_speeddelay)
			;Sleep(600)
			MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
			;MouseClick("right", 590 + $xrd, 110 + $yrd, 1)
			;CheckMove(600)
			Sleep(350)
			;Sleep(600)
		Case 2
			MouseClick("right", 480 + $xrd, 50 + $yrd, 1) ;120
			Sleep(350 + $parm_speeddelay)
			;MouseMove(750,50)
			MouseClick("right", 630 + $xrd, 150 + $yrd, 1) ;50
			Sleep(350 + $parm_speeddelay)
			;MouseMove(750,50)
			MouseClick("right", 630 + $xrd, 180 + $yrd, 1) ;30
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 630, 150, 1) ;30
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 630, 180, 1) ;30
			Sleep(350 + $parm_speeddelay)
		Case 3
			MouseClick("right", 700 + $xrd, 60 + $yrd, 1) ;120
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 700 + $xrd, 60 + $yrd, 1) ;50
			Sleep(350 + $parm_speeddelay)
			MouseClick("right", 700 + $xrd, 70 + $yrd, 1) ;30
			Sleep(350 + $parm_speeddelay)
			
			MouseClick("left", 500 + $xrd, 255 + $yrd, Random(1, 2, 1))
			;MouseClick("right", 500 + $xrd, 240 + $yrd, 1) ;30
			Sleep(100)
		Case Else
			;用找绿色标记的方式tp
			$xrd = 1
			$yrd = 1
			$beginAttackTime = TimerInit()
			$i = Random(1, 3, 1)
			Switch $i
				Case 1
					$first_left = 630 + $xrd
					$first_right = 120 + $yrd
				Case 2
					$first_left = 630 + $xrd
					$first_right = 100 + $yrd
				Case 3
					$first_left = 620 + $xrd
					$first_right = 90 + $yrd

			EndSwitch

			MouseClick("right", $first_left, $first_right, Random(1, 3)) ;50
			Sleep(200 + $parm_speeddelay)
			$findflag = 0
			$i = Random(1, 2, 1)
			Switch $i
				Case 1
					Do
						If isInRoom() Then
							$coord = PixelSearch(10, 10, 700, 300, 0x18FC00, 10, 1, $title) ;0x118FB01
							If @error Then
								TrayTip("", "瞬移中...", 1, 16)
								$i = Random(1, 2, 1)
								If $i = 1 Then
									MouseClick("right", 540 + $xrd, 150 + $yrd, Random(1, 3)) ;50
								Else
									MouseClick("right", 500 + $xrd, 130 + $yrd, Random(1, 3)) ;50
								EndIf
								Sleep(200 + $parm_speeddelay)
								$findflag = 0
							Else
								$findflag = 1
							EndIf
						Else
							Return
						EndIf
						$dif = TimerDiff($beginAttackTime)
					Until $findflag = 1 Or $dif >= 15000
				Case 2
					Do
						If isInRoom() Then
							$coord = PixelSearch(10, 10, 700, 300, 0x18FC00, 20, 2, $title)
							If @error Then
								TrayTip("", "瞬移中...", 1, 16)
								MouseClick("right", 550 + $xrd, 180 + $yrd, Random(1, 3)) ;50
								Sleep(250 + $parm_speeddelay)
								$findflag = 0
							Else
								$findflag = 1
							EndIf
						Else
							Return
						EndIf
						$dif = TimerDiff($beginAttackTime)
					Until $findflag = 1 Or $dif >= 10000
			EndSwitch
			
			
			
			$coord = PixelSearch(10, 5, 500, 300, 0x18FC00, 20, 2, $title) ; 找到左上角的绿色标记后，tp 到它的右边
			If Not @error Then
				TrayTip("", "继续tp2", 1, 16)
				If $coord[0] + 250 >= 790 Or $coord[1] + 120 >= 580 Then ;判断是否越界，若越界，可能是飞过了
					TrayTip("", "继续tp2异常", 1, 16)
					Sleep(300 + $parm_speeddelay)
					MouseClick("right", $coord[0], $coord[1] + Random(120, 125), Random(1, 3, 1))
				Else
					MouseClick("right", $coord[0] + Random(250, 255), $coord[1] + Random(120, 125), Random(1, 3, 1))
					Sleep(300 + $parm_speeddelay)
				EndIf
			EndIf
			
			;下面是找上下两个标记位，tp入老p房间
			$findflag = 0
			$beginAttackTime = TimerInit()
			Do
				;CheckMove($Char_CheckMoveDelay)
				$coord = PixelSearch(10, 5, 700, 300, 0x18FC00, 30, 1, $title) ;
				If Not @error Then
					$coord1 = PixelSearch(350, 280, 790, 560, 0x18FC00, 25, 2, $title) ; 看它右下方有没有绿色标记，有的话，表示在两个标记中间
					If Not @error Then
						TrayTip("", "继续tp3.。。", 1, 16)
						If $coord1[0] + 130 >= 790 Or $coord1[1] - 205 >= 580 Then ;判断是否越界，若越界，可能是飞过了
							TrayTip("", "继续tp3.异常。。", 1, 16)
							exitRoomWithMap()
						Else
							MouseClick("right", $coord1[0] + 130 + Random(5, 10, 1), $coord1[1] - Random(205, 210, 1), Random(1, 3, 1)) ;右边参照
							Sleep(200 + $parm_speeddelay)
							;CheckMove($Char_CheckMoveDelay)
							$coord2 = PixelSearch(10, 20, 350, 300, 0x18FC00, 30, 1, $title) ; 再次判断是否tp 到房间里了，左上找不到标记了
							If @error Then
								$findflag = 1
								;Sleep(1000)
							Else
								CheckMove($Char_CheckMoveDelay)
							EndIf
						EndIf
						
					Else
						;判断左下方是否有，表示tp 过了，可能已经到了房间里面
						$coordLeft = PixelSearch(2, 350, 200, 560, 0x18FC00, 30, 1, $title) ;看到位置后，找到相应位置的地方,
						If Not @error Then ;修正方向
							TrayTip("", "修正tp。。", 1, 16)
							If $coordLeft[0] + 250 >= 790 Or $coordLeft[1] + 120 >= 580 Then ;判断是否越界，若越界，可能是飞过了
								TrayTip("", "修正tp。异常。", 1, 16)
								exitRoomWithMap()
							Else
								MouseClick("right", $coordLeft[0] + Random(250, 255), $coordLeft[1] + Random(120, 125), Random(1, 3, 1))
								Sleep(300 + $parm_speeddelay)
							EndIf
						Else
							TrayTip("", "飞过了。。", 1, 16)
							;MouseClick("right", $coord[0] + Random(250, 255), $coord[1] + Random(120, 125), Random(1, 3, 1))
							exitRoomWithMap()
							Sleep(300 + $parm_speeddelay)
						EndIf
					EndIf
				Else
					TrayTip("", "继续调整tp。。", 1, 16)
					;Sleep(1000)
					;Return
				EndIf
				$dif = TimerDiff($beginAttackTime)
			Until $findflag = 1 Or $dif >= 8000

			
			
			
;~ 			$coord = PixelSearch(10, 5, 700, 300, 0x118FB01, 10, 1, $title) ;看到位置后，找到相应位置的地方
;~ 			If Not @error Then
;~ 				$coord1 = PixelSearch(350, 280, 790, 560, 0x118FB01, 10, 1, $title) ;看到位置后，找到相应位置的地方,
;~ 				If Not @error Then
;~ 					TrayTip("", "继续tp2", 1, 16)
;~ 					;MouseClick("right", $coord[0] + 550, $coord[1] - 10, Random(1, 2,1))  ;左边参照
;~ 					MouseClick("right", $coord1[0] + 150 + Random(5, 10, 1), $coord1[1] - Random(205, 210, 1), Random(1, 2, 1)) ;右边参照
;~ 					Sleep(350 + $parm_speeddelay)
;~ 				Else
;~ 					exitRoomWithMap()
;~ 				EndIf
;~ 			Else
;~ 				exitRoomWithMap()
;~ 			EndIf

			
	EndSwitch

EndFunc   ;==>movekp
Func fire($var = 1)
	takefire($var, $parm_blztime, $parm_blzrnd)
EndFunc   ;==>fire

Func isInTown() ; 在城镇中
	;If findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = True Then
	If isInRoom() = True And findPointColor(125, 595, "2C1008") = True Then ;28241C  外
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>isInTown

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
	If isInRoom() = False And findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") Then
		If $parm_gamemode = 1 Then
			MouseClick("left", 400 + Random(-50, 50), 350 + Random(-2, 2))
			Return True
		Else
			TrayTip("", "单机模式", 1, 16)
			;单机
			MouseClick("left", 400, 300, 1)
			Sleep(500)
			MouseClick("left", 700, 560, 1)
			Sleep(500)
			MouseClick("left", 400, 360, 1)
			Sleep(4000)
			Return False
		EndIf
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;进入战网，判断是否准备点battle
	If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") Then
		MouseClick("left", 360 + Random(-50, 50), 430 + Random(-5, 5))
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;进入战网，判断是否准备输入账号密码
	If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") Then
		MouseClick("left", 400 + Random(-50, 50), 340 + Random(-1, 1), 2)
		Sleep(500)
		;ControlSend($title, "", "", $usr,1)
		Send($usr, 1) ;如果有下划线等，就用这个
		Sleep(1500)
		MouseMove(400 + Random(-5, 5), 390 + Random(-1, 1))
		Sleep(1000)
		MouseClick("left", 400 + Random(-5, 5), 390 + Random(-5, 5), 2)
		Sleep(500)
		;ControlSend($title, "", "", $psd, 1)
		Send($psd, 1)
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
			$i = Random(1, 3)
			If $i = 1 Then
				MouseMove(400 + Random(-10, 10), 390 + Random(-2, 2))
				Sleep(500)
				MouseClick("left", Default, Default)
			Else
				Send("{ENTER}")
			EndIf
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
		Sleep(2000)
		$i = Random(1, 3)
		If $i = 1 Then
			Send("{ENTER}")
		Else
			MouseMove(690 + Random(-50, 50), 550 + Random(-2, 2))
			Sleep(1000)
			MouseClick("left", Default, Default)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>selectRole
Func waitCreatRoom()
	;进入战网，判断是否准备建房间
	;If findPointColor(30, 585, "040404") And findPointColor(325, 585, "040404") Then
	;If findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") And findPointColor(180, 350, "040404") Then ; 109 的测试
	If isInRoom() = False And findPointColor(10, 250, "141414") And findPointColor(10, 350, "4C4C4C") Then ; 109 的测试	 ttbn 测试
		TrayTip("", "进入战网大厅,准备建立房间..", 1, 16)
		;如果找到，表示是在大厅
		;建房间，判断是否出现对话框，如无法建立，同名等提示，中间会出现对话框
		Sleep(Random(50, 3000));随机，防止每次建房间的间隔都相同
		;If findAreaColor(300, 200, 380, 250, 0xC4C4C4, 0, 1, $title) Then
		If isInRoom() = False And findPointColor(385, 250, "040404") = False Then
			;Send("{ENTER}") ;原来是enter
			MouseClick("left", 400 + Random(1, 10), 320 + Random(1, 10))
			Sleep(500)
			Return True
		ElseIf isInRoom() = False And findPointColor(445, 410, "786C60") = True Then
			
			$createroominqueecount = $createroominqueecount + 1
			If $createroominqueecount >= 3 Then
				Sleep(1000 * 60 * 20)
				$createroominqueecount = 0
			EndIf
			
			TrayTip("", "需要等待排队，重试..", 1, 16)
			Send("{ESC}") ;原来为enter键
			Sleep(500)
			Return True
		Else
			$createroominqueecount = 0
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

Func waitInGame() ;等待进入游戏中 ,画面四周都是黑框,中间红门慢慢打开
	If findPointColor(100, 100, "000000") = True And findPointColor(100, 600, "000000") = True And findPointColor(500, 100, "000000") = True And findPointColor(500, 600, "000000") = True Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitInGame
Func createRoom() ;建立战网游戏房间名
	;/进入游戏界面，点击按钮进入战网
	;MouseClick("left", 600, 455, 1)
	;//进入战网
	;MouseClick("left", 700, 455)   ;先点下加入游戏
	MouseClick("left", 600 + Random(-50, 50), 455 + Random(-2, 2))
	;MouseClick("left", 705, 378) ;选地狱难度
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
	ElseIf $nameCat = 3 Then
		If $parm_namepre = "" Then ;如果前缀没有填，则随机弄一个
			$parm_namepre = Chr(Random(97, 117, 1)) & Chr(Random(97, 117, 1))
		EndIf
		ControlSend($title, "", "", $parm_namepre & $ct)
		$ct = $ct + 1
	Else ;其他情况，比如玩家就想几个固定的名字
		If $parm_namegd = "" Then
			$parm_namegd = Random(111, 333, 1)
		EndIf
		ControlSend($title, "", "", $parm_namegd)
	EndIf

	Sleep(Random(400, 500, 1))
	If isInRoom() = False Then ;加入防止进入游戏后还有点击
		MouseClick("left", 680 + Random(1, 5), 410 + Random(1, 10), 1)
	EndIf
	Sleep(50)
EndFunc   ;==>createRoom

Func exitRoom()
	Sleep(100)
	Send("{ESC}")
	Sleep(10)
	MouseClick("left", 400 + Random(1, 50), 250 + Random(1, 10), 1)
	Sleep(10)
EndFunc   ;==>exitRoom

Func ReturnToTownWithMap()
	Sleep(100)
	Send("{BS}")
	Sleep(1000)
EndFunc   ;==>ReturnToTownWithMap

Func exitRoomWithMap()
	Sleep(100)
	Send("{-}")
	Sleep(10)
EndFunc   ;==>exitRoomWithMap

Func finddoor() ;找红门的程序
	TrayTip("", "寻找红门.", 1, 16)
	Sleep(Random(1, 1, 1))
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 100
	$top = 50
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
;~ 	;此处可以加个 用图片找图的方式
;~ 		$coord = findreddoor1() ;找到柴草的位置
;~ 		;ConsoleWrite(TimerDiff($t1) & @CRLF)
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			MouseClick('left', $coord[0] +10 , $coord[1] + 50)
;~ 		Else
;~ 			TrayTip("", "没有找到", 9, 16)
;~ 	       Sleep(2000)
;~ 		EndIf

	;针对win7
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		TrayTip("", "找到红门！", 1, 16)
		$notfinddoorCount = 0 ;如果找到红门，就把未找到红门的标记次数改为0
		$x = $coord[0]
		$y = $coord[1]
		MouseMove($x, $y, Random(1, 10))
		Sleep(Random(50, 80, 1))
		MouseClick("left", Default, Default, 1)
		;MouseClick("left", $x, $y, 1)
		;Sleep(Random(1400, 1600, 1))
		CheckMove($Char_CheckMoveDelay)
		Return True
	Else
		TrayTip("", "红门未找到！准备退出房间", 1, 16)
		Sleep(500)
		exitRoom()
		$notfinddoorCount = $notfinddoorCount + 1
		
		If $notfinddoorCount >= 2 Then
			Send("{LSHIFT}")
		EndIf
		
		If $notfinddoorCount >= 10 Then ;如果10次以上连续没找到红门，表示可能不在act5，或者是人物鞋子速度不够
			TrayTip("", "20次以上未找到红门，请检查！.", 1, 16)
			writelog("异常---第 " & $round & " 局多次以上未找到红门，停止挂机！")
			WinClose($title)
			Exit 0
		EndIf
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
	If isInRoom() = True And $checkbag = 1 And $parm_MoveBox = 1000 Then ;不用
		Send("{" & $char_Bag & "}")
		Sleep(100)
		MouseMove(300, 440)
		Sleep(100)
		InitialBagCheck()
		$emptybag = getbagLocation()
		TrayTip("", "检查背包剩余数量：" & $emptybag, 1, 16)
		Sleep(400)
		
		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;如果都有物品占用，表示包裹满了
			TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{" & $char_Bag & "}")
			Sleep(500)
			
			If $boxisfull = 0 Then ;如果记录仓库已满的表示 =1 ，表示满了，就不用再存仓库里，0 去存仓库
				checkbagRev()
				;a5bianshi() 此处可以增加一个辨识
				gotoBox()
				If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
					;movebagtoBox()
					mapmove() ;添加一个用地图转移包裹的测试
					Sleep(100)
					exitRoom()
					Return True
				Else
					exitRoom()
					Return True
				EndIf
			EndIf
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;如果用户选择了包裹满了关机,则提示
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "正在执行关机", 1, 16)
				writelog("包裹---第 " & $round & " 局: " & "包裹满，准备关机")
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
			
		Else
			Send("{" & $char_Bag & "}")
			Return False
		EndIf
		#CS 	Else
			Return False
		#CE
	EndIf
	
	If isInRoom() = True And $checkbag = 1 And $parm_MoveBox = 2 Then ;启用固定ＫＰ局数的转移
		
		If $movebagcount >= $parm_moveround + Random(0, 0, 1) Then ;加入随机值
			;If $movebagcount >= $parm_moveround  Then
			InitialBagCheck() ;先初始化包裹空间
			;定义一个局数，用于装箱的
			If $boxisfull = 0 Then ;如果记录仓库已满的表示 =1 ，表示满了，就不用再存仓库里，0 去存仓库
				;包裹转移前，先喝掉多余的药水
				checkbagRev();
				;a5bianshi() 此处可以增加一个辨识
				;----包裹转移前，先喝掉多余的药水
				gotoBox()
				If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 400, "101010") = True And findPointColor(750, 200, "202020") = True And findPointColor(750, 400, "1C1C1C") = True Then
					;movebagtoBox()
					$movebagcount = 0 ;初始化为０　，以好下次重新开始计算装箱
					mapmove() ;添加一个用地图转移包裹的测试
					Sleep(100)
					exitRoom()
					Return True
				Else
					exitRoom()
					Return True
				EndIf
			EndIf
			
			$emptybag = getbagLocation()
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;如果用户选择了包裹满了关机,则提示
				Sleep(100)
				exitRoom()
				Sleep(2000)
				TrayTip("", "正在执行关机", 1, 16)
				writelog("包裹---第 " & $round & " 局: " & "包裹满，准备关机")
				Sleep(1000)
				Shutdown(1)
				Sleep(1000)
				Exit 0
				Return True
			EndIf
		Else
			Return False
		EndIf
	Else
		Return False
	EndIf
	
	
EndFunc   ;==>bagisfull


Func notinfive()
	TrayTip("", "检查是否在act5", 1, 16)
	Sleep(10)
	;现在通过取点判断
	If isInRoom() Then
		
;~ 		;通过检查雇佣兵来判断即可
;~ 		If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x008400, 0, 1, $title) = True Then ;如果左上找到雇佣兵，是在act5了，那就不需要了
;~ 			Return False
;~ 		EndIf
;~
;~ 		;0x016616 在其他act 的颜色
;~ 		If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = True Then ;如果左上找到雇佣兵的，且是在act4， 那就去act5
;~ 			;in act4
;~ 			TrayTip("", "在act4，准备去act5场景..", 1, 16)
;~ 			Sleep(300)
;~ 			MouseMove(740, 80)
;~ 			Sleep(500)
;~ 			MouseClick("left", Default, Default, 1)
;~ 			;MouseClick("left", 740, 80, 1)
;~ 			Sleep(2000)
;~ 			MouseClick("left", 340, 80, 1)
;~ 			Sleep(200)
;~ 			MouseClick("left", 340, 140, 1)
;~ 			Sleep(2000)
;~ 			exitRoom()
;~ 			Return True
;~ 		EndIf
		
		$coord = PixelSearch(200, 20, 500, 200, 0x118FB01, 25, 2, $title)
		If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
			; 再次检查下方，没有放开才对
			$coord1 = PixelSearch(10, 300, 570, 520, 0x118FB01, 25, 2, $title)
			If Not @error Then
				Return False
			Else
				Return True
			EndIf
		Else
			Return False
		EndIf
		
	Else
		Return False ;如果都不在房间内，就返回
	EndIf
	;MouseMove(280,80) ;act4 1    2C2C2C   4C4C4C
	;MouseMove(320,80) ;act4 2    242424   404040
	;MouseMove(350,80) ;act5 1   2C2C2C    181818
	;MouseMove(380,80) ;act5 2   242424   101010
	
EndFunc   ;==>notinfive


Func astisdead()
	TrayTip("", "检查pet挂了没", 1, 16)
	Sleep(1)
	If isInRoom() Then
		;If checkOpenStat() = False And findAreaColor(15, 5, 50, 20, 0x008400, 0, 1, $title) = False And findAreaColor(15, 5, 50, 20, 0x007C00, 0, 1, $title) = False Then ;如果左上没找到雇佣兵的,或者检查到pet是在act4的颜色
		If CheckpetStatus() = 0 And isInTown() = True Then ;改用新func
			#CS 			$repeatrejpet = $repeatrejpet + 1 ;
				TrayTip("", "尝试第" & $repeatrejpet & " 次复活pet", 1, 16)
				Sleep(500)
				If $repeatrejpet >= 10 Then ;如果 发现重复执行复活的次数大于 10次，表示可能没钱了。
				writelog("雇佣兵---第 " & $round & " 局: " & "连续10次重复复活pet，可能是没钱了，自动退出。")
				WinClose($title)
				Sleep(1000)
				Exit 0
				EndIf
				
				TrayTip("", "pet挂了，待复活", 1, 16)
				Sleep(1000)
				resumepet()
				exitRoom()
			#CE
			Return True
			
		Else ;如果有，表示雇佣兵在的
			$repeatrejpet = 0 ;重置为 0
			Return False
		EndIf
		
	Else
		Return False
	EndIf
	#CS
		;------------------------------ 这一段是新增的
		Send("{O}")
		Sleep(300)
		;MouseMove(400, 300)
		;Sleep(50)
		;$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
		$a = PixelChecksum(160, 100, 200, 150, $title) ;   ;1649310059
		Sleep(300)
		Send("{O}")
		Sleep(300)
		If $a <> 1649310059 Then
		; -------------------------
		$repeatrejpet = $repeatrejpet + 1 ;
		TrayTip("", "尝试第" & $repeatrejpet & " 次复活pet", 1, 16)
		Sleep(500)
		If $repeatrejpet >= 10 Then ;如果 发现重复执行复活的次数大于 10次，表示可能没钱了。
		writelog("雇佣兵---第 " & $round & " 局: " & "连续10次重复复活pet，可能是没钱了，自动退出。")
		WinClose($title)
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
	#CE
	


EndFunc   ;==>astisdead

Func resumepet()
	
	If $parm_imageMode = 2 And $dingZhiFlag = 109 Then
		MouseClick("left", 60, 220)
		Sleep(2000)
		$coord = findtianshi()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			TrayTip("", $coord[0] & $coord[1], 9, 16)
			MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0], $coord[1] + 20)
			Sleep(2000)
			MouseMove(356, 130)
			MouseClick("left", 356, 130, 1)
			;MouseMove(356,135)      ; 复活pet
			;MouseClick("left",356,135,1)
			Sleep(2000)
			MouseClick("left", 400, 300, 1) ;双击一次，防止点到其他对话按钮
			Return
		Else
			;---------
			MouseMove(240, 200) ; 针对有的电脑特殊，尝试手动定位
			Sleep(2000)
			MouseClick("left", Default, Default, 1)
			Sleep(3000)
			MouseMove(356, 130)
			MouseClick("left", Default, Default, 1)
			Sleep(2000)
			MouseClick("left", 400, 300, 1) ;双击一次，防止点到其他对话按钮
			;--------------------
			TrayTip("", "没找到", 9, 16)
			Sleep(1000)
			Return
		EndIf
	EndIf
	
	If $parm_imageMode = 2 And $dingZhiFlag = 113 Then
		findpath(11301)
		;通过找方块
		$monsterColor1 = "0xA420FC" ;绿色方块 0x18FC00        ；紫色 0xA420FC  红色 0xFC2C00 ，，"0xCE8523" ;橙色
		$monsterColor1_hex = "A420FC"
		$findflag113 = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "查找npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0xCE8523, 30, 1, $title) ; 在 0x1CC40C 绿色，  红色 0xFC2C00  "0xCE8523" ;橙色
				If Not @error Then
					TrayTip("", "点击复活！", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + Random(1, 20), $coord[1] + Random(1, 5))
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(500)
					MouseClick("left", 398, 298, Random(2, 3, 1), 5)
					Sleep(50)
					$findflag113 = 1
				Else ;可能存在找到颜色，但是没点上去，或者点上了，没找到颜色的情况
					TrayTip("", "点击失败！", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag113 = 1 Or $dif >= 20000
		Return
		;CheckMove($Char_CheckMoveDelay)
	EndIf
	
	
	If $parm_imageMode = 2 Then
		;通过找色快方式，在act5复活
		MouseClick("left", 60 + Random(1, 10), 250 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 30 + Random(1, 10), 220 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 160 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 170 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 350, 250, Random(1, 2))
		MouseClick("left", 200, 290, Random(1, 2))
		CheckMove($Char_CheckMoveDelay)
		Sleep(2000) ;可能npc在移动，先等等
		
		;通过找方块
		$monsterColor1 = "0xA420FC" ;绿色方块 0x18FC00        ；紫色 0xA420FC   红色 0xFC2C00    ，"0xCE8523" ;橙色
		$monsterColor1_hex = "A420FC"
		$findflag = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "查找npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0xCE8523, 30, 1, $title) ; 在
				If Not @error Then
					TrayTip("", "点击复活！", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + 10, $coord[1] + 10)
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(1500)
					$findflag = 1
					exitRoomWithMap()
				Else ;可能存在找到颜色，但是没点上去，或者点上了，没找到颜色的情况
					TrayTip("", "点击失败！", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 40000
		CheckMove($Char_CheckMoveDelay)
		
		
;~ 		$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 		If Not @error Then
;~ 			MouseClick("left", $coord[0] + 10, $coord[1] + 15)
;~ 			Sleep(5000)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		Else
;~ 			;通过单个颜色
;~ 			TrayTip("", "继续搜索！.", 1, 16)
;~ 			Sleep(10)
;~ 			$coord = PixelSearch(80, 80, 380, 500, 0x118FB01, 30, 1, $title)
;~ 			If Not @error Then
;~ 				MouseMove($coord[0] - Random(20, 30), $coord[1] + Random(100, 120))
;~ 				MouseClick("left", Default, Default, 1)
;~ 				CheckMove($Char_CheckMoveDelay)
;~ 				Sleep(5000) ;可能npc在移动，先等等
;~ 				$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 				If Not @error Then
;~ 					MouseClick("left", $coord[0] + Random(30, 50), $coord[1] + 10)
;~ 					CheckMove($Char_CheckMoveDelay)
;~ 				EndIf
;~ 			Else
;~ 				exitRoom()
;~ 			EndIf
;~ 			EndIf
		
		
		;下面用循环的方式找npc
;~ 	Else
;~ 		$coord = finda5aakkByPicture() ;找到柴
;~ 		;ConsoleWrite(TimerDiff($t1) & @CRLF)
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			;MouseMove($coord[0] +10 , $coord[1] + 50);
;~ 			MouseClick('left', $coord[0] + 5, $coord[1] + 5)
;~ 			Sleep(5000) ;下面可以取点复活的的按钮
;~ 			MouseClick("left", 380, 130, 1);点中复活 ，如果点不中，此处可以进行微调
;~ 			Sleep(1500)
;~ 		Else
;~ 			TrayTip("", "没有找到", 9, 16)
;~ 			Sleep(2000)
;~ 		EndIf
	EndIf
	
	If $parm_imageMode = 1 Then
		;这是去 act4复活
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
	EndIf
EndFunc   ;==>resumepet


Func a5bianshi()
	
	If $parm_imageMode = 2 Then
		;通过找色快方式，在act5复活
		MouseClick("left", 60 + Random(1, 10), 250 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 30 + Random(1, 10), 220 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 160 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 170 + Random(1, 10), 480 + Random(1, 10), Random(1, 5))
		CheckMove($Char_CheckMoveDelay)
		MouseClick("left", 150, 450, Random(1, 2))
		Sleep(2000)

		
		;通过找方块
		$monsterColor1 = "0xFC2C00" ;绿色方块 0x18FC00        ；紫色 0xA420FC  ,红色 0xFC2C00
		$monsterColor1_hex = "FC2C00"
		$findflag = 0
		$begin1 = TimerInit()
		Do
			$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
			If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
				TrayTip("", "查找npc..", 1, 16)
				MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
				Sleep(3000)
				CheckMove($Char_CheckMoveDelay)
				
				$coord = PixelSearch(100, 50, 500, 300, 0x1CC40C, 30, 1, $title) ; 在
				If Not @error Then
					TrayTip("", "点击复活！", 1, 16)
					;Sleep(2000)
					;MouseClick("right", $coord[0], $coord[1], 1);
					MouseMove($coord[0] + Random(1, 20), $coord[1] + Random(1, 5))
					Sleep(1000)
					MouseClick("left", Default, Default, 1)
					Sleep(200)
					$findflag = 1
					exitRoomWithMap()
				Else ;可能存在找到颜色，但是没点上去，或者点上了，没找到颜色的情况
					TrayTip("", "点击失败！", 1, 16)
					Sleep(1000)
					MouseClick("left", 400, 300, Default, Random(1, 3, 1))
					Sleep(200)
				EndIf
				
				
			EndIf
			;$i = $ + 1
			$dif = TimerDiff($begin1)
		Until $findflag = 1 Or $dif >= 20000
		CheckMove($Char_CheckMoveDelay)
		
		
	EndIf
EndFunc   ;==>a5bianshi

Func roleisdead()
	If astisdead() = True Then ;角色死亡后，雇佣兵肯定挂了，所以先判断下雇佣兵

		TrayTip("", "检查人物是否挂了", 1, 16)
		Send("{" & $char_Bag & "}")
		Sleep(500)
		If findPointColor(460, 250, "242424") = True And findPointColor(505, 250, "040404") = True And findPointColor(690, 250, "282828") = True Then
			;如果手套,戒指,鞋子三个点颜色都为默认颜色,则表示人物没有装备,死亡了
			Send("{" & $char_Bag & "}")
			;Sleep(500)        ;
			;MouseMove(395, 278)   ;有些可能是尸体在人物上方点位置。临时加
			;Sleep(3000)
			;MouseClick(395, 278);   ;有些可能是尸体在人物上方点位置。临时加
			Sleep(500)
			MouseClick("left", 400, 285, 1)
			Sleep(2000)
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
	Else
		Return False
	EndIf
EndFunc   ;==>roleisdead

Func checkbagRev()
	TrayTip("", "检查多余的瞬间回复药水", 1, 16)
	;Sleep(100)
	Send("{" & $char_Bag & "}")
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
;~ 	For $i = 1 To 1 Step 1
;~ 		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
;~ 		If Not @error Then
;~ 			checkzise("0x682070")
;~ 			;MouseClick("right", $coord[0], $coord[1], 1);
;~ 			;Sleep(200)
;~ 		EndIf
;~ 	Next
	MouseMove(390 + Random(1, 20, 1), 300 + Random(1, 80, 1))
	For $i = 1 To 20 Step 1 ;用找图的方式，更精准
		$coord = findRevInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
		EndIf
	Next
	
	;喝掉多余红，多余蓝
	For $i = 1 To 20 Step 1 ;用找图的方式，更精准
		$coord = findHealInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
		EndIf
	Next
	
	For $i = 1 To 20 Step 1 ;用找图的方式，更精准
		$coord = findManaInBag()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseClick("right", $coord[0], $coord[1], Random(1, 2, 1), Random(0, 5, 1));
			Sleep(Random(100, 150))
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


Func tradewater($water)
	;If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
	If findPointColor(500, 440, "4C4C4C") = True Then
		TrayTip("", "检测物品.", 1, 16)
		Sleep(1000)
		;MouseMove(400,300)
		;Sleep(100)
		;在安亚的交易窗口中
		If $water = 1 Then ;红
			$coord = findHealInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "找到红药水.", 1, 16)
				Sleep(1000)
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0] + 2, $coord[1] + 5, 1);
				Sleep(500)
				Send("{LSHIFT up}")
				Sleep(300)
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
				For $i = 0 To 2 Step 1
					Send("{LSHIFT}")
				Next
			Else
				TrayTip("", "没有找到红药水.", 1, 16)
				Sleep(1000)
			EndIf

		Else
			$coord = findManaInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				TrayTip("", "买药水.", 1, 16)
				Sleep(1000)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0] + 2, $coord[1] + 5, 1);
				Sleep(500)
				Send("{LSHIFT up}")
				Sleep(300)
				MouseMove(400, 300)
				Sleep(10)
				For $i = 0 To 2 Step 1
					Send("{LSHIFT}")
				Next
				;MouseClick("right", Default, Default, 1)
			Else
				TrayTip("", "没有找到蓝色药水.", 1, 16)
				Sleep(2000)
			EndIf
		EndIf
		#CS 		Send("{ESC}")
			Sleep(600)
		#CE
	EndIf
EndFunc   ;==>tradewater

Func findbeltWater($cat, $color)
	$needshop = 0 ;设置知否需要shop的标志
	$belt1 = 0
	$belt2 = 0
	$belt3 = 0
	$belt4 = 0
	For $i = 1 To 4 Step 1
		;MouseMove(420, 565)
		;MouseMove(450, 565)    第一个红窗
		;MouseMove(455, 565)
		;MouseMove(480, 565)   ; 第2个红窗口
		;MouseMove(485, 565)
		;MouseMove(510, 565)   ; 第3个红窗口
		;MouseMove(515, 565)
		;MouseMove(540, 590)   ; 第4个红窗口
		Select
			Case $i = 1
				If findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "第" & $i & "列有药水", 1, 16)
					$belt1 = 1
				EndIf
			Case $i = 2
				If findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "第" & $i & "列有药水", 1, 16)
					$belt2 = 1
				EndIf
			Case $i = 3
				If findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "第" & $i & "列有药水", 1, 16)
					$belt3 = 1
				EndIf
			Case $i = 4
				If findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $color, 25, 1, $title) Then
					TrayTip("", "第" & $i & "列有药水", 1, 16)
					$belt4 = 1
				EndIf
		EndSelect
	Next
	
	If $cat = "heal" Then
		If $belt1 = 0 Then ;有一列空，表示需要购买了
			TrayTip("", "1列有药水为空了", 1, 16)
			For $i = 1 To 4
				MouseClick("right", $xbeltarray[0][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		If $belt2 = 0 Then ;有一列空，表示需要购买了
			TrayTip("", "2列有药水为空了", 1, 16)
			For $i = 1 To 4
				MouseClick("right", $xbeltarray[1][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		
		
	ElseIf $cat = "mana" Then
		
		If $belt3 = 0 Then ;有一列空，表示需要购买了
			TrayTip("", "3列有药水为空了", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[2][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
		If $belt4 = 0 Then ;有一列空，表示需要购买了
			TrayTip("", "4列有药水为空了", 1, 16)
			For $i = 1 To 4
				;Send("{4}")
				MouseClick("right", $xbeltarray[3][0] + 5, $ybeltarray[3][0] + 5, Random(1, 4, 1))
				Sleep(100)
			Next
			$needshop = 1
		EndIf
		
	EndIf
	
	If $needshop = 1 Then
		Return 0
	Else
		Return 1
	EndIf



EndFunc   ;==>findbeltWater



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
	For $i = 0 To 2 Step 1
		Send("{LSHIFT}")
		Sleep(100)
	Next
EndFunc   ;==>addrevtobag

Func afterReady() ;进门后的准备，如装配护甲，CTA 波
	;Sleep(Random(800, 1000, 1))
	Sleep(Random(300, 500, 1) + $parm_speeddelay)
	$armrnd = Random(1, 10, 1) ;加入随即，可放，或者不放装甲技能
	$armrnd = 1
	If $armrnd = 1 Then
		MouseMove(400 + Random(1, 50, 1), 300 + Random(1, 100, 1))
		armShied()
	EndIf
	
	#CS 		;WIN DRU
		MouseMove(500 , 250)
		Sleep(50)
		Send("{F5}")
		Sleep(50)
		MouseClick("right", Default, Default, 1)
		Sleep(400)
		Send("{F2}")
		MouseClick("right", Default, Default, 2)
		Sleep(400)
		;------
	#CE
	
	;Sleep(1000) ;针对虚拟机
EndFunc   ;==>afterReady

Func armShied() ;装备冰甲技能
	If $fire = 1 Then
		Send("{" & $char_armFire & "}")
		Sleep(50)
		MouseClick("right", Default, Default, Random(1, 5))
		Sleep(Random(200, 400, 1))
	ElseIf $fire = 2 Then

	EndIf
EndFunc   ;==>armShied

Func gotoBox()
	
	If $parm_path = 5 Then
		
		If $dingZhiFlag = "109" Then
			cnbnpath() ; 109 先去box路上
		Else
			anhei3() ; 113
			$i = 1
			While $i <= 1 ;;循环一下，踢两次试试
;~ 		If $i = 2 Then ;第2次人物退后下再点
;~ 			MouseClick('left', 410, 310)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		EndIf
				$coord = findtudui1() ;找到柴草的位置
				;ConsoleWrite(TimerDiff($t1) & @CRLF)
				If $coord[0] >= 0 And $coord[1] >= 0 Then
					;MouseMove($coord[0] +150, $coord[1] +30);
					MouseClick('left', $coord[0] + 150, $coord[1] + 30)
					Sleep(1500)
					CheckMove($Char_CheckMoveDelay)
				EndIf
				$i = $i + 1
			WEnd
			MouseClick('left', 400, 260) ;再向上方走走方便找红门
			Sleep(300)
			CheckMove($Char_CheckMoveDelay)
		EndIf
		
		$coord = finda3box()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			MouseMove($coord[0], $coord[1]);
			MouseClick('left', $coord[0], $coord[1] + 20)
			CheckMove($Char_CheckMoveDelay)
			;Sleep(1200)
		Else
			TrayTip("", "109找箱子失败", 9, 16)
			Sleep(1000)
			Return False;
		EndIf
		
		
		
	Else
;~ 		;新随机路线
;~ 		a5down1();
;~ 		Sleep(2000)
;~ 		$coord = finda3box()
;~ 		If $coord[0] >= 0 And $coord[1] >= 0 Then
;~ 			MouseMove($coord[0], $coord[1]);
;~ 			MouseClick('left', $coord[0], $coord[1] + 20)
;~ 			;CheckMove($Char_CheckMoveDelay)
;~ 			Sleep(3000)
;~ 		Else
;~ 			TrayTip("", "111找箱子失败，尝试继续点击", 9, 16)
;~ 			Sleep(1000)
;~ 			Return False;
;~ 		EndIf
		;原路线
		Sleep(100)
		MouseMove(200, 500)
		Sleep(1000)
		MouseClick("left", 200, 500, 1)
		Sleep(1600)
		MouseMove(750, 430)
		Sleep(1000)
		MouseClick("left", 750, 430, 1)
		Sleep(1600)
		MouseMove(380, 480)
		Sleep(1000)
		MouseClick("left", 380, 480, 1)
		Sleep(1400)
		MouseMove(150, 240)
		Sleep(100)
		MouseClick("left", 150, 240, 1)
		Sleep(1800)
	EndIf
	
EndFunc   ;==>gotoBox

Func getRam()

	;_GUICtrlStatusBar_SetText($StatusBar1, "KP次数：" & $round & " 随机延迟: " & $tfcount, 1)
	$ranKp = Random(-4, 4, 1)
	;$ranKp = 0
	If $tfcount >= $parm_kprounctime + $ranKp Then ; 切换账号后 循环次数也大于规定的
		;此时可以关闭游戏,用循环的下一个账号来登陆
		TrayTip("", "开始随机事件。。.", 1, 16)
		Sleep(1000)
		;以下就是随机发生的事件了，可以延时，可以去act4
		Select
			Case $tfcount >= 0
				$waitmethord = Random(1, 2, 1) ;如果是1，就在游戏房间内等，如果是2，就退出房间等待
				If $waitmethord = 1 Then ;
					;MouseClick("left", 400 - Random(30, 400, 1), 300 + Random(10, 50, 1))
					Sleep(Random(200, 1000, 1))
					writelog("随机---第 " & $round & " 局: " & "随机暂停:" & $parm_rantime & "秒")
					For $ab = $parm_rantime To 0 Step -1
						TrayTip("", "挂机暂停剩余分钟数:" & $ab, 1, 16)
						Sleep(1000)
						If $parm_settime = 1 Then ;check if set tiem to shutdown
							tiemtoshut($parm_timedata)
						EndIf
					Next
					exitRoom() ;退出游戏到大厅界面
					Sleep(1000)
				Else
					exitRoom() ;退出游戏到大厅界面
					Sleep(Random(200, 1000, 1))
					writelog("随机---第 " & $round & " 局: " & "随机暂停:" & $parm_rantime & "秒")
					For $ab = $parm_rantime To 0 Step -1
						TrayTip("", "挂机暂停剩余分钟数:" & $ab, 1, 16)
						Sleep(1000)
						If $parm_settime = 1 Then ;check if set tiem to shutdown
							tiemtoshut($parm_timedata)
						EndIf
					Next
					Sleep(1000)
				EndIf
				
			Case Else

		EndSelect
		$tfcount = 0 ; 重置为0
	EndIf

	
	
EndFunc   ;==>getRam

Func ramclose()
	;_GUICtrlStatusBar_SetText($StatusBar1, "KP次数：" & $round & " 随机延迟: " & $tfclosecount, 1)
	$ranKp = Random(-4, 4, 1)
	;$ranKp = 0
	If $tfclosecount >= $parm_closetime + $ranKp Then ; 切换账号后 循环次数也大于规定的
		;此时可以关闭游戏,用循环的下一个账号来登陆
		closeAndWait(0)
	EndIf
	
	If $tfclosecount >= 300 Then ; 如果大于250局都不下线，系统强行给它下线
		;此时可以关闭游戏,用循环的下一个账号来登陆
		closeAndWait(1)
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
		WinKill($errortitle)
		Sleep(3000)
	EndIf
	
	$errortitle = "Hey guys"
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
		WinKill($errortitle)
		Sleep(3000)
	EndIf
	
	
EndFunc   ;==>closeError

Func closeAndWait($force) ;force 为 0 1 2   0 -用户定义时间 1- 一般强制时间  2- 严格强制时间
	;对force 可设置如果tfclosecount 超过200次都不下线，可以此处强制下线
	If $force = 0 Then
		$gamclosestoptime = $parm_closestoptime
	Else
		$gamclosestoptime = Random(35, 45, 1)
	EndIf
	
	writelog("随机---第 " & $round & " 局: 关闭游戏帐号下线:" & $gamclosestoptime & "分")
	TrayTip("", "关闭游戏帐号下线，线下停留分钟数：" & $gamclosestoptime, 1, 16)
	WinClose($title)
	Sleep(1000)
	WinClose($title)

	$ct = 1 ; 把房间后的数字也重置
	$tfclosecount = 0 ; 重置为0
	;_GUICtrlStatusBar_SetText($StatusBar1, "帐号下线暂停中...", 1)
	$gamclosestoptime = $gamclosestoptime + Random(1, 5, 1) ;加入随机值
	$sleeptime = $gamclosestoptime * 60
	For $aa = $sleeptime To 0 Step -1
		TrayTip("", "挂机下线暂停剩余分钟数:" & Round($aa / 60, 1), 1, 16)
		Sleep(1000)
		If $parm_settime = 1 Then ;check if set tiem to shutdown
			tiemtoshut($parm_timedata)
		EndIf
	Next
	
	TrayTip("", "暂停时间已过 ,开始继续挂机", 1, 16)
EndFunc   ;==>closeAndWait

Func checkotherin()
	TrayTip("", "检查是否有他人进入", 1, 16)
	Sleep(10)
	MouseMove(400 + Random(1, 5, 1), 300 + Random(1, 5, 1))
	Sleep(50)
	Send("{" & $char_Team & "}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		;Send("{" & $char_Team & "}") ;关闭队伍界面
		If $b <> 3299051709 Then ;表示有变动了,可能是其他人进入房间了
			If $parm_otherimage = 1 Then
				_ScreenCapture_CaptureWnd(@ScriptDir & "\" & $parm_kpcount & "other.jpg", $handle) ;先保存下图片
			EndIf
			
			Send("{" & $char_Team & "}") ;关闭队伍界面
			If $parm_otherroundtrace = 1 Then ;是否启用规定局内自动下线功能
				If $round + 1 - $other_traced_round <= $parm_otheroundinterval Then ;连续间隔10局以内就有两次被追踪，表示有点危险了，
					writelog("其他人进房间---在第" & $round + 1 & "局进入房间，连续次之内2次进入，停止挂机！")
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
					closeAndWait(0)
				Case Else
					;其他处理方案
			EndSelect
			Return True
		Else
			Send("{" & $char_Team & "}") ;关闭队伍界面
			TrayTip("", "没有其他人", 1, 16)
			;没找到其他人
			Return False
		EndIf
	Else
		TrayTip("", "没有队伍", 1, 16)
		;按了P后，发现也没有找到队伍界面，则忽略掉
		Send("{" & $char_Team & "}")
		Return False
	EndIf
	
EndFunc   ;==>checkotherin

Func checkOpenStat() ;检查是否打开人物属性或任务栏，或雇佣兵界面
	;外围边框都是一样的
	If findPointColor(50, 200, "1C1C1C") = True And findPointColor(50, 300, "040404") = True And findPointColor(200, 500, "1C1C1C") = True Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>checkOpenStat

Func _shortdelaysec()
	Dim $randshort
	Select
		Case $short1 >= 4
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(2, 3, 1)
			If $randshort = 2 Then
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			Else
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
		Case $short2 >= 3
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(1, 4, 1)
			If $randshort <> 4 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			Else
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
		Case $short3 >= 3
			$short1 = 0
			$short2 = 0
			$short3 = 0
			$randshort = Random(1, 4, 1)
			If $randshort <> 4 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			Else
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			EndIf
		Case Else
			
			$randshort = Random(1, 5, 1)
			If $randshort <> 2 And $randshort <> 3 Then
				$short1 = $short1 + 1
				$autshortdelaysec = 0
			ElseIf $randshort = 2 Then
				$short2 = $short2 + 1
				$autshortdelaysec = Random(5, 7, 1)
			ElseIf $randshort = 3 Then
				$short3 = $short3 + 1
				$autshortdelaysec = Random(10, 13, 1)
			EndIf
			
			Return $autshortdelaysec
	EndSelect
EndFunc   ;==>_shortdelaysec


Func clikcTradeMaraInAct5()
	
	MouseClick("left", 120 + Random(1, 10, 1), 290 + Random(1, 10, 1))
	Sleep(2000)
	
;~ 	$monsterColor1 = "0xA420FC" ;绿色方块 0x18FC00        ；紫色 0xA420FC
;~ 	$monsterColor1_hex = "A420FC"
;~ 	$tp_Pix = countFirepointRec(10, 10, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
;~ 	If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
;~ 		;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
;~ 		MouseClick("left", $tp_Pix[0], $tp_Pix[1], 1, 0)
;~ 		Sleep(3000)
;~ 		CheckMove($Char_CheckMoveDelay)
;~ 	Else
;~ 		exitRoom()
;~ 	EndIf
	
	$monsterColor1 = "0xA420FC" ;绿色方块 0x18FC00        ；紫色 0xA420FC
	$monsterColor1_hex = "A420FC"
	$findflag = 0
	$begin1 = TimerInit()
	Do
		$tp_Pix = countFirepointRec(10, 5, 700, 540, $monsterColor1, $monsterColor1_hex) ;2  0x118FB01    ;0x00FC19, "00FC19"
		If $tp_Pix[0] >= 0 And $tp_Pix[1] >= 0 Then
			;TrayTip("", "1： " & $tp_Pix[0] & "-" & $tp_Pix[1], 1, 16)
			MouseClick("left", $tp_Pix[0] + 10, $tp_Pix[1] + 10, 1, 0)
			Sleep(3000)
			CheckMove($Char_CheckMoveDelay)
			
			$coord = PixelSearch(100, 30, 500, 300, 0x1CC40C, 30, 1, $title) ; 在
			If Not @error Then
				TrayTip("", "点击交易！", 1, 16)
				;MouseClick("right", $coord[0], $coord[1], 1);
				MouseMove($coord[0] + Random(10, 20), $coord[1] + Random(5, 7))
				Sleep(1000)
				MouseClick("left", Default, Default, 1)
				Sleep(200)
				$findflag = 1
			Else ;可能存在找到颜色，但是没点上去，或者点上了，没找到颜色的情况
				TrayTip("", "点击失败！", 1, 16)
				Sleep(2000)
				MouseClick("left", 400, 300, Default, Random(1, 3, 1))
				Sleep(200)
			EndIf
			
		EndIf
		;$i = $ + 1
		$dif = TimerDiff($begin1)
	Until $findflag = 1 Or $dif >= 40000
	CheckMove($Char_CheckMoveDelay)

;~ 	;单个像素找色
;~ 	$coord = PixelSearch(10, 10, 380, 450, 0xA420FC, 30, 1, $title) ;   --找npc颜色
;~ 	If Not @error Then
;~ 		MouseClick("left", $coord[0] + 10, $coord[1] + 10)
;~ 		Sleep(3000)
;~ 		CheckMove($Char_CheckMoveDelay)
;~ 	Else
;~ 		TrayTip("", "继续搜索！.", 1, 16)
;~ 		MouseClick("left", 300, 250)
;~ 		Sleep(2000) ;可能npc在移动，先等等
;~ 		$coord = PixelSearch(10, 10, 380, 500, 0xA420FC, 30, 1, $title) ;
;~ 		If Not @error Then
;~ 			MouseClick("left", $coord[0] + Random(30, 50), $coord[1] + 10)
;~ 			Sleep(3000)
;~ 			CheckMove($Char_CheckMoveDelay)
;~ 		Else
;~ 			exitRoom();
;~ 		EndIf
;~ 	EndIf
	
	
	
;~ 	$coord = PixelSearch(100, 50, 400, 300, 0x1CC40C, 30, 1, $title) ; 在
;~ 	If Not @error Then
;~ 		TrayTip("", "点击交易！", 1, 16)
;~ 		;MouseClick("right", $coord[0], $coord[1], 1);
;~ 		MouseMove($coord[0] + Random(10, 20), $coord[1] + Random(1, 5))
;~ 		Sleep(200)
;~ 		MouseClick("left", Default, Default, 1)
;~ 		TrayTip("", "打开交易界面！", 1, 16)
;~ 		Sleep(200)
;~ 	EndIf
	
EndFunc   ;==>clikcTradeMaraInAct5


;---------------------多进程判断血量，蓝，pet等
Local $lifeStatus ;1.人物血量  0 缺少 ，1 正常
Local $manaStatus ;2.人物法力: 0 缺少 ，1 正常
Local $petStatus ;3.雇佣兵血量 0 死亡 ，1 加血 ，2 正常
Local $lifeBottle ;4.红药情况  0 无    1 有
Local $manaBottle ;5.蓝药情况  0 无    1 有
Local $purpleBottle ;6.紫药情况   0 无    1 有
Local $noOtherComeIn ;7.有人进房间   0 有人进    1 无
Local $noOtherWhisper ;  8是否有人m你  0 有人mi  1 无人m

Func child1()
	Local $parm[6]
	Local $needResumePetFlag = 0 ; 需要复活pet的标志位
	Local $needByRedBottle = 0 ; 需要买红药的标记位
	Local $needByManaBottle = 0 ; 需要买红药的标记位

	$drink_pet_ct = 0 ;默认喝红药的次数 ，开始为 0 ，没喝一次，加1， 同样时间也是加3秒
	$drink_heal_ct = 0
	$drink_mana_ct = 0
	$i = 0
	While ProcessExists($gi_CoProcParent)
		$i = $i + 1
		$petStatus = CheckpetStatus() ;---先检查雇佣兵，若雇佣兵挂了，则复活
		_CoProcSend($gi_CoProcParent, "petStatus|" & $petStatus)
		If isInRoom() = True And isInTown() = False And $petStatus = 0 And $needResumePetFlag = 0 Then ;站城内部退出
			writelog("雇佣兵 - 检测到需要复活雇佣兵")
			exitRoomWithMap()
			;exitRoom()
			$needResumePetFlag = 1
			ContinueLoop
			;writelog($petStatus & "-" & $i & "-" & $needResumePetFlag)
		EndIf
		If $petStatus = 1 Or $petStatus = 2 Then ;当复活成功后,
			$needResumePetFlag = 0
		EndIf
		If $petStatus = 1 Then ;雇佣兵少血，要加血的情况
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;有紫药水，下面就加紫药水
				Send("{LSHIFT down}")
				Sleep(50)
				drinkWaterNew("0x682070")
				Sleep(50)
				Send("{LSHIFT up}")
				Send("{LSHIFT}")
				Sleep(50)
				Send("{LSHIFT}")

			Else ;没紫药水的话，去找红药水
				
				$lifeBottle = ChecklifeBottle()
				If $lifeBottle = 1 Then
					If $drink_pet_ct = 0 Then ;第一次喝红药水
						$begindrinkpetTime = TimerInit()
						Send("{LSHIFT down}")
						Sleep(50)
						drinkWaterNew("0x943030")
						Sleep(50)
						Send("{LSHIFT up}")
						Send("{LSHIFT}")
						Sleep(50)
						Send("{LSHIFT}")
						$drink_pet_ct = $drink_pet_ct + 1
					Else ;若果是第二次或以上喝
						$difpet = TimerDiff($begindrinkpetTime)
						If $difpet >= 4000 Then
							Send("{LSHIFT down}")
							Sleep(50)
							drinkWaterNew("0x943030")
							Sleep(50)
							Send("{LSHIFT up}")
							Send("{LSHIFT}")
							Sleep(50)
							Send("{LSHIFT}")
							$drink_pet_ct = $drink_pet_ct + 1
							$begindrinkpetTime = TimerInit() ;重置时间
						EndIf
					EndIf
				Else ;没有红药，可以选择退出，并在下局开始的时候买红药
					If isInRoom() And $needByRedBottle = 0 And $ckred = 1 Then
						writelog("红药----需要买红药")
						exitRoom()
						$needByRedBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;如果不需要加血，需要将喝血的次数改为0
			$drink_pet_ct = 0
		EndIf
		
		
		$lifeStatus = ChecklifeStatus() ;	检查血量
		_CoProcSend($gi_CoProcParent, "lifeStatus|" & $lifeStatus)
		If $lifeStatus = 0 Then ;需要加血，但是注意加红药水需要有时间间隔
			;1优先加紫药水
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;有紫药水，下面就加紫药水
				drinkWaterNew("0x682070")
				Sleep(10)
			Else ;没紫药水的话，去找红药水
				$lifeBottle = ChecklifeBottle()
				If $lifeBottle = 1 Then
					If $drink_heal_ct = 0 Then ;第一次喝红药水
						$begindrinkhealTime = TimerInit()
						drinkWaterNew("0x943030")
						$drink_heal_ct = $drink_heal_ct + 1
					Else ;若果是第二次或以上喝
						$difheal = TimerDiff($begindrinkhealTime)
						If $difheal >= 4000 Then
							drinkWaterNew("0x943030")
							$drink_heal_ct = $drink_heal_ct + 1
							$begindrinkhealTime = TimerInit() ;重置时间
						EndIf
					EndIf
				Else ;没有红药，可以选择退出，并在下局开始的时候买红药
					If isInRoom() And $needByRedBottle = 0 And $ckred = 1 Then
						writelog("红药----需要买红药")
						exitRoom()
						$needByRedBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;如果不需要喝红，就把标记为改为 0
			$drink_heal_ct = 0
		EndIf
		
		
		$manaStatus = CheckmanaStatus()
		_CoProcSend($gi_CoProcParent, "manaStatus|" & $manaStatus)
		If $manaStatus = 0 Then ;需要加蓝，但是注意加蓝药水需要有时间间隔
			;1优先加紫药水
			$purpleBottle = CheckpurpleBottle()
			If $purpleBottle = 1 Then ;有紫药水，下面就加紫药水
				drinkWaterNew("0x682070")
				Sleep(10)
			Else ;没紫药水的话，去找蓝药水
				$manaBottle = CheckmanaBottle()
				If $manaBottle = 1 Then ;有蓝药，则喝蓝药,但蓝药恢复时间缓慢，需要设计一个时间差
					If $drink_mana_ct = 0 Then ;第一次喝红药水
						$beginmanaTime = TimerInit()
						drinkWaterNew("0x1828A4")
						$drink_mana_ct = $drink_mana_ct + 1
					Else ;若果是第二次或以上喝
						$difmana = TimerDiff($beginmanaTime)
						If $difmana >= 4000 Then
							drinkWaterNew("0x1828A4")
							$drink_mana_ct = $drink_mana_ct + 1
							$beginmanaTime = TimerInit() ;重置时间
						EndIf
					EndIf
				Else ;没有蓝药，可以选择退出，并在下局开始的时候买蓝药
					If isInRoom() And $needByManaBottle = 0 And $ckblue = 1 Then
						writelog("蓝药----需要买蓝药")
						exitRoom()
						$needByManaBottle = 1
					EndIf
				EndIf
			EndIf
		Else ;如果不需要喝红，就把标记为改为 0
			$drink_mana_ct = 0
		EndIf
		
		

		$lifeBottle = ChecklifeBottle()
		_CoProcSend($gi_CoProcParent, "lifeBottle|" & $lifeBottle)
		
		$manaBottle = CheckmanaBottle()
		_CoProcSend($gi_CoProcParent, "manaBottle|" & $manaBottle)
		
		$purpleBottle = CheckpurpleBottle()
		_CoProcSend($gi_CoProcParent, "purpleBottle|" & $purpleBottle)
		
		$noOtherComeIn = ChecknoOtherComeIn()
		If $noOtherComeIn = 0 And $guiothercheck = 1 Then
			exitRoomWithMap()
		EndIf
		_CoProcSend($gi_CoProcParent, "noOtherComeIn|" & $noOtherComeIn)
		
		$noOtherWhisper = ChecknoOtherWhisper()
		_CoProcSend($gi_CoProcParent, "noOtherWhisper|" & $noOtherWhisper)
		
		Sleep(50)
	WEnd

EndFunc   ;==>child1

Func CheckpetStatus()
	;检查雇佣兵
	If isInRoom() = False Then
		Return 3
	Else
;~ 		If isInRoom() And checkOpenStat() = False And findPointColor(18, 17, "F0041C") = False And findPointColor(18, 17, "D08420") = False And findPointColor(18, 17, "008400") = False Then
;~ 			;红  F0041C，黄 D08420 ，绿 008400 ，  sum 那个是打开雇佣兵窗口的画面
;~ 			If findAreaColor(10, 5, 52, 20, 0xF0041C, 30, 2, $title) = False And findAreaColor(10, 5, 52, 20, 0xDD0D20, 30, 2, $title) = False Then
;~ 				;writelog("雇佣兵----雇佣兵监测有问题，似乎挂了")
;~ 				Return 0
;~ 			Else;如果进一步检测红血发现还有，表示存在一丝血
;~ 				Return 1
;~ 			EndIf
;~
;~ 		Else
;~ 			If isInRoom() And checkOpenStat() = False And findPointColor(40, 17, "008400") = False Then
;~ 				Return 1
;~ 			Else
;~ 				Return 2
;~ 			EndIf
;~ 		EndIf
		
		If isInRoom() And checkOpenStat() = True Then ;如果在房间内，且打开了背包转移，雇佣兵等画面
			Return 3
		Else ;
			If isInRoom() And findPointColor(18, 17, "008400") = True Then ;如果是绿色，基本是满的，可以不用加血
				Return 2 ; 表示正常
			Else ;不是绿色，判断是不是黄色
				If isInRoom() And findPointColor(18, 17, "D08420") = True Then
					Return 1
				Else ;如果不是黄色，看是不是红色
					If isInRoom() And findPointColor(18, 17, "F0041C") = True Then
						Return 1
					Else ;如果红色也找不到，可能存在一丝血，改为范围取色试试
						
						;红  F0041C，黄 D08420 ，绿 008400 ，  sum 那个是打开雇佣兵窗口的画面
						If isInRoom() And findAreaColor(10, 5, 52, 20, 0xF0041C, 30, 1, $title) = False And findAreaColor(10, 5, 52, 20, 0x231B9D, 30, 2, $title) = False Then
							;writelog("雇佣兵----雇佣兵监测有问题，似乎挂了")
							Return 0
						Else;如果进一步检测红血发现还有，表示存在一丝血
							Return 3
						EndIf
					EndIf
				EndIf
				
			EndIf
		EndIf
		
	EndIf
	
	
	
	
EndFunc   ;==>CheckpetStatus

Func ChecklifeStatus()
	;检查生命
	If isInRoom() And findPointColor(70, 530, "5C0000") = False And findPointColor(70, 530, "18480C") = False Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>ChecklifeStatus

Func CheckmanaStatus()
	;检查法力
	If isInRoom() And findPointColor(705, 570, "040404") = False Then ; 735, 580, "0C0C28"
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>CheckmanaStatus

Func ChecklifeBottle()
;~ 	;检查包裹红药水
;~ 	$haveRed = 0
;~ 	$colorRed = "0x943030"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorRed, 25, 3, $title) Then
;~ 					$haveRed = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $haveRed = 0 Then ;如果没找到任何红药水
;~ 		Return 0 ;没红药
;~ 	Else
;~ 		Return 1 ;有红药
;~ 	EndIf
	
	;第二种方式，直接找整个包裹
	$coord1 = PixelSearch(420, 565, 540, 590, 0x943030, 25, 1, $title) ;红色
	If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
		Return 1 ;有红药
	Else
		Return 0 ;没红药
	EndIf
	
EndFunc   ;==>ChecklifeBottle

Func CheckmanaBottle()
;~ 	;检查包裹蓝药水
;~ 	$haveBlue = 0
;~ 	$colorBlue = "0x1828A4"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorBlue, 25, 3, $title) Then
;~ 					$haveBlue = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $haveBlue = 0 Then ;
;~ 		Return 0 ;没蓝色法力药水
;~ 	Else
;~ 		Return 1 ;有蓝色法力药水
;~ 	EndIf
	$coord1 = PixelSearch(420, 565, 540, 590, 0x1828A4, 25, 1, $title) ;红色
	If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
		Return 1 ;有蓝色法力药水
	Else
		Return 0 ;没蓝色法力药水
	EndIf


	
	
EndFunc   ;==>CheckmanaBottle

Func CheckpurpleBottle()
;~ 	;检查包裹紫色药水
;~ 	$havePurple = 0 ; $purpleBottle
;~ 	$colorPurple = "0x682070"
;~ 	For $i = 1 To 4 Step 1
;~ 		Select
;~ 			Case $i = 1
;~ 				If isInRoom() And findAreaColor($xbeltarray[0][0], $ybeltarray[3][0], $xbeltarray[0][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 2
;~ 				If isInRoom() And findAreaColor($xbeltarray[1][0], $ybeltarray[3][0], $xbeltarray[1][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 3
;~ 				If isInRoom() And findAreaColor($xbeltarray[2][0], $ybeltarray[3][0], $xbeltarray[2][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 			Case $i = 4
;~ 				If isInRoom() And findAreaColor($xbeltarray[3][0], $ybeltarray[3][0], $xbeltarray[3][1], $ybeltarray[3][1], $colorPurple, 25, 1, $title) Then
;~ 					$havePurple = 1
;~ 				EndIf
;~ 		EndSelect
;~ 	Next
;~ 	If $havePurple = 0 Then ;如果一个大回复药水都没找到，悲剧了。。乱点一个，或者hackmap设置为血保护
;~ 		Return 0 ;没紫色药水
;~ 	Else
;~ 		Return 1 ;有紫色药水
;~ 	EndIf
	
	$coord1 = PixelSearch(420, 565, 540, 590, 0x682070, 25, 1, $title) ;红色
	If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
		Return 1 ;有紫色药水
	Else
		Return 0 ;没紫色药水

	EndIf

EndFunc   ;==>CheckpurpleBottle

Func ChecknoOtherComeIn()
	;检查是否有人进房间
;~ 	$firstOther = 1
;~ 	$secondOther = 1
;~ 	$noOthercolor1 = "0xCE8523"
;~ 	$noOthercolor2 = "0x1CC40C"
;~ 	$noOthercolor21 = "0x14FD01"
;~
;~ 	If isInRoom() And findAreaColor(20, 10, 35, 105, $noOthercolor1, 25, 1, $title) And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 		$firstOther = 0
;~ 	Else
;~ 		$firstOther = 1
;~ 	EndIf
;~ 	If isInRoom() And findAreaColor(60, 10, 85, 105, $noOthercolor2, 25, 1, $title) And findAreaColor(60, 10, 85, 105, $noOthercolor1, 25, 1, $title) = False And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 		$secondOther = 0
;~ 	Else
;~ 		If isInRoom() And findAreaColor(60, 10, 85, 105, $noOthercolor21, 25, 1, $title) And findAreaColor(60, 10, 85, 105, $noOthercolor1, 25, 1, $title) = False And PixelChecksum(10, 300, 60, 400, $title) <> 3002911715 Then
;~ 			$secondOther = 0
;~ 		Else
;~ 			$secondOther = 1
;~ 		EndIf
;~ 	EndIf
;~ 	If $firstOther = 0 And $secondOther = 0 Then ;满足两个条件才是有人进
;~ 		writelog("其他人进房间---请留意！")
;~ 		Return 0
;~ 	Else
;~ 		Return 1
;~ 	EndIf

	;0x010101  ;黑色
	$cheng = "0xCE8523" ;橙色
	$lan = "0x4E4FAD" ;蓝色
	$bai = "0xC4C4C4" ;白色
	; 20 -  ,54  ,93
	; 30- 40
	; 60 - 70
	; 100 -110
	$coord = PixelSearch(20, 10, 150, 150, $cheng, 25, 1, $title)
	If Not @error Then;找到橙色，继续找同一水平行有其他两种颜色没
		;ConsoleWrite("  " & $coord[0] & @CRLF)
		$coord1 = PixelSearch(60, $coord[1] - 2, 70, $coord[1] + 10, $lan, 25, 2, $title)
		If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
			;ConsoleWrite("  " & $coord1[0] & @CRLF)
			$coord2 = PixelSearch(100, $coord1[1] - 2, 110, $coord1[1] + 10, $bai, 20, 2, $title)
			If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
				;ConsoleWrite("  " & $coord2[0] & @CRLF)
				writelog("其他人进房间---请留意！")
				Return 0;
			EndIf
			;ConsoleWrite( "  "& $coord[0]& @CRLF)
		EndIf
	EndIf
	Return 1;
EndFunc   ;==>ChecknoOtherComeIn

Func ChecknoOtherWhisper()
	;检查是否有其他人m你
;~ 	$firstWhisper = 1
;~ 	$secondWhisper = 1
;~ 	$Whispercolor1 = "0x1CC40C" ;0x1CC40C  0x14FD01
;~ 	$Whispercolor11 = "0x14FD01"
;~ 	$Whispercolor2 = "0xCE8523"
;~
;~ 	If isInRoom() And checkOpenStat() = False And findAreaColor(20, 10, 35, 105, $Whispercolor1, 25, 1, $title) And findAreaColor(20, 10, 35, 105, $Whispercolor2, 25, 1, $title) = False Then
;~ 		$firstWhisper = 0
;~ 	Else
;~ 		If isInRoom() And checkOpenStat() = False And findAreaColor(20, 10, 35, 105, $Whispercolor11, 25, 1, $title) And findAreaColor(20, 10, 35, 105, $Whispercolor2, 25, 1, $title) = False Then
;~ 			$firstWhisper = 0
;~ 		Else
;~ 			$firstWhisper = 1
;~ 		EndIf
;~ 	EndIf
;~ 	If isInRoom() And checkOpenStat() = False And findAreaColor(60, 10, 85, 105, $Whispercolor2, 25, 1, $title) Then
;~ 		$secondWhisper = 0
;~ 	Else
;~ 		$secondWhisper = 1
;~ 	EndIf
;~
;~ 	If $firstWhisper = 0 And $secondWhisper = 0 Then ;满足两个条件才是有人进
;~ 		writelog("有人m你---请留意！")
;~ 		Return 0
;~ 	Else
;~ 		Return 1
;~ 	EndIf

	;0x010101  ;黑色
	$cheng = "0xCE8523" ;橙色
	$lan = "0x4E4FAD" ;蓝色
	$bai = "0xC4C4C4" ;白色
	; 20 -  ,54  ,93
	; 30- 40
	; 60 - 70
	; 100 -110
	$coord = PixelSearch(20, 10, 150, 150, $lan, 25, 1, $title)
	If Not @error Then;找到蓝色，继续找同一水平行有其他两种颜色没
		;ConsoleWrite("  " & $coord[0] & @CRLF)
		$coord1 = PixelSearch(60, $coord[1] - 2, 70, $coord[1] + 10, $cheng, 25, 2, $title)
		If Not @error Then ;找到橙色， 继续找同一水平行是否有白色
			;ConsoleWrite("  " & $coord1[0] & @CRLF)
			$coord2 = PixelSearch(100, $coord1[1] - 2, 110, $coord1[1] + 10, $bai, 20, 2, $title)
			If Not @error Then ;找到蓝色， 继续找同一水平行是否有白色
				;ConsoleWrite("  " & $coord2[0] & @CRLF)
				writelog("有人m你---请留意！")
				Return 0;
			EndIf
			;ConsoleWrite( "  "& $coord[0]& @CRLF)
		EndIf
	EndIf
	Return 1;

EndFunc   ;==>ChecknoOtherWhisper





Func Reciver($vParameter)
	;TrayTip("",  $i  & "  收到子进程的消息是 " & $vParameter , 1, 16)   ; $gi_CoProcParent
	;$childmsg = $vParameter
	$aParam = StringSplit($vParameter, "|")
	If $aParam[1] = "lifeStatus" Then $childmsg[0] = $aParam[2]
	If $aParam[1] = "manaStatus" Then $childmsg[1] = $aParam[2]
	If $aParam[1] = "petStatus" Then $childmsg[2] = $aParam[2]
	If $aParam[1] = "lifeBottle" Then $childmsg[3] = $aParam[2]
	If $aParam[1] = "manaBottle" Then $childmsg[4] = $aParam[2]
	If $aParam[1] = "purpleBottle" Then $childmsg[5] = $aParam[2]
	If $aParam[1] = "noOtherComeIn" Then $childmsg[6] = $aParam[2]
	If $aParam[1] = "noOtherWhisper" Then $childmsg[7] = $aParam[2]

EndFunc   ;==>Reciver







