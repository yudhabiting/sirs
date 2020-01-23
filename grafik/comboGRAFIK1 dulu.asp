<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/datatokonusantara.asp" -->
<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>					
function DoDateTime(str, nNamedFormat, nLCID)				
	dim strRet								
	dim nOldLCID								
										
	strRet = str								
	If (nLCID > -1) Then							
		oldLCID = Session.LCID						
	End If									
										
	On Error Resume Next							
										
	If (nLCID > -1) Then							
		Session.LCID = nLCID						
	End If									
										
	If ((nLCID < 0) Or (Session.LCID = nLCID)) Then				
		strRet = FormatDateTime(str, nNamedFormat)			
	End If									
										
	If (nLCID > -1) Then							
		Session.LCID = oldLCID						
	End If									
										
	DoDateTime = strRet							
End Function									
</SCRIPT>

<%
ctabel=request.form("ctabel")
Set tnourut1 = Server.CreateObject("ADODB.connection")
tnourut1.open = MM_datatokonusantara_STRING

dtgltrans1=request.form("dtgltrans1")
dtgltrans2=request.form("dtgltrans2")
ctahun=request.form("ctahun")
ckbarang=request.form("ckbarang")
cksuplierbarang=request.form("cksuplierbarang")

set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 
cjmltanggal=(tnourut2("jumlahtanggal"))
dtanggalanku1= (dtgltrans1) 
  
%>
<%
if ctabel="1" then
%>
<%
Set tpemasukan = Server.CreateObject("ADODB.Recordset")
tpemasukan.ActiveConnection = MM_datatokonusantara_STRING
tpemasukan.Source = "SELECT sum(tpemasukan.subtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tpemasukan  WHERE tpemasukan.tgltrans >= '" & dtgltrans1 & "' and tpemasukan.tgltrans<='" & dtgltrans2 & "' group by tpemasukan.tgltrans order by tgltrans"
tpemasukan.CursorType = 0
tpemasukan.CursorLocation = 2
tpemasukan.LockType = 1
tpemasukan.Open()
tpemasukan_numRows = 0

Set tpengeluaran = Server.CreateObject("ADODB.Recordset")
tpengeluaran.ActiveConnection = MM_datatokonusantara_STRING
tpengeluaran.Source = "SELECT sum(tpengeluaran.subtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tpengeluaran  WHERE tpengeluaran.tgltrans >= '" & dtgltrans1 & "' and tpengeluaran.tgltrans<='" & dtgltrans2 & "' group by tpengeluaran.tgltrans order by tgltrans"
tpengeluaran.CursorType = 0
tpengeluaran.CursorLocation = 2
tpengeluaran.LockType = 1
tpengeluaran.Open()
tpengeluaran_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(tpemasukan.subtotal),0) as jumlah1 FROM tpemasukan  WHERE tpemasukan.tgltrans = '" & dtgltrans1 & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(tpengeluaran.subtotal),0) as jumlah2 FROM tpengeluaran  WHERE tpengeluaran.tgltrans = '" & dtgltrans1 & "'") 
ctotal2=(tnourut2("jumlah2"))

For i=1 to cstr(cjmltanggal)+0

	cjumlah1=0
	cjumlah2=0
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	
	While (NOT tpemasukan.EOF)
		ctanggalanku=cstr(tpemasukan.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(tpemasukan.Fields.Item("jumlah").Value)+0
		end if
	  tpemasukan.MoveNext()
	Wend
	If (tpemasukan.CursorType > 0) Then
	  tpemasukan.MoveFirst
	Else
	  tpemasukan.Requery
	End If


	While (NOT tpengeluaran.EOF)
		ctanggalanku=cstr(tpengeluaran.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(tpengeluaran.Fields.Item("jumlah").Value)+0
		end if
	  tpengeluaran.MoveNext()
	Wend
	If (tpengeluaran.CursorType > 0) Then
	  tpengeluaran.MoveFirst
	Else
	  tpengeluaran.Requery
	End If
		
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
	
tpemasukan.Close()
Set tpemasukan = Nothing
tpengeluaran.Close()
Set tpengeluaran = Nothing
%>



<%
elseif ctabel="2" then
%>
<%
Set tbarangmasuk1 = Server.CreateObject("ADODB.Recordset")
tbarangmasuk1.ActiveConnection = MM_datatokonusantara_STRING
tbarangmasuk1.Source = "SELECT sum(tbarangmasuk1.grandtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tbarangmasuk1  WHERE tbarangmasuk1.tgltrans >= '" & dtgltrans1 & "' and tbarangmasuk1.tgltrans<='" & dtgltrans2 & "' group by tbarangmasuk1.tgltrans order by tgltrans"
tbarangmasuk1.CursorType = 0
tbarangmasuk1.CursorLocation = 2
tbarangmasuk1.LockType = 1
tbarangmasuk1.Open()
tbarangmasuk1_numRows = 0

Set tbarangkeluar1 = Server.CreateObject("ADODB.Recordset")
tbarangkeluar1.ActiveConnection = MM_datatokonusantara_STRING
tbarangkeluar1.Source = "SELECT sum(tbarangkeluar1.grandtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tbarangkeluar1  WHERE tbarangkeluar1.tgltrans >= '" & dtgltrans1 & "' and tbarangkeluar1.tgltrans<='" & dtgltrans2 & "' group by tbarangkeluar1.tgltrans order by tgltrans"
tbarangkeluar1.CursorType = 0
tbarangkeluar1.CursorLocation = 2
tbarangkeluar1.LockType = 1
tbarangkeluar1.Open()
tbarangkeluar1_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(tbarangmasuk1.grandtotal),0) as jumlah1 FROM tbarangmasuk1  WHERE  tbarangmasuk1.tgltrans = '" & dtgltrans1 & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(tbarangkeluar1.grandtotal),0) as jumlah2 FROM tbarangkeluar1  WHERE  tbarangkeluar1.tgltrans = '" & dtgltrans1 & "'") 
ctotal2=(tnourut2("jumlah2"))

For i=1 to cstr(cjmltanggal)+0

	cjumlah1=0
	cjumlah2=0
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	
	While (NOT tbarangmasuk1.EOF)
		ctanggalanku=cstr(tbarangmasuk1.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(tbarangmasuk1.Fields.Item("jumlah").Value)+0
		end if
	  tbarangmasuk1.MoveNext()
	Wend
	If (tbarangmasuk1.CursorType > 0) Then
	  tbarangmasuk1.MoveFirst
	Else
	  tbarangmasuk1.Requery
	End If


	While (NOT tbarangkeluar1.EOF)
		ctanggalanku=cstr(tbarangkeluar1.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(tbarangkeluar1.Fields.Item("jumlah").Value)+0
		end if
	  tbarangkeluar1.MoveNext()
	Wend
	If (tbarangkeluar1.CursorType > 0) Then
	  tbarangkeluar1.MoveFirst
	Else
	  tbarangkeluar1.Requery
	End If
		
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
	
tbarangmasuk1.Close()
Set tbarangmasuk1 = Nothing
tbarangkeluar1.Close()
Set tbarangkeluar1 = Nothing
%>


<%
elseif ctabel="5" then
%>
<%
ckbarang=request.form("ckbarang")

Set tbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
tbarangmasuk2.ActiveConnection = MM_datatokonusantara_STRING
tbarangmasuk2.Source = "SELECT sum(jumlah) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM vtbarangmasuk2  WHERE tgltrans >= '" & dtgltrans1 & "' and tgltrans<='" & dtgltrans2 & "'  and kbarang='" & ckbarang & "' group by tgltrans order by tgltrans"
tbarangmasuk2.CursorType = 0
tbarangmasuk2.CursorLocation = 2
tbarangmasuk2.LockType = 1
tbarangmasuk2.Open()
tbarangmasuk2_numRows = 0

Set tbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
tbarangkeluar2.ActiveConnection = MM_datatokonusantara_STRING
tbarangkeluar2.Source = "SELECT sum(jumlah) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM vtbarangkeluar2  WHERE tgltrans >= '" & dtgltrans1 & "' and tgltrans<='" & dtgltrans2 & "'  and kbarang='" & ckbarang & "' group by tgltrans order by tgltrans"
tbarangkeluar2.CursorType = 0
tbarangkeluar2.CursorLocation = 2
tbarangkeluar2.LockType = 1
tbarangkeluar2.Open()
tbarangkeluar2_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(jumlah),0) as jumlah1 FROM vtbarangmasuk2  WHERE tgltrans = '" & dtgltrans1 & "'  and kbarang='" & ckbarang & "' group by tgltrans") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(jumlah),0) as jumlah2 FROM vtbarangkeluar2  WHERE tgltrans = '" & dtgltrans1 & "'  and kbarang='" & ckbarang & "' group by tgltrans") 
ctotal2=(tnourut2("jumlah2"))

For i=1 to cstr(cjmltanggal)+0

	cjumlah1=0
	cjumlah2=0
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	
	While (NOT tbarangmasuk2.EOF)
		ctanggalanku=cstr(tbarangmasuk2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(tbarangmasuk2.Fields.Item("jumlah").Value)+0
		end if
	  tbarangmasuk2.MoveNext()
	Wend
	If (tbarangmasuk2.CursorType > 0) Then
	  tbarangmasuk2.MoveFirst
	Else
	  tbarangmasuk2.Requery
	End If


	While (NOT tbarangkeluar2.EOF)
		ctanggalanku=cstr(tbarangkeluar2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(tbarangkeluar2.Fields.Item("jumlah").Value)+0
		end if
	  tbarangkeluar2.MoveNext()
	Wend
	If (tbarangkeluar2.CursorType > 0) Then
	  tbarangkeluar2.MoveFirst
	Else
	  tbarangkeluar2.Requery
	End If
		
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
	
tbarangmasuk2.Close()
Set tbarangmasuk2 = Nothing
tbarangkeluar2.Close()
Set tbarangkeluar2 = Nothing
%>

<%
elseif ctabel="7" then

%>
<%


Set vtbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
vtbarangkeluar2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangkeluar2.Source = "select kbarang, barang,coalesce(sum(jumlah),0) as jumlah2, (select coalesce(sum(jumlah),0) from vtbarangmasuk2 where  vtbarangmasuk2.tgltrans >= '" & dtgltrans1 & "' and vtbarangmasuk2.tgltrans<='" & dtgltrans2 & "' and vtbarangmasuk2.kbarang=vtbarangkeluar2.kbarang  ) AS jumlah1 from vtbarangkeluar2 where  vtbarangkeluar2.tgltrans >= '" & dtgltrans1 & "' and vtbarangkeluar2.tgltrans<='" & dtgltrans2 & "' group by kbarang  order by sum(jumlah) desc limit 10"
vtbarangkeluar2.CursorType = 0
vtbarangkeluar2.CursorLocation = 2
vtbarangkeluar2.LockType = 1
vtbarangkeluar2.Open()
vtbarangkeluar2_numRows = 0

dbarangku=""
cjumlah1=""
cjumlah2=""
ctotal1=""
ctotal2=""

While (NOT vtbarangkeluar2.EOF)

	dbarangku  = vtbarangkeluar2.Fields.Item("barang").Value
	cjumlah1  = cstr(vtbarangkeluar2.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(vtbarangkeluar2.Fields.Item("jumlah2").Value)+0
	dbarangku1 = dbarangku1 & "=;=" & (dbarangku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 

vtbarangkeluar2.MoveNext()
Wend
If (vtbarangkeluar2.CursorType > 0) Then
  vtbarangkeluar2.MoveFirst
Else
  vtbarangkeluar2.Requery
End If


dbarangku1=mid(trim(dbarangku1),4,len(trim(dbarangku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbarangku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
vtbarangkeluar2.Close()
Set vtbarangkeluar2 = Nothing

%>



<%
elseif ctabel="8" then

%>
<%


Set vtbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
vtbarangkeluar2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangkeluar2.Source = "select kbarang, barang,coalesce(sum(jumlah),0) as jumlah2, (select coalesce(sum(jumlah),0) from vtbarangmasuk2 where  year(vtbarangmasuk2.tgltrans)='"&ctahun&"'  and vtbarangmasuk2.kbarang=vtbarangkeluar2.kbarang  ) AS jumlah1 from vtbarangkeluar2 where   year(vtbarangkeluar2.tgltrans)='"&ctahun&"'  group by kbarang  order by sum(jumlah) desc limit 10"
vtbarangkeluar2.CursorType = 0
vtbarangkeluar2.CursorLocation = 2
vtbarangkeluar2.LockType = 1
vtbarangkeluar2.Open()
vtbarangkeluar2_numRows = 0

dbarangku=""
cjumlah1=""
cjumlah2=""
ctotal1=""
ctotal2=""

While (NOT vtbarangkeluar2.EOF)

	dbarangku  = vtbarangkeluar2.Fields.Item("barang").Value
	cjumlah1  = cstr(vtbarangkeluar2.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(vtbarangkeluar2.Fields.Item("jumlah2").Value)+0
	dbarangku1 = dbarangku1 & "=;=" & (dbarangku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 

vtbarangkeluar2.MoveNext()
Wend
If (vtbarangkeluar2.CursorType > 0) Then
  vtbarangkeluar2.MoveFirst
Else
  vtbarangkeluar2.Requery
End If


dbarangku1=mid(trim(dbarangku1),4,len(trim(dbarangku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbarangku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
vtbarangkeluar2.Close()
Set vtbarangkeluar2 = Nothing

%>


<%
elseif ctabel="9" then

%>
<%


Set vtbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
vtbarangmasuk2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangmasuk2.Source = "select kbarang, barang,coalesce(sum(jumlah),0) as jumlah2, (select coalesce(sum(jumlah),0) from vtbarangkeluar2 where  vtbarangkeluar2.tgltrans >= '" & dtgltrans1 & "' and vtbarangkeluar2.tgltrans<='" & dtgltrans2 & "' and vtbarangkeluar2.kbarang=vtbarangmasuk2.kbarang  ) AS jumlah1 from vtbarangmasuk2 where  vtbarangmasuk2.tgltrans >= '" & dtgltrans1 & "' and vtbarangmasuk2.tgltrans<='" & dtgltrans2 & "' group by kbarang  order by sum(jumlah) desc limit 10"
vtbarangmasuk2.CursorType = 0
vtbarangmasuk2.CursorLocation = 2
vtbarangmasuk2.LockType = 1
vtbarangmasuk2.Open()
vtbarangmasuk2_numRows = 0

dbarangku=""
cjumlah1=""
cjumlah2=""
ctotal1=""
ctotal2=""

While (NOT vtbarangmasuk2.EOF)

	dbarangku  = vtbarangmasuk2.Fields.Item("barang").Value
	cjumlah1  = cstr(vtbarangmasuk2.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(vtbarangmasuk2.Fields.Item("jumlah2").Value)+0
	dbarangku1 = dbarangku1 & "=;=" & (dbarangku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 

vtbarangmasuk2.MoveNext()
Wend
If (vtbarangmasuk2.CursorType > 0) Then
  vtbarangmasuk2.MoveFirst
Else
  vtbarangmasuk2.Requery
End If


dbarangku1=mid(trim(dbarangku1),4,len(trim(dbarangku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbarangku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
vtbarangmasuk2.Close()
Set vtbarangmasuk2 = Nothing

%>

<%
elseif ctabel="10" then

%>
<%


Set vtbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
vtbarangmasuk2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangmasuk2.Source = "select kbarang, barang,coalesce(sum(jumlah),0) as jumlah2, (select coalesce(sum(jumlah),0) from vtbarangkeluar2 where  year(vtbarangkeluar2.tgltrans)='"&ctahun&"'  and vtbarangkeluar2.kbarang=vtbarangmasuk2.kbarang  ) AS jumlah1 from vtbarangmasuk2 where   year(vtbarangmasuk2.tgltrans)='"&ctahun&"'  group by kbarang  order by sum(jumlah) desc limit 10"
vtbarangmasuk2.CursorType = 0
vtbarangmasuk2.CursorLocation = 2
vtbarangmasuk2.LockType = 1
vtbarangmasuk2.Open()
vtbarangmasuk2_numRows = 0

dbarangku=""
cjumlah1=""
cjumlah2=""
ctotal1=""
ctotal2=""

While (NOT vtbarangmasuk2.EOF)

	dbarangku  = vtbarangmasuk2.Fields.Item("barang").Value
	cjumlah1  = cstr(vtbarangmasuk2.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(vtbarangmasuk2.Fields.Item("jumlah2").Value)+0
	dbarangku1 = dbarangku1 & "=;=" & (dbarangku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 

vtbarangmasuk2.MoveNext()
Wend
If (vtbarangmasuk2.CursorType > 0) Then
  vtbarangmasuk2.MoveFirst
Else
  vtbarangmasuk2.Requery
End If


dbarangku1=mid(trim(dbarangku1),4,len(trim(dbarangku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)

response.Write(dbarangku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
vtbarangmasuk2.Close()
Set vtbarangmasuk2 = Nothing

%>




<%
elseif ctabel="11" then

%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datatokonusantara_STRING
tbulan.Source = "select bulan,(select coalesce(sum(jumlah),0) from vtbarangmasuk2 where month(tgltrans)=tbulan.kbulan and year(vtbarangmasuk2.tgltrans)='"&ctahun&"'  and kbarang like '%" & ckbarang & "%' )  as jumlah1,(select coalesce(sum(jumlah),0) from vtbarangkeluar2 where  month(tgltrans)=tbulan.kbulan and year(vtbarangkeluar2.tgltrans)='"&ctahun&"'  and kbarang like '%" & ckbarang & "%' ) as jumlah2,(select coalesce(sum(jumlah),0) from tsisabahan  where  month(tgltrans)=tbulan.kbulan and year(tsisabahan.tgltrans)='"&ctahun&"'  and kbarang like '%" & ckbarang & "%'  AND kondisi='S')  as jumlah3,(select coalesce(sum(jumlah),0) from tsisabahan  where  month(tgltrans)=tbulan.kbulan and year(tsisabahan.tgltrans)='"&ctahun&"'   and kbarang like '%" & ckbarang & "%'  AND kondisi='R')  as jumlah4 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cjumlah1=""
cjumlah2=""
cjumlah3=""
cjumlah4=""
ctotal1=""
ctotal2=""
ctotal3=""
ctotal4=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cjumlah1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0
	cjumlah3  = cstr(tbulan.Fields.Item("jumlah3").Value)+0
	cjumlah4  = cstr(tbulan.Fields.Item("jumlah4").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 
	ctotal3   = ctotal3 & "=;=" & (cjumlah3) 
	ctotal4   = ctotal4 & "=;=" & (cjumlah4) 

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
ctotal3=mid(trim(ctotal3),4,len(trim(ctotal3))-3)
ctotal4=mid(trim(ctotal4),4,len(trim(ctotal4))-3)

response.Write(dbulanku1&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}"&ctotal3&"{{}}"&ctotal4&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>



<%
elseif ctabel="12" then

%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datatokonusantara_STRING
tbulan.Source = "select bulan,(select coalesce(sum(grandtotal),0) from tbarangmasuk1 where month(tgltrans)=tbulan.kbulan and year(tbarangmasuk1.tgltrans)='"&ctahun&"'  and ksuplierbarang like '%" & cksuplierbarang & "%' )  as grandtotal1 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cgrandtotal1=""
ctotal1=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cgrandtotal1  = cstr(tbulan.Fields.Item("grandtotal1").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal1   = ctotal1 & "=;=" & (cgrandtotal1) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)

response.Write(dbulanku1&"{{}}"&ctotal1&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>


<%
end if
%>
