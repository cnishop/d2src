#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.2.8
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#RequireAdmin 

#include "CoProc.au3"

$Pidmsgb = _CoProc("msgb")

Local $msg

_CoProcReciver("Reciver") ;注册Reciver()函数来接收子进程传递过来的消息

For $i = 1 To 6 Step 1
;ConsoleWrite("this is A" & $i & @CRLF)
   TrayTip("",  $i  & "  这个是主进程,子进程id是 " & $Pidmsgb  &"  " & $msg, 1, 16)   ; $gi_CoProcParent
sleep(3000)
;$pid = _CoProc("fuck")  
             ;ProcessClose($pid)
			 
If 	$i=3 Then
		   TrayTip("", $i & "    关闭子进程......", 1, 16)
	       Sleep(1000)
               ProcessClose($Pidmsgb)
			  ;_CloseHandle($Pidmsgb)
		 EndIf	
		 
	 Next
	 
	 

Func msgb()
	$j = 1
	While 1
	   TrayTip("", "这个是子进程" & $j , 1, 16)
	   ConsoleWrite( "this is B" & $j & @CRLF)
	   $j = $j + 1;
	   _CoProcSend($gi_CoProcParent,$j )
	   Sleep(1000)
	WEnd   
		;
EndFunc


Func Reciver($vParameter)
	;TrayTip("",  $i  & "  收到子进程的消息是 " & $vParameter , 1, 16)   ; $gi_CoProcParent
    $msg =$vParameter
	;Sleep(1000)
EndFunc