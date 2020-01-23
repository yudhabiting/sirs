<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../../Connections/datarspermata.asp" -->
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
ckbarang=request.form("ckbarang")
ctahun=request.form("ctahun")

set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 
cjmltanggal=(tnourut2("jumlahtanggal"))
dtanggalanku1= (dtgltrans1) 
  
%>
<%
if ctabel="5" then
%>
<%
Set vtbarangmasuk2 = Server.CreateObject("ADODB.Recordset")
vtbarangmasuk2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangmasuk2.Source = "SELECT sum(vtbarangmasuk2.jumlah) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM vtbarangmasuk2  WHERE vtbarangmasuk2.tgltrans >= '" & dtgltrans1 & "' and vtbarangmasuk2.tgltrans<='" & dtgltrans2 & "' and vtbarangmasuk2.kbarang='" & ckbarang & "' group by vtbarangmasuk2.tgltrans order by tgltrans"
vtbarangmasuk2.CursorType = 0
vtbarangmasuk2.CursorLocation = 2
vtbarangmasuk2.LockType = 1
vtbarangmasuk2.Open()
vtbarangmasuk2_numRows = 0

Set vtbarangkeluar2 = Server.CreateObject("ADODB.Recordset")
vtbarangkeluar2.ActiveConnection = MM_datatokonusantara_STRING
vtbarangkeluar2.Source = "SELECT sum(vtbarangkeluar2.jumlah) as jumlah, DATE_FORMAT(tgltrans,'%Y-%m-%d') AS tgltrans FROM vtbarangkeluar2  WHERE vtbarangkeluar2.tgltrans >= '" & dtgltrans1 & "' and vtbarangkeluar2.tgltrans<='" & dtgltrans2 & "' and vtbarangkeluar2.kbarang='" & ckbarang & "' group by vtbarangkeluar2.tgltrans order by tgltrans"
vtbarangkeluar2.CursorType = 0
vtbarangkeluar2.CursorLocation = 2
vtbarangkeluar2.LockType = 1
vtbarangkeluar2.Open()
vtbarangkeluar2_numRows = 0

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(vtbarangmasuk2.jumlah),0) as jumlah1 FROM vtbarangmasuk2  WHERE vtbarangmasuk2.tgltrans = '" & dtgltrans1 & "' and vtbarangmasuk2.kbarang='" & ckbarang & "'") 
ctotal1=(tnourut2("jumlah1"))

set tnourut2=tnourut1.execute ("SELECT coalesce(sum(vtbarangkeluar2.jumlah),0) as jumlah2 FROM vtbarangkeluar2  WHERE vtbarangkeluar2.tgltrans = '" & dtgltrans1 & "' and vtbarangkeluar2.kbarang='" & ckbarang & "'") 
ctotal2=(tnourut2("jumlah2"))

For i=1 to cstr(cjmltanggal)+0

	cjumlah1=0
	cjumlah2=0
	dtanggalanku = DateAdd("d", i, dtgltrans1)
	dtanggalanku=DoDateTime((dtanggalanku), 2, 1042)
	dtanggalanku1=dtanggalanku1 & "=;=" & (dtanggalanku) 
	
	While (NOT vtbarangmasuk2.EOF)
		ctanggalanku=cstr(vtbarangmasuk2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah1=cjumlah1+cstr(vtbarangmasuk2.Fields.Item("jumlah").Value)+0
		end if
	  vtbarangmasuk2.MoveNext()
	Wend
	If (vtbarangmasuk2.CursorType > 0) Then
	  vtbarangmasuk2.MoveFirst
	Else
	  vtbarangmasuk2.Requery
	End If


	While (NOT vtbarangkeluar2.EOF)
		ctanggalanku=cstr(vtbarangkeluar2.Fields.Item("tgltrans").Value)
		if dtanggalanku=ctanggalanku then
			cjumlah2=cjumlah2+cstr(vtbarangkeluar2.Fields.Item("jumlah").Value)+0
		end if
	  vtbarangkeluar2.MoveNext()
	Wend
	If (vtbarangkeluar2.CursorType > 0) Then
	  vtbarangkeluar2.MoveFirst
	Else
	  vtbarangkeluar2.Requery
	End If
		
	ctotal1=ctotal1 & "=;=" & (cjumlah1) 
	ctotal2=ctotal2 & "=;=" & (cjumlah2) 
Next 

dtanggalanku2=dtanggalanku1
response.Write(dtanggalanku2&"{{}}"&ctotal1&"{{}}"&ctotal2&"{{}}")
	
vtbarangmasuk2.Close()
Set vtbarangmasuk2 = Nothing
vtbarangkeluar2.Close()
Set vtbarangkeluar2 = Nothing
%>
<%
elseif ctabel="6" then

%>
<%

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datatokonusantara_STRING
tbulan.Source = "select bulan,(select coalesce(sum(jumlah),0) from vtbarangmasuk2 where month(tgltrans)=tbulan.kbulan and year(vtbarangmasuk2.tgltrans)='"&ctahun&"')  as jumlah1,(select coalesce(sum(jumlah),0) from vtbarangkeluar2 where month(tgltrans)=tbulan.kbulan and year(vtbarangkeluar2.tgltrans)='"&ctahun&"')  as jumlah2 from tbulan "
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

dbulanku=""
cjumlah1=""
cjumlah2=""
ctotal1=""
ctotal2=""

While (NOT tbulan.EOF)

	dbulanku  = tbulan.Fields.Item("bulan").Value
	cjumlah1  = cstr(tbulan.Fields.Item("jumlah1").Value)+0
	cjumlah2  = cstr(tbulan.Fields.Item("jumlah2").Value)+0


	dbulanku1 = dbulanku1 & "=;=" & (dbulanku) 
	ctotal1   = ctotal1 & "=;=" & (cjumlah1) 
	ctotal2   = ctotal2 & "=;=" & (cjumlah2) 

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
