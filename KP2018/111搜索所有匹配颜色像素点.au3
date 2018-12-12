HotKeySet("{F9}", "test")
While True
        Sleep(10)
WEnd

Func test()
        Local $Result
        $Result = FindAllColor(5, 5, 798, 580, "1CC40C")
        If $Result[0][0] <> 0 Then
                For $i = 1 To $Result[0][0] Step +1
                        MouseMove($Result[$i][0], $Result[$i][1], 0)
                        Sleep(10)
                Next
        Else
                ConsoleWrite("在指定区域未找到目标颜色. " & @CR)
        EndIf
EndFunc   ;==>test

Func FindAllColor($iLeft, $iTop, $iRight, $iBottom, $iColor)
        Local $Rnum[1][1], $s = 0
        For $Top = $iTop To $iBottom Step +1
                For $Left = $iLeft To $iRight Step +1
                        $Color = Hex($PixelGetColor($Left, $Top),6)
                        ConsoleWrite($Color & @CR)
                        If $Color = $iColor Then
                                $s += 1
                                ReDim $Rnum[$s + 1][2]
                                $Rnum[$s][0] = $Left
                                $Rnum[$s][1] = $Top
                        EndIf
                Next
        Next
        $Rnum[0][0] = $s
        Return $Rnum
EndFunc   ;==>FindAllColor