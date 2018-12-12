
#NoTrayIcon
#include "CoProc.au3"



#region ����������
#include <GUIConstants.au3>
$Form1 = GUICreate("Multiple File Download", 622, 119, 192, 125)
GUICtrlCreateLabel("http://www.mv.com/test/paths.txt (1Mb)", 8, 8)
GUICtrlCreateLabel("http://support.shaw.ca/troubleshooting/files/download.dat (20Mb)", 8, 48)
$Progress1 = GUICtrlCreateProgress(8, 24, 601, 17)
$Progress2 = GUICtrlCreateProgress(8, 64, 601, 17)
$Button1 = GUICtrlCreateButton("Pause", 8, 88, 81, 25)
$Button2 = GUICtrlCreateButton("Resume", 96, 88, 81, 25)

$iPidSmall = _CoProc("Small") ;�����ӽ���,�ӽ��̽�ִ��Small()����,$iPidSmall�õ������ӽ��̵�PID
$iPidBig = _CoProc("Big")
GUISetState(@SW_SHOW)

_CoProcReciver("Reciver") ;ע��Reciver()�����������ӽ��̴��ݹ�������Ϣ

While 1
    $msg = GuiGetMsg()
    Select
    Case $msg = $GUI_EVENT_CLOSE
        ExitLoop
    Case $msg = $Button1
         _ProcSuspend($iPidSmall) ;��ͣ$iPidSmall����ӽ���
         _ProcSuspend($iPidBig)
    Case $msg = $Button2
         _ProcResume($iPidSmall) ;�ָ�$iPidSmall�ӽ���
         _ProcResume($iPidBig)
    Case Else
        ;
    EndSelect
WEnd
FileDelete(@TempDir & "\smalltest.tmp")
FileDelete(@TempDir & "\bigtest.tmp")
Exit

Func Reciver($vParameter)
    ;$vParameter������ӽ��̷�������Ϣ
    $aParam = StringSplit($vParameter,"|")
    If $aParam[1] = "small" Then GUICtrlSetData($Progress1,$aParam[2])
    If $aParam[1] = "big" Then GUICtrlSetData($Progress2,$aParam[2])
EndFunc
#endregion  

#region Small()��������'Small file'�ӽ��̵���Ҫִ�еĴ���
Func Small()
    $url = "http://www.mv.com/test/paths.txt"
    $size = InetGetSize($url)
    InetGet($url,@TempDir & "\smalltest.tmp",1,1)
    While @InetGetActive And ProcessExists($gi_CoProcParent)
        ;������ʱ�����򸸽��̷������ؽ���,$gi_CoProcParent�Ǹ����̵�PID,��������Ǻ����Լ�������
         _CoProcSend($gi_CoProcParent,"small|" & Round(@InetGetBytesRead / $size * 100,0))
        Sleep(250)
    WEnd
     _CoProcSend($gi_CoProcParent,"small|100")
EndFunc
#endregion

#region 'Big file'�ӽ���ִ�еĴ���
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