#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Res_requestedExecutionLevel=None
#endregion ;**** 参数创建于 ACNWrapper_GUI ****
#include "CoProc.au3"
#include <WinAPIEx.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include 'array.au3'

Opt("GUIOnEventMode", 1)
#region ### START Koda GUI section ### Form=
$Form1 = GUICreate("子母进程通讯测试程序", 354, 118)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
$Button1 = GUICtrlCreateButton("呼叫A进程", 16, 32, 97, 49)
GUICtrlSetOnEvent(-1, "Button1Click")
$Button2 = GUICtrlCreateButton("呼叫B进程", 128, 32, 97, 49)
GUICtrlSetOnEvent(-1, "Button2Click")
$Button3 = GUICtrlCreateButton("呼叫C进程", 240, 32, 97, 49)
GUICtrlSetOnEvent(-1, "Button3Click")
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###


_CoProcReciver("Receiver")
$hA = _CoProc("A")
$hB = _CoProc("B")
$hC = _CoProc("C")

ConsoleWrite("主进程PID：" & @AutoItPID & @CRLF)
ConsoleWrite("子进程PID：" & $hA & " : " & $hB & " : " & $hC & @CRLF)
$list = ProcessList('Autoit3.exe')
_ArrayDisplay($list,"调试代码：各进程PID列表")

While 1
        Sleep(100)
WEnd

Func Button1Click()
        _CoProcSend($hA, "AAA")
        _CloseHandle($hA)
EndFunc   ;==>Button1Click
Func Button2Click()
        _CoProcSend($hB, "BBB")
EndFunc   ;==>Button2Click
Func Button3Click()
        _CoProcSend($hC, "CCC")
EndFunc   ;==>Button3Click
Func Form1Close()
        Exit
EndFunc   ;==>Form1Close


Func Receiver($sParama)
        MsgBox(0, "进程号：" & @AutoItPID , $sParama)
        
EndFunc   ;==>Receiver

Func A()
        _CoProcReciver("Receiver") 
        While ProcessExists($gi_CoProcParent)
                Sleep(5000)
                ;MsgBox(0,"A","AAAAA",1)
                ;_CoProcSend($gi_CoProcParent,$gi_CoProcParent)
        WEnd
EndFunc

Func B()
        _CoProcReciver("Receiver") 
        While ProcessExists($gi_CoProcParent)
                Sleep(5000)
                MsgBox(0,"B","BBBBB",1)
        WEnd
EndFunc

Func C()
        _CoProcReciver("Receiver") 
        While ProcessExists($gi_CoProcParent)
                Sleep(5000)
                MsgBox(0,"C","CCCCC",1)
        WEnd
EndFunc