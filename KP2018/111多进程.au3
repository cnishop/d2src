#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.2.8
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#RequireAdmin 

#include "CoProc.au3"

$Pidmsgb = _CoProc("msgb")

Local $msg

_CoProcReciver("Reciver") ;ע��Reciver()�����������ӽ��̴��ݹ�������Ϣ

For $i = 1 To 6 Step 1
;ConsoleWrite("this is A" & $i & @CRLF)
   TrayTip("",  $i  & "  �����������,�ӽ���id�� " & $Pidmsgb  &"  " & $msg, 1, 16)   ; $gi_CoProcParent
sleep(3000)
;$pid = _CoProc("fuck")  
             ;ProcessClose($pid)
			 
If 	$i=3 Then
		   TrayTip("", $i & "    �ر��ӽ���......", 1, 16)
	       Sleep(1000)
               ProcessClose($Pidmsgb)
			  ;_CloseHandle($Pidmsgb)
		 EndIf	
		 
	 Next
	 
	 

Func msgb()
	$j = 1
	While 1
	   TrayTip("", "������ӽ���" & $j , 1, 16)
	   ConsoleWrite( "this is B" & $j & @CRLF)
	   $j = $j + 1;
	   _CoProcSend($gi_CoProcParent,$j )
	   Sleep(1000)
	WEnd   
		;
EndFunc


Func Reciver($vParameter)
	;TrayTip("",  $i  & "  �յ��ӽ��̵���Ϣ�� " & $vParameter , 1, 16)   ; $gi_CoProcParent
    $msg =$vParameter
	;Sleep(1000)
EndFunc