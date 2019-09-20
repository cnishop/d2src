AutoItSetOption("WinTitleMatchMode", 3)
AutoItSetOption("MouseCoordMode", 2)
AutoItSetOption("PixelCoordMode", 2)

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