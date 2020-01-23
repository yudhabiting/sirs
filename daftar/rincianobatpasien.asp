<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../Connections/datarspermata.asp" -->

<%
Dim vtinputobatpasien__MMColParam
vtinputobatpasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputobatpasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputobatpasien
Dim vtinputobatpasien_numRows

Set vtinputobatpasien = Server.CreateObject("ADODB.Recordset")
vtinputobatpasien.ActiveConnection = MM_datarspermata_STRING
vtinputobatpasien.Source = "SELECT *  FROM rspermata.tinputobat  WHERE notrans = '" + Replace(vtinputobatpasien__MMColParam, "'", "''") + "'"
vtinputobatpasien.CursorType = 0
vtinputobatpasien.CursorLocation = 2
vtinputobatpasien.LockType = 1
vtinputobatpasien.Open()

vtinputobatpasien_numRows = 0
%>



<%
Dim trawatpasien__MMColParam
trawatpasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  trawatpasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT * FROM rspermata.trawatpasien WHERE notrans = '" + Replace(trawatpasien__MMColParam, "'", "''") + "' ORDER BY tglmasuk ASC"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()

trawatpasien_numRows = 0
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Rincian Obat Pasien</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
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

<style type="text/css">
<!--
.style16 {font-family: Arial, Helvetica, sans-serif}
.style33 {font-family: "Lucida Sans"; font-size: 9px; color: #FFFFFF;}
.style50 {	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 12px;
}
.style40 {font-size: 12px}
.style41 {
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.style37 {color: #000000}
.style59 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #FFFFFF; font-weight: bold; }
.style61 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000; }
.style62 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style67 {font-size: 10px}
.style78 {color: #000000; font-weight: bold; font-family: Arial, Helvetica, sans-serif;}
.style79 {font-size: 14px}
body {
}
.style81 {color: #000; }
.style82 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; }
.style83 {color: #FFFFFF; }
.style84 {color: #000; font-size:20px; }
.style44 {color: #437CD8}
.style45 {	color: #6F7A9F;
	font-weight: bold;
}
.style46 {	font-family: Arial, Helvetica, sans-serif;
	color: #0000FF;
}
-->
</style>
</head>

<body>
<table width="100%">
  
  <tr>
    <td colspan="3" align="center"><div align="CENTER" class="style81"><font size="2" face="Arial, Helvetica, sans-serif" class="style84">RINCIAN OBAT PASIEN</font></div></td>
  </tr>
  <tr>
    <td width="10%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Nocm</font></div></td>
    <td width="2%" align="center"><font size="2" face="Lucida Console">:</font></td>
    <td width="88%"><span class="style81"><font size="2" face="Lucida Console"><strong><%=(trawatpasien.Fields.Item("nocm").Value)%></strong> </font></span></td>
  </tr>
  
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Nama</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><font size="2" face="Lucida Console"><span class="style84"><strong><%=(trawatpasien.Fields.Item("nama").Value)%></strong></span></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Alamat</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%=(trawatpasien.Fields.Item("alamat").Value)%></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Umur </font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%=(trawatpasien.Fields.Item("umurthn").Value)%> tahun / <%=(trawatpasien.Fields.Item("umurbln").Value)%> bulan / <%=(trawatpasien.Fields.Item("umurhr").Value)%> hari</font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Jenis 
      Kelamin</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console">
      <%
if trawatpasien.Fields.Item("jeniskel").Value ="L"  Then
	response.Write("Laki-laki")
else
	response.Write("Perempuan")
end if 
%>
    </font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Tanggal Masuk </font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%= DoDateTime((trawatpasien.Fields.Item("tglmasuk").Value), 2, 2070) %> Jam <%= formatdatetime((trawatpasien.Fields.Item("jammasuk").Value), 3) %></font></span></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
      <%
	  cnomerku=0
While (NOT trawatpasien.EOF)
cnotrans=(trawatpasien.Fields.Item("notrans").Value)
cnomerku=cnomerku+1
%>
<% 
	vtinputobatpasien.close
	vtinputobatpasien.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputobatpasien  WHERE notrans = '" + cnotrans + "' ORDER BY tgltrans,nourut ASC"
vtinputobatpasien.open
if not vtinputobatpasien.eof then
%>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="10%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style83
">
      <div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Obat</strong></font></div>
    </div></td>
    <td width="5%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Jumlah</strong></font></div></td>
    <td width="5%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Harga</strong></font></div></td>
    <td width="5%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Total</strong></font></div></td>
  </tr>
<%
ctotal=0
While (NOT vtinputobatpasien.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputobatpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputobatpasien.Fields.Item("obat").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputobatpasien.Fields.Item("jumlah").Value)  %></font></div></td>
      <td align="right" bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%= FormatNumber((vtinputobatpasien.Fields.Item("tarif").Value), 0, -2, -2, -1)   %></font></td>
      <td align="right" bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%= FormatNumber((vtinputobatpasien.Fields.Item("subtotal").Value), 0, -2, -2, -1)   %></font></td>
    </tr>
  <% 
  ctotal=ctotal+(vtinputobatpasien.Fields.Item("subtotal").Value)+0
  vtinputobatpasien.MoveNext()
Wend
If (vtinputobatpasien.CursorType > 0) Then
 vtinputobatpasien.MoveFirst
Else
  vtinputobatpasien.Requery
End If

%>
    <tr>
      <td height="23" colspan="4" align="center" bgcolor="#FFFFFF">Total</td>
      <td align="right" bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%= FormatNumber((ctotal), 0, -2, -2, -1)   %></font></td>
    </tr>

</table>
<%
end if
%>





<p>
  <%
  trawatpasien.MoveNext()
Wend
If (trawatpasien.CursorType > 0) Then
  trawatpasien.MoveFirst
Else
  trawatpasien.Requery
End If

%>
</p>
<p>&nbsp;</p>
</body>
</html>

<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
vtinputobatpasien.Close()
Set vtinputobatpasien = Nothing
%>

