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
  dtgltrans1=request.form("dtgltrans1")
  dtgltrans2=request.form("dtgltrans2")
  ctabel=request.form("ctabel")
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datatokonusantara_STRING
  set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 
  cjmltanggal=(tnourut2("jumlahtanggal"))
  dtanggalanku1= (dtgltrans1) 
  
%>
<%
if ctabel="01" then
%>
<%
Dim tpemasukan
Dim tpemasukan_numRows
Set tpemasukan = Server.CreateObject("ADODB.Recordset")
tpemasukan.ActiveConnection = MM_datatokonusantara_STRING
tpemasukan.Source = "SELECT sum(tpemasukan.subtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tpemasukan  WHERE tpemasukan.tgltrans >= '" & dtgltrans1 & "' and tpemasukan.tgltrans<='" & dtgltrans2 & "' group by tpemasukan.tgltrans order by tgltrans"
tpemasukan.CursorType = 0
tpemasukan.CursorLocation = 2
tpemasukan.LockType = 1
tpemasukan.Open()
tpemasukan_numRows = 0

Dim tpengeluaran
Dim tpengeluaran_numRows
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
	dtanggalanku1=dtanggalanku1 & "," & (dtanggalanku) 
	
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
		
	ctotal1=ctotal1 & "," & (cjumlah1) 
	ctotal2=ctotal2 & "," & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2)
	
tpemasukan.Close()
Set tpemasukan = Nothing
tpengeluaran.Close()
Set tpengeluaran = Nothing
%>



<%
elseif ctabel="02" then
%>
<%
Dim tbarangmasuk1
Dim tbarangmasuk1_numRows
Set tbarangmasuk1 = Server.CreateObject("ADODB.Recordset")
tbarangmasuk1.ActiveConnection = MM_datatokonusantara_STRING
tbarangmasuk1.Source = "SELECT sum(tbarangmasuk1.grandtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tbarangmasuk1  WHERE tbarangmasuk1.tgltrans >= '" & dtgltrans1 & "' and tbarangmasuk1.tgltrans<='" & dtgltrans2 & "' group by tbarangmasuk1.tgltrans order by tgltrans"
tbarangmasuk1.CursorType = 0
tbarangmasuk1.CursorLocation = 2
tbarangmasuk1.LockType = 1
tbarangmasuk1.Open()
tbarangmasuk1_numRows = 0

Dim tbarangkeluar1
Dim tbarangkeluar1_numRows
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
	dtanggalanku1=dtanggalanku1 & "," & (dtanggalanku) 
	
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
		
	ctotal1=ctotal1 & "," & (cjumlah1) 
	ctotal2=ctotal2 & "," & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2)
	
tbarangmasuk1.Close()
Set tbarangmasuk1 = Nothing
tbarangkeluar1.Close()
Set tbarangkeluar1 = Nothing
%>


<%
end if
%>
