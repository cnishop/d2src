#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <DATE.au3>


Global $SQLite_Data_Path
Global $Msg, $hQuery, $aRow
Global $Temp, $a, $b, $c
Global $app_date,$app_kpcount

$SQLite_Data_Path = "a01.dll"
_SQLite_Startup () ;加载 SQLite.dll
If Not FileExists($SQLite_Data_Path) Then
	MsgBox(0,"错误提示","丢失所需文件，请重新安装！")
	Exit
    ;SQLCreate()
EndIf

If Not FileExists("a02.df") Then
	MsgBox(0,"错误提示","丢失所需文件，请重新安装！")
	Exit
    ;SQLCreate()
EndIf

;SQLiteDelete(1)
#CS  SQLiteInsert(101,@YEAR & @MON & @MDAY,20)
   
   SQLiteRead(101)
#CE



Func SQLCreate()
    _SQLite_Open ($SQLite_Data_Path)
    _SQLite_Exec(-1, "Create Table IF NOT Exists tlog (IDs Text PRIMARY KEY, firstdate Text, kpcount Text);")
    _SQLite_Close ()
EndFunc

Func SQLiteRead($a)

    _SQLite_Open ($SQLite_Data_Path)
_SQLite_QuerySingleRow(-1, "SELECT * FROM tlog WHERE IDs = '" & $a & "';", $aRow)
    $app_date = $aRow[1]
	$app_kpcount =  $aRow[2]
    _SQLite_Close ()
EndFunc

Func SQLiteInsert($a, $b, $c)
    _SQLite_Open ($SQLite_Data_Path)
_SQLite_QuerySingleRow(-1, "SELECT IDs FROM tlog WHERE IDs = '" & $a & "';", $aRow)
    $Temp = $aRow[0]
If $Temp = "" Then
  _SQLite_Exec(-1, "Insert into tlog (IDs,firstdate) values ('" & $a & "','" & _NowCalc() & "'   );")
EndIf
    _SQLite_Exec(-1, "UPDATE tlog SET kpcount = '" & $c & "' WHERE IDs = '" & $a & "';")
    _SQLite_Close ()
EndFunc

Func SQLiteFirstUpateDate()
    _SQLite_Open ($SQLite_Data_Path)
_SQLite_QuerySingleRow(-1, "SELECT IDs FROM tlog WHERE IDs = '" & $a & "';", $aRow)
    $Temp = $aRow[0]
If $Temp = "" Then
  _SQLite_Exec(-1, "Insert into tlog (IDs,firstdate,kpcount) values ('102','1','0' );")
EndIf
    _SQLite_Exec(-1, "UPDATE tlog SET firstdate = '" & _NowCalc() & "' WHERE IDs = '101' and firstdate = '1';")
    _SQLite_Close ()
EndFunc


Func SQLiteSelect($a)
    _SQLite_Open ($SQLite_Data_Path)
_SQLite_QuerySingleRow(-1, "SELECT * FROM tlog WHERE firstdate = '" & $a & "';", $aRow)
    $Temp = $aRow[0]
If $Temp = "" Then
  MsgBox(262208, "错误","错误" )
    Else

EndIf
    _SQLite_Close ()
EndFunc
Func SQLiteDelete($a)
    _SQLite_Open ($SQLite_Data_Path)
	_SQLite_Exec(-1, "DELETE FROM  tlog ")
    ;_SQLite_Exec(-1, "DELETE FROM  tlog WHERE firstdate = '" & $a & "';")
    _SQLite_Close ()
EndFunc



