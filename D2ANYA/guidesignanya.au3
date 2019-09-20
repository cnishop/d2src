
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
Global $usr, $psd, $fire, $cta, $d2path1, $d2path2, $shutdown, $nameCat, $guidrinkrej, $ckroledead, $ckass, $sanctury, $ckact5
Global $pos, $guibhTime, $guiboxing, $guiboxqty, $guinamelenfr, $guinamelento, $guidrinkheal, $guidrinkmana, $guisettime, $guitimedata, $guipicktime
Global $guiramstop, $guikpstoptime, $guiramtime, $guiblztime
Local $avArray[3], $avArrayP[8], $avArrayName[2]
Global $guiothercheck, $guistaymin
Global $Files = "system.log"   ;日志记录

#Region ### START Koda GUI section ### Form=d:\autoit3\examples\guo\d2anya\anya.kxf
$Form1_1_2_1 = GUICreate("暗黑2-挂机王-shop商店版", 641, 556, 192, 124)
$Tab1 = GUICtrlCreateTab(8, 8, 625, 521)
$TabSheet1 = GUICtrlCreateTabItem("系统设置")
$Group1 = GUICtrlCreateGroup("帐号信息(可不输入,但需已登陆战网)", 20, 33, 225, 113)
$Label1 = GUICtrlCreateLabel("站网帐号", 28, 57, 52, 17)
$Label2 = GUICtrlCreateLabel("站网密码", 28, 89, 52, 17)
$n1 = GUICtrlCreateInput("", 84, 49, 89, 21)
$n2 = GUICtrlCreateInput("", 84, 81, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("角色位置", 252, 33, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 260, 49, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 260, 73, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 260, 97, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 260, 121, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 332, 49, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 332, 73, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 332, 97, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 332, 121, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$YesID = GUICtrlCreateButton("锁定", 396, 441, 75, 25)
$Group7 = GUICtrlCreateGroup("暗黑路径(鼠标右击游戏快捷方式获得)", 20, 280, 593, 89)
$path1 = GUICtrlCreateInput("E:\暗黑破坏神II毁灭之王\D2loader.exe -w -lq -direct -title d2", 112, 304, 473, 21)
$Label16 = GUICtrlCreateLabel("程序目标:", 32, 304, 55, 17)
$Label17 = GUICtrlCreateLabel("起始位置：", 32, 336, 64, 17)
$path2 = GUICtrlCreateInput("E:\暗黑破坏神II毁灭之王", 112, 336, 289, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$SaveID = GUICtrlCreateButton("保存", 108, 441, 75, 25)
$ExitID = GUICtrlCreateButton("退出", 244, 441, 75, 25)
$Label18 = GUICtrlCreateLabel("点锁定后F9运行,F10退出", 416, 472, 133, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Group8 = GUICtrlCreateGroup("功能设置", 424, 145, 193, 121)
$ckbBagfull = GUICtrlCreateCheckbox("包满后关机", 440, 161, 97, 17)
$ckbBoxing = GUICtrlCreateCheckbox("包裹满是否装箱", 440, 181, 121, 17)
$boxQty = GUICtrlCreateInput("8", 576, 201, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label20 = GUICtrlCreateLabel("少于此格数执行", 464, 201, 88, 17)
$ckbother = GUICtrlCreateCheckbox("检查他人进房间", 440, 224, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group9 = GUICtrlCreateGroup("房间名设置", 424, 32, 185, 113)
$RDnameAp = GUICtrlCreateRadio("字母房间名", 440, 48, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RDnameMa = GUICtrlCreateRadio("数字房间名", 440, 72, 113, 17)
$namelenfr = GUICtrlCreateInput("3", 480, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label21 = GUICtrlCreateLabel("到", 512, 104, 16, 17)
$namelento = GUICtrlCreateInput("6", 536, 96, 25, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
$Label22 = GUICtrlCreateLabel("位", 568, 104, 16, 17)
$Label23 = GUICtrlCreateLabel("长度:", 440, 104, 31, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group10 = GUICtrlCreateGroup("附加设置", 19, 152, 393, 113)
$dtshut = GUICtrlCreateDate("2011/06/03 12:13:43", 107, 176, 138, 21, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))

	GUICtrlSendMsg(-1, 0x1032, 0, "yyyy/MM/dd HH:mm:ss") ; DTM_SETFORMATW

$ckbTimeshut = GUICtrlCreateCheckbox("定时关机:", 27, 176, 73, 17)
$Label3 = GUICtrlCreateLabel("房间内最大停留分钟：", 24, 208, 124, 17)
$staymin = GUICtrlCreateInput("60", 160, 208, 73, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet2 = GUICtrlCreateTabItem("日志查看")
$edtLog = GUICtrlCreateEdit("", 16, 40, 604, 432)
$readlog = GUICtrlCreateButton("读取", 95, 492, 75, 25)
$deletLog = GUICtrlCreateButton("清空", 362, 493, 75, 25)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_2_1)
Dim $StatusBar1_PartsWidth[2] = [400, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "不发送任何数据包,避开Warden检测机制,请合理安排挂机时间", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "QQ:1246035036", 1)





TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("参数")
TrayCreateItem("")
$aboutitem = TrayCreateItem("关于")
TrayCreateItem("")
$exititem = TrayCreateItem("退出")

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$mainform = WinGetHandle($Form1_1_2_1)
Func creatGui()
	TraySetState()
	GUISetState(@SW_SHOW, $mainform)
	readinfor()
	While 1
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		Select
			Case $msg = $SaveID ;save info
				If saveinfor() Then
					MsgBox(0, "成功", "保存成功")
				EndIf
			Case $msg = $YesID
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
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
				MsgBox(64, "关于:", "暗黑2专用KP挂机工具.")
			Case $msg1 = $exititem
				Exit 0
		EndSelect
		
	WEnd
EndFunc   ;==>creatGui

Func saveinfor()

	;check
	$lenNamefr = GUICtrlRead($namelenfr)
	$lenNameto = GUICtrlRead($namelento)
	;$lenbhtime = GUICtrlRead($bhTime)
	$lenboxqty = GUICtrlRead($boxQty)
	;$lenpicktiem = GUICtrlRead($picktime)
	;$lenroundtime = GUICtrlRead($kproundtime)
	;$lenstoptime = GUICtrlRead($ramstoptime)
	;$lenblztime = GUICtrlRead($blztime)
	
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
	#CS	If $lenpicktiem <= 0 Or $lenpicktiem >= 20 Then
		MsgBox(0, "警告", "找东西的次数不能为0,也不要过大,建议5次左右")
		Return False
		EndIf
		If $lenroundtime <= 0 Or $lenroundtime >= 20000 Then
		MsgBox(0, "警告", "kp次数不能为0,也不能无限大")
		Return False
		EndIf
		If $lenstoptime <= 0 Or $lenstoptime >= 20000 Then
		MsgBox(0, "警告", "延时时间不能为0,也不能无限大")
		Return False
		EndIf
		If $lenblztime <= 0 Or $lenblztime >= 10 Then
		MsgBox(0, "警告", "暴风雪攻击次数为能为0,也不能太长，建议3次")
		Return False
		EndIf
	#CE
	
	
	#CS 	$avArray[0] = $Radio1
		$avArray[1] = $Radio2
		$avArray[2] = $Radio3
	#CE
	
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
	
	For $i = 0 To 2 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArray[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$fire = $i + 1
		EndIf
	Next
	
	For $i = 0 To 7 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayP[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$pos = $i + 1
		EndIf
	Next

	For $i = 0 To 1 Step 1 ;write cati
		If BitAND(GUICtrlRead($avArrayName[$i]), $GUI_CHECKED) = $GUI_CHECKED Then
			$nameCat = $i + 1
		EndIf
	Next




	If BitAND(GUICtrlRead($ckbBagfull), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$shutdown = 1
	Else
		$shutdown = 0
	EndIf
	

	
	If BitAND(GUICtrlRead($ckbBoxing), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guiboxing = 1
	Else
		$guiboxing = 0
	EndIf

	If BitAND(GUICtrlRead($ckbTimeshut), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$guisettime = 1
	Else
		$guisettime = 0
	EndIf

	If BitAND(GUICtrlRead($ckbother), $GUI_CHECKED) = $GUI_CHECKED Then ; other in room
		$guiothercheck = 1
	Else
		$guiothercheck = 0
	EndIf
	
	IniWrite("info.dat", "shop", "帐号", GUICtrlRead($n1))
	IniWrite("info.dat", "shop", "密码", _StringToHex(GUICtrlRead($n2)))

	IniWrite("info.dat", "shop", "位置", $pos)
	IniWrite("info.dat", "shop", "程序目标", GUICtrlRead($path1))
	IniWrite("info.dat", "shop", "起始位置", GUICtrlRead($path2))
	IniWrite("info.dat", "shop", "包裹满后关机", $shutdown)
	IniWrite("info.dat", "shop", "包裹满装箱", $guiboxing)
	IniWrite("info.dat", "shop", "少于格数开始装箱", GUICtrlRead($boxQty))
	IniWrite("info.dat", "shop", "房间名格式", $nameCat)

	IniWrite("info.dat", "shop", "房间名长度下限", GUICtrlRead($namelenfr))
	IniWrite("info.dat", "shop", "房间名长度上限", GUICtrlRead($namelento))
	IniWrite("info.dat", "shop", "是否定时关机", $guisettime)
	IniWrite("info.dat", "shop", "定时关机时间", GUICtrlRead($dtshut))

	IniWrite("info.dat", "shop", "检查其他人进入", $guiothercheck)
	IniWrite("info.dat", "shop", "房间内最大分钟数", GUICtrlRead($staymin))
	
	
	Return True
EndFunc   ;==>saveinfor

Func readinfor()
	$guistaymin =60
	
	$usr = IniRead("info.dat", "shop", "帐号", "")
	$psd = _HexToString(IniRead("info.dat", "shop", "密码", "")) ;16进制转换回二进制

	$pos = IniRead("info.dat", "shop", "位置", "")

	$d2path1 = IniRead("info.dat", "shop", "程序目标", "")
	$d2path2 = IniRead("info.dat", "shop", "起始位置", "")
	$shutdown = IniRead("info.dat", "shop", "包裹满后关机", "")
	$nameCat = IniRead("info.dat", "shop", "房间名格式", "")

	$guiboxing = IniRead("info.dat", "shop", "包裹满装箱", "")
	$guiboxqty = IniRead("info.dat", "shop", "少于格数开始装箱", "")
	$guinamelenfr = IniRead("info.dat", "shop", "房间名长度下限", "")
	$guinamelento = IniRead("info.dat", "shop", "房间名长度上限", "")
	$guisettime = IniRead("info.dat", "shop", "是否定时关机", "")
	$guitimedata = IniRead("info.dat", "shop", "定时关机时间", "")
	$guiothercheck = IniRead("info.dat", "shop", "检查其他人进入", "")
	$guistaymin = IniRead("info.dat", "shop", "房间内最大分钟数", "")

	
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	GUICtrlSetData($path1, $d2path1)
	GUICtrlSetData($path2, $d2path2)
	;GUICtrlSetData($bhTime, $guibhTime)
	GUICtrlSetData($boxQty, $guiboxqty)
	GUICtrlSetData($namelenfr, $guinamelenfr)
	GUICtrlSetData($namelento, $guinamelento)
	GUICtrlSetData($dtshut, $guitimedata)
	GUICtrlSetData($staymin, $guistaymin)

	
	
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
	

	If $guisettime = 1 Then
		GUICtrlSetState($ckbTimeshut, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbTimeshut, $GUI_UNCHECKED)
	EndIf
	
	If $guiothercheck = 1 Then ;检查其他人是否进入
		GUICtrlSetState($ckbother, $GUI_CHECKED)
	Else
		GUICtrlSetState($ckbother, $GUI_UNCHECKED)
	EndIf

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
