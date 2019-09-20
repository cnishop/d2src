AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)


$title = ""
$char_Q = "Q"
$char_TAB = "TAB"
$char_Wave = "~"
$char_ESC = "ESC"
;3c部分
$char_Vigor = "F3" ;活力
$char_Bh = "F1" ;Bh
$char_normal_attack = "F2" ;  普通攻击, 不用突击,可能导致会僵直
$char_Conc = "F4" ;专注光环
$char_Shield = "F5"
$char_Shift_Down = "LSHIFT down"
$char_Shift_Up = "LSHIFT up"
$char_Alt_Down = "ALT down"
$char_Alt_Up = "ALT up"
$itemcolor = "0x00FC18" ;act3的颜色

$drinkhealok = 0   ;上次一的加红是否成功，因为红是慢慢回血的，需要一定时间间隔
$drinkmanaok = 0   ;同上红


$int_beltRej = 0
;腰带每格的坐标


;MouseMove(420, 565)
;MouseMove(450, 565)    第一个红窗
;MouseMove(455, 565)
;MouseMove(480, 565)   ; 第2个红窗口
;MouseMove(485, 565)
;MouseMove(510, 565)   ; 第3个红窗口
;MouseMove(515, 565)
;MouseMove(540, 590)   ; 第4个红窗口

;420 470   490
;505 525
; 535 560

Global $xbeltarray[4][2]
Global $ybeltarray[4][2]

$xbeltarray[0][0] = 420 ;x
$xbeltarray[0][1] = 450
$xbeltarray[1][0] = 455 ;x
$xbeltarray[1][1] = 480
$xbeltarray[2][0] = 485 ;x
$xbeltarray[2][1] = 510
$xbeltarray[3][0] = 515 ;x
$xbeltarray[3][1] = 540

$ybeltarray[0][0] = 465 ;y
$ybeltarray[0][1] = 470
$ybeltarray[1][0] = 505 ;y
$ybeltarray[1][1] = 525
$ybeltarray[2][0] = 535 ;y
$ybeltarray[2][1] = 560
$ybeltarray[3][0] = 565 ;y
$ybeltarray[3][1] = 590



;drinkWater  -drink  heal mana
