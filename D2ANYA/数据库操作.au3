;~    2009-10-29 17:38
$dbname="test.mdb"
$tblname="���Ա�"
$fldname="�����ֶ�"
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

#CS ;~ ������ѭ����ȡ���¼������
   $tempData=""
   while not $RS.eof and not $RS.bof
   if @error =1 Then ExitLoop
   $tempData=$tempData&($RS.Fields("value").Value)&"|"
   $rs.movenext
   WEnd
   
#CE


;~ �����Զ��庯������ͨ��ObjCreate("ADODB.Connection")��ʵ�ֵ� ��������ʹ�õ���ObjCreate("ADOX.Catalog")��

#CS ;~ ʹ��sql�����������̣� 
   $pro = ObjCreate("ADODB.Connection")
   $pro.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & $dbname)
   $pro.Execute(sql)
   $pro.Close
   
#CE


;~ ���ӡ�д��һ������ �Ͷ�ȡ����

$mdb_data_path="sky.mdb"
$mdb_data_pwd=""
$name="�����Ҳ�"
$pass="��ȥ"
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
MsgBox(4096, "Access:", $name & " �ѳɹ�д�����ݿ⣡")


$addfld = ObjCreate("ADODB.Connection")
$addfld.Open("Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" &$mdb_data_path)
$RS =ObjCreate("ADODB.Recordset")
$RS.ActiveConnection = $addfld
$tempData=""
$RS.Open ("Select "&$T & " From " & $tblname )
while Not $RS.eof And Not $RS.bof
if @error =1 Then ExitLoop
MsgBox(0, "", $RS.Fields (1).value);��ʾ���һ������
$rs.movenext
WEnd
$addfld.Close



;~ ˵��

$addfld = ObjCreate("ADODB.Connection")
$RS = ObjCreate("ADODB.Recordset")
$addfld.Open ("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=���ݿ�·��" ) ;�������ݿ�
$RS.ActiveConnection = $addfld
$RS.Open ("Select name,tel From admin" ) ;��admin���в����ֶ�Ϊname��tel����Ϣ
$RS.Open ("Select name From admin where name=С��") ;��admin���в��ֶ�Ϊname����С���ļ�¼
$addfld.Execute('Insert Into admin (name,tel) Values (С��,123456)') ;�ֱ���admin���е�name��telд�� С�� �� 123456
$addfld.Execute("UPDATE admin SET tel =654321 where name=С��") ;��admin���и����ֶ�name����С����Ӧ���ֶ�tel��ֵΪ654321
$addfld.Execute("Delete From admin Where name =С��"); ��admin����ɾ���ֶ�name�ȵ�С���ļ�¼
$RS.eof ;���һ����¼
$RS.bof;���һ����¼����һ��
$RS.Fields (0).value ;��¼��Ϣ 0��ʾ��һ�ֶ���
$RS.movenext ;��������һ����¼

$RS.close ;�رձ�
$addfld.close ;�ر����ݿ�
