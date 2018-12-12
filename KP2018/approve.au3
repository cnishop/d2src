#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <DATE.au3>


Global $SQLite_Data_Path
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c
Global $app_date, $app_kpcount

$SQLite_Data_Path = "sys1.dll"
_SQLite_Startup() ;加载 SQLite.dll
If Not FileExists($SQLite_Data_Path) Then
	MsgBox(0, "错误提示", "丢失所需文件，请重新安装！")
	Exit
	;SQLCreate()
EndIf

#CS If Not FileExists("sys2.df") Then
	MsgBox(0,"错误提示","丢失所需文件，请重新安装！")
	Exit
	;SQLCreate()
	EndIf
#CE

;SQLiteDelete(1)
#CS  SQLiteInsert(101,@YEAR & @MON & @MDAY,20)
	
	SQLiteRead(101)
#CE



Func SQLCreate()
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_Exec(-1, "Create Table IF NOT Exists tlog (IDs Text PRIMARY KEY, firstdate Text, kpcount Text);")
	_SQLite_Close()
EndFunc   ;==>SQLCreate

Func SQLiteRead($a)

	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT * FROM tlog WHERE IDs = '" & $a & "';", $aRow)
	$app_date = $aRow[1]
	$app_kpcount = $aRow[2]
	_SQLite_Close()
EndFunc   ;==>SQLiteRead

Func SQLiteInsert($a, $b, $c)
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT IDs FROM tlog WHERE IDs = '" & $a & "';", $aRow)
	$Temp = $aRow[0]
	If $Temp = "" Then
		_SQLite_Exec(-1, "Insert into tlog (IDs,firstdate) values ('" & $a & "','" & _NowCalc() & "'   );")
	EndIf
	_SQLite_Exec(-1, "UPDATE tlog SET kpcount = '" & $c & "' WHERE IDs = '" & $a & "';")
	_SQLite_Close()
EndFunc   ;==>SQLiteInsert

Func SQLiteFirstUpateDate($a)
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT IDs FROM tlog WHERE IDs = '" & $a & "';", $aRow)
	;$ss= "SELECT IDs FROM tlog WHERE IDs = '" & $a & "';"
	;MsgBox(16, "错误提醒", $ss)
	
 	If @error Then
   		MsgBox(16, "提醒", "初始化结束，请重新打开软件!")
   		Exit -1
   	EndIf

	
	$Temp = $aRow[0]
	If $Temp = "" Then
		_SQLite_Exec(-1, "Insert into tlog (IDs,firstdate,kpcount) values ('101','1','0' );")
	EndIf
	_SQLite_Exec(-1, "UPDATE tlog SET firstdate = '" & _NowCalc() & "' WHERE IDs = '101' and firstdate = '1';")
	_SQLite_Close()
EndFunc   ;==>SQLiteFirstUpateDate


Func SQLiteSelect($a)
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_QuerySingleRow(-1, "SELECT * FROM tlog WHERE IDs = '" & $a & "';", $aRow)
	$Temp = $aRow[0]
	If $Temp = "" Then
		MsgBox(262208, "错误", "读取数据记录不完整,请关闭软件重新打开!")
	Else

	EndIf
	_SQLite_Close()
EndFunc   ;==>SQLiteSelect
Func SQLiteDelete($a)
	_SQLite_Open($SQLite_Data_Path)
	_SQLite_Exec(-1, "DELETE FROM  tlog ")
	;_SQLite_Exec(-1, "DELETE FROM  tlog WHERE firstdate = '" & $a & "';")
	_SQLite_Close()
EndFunc   ;==>SQLiteDelete



