
#NoTrayIcon
#include "CoProc.au3"



#region 主程序区域
#include <GUIConstants.au3>
$Form1 = GUICreate("Multiple File Download", 622, 119, 192, 125)
GUICtrlCreateLabel("http://www.mv.com/test/paths.txt (1Mb)", 8, 8)
GUICtrlCreateLabel("http://support.shaw.ca/troubleshooting/files/download.dat (20Mb)", 8, 48)
$Progress1 = GUICtrlCreateProgress(8, 24, 601, 17)
$Progress2 = GUICtrlCreateProgress(8, 64, 601, 17)
$Button1 = GUICtrlCreateButton("Pause", 8, 88, 81, 25)
$Button2 = GUICtrlCreateButton("Resume", 96, 88, 81, 25)

$iPidSmall = _CoProc("Small") ;开启子进程,子进程将执行Small()函数,$iPidSmall得到的是子进程的PID
$iPidBig = _CoProc("Big")
GUISetState(@SW_SHOW)

_CoProcReciver("Reciver") ;注册Reciver()函数来接收子进程传递过来的消息

While 1
    $msg = GuiGetMsg()
    Select
    Case $msg = $GUI_EVENT_CLOSE
        ExitLoop
    Case $msg = $Button1
         _ProcSuspend($iPidSmall) ;暂停$iPidSmall这个子进程
         _ProcSuspend($iPidBig)
    Case $msg = $Button2
         _ProcResume($iPidSmall) ;恢复$iPidSmall子进程
         _ProcResume($iPidBig)
    Case Else
        ;
    EndSelect
WEnd
FileDelete(@TempDir & "\smalltest.tmp")
FileDelete(@TempDir & "\bigtest.tmp")
Exit

Func Reciver($vParameter)
    ;$vParameter里就是子进程发来的消息
    $aParam = StringSplit($vParameter,"|")
    If $aParam[1] = "small" Then GUICtrlSetData($Progress1,$aParam[2])
    If $aParam[1] = "big" Then GUICtrlSetData($Progress2,$aParam[2])
EndFunc
#endregion  

#region Small()函数里是'Small file'子进程的所要执行的代码
Func Small()
    $url = "http://www.mv.com/test/paths.txt"
    $size = InetGetSize($url)
    InetGet($url,@TempDir & "\smalltest.tmp",1,1)
    While @InetGetActive And ProcessExists($gi_CoProcParent)
        ;在下载时不断向父进程发送下载进度,$gi_CoProcParent是父进程的PID,这个变量是函数自己建立的
         _CoProcSend($gi_CoProcParent,"small|" & Round(@InetGetBytesRead / $size * 100,0))
        Sleep(250)
    WEnd
     _CoProcSend($gi_CoProcParent,"small|100")
EndFunc
#endregion

#region 'Big file'子进程执行的代码
Func Big()
    $url = "http://support.shaw.ca/troubleshooting/files/download.dat"
    $size = InetGetSize($url)
    InetGet($url,@TempDir & "\bigtest.tmp",1,1)
    While @InetGetActive And ProcessExists($gi_CoProcParent)
         _CoProcSend($gi_CoProcParent,"big|" & Round(@InetGetBytesRead / $size * 100,0))
        Sleep(250)
    WEnd
     _CoProcSend($gi_CoProcParent,"big|100")
EndFunc
#endregion