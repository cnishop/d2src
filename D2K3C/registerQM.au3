#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=image.ico
#AutoIt3Wrapper_Res_Comment=首次运行前注册下即可
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#CS MsgBox(0,"",@SystemDir&"\regsvr32.exe " &  @ScriptDir & "\QMDispatch.dll")
   Exit
    $pid = Run (@SystemDir&"\regsvr32.exe   QMDispatch.dll" )
#CE
 $pid = Run ( @SystemDir & "\regsvr32.exe /u " &  @ScriptDir & "\QMDispatch.dll" )  ;反注册
 
MsgBox(0, "提示", @error & " " & $pid )    
 
 ; $pid = Run ( @SystemDir&"\regsvr32.exe " &  @ScriptDir & "\QMDispatch.dll" )  ;注册
 
 
;$pid = Run (@SystemDir&"\regsvr32.exe   QMDispatch.dll" )