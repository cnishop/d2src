;~    2009-10-29 17:38
$dbname="test.mdb"
$tblname="测试表"
$fldname="测试字段"
$format="int"
$sData="123456"
$T="*"
;$RS =""

 _CreateDB($dbname)
   _CreateTBL($dbname, $tblname)
   _CreateFLD($dbname, $tblname, $fldname, $format)
   ;_InsertData($dbname, $tblname, $fldname, $sData)
   ;_DeleteData($dbname, $tblname, $fldname, $sData)
   _SelectData($dbname, $tblname, $fldname, $T)


Func _CreateDB($dbname)
$newMdb = ObjCreate("ADOX.Catalog")
$newMdb.Create("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$newmdb.ActiveConnection.Close
EndFunc

Func _CreateTBL($dbname, $tblname)
$addtbl = ObjCreate("ADODB.Connection")
$addTbl.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$addTbl.Execute("CREATE TABLE " & $tblname)
$addtbl.Close
EndFunc

Func _CreateFLD($dbname, $tblname, $fldname, $format)
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$addfld.Execute("ALTER TABLE " & $tblname & " ADD " & $fldname & " " & $format)
$addfld.Close
EndFunc

Func _InsertData($dbname, $tblname, $fldname, $sData)
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$addfld.Execute("Insert Into " & $tblname & " (" & $fldname & ") " & "VALUES ("&$sData&")")
$addfld.Close
EndFunc

Func _DeleteData($dbname, $tblname, $fldname, $sData)
$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$addfld.Execute("Delete From " & $tblname & " Where " & $fldname & " = " &$sData)
$addfld.Close
EndFunc

Func _SelectData($dbname, $tblname, $fldname, $T)
$addfld = ObjCreate("ADODB.Connection")

$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
$RS =ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$RS.Open ("Select "&$T & " From " & $tblname )
msgbox(0,"",$RS.Fields(0).Name)
msgbox(0,"",$RS.Fields(0).Value)

$addfld.Close
EndFunc

#CS ;~ 以下是循环读取表记录的例子
   $tempData=""
   while not $RS.eof and not $RS.bof
   if @error =1 Then ExitLoop
   $tempData=$tempData&($RS.Fields("value").Value)&"|"
   $rs.movenext
   WEnd
   
#CE


;~ 几个自定义函数都是通过ObjCreate("ADODB.Connection")来实现的 （创建库使用的是ObjCreate("ADOX.Catalog")）

#CS ;~ 使用sql语句的完整过程： 
   $pro = ObjCreate("ADODB.Connection")
   $pro.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
   $pro.Execute(sql)
   $pro.Close
   
#CE


;~ 例子。写入一条数据 和读取数据

$mdb_data_path="sky.mdb"
$mdb_data_pwd=""
$name="天生我才"
$pass="过去"
$qq=25359272
$e_mail="xtybfgu@163.com"
$T="*"
$tblname="tywb"

$conn = ObjCreate("ADODB.Connection")
$RS = ObjCreate("ADODB.Recordset")
$conn.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & $mdb_data_path & ";Jet Oledb:Database Password=" & $mdb_data_pwd)
$RS.ActiveConnection = $conn
$RS.Open('Select * From tywb')
$conn.Execute("insert into tywb (name,pass,qq,e_mail) values('"&$name&"','"&$pass&"','"&$qq&"','"&$e_mail&"')")
$RS.close
$conn.close
MsgBox(4096, "Access:", $name & " 已成功写入数据库！")


$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" &$mdb_data_path)
$RS =ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$tempData=""
$RS.Open ("Select "&$T & " From " & $tblname )
while Not $RS.eof And Not $RS.bof
if @error =1 Then ExitLoop
MsgBox(0, "", $RS.Fields (1).value);显示表第一个数据
$rs.movenext
WEnd
$addfld.Close



;~ 说明

$addfld = ObjCreate("ADODB.Connection")
$RS = ObjCreate("ADODB.Recordset")
$addfld.Open ("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=数据库路径" ) ;连接数据库
$RS.ActiveConnection = $addfld
$RS.Open ("Select name,tel From admin" ) ;从admin表中查找字段为name和tel的信息
$RS.Open ("Select name From admin where name=小覃") ;从admin表中查字段为name等于小覃的记录
$addfld.Execute('Insert Into admin (name,tel) Values (小覃,123456)') ;分别向admin表中的name和tel写入 小覃 和 123456
$addfld.Execute("UPDATE admin SET tel =654321 where name=小覃") ;在admin表中更新字段name等于小覃对应的字段tel的值为654321
$addfld.Execute("Delete From admin Where name =小覃"); 从admin表中删除字段name等到小覃的记录
$RS.eof ;最后一条记录
$RS.bof;最后一条记录的上一条
$RS.Fields (0).value ;记录信息 0表示第一字段中
$RS.movenext ;继续查下一条记录

$RS.close ;关闭表
$addfld.close ;关闭数据库
