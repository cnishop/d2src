#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=image.ico
#AutoIt3Wrapper_Res_Comment=�״�����ǰע���¼���
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#CS MsgBox(0,"",@SystemDir&"\regsvr32.exe " &  @ScriptDir & "\QMDispatch.dll")
   Exit
    $pid = Run (@SystemDir&"\regsvr32.exe   QMDispatch.dll" )
#CE
 $pid = Run ( @SystemDir & "\regsvr32.exe /u " &  @ScriptDir & "\QMDispatch.dll" )  ;��ע��
 
MsgBox(0, "��ʾ", @error & " " & $pid )    
 
 ; $pid = Run ( @SystemDir&"\regsvr32.exe " &  @ScriptDir & "\QMDispatch.dll" )  ;ע��
 
 
;$pid = Run (@SystemDir&"\regsvr32.exe   QMDispatch.dll" )