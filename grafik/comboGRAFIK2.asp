<%@LANGUAGE="VBSCRIPT" %>
<!--#include file="../Connections/datarspermata.asp" -->

<%
ctabel=request.form("ctabel")
ctahun=request.form("ctahun")
%>

<%
if ctabel="02001" then
%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "select bulan,(select coalesce(count(notrans),0) from trawatpasien where ktujuan<>'01' and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"')  as jumlah1,(select coalesce(count(notrans),0) from trawatpasien where  ktujuan='01' and month(tglmasuk)=tbulan.kbulan and year(tglmasuk)='"&ctahun&"')  as jumlah2 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
csubtotal1=""
csubtotal2=""
ctotal1=""
ctotal2=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	csubtotal1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	csubtotal2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal1   = ctotal1 & "=;=" & (csubtotal1) 
	ctotal2   = ctotal2 & "=;=" & (csubtotal2) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbulanku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>


<%
elseif ctabel="4" then

%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "select bulan,(select coalesce(sum(grandtotal),0) from tbarangmasuk1 where month(tgltrans)=tbulan.kbulan and year(tbarangmasuk1.tgltrans)='"&ctahun&"')  as jumlah1,(select coalesce(sum(grandtotal),0) from tbarangkeluar1 where month(tgltrans)=tbulan.kbulan and year(tbarangkeluar1.tgltrans)='"&ctahun&"')  as jumlah2 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cgrandtotal1=""
cgrandtotal2=""
ctotal1=""
ctotal2=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cgrandtotal1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	cgrandtotal2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal1   = ctotal1 & "=;=" & (cgrandtotal1) 
	ctotal2   = ctotal2 & "=;=" & (cgrandtotal2) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbulanku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
tbulan.Close()
Set tbulan = Nothing
%>





<%
end if

%>
