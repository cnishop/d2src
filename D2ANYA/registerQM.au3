#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=image.ico
#AutoIt3Wrapper_Res_Comment=首次运行前注册下即可
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
 $pid = Run (@SystemDir&"\regsvr32.exe   QMDispatch.dll" )

 