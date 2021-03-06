;AutoItSetOption ( "ColorMode", 1 ) 
AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("WinWaitDelay", 250)
AutoItSetOption ("PixelCoordMode", 0) 
AutoItSetOption ("MouseCoordMode", 0)

#include <BOT.au3>

$title = "d2"


; 得到包括 "this one" 内容的记事本窗口的句柄
$handle = WinGetHandle($title)
If @error Then
	MsgBox(4096, "错误", "不能找到指定窗口，请先打开")
	Exit
Else
	WinActivate($title)
EndIf

$size = WinGetClientSize($title)
If $size[0] <> 800 And $size[1] <> 600 Then
	MsgBox(0, "提示", "请先将窗口设置成800*600")
EndIf


Sleep(2000)
		;TrayTip("", "1111.", 1, 16)
#CS    $coord= PixelSearch(50,50,400,300,0x18FC00,0,1)
   	If Not @error Then
   		TrayTip(0,"","找到颜色",16)
   		Sleep(1000)
   					MouseMove($coord[0], $coord[1])
   		Sleep(1000)
   	EndIf
#CE



Path("A3StartToA5WP")

;~ MouseMove(50,200)    ;1C1C1C
;~ MouseMove(50,400)   ;101010
;~ MouseMove(750,200)   ;202020
;~ MouseMove(750,400)   ;1c1c1c

#CS     $var = PixelGetColor(300, 300 ) ;786C60
   MsgBox(0, "", $var)
   ;MsgBox(0, "", Hex($var, 6))
   Sleep(50)
#CE




   Exit


#CS 
   	$coord = PixelSearch(0, 0 ,400, 300, 0xFFFFFF, 1, 1, $title) ; 在背包空间范围内查找
   	If Not @error Then
   	;MouseClick("right", $coord[0], $coord[1], 1);
   		MouseMove($coord[0], $coord[1]+100)
   	Sleep(200)
   	EndIf
   
#CE
 
Sleep(1000)
MouseMove(200,530)
MouseDown("left")
TrayTip("", "1", 1, 16)
Sleep(1200)
MouseMove(600,330)
TrayTip("", "2", 1, 16)
Sleep(1200)
MouseMove(60,460)
TrayTip("", "3", 1, 16)
Sleep(3000)

MouseUp("left")
MouseClick("left",60,300)
Sleep(1000)


Func movemous()
;~ //变量定义
$LTopx=150
$LTopy=100
$RBotx=380
$RBoty=280
$Centerx=300
$Centery=200
$L=20   ;"2个搜怪点之间的距离"
$M=3     ;"从第几圈开始搜索"

Dim $s,$v,$i,$n,$x,$y,$a1,$b1,$a2,$b2,$c1,$c2,$x0,$y0,$k1,$k2

$a1=$LTopx

$b1=$LTopy

$a2=$RBotx

$b2=$RBoty
;~ //取起点坐标赋值到x0,y0
$x0=$Centerx
$y0=$Centery
;~ //比较x0到a1和x0到a2的长度，取最长的距离来限制方形渐开的范围，保证渐开线能全部覆盖鼠标活动范围
If $x0-$a1>=$a2-$x0 Then
    $n=$a1
Else 
;~      //将x0到a2的距离转换到左边，方便下面的While x>=n的循环判断
    $n=$x0-($a2-$x0)
EndIf 
;~ Rem 开始搜怪
;~ //将点距赋值到v
$v=$L
;~ //将渐开起点圈数赋值到i
$i=$M
;~ //将渐开起点坐标赋值到x,y
$x=$x0
$y=$y0-$v
While $x>=$n
    $k1=0
	$k2=$v
    For $ii=1 To 2
        For $jj=1 To $i
            $x=$x+$k1
			$y=$y+$k2
;~             //只有（x，y）点在鼠标活动范围内才移动鼠标和执行颜色变化判断
            If $x>=$a1 and $x<=$a2 and $y>=$b1 and $y<=$b2 Then
;~                 //计算出x，y后，先取x，y点的颜色赋值到c1
                $c1=PixelGetColor($x,$y-5)
                MouseMove($x,$y,1)
                Sleep(10)
;~                 //移动到x,y延时10毫秒后再次取x,y点的颜色并赋值到c2
                $c2=PixelGetColor($x,$y-5)
;~                 //如果x,y点的颜色鼠标移动前和鼠标移动后的颜色不同，则执行打怪动作
                If  $c1<>$c2  Then
;~                     //打怪代码
					TrayTip("", "找到不一样的了！.", 1, 16)
					MouseMove ($x,$y)
                    Sleep(1000)
					Exit
;~                     //打完怪后再重新开始搜索
;~                     Goto 开始搜怪
                EndIf 
                Sleep(1)
            EndIf 
        Next 
        $k1=$v
		$k2=0
    Next
    $i=$i+1
	$v=$v*(-1)
Wend 
Sleep(200)

EndFunc



Func gotoBox()
			Sleep(100)
 			MouseClick("left", 200, 500, 1)
   			Sleep(1400)
   			MouseClick("left", 750, 430, 1)
   			Sleep(1400)
   			MouseClick("left", 380, 480, 1)
   			Sleep(1000)
			MouseMove(150,240)
			Sleep(100)
			MouseClick("left", 150,240, 1)
   			Sleep(1800)
		EndFunc
		
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