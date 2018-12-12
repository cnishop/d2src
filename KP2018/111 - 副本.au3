#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=routo.ico
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.7
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****


_DirCopy(@ScriptDir & "\images","D:\");引用下面复制函数显示对话框

Func _DirCopy($SourceDir,$Destdir) 
;说明：利用Shell对象来实现复制文件对话框
    Local $Shell
    Local $FOF_SIMPLEPROGRESS = 16
    If Not FileExists($Destdir) Then DirCreate($Destdir)
    $Shell = ObjCreate("shell.application")
    $Shell.namespace($Destdir).CopyHere($SourceDir,$FOF_SIMPLEPROGRESS)
EndFunc