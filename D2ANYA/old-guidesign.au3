#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#NoTrayIcon
#include <Array.au3>
Opt("TrayMenuMode", 1) ; 默认托盘菜单项目(脚本已暂停/退出脚本) (Script Paused/Exit) 将不显示.
Global $usr, $psd, $fire, $cta
Global $pos
Local $avArray[3], $avArrayP[8]




#Region ### START Koda GUI section ### Form=d:\tool\autoit3\examples\guo\d2kp\design.kxf
$Form1_1_1 = GUICreate("暗黑2-KP精灵-非BOT", 623, 586, 192, 124)
$Group1 = GUICtrlCreateGroup("帐号信息", 8, 0, 225, 113)
$Label1 = GUICtrlCreateLabel("站网帐号", 16, 24, 52, 17)
$Label2 = GUICtrlCreateLabel("站网密码", 16, 56, 52, 17)
$n1 = GUICtrlCreateInput("", 72, 16, 89, 21)
$n2 = GUICtrlCreateInput("", 72, 48, 89, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
$ExitID = GUICtrlCreateButton("退出", 144, 80, 75, 25)
$SaveID = GUICtrlCreateButton("保存", 32, 80, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("角色攻击类型", 240, 0, 377, 113)
$Radio1 = GUICtrlCreateRadio("纯冰系法师 F1-传送,F2-暴风雪,F5-冰封装甲", 256, 16, 265, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("纯火系法师 F1-传送,F2-大火球,F5-冰封装甲", 256, 40, 305, 17)
$Radio3 = GUICtrlCreateRadio("冰火双修(主火) F1-传送,F2-大火球,F3-暴风雪,F5-冰封装甲", 256, 64, 313, 17)
$Ckbcta = GUICtrlCreateCheckbox("副手携带战争召唤 F7-战斗指挥,F8-战斗体制 ", 256, 88, 305, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("运行前设置", 8, 240, 609, 145)
$Label3 = GUICtrlCreateLabel("1.打开暗黑目录下的 d2hackmap.cfg ，把需要捡取物品代码颜色设置为 2，表示亮绿色(瞬间回复必须设置)                                           ", 24, 264, 579, 17)
GUICtrlSetResizing(-1, $GUI_DOCKRIGHT)
$Label4 = GUICtrlCreateLabel("以华之羽翼  HackMap2.24 CFG For DIIExp 1.11b  为例： Item Colours[1116][7]:     2,0x20 //权冠；                              ", 32, 288, 579, 17)
$Label5 = GUICtrlCreateLabel("2.窗口加上 -title d2， 并第一个进入游戏后显示模式设成800*600                                                                                 ", 24, 312, 576, 17)
$Label6 = GUICtrlCreateLabel("3.进入游戏，检查是否已设置的物品显示为亮绿色，且窗口为 800*600                                                                   ", 24, 336, 569, 17)
$Label7 = GUICtrlCreateLabel("4.根据游戏角色，将技能快捷键设置为与此程序右上角的一致  ", 24, 360, 331, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group5 = GUICtrlCreateGroup("角色位置", 8, 120, 161, 113)
$RadP1 = GUICtrlCreateRadio("1", 16, 136, 65, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadP2 = GUICtrlCreateRadio("2", 16, 160, 65, 17)
$RadP3 = GUICtrlCreateRadio("3", 16, 184, 65, 17)
$RadP4 = GUICtrlCreateRadio("4", 16, 208, 65, 17)
$RadP5 = GUICtrlCreateRadio("5", 88, 136, 65, 17)
$RadP6 = GUICtrlCreateRadio("6", 88, 160, 65, 17)
$RadP7 = GUICtrlCreateRadio("7", 88, 184, 65, 17)
$RadP8 = GUICtrlCreateRadio("8", 88, 208, 65, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group6 = GUICtrlCreateGroup("系统 | 游戏角色装备需求", 176, 120, 441, 113)
$Label8 = GUICtrlCreateLabel("1.电脑能8开以上,网速150以内 ", 184, 144, 163, 17)
$Label9 = GUICtrlCreateLabel("2.武器不能用眼球，建议用OAK或怪异之球（不追求MF，迅速杀怪效率第一） ", 184, 168, 413, 17)
$Label10 = GUICtrlCreateLabel("塔拉夏套装即可，鞋子25高跑以上，建议用wt ", 192, 184, 399, 17)
$Label11 = GUICtrlCreateLabel("3.PET用丧钟，案头+物免甲或刚毅（PET必须能顶怪且不容易挂）", 184, 208, 349, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("运行方式", 8, 392, 609, 145)
$Label12 = GUICtrlCreateLabel("2.此界面输入账号密码保存，点锁定(第一次保存，以后每次打开，直接点锁定)                                   ", 24, 448, 520, 17)
$Label13 = GUICtrlCreateLabel("3. 启动快捷键： F9 -开始游戏 F11-退出脚本                                                         ", 24, 472, 400, 17)
$YesID = GUICtrlCreateButton("锁定", 272, 504, 75, 25)
$Label14 = GUICtrlCreateLabel("然后退出房间，返回到站网建立房间界面     ", 32, 424, 235, 17)
$Label15 = GUICtrlCreateLabel("1.打开暗黑游戏，第一次先手动创建一个地狱游戏，人物停留在act5，将包裹留有足够空间，                   ", 24, 408, 547, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1_1)
Dim $StatusBar1_PartsWidth[2] = [300, -1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, "暗黑2专用KP挂机工具，服务器端无法检测，绝对安全", 0)
_GUICtrlStatusBar_SetText($StatusBar1, "联络作者QQ:1246035036,邮箱:cnishop@126.com", 1)


TraySetIcon("D:\autoit3\Examples\guo\D2KP\routo.ico", -1)
$prefsitem = TrayCreateItem("参数")
TrayCreateItem("")
$aboutitem = TrayCreateItem("关于")
TrayCreateItem("")
$exititem = TrayCreateItem("退出")

;GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


$mainform = WinGetHandle($Form1_1_1)
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
				saveinfor()
				MsgBox(0, "成功", "保存成功")
			Case $msg = $YesID
				If BitAND(GUICtrlRead($Radio1), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 1
				ElseIf BitAND(GUICtrlRead($Radio2), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 2
				ElseIf BitAND(GUICtrlRead($Radio3), $GUI_CHECKED) = $GUI_CHECKED Then
					$fire = 3
				EndIf
				
				GUICtrlSetState($SaveID, $GUI_DISABLE)
				GUICtrlSetState($ExitID, $GUI_DISABLE)
				ExitLoop
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
				
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
	
	$avArray[0] = $Radio1
	$avArray[1] = $Radio2
	$avArray[2] = $Radio3
	
	$avArrayP[0] = $RadP1
	$avArrayP[1] = $RadP2
	$avArrayP[2] = $RadP3
	$avArrayP[3] = $RadP4
	$avArrayP[4] = $RadP5
	$avArrayP[5] = $RadP6
	$avArrayP[6] = $RadP7
	$avArrayP[7] = $RadP8

	
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

	If BitAND(GUICtrlRead($Ckbcta), $GUI_CHECKED) = $GUI_CHECKED Then ;cta
		$cta = 1
	Else
		$cta = 0
	EndIf

	IniWrite("info.dat", "信息", "帐号", GUICtrlRead($n1))
	IniWrite("info.dat", "信息", "密码", GUICtrlRead($n2))
	IniWrite("info.dat", "信息", "cta", $cta)
	IniWrite("info.dat", "信息", "类型", $fire)
	IniWrite("info.dat", "信息", "位置", $pos)


EndFunc   ;==>saveinfor

Func readinfor()
	$usr = IniRead("info.dat", "信息", "帐号", "")
	$psd = IniRead("info.dat", "信息", "密码", "")
	$fire = IniRead("info.dat", "信息", "类型", "")
	$pos = IniRead("info.dat", "信息", "位置", "")
	$cta = IniRead("info.dat", "信息", "cta", "")
	
	GUICtrlSetData($n1, $usr)
	GUICtrlSetData($n2, $psd)
	Select
		Case $fire = 1
			GUICtrlSetState($Radio1, $GUI_CHECKED)
		Case $fire = 2
			GUICtrlSetState($Radio2, $GUI_CHECKED)
		Case Else
			GUICtrlSetState($Radio3, $GUI_CHECKED)
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

	If $cta = 1 Then
		GUICtrlSetState($Ckbcta, $GUI_CHECKED)
	Else
		GUICtrlSetState($Ckbcta, $GUI_UNCHECKED)
	EndIf
EndFunc   ;==>readinfor


