<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->


    <%
    Const strMYBackup="d:\"
    Const strMYLocation = "D:\INETPUB\campuran\database\MySQL\MySQL Server 5.0\bin\"
    Const dbname= "rspermata"
    strBackup = formatdatetime(now,2)
    strbackup = right("0" & replace(strbackup,"/",""),8)
    Set MyConn=Server.CreateObject("ADODB.Connection")
	MyConn.open = MM_datarspermata_STRING

    Dim oShell
    Set oShell = CreateObject("WScript.Shell")
    oShell.run "cmd /C D:\INETPUB\campuran\database\MySQL\MySQL Server 5.0\bin\mysqldump -uroot -pkalboya rspermata  > d:\rspermata.sql",,true

    Set oShell = Nothing

    MyConn.close()
    response.write("proses backup selesai")
    %>