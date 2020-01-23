<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/datarspermata.asp" -->
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
tnourut1.open = MM_datarspermata_STRING

dtgltrans1=request.form("dtgltrans1")
dtgltrans2=request.form("dtgltrans2")
ctahun=request.form("ctahun")

cstatuspasien=request.form("cstatuspasien")

ckobat=request.form("ckobat")
cksuplierbarang=request.form("cksuplierbarang")

set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 
cjmltanggal=(tnourut2("jumlahtanggal"))
dtanggalanku1= (dtgltrans1) 
  
%>
<%
'GRAFIK KUNJUNGAN PASIEN PER TANGGAL
if ctabel="01001" then
%>
<%
Set trawatjalan = Server.CreateObject("ADODB.Recordset")
trawatjalan.ActiveConnection = MM_datarspermata_STRING
trawatjalan.Source = "SELECT count(trawatpasien.notrans) as jumlah, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.ktujuan<>'01' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatjalan.CursorType = 0
trawatjalan.CursorLocation = 2
trawatjalan.LockType = 1
trawatjalan.Open()
trawatjalan_numRows = 0

Set trawatinap = Server.CreateObject("ADODB.Recordset")
trawatinap.ActiveConnection = MM_datarspermata_STRING
trawatinap.Source = "SELECT count(trawatpasien.notrans) as jumlah, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.ktujuan='01' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatinap.CursorType = 0
trawatinap.CursorLocation = 2
trawatinap.LockType = 1
trawatinap.Open()
trawatinap_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah1 FROM trawatpasien  WHERE  trawatpasien.ktujuan='01' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah2 FROM trawatpasien  WHERE  trawatpasien.ktujuan='01' and  trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal2=(tnourut2("jumlah2"))

For i=1 to cstr(cjmltanggal)+0

	cjumlah1=0
	cjumlah2=0
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	
	While (NOT trawatjalan.EOF)
		ctanggalanku=cstr(trawatjalan.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(trawatjalan.Fields.Item("jumlah").Value)+0
		end if
	  trawatjalan.MoveNext()
	Wend
	If (trawatjalan.CursorType > 0) Then
	  trawatjalan.MoveFirst
	Else
	  trawatjalan.Requery
	End If


	While (NOT trawatinap.EOF)
		ctanggalanku=cstr(trawatinap.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(trawatinap.Fields.Item("jumlah").Value)+0
		end if
	  trawatinap.MoveNext()
	Wend
	If (trawatinap.CursorType > 0) Then
	  trawatinap.MoveFirst
	Else
	  trawatinap.Requery
	End If
		
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
	
trawatjalan.Close()
Set trawatjalan = Nothing
trawatinap.Close()
Set trawatinap = Nothing
%>



<%
'KUNJUNGAN PASIEN PER KELOMPOK PER TANGGAL
elseif ctabel="1002" then
%>
<%

Set trawatpasien0 = Server.CreateObject("ADODB.Recordset")
trawatpasien0.ActiveConnection = MM_datarspermata_STRING
trawatpasien0.Source = "SELECT count(trawatpasien.notrans) as jumlah0, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%'  and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien0.CursorType = 0
trawatpasien0.CursorLocation = 2
trawatpasien0.LockType = 1
trawatpasien0.Open()
trawatpasien0_numRows = 0


Set trawatpasien1 = Server.CreateObject("ADODB.Recordset")
trawatpasien1.ActiveConnection = MM_datarspermata_STRING
trawatpasien1.Source = "SELECT count(trawatpasien.notrans) as jumlah1, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='1' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien1.CursorType = 0
trawatpasien1.CursorLocation = 2
trawatpasien1.LockType = 1
trawatpasien1.Open()
trawatpasien1_numRows = 0

Set trawatpasien2 = Server.CreateObject("ADODB.Recordset")
trawatpasien2.ActiveConnection = MM_datarspermata_STRING
trawatpasien2.Source = "SELECT count(trawatpasien.notrans) as jumlah2, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok between '2' and '3' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien2.CursorType = 0
trawatpasien2.CursorLocation = 2
trawatpasien2.LockType = 1
trawatpasien2.Open()
trawatpasien2_numRows = 0


Set trawatpasien3 = Server.CreateObject("ADODB.Recordset")
trawatpasien3.ActiveConnection = MM_datarspermata_STRING
trawatpasien3.Source = "SELECT count(trawatpasien.notrans) as jumlah3, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='4' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien3.CursorType = 0
trawatpasien3.CursorLocation = 2
trawatpasien3.LockType = 1
trawatpasien3.Open()
trawatpasien3_numRows = 0


Set trawatpasien4 = Server.CreateObject("ADODB.Recordset")
trawatpasien4.ActiveConnection = MM_datarspermata_STRING
trawatpasien4.Source = "SELECT count(trawatpasien.notrans) as jumlah4, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='5' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien4.CursorType = 0
trawatpasien4.CursorLocation = 2
trawatpasien4.LockType = 1
trawatpasien4.Open()
trawatpasien4_numRows = 0


Set trawatpasien5 = Server.CreateObject("ADODB.Recordset")
trawatpasien5.ActiveConnection = MM_datarspermata_STRING
trawatpasien5.Source = "SELECT count(trawatpasien.notrans) as jumlah5, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='6' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien5.CursorType = 0
trawatpasien5.CursorLocation = 2
trawatpasien5.LockType = 1
trawatpasien5.Open()
trawatpasien5_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah0 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%'  and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal0=(tnourut2("jumlah0"))


set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah1 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='1' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah2 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok  between '2' and '3' and  trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal2=(tnourut2("jumlah2"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah3 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='4' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal3=(tnourut2("jumlah3"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah4 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='5' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal4=(tnourut2("jumlah4"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah5 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.kkelompok='6' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal5=(tnourut2("jumlah5"))



For i=1 to cstr(cjmltanggal)+0

	cjumlah0=0
	cjumlah1=0
	cjumlah2=0
	cjumlah3=0
	cjumlah4=0
	cjumlah5=0
	
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	

	While (NOT trawatpasien0.EOF)
		ctanggalanku=cstr(trawatpasien0.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah0=cjumlah0+cstr(trawatpasien0.Fields.Item("jumlah0").Value)+0
		end if
	  trawatpasien0.MoveNext()
	Wend
	If (trawatpasien0.CursorType > 0) Then
	  trawatpasien0.MoveFirst
	Else
	  trawatpasien0.Requery
	End If


	While (NOT trawatpasien1.EOF)
		ctanggalanku=cstr(trawatpasien1.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(trawatpasien1.Fields.Item("jumlah1").Value)+0
		end if
	  trawatpasien1.MoveNext()
	Wend
	If (trawatpasien1.CursorType > 0) Then
	  trawatpasien1.MoveFirst
	Else
	  trawatpasien1.Requery
	End If


	While (NOT trawatpasien2.EOF)
		ctanggalanku=cstr(trawatpasien2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(trawatpasien2.Fields.Item("jumlah2").Value)+0
		end if
	  trawatpasien2.MoveNext()
	Wend
	If (trawatpasien2.CursorType > 0) Then
	  trawatpasien2.MoveFirst
	Else
	  trawatpasien2.Requery
	End If


	While (NOT trawatpasien3.EOF)
		ctanggalanku=cstr(trawatpasien3.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah3=cjumlah3+cstr(trawatpasien3.Fields.Item("jumlah3").Value)+0
		end if
	  trawatpasien3.MoveNext()
	Wend
	If (trawatpasien3.CursorType > 0) Then
	  trawatpasien3.MoveFirst
	Else
	  trawatpasien3.Requery
	End If


	While (NOT trawatpasien4.EOF)
		ctanggalanku=cstr(trawatpasien4.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah4=cjumlah4+cstr(trawatpasien4.Fields.Item("jumlah4").Value)+0
		end if
	  trawatpasien4.MoveNext()
	Wend
	If (trawatpasien4.CursorType > 0) Then
	  trawatpasien4.MoveFirst
	Else
	  trawatpasien4.Requery
	End If



	While (NOT trawatpasien5.EOF)
		ctanggalanku=cstr(trawatpasien5.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah5=cjumlah5+cstr(trawatpasien5.Fields.Item("jumlah5").Value)+0
		end if
	  trawatpasien5.MoveNext()
	Wend
	If (trawatpasien5.CursorType > 0) Then
	  trawatpasien5.MoveFirst
	Else
	  trawatpasien5.Requery
	End If

		
	ctotal0=ctotal0 & "=;=" & (cjumlah0) 
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
	ctotal3=ctotal3 & "=;=" & (cjumlah3) 
	ctotal4=ctotal4 & "=;=" & (cjumlah4) 
	ctotal5=ctotal5 & "=;=" & (cjumlah5) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal0&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}"&ctotal3&"{{}}"&ctotal4&"{{}}"&ctotal5&"{{}}")
	
trawatpasien0.Close()
Set trawatpasien0 = Nothing
trawatpasien1.Close()
Set trawatpasien1 = Nothing
trawatpasien2.Close()
Set trawatpasien2 = Nothing
trawatpasien3.Close()
Set trawatpasien3 = Nothing
trawatpasien4.Close()
Set trawatpasien4 = Nothing
trawatpasien5.Close()
Set trawatpasien5 = Nothing
%>



<%
'KUNJUNGAN PASIEN PER TUJUAN BEROBAT PER TANGGAL
elseif ctabel="1003" then
%>
<%

Set trawatpasien0 = Server.CreateObject("ADODB.Recordset")
trawatpasien0.ActiveConnection = MM_datarspermata_STRING
trawatpasien0.Source = "SELECT count(trawatpasien.notrans) as jumlah0, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%'  and trawatpasien.ktujuan IN ('02','04','07','21','22','23','24','26','27') and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien0.CursorType = 0
trawatpasien0.CursorLocation = 2
trawatpasien0.LockType = 1
trawatpasien0.Open()
trawatpasien0_numRows = 0

'poli umum
Set trawatpasien1 = Server.CreateObject("ADODB.Recordset")
trawatpasien1.ActiveConnection = MM_datarspermata_STRING
trawatpasien1.Source = "SELECT count(trawatpasien.notrans) as jumlah1, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='02' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien1.CursorType = 0
trawatpasien1.CursorLocation = 2
trawatpasien1.LockType = 1
trawatpasien1.Open()
trawatpasien1_numRows = 0
'poli obsgin
Set trawatpasien2 = Server.CreateObject("ADODB.Recordset")
trawatpasien2.ActiveConnection = MM_datarspermata_STRING
trawatpasien2.Source = "SELECT count(trawatpasien.notrans) as jumlah2, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='04' and '3' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien2.CursorType = 0
trawatpasien2.CursorLocation = 2
trawatpasien2.LockType = 1
trawatpasien2.Open()
trawatpasien2_numRows = 0

'poli gigi
Set trawatpasien3 = Server.CreateObject("ADODB.Recordset")
trawatpasien3.ActiveConnection = MM_datarspermata_STRING
trawatpasien3.Source = "SELECT count(trawatpasien.notrans) as jumlah3, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='07' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien3.CursorType = 0
trawatpasien3.CursorLocation = 2
trawatpasien3.LockType = 1
trawatpasien3.Open()
trawatpasien3_numRows = 0

'poli penyakit dalam
Set trawatpasien4 = Server.CreateObject("ADODB.Recordset")
trawatpasien4.ActiveConnection = MM_datarspermata_STRING
trawatpasien4.Source = "SELECT count(trawatpasien.notrans) as jumlah4, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='21' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien4.CursorType = 0
trawatpasien4.CursorLocation = 2
trawatpasien4.LockType = 1
trawatpasien4.Open()
trawatpasien4_numRows = 0

' poli anak
Set trawatpasien5 = Server.CreateObject("ADODB.Recordset")
trawatpasien5.ActiveConnection = MM_datarspermata_STRING
trawatpasien5.Source = "SELECT count(trawatpasien.notrans) as jumlah5, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='22' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien5.CursorType = 0
trawatpasien5.CursorLocation = 2
trawatpasien5.LockType = 1
trawatpasien5.Open()
trawatpasien5_numRows = 0

' poli bedah
Set trawatpasien6 = Server.CreateObject("ADODB.Recordset")
trawatpasien6.ActiveConnection = MM_datarspermata_STRING
trawatpasien6.Source = "SELECT count(trawatpasien.notrans) as jumlah6, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='23' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien6.CursorType = 0
trawatpasien6.CursorLocation = 2
trawatpasien6.LockType = 1
trawatpasien6.Open()
trawatpasien6_numRows = 0

' poli saraf
Set trawatpasien7 = Server.CreateObject("ADODB.Recordset")
trawatpasien7.ActiveConnection = MM_datarspermata_STRING
trawatpasien7.Source = "SELECT count(trawatpasien.notrans) as jumlah7, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='24' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien7.CursorType = 0
trawatpasien7.CursorLocation = 2
trawatpasien7.LockType = 1
trawatpasien7.Open()
trawatpasien7_numRows = 0


' poli paru
Set trawatpasien8 = Server.CreateObject("ADODB.Recordset")
trawatpasien8.ActiveConnection = MM_datarspermata_STRING
trawatpasien8.Source = "SELECT count(trawatpasien.notrans) as jumlah8, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='26' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien8.CursorType = 0
trawatpasien8.CursorLocation = 2
trawatpasien8.LockType = 1
trawatpasien8.Open()
trawatpasien8_numRows = 0


' poli bedah tulang
Set trawatpasien9 = Server.CreateObject("ADODB.Recordset")
trawatpasien9.ActiveConnection = MM_datarspermata_STRING
trawatpasien9.Source = "SELECT count(trawatpasien.notrans) as jumlah9, DATE_FORMAT(tglmasuk,'%Y-%m-%d') AS tgltrans FROM trawatpasien  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='27' and trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' group by trawatpasien.tglmasuk order by tglmasuk"
trawatpasien9.CursorType = 0
trawatpasien9.CursorLocation = 2
trawatpasien9.LockType = 1
trawatpasien9.Open()
trawatpasien9_numRows = 0



set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah0 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%'  and trawatpasien.ktujuan IN ('02','04','07','21','22','23','24','26','27') and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal0=(tnourut2("jumlah0"))


set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah1 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='02' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah2 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='04' and  trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal2=(tnourut2("jumlah2"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah3 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='07' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal3=(tnourut2("jumlah3"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah4 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='21' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal4=(tnourut2("jumlah4"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah5 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='22' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal5=(tnourut2("jumlah5"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah6 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='23' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal6=(tnourut2("jumlah6"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah7 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='24' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal7=(tnourut2("jumlah7"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah8 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='26' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal8=(tnourut2("jumlah8"))

set tnourut2=tnourut1.execute ("SELECT coalesce(count(trawatpasien.notrans),0) as jumlah9 FROM trawatpasien  WHERE  trawatpasien.statuspasien like '%"&cstatuspasien&"%' and trawatpasien.ktujuan='27' and trawatpasien.tglmasuk = '" & dtgltrans1 & "'") 
ctotal9=(tnourut2("jumlah9"))



For i=1 to cstr(cjmltanggal)+0

	cjumlah0=0
	cjumlah1=0
	cjumlah2=0
	cjumlah3=0
	cjumlah4=0
	cjumlah5=0
	cjumlah6=0
	cjumlah7=0
	cjumlah8=0
	cjumlah9=0
	
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	

	While (NOT trawatpasien0.EOF)
		ctanggalanku=cstr(trawatpasien0.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah0=cjumlah0+cstr(trawatpasien0.Fields.Item("jumlah0").Value)+0
		end if
	  trawatpasien0.MoveNext()
	Wend
	If (trawatpasien0.CursorType > 0) Then
	  trawatpasien0.MoveFirst
	Else
	  trawatpasien0.Requery
	End If


	While (NOT trawatpasien1.EOF)
		ctanggalanku=cstr(trawatpasien1.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(trawatpasien1.Fields.Item("jumlah1").Value)+0
		end if
	  trawatpasien1.MoveNext()
	Wend
	If (trawatpasien1.CursorType > 0) Then
	  trawatpasien1.MoveFirst
	Else
	  trawatpasien1.Requery
	End If


	While (NOT trawatpasien2.EOF)
		ctanggalanku=cstr(trawatpasien2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(trawatpasien2.Fields.Item("jumlah2").Value)+0
		end if
	  trawatpasien2.MoveNext()
	Wend
	If (trawatpasien2.CursorType > 0) Then
	  trawatpasien2.MoveFirst
	Else
	  trawatpasien2.Requery
	End If


	While (NOT trawatpasien3.EOF)
		ctanggalanku=cstr(trawatpasien3.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah3=cjumlah3+cstr(trawatpasien3.Fields.Item("jumlah3").Value)+0
		end if
	  trawatpasien3.MoveNext()
	Wend
	If (trawatpasien3.CursorType > 0) Then
	  trawatpasien3.MoveFirst
	Else
	  trawatpasien3.Requery
	End If


	While (NOT trawatpasien4.EOF)
		ctanggalanku=cstr(trawatpasien4.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah4=cjumlah4+cstr(trawatpasien4.Fields.Item("jumlah4").Value)+0
		end if
	  trawatpasien4.MoveNext()
	Wend
	If (trawatpasien4.CursorType > 0) Then
	  trawatpasien4.MoveFirst
	Else
	  trawatpasien4.Requery
	End If



	While (NOT trawatpasien5.EOF)
		ctanggalanku=cstr(trawatpasien5.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah5=cjumlah5+cstr(trawatpasien5.Fields.Item("jumlah5").Value)+0
		end if
	  trawatpasien5.MoveNext()
	Wend
	If (trawatpasien5.CursorType > 0) Then
	  trawatpasien5.MoveFirst
	Else
	  trawatpasien5.Requery
	End If

	While (NOT trawatpasien6.EOF)
		ctanggalanku=cstr(trawatpasien6.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah6=cjumlah6+cstr(trawatpasien6.Fields.Item("jumlah6").Value)+0
		end if
	  trawatpasien6.MoveNext()
	Wend
	If (trawatpasien6.CursorType > 0) Then
	  trawatpasien6.MoveFirst
	Else
	  trawatpasien6.Requery
	End If


	While (NOT trawatpasien7.EOF)
		ctanggalanku=cstr(trawatpasien7.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah7=cjumlah7+cstr(trawatpasien7.Fields.Item("jumlah7").Value)+0
		end if
	  trawatpasien7.MoveNext()
	Wend
	If (trawatpasien7.CursorType > 0) Then
	  trawatpasien7.MoveFirst
	Else
	  trawatpasien7.Requery
	End If


	While (NOT trawatpasien8.EOF)
		ctanggalanku=cstr(trawatpasien8.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah8=cjumlah8+cstr(trawatpasien8.Fields.Item("jumlah8").Value)+0
		end if
	  trawatpasien8.MoveNext()
	Wend
	If (trawatpasien8.CursorType > 0) Then
	  trawatpasien8.MoveFirst
	Else
	  trawatpasien8.Requery
	End If


	While (NOT trawatpasien9.EOF)
		ctanggalanku=cstr(trawatpasien9.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah9=cjumlah9+cstr(trawatpasien9.Fields.Item("jumlah9").Value)+0
		end if
	  trawatpasien9.MoveNext()
	Wend
	If (trawatpasien9.CursorType > 0) Then
	  trawatpasien9.MoveFirst
	Else
	  trawatpasien9.Requery
	End If


		
	ctotal0=ctotal0 & "=;=" & (cjumlah0) 
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
	ctotal3=ctotal3 & "=;=" & (cjumlah3) 
	ctotal4=ctotal4 & "=;=" & (cjumlah4) 
	ctotal5=ctotal5 & "=;=" & (cjumlah5) 
	ctotal6=ctotal6 & "=;=" & (cjumlah6) 
	ctotal7=ctotal7 & "=;=" & (cjumlah7) 
	ctotal8=ctotal8 & "=;=" & (cjumlah8) 
	ctotal9=ctotal9 & "=;=" & (cjumlah9) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal0&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}"&ctotal3&"{{}}"&ctotal4&"{{}}"&ctotal5&"{{}}"&ctotal6&"{{}}"&ctotal7&"{{}}"&ctotal8&"{{}}"&ctotal9&"{{}}")
	
trawatpasien0.Close()
Set trawatpasien0 = Nothing
trawatpasien1.Close()
Set trawatpasien1 = Nothing
trawatpasien2.Close()
Set trawatpasien2 = Nothing
trawatpasien3.Close()
Set trawatpasien3 = Nothing
trawatpasien4.Close()
Set trawatpasien4 = Nothing
trawatpasien5.Close()
Set trawatpasien5 = Nothing
trawatpasien6.Close()
Set trawatpasien6 = Nothing
trawatpasien7.Close()
Set trawatpasien7 = Nothing
trawatpasien8.Close()
Set trawatpasien8 = Nothing
trawatpasien9.Close()
Set trawatpasien9 = Nothing

%>



<%
'TREND PEMAKAIAN OBAT PER TANGGAL
elseif ctabel="1007" then
%>
<%

Set trawatpasien0 = Server.CreateObject("ADODB.Recordset")
trawatpasien0.ActiveConnection = MM_datarspermata_STRING
trawatpasien0.Source = "SELECT coalesce(sum(tinputobat.jumlah),0) as jumlah0, DATE_FORMAT(tinputobat.tgltrans,'%Y-%m-%d') AS tgltrans FROM tinputobat Left Join trawatpasien ON tinputobat.notrans = trawatpasien.notrans  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%'  and tinputobat.kobat='"&ckobat&"' and tinputobat.tgltrans >= '" & dtgltrans1 & "' and tinputobat.tgltrans<='" & dtgltrans2 & "' group by tinputobat.tgltrans order by tinputobat.tgltrans"
trawatpasien0.CursorType = 0
trawatpasien0.CursorLocation = 2
trawatpasien0.LockType = 1
trawatpasien0.Open()
trawatpasien0_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(tinputobat.jumlah),0) as jumlah0, DATE_FORMAT(tinputobat.tgltrans,'%Y-%m-%d') AS tgltrans FROM tinputobat Left Join trawatpasien ON tinputobat.notrans = trawatpasien.notrans  WHERE trawatpasien.statuspasien like '%"&cstatuspasien&"%' and tinputobat.kobat='"&ckobat&"' and tinputobat.tgltrans = '" & dtgltrans1 & "' group by tinputobat.tgltrans") 

if tnourut2.EOF=true then
	ctotal0=0
else
	ctotal0=(tnourut2("jumlah0"))
end if
For i=1 to cstr(cjmltanggal)+0

	cjumlah0=0
	
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	

	While (NOT trawatpasien0.EOF)
		ctanggalanku=cstr(trawatpasien0.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah0=cjumlah0+cstr(trawatpasien0.Fields.Item("jumlah0").Value)+0
		end if
	  trawatpasien0.MoveNext()
	Wend
	If (trawatpasien0.CursorType > 0) Then
	  trawatpasien0.MoveFirst
	Else
	  trawatpasien0.Requery
	End If

	ctotal0=ctotal0 & "=;=" & (cjumlah0) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal0&"{{}}")
trawatpasien0.Close()
Set trawatpasien0 = Nothing
%>



<%
elseif ctabel="2002" then
'KUNJUNGAN PASIEN PER KELOMPOK PER BULAN
%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "select bulan,(select coalesce(count(notrans),0) from trawatpasien where month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah0,(select coalesce(count(notrans),0) from trawatpasien where  trawatpasien.kkelompok='1' and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah1,(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.kkelompok  between '2' and '3' and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah2,(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.kkelompok='4' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah3,(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.kkelompok='5' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah4,(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.kkelompok='6' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah5 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cjumlah0=""
cjumlah1=""
cjumlah2=""
cjumlah3=""
cjumlah4=""
cjumlah5=""
ctotal0=""
ctotal1=""
ctotal2=""
ctotal3=""
ctotal4=""
ctotal5=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cjumlah0  = cstr(tbulan.Fields.Item("jumlah0").Value)+0
	cjumlah1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0
	cjumlah3  = cstr(tbulan.Fields.Item("jumlah3").Value)+0
	cjumlah4  = cstr(tbulan.Fields.Item("jumlah4").Value)+0
	cjumlah5  = cstr(tbulan.Fields.Item("jumlah5").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal0   = ctotal0 & "=;=" & (cjumlah0) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 
	ctotal3   = ctotal3 & "=;=" & (cjumlah3) 
	ctotal4   = ctotal4 & "=;=" & (cjumlah4) 
	ctotal5   = ctotal5 & "=;=" & (cjumlah5) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal0=mid(trim(ctotal0),4,len(trim(ctotal0))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)
ctotal3=mid(trim(ctotal3),4,len(trim(ctotal3))-3)
ctotal4=mid(trim(ctotal4),4,len(trim(ctotal4))-3)
ctotal5=mid(trim(ctotal5),4,len(trim(ctotal5))-3)

response.Write(dbulanku1&"{{}}"&ctotal0&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}"&ctotal3&"{{}}"&ctotal4&"{{}}"&ctotal5&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>

<%
elseif ctabel="2003" then
'KUNJUNGAN RAWAT JALAN PER POLI PER BULAN
%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "select bulan, "&_
"(select coalesce(count(notrans),0) from trawatpasien where  trawatpasien.ktujuan IN ('02','04','07','21','22','23','24','26','27') and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah0, "&_
"(select coalesce(count(notrans),0) from trawatpasien where  trawatpasien.ktujuan='02' and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah1, "&_
"(select coalesce(count(notrans),0) from trawatpasien where  trawatpasien.ktujuan='04' and month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah2, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='07' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah3, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='21' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah4, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='22' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah5, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='23' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah6, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='24' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah7, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='26' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah8, "&_
"(select coalesce(count(notrans),0) from trawatpasien where trawatpasien.ktujuan='27' and  month(tglmasuk)=tbulan.kbulan and year(trawatpasien.tglmasuk)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' )  as jumlah9 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cjumlah0=""
cjumlah1=""
cjumlah2=""
cjumlah3=""
cjumlah4=""
cjumlah5=""
cjumlah6=""
cjumlah7=""
cjumlah8=""
cjumlah9=""
ctotal0=""
ctotal1=""
ctotal2=""
ctotal3=""
ctotal4=""
ctotal5=""
ctotal6=""
ctotal7=""
ctotal8=""
ctotal9=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cjumlah0  = cstr(tbulan.Fields.Item("jumlah0").Value)+0
	cjumlah1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0
	cjumlah3  = cstr(tbulan.Fields.Item("jumlah3").Value)+0
	cjumlah4  = cstr(tbulan.Fields.Item("jumlah4").Value)+0
	cjumlah5  = cstr(tbulan.Fields.Item("jumlah5").Value)+0
	cjumlah6  = cstr(tbulan.Fields.Item("jumlah6").Value)+0
	cjumlah7  = cstr(tbulan.Fields.Item("jumlah7").Value)+0
	cjumlah8  = cstr(tbulan.Fields.Item("jumlah8").Value)+0
	cjumlah9  = cstr(tbulan.Fields.Item("jumlah9").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal0   = ctotal0 & "=;=" & (cjumlah0) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 
	ctotal3   = ctotal3 & "=;=" & (cjumlah3) 
	ctotal4   = ctotal4 & "=;=" & (cjumlah4) 
	ctotal5   = ctotal5 & "=;=" & (cjumlah5) 
	ctotal6   = ctotal6 & "=;=" & (cjumlah6) 
	ctotal7   = ctotal7 & "=;=" & (cjumlah7) 
	ctotal8   = ctotal8 & "=;=" & (cjumlah8) 
	ctotal9   = ctotal9 & "=;=" & (cjumlah9) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal0=mid(trim(ctotal0),4,len(trim(ctotal0))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)
ctotal2=mid(trim(ctotal2),4,len(trim(ctotal2))-3)
ctotal3=mid(trim(ctotal3),4,len(trim(ctotal3))-3)
ctotal4=mid(trim(ctotal4),4,len(trim(ctotal4))-3)
ctotal5=mid(trim(ctotal5),4,len(trim(ctotal5))-3)
ctotal6=mid(trim(ctotal6),4,len(trim(ctotal6))-3)
ctotal7=mid(trim(ctotal7),4,len(trim(ctotal7))-3)
ctotal8=mid(trim(ctotal8),4,len(trim(ctotal8))-3)
ctotal9=mid(trim(ctotal9),4,len(trim(ctotal9))-3)

response.Write(dbulanku1&"{{}}"&ctotal0&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}"&ctotal3&"{{}}"&ctotal4&"{{}}"&ctotal5&"{{}}"&ctotal6&"{{}}"&ctotal7&"{{}}"&ctotal8&"{{}}"&ctotal9&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>



<%
elseif ctabel="2004" then
'TREND PEMAKAIAN OBAT PER BULAN
%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "select bulan, "&_
"(select coalesce(sum(tinputobat.jumlah),0)  from tinputobat  Left Join trawatpasien ON tinputobat.notrans = trawatpasien.notrans  where  month(tinputobat.tgltrans)=tbulan.kbulan and year(tinputobat.tgltrans)='"&ctahun&"'  and trawatpasien.statuspasien like '%" & cstatuspasien & "%' and tinputobat.kobat='"&ckobat&"' )  as jumlah0 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cjumlah0=""
ctotal0=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cjumlah0  = cstr(tbulan.Fields.Item("jumlah0").Value)+0

	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal0   = ctotal0 & "=;=" & (cjumlah0) 

tbulan.MoveNext()
Wend
If (tbulan.CursorType > 0) Then
  tbulan.MoveFirst
Else
  tbulan.Requery
End If

dbulanku1=mid(trim(dbulanku1),4,len(trim(dbulanku1))-3)
ctotal0=mid(trim(ctotal0),4,len(trim(ctotal0))-3)

response.Write(dbulanku1&"{{}}"&ctotal0&"{{}}")
tbulan.Close()
Set tbulan = Nothing

%>



<%
elseif ctabel="1004" then
'10 BESAR PENYAKIT PER TANGGAL
%>
<%


Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT coalesce(count(trawatpasien.notrans),0) as jumlah1 , tpenyakit.kpenyakit as kpenyakit, tpenyakit.penyakit as penyakit FROM trawatpasien Left Join tpenyakit ON trawatpasien.kpenyakit1 = tpenyakit.kpenyakit where trawatpasien.tglmasuk >= '" & dtgltrans1 & "' and trawatpasien.tglmasuk<='" & dtgltrans2 & "' and trawatpasien.statuspasien like '%" & cstatuspasien & "%' group by tpenyakit.kpenyakit  order by count(trawatpasien.notrans) desc limit 10"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()
trawatpasien_numRows = 0

dpenyakitku=""
cjumlah1=""
ctotal1=""

While (NOT trawatpasien.EOF)

	dpenyakitku  = trawatpasien.Fields.Item("penyakit").Value
	cjumlah1  = cstr(trawatpasien.Fields.Item("jumlah1").Value)+0
	dpenyakitku1 = dpenyakitku1 & "=;=" & (dpenyakitku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 

trawatpasien.MoveNext()
Wend
If (trawatpasien.CursorType > 0) Then
  trawatpasien.MoveFirst
Else
  trawatpasien.Requery
End If


dpenyakitku1=mid(trim(dpenyakitku1),4,len(trim(dpenyakitku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)

response.Write(dpenyakitku1&"{{}}"&ctotal1&"{{}}")
trawatpasien.Close()
Set trawatpasien = Nothing

%>



<%
elseif ctabel="1005" then
'10 BESAR PEMAKAIAN OBAT  PER TANGGAL
%>
<%


Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT coalesce(sum(tinputobat.jumlah),0) as jumlah1, tinputobat.obat  as obat, tinputobat.kobat  as kobat FROM tinputobat Left Join trawatpasien ON tinputobat.notrans = trawatpasien.notrans where tinputobat.tgltrans >= '" & dtgltrans1 & "' and tinputobat.tgltrans<='" & dtgltrans2 & "' and trawatpasien.statuspasien like '%" & cstatuspasien & "%' group by tinputobat.kobat  order by sum(tinputobat.jumlah) desc limit 10"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()
trawatpasien_numRows = 0

dobatku=""
cjumlah1=""
ctotal1=""

While (NOT trawatpasien.EOF)

	dobatku  = trawatpasien.Fields.Item("obat").Value
	cjumlah1  = cstr(trawatpasien.Fields.Item("jumlah1").Value)+0
	dobatku1 = dobatku1 & "=;=" & (dobatku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 

trawatpasien.MoveNext()
Wend
If (trawatpasien.CursorType > 0) Then
  trawatpasien.MoveFirst
Else
  trawatpasien.Requery
End If


dobatku1=mid(trim(dobatku1),4,len(trim(dobatku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)

response.Write(dobatku1&"{{}}"&ctotal1&"{{}}")
trawatpasien.Close()
Set trawatpasien = Nothing

%>


<%
elseif ctabel="1006" then
'10 BESAR PEMAKAIN PER GOLONGAN PER TANGGAL
%>
<%


Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT coalesce(sum(tinputobat.jumlah),0) as jumlah1, tinputobat.kgolobat  as kgolobat, tgolobat.golobat  as golobat FROM tinputobat Left Join trawatpasien ON tinputobat.notrans = trawatpasien.notrans   Left Join tgolobat ON tinputobat.kgolobat = tgolobat.kgolobat where tinputobat.tgltrans >= '" & dtgltrans1 & "' and tinputobat.tgltrans<='" & dtgltrans2 & "' and trawatpasien.statuspasien like '%" & cstatuspasien & "%' group by tinputobat.kgolobat  order by sum(tinputobat.jumlah) desc limit 10"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()
trawatpasien_numRows = 0

dgolobatku=""
cjumlah1=""
ctotal1=""

While (NOT trawatpasien.EOF)

	dgolobatku  = trawatpasien.Fields.Item("golobat").Value
	cjumlah1  = cstr(trawatpasien.Fields.Item("jumlah1").Value)+0
	dgolobatku1 = dgolobatku1 & "=;=" & (dgolobatku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 

trawatpasien.MoveNext()
Wend
If (trawatpasien.CursorType > 0) Then
  trawatpasien.MoveFirst
Else
  trawatpasien.Requery
End If


dgolobatku1=mid(trim(dgolobatku1),4,len(trim(dgolobatku1))-3)
ctotal1=mid(trim(ctotal1),4,len(trim(ctotal1))-3)

response.Write(dgolobatku1&"{{}}"&ctotal1&"{{}}")
trawatpasien.Close()
Set trawatpasien = Nothing

%>



<%
elseif ctabel="02" then
%>
<%
Set tbarangmasuk1 = Server.CreateObject("ADODB.Recordset")
tbarangmasuk1.ActiveConnection = MM_datarspermata_STRING
tbarangmasuk1.Source = "SELECT sum(tbarangmasuk1.grandtotal) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM tbarangmasuk1  WHERE tbarangmasuk1.tgltrans >= '" & dtgltrans1 & "' and tbarangmasuk1.tgltrans<='" & dtgltrans2 & "' group by tbarangmasuk1.tgltrans order by tgltrans"
tbarangmasuk1.CursorType = 0
tbarangmasuk1.CursorLocation = 2
tbarangmasuk1.LockType = 1
tbarangmasuk1.Open()
tbarangmasuk1_numRows = 0

Set tbarangkeluar1 = Server.CreateObject("ADODB.Recordset")
tbarangkeluar1.ActiveConnection = MM_datarspermata_STRING
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
elseif ctabel="05" then
%>
<%
ckbarang=request.form("ckbarang")

Set tbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
tbarangmasuk2.ActiveConnection = MM_datarspermata_STRING
tbarangmasuk2.Source = "SELECT sum(jumlah) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM vtbarangmasuk2  WHERE tgltrans >= '" & dtgltrans1 & "' and tgltrans<='" & dtgltrans2 & "'  and kbarang='" & ckbarang & "' group by tgltrans order by tgltrans"
tbarangmasuk2.CursorType = 0
tbarangmasuk2.CursorLocation = 2
tbarangmasuk2.LockType = 1
tbarangmasuk2.Open()
tbarangmasuk2_numRows = 0

Set tbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
tbarangkeluar2.ActiveConnection = MM_datarspermata_STRING
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
elseif ctabel="07" then

%>
<%


Set vtbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
vtbarangkeluar2.ActiveConnection = MM_datarspermata_STRING
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
elseif ctabel="08" then

%>
<%


Set vtbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
vtbarangkeluar2.ActiveConnection = MM_datarspermata_STRING
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
elseif ctabel="09" then

%>
<%


Set vtbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
vtbarangmasuk2.ActiveConnection = MM_datarspermata_STRING
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
vtbarangmasuk2.ActiveConnection = MM_datarspermata_STRING
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
tbulan.ActiveConnection = MM_datarspermata_STRING
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
tbulan.ActiveConnection = MM_datarspermata_STRING
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
