<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
Dim tpenyakit
Dim tpenyakit_numRows

Set tpenyakit = Server.CreateObject("ADODB.Recordset")
tpenyakit.ActiveConnection = MM_datarspermata_STRING
tpenyakit.Source = "SELECT * FROM rspermata.tpenyakit"
tpenyakit.CursorType = 0
tpenyakit.CursorLocation = 2
tpenyakit.LockType = 1
tpenyakit.Open()

tpenyakit_numRows = 0
%>
<%
Dim ttujuan
Dim ttujuan_numRows

Set ttujuan = Server.CreateObject("ADODB.Recordset")
ttujuan.ActiveConnection = MM_datarspermata_STRING
ttujuan.Source = "SELECT * FROM rspermata.ttujuan ORDER BY ktujuan ASC"
ttujuan.CursorType = 0
ttujuan.CursorLocation = 2
ttujuan.LockType = 1
ttujuan.Open()

ttujuan_numRows = 0
%>
<%
Dim tpegawai
Dim tpegawai_numRows

Set tpegawai = Server.CreateObject("ADODB.Recordset")
tpegawai.ActiveConnection = MM_datarspermata_STRING
tpegawai.Source = "SELECT * FROM rspermata.tpegawai"
tpegawai.CursorType = 0
tpegawai.CursorLocation = 2
tpegawai.LockType = 1
tpegawai.Open()

tpegawai_numRows = 0
%>


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
vtinputobatpasien.Source = "SELECT *  FROM rspermata.vtinputobatpasien  WHERE notrans = '" + Replace(vtinputobatpasien__MMColParam, "'", "''") + "'"
vtinputobatpasien.CursorType = 0
vtinputobatpasien.CursorLocation = 2
vtinputobatpasien.LockType = 1
vtinputobatpasien.Open()

vtinputobatpasien_numRows = 0
%>


<%
Dim vtinputtindakanpasien__MMColParam
vtinputtindakanpasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputtindakanpasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputtindakanpasien
Dim vtinputtindakanpasien_numRows

Set vtinputtindakanpasien = Server.CreateObject("ADODB.Recordset")
vtinputtindakanpasien.ActiveConnection = MM_datarspermata_STRING
vtinputtindakanpasien.Source = "SELECT *  FROM rspermata.vtinputtindakanpasien  WHERE kgoltindakan NOT IN ('05','11')   and notrans = '" + Replace(vtinputtindakanpasien__MMColParam, "'", "''") + "'"
vtinputtindakanpasien.CursorType = 0
vtinputtindakanpasien.CursorLocation = 2
vtinputtindakanpasien.LockType = 1
vtinputtindakanpasien.Open()

vtinputtindakanpasien_numRows = 0
%>



<%
Dim vtinputanalisasituasi__MMColParam
vtinputanalisasituasi__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputanalisasituasi__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputanalisasituasi
Dim vtinputanalisasituasi_numRows

Set vtinputanalisasituasi = Server.CreateObject("ADODB.Recordset")
vtinputanalisasituasi.ActiveConnection = MM_datarspermata_STRING
vtinputanalisasituasi.Source = "SELECT *  FROM rspermata.vtinputanalisasituasi  WHERE notrans = '" + Replace(vtinputanalisasituasi__MMColParam, "'", "''") + "'"
vtinputanalisasituasi.CursorType = 0
vtinputanalisasituasi.CursorLocation = 2
vtinputanalisasituasi.LockType = 1
vtinputanalisasituasi.Open()

vtinputanalisasituasi_numRows = 0
%>



<%
Dim vtinputvisitepasien__MMColParam
vtinputvisitepasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputvisitepasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputvisitepasien
Dim vtinputvisitepasien_numRows

Set vtinputvisitepasien = Server.CreateObject("ADODB.Recordset")
vtinputvisitepasien.ActiveConnection = MM_datarspermata_STRING
vtinputvisitepasien.Source = "SELECT *  FROM rspermata.vtinputtindakanpasien  WHERE kgoltindakan='11' and notrans = '" + Replace(vtinputvisitepasien__MMColParam, "'", "''") + "'"
vtinputvisitepasien.CursorType = 0
vtinputvisitepasien.CursorLocation = 2
vtinputvisitepasien.LockType = 1
vtinputvisitepasien.Open()

vtinputvisitepasien_numRows = 0
%>




<%
Dim trawatpasien__MMColParam
trawatpasien__MMColParam = "1"
If (Request.QueryString("cnocm") <> "") Then 
  trawatpasien__MMColParam = Request.QueryString("cnocm")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT * FROM rspermata.trawatpasien WHERE nocm = '" + Replace(trawatpasien__MMColParam, "'", "''") + "' ORDER BY tglmasuk ASC"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()

trawatpasien_numRows = 0
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Catatan Medik</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

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
	background-color: #95B4CC;
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
	  <link rel="STYLESHEET" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.css">
	<link rel="stylesheet" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
	<p>
	  <script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
	  <script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
	  <script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>	
	  <script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
	  <script>
		dhtmlx.skin = "dhx_skyblue";
	</script>
    </p>
	
<table width="100%">
  
  <tr>
    <td width="18%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Nocm</font></div></td>
    <td width="2%" align="center"><font size="2" face="Lucida Console">:</font></td>
    <td width="82%"><span class="style81"><font size="2" face="Lucida Console"><strong><%=(trawatpasien.Fields.Item("nocm").Value)%></strong> </font></span></td>
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
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
      <%
	  cnomerku=0
While (NOT trawatpasien.EOF)
cnotrans=(trawatpasien.Fields.Item("notrans").Value)
cgejala=(trawatpasien.Fields.Item("gejala").Value)
ckpenyakit1=trawatpasien.Fields.Item("kpenyakit1").Value
ckpenyakit2=(trawatpasien.Fields.Item("kpenyakit2").Value)
cnomerku=cnomerku+1
'if trim(cgejala)<>"" or trim(ckpenyakit1)<>"" or trim(ckpenyakit2)<>"" then
%>
<table width="100%">
  <tr>
    <td width="18%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Kunjungan Ke</font></div></td>
    <td width="2%" align="center"><font size="2" face="Lucida Console">:</font></td>
    <td width="82%"><span class="style81"><font size="2" face="Lucida Console"><%=cnomerku%></font></span></td>
  </tr>
  
  <tr>
    <td width="18%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Tanggal Berobat </font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%= DoDateTime((trawatpasien.Fields.Item("tglmasuk").Value), 2, 2070) %> Jam <%= formatdatetime((trawatpasien.Fields.Item("jammasuk").Value), 3) %></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Tujuan Berobat</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console">
      <%
if trawatpasien.Fields.Item("statuspasien").Value="2" Then 
	 response.Write("Rawat Inap")
	 else
	 response.Write("Rawat Jalan")
end if
%>
    </font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Anamnese</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%=(trawatpasien.Fields.Item("anamnese").Value)%></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Diagnosa 
      Penyakit Masuk</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console">
      <%
While (NOT tpenyakit.EOF)
if tpenyakit.Fields.Item("kpenyakit").Value=trawatpasien.Fields.Item("kpenyakit1").Value Then 
	 response.Write(tpenyakit.Fields.Item("penyakit").Value)
end if
  tpenyakit.MoveNext()
Wend
If (tpenyakit.CursorType > 0) Then
  tpenyakit.MoveFirst
Else
  tpenyakit.Requery
End If
%>
    </font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Diagnosa 
      Penyakit Keluar</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%=(trawatpasien.Fields.Item("kpenyakit2").Value)%> </font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Riwayat Penyakit</font></div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><span class="style81"><font size="2" face="Lucida Console"><%=(trawatpasien.Fields.Item("riwayatpenyakit").Value)%></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81">
      <div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Petugas</font></div>
    </div></td>
    <td align="center"><font size="2" face="Lucida Console">:</font></td>
    <td><font size="2" face="Lucida Console">
      <%
While (NOT tpegawai.EOF)
if tpegawai.Fields.Item("nourut").Value=trawatpasien.Fields.Item("kpegawai").Value Then 
	 response.Write(tpegawai.Fields.Item("nama").Value)
end if
  tpegawai.MoveNext()
Wend
If (tpegawai.CursorType > 0) Then
  tpegawai.MoveFirst
Else
  tpegawai.Requery
End If
%>
    </font></td>
  </tr>
</table>



<% 
	vtinputobatpasien.close
	vtinputobatpasien.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputobatpasien  WHERE notrans = '" + cnotrans + "' ORDER BY tgltrans,nourut ASC"
vtinputobatpasien.open
if not vtinputobatpasien.eof then
%>
<table width="100%">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style83
">
      <div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Obat</strong></font></div>
    </div></td>
    <td width="5%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Jumlah</strong></font></div></td>
    <td width="27%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
<%
While (NOT vtinputobatpasien.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputobatpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputobatpasien.Fields.Item("obat").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputobatpasien.Fields.Item("jumlah").Value)  %></font></div></td>
      <td bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputobatpasien.Fields.Item("ket").Value)  %></font></div></td>
    </tr>
  <% 
  vtinputobatpasien.MoveNext()
Wend
If (vtinputobatpasien.CursorType > 0) Then
 vtinputobatpasien.MoveFirst
Else
  vtinputobatpasien.Requery
End If

%>
</table>
<%
end if
%>




<% 
	vtinputtindakanpasien.close
	vtinputtindakanpasien.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputtindakanpasien  WHERE notrans = '" + cnotrans + "' and kgoltindakan NOT in ('05','11')  ORDER BY tgltrans,nourut ASC"
vtinputtindakanpasien.open
if not vtinputtindakanpasien.eof then
%>
<table width="100%">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style83
">
      <div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tindakan</strong></font></div>
    </div></td>
    <td width="32%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Hasil</strong></font></div></td>
  </tr>
<%
While (NOT vtinputtindakanpasien.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputtindakanpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputtindakanpasien.Fields.Item("tindakan").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputtindakanpasien.Fields.Item("hasil").Value)%></font></div></td>
    </tr>
  <% 
  vtinputtindakanpasien.MoveNext()
Wend
If (vtinputtindakanpasien.CursorType > 0) Then
 vtinputtindakanpasien.MoveFirst
Else
  vtinputtindakanpasien.Requery
End If

%>
</table>
<%
end if
%>




<% 
	vtinputtindakanpasien.close
	vtinputtindakanpasien.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputtindakanpasien  WHERE notrans = '" + cnotrans + "' and kgoltindakan='05' ORDER BY tgltrans,nourut ASC"
vtinputtindakanpasien.open
if not vtinputtindakanpasien.eof then
%>
<table width="100%">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style83
">
      <div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Laboratorium</strong></font></div>
    </div></td>
    <td width="32%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Hasil</strong></font></div></td>
  </tr>
<%
While (NOT vtinputtindakanpasien.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputtindakanpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputtindakanpasien.Fields.Item("tindakan").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputtindakanpasien.Fields.Item("hasil").Value)%></font></div></td>
    </tr>
  <% 
  vtinputtindakanpasien.MoveNext()
Wend
If (vtinputtindakanpasien.CursorType > 0) Then
 vtinputtindakanpasien.MoveFirst
Else
  vtinputtindakanpasien.Requery
End If

%>
</table>
<%
end if
%>




<% 
	vtinputanalisasituasi.close
	vtinputanalisasituasi.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputanalisasituasi  WHERE notrans = '" + cnotrans + "' ORDER BY tgltrans,nourut ASC"
vtinputanalisasituasi.open
if not vtinputanalisasituasi.eof then
%>
<table width="100%">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Analisa Situasi</strong></font></div></td>
    <td width="32%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Petugas</strong></font></div></td>
  </tr>
<%
While (NOT vtinputanalisasituasi.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputanalisasituasi.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputanalisasituasi.Fields.Item("analisasituasi").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputanalisasituasi.Fields.Item("petugas").Value)%></font></div></td>
    </tr>
  <% 
  vtinputanalisasituasi.MoveNext()
Wend
If (vtinputanalisasituasi.CursorType > 0) Then
 vtinputanalisasituasi.MoveFirst
Else
  vtinputanalisasituasi.Requery
End If

%>
</table>
<%
end if
%>





<% 
	vtinputvisitepasien.close
	vtinputvisitepasien.Source = "SELECT *, date_format(tgltrans, '%Y/%m/%d') as tgltrans  FROM rspermata.vtinputtindakanpasien  WHERE notrans = '" + cnotrans + "' and kgoltindakan='11' ORDER BY tgltrans,nourut ASC"
vtinputvisitepasien.open
if not vtinputvisitepasien.eof then
%>
<table width="100%">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style83
">
      <div align="center" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Pemeriksaan Dokter</strong></font></div>
    </div></td>
    <td width="32%" bgcolor="#336699"><div align="left" class="style83
"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Visite Dokter</strong></font></div></td>
  </tr>
<%
While (NOT vtinputvisitepasien.EOF)
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((vtinputvisitepasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputvisitepasien.Fields.Item("hasil").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(vtinputvisitepasien.Fields.Item("tindakan").Value) &" : "& (vtinputvisitepasien.Fields.Item("dokter").Value)%></font></div></td>
    </tr>
  <% 
  vtinputvisitepasien.MoveNext()
Wend
If (vtinputvisitepasien.CursorType > 0) Then
 vtinputvisitepasien.MoveFirst
Else
  vtinputvisitepasien.Requery
End If

%>
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
tpenyakit.Close()
Set tpenyakit = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
vtinputobatpasien.Close()
Set vtinputobatpasien = Nothing
%>

<%
vtinputtindakanpasien.Close()
Set vtinputtindakanpasien = Nothing
%>
<%
vtinputvisitepasien.Close()
Set vtinputvisitepasien = Nothing
%>


<%
vtinputanalisasituasi.Close()
Set vtinputanalisasituasi = Nothing
%>

<%
ttujuan.Close()
Set ttujuan = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
