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

dtgltrans1="2017-01-01"
dtgltrans2="2017-02-01"
ctahun=request.form("ctahun")
ckbarang=request.form("ckbarang")
cksuplierbarang=request.form("cksuplierbarang")

set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 
cjmltanggal=(tnourut2("jumlahtanggal"))
dtanggalanku1= (dtgltrans1) 
  
%>
<%
ckobat="adada"
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

