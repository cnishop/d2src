
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_Res_Comment=暗黑kp专业户挂机简单演示
#AutoIt3Wrapper_Res_LegalCopyright=QQ:1246035036 *潘多拉之星
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****

#include <GUIConstantsEx.au3>
Opt("TrayMenuMode", 1) 
; d2
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)
$title = "d2"
$usr = ""
$psd = ""
creatGui()
Global $Paused
HotKeySet("{F9}", "TogglePause")
HotKeySet("{F11}", "Terminate")
;;;; Body of program would go here ;;;;
While 1
	Sleep(100)
WEnd
;;;;;;;;
Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		TrayTip("", "执行中！", 5)
		runGame()
	WEnd
	TrayTip("", "暂停执行！", 5)
EndFunc   ;==>TogglePause
Func Terminate()
	TrayTip("", "脚本结束了！", 5)
	Sleep(2000)
	Exit 0
EndFunc   ;==>Terminate
Func creatGui()
	Local $menu1, $n1, $n2, $msg, $menustate, $menutext
	GUICreate("暗黑kp专业户简单演示",340,150,400,250) ; 创建一个居中显示的 GUI 窗口
	$YesID = GUICtrlCreateButton("锁定", 80, 20, 50, 20)
	$ExitID = GUICtrlCreateButton("退出", 180, 20, 50, 20)
	GUICtrlCreateLabel("运行方法：先点锁定，进房间后按F9开始/暂停，F11退出", 10, 80, 300, 40)
	GUICtrlCreateLabel("使用方法:", 10, 50, 300, 20)


	GUICtrlCreateLabel("进入游戏，建立房间并进入后，鼠标不要动，此时按F9", 10, 100, 350, 30)

	GUISetState() ; 显示一个空白的窗口

	; 运行界面，直到窗口被关闭
	Do
		$msg = GUIGetMsg()
		$usr = GUICtrlRead($n1)
		$psd = GUICtrlRead($n2)
		Select
			Case $msg = $YesID
				ExitLoop
			Case $msg = $ExitID
				Exit 0
			Case $msg = $GUI_EVENT_CLOSE
				Exit 0
		EndSelect
	Until $msg = $GUI_EVENT_CLOSE Or $msg = $ExitID
EndFunc   ;==>creatGui
Func runGame()
	acitveWindow()
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
	#CS
		;单机
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
			Sleep(2000)

		Case Else 
			TrayTip("", "请自己建立房间进入游戏！", 5)
			Sleep(6000)

	EndSelect
EndFunc   ;==>runGame

Func acitveWindow()
	; 得到包括 "this one" 内容的记事本窗口的句柄
	$handle = WinGetHandle($title)
	If @error Then
		MsgBox(32, "错误", "没找到暗黑窗口程序，第一次请先打开暗黑，并进入选择单机或战网的界面")
		;Run(@WindowsDir & "\Notepad.exe", "", @SW_MAXIMIZE)
		Exit
	Else
		WinActivate($title)
	EndIf
	$size = WinGetClientSize($title)
	If $size[0] <> 800 And $size[1] <> 600 Then
		MsgBox(0, "提示", "请先将窗口设置成800*600")
	EndIf
	;WinMove($title, "", 0, 0)
	Sleep(50)
EndFunc   ;==>acitveWindow

Func roomplay()
	;If isInRoom() Then
	
	findpath(1)
	;finddoor()
	finddoor()
	
	TrayTip("", "演示结束了！！", 5, 16)
	Sleep(3000)
	Exit 0
	;EndIf
EndFunc   ;==>roomplay

Func findpath($pathNumber)
	Select
		Case $pathNumber = 1
			TrayTip("", "移动到红门..", 5, 16)
			MouseClick("left", 60, 250, 1)
			Sleep(2000)
			MouseClick("left", 40, 250, 1)
			Sleep(2000)
			MouseClick("left", 180, 480, 1)
			Sleep(2000)
			MouseClick("left", 180, 480, 1)
			Sleep(2000)
			MouseClick("left", 100, 450, 1)
			Sleep(2000)
			MouseClick("left", 220, 500, 1)
			Sleep(2000)
			MouseClick("left", 600, 420, 1)
			Sleep(2000)
			MouseClick("left", 700, 400, 1)
			Sleep(2000)
		Case Else 
			TrayTip("", "等待中，请稍后", 1, 16)
			Sleep(100)
	EndSelect
EndFunc   ;==>findpath


Func isInRoom($color = 0xB08848) ;检查看人物下方是否有黄色的耐力条，有表示在游戏内
	$coord = PixelSearch(300, 575, 350, 590, $color, 0, 1, $title)
	If Not @error Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>isInRoom


Func findAreaColor($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	$coord = PixelSearch($left, $top, $right, $bottom, $color, $shadow, $step, $title)
	If Not @error Then
		;MouseMove($coord[0],$coord[1])
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findAreaColor
Func findPointColor($x, $y, $color)
	$var = PixelGetColor($x, $y)
	If Hex($var, 6) = $color Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>findPointColor

Func finddoor() ;找红门的程序
	;循环找出区域内大于指定数量的相同颜色的点
	$left = 100
	$top = 100
	$right = 500
	$bottom = 400
	Sleep(1000)
	;TrayTip("", "开始寻找红门.", 1)
	findredDoor($left, $top, $right, $bottom)
EndFunc   ;==>finddoor
Func findredDoor($left, $top, $right, $bottom)
	$exit = False
	$total = 0
	$coord = PixelSearch($left, $top, $right, $bottom, 0xFFFFFF, 0, 1, $title)
	If Not @error Then
		$x = $coord[0]
		$y = $coord[1]
		If getRightPoint($x, $y) Then
			TrayTip("", "找到红门了！.", 1,16)
			;MouseMove($x, $y)
			Sleep(1000)
			;MsgBox(0, "", "right")
		Else
			For $k = $left To $right Step 100
				For $j = $top To $bottom Step 100
					;MsgBox(0,"","查找中")
					;TrayTip("", "查询坐标." & $k & "" & $j, 1)
					If findNext($k, $j, $right, $bottom) Then
						;MsgBox(0, "", "查找下一个")
						TrayTip("", "找到红门了！.", 1)
						;MouseMove($k, $j)
						;MouseClick("left", $k, $j, 1)
						;AAA()
						$exit = True
						ExitLoop
					EndIf
					;MsgBox(0, "", "查找：" & $k & "" & $j)
					If $k >= $right And $j >= $bottom Then
						;MsgBox(0, "", "error")
						TrayTip("", "寻找红门失败，退出.", 5)
						$exit = True
						ExitLoop
					EndIf
				Next
				If $exit = True Then
					ExitLoop
				EndIf
			Next
		EndIf
	Else
		MsgBox(0, "", "寻找红门失败")
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
	If $total >= 20 Then
		MouseMove($xx, $yy)
		MouseClick("left", $xx, $yy, 1)
		Sleep(1000)
		;TrayTip("", "total为：" & $total, 1)
		Return True
		;ElseIf  $total >= 15 Then
		; Return True
	Else
		;TrayTip("", "total为：" & $total, 1)
		Return False
	EndIf
EndFunc   ;==>getRightPoint



