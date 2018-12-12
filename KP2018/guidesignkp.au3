
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <DateTimeConstants.au3>
#include <Date.au3>
#include <string.au3>   ;16进制转字符串


#NoTrayIcon
#include <Array.au3>
Opt("TrayMenuMode", 1) ; 默认托盘菜单项目(脚本已暂停/退出脚本) (Script Paused/Exit) 将不显示.

Global $Files = "system.log" ;日志记录
Global $infofiles = "info.dat", $remark = "说明.txt"
Global $usr, $psd, $fire, $d2path1, $d2path2, $d2path3, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5, $guinamepre, $guinamegd, $guikpmode,$ckred,$ckblue
Global $pos, $guibhTime, $guiboxing, $guiMoveBox, $guiboxqty, $guimoveround, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime, $guipath, $guifirelighttime
Global $guiramclose, $guiclosetime, $guiclosestoptime
Global $guiothercheck ;检查他人进入，何时检查，检查到的处理方法，检查到连续跟踪的处理 ,规定两次进房间的间隔局数
Global $guisldspeed ;网速选择
Global $guiWalkspeedAdjust ;不行速度调节
Global $guiotherimage ;是否保存陌生人图片
Global $guititle, $guiexeparm3, $guigamemode ;标题，其他参数,游戏模式
Global $guiclosegame, $guiclosegamesec ;定义是否重启动游戏
Local $avArray[2], $avArrayP[8], $avArrayName[4], $avArrayPath[5], $ArrayOtherWhen[2], $Arrayothermetherd[2]
Local $avGameMode[2] ;游戏模式，单击还是战网
Global $ImageMode[2] ,$guiImageMode;找图的模式，是最普通， 还是通过图片
Local $avKpMode[4] ;kp模式，默认，高效等
Local $avMove[2] ;转移到包裹的方式
Global $guiavAlpName[12] ;自定义的12个字母名称
Global $guitpFire, $guifireFire, $guiarmFire ;技能快捷键


$Form1_1_2_1 = GUICreate("", 531, 614, 489, 42)
$Tab1 = GUICtrlCreateTab(4, 8, 513, 529)
$TabSheet1 = GUICtrlCreateTabItem("系统")
$Group7 = GUICtrlCreateGroup("游戏路径", 8, 32, 505, 177)
$path1 = GUICtrlCreateInput("e:\暗黑破坏神ii毁灭之王\d2loader.exe -w -lq -direct -title d2", 100, 56, 321, 21, BitOR($GUI_SS_DEFAULT_INPUT,$WS_BORDER), BitOR($WS_EX_CLIENTEDGE,$WS_EX_STATICEDGE))
$Label16 = GUICtrlCreateLabel("程序目标:", 20, 56, 55, 17)
$Label17 = GUICtrlCreateLabel("起始位置：", 20, 80, 64, 17)
$path2 = GUICtrlCreateInput("E:\暗黑破坏神II毁灭之王", 100, 80, 289, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label28 = GUICtrlCreateLabel("程序名称：", 20, 104, 64, 17)
$path3 = GUICtrlCreateInput(".exe", 100, 104, 225, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$btnPath = GUICtrlCreateButton("浏览", 428, 52, 43, 25)
$Label3 = GUICtrlCreateLabel("启动参数：", 20, 152, 64, 17)
$ckbexeparm1 = GUICtrlCreateCheckbox("-w (窗口化)", 100, 152, 81, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Label4 = GUICtrlCreateLabel("窗口标题：", 20, 128, 64, 17)
$exetile = GUICtrlCreateInput("exetile", 100, 128, 97, 21)
$Label5 = GUICtrlCreateLabel("例如填：  abc  ", 212, 128, 82, 17)
$Label6 = GUICtrlCreateLabel("其他参数:", 20, 176, 55, 17)
$exeparm3 = GUICtrlCreateInput("-ns", 100, 176, 209, 21)
$Label7 = GUICtrlCreateLabel("(可不填) ", 324, 176, 49, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("外部控制", 8, 400, 505, 129)
$ckbTimeshut = GUICtrlCreateCheckbox("定时关机:", 16, 424, 73, 17)
$dtshut = GUICtrlCreateDate("2017/03/13 12:13:43", 96, 424, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))

	GUICtrlSendMsg(-1, 0x1032, 0, "yyyy/MM/dd HH:mm:ss") ; DTM_SETFORMATW

$Label31 = GUICtrlCreateLabel("网速选择:", 20, 482, 55, 17)
$sldspeed = GUICtrlCreateSlider(88, 476, 134, 20)
GUICtrlSetLimit(-1, 2, 0)
GUICtrlSetData(-1, 1)
$Label32 = GUICtrlCreateLabel("快", 92, 504, 16, 17)
$Label33 = GUICtrlCreateLabel("中", 148, 504, 16, 17)
$Label34 = GUICtrlCreateLabel("慢", 204, 504, 16, 17)
$ckbRanclosegame = GUICtrlCreateCheckbox("定时多少分钟重启游戏：", 16, 448, 161, 17)
$txtranclosegame = GUICtrlCreateInput("60", 180, 448, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label25 = GUICtrlCreateLabel("可直接改善瞬移速度", 236, 480, 112, 17)
$Group16 = GUICtrlCreateGroup("CPU", 368, 416, 137, 81)
$RadNormal = GUICtrlCreateRadio("普通", 396, 436, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadHigh = GUICtrlCreateRadio("增强", 396, 468, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("游戏模式", 8, 216, 505, 49)
$RadGame1 = GUICtrlCreateRadio("战网模式", 76, 236, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadGame2 = GUICtrlCreateRadio("单机模式", 252, 236, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("KP模式(每次选择完, 务必点保存,才生效) -休闲玩家建议使用高效模式", 8, 272, 505, 121)
$Radkpmod2 = GUICtrlCreateRadio("高效模式(推荐)--不做检查,强力kp,仅适合人在电脑面前的短时间内挂机,不实现无人值守", 12, 320, 489, 17)
$Radkpmod1 = GUICtrlCreateRadio("一般模式--检查所有必要功能,实现无人值守,适合0-2小时挂机", 12, 296, 377, 17)
$Radkpmod3 = GUICtrlCreateRadio("慢速模式(少用)--加入延时,适合长时间不在电脑面前的玩家", 12, 344, 361, 17)
$Radkpmod4 = GUICtrlCreateRadio("自定义模式--如果想自己配置功能等界面,请先选用此模式", 12, 368, 377, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("角色")
$Group5 = GUICtrlCreateGroup("角色位置", 236, 41, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 244, 57, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 244, 81, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 244, 105, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 244, 129, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 316, 57, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 316, 81, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 316, 105, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 316, 129, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("角色攻击类型", 16, 164, 494, 281)
$Radio1 = GUICtrlCreateRadio("通用类型", 24, 192, 97, 17)
$Radio2 = GUICtrlCreateRadio("特殊订制", 24, 290, 121, 17)
$Group12 = GUICtrlCreateGroup("", 124, 187, 353, 86)
$Label11 = GUICtrlCreateLabel("传送", 136, 207, 28, 17)
$cmbTpFire = GUICtrlCreateCombo("", 176, 207, 49, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label13 = GUICtrlCreateLabel("冰甲", 242, 207, 28, 17)
$cmbArmFire = GUICtrlCreateCombo("", 286, 207, 57, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label12 = GUICtrlCreateLabel("主攻技能", 134, 235, 52, 17)
$cmbFireFire = GUICtrlCreateCombo("", 200, 235, 57, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_UPPERCASE))
GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8", "F1")
$Label19 = GUICtrlCreateLabel("次数", 278, 235, 28, 17)
$firelighttime = GUICtrlCreateInput("25", 350, 235, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group1 = GUICtrlCreateGroup("帐号信息", 16, 41, 209, 113)
$Label1 = GUICtrlCreateLabel("站网帐号", 24, 65, 52, 17)
$Label2 = GUICtrlCreateLabel("站网密码", 24, 97, 52, 17)
$n1 = GUICtrlCreateInput("", 88, 65, 89, 21)
$n2 = GUICtrlCreateInput("", 88, 97, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet3 = GUICtrlCreateTabItem("路径")
$Group11 = GUICtrlCreateGroup("去红门路径(鞋子推荐 战场之靴-25高跑)", 16, 44, 476, 145)
$RDpath1 = GUICtrlCreateRadio("随机路线", 120, 68, 89, 17)
$RDpath2 = GUICtrlCreateRadio("最短路线", 24, 68, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDpath3 = GUICtrlCreateRadio("单一路线", 24, 92, 73, 17)
$RDpath5 = GUICtrlCreateRadio("专用定制路线", 224, 92, 97, 17)
$RDpath4 = GUICtrlCreateRadio("稳定路线", 120, 92, 81, 17)
$txtSpeed = GUICtrlCreateInput("0", 144, 130, 65, 21)
$Label29 = GUICtrlCreateLabel("步行速度调节毫秒:", 32, 132, 103, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet4 = GUICtrlCreateTabItem("功能")
$Group8 = GUICtrlCreateGroup("功能设置", 16, 168, 489, 302)
$ckbBagfull = GUICtrlCreateCheckbox("包满后关机", 32, 184, 97, 17)
$ckbRej = GUICtrlCreateCheckbox("喝去多余紫瓶", 32, 228, 121, 17)
$ckbRoledead = GUICtrlCreateCheckbox("复活角色", 32, 248, 145, 17)
$ckbAss = GUICtrlCreateCheckbox("复活雇佣兵", 32, 268, 121, 17)
$ckbBoxing = GUICtrlCreateCheckbox("包裹装备转移到仓库", 32, 208, 129, 17)
$ckbQinse = GUICtrlCreateCheckbox("雇佣兵带庇护(pet带青色愤怒)", 32, 308, 177, 17)
$ckbAct5 = GUICtrlCreateCheckbox("检查是否在ACT5", 32, 288, 145, 17)
$Label24 = GUICtrlCreateLabel("每局捡取物品件数上限:", 28, 415, 127, 17)
$picktime = GUICtrlCreateInput("5", 172, 415, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Checkbox1 = GUICtrlCreateCheckbox("自动加红蓝", 32, 372, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Checkbox2 = GUICtrlCreateCheckbox("自动给雇佣兵加血", 32, 392, 121, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Group15 = GUICtrlCreateGroup("转移到仓库方式:", 184, 184, 169, 89)
$boxQty = GUICtrlCreateInput("8", 312, 208, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$RadMove1 = GUICtrlCreateRadio("少于此包裹格数:", 192, 208, 113, 17)
$RadMove2 = GUICtrlCreateRadio("每隔此局数:", 192, 240, 97, 17)
$txtMoveRound = GUICtrlCreateInput("100", 312, 240, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ckbByRed = GUICtrlCreateCheckbox("买红药水", 32, 328, 145, 17)
$ckbByBlue = GUICtrlCreateCheckbox("买蓝药水", 32, 352, 145, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group9 = GUICtrlCreateGroup("房间名设置", 16, 33, 265, 129)
$RDnameAp = GUICtrlCreateRadio("字母房间名", 32, 49, 81, 17)
$RDnameMa = GUICtrlCreateRadio("数字房间名", 32, 73, 81, 17)
$namelenfr = GUICtrlCreateInput("3", 168, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("到", 200, 65, 16, 17)
$namelento = GUICtrlCreateInput("6", 224, 65, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("位", 256, 65, 16, 17)
$Label23 = GUICtrlCreateLabel("长度:", 128, 65, 31, 17)
$Label27 = GUICtrlCreateLabel("名称前缀:", 128, 97, 55, 17)
$namepre = GUICtrlCreateInput("aa", 200, 97, 41, 21)
$RDnameAd = GUICtrlCreateRadio("房间名加1 :", 32, 97, 89, 17)
$RDnameGd = GUICtrlCreateRadio("房间名固定:", 32, 121, 89, 17)
$namegd = GUICtrlCreateInput("aa", 128, 121, 73, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$grpName = GUICtrlCreateGroup("自定义字母名(小写,可重复)", 288, 33, 217, 129)
$txtName1 = GUICtrlCreateInput("a", 296, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName5 = GUICtrlCreateInput("s", 296, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName2 = GUICtrlCreateInput("s", 344, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName3 = GUICtrlCreateInput("d", 392, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName4 = GUICtrlCreateInput("a", 440, 56, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName7 = GUICtrlCreateInput("a", 392, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName6 = GUICtrlCreateInput("d", 344, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName8 = GUICtrlCreateInput("s", 440, 88, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName9 = GUICtrlCreateInput("d", 296, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName10 = GUICtrlCreateInput("s", 344, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName11 = GUICtrlCreateInput("a", 392, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
$txtName12 = GUICtrlCreateInput("s", 440, 120, 33, 21)
GUICtrlSetLimit(-1, 1)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet5 = GUICtrlCreateTabItem("伪装")
$Group10 = GUICtrlCreateGroup("反检测----持续挂机40分钟以上必须设置,否则后果很严重,也不建议长时间挂机", 8, 40, 489, 473)
$ckbRamstop = GUICtrlCreateCheckbox("达到规定KP局数: ", 16, 88, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$kproundtime = GUICtrlCreateInput("30", 144, 87, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$lblstop1 = GUICtrlCreateLabel("暂停秒数:", 184, 87, 55, 17)
$ramstoptime = GUICtrlCreateInput("3600", 272, 87, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbRamclose = GUICtrlCreateCheckbox("达到规定KP局数:", 16, 111, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$kproundclosetime = GUICtrlCreateInput("50", 144, 111, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$lblstop2 = GUICtrlCreateLabel("下线停留分钟", 184, 111, 76, 17)
$closestoptime = GUICtrlCreateInput("30", 272, 111, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$ckbothersin = GUICtrlCreateCheckbox("检查他人进入房间", 16, 64, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$ckbNotfinddoor = GUICtrlCreateCheckbox("连续多次未找到红门，停止挂机", 16, 156, 193, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$ckbConnectError = GUICtrlCreateCheckbox("连续多次网络连接异常，暂停挂机", 16, 184, 209, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
$Checkbox3 = GUICtrlCreateCheckbox("连续多次建房间异常，暂停挂机", 16, 212, 193, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetState(-1, $GUI_HIDE)
$TabSheet6 = GUICtrlCreateTabItem("日志")
$edtLog = GUICtrlCreateEdit("", 12, 40, 500, 361)
$readLog = GUICtrlCreateButton("读取", 116, 416, 75, 25)
$deletLog = GUICtrlCreateButton("清空", 324, 416, 75, 25)
$TabSheet7 = GUICtrlCreateTabItem("说明")
$edtRemark = GUICtrlCreateEdit("", 12, 40, 497, 457)
$TabSheet8 = GUICtrlCreateTabItem("其他")
$grpKeybord = GUICtrlCreateGroup("快捷键设置(需大写,与你游戏中设置一致):", 8, 41, 473, 137)
$lblTab = GUICtrlCreateLabel("小地图:", 16, 65, 43, 17)
$txtTab = GUICtrlCreateInput("TAB", 72, 65, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
$lblTeam = GUICtrlCreateLabel("队伍:", 16, 97, 31, 17)
$txtTeam = GUICtrlCreateInput("P", 72, 97, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
$lblBag = GUICtrlCreateLabel("物品栏:", 16, 129, 43, 17)
$txtBag = GUICtrlCreateInput("I", 72, 129, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_UPPERCASE))
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [300, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "请合理安排挂机时间,低调挂机", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036 潘多拉盒子", 1)
$SaveID = GUICtrlCreateButton("保存", 136, 544, 67, 25)
$ExitID = GUICtrlCreateButton("退出", 264, 544, 67, 25)
$YesID = GUICtrlCreateButton("锁定", 413, 544, 67, 25)
$Label18 = GUICtrlCreateLabel("点锁定后 F11运行/暂停, F10 退出     ", 292, 575, 220, 17)
GUICtrlSetColor(-1, 0xFF0000)
$lblversion = GUICtrlCreateLabel("PindleBox-正式版  ", 392, 8, 96, 17)
$btnInitial = GUICtrlCreateButton("恢复默认", 12, 544, 67, 25)
GUICtrlSetState(-1, $GUI_HIDE)






   TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
   $prefsitem = TrayCreateItem("参数")
   TrayCreateItem("")
   $aboutitem = TrayCreateItem("关于")
   TrayCreateItem("")
   $exititem = TrayCreateItem("退出")
   
#EndRegion ### END Koda GUI section ###

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$mainform = WinGetHandle($Form1_1_2_1)
Func creatGui()
	TraySetState()
	GUISetState(@SW_SHOW, $mainform)
	;WinSetTitle($Form1_1_2_1,"","轻松休闲挂机，勿以好用而滥用.")
	;WinMove("", "", 10, 10)
	readinfor()
	While 1
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		
		
		Select
			Case $msg = $btnPath
				$folder = FileOpenDialog("查找暗黑启动程序", "C:Windows", "可执行文件(*.exe)")
				If Not @error Then
					GUICtrlSetData($path1, $folder)
				Else
					;MsgBox(0, "提示", "请选择正确的路径")
				EndIf
				
				$lenstr = StringInStr(GUICtrlRead($path1), "\", 1, -1) ;
				$path22 = StringLeft(GUICtrlRead($path1), $lenstr) ;得到程序的路径
				$path32 = StringRight(GUICtrlRead($path1), StringLen(GUICtrlRead($path1)) - $lenstr) ;得到程序的路径
				
				GUICtrlSetData($path2, $path22)
				GUICtrlSetData($path3, $path32)
				
			Case $msg = $SaveID ;save info
				If saveinfor() Then
					readinfor()
					MsgBox(0, "提示", "保存成功，请关闭重新打开查看")
				EndIf
			Case $msg = $YesID
				If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 1
				ElseIf BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 2
				EndIf
				GUICtrlSetState($btnInitial, $GUI_DISABLE)
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
				
			Case $msg = $btnInitial
				deletinfo()
				readinfor()
				MsgBox(0, "提示", "恢复默认设置成功,请点击保存", 5)
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
			Case $msg = $readLog
				GUICtrlSetData($edtLog, readdate())
			Case $msg = $deletLog
				Setdate()
				
				
		EndSelect
		
		$msg1 = TrayGetMsg()
		Select
			Case $msg1 = 0
				ContinueLoop
			Case $msg1 = $prefsitem
				MsgBox(64, "参数:", "系统版本:" & @OSVersion)
			Case $msg1 = $aboutitem
				MsgBox(64, "关于:", "暗黑2专用KP挂机工具.QQ：1246035036")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui


Func saveinfor()


	;check
	$lenpath1 = GUICtrlRead($path1)
	$lenpath2 = GUICtrlRead($path2)
	
	$lenNamefr = GUICtrlRead($namelenfr)
	$lenNameto = GUICtrlRead($namelento)
	;$lenbhtime = GUICtrlRead($bhTime)
	$lenboxqty = GUICtrlRead($boxQty)
	$lenpicktiem = GUICtrlRead($picktime)
	$lenroundtime = GUICtrlRead($kproundtime)
	$lenstoptime = GUICtrlRead($ramstoptime)
	$lenroundclosetime = GUICtrlRead($kproundclosetime)
	$lenclosestoptime = GUICtrlRead($closestoptime)
	$lenexetile = GUICtrlRead($exetile)
	
	If $lenpath1 = "" Or $lenpath2 = "" Then
		MsgBox(0, "错误", "请浏览并选择有效的暗黑程序")
		Return False
	EndIf
	
	If $lenexetile = "" Then
		MsgBox(0, "错误", "请输入游戏窗口标题，例如 d2")
		Return False
	EndIf
	
	
	If $lenNamefr <= 0 Then
		MsgBox(0, "错误", "房间长度至少要有1位吧！")
		Return False
	EndIf
	If $lenNamefr > $lenNameto Then
		MsgBox(0, "错误", "起始长度大于结束长度了！")
		Return False
	EndIf
	If $lenNameto > 10 Then
		MsgBox(0, "错误", "没有人会建10位以上的房间名，建议控制在8位以内！")
		Return False
	EndIf
	If $lenboxqty <= 0 Or $lenboxqty >= 40 Then
		MsgBox(0, "警告", "包裹剩余数量必须控制在1 到 39之间,建议5或10格之间")
		Return False
	EndIf
	If $lenpicktiem <= 0 Or $lenpicktiem >= 20 Then
		MsgBox(0, "警告", "捡取物品的最大上限不能为0,也不要过大,建议5次")
		Return False
	EndIf
	If $lenroundtime <= 0 Or $lenroundtime >= 20000 Then
		MsgBox(0, "警告", "规定暂停的kp次数不能为0,也不能无限大")
		Return False
	EndIf
	If $lenstoptime <= 0 Or $lenstoptime >= 20000 Then
		MsgBox(0, "警告", "延时时间不能为0,也不能无限大")
		Return False
	EndIf
	If $lenroundclosetime <= 0 Or $lenroundclosetime >= 20000 Then
		MsgBox(0, "警告", "规定kp下线的次数不能小于0,也不能无限大")
		Return False
	EndIf
	If $lenclosestoptime <= 0 Or $lenclosestoptime >= 20000 Then
		MsgBox(0, "警告", "线下等待时间不能为0,也不能无限大")
		Return False
	EndIf

	
	$avGameMode[0] = $RadGame1
	$avGameMode[1] = $RadGame2
	
	$ImageMode[0] = $RadNormal
	$ImageMode[1] = $RadHigh
	
	$avKpMode[0] = $Radkpmod1
	$avKpMode[1] = $Radkpmod2
	$avKpMode[2] = $Radkpmod3
	$avKpMode[3] = $Radkpmod4
	
	$avArray[0] = $Radio1
	$avArray[1] = $Radio2

	$avArrayP[0] = $RadP1
	$avArrayP[1] = $RadP2
	$avArrayP[2] = $RadP3
	$avArrayP[3] = $RadP4
	$avArrayP[4] = $RadP5
	$avArrayP[5] = $RadP6
	$avArrayP[6] = $RadP7
	$avArrayP[7] = $RadP8

	$avArrayName[0] = $RDnameAp
	$avArrayName[1] = $RDnameMa
	$avArrayName[2] = $RDnameAd
	$avArrayName[3] = $RDnameGd

	$avMove[0] = $RadMove1
	$avMove[1] = $RadMove2

	$avArrayPath[0] = $RDpath1
	$avArrayPath[1] = $RDpath2
	$avArrayPath[2] = $RDpath3
	$avArrayPath[3] = $RDpath4
	$avArrayPath[4] = $RDpath5
	
	
	For $i = 0 To 1 Step 1 ;游戏模式
		If BitAND(GUICtrlRead($avGameMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guigamemode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;找图模式
		If BitAND(GUICtrlRead($ImageMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiImageMode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 3 Step 1 ;KP模式
		If BitAND(GUICtrlRead($avKpMode[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guikpmode = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArray[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$fire = $i + 1
		EndIf
	Next
	
	For $i = 0 To 7 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayP[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$pos = $i + 1
		EndIf
	Next

	For $i = 0 To 3 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayName[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$nameCat = $i + 1
		EndIf
	Next
	
	For $i = 0 To 4 Step 1 ;write path
		If BitAND(GUICtrlRead($avArrayPath[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guipath = $i + 1
		EndIf
	Next
	
	For $i = 0 To 1 Step 1 ;other when in
		If BitAND(GUICtrlRead($ArrayOtherWhen[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiotherwhen = $i + 1
		EndIf
	Next

	For $i = 0 To 1 Step 1 ;other in methord
		If BitAND(GUICtrlRead($Arrayothermetherd[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiothermetherd = $i + 1
		EndIf
	Next

	For $i = 0 To 1 Step 1 ;转移到包裹的方式，检查包裹剩余格数，还是间隔固定局数
		If BitAND(GUICtrlRead($avMove[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$guiMoveBox = $i + 1
		EndIf
	Next
	

	If BitAND(GUICtrlRead($ckbBagfull), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$shutdown = 1
	Else
		$shutdown = 0
	EndIf
	
	If BitAND(GUICtrlRead($ckbRej), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkrej = 1
	Else
		$guidrinkrej = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRoledead), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckroledead = 1
	Else
		$ckroledead = 0
	EndIf
	If BitAND(GUICtrlRead($ckbAss), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckass = 1
	Else
		$ckass = 0
	EndIf
	If BitAND(GUICtrlRead($ckbQinse), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$sanctury = 1
	Else
		$sanctury = 0
	EndIf
	
	If BitAND(GUICtrlRead($ckbBoxing), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiboxing = 1
	Else
		$guiboxing = 0
	EndIf
	#CS 	If BitAND(GUICtrlRead($ckbHeal), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkheal = 1
		Else
		$guidrinkheal = 0
		EndIf
		If BitAND(GUICtrlRead($ckbMana), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guidrinkmana = 1
		Else
		$guidrinkmana = 0
		EndIf
	#CE
	If BitAND(GUICtrlRead($ckbTimeshut), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guisettime = 1
	Else
		$guisettime = 0
	EndIf
	If BitAND(GUICtrlRead($ckbAct5), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckact5 = 1
	Else
		$ckact5 = 0
	EndIf
		If BitAND(GUICtrlRead($ckbByRed), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckred = 1
	Else
		$ckred = 0
	EndIf
		If BitAND(GUICtrlRead($ckbByBlue), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$ckblue = 1
	Else
		$ckblue = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRamstop), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiramstop = 1
	Else
		$guiramstop = 0
	EndIf
	If BitAND(GUICtrlRead($ckbRamclose), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiramclose = 1
	Else
		$guiramclose = 0
	EndIf
	If BitAND(GUICtrlRead($ckbothersin), $GUI_CHECKED) = $GUI_CHECKED Then ; other in room
		$guiothercheck = 1
	Else
		$guiothercheck = 0
	EndIf

	
	
	If BitAND(GUICtrlRead($ckbRanclosegame), $GUI_CHECKED) = $GUI_CHECKED Then ; 是否重启游戏
		$guiclosegame = 1
	Else
		$guiclosegame = 0
	EndIf
	

	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "帐号", GUICtrlRead($n1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "密码", _StringToHex(GUICtrlRead($n2)))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "类型", $fire)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "位置", $pos)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "程序目标", GUICtrlRead($path1))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "起始位置", GUICtrlRead($path2))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "程序名称", GUICtrlRead($path3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "其他参数", GUICtrlRead($exeparm3))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "窗口标题", GUICtrlRead($exetile))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "游戏模式", $guigamemode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "CPU模式", $guiImageMode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "kp模式", $guikpmode)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否重启游戏", $guiclosegame)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "重启游戏分钟", GUICtrlRead($txtranclosegame))
	
	;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "起始位置", $path22)
	;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "程序名称", $path32)
		
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "火法传送", GUICtrlRead($cmbTpFire))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "火法大火球", GUICtrlRead($cmbFireFire))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "火法装甲", GUICtrlRead($cmbArmFire))
	
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满后关机", $shutdown)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满装箱", $guiboxing)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "装箱方式", $guiMoveBox)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "少于格数开始装箱", GUICtrlRead($boxQty))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "间隔局数开始装箱", GUICtrlRead($txtMoveRound))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名格式", $nameCat)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名前缀", GUICtrlRead($namepre))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名固定名称", GUICtrlRead($namegd))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "喝去多余紫瓶", $guidrinkrej)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活角色", $ckroledead)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活雇佣兵", $ckass)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名长度下限", GUICtrlRead($namelenfr))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名长度上限", GUICtrlRead($namelento))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否定时关机", $guisettime)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "定时关机时间", GUICtrlRead($dtshut))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "物品循环捡取次数", GUICtrlRead($picktime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "火电攻击次数", GUICtrlRead($firelighttime))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "网速选择", GUICtrlRead($sldspeed))
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "步行调节", GUICtrlRead($txtSpeed))
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "去红门路线", $guipath)
	
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "雇佣兵带庇护", $sanctury)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查是否在ACT5", $ckact5)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否买红药水", $ckred)
	IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否买蓝药水", $ckblue)
	
	;--以下是伪装功能，对于免费版，最好屏蔽
	If $testversion = 0 Then
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否次数延时", $guiramstop)
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到延时次数", GUICtrlRead($kproundtime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "暂停时数", GUICtrlRead($ramstoptime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否脱机", $guiramclose)
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到脱机次数", GUICtrlRead($kproundclosetime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "脱机时间", GUICtrlRead($closestoptime))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查其他人进入", $guiothercheck)
		
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名1", GUICtrlRead($txtName1))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名2", GUICtrlRead($txtName2))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名3", GUICtrlRead($txtName3))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名4", GUICtrlRead($txtName4))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名5", GUICtrlRead($txtName5))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名6", GUICtrlRead($txtName6))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名7", GUICtrlRead($txtName7))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名8", GUICtrlRead($txtName8))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名9", GUICtrlRead($txtName9))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名10", GUICtrlRead($txtName10))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名11", GUICtrlRead($txtName11))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "字母名12", GUICtrlRead($txtName12))
		
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "快捷键小地图", GUICtrlRead($txtTab))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "快捷键队伍", GUICtrlRead($txtTeam))
		IniWrite(@ScriptDir & "\" & $infofiles, "KP", "快捷键包裹", GUICtrlRead($txtBag))
		
	Else
		$guikpmode = 4
	EndIf
	;以下是加入了kp模式选择，写入一些必要的功能
	Select
		Case $guikpmode = 1
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名格式", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "非固定暴风雪", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满后关机", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满装箱", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "少于格数开始装箱", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "喝去多余紫瓶", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活角色", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活雇佣兵", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查是否在ACT5", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否次数延时", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到延时次数", 26)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "暂停时数", 76)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否脱机", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到脱机次数", 76)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "脱机时间", 23)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线随机延时", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线延时秒数", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "启用推荐延时", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查其他人进入", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "其他玩家", 1)
			
			
			
		Case $guikpmode = 2
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名格式", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "非固定暴风雪", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满后关机", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满装箱", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "少于格数开始装箱", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "喝去多余紫瓶", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活角色", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活雇佣兵", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查是否在ACT5", 0)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否次数延时", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到延时次数", 31)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "暂停时数", 116)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否脱机", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到脱机次数", 76)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "脱机时间", 23)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线随机延时", 0)
			;IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线延时秒数", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "启用推荐延时", 0)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查其他人进入", 0)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "其他玩家", 1)
		Case $guikpmode = 3
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "房间名格式", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满后关机", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "包裹满装箱", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "少于格数开始装箱", 11)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "喝去多余紫瓶", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活角色", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "复活雇佣兵", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查是否在ACT5", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否次数延时", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到延时次数", 23)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "暂停时数", 183)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "是否脱机", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "达到脱机次数", 83)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "脱机时间", 37)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线随机延时", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "最短路线延时秒数", 15)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "启用推荐延时", 1)
			
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "检查其他人进入", 1)
			IniWrite(@ScriptDir & "\" & $infofiles, "KP", "其他玩家", 1)
			
		Case $guikpmode = 4
			;用户自定义，不做强制改变
	EndSelect


	Return True
EndFunc   ;==>saveinfor

Func readinfor()
	

	$usr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "帐号", "")
	$psd = _HexToString(IniRead(@ScriptDir & "\" & $infofiles, "KP", "密码", "")) ;16进制转换回二进制
	$fire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "类型", "1")
	$pos = IniRead(@ScriptDir & "\" & $infofiles, "KP", "位置", "1")
	$d2path1 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "程序目标", "")
	$d2path2 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "起始位置", "")
	$d2path3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "程序名称", "")
	$guiexeparm3 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "其他参数", "")
	$guititle = IniRead(@ScriptDir & "\" & $infofiles, "KP", "窗口标题", "d")
	$guigamemode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "游戏模式", "1")
	$guiImageMode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "CPU模式", "1")
	$guikpmode = IniRead(@ScriptDir & "\" & $infofiles, "KP", "kp模式", "1")
	
	$guiclosegame = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否重启游戏", "1")
	$guiclosegamesec = IniRead(@ScriptDir & "\" & $infofiles, "KP", "重启游戏分钟", "40")
	
	$guitpFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "火法传送", "F1")
	$guifireFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "火法大火球", "F2")
	$guiarmFire = IniRead(@ScriptDir & "\" & $infofiles, "KP", "火法装甲", "F5")

	
	$shutdown = IniRead(@ScriptDir & "\" & $infofiles, "KP", "包裹满后关机", "1")
	$nameCat = IniRead(@ScriptDir & "\" & $infofiles, "KP", "房间名格式", "1")
	$guinamepre = IniRead(@ScriptDir & "\" & $infofiles, "KP", "房间名前缀", "mf")
	$guinamegd = IniRead(@ScriptDir & "\" & $infofiles, "KP", "房间名固定名称", "asd")
	$guidrinkrej = IniRead(@ScriptDir & "\" & $infofiles, "KP", "喝去多余紫瓶", "1")
	$ckroledead = IniRead(@ScriptDir & "\" & $infofiles, "KP", "复活角色", "1")
	$ckass = IniRead(@ScriptDir & "\" & $infofiles, "KP", "复活雇佣兵", "1")
	;$guibhTime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "bh释放持续时间", "")
	$guiboxing = IniRead(@ScriptDir & "\" & $infofiles, "KP", "包裹满装箱", "1")
	$guiMoveBox = IniRead(@ScriptDir & "\" & $infofiles, "KP", "装箱方式", "2")
	$guiboxqty = IniRead(@ScriptDir & "\" & $infofiles, "KP", "少于格数开始装箱", "10")
	$guimoveround = IniRead(@ScriptDir & "\" & $infofiles, "KP", "间隔局数开始装箱", "100")
	
	$guinamelenfr = IniRead(@ScriptDir & "\" & $infofiles, "KP", "房间名长度下限", "1")
	$guinamelento = IniRead(@ScriptDir & "\" & $infofiles, "KP", "房间名长度上限", "5")
	$guisettime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否定时关机", "")
	$guitimedata = IniRead(@ScriptDir & "\" & $infofiles, "KP", "定时关机时间", "")
	$guipicktime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "物品循环捡取次数", "6")
	$ckact5 = IniRead(@ScriptDir & "\" & $infofiles, "KP", "检查是否在ACT5", "1")
	$ckred = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否买红药水", "1")
	$ckblue = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否买蓝药水", "1")
	$sanctury = IniRead(@ScriptDir & "\" & $infofiles, "KP", "雇佣兵带庇护", "")
	$guiramstop = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否次数延时", "1")
	$guikpstoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "达到延时次数", "30")
	$guiramtime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "暂停时数", "163")
	
	$guiramclose = IniRead(@ScriptDir & "\" & $infofiles, "KP", "是否脱机", "1")
	$guiclosetime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "达到脱机次数", "82")
	$guiclosestoptime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "脱机时间", "37")
	
	$char_TAB = IniRead(@ScriptDir & "\" & $infofiles, "KP", "快捷键小地图", "TAB")
	$char_Team = IniRead(@ScriptDir & "\" & $infofiles, "KP", "快捷键队伍", "P")
	$char_Bag = IniRead(@ScriptDir & "\" & $infofiles, "KP", "快捷键包裹", "B")
	
	$guiblztime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "暴风雪攻击次数", "3")
	$guifirelighttime = IniRead(@ScriptDir & "\" & $infofiles, "KP", "火电攻击次数", "27")
	$guisldspeed = IniRead(@ScriptDir & "\" & $infofiles, "KP", "网速选择", "1")
	$guiWalkspeedAdjust = IniRead(@ScriptDir & "\" & $infofiles, "KP", "步行调节", "0")
	$guipath = IniRead(@ScriptDir & "\" & $infofiles, "KP", "去红门路线", "3")

	$guiothercheck = IniRead(@ScriptDir & "\" & $infofiles, "KP", "检查其他人进入", "1")
	$guiotherwhen = IniRead(@ScriptDir & "\" & $infofiles, "KP", "何时检查其他人", "1")
	$guiothermetherd = IniRead(@ScriptDir & "\" & $infofiles, "KP", "检查其他人处理方式", "1")
	$guiotherroundtrace = IniRead(@ScriptDir & "\" & $infofiles, "KP", "检查其他人连续跟踪处理", "1")
	$guiroundinterval = IniRead(@ScriptDir & "\" & $infofiles, "KP", "连续两次进房间的间隔局数", "8")
	$guiotherimage = IniRead(@ScriptDir & "\" & $infofiles, "KP", "其他玩家", "1")
	
	$guiavAlpName[0] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名1", "a")
	$guiavAlpName[1] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名2", "s")
	$guiavAlpName[2] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名3", "d")
	$guiavAlpName[3] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名4", "f")
	$guiavAlpName[4] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名5", "q")
	$guiavAlpName[5] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名6", "q")
	$guiavAlpName[6] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名7", "z")
	$guiavAlpName[7] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名8", "c")
	$guiavAlpName[8] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名9", "v")
	$guiavAlpName[9] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名10", "a")
	$guiavAlpName[10] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名11", "d")
	$guiavAlpName[11] = IniRead(@ScriptDir & "\" & $infofiles, "KP", "字母名12", "x")


	If $cheapversion = 1 Then ;如果简易版本，即不带转移包裹功能
		GUICtrlSetState($ckbBagfull, $GUI_DISABLE)
		GUICtrlSetState($ckbBoxing, $GUI_DISABLE)
		$guiboxing = 0
		$shutdown = 0
	EndIf



	If $testversion = 1 Then ;如果测试版
		;WinSetTitle($Form1_1_2_1, "", "PindleBox-放松心情挂机，欢迎使用正式版")
		GUICtrlSetData($lblversion, "PindleBox-免费版")
		;系统
		GUICtrlSetState($ckbTimeshut, $GUI_DISABLE)
		GUICtrlSetState($sldspeed, $GUI_DISABLE)
		GUICtrlSetState($ckbRanclosegame, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod1, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod2, $GUI_DISABLE)
		GUICtrlSetState($Radkpmod3, $GUI_DISABLE)
		GUICtrlSetState($RadHigh, $GUI_DISABLE)
		
		$guikpmode = 4
		$guisettime = 0
		$guisldspeed = 2
		$guiclosegame = 0
		$guiImageMode = 1 
		;---角色
		;GUICtrlSetState($Radio2, $GUI_DISABLE)

		;-路径
		GUICtrlSetState($RDpath1, $GUI_DISABLE)
		GUICtrlSetState($RDpath2, $GUI_DISABLE)
		GUICtrlSetState($RDpath3, $GUI_DISABLE)
		
		
		;功能
		GUICtrlSetState($grpName, $GUI_HIDE)
		GUICtrlSetState($txtName1, $GUI_HIDE)
		GUICtrlSetState($txtName2, $GUI_HIDE)
		GUICtrlSetState($txtName3, $GUI_HIDE)
		GUICtrlSetState($txtName4, $GUI_HIDE)
		GUICtrlSetState($txtName5, $GUI_HIDE)
		GUICtrlSetState($txtName6, $GUI_HIDE)
		GUICtrlSetState($txtName7, $GUI_HIDE)
		GUICtrlSetState($txtName8, $GUI_HIDE)
		GUICtrlSetState($txtName9, $GUI_HIDE)
		GUICtrlSetState($txtName10, $GUI_HIDE)
		GUICtrlSetState($txtName11, $GUI_HIDE)
		GUICtrlSetState($txtName12, $GUI_HIDE)
		
		GUICtrlSetState($RDnameAp, $GUI_DISABLE)
		GUICtrlSetState($RDnameAd, $GUI_DISABLE)
		GUICtrlSetState($RDnameGd, $GUI_DISABLE)
		GUICtrlSetState($namelenfr, $GUI_DISABLE)
		GUICtrlSetState($namelento, $GUI_DISABLE)
		GUICtrlSetState($namepre, $GUI_DISABLE)
		GUICtrlSetState($namegd, $GUI_DISABLE)
		
		GUICtrlSetState($RadMove1, $GUI_DISABLE)
		GUICtrlSetState($RadMove2, $GUI_DISABLE)
		GUICtrlSetState($boxQty, $GUI_DISABLE)
		GUICtrlSetState($txtMoveRound, $GUI_DISABLE)
		
		GUICtrlSetState($ckbBagfull, $GUI_DISABLE)
		GUICtrlSetState($ckbBoxing, $GUI_DISABLE)
		GUICtrlSetState($ckbRej, $GUI_DISABLE)
		GUICtrlSetState($ckbRoledead, $GUI_DISABLE)
		GUICtrlSetState($ckbAss, $GUI_DISABLE)
		GUICtrlSetState($ckbAct5, $GUI_DISABLE)
		GUICtrlSetState($ckbByRed, $GUI_DISABLE)
		GUICtrlSetState($ckbByBlue, $GUI_DISABLE)
		GUICtrlSetState($ckbQinse, $GUI_DISABLE)
		GUICtrlSetState($picktime, $GUI_DISABLE)
		
		
		$nameCat = 2
		$guinamelenfr = 1
		$guinamelento = 4
		$guinamepre = ""
		
		
		$shutdown = 0
		$guiboxing = 0
		$guidrinkrej = 0
		$ckroledead = 0
		$ckass = 0
		$ckact5 = 0
		$ckred = 0
		$ckblue = 0
		$guipicktime = 5
		
		;伪装
		GUICtrlSetState($ckbRamstop, $GUI_HIDE)
		GUICtrlSetState($ckbRamclose, $GUI_HIDE)
		GUICtrlSetState($kproundtime, $GUI_HIDE)
		GUICtrlSetState($ramstoptime, $GUI_HIDE)
		GUICtrlSetState($lblstop1, $GUI_HIDE)
		GUICtrlSetState($lblstop2, $GUI_HIDE)
		GUICtrlSetState($kproundclosetime, $GUI_HIDE)
		GUICtrlSetState($closestoptime, $GUI_HIDE)
		
		GUICtrlSetState($ckbothersin, $GUI_HIDE)
				
		GUICtrlSetState($grpKeybord, $GUI_HIDE)
		GUICtrlSetState($lblTab, $GUI_HIDE)
		GUICtrlSetState($lblTeam, $GUI_HIDE)
		GUICtrlSetState($lblBag, $GUI_HIDE)
		GUICtrlSetState($txtTab, $GUI_HIDE)
		GUICtrlSetState($txtTeam, $GUI_HIDE)
		GUICtrlSetState($txtBag, $GUI_HIDE)
		
		GUICtrlSetState($ckbNotfinddoor,$GUI_HIDE)
		GUICtrlSetState($ckbConnectError,$GUI_HIDE)
		GUICtrlSetState($Checkbox3,$GUI_HIDE)
		
		$guiramstop = 0
		$guiramclose = 0
		$guiothercheck = 0
		$guiotherroundtrace = 0
		$guiotherimage = 0
		
		
	EndIf
	
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	GUICtrlSetData($path1, $d2path1)
	GUICtrlSetData($path2, $d2path2)
	GUICtrlSetData($path3, $d2path3)
	GUICtrlSetData($exeparm3, $guiexeparm3)
	GUICtrlSetData($exetile, $guititle)
	GUICtrlSetData($txtranclosegame, $guiclosegamesec)
	

	GUICtrlSetData($cmbTpFire, $guitpFire) ;技能
	GUICtrlSetData($cmbFireFire, $guifireFire) ;技能
	GUICtrlSetData($cmbArmFire, $guiarmFire) ;技能
	
	GUICtrlSetData($txtName1, $guiavAlpName[0]) ;自定义字母名
	GUICtrlSetData($txtName2, $guiavAlpName[1]) ;自定义字母名
	GUICtrlSetData($txtName3, $guiavAlpName[2]) ;自定义字母名
	GUICtrlSetData($txtName4, $guiavAlpName[3]) ;自定义字母名
	GUICtrlSetData($txtName5, $guiavAlpName[4]) ;自定义字母名
	GUICtrlSetData($txtName6, $guiavAlpName[5]) ;自定义字母名
	GUICtrlSetData($txtName7, $guiavAlpName[6]) ;自定义字母名
	GUICtrlSetData($txtName8, $guiavAlpName[7]) ;自定义字母名
	GUICtrlSetData($txtName9, $guiavAlpName[8]) ;自定义字母名
	GUICtrlSetData($txtName10, $guiavAlpName[9]) ;自定义字母名
	GUICtrlSetData($txtName11, $guiavAlpName[10]) ;自定义字母名
	GUICtrlSetData($txtName12, $guiavAlpName[11]) ;自定义字母名
	
	
	
	;GUICtrlSetData($bhTime, $guibhTime)
	GUICtrlSetData($boxQty, $guiboxqty)
	GUICtrlSetData($txtMoveRound, $guimoveround)
	
	GUICtrlSetData($namelenfr, $guinamelenfr)
	GUICtrlSetData($namelento, $guinamelento)
	GUICtrlSetData($dtshut, $guitimedata)
	GUICtrlSetData($picktime, $guipicktime)
	GUICtrlSetData($kproundtime, $guikpstoptime)
	GUICtrlSetData($sldspeed, $guisldspeed) ;网速
	GUICtrlSetData($txtSpeed, $guiWalkspeedAdjust) ;网速
	GUICtrlSetData($ramstoptime, $guiramtime)
	
	
	GUICtrlSetData($kproundclosetime, $guiclosetime)
	GUICtrlSetData($closestoptime, $guiclosestoptime)
	
	GUICtrlSetData($txtTab, $char_TAB) ; 快捷键
	GUICtrlSetData($txtTeam, $char_Team) ;快捷键
	GUICtrlSetData($txtBag, $char_Bag) ;快捷键
	
	GUICtrlSetData($firelighttime, $guifirelighttime)
	GUICtrlSetData($namepre, $guinamepre)
	GUICtrlSetData($namegd, $guinamegd)
	
	Select
		Case $guigamemode = 1
			GUICtrlSetState($RadGame1, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($RadGame2, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guiImageMode = 1
			GUICtrlSetState($RadNormal, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($RadHigh, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guikpmode = 1
			GUICtrlSetState($Radkpmod1, $GUI_CHECKED)
		Case $guikpmode = 2
			GUICtrlSetState($Radkpmod2, $GUI_CHECKED)
		Case $guikpmode = 3
			GUICtrlSetState($Radkpmod3, $GUI_CHECKED)
		Case $guikpmode = 4
			GUICtrlSetState($Radkpmod4, $GUI_CHECKED)
	EndSelect
	
	
	If $guiclosegame = 1 Then
		GUICtrlSetState($ckbRanclosegame, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRanclosegame, $GUI_UNCHECKED)
	EndIf
	
	
	Select
		Case $fire = 1
			GUICtrlSetState($Radio1, $GUI_CHECKED)
		Case $fire = 2
			GUICtrlSetState($Radio2, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $pos = 1
			GUICtrlSetState($RadP1, $GUI_CHECKED)
		Case $pos = 2
			GUICtrlSetState($RadP2, $GUI_CHECKED)
		Case $pos = 3
			GUICtrlSetState($RadP3, $GUI_CHECKED)
		Case $pos = 4
			GUICtrlSetState($RadP4, $GUI_CHECKED)
		Case $pos = 5
			GUICtrlSetState($RadP5, $GUI_CHECKED)
		Case $pos = 6
			GUICtrlSetState($RadP6, $GUI_CHECKED)
		Case $pos = 7
			GUICtrlSetState($RadP7, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($RadP8, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $nameCat = 1
			GUICtrlSetState($RDnameAp, $GUI_CHECKED)
		Case $nameCat = 2
			GUICtrlSetState($RDnameMa, $GUI_CHECKED)
		Case $nameCat = 3
			GUICtrlSetState($RDnameAd, $GUI_CHECKED)
		Case $nameCat = 4
			GUICtrlSetState($RDnameGd, $GUI_CHECKED)
	EndSelect
	
	Select
		Case $guipath = 1
			GUICtrlSetState($RDpath1, $GUI_CHECKED)
		Case $guipath = 2
			GUICtrlSetState($RDpath2, $GUI_CHECKED)
		Case $guipath = 3
			GUICtrlSetState($RDpath3, $GUI_CHECKED)
		Case $guipath = 4
			GUICtrlSetState($RDpath4, $GUI_CHECKED)
		Case $guipath = 5
			GUICtrlSetState($RDpath5, $GUI_CHECKED)
			
	EndSelect
		
	
	If $shutdown = 1 Then
		GUICtrlSetState($ckbBagfull, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbBagfull, $GUI_UNCHECKED)
	EndIf
	
	If $guiboxing = 1 Then
		GUICtrlSetState($ckbBoxing, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbBoxing, $GUI_UNCHECKED)
	EndIf
	
	If $guiMoveBox = 1 Then
		GUICtrlSetState($RadMove1, $GUI_CHECKED)
	Else
		GUICtrlSetState($RadMove2, $GUI_CHECKED)
	EndIf
	
	
	If $guidrinkrej = 1 Then
		GUICtrlSetState($ckbRej, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRej, $GUI_UNCHECKED)
	EndIf
	
	If $ckroledead = 1 Then
		GUICtrlSetState($ckbRoledead, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRoledead, $GUI_UNCHECKED)
	EndIf
	If $ckass = 1 Then
		GUICtrlSetState($ckbAss, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbAss, $GUI_UNCHECKED)
	EndIf
	#CS 	If $guidrinkheal = 1 Then
		GUICtrlSetState($ckbHeal, $GUI_CHECKED)
		Else
		GUICtrlSetState($ckbHeal, $GUI_UNCHECKED)
		EndIf
		If $guidrinkmana = 1 Then
		GUICtrlSetState($ckbMana, $GUI_CHECKED)
		Else
		GUICtrlSetState($ckbMana, $GUI_UNCHECKED)
		EndIf
	#CE
	If $guisettime = 1 Then
		GUICtrlSetState($ckbTimeshut, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbTimeshut, $GUI_UNCHECKED)
	EndIf
	If $ckact5 = 1 Then
		GUICtrlSetState($ckbAct5, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbAct5, $GUI_UNCHECKED)
	EndIf
	If $ckred = 1 Then
		GUICtrlSetState($ckbByRed, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbByRed, $GUI_UNCHECKED)
	EndIf
	If $ckblue = 1 Then
		GUICtrlSetState($ckbByBlue, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbByBlue, $GUI_UNCHECKED)
	EndIf
	If $sanctury = 1 Then
		GUICtrlSetState($ckbQinse, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbQinse, $GUI_UNCHECKED)
	EndIf
	If $guiramstop = 1 Then
		GUICtrlSetState($ckbRamstop, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRamstop, $GUI_UNCHECKED)
	EndIf
	If $guiramclose = 1 Then
		GUICtrlSetState($ckbRamclose, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbRamclose, $GUI_UNCHECKED)
	EndIf
	If $guiothercheck = 1 Then ;检查其他人是否进入
		GUICtrlSetState($ckbothersin, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbothersin, $GUI_UNCHECKED)
	EndIf
	


	GUICtrlSetData($edtRemark, readremark()) ;读取txt中的备注 ,必须放在最后，否则影响加载时间
EndFunc   ;==>readinfor

Func Readdate()
	Local $txt, $temp
	$temp = FileOpen($Files, 0)
	$txt = FileRead($temp)
	FileClose($temp)
	Return $txt
EndFunc   ;==>Readdate

Func Setdate()
	Local $txt, $temp
	$temp = FileOpen($Files, 2)
	$txt = GUICtrlRead($edtLog)
	FileDelete($temp)
	;FileWrite($temp,$txt)
	FileClose($temp)
	GUICtrlSetData($edtLog, readdate())
	
EndFunc   ;==>Setdate


Func readremark()
	Local $txt, $temp
	$temp = FileOpen($remark, 0)
	$txt = FileRead($temp)
	FileClose($temp)
	Return $txt
EndFunc   ;==>readremark


Func deletinfo()
	FileDelete(@ScriptDir & "\" & $infofiles)
	FileClose(@ScriptDir & "\" & $infofiles)

	
EndFunc   ;==>deletinfo
