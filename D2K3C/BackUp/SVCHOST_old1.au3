#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****



Global $testversion =  0 ;  是测试版 1   0 为正式版

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////各种版本
Local $acountArray[2] ;用于绑定帐号
$acountArray[0] = "suizhibo-p"
$acountArray[1] = "suizhibo-p"

$bindmac = 1 ;绑定机器
$bindacc = 0 ;绑定帐号
$bindlimitCount = 0 ;  绑定次数
$bindTime = 0 ;数据库中的次数  ;只测试版用到

Local $debugmode = 0 ;   1 打开 0 关闭 手动调试模式，用于游戏内控制

;$global $colorMonster = "0xFC2C00"   ;红色 
Global $colorPath = "0x18FC00"  ;路上的方块
Global $colorPath3c = "0x8FB8FC"  ;3c最里面一个方块淡蓝色
Global $colorItem = "0xA420FC" ;物品颜色，紫色
Global $colorNpc1 = "0xA420FC" ;大部分npc颜色，紫色





If $testversion = 1 Then ;如果是免费版，就绑定次数
	$bindlimitCount = 1
	$bindTime = 1
EndIf
$limitRound = 4 ;持续挂机次数

$ranLimte = Random(-10, 13, 1) ;最大次数限制的前后范围   比如可以 80-20 或者 80+20
;$ranLimte = 0
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////各种版本
Global $a3colorCui = "0x90B8FC"   ;崔凡客3c处，最里面的淡蓝色
Global $a3colorBlock = "0x18FC00" ;路上绿色的方块
Global $a3colorItem = "0xA420FC"  ;紫色


#include <guidesignk3c.au3>
#include <d2KC3客户端.au3>
#include <include.au3>
#include <colormanger.au3>  ;调用找色的函数
#include <imageSearch.au3>
#include <commonUse.au3>
#include <fireMethord.au3>   ;攻击过程中的函数
#include <checkbag.au3>
#include <findpath.au3>    ;跑步路径
#include <approve.au3>
#include <file.au3>    ;写入log 日志
#include <ScreenCapture.au3>


; d2
;AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


Global $Paused

Local $ohterImage = 0 ;出现的其他未知界面
Local $emptybag
Local $checkbag = 1

Local $handle

Local $title ;窗口标题
Local $parm_path1, $parm_path2, $parm_path3 ;  路径
Local $parm_exeparm3 ;其他参数
Local $parm_gamemode ; 单机 0 ，网络 1

Local $gameopt = 1 ; 单机 0 ，网络 1
;$fire = 0   ;/ / 角色攻击类型,由radio button来选择，
$titlefiremethord = $title
$titleImageSearch = $title


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
Local $parm_shopwater
Local $parm_otherimage ;保存陌生人图像
Local $parm_repair, $parm_repairRound
Local $parm_atBh, $parm_atNA, $parm_atVIG, $parm_atCON, $parm_atSHD, $parm_atTP;技能快捷键
Local $parm_tp ;tp

Local $parm_act ;which act role is in
Local $parm_bhtime ;bh 的释放时间
Local $parm_firemothord ;  $guifiremothord

Local $round = 0 ; kp次数统计
Local $tfcount = 0 ; 切换账号前该账号的累积kp计数 建房间
Local $tfclosecount = 0 ; 自动上下线的kp局数
Local $trepaircount = 0 ; 自动上下线的kp局数

Local $other_traced_round = 0 ;定义第几局被人进入房间,

Local $authority ;
Local $parm_firstdate, $parm_kpcount ;总的kp次数，用于限制月付客户
Local $connectfailcount = 0 ;增加一个无法连接战网的几次，比如帐号服务器停机时，就不能一直尝试连接
Local $createroominqueecount = 0 ;增加一个建房间等待排队


Local $arrayroomName[12] ;定义用于字母房间名
$arrayroomName[0] = "q"
$arrayroomName[1] = "s"
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


Local $childmsg[8] ;定义多进程收到的消息
Local $PidChild1 ;子进程id



If $bindmac = 0 And $bindTime = 0 And $bindacc = 0 Then
	MsgBox(0, "提示", "未知错误，请检查")
	Exit 0
EndIf


If $bindmac = 1 And $testversion = 0 Then
	_GUICtrlStatusBar_SetText($StatusBar1, "绑定机器", 0)
	If Not _IniVer() Then ; 绑定机器
		gui()
	EndIf
EndIf


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

$parm_boxing = $guiboxing
$parm_boxqty = $guiboxqty
$parm_namelenfr = $guinamelenfr
$parm_namelento = $guinamelento
$parm_namepre = $guinamepre
$parm_drinkrej_plus = $guidrinkrej
$parm_drinkheal_plus = $guidrinkheal
$parm_drinkmana_plus = $guidrinkmana

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
$parm_act = $ckact5
$parm_shopwater = $guishopwater

$parm_bhtime = $guibhTime
$parm_firemothord = $guifiremothord
$parm_otherimage = $guiotherimage ;保存陌生人照片到图像

$parm_repair = $guirepair
$parm_repairRound = $guirepairRound

#CS $parm_atBh = $guiatBh
	$parm_atNA = $guiatNA
	$parm_atVIG = $guiatVIG
	$parm_atCON = $guiatCON
	$parm_atSHD = $guiatSHD
#CE

$char_Vigor = $guiatVIG ;活力
$char_Bh = $guiatBh ;Bh
$char_normal_attack = $guiatNA ;  普通攻击, 不用突击,可能导致会僵直
$char_Conc = $guiatCON;专注光环
$char_Shield = $guiatSHD
$char_tp = $guiatTP

$parm_tp = $guitp ;tp

HotKeySet("{F9}", "TogglePause")
HotKeySet("{F10}", "Terminate")
;;;; Body of program would go here ;;;;

While 1
	Sleep(100)
WEnd

;;;;;;;;
Func TogglePause()
	$Paused = Not $Paused

			If $Paused = False Then
			$PidChild1 = _CoProc("child1") ;;加了多进程，判断血，蓝，雇佣兵，他人进房间等
			_CoProcReciver("Reciver")
		Else
			If ProcessExists($PidChild1) Then
				ProcessClose($PidChild1) ;结束子进程
			EndIf
		EndIf
		
	While $Paused
		Sleep(100)
		TrayTip("", "等待执行中..", 1, 16)
		runGame()
	WEnd
	;Exit
	$checkbag = 1
	$boxisfull = 0
	$connectfailcount = 0
	$createroominqueecount = 0
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
		_GUICtrlStatusBar_SetText($StatusBar1, "正式版-绑定账号", 0)
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
			MsgBox(4096, " ..... 温馨提示 .........", "恭喜您能kp这么多次,请休息下再挂机" & @CRLF & "或使用正式版")
			Exit 0
		EndIf
	EndIf
	
	;增加对软件使用次数的限制 ----------------                 .数据库中使用次数限制
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
		If $parm_kpcount >= 150 Then
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
	



	
	If $connectfailcount >= 3 Then
		TrayTip("", "续5次无法登陆战网或者密码错误，准备暂停..", 1, 16)
		writelog("异常---第 " & $round & " 局连续5次无法登陆战网或者密码错误，系统暂停二十分钟！")
		Sleep(1000 * 60 * 20)
		$connectfailcount = 0
	EndIf

	
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
			Sleep(Random(2000, 3000, 1))
		Case loginnotConnect()
			$connectfailcount = $connectfailcount + 1 ;无法连接战网
			$optcount = $optcount + 1
			TrayTip("", "无法连接战网，重试中。。.", 1, 16)
			Sleep(1000)
		Case pwderror()
			$connectfailcount = $connectfailcount + 1 ;无法连接战网
			$optcount = $optcount + 1
			TrayTip("", "密码错误，重试。。.", 1, 16)
			Sleep(1000)
		Case selectRole()
			$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要创建房间.", 1, 16)
			Sleep(2000)
		Case waitInputUsr()
			$connectfailcount = 0
			$optcount = $optcount + 1
			TrayTip("", "检查是否选择角色界面.", 1, 16)
			Sleep(2000)
		Case waitLoginNet()
			$optcount = $optcount + 1
			TrayTip("", "检查是否需要输入用户名密码.", 1, 16)
			Sleep(1000)
		Case $debugmode = 1
			TrayTip("", "手动调试模式中.", 1, 16)
			Sleep(10)
			TrayTip("", "子进程id: " & $PidChild1 & @CR & "不加血：" & $childmsg[0] & @CR & "不加法力：" & $childmsg[1] & @CR & "不加雇佣兵血：" & $childmsg[2] & @CR & "有血瓶：" & $childmsg[3] & @CR & "有蓝瓶：" & $childmsg[4] & @CR & "有紫瓶：" & $childmsg[5] & @CR & "无人进房间：" & $childmsg[6] & @CR & "无人m你：" & $childmsg[7], 1, 16)
			Sleep(2000)
			
		Case Else
			TrayTip("", "等待中，请稍后", 1, 16)
			Sleep(Random(400, 600, 1))
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
				WinClose($title)
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
		If Run($parm_path1 & " -w -direct -title " & $title & " " & $parm_exeparm3, $parm_path2) = 0 Then
			;If Run($d2path1, $d2path2) = 0 Then
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
			WinWait($title, "")
			WinActivate($title)
			Send("{ENTER}")
			Sleep(100)
		EndIf
		
	Else
		WinActivate($title)
	EndIf
	WinMove($title, "", 1, 1) ;移动到左上，防止被任务栏挡住
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

Func roomplay()
;~ 	fireMonsterByBlock(100, 20, 790, 520, 0, 60000) 
;~ 	TrayTip("", "结束", 1, 16)
;~ 	Sleep(2000)
;~ 	Return
	
	If $parm_ramevent = 1 Then
		getRam() ;获取随机事件
	EndIf
	
	If $parm_act = 1 And isInRoom() Then
		$act = whichAct()
		If $act = "A4" Then
			a4Toa3()
			Return
		ElseIf $act = "A5" Then
			a5Toa3()
			Return
			
		ElseIf $act = "A3" Then
			
			
		Else
			exitRoom()
			Return
		EndIf
	EndIf

	If $ckroledead = 1 And roleisdead() Then
		writelog("角色---角色死亡")
		Sleep(Random(150, 220, 1))
		Return
	EndIf

	
	;a3toomous(Random(1, 2, 1)); 在act3即从桥头去omous ，
	a3toomous(3)

	;看血或者蓝是否符合，如果有少，点下omous
	clickomous()
	MouseClick("left", 400, 300, 2) ;点击其他地方，放弃对话omous
	Sleep(100)
	
	If $parm_shopwater = 1 Then
		If findbeltWater("heal", "0xA42818") = 0 Or findbeltWater("mana", "0x303094") = 0 Then;需要买红或蓝
			TrayTip("", "准备交易", 1, 16)
			Sleep(1000)
			tradeomous()
			If findbeltWater("heal", "0xA42818") = 0 Then
				tradewater(1)
			EndIf
			If findbeltWater("mana", "0x303094") = 0 Then
				tradewater(2)
			EndIf
			MouseClick("left", 430, 460)
			Sleep(600)
		EndIf
	EndIf
	
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;进到崔凡客后检查是否有其他人登录
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	a3omousToWp() ;从奥斯玛到小站那
	
	;增加一个是否需要修理装备的情况
	Dim $faillasuke
	If $parm_repair = 1 And $parm_repairRound = $trepaircount Then
		a3Toa5()
		a5WpTolasuke()
		Do
			ClickLasuke()
			$faillasuke = $faillasuke + 1
		Until traderepair() = 1 Or $faillasuke >= 5
		$trepaircount = 0
		
		MouseClick("left", 400, 300)
		exitRoom()
		Return
	EndIf
	
	
	#CS 	$coord = PixelSearch(100, 100, 800, 520, 0x1CC40C, 30, 1, $title)
		If Not @error Then
		TrayTip("", "移到小站旁边", 1)
		MouseClick("left", $coord[0] - 10, $coord[1] -10, 1)
		Sleep(2000)
		EndIf
	#CE
	
	Sleep(10)
	;还可以增加是否购买红或者蓝
	
	If $parm_drinkrej_plus = 1 Then
		drinksurplusrev()
		;checkbagRev()
	EndIf
	If $parm_drinkheal_plus = 1 Then
		drinksurplusHeal()
	EndIf
	If $parm_drinkmana_plus = 1 Then
		;drinksurplusMana()
		checkbagRev()
	EndIf
	;addBloodtorole() ;加红  既然前面已经和omous 对话，就不用再加了
	;addmanatorole() ;加蓝
	If $parm_boxing = 1 Then
		If bagisfull() Then
			writelog("包裹---包裹已满")
			Sleep(Random(80, 100, 1))
			Return
		EndIf
	EndIf

	#CS 			If checkRejQtyInBelt() <= $rejneedqty Then ; 此处可以判断，如果没有红蓝了，就去购买，或者点omous 回复下
		TrayTip("", "没红蓝了，去购买.", 1, 16)
		a3Toa5()
		Return
		EndIf
	#CE
	If $ckass = 1 And astisdead() Then ; 此处可以用KP时候用的复活方式
		writelog("雇佣兵---雇佣兵死亡")
		Sleep(Random(80, 100, 1))
		a3toa4()
		a4wpToYizuer()
		exitRoom()
		Return
	EndIf
	
	Sleep(500) ;延时以下，防止点到鞋子上去
	If $testversion = 0 Then ;如果是正式版
		a3townwptocui() ;从act3到崔反客
	Else
		MouseClick("left", 760, 350, 2)
		Sleep(1400)
		MouseClick("left", 760, 250, 2)
		Sleep(1400)
		MouseClick("left", 280, 280, 1);
		Sleep(1400)
		MouseClick("left", 120, 380, 1);
		Sleep(1400)
		
	EndIf

	
	If $testversion = 0 Then
		If a3CuiNearPoint() = False Then ;如果没有成功到达cuifanke 小站
			TrayTip("", "没有成功到达崔凡客，退出重来", 1, 16)
			exitRoom()
			Return False
		EndIf
	EndIf
	
	afterReady() ;cta
	
	Sleep(Random(80, 100, 1))
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;进到崔后检查是否有其他人登录
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	TrayTip("", "移向3C.", 1, 16)
	If $parm_path = 1 Then
		If $parm_tp = 0 Then
			;goto3cpath(Random(2, 3, 1)) ;从崔方克的小站到 3c面前
			goto3cpath(100)
		Else
			TrayTip("", "启用TP+技能进行tp..", 1, 16)
			goto3cpath(4)
		EndIf
	EndIf
	;goto3cpath(3)
	;Sleep(Random(800, 1500, 1))
	Sleep(Random(80, 100, 1))
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;进到崔后检查是否有其他人登录
		If checkotherin() = True Then
			Return
		EndIf
	EndIf
	
	If $testversion = 0 Then
		$coord = finPicPos("images\cui2.bmp", 0.7)
		;$coord = findcui2()
		If $coord[0] >= 0 And $coord[1] >= 0 Then
			TrayTip("", "继续移动下", 1, 16)
			;MouseClick("left", $coord[0], $coord[1], 1);
			;Sleep(200)
			MouseClick("left", 600, 200, 2);
			CheckMove(400)
			Sleep(10)
		EndIf
	EndIf
	
	If isInRoom() Then
		
		TrayTip("", "准备进行攻击.", 1, 16)
		If $parm_firemothord = 1 Then
			fire3c(50, 20, 790, 520, $parm_bhtime);定点释放
		Else
			;fire3cByBlock(50, 20, 790, 520, 5)
			fireMonsterByBlock(100, 20, 790, 520, 0, 80000) 
		EndIf
		
		If checkNowDead() = 1 Then ;如果死亡
			Send("{ESC}")
			Sleep(500)
			exitRoom()
			Return
		EndIf
		
	EndIf
	
	If $parm_othercheck = 1 And $parm_otherwhencheck = 1 Then ;进到崔后检查是否有其他人登录
		If checkotherin() = True Then
			Return
		EndIf
	EndIf

	If isInRoom() Then
		TrayTip("", "寻找物品.", 1, 16)
		finditem($parm_picktime) ;pick up item
	Else
		Return
	EndIf
	If isInRoom() Then
		TrayTip("", "退出房间.", 1, 16)
		exitRoom()
		Sleep(2000)
	Else
		Return
	EndIf
	
	$round = $round + 1
	$tfcount = $tfcount + 1
	$tfclosecount = $tfclosecount + 1
	$trepaircount = $trepaircount + 1 ; repair count
	_GUICtrlStatusBar_SetText($StatusBar1, "K3C次数：" & $round & "  累计K3C次数： " & $parm_kpcount + 1, 1)
	
	$parm_kpcount = $parm_kpcount + 1
	;SQLiteInsert(101, "", $parm_kpcount)
	
	IniWrite("D2KP.dat", "注册", "序号", _StringToHex($parm_kpcount)  )

EndFunc   ;==>roomplay


Func finditem($parm_picktime)
	Sleep(10)
	MouseMove(400, 300)
	Sleep(10)
	Send("{ALT down}")
	For $i = 1 To $parm_picktime Step 1
		If isInRoom() = False Then
			ExitLoop
		EndIf
		
		
		#CS 		$coord = PixelSearch(100, 50, 795, 520, $colorItem, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
			If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			Sleep(1200)
			EndIf
			Sleep(100)
		#CE
		
		;人物可能中毒，所以需要去掉人物的座标
		$coord = PixelSearch(100, 50, 375, 300, $colorItem, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

		
		$coord = PixelSearch(375, 50, 795, 215, $colorItem, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(800)
		EndIf

		
		$coord = PixelSearch(425, 215, 795, 520, $colorItem, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

		
		$coord = PixelSearch(100, 300, 425, 520, $colorItem, 30, 1, $title) ;lianglv : 18FC00   zise : A420FC
		If Not @error Then
			TrayTip("", "捡起需要的物品", 1)
			MouseClick("left", $coord[0], $coord[1] + 5, 1)
			CheckMove(400)
			Sleep(100)
		EndIf

	Next
	
	Send("{ALT up}")
	Sleep(10)
	Send("{ALT}")
	Sleep(50)
	
EndFunc   ;==>finditem

Func movekp()
	$xrd = Random(-2, 2, 1)
	$yrd = Random(-2, 2, 1)
	TrayTip("", "启用随机路径" & "坐标迷惑偏移" & $xrd & " " & $yrd, 1, 16)
	Send("{F1}") ;
	Sleep(100)
	MouseClick("right", 740 + $xrd, 120 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 740 + $xrd, 110 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 540 + $xrd, 80 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
	MouseClick("right", 590 + $xrd, 140 + $yrd, 1)
	CheckMove(400)
	;Sleep(600)
EndFunc   ;==>movekp


Func waitLoginNet()
	;进入战网，判断是否准备点battle
	If findPointColor(290, 300, "4C4C4C") = True And findPointColor(290, 350, "686868") And findPointColor(290, 560, "585858") And isInRoom() = False Then
		If $parm_gamemode = 1 Then
			MouseClick("left", 400, 350)
		Else
			;单击
			MouseClick("left", 400, 300, 1)
			Sleep(500)
			MouseClick("left", 700, 560, 1)
			Sleep(500)
			MouseClick("left", 400, 360, 1)
			Sleep(4000)
		EndIf
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>waitLoginNet


Func loginnotConnect()
	;进入战网，判断是否准备点battle
	If findPointColor(290, 510, "2C2C2C") = True And findPointColor(290, 560, "2C2C2C") And findPointColor(360, 430, "585048") And isInRoom() = False Then
		MouseClick("left", 360, 430)
		Sleep(100)
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>loginnotConnect

Func waitInputUsr()
	;进入战网，判断是否准备输入账号密码
	If findPointColor(290, 510, "4C4C4C") = True And findPointColor(290, 560, "606060") And isInRoom() = False Then
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
	If findPointColor(290, 510, "242424") = True And findPointColor(290, 560, "303030") And isInRoom() = False Then
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
				Sleep(1000)
				Send("{RIGHT}")
				Sleep(2000)
				Send("{DOWN}")
				Sleep(2000)
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
			
			$createroominqueecount = $createroominqueecount + 1
			If $createroominqueecount >= 3 Then
				Sleep(1000 * 60 * 20)
				$createroominqueecount = 0
			EndIf
			
			Send("{ENTER}")
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
		Sleep(100)
		

		
		
		;If isInRoom() And  findPointColor(500, 440,"4C4C4C")=True And findPointColor(500, 280,"646464")=True And  findPointColor(460, 380, "040404") = False And findPointColor(500, 380, "040404") = False And findPointColor(540, 380, "040404") = False And findPointColor(580, 380, "040404") = False And findPointColor(610, 380, "040404") = False Then
		If isInRoom() And findPointColor(500, 440, "4C4C4C") = True And $emptybag <= $parm_boxqty Then
			;如果都有物品占用，表示包裹满了
			TrayTip("", "包裹空间格数: " & $emptybag & " 少于你设置的格数: " & $parm_boxqty, 1, 16)
			Sleep(1000)
			Send("{B}")
			Sleep(500)
			If $boxisfull = 0 Then ;如果记录仓库已满的表示 =1 ，表示满了，就不用再存仓库里，0 去存仓库
				;gotoa3Box($act)
				gotoa3Box("A3")
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
			
			If $shutdown = 1 And isInRoom() And $boxisfull = 1 And $emptybag <= 4 Then ;如果用户选择了包裹满了关机,则提示
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
		MouseClick("left", 740, 80, 1)
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
			WinClose($title)
			#CS 			$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
				If $PID Then ProcessClose($PID)
			#CE
			
			Sleep(1000)
			Exit 0
		EndIf
		
		TrayTip("", "pet挂了，待复活", 1, 16)
		Sleep(1000)
		;resumepet()
		;exitRoom()
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
	Sleep(100)
	;addrevtobag()
	;drinksurplusrev()
	drinksurplusInbag("0x303094") ;0x702068 zise  ;  0x303094 lanse
	Send("{B}")
	Sleep(100)
	;If 1 = 1 Then
	;	Return True
	;Else
	;	Return False
	;EndIf
EndFunc   ;==>checkbagRev

Func drinksurplusrev1() ;去掉多余的瞬间回复血瓶,省得占用空间
	For $i = 1 To 1 Step 1
		$coord = PixelSearch(420, 320, 705, 430, 0x682070, 10, 1, $title) ; 在背包空间范围内查找
		If Not @error Then
			checkzise("0x682070")
			;MouseClick("right", $coord[0], $coord[1], 1);
			;Sleep(200)
		EndIf
	Next
EndFunc   ;==>drinksurplusrev1


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
	Sleep(100)
	Send("{" & $char_Shield & "}")
	Sleep(50)
	MouseClick("right", Default, Default, 1)
	Sleep(50)
	Send("{" & $char_Vigor & "}")
	Sleep(50)
	
	Sleep(500)
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


Func gotoa3Box($whichAct) ;包裹满了，要装箱，act3 和在 act5 两种情况
	Select
		Case $whichAct = "A3"
			TrayTip("", "在act3进行装箱！", 9, 16)
			Sleep(500)
			$coord = finda3box();
			;$coord = findwp()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				MouseClick("left", $coord[0], $coord[1], 1);
				Sleep(2000)
			EndIf
			Sleep(1000)
		Case $whichAct = "A5"
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
		Case Else
	EndSelect
EndFunc   ;==>gotoa3Box

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
				writelog("随机---第 " & $round & " 局: " & "随机暂停:" & $parm_rantime & "秒")
				For $ab = $parm_rantime To 0 Step -1
					TrayTip("", "挂机暂停剩余分钟数:" & $ab, 1, 16)
					Sleep(1000)
					If $parm_settime = 1 Then ;check if set tiem to shutdown
						tiemtoshut($parm_timedata)
					EndIf
				Next
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
	If $tfclosecount >= $parm_closetime + $ranKp Then ; 切换账号后 循环次数也大于规定的
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
	writelog("随机---第 " & $round & " 局: 关闭游戏帐号下线:" & $parm_closestoptime & "分")
	TrayTip("", "关闭游戏帐号下线，线下停留分钟数：" & $parm_closestoptime, 1, 16)
	WinClose($title)
	Sleep(1000)
	WinClose($title)
	
	#CS 	$PID = ProcessExists($d2path3) ; Will return the PID or 0 if the process isn't found.
		If $PID Then ProcessClose($PID)
	#CE
	#CS 	$sleeptime = $parm_closestoptime * 60 * 1000
		TrayTip("", "软件暂停:" & $parm_closestoptime & "分钟", 1, 16)
		_GUICtrlStatusBar_SetText($StatusBar1, "帐号下线暂停中...", 1)
	#CE
	$tfclosecount = 0 ; 重置为0
	;Sleep($sleeptime)
	
	$sleeptime = $parm_closestoptime * 60
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
	TrayTip("", "检查队伍", 1, 16)
	;Sleep(100)
	MouseMove(400, 300)
	Sleep(50)
	Send("{P}")
	Sleep(200)
	$a = PixelChecksum(10, 300, 60, 400, $title) ; 3002911715
	If $a = 3002911715 Then
		$b = PixelChecksum(100, 140, 140, 170, $title) ; 3002911715
		Send("{P}") ;关闭队伍界面
		Sleep(50)
		If $b <> 3299051709 Then ;表示有变动了,可能是其他人进入房间了
			If $parm_otherimage = 1 Then
				_ScreenCapture_CaptureWnd(@ScriptDir & "\" & $parm_kpcount & "other.jpg", $handle) ;先保存下图片
			EndIf
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



Func clickomous()
	$coord = PixelSearch(100, 50, 500, 400, 0xA420FC, 30, 1, $title) ;
	If Not @error Then
		TrayTip("", "搜寻omous，走向omous！.", 1, 16)
		$x = $coord[0] + 5
		$y = $coord[1] + 50
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		;MouseMove($coord[0] , $coord[1] )
		Sleep(1500)
	EndIf
EndFunc   ;==>clickomous


Func tradeomous();前提是在已经点钟omous的情况下 ， 此处是和奥斯玛点交易
	
	$coord = PixelSearch(100, 50, 500, 400, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
	If Not @error Then
		TrayTip("", "检测omous，走向omous！.", 1, 16)
		$x = $coord[0] + 25 
		$y = $coord[1] + 25
		MouseMove($x, $y)
		Sleep(300)
		MouseClick("left", Default, Default, 1)
		Sleep(600)
		
		;$coord1 = PixelSearch($x - 50, $y - 100, $x + 100, $y, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
		$coord1 = PixelSearch(150, 50, 400, 300, 0x18FC00 , 30, 1, $title) ;     ;0xA420FC
		If Not @error Then
			TrayTip("", "点击交易。。。.", 1, 16)
			Sleep(1000)
			$x1 = $coord1[0] +5
			$y1 = $coord1[1] +5 ; 点“交易的字”
			MouseMove($x1, $y1)
			Sleep(100)
			MouseClick("left", Default, Default, 1)
		Else
			TrayTip("", "没找到交易", 1, 16) ;
			Sleep(1000)  
		
		EndIf

		Sleep(1800)
	EndIf
	
EndFunc   ;==>tradeomous



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
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0], $coord[1], 1);
				Sleep(300)
				Send("{LSHIFT up}")
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
			EndIf
		Else
			$coord = findManaInShop()
			If $coord[0] >= 0 And $coord[1] >= 0 Then
				Sleep(10)
				Send("{LSHIFT down}")
				Sleep(50)
				MouseClick("right", $coord[0], $coord[1], 1);
				Sleep(300)
				Send("{LSHIFT up}")
				MouseMove(400, 300)
				Sleep(10)
				;MouseClick("right", Default, Default, 1)
			EndIf
		EndIf
		#CS 		Send("{ESC}")
			Sleep(600)
		#CE
	EndIf
EndFunc   ;==>tradewater

Func ClickLasuke()
	MouseClick("left", 401, 298)
	Sleep(Random(300, 400, 1))
	$coord = PixelSearch(200, 10, 790, 520, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
	If Not @error Then
		TrayTip("", "走向Lasuke！.", 1, 16)
		$x = $coord[0] + 25
		$y = $coord[1]
		MouseMove($x, $y)
		Sleep(100)
		MouseClick("left", Default, Default, 1)
		Sleep(1600)
		MouseMove(400, 300)
		
		$coord = PixelSearch(200, 10, 790, 520, 0xA420FC, 30, 1, $title) ;     ;0xA420FC
		If Not @error Then
			$x = $coord[0]
			$y = $coord[1]
			
			$coord = PixelSearch($x - 50, $y - 100, $x + 90, $y, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
			If Not @error Then
				TrayTip("", "继续操作！.", 1, 16)
				$x = $coord[0]
				$y = $coord[1]
				;MouseMove($x, $y)
				
				$coord = PixelSearch($x - 50, $y + 5, $x - 10, $y + 50, 0xC4C4C4, 20, 1, $title) ;     ;0xA420FC
				If Not @error Then
					$x = $coord[0]
					$y = $coord[1] + 5
					MouseMove($x, $y)
					MouseClick("left", Default, Default, 1)
				EndIf
				Sleep(200)
				;MouseClick("left", Default, Default, 1)
				;MouseMove($coord[0] , $coord[1] )
			EndIf
		EndIf
		Sleep(1800)
	EndIf
EndFunc   ;==>ClickLasuke


Func traderepair()
	;If isInRoom() And findPointColor(500, 440, "4C4C4C") = True Then
	If findPointColor(500, 440, "4C4C4C") = True Then
		TrayTip("", "修理装备.", 1, 16)
		MouseClick("left", 370, 460)
		Sleep(600)
		MouseClick("left", 430, 460)
		Sleep(600)
		Return 1
	Else
		Return 0
	EndIf
	
EndFunc   ;==>traderepair

