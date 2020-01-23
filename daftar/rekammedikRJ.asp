<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/datarumahsakit.asp" -->
<!--#include file="../Connections/dataapotik.asp" -->
<!--#include file="../Connections/datalaboratorium.asp" -->
<%
Dim tpenyakit
Dim tpenyakit_numRows

Set tpenyakit = Server.CreateObject("ADODB.Recordset")
tpenyakit.ActiveConnection = MM_datarumahsakit_STRING
tpenyakit.Source = "SELECT * FROM rumahsakit.tpenyakit ORDER BY penyakit ASC"
tpenyakit.CursorType = 0
tpenyakit.CursorLocation = 2
tpenyakit.LockType = 1
tpenyakit.Open()

tpenyakit_numRows = 0
%>
<%
Dim tpasienrj__MMColParam
tpasienrj__MMColParam = "1"
If (Request.QueryString("cnocm") <> "") Then 
  tpasienrj__MMColParam = Request.QueryString("cnocm")
End If
%>
<%
Dim tpasienrj
Dim tpasienrj_numRows

Set tpasienrj = Server.CreateObject("ADODB.Recordset")
tpasienrj.ActiveConnection = MM_datarumahsakit_STRING
tpasienrj.Source = "SELECT * FROM rumahsakit.tpasienrj WHERE nocm = '" + Replace(tpasienrj__MMColParam, "'", "''") + "' ORDER BY tgltrans ASC"
tpasienrj.CursorType = 0
tpasienrj.CursorLocation = 2
tpasienrj.LockType = 1
tpasienrj.Open()

tpasienrj_numRows = 0
%>
<%
Dim tpegawai__MMColParam
tpegawai__MMColParam = "02"
If (Request("MM_EmptyValue") <> "") Then 
  tpegawai__MMColParam = Request("MM_EmptyValue")
End If
%>
<%
Dim tpegawai
Dim tpegawai_numRows

Set tpegawai = Server.CreateObject("ADODB.Recordset")
tpegawai.ActiveConnection = MM_datarumahsakit_STRING
tpegawai.Source = "SELECT nourut, nip, nama FROM rumahsakit.tpegawai WHERE bagian = '" + Replace(tpegawai__MMColParam, "'", "''") + "' ORDER BY nama ASC"
tpegawai.CursorType = 0
tpegawai.CursorLocation = 2
tpegawai.LockType = 1
tpegawai.Open()

tpegawai_numRows = 0
%>
<%
Dim ttind_ugd
Dim ttind_ugd_numRows

Set ttind_ugd = Server.CreateObject("ADODB.Recordset")
ttind_ugd.ActiveConnection = MM_datarumahsakit_STRING
ttind_ugd.Source = "SELECT * FROM rumahsakit.ttind_ugd ORDER BY tindakan ASC"
ttind_ugd.CursorType = 0
ttind_ugd.CursorLocation = 2
ttind_ugd.LockType = 1
ttind_ugd.Open()

ttind_ugd_numRows = 0
%>
<%
Dim trjugd
Dim trjugd_numRows

Set trjugd = Server.CreateObject("ADODB.Recordset")
trjugd.ActiveConnection = MM_datarumahsakit_STRING
trjugd.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket, tindakan  FROM rumahsakit.trjugd  WHERE notrans = '" + Replace(tpasienrj__MMColParam, "'", "''") + "'  ORDER BY tgltrans,nourut ASC"
trjugd.CursorType = 0
trjugd.CursorLocation = 2
trjugd.LockType = 1
trjugd.Open()

trjugd_numRows = 0
%>
<%
Dim ttind_keperawatan
Dim ttind_keperawatan_numRows

Set ttind_keperawatan = Server.CreateObject("ADODB.Recordset")
ttind_keperawatan.ActiveConnection = MM_datarumahsakit_STRING
ttind_keperawatan.Source = "SELECT * FROM rumahsakit.ttind_keperawatan ORDER BY tindakan ASC"
ttind_keperawatan.CursorType = 0
ttind_keperawatan.CursorLocation = 2
ttind_keperawatan.LockType = 1
ttind_keperawatan.Open()

ttind_keperawatan_numRows = 0
%>
<%
Dim trjmedis
Dim trjmedis_numRows

Set trjmedis = Server.CreateObject("ADODB.Recordset")
trjmedis.ActiveConnection = MM_datarumahsakit_STRING
trjmedis.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, tindakan, tarif, ket, kpegawai, nama  FROM rumahsakit.trjmedis  WHERE notrans = '" + Replace(tpasienrj__MMColParam, "'", "''") + "'  ORDER BY tgltrans,nourut ASC"
trjmedis.CursorType = 0
trjmedis.CursorLocation = 2
trjmedis.LockType = 1
trjmedis.Open()

trjmedis_numRows = 0
%>
<%
Dim ttind_pp
Dim ttind_pp_numRows

Set ttind_pp = Server.CreateObject("ADODB.Recordset")
ttind_pp.ActiveConnection = MM_datarumahsakit_STRING
ttind_pp.Source = "SELECT * FROM rumahsakit.ttind_pp ORDER BY tindakan ASC"
ttind_pp.CursorType = 0
ttind_pp.CursorLocation = 2
ttind_pp.LockType = 1
ttind_pp.Open()

ttind_pp_numRows = 0
%>
<%
Dim trjpp
Dim trjpp_numRows

Set trjpp = Server.CreateObject("ADODB.Recordset")
trjpp.ActiveConnection = MM_datarumahsakit_STRING
trjpp.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket,hasil, tindakan  FROM rumahsakit.trjpp  WHERE notrans = '" + Replace(tpasienrj__MMColParam, "'", "''") + "'  and ktindakan<>'005' ORDER BY tgltrans,nourut ASC"
trjpp.CursorType = 0
trjpp.CursorLocation = 2
trjpp.LockType = 1
trjpp.Open()

trjpp_numRows = 0
%>
<%
Dim tkeluarobat1
Dim tkeluarobat1_numRows

Set tkeluarobat1 = Server.CreateObject("ADODB.Recordset")
tkeluarobat1.ActiveConnection = MM_dataapotik_STRING
'tkeluarobat.Source = "SELECT *,date_format(tglkeluar, '%d/%m/%Y') as tglkeluar,coalesce(potongan,0) as potongan,coalesce(btindakan,0) as btindakan,coalesce(sum(total),0) as total,coalesce(totalbayar,0) as totalbayar  FROM apotik.tkeluarobat  WHERE knotrans = '" + Replace(tkeluarobat__MMColParam, "'", "''") + "' group by total"
tkeluarobat1.Source = "SELECT notrans,date_format(tglkeluar, '%Y/%m/%d') as tglkeluar FROM apotik.tkeluarobat  WHERE knotrans = '" + Replace(tpasienrj__MMColParam, "'", "''") + "'"
tkeluarobat1.CursorType = 0
tkeluarobat1.CursorLocation = 2
tkeluarobat1.LockType = 1
tkeluarobat1.Open()
tkeluarobat1_numRows = 0
%>
<%
Dim titemkeluarobat__MMColParam
titemkeluarobat__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  titemkeluarobat__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim titemkeluarobat
Dim titemkeluarobat_numRows

Set titemkeluarobat = Server.CreateObject("ADODB.Recordset")
titemkeluarobat.ActiveConnection = MM_dataapotik_STRING
titemkeluarobat.Source = "SELECT notrans FROM apotik.titemkeluarobat WHERE notrans = '" + Replace(titemkeluarobat__MMColParam, "'", "''") + "'"
titemkeluarobat.CursorType = 0
titemkeluarobat.CursorLocation = 2
titemkeluarobat.LockType = 1
titemkeluarobat.Open()

titemkeluarobat_numRows = 0
%>

<%
Dim tinputlaborat1__MMColParam
tinputlaborat1__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputlaborat1__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputlaborat11
Dim tinputlaborat11_numRows

Set tinputlaborat11 = Server.CreateObject("ADODB.Recordset")
tinputlaborat11.ActiveConnection = MM_datalaboratorium_STRING
tinputlaborat11.Source = "SELECT date_format(tgltrans, '%d/%m/%Y') as tgltrans,notrans  FROM laboratorium.tinputlaborat1  WHERE knotrans = '" + Replace(tinputlaborat1__MMColParam, "'", "''") + "'"
tinputlaborat11.CursorType = 0
tinputlaborat11.CursorLocation = 2
tinputlaborat11.LockType = 1
tinputlaborat11.Open()
tinputlaborat11_numRows = 0
%>
<%
Dim tinputlaborat2__MMColParam
tinputlaborat2__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputlaborat2__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputlaborat2
Dim tinputlaborat2_numRows

Set tinputlaborat2 = Server.CreateObject("ADODB.Recordset")
tinputlaborat2.ActiveConnection = MM_datalaboratorium_STRING
tinputlaborat2.Source = "SELECT notrans  FROM laboratorium.tinputlaborat2  WHERE notrans = '" + Replace(tinputlaborat2__MMColParam, "'", "''") + "'"
tinputlaborat2.CursorType = 0
tinputlaborat2.CursorLocation = 2
tinputlaborat2.LockType = 1
tinputlaborat2.Open()

tinputlaborat2_numRows = 0
%>
<%
Dim trontgenpasien
Dim trontgenpasien_numRows

Set trontgenpasien = Server.CreateObject("ADODB.Recordset")
trontgenpasien.ActiveConnection = MM_datarumahsakit_STRING
trontgenpasien.Source = "SELECT tgltrans, jenispemeriksaan, hasil, anjuran,kpemeriksaan FROM rumahsakit.trontgenpasien WHERE knotrans = '" + Replace(tinputlaborat2__MMColParam, "'", "''") + "' and ktujuan<>13"
trontgenpasien.CursorType = 0
trontgenpasien.CursorLocation = 2
trontgenpasien.LockType = 1
trontgenpasien.Open()

trontgenpasien_numRows = 0
%>
<%
Dim tgolongan
Dim tgolongan_numRows

Set tgolongan = Server.CreateObject("ADODB.Recordset")
tgolongan.ActiveConnection = MM_datalaboratorium_STRING
tgolongan.Source = "SELECT * FROM laboratorium.tgollab ORDER BY kgolongan ASC"
tgolongan.CursorType = 0
tgolongan.CursorLocation = 2
tgolongan.LockType = 1
tgolongan.Open()

tgolongan_numRows = 0
%>
<%
Dim ttindlab1
Dim ttindlab1_numRows

Set ttindlab1 = Server.CreateObject("ADODB.Recordset")
ttindlab1.ActiveConnection = MM_datalaboratorium_STRING
ttindlab1.Source = "SELECT KLABORATORIUM, SATUAN, NORMAL FROM laboratorium.ttindlab"
ttindlab1.CursorType = 0
ttindlab1.CursorLocation = 2
ttindlab1.LockType = 1
ttindlab1.Open()

ttindlab1_numRows = 0
%>
<%
Dim ttujuan
Dim ttujuan_numRows

Set ttujuan = Server.CreateObject("ADODB.Recordset")
ttujuan.ActiveConnection = MM_datarumahsakit_STRING
ttujuan.Source = "SELECT * FROM rumahsakit.ttujuan ORDER BY ktujuan ASC"
ttujuan.CursorType = 0
ttujuan.CursorLocation = 2
ttujuan.LockType = 1
ttujuan.Open()

ttujuan_numRows = 0
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = -1
Repeat2__index = 0
trjugd_numRows = trjugd_numRows + Repeat2__numRows
%>
<%
Dim Repeat3__numRows
Dim Repeat3__index

Repeat3__numRows = -1
Repeat3__index = 0
trjmedis_numRows = trjmedis_numRows + Repeat3__numRows
%>
<%
Dim Repeat4__numRows
Dim Repeat4__index

Repeat4__numRows = -1
Repeat4__index = 0
trjpp_numRows = trjpp_numRows + Repeat4__numRows
%>
<%
Dim Repeat6__numRows
Dim Repeat6__index

Repeat6__numRows = -1
Repeat6__index = 0
tkeluarobat6_numRows = tkeluarobat6_numRows + Repeat6__numRows
%>

<%
Dim Repeat7__numRows
Dim Repeat7__index

Repeat7__numRows = -1
Repeat7__index = 0
trontgentpsien7_numRows = trontgentpsien7_numRows + Repeat7__numRows
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
.style81 {color: #FFFFFF; }
.style82 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; }
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
    <td width="30%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Nocm</font></div></td>
    <td width="70%"><span class="style81"><font size="2" face="Lucida Console">:  <strong><%=(tpasienrj.Fields.Item("nocm").Value)%></strong> </font></span></td>
  </tr>
  
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Nama</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: <strong><%=(tpasienrj.Fields.Item("nama").Value)%></strong></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Alamat</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console"> : <%=(tpasienrj.Fields.Item("alamat").Value)%></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Umur </font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: <%=(tpasienrj.Fields.Item("umurthn").Value)%> tahun / <%=(tpasienrj.Fields.Item("umurbln").Value)%> bulan / <%=(tpasienrj.Fields.Item("umurhr").Value)%> hari</font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Jenis 
      Kelamin</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">:
      <%
if tpasienrj.Fields.Item("jeniskel").Value ="L"  Then
	response.Write("Laki-laki")
else
	response.Write("Perempuan")
end if 
%>
    </font></span></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
      <%
	  cnomerku=0
While (NOT tpasienrj.EOF)
cnotrans=(tpasienrj.Fields.Item("notrans").Value)
cgejala=(tpasienrj.Fields.Item("gejala").Value)
ckpenyakit1=tpasienrj.Fields.Item("kpenyakit1").Value
ckpenyakit2=(tpasienrj.Fields.Item("kpenyakit2").Value)
cnomerku=cnomerku+1
'if trim(cgejala)<>"" or trim(ckpenyakit1)<>"" or trim(ckpenyakit2)<>"" then
%>
<table width="100%">
  <tr>
    <td width="30%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">No</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: <%=cnomerku%></font></span></td>
  </tr>
  
  <tr>
    <td width="24%" align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Tanggal Berobat </font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: <%= DoDateTime((tpasienrj.Fields.Item("tgltrans").Value), 2, 2070) %></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Gejala 
      yang dirasakan</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: <%=(tpasienrj.Fields.Item("gejala").Value)%></font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Diagnosa 
      Penyakit Masuk</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">:
      <%
While (NOT tpenyakit.EOF)
if tpenyakit.Fields.Item("kpenyakit").Value=tpasienrj.Fields.Item("kpenyakit1").Value Then 
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
    <td><span class="style81"><font size="2" face="Lucida Console">: <%=(tpasienrj.Fields.Item("kpenyakit2").Value)%> </font></span></td>
  </tr>
  <tr>
    <td align="center"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif">Poli</font></div></td>
    <td><span class="style81"><font size="2" face="Lucida Console">: </font> <font size="2" face="Lucida Console">
      <%
While (NOT ttujuan.EOF)
if ttujuan.Fields.Item("ktujuan").Value=tpasienrj.Fields.Item("ktujuan").Value Then 
	 response.Write(ttujuan.Fields.Item("tujuan").Value)
end if
  ttujuan.MoveNext()
Wend
If (ttujuan.CursorType > 0) Then
  ttujuan.MoveFirst
Else
  ttujuan.Requery
End If
%>
    </font></span></td>
  </tr>
</table>







<% 
  tkeluarobat1.close
  tkeluarobat1.Source = "SELECT notrans,date_format(tglkeluar, '%Y/%m/%d') as tglkeluar FROM apotik.tkeluarobat  WHERE knotrans = '" + cnotrans + "' and ktujuan='01'"
  tkeluarobat1.open

if not tkeluarobat1.eof then
%>
<table width="100%" border="1">
  <tr>
    <td width="*" bgcolor="#336699"><div align="center" class="style33 style50 style70 style16">
      <div align="left">
        <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><strong> Tanggal</strong></font></div>
      </div>
    </div></td>
    <td width="*" bgcolor="#336699"><div align="center" class="style59 style70 style16 style40 style41">
      <div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Obat</strong></font></div>
    </div></td>
    <td width="*" bgcolor="#336699"><div align="center" class="style50 style70 style16 style81">
      <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><strong> Jumlah Biji </strong></font></div>
    </div></td>
  </tr>
  <tr>
    <td colspan="3"></td>
  </tr>
<%
While ((Repeat6__numRows <> 0) AND (NOT tkeluarobat1.EOF)) 
	 titemkeluarobat.close
	 titemkeluarobat.Source = " select titemkeluarobat.kobat,titemkeluarobat.kgolobat,titemkeluarobat.jmlbiji,titemkeluarobat.subtotal,tmasterobat.namaobat From titemkeluarobat Inner Join tmasterobat ON titemkeluarobat.kobat = tmasterobat.kobat  WHERE  titemkeluarobat.notrans='"&(tkeluarobat1.Fields.Item("notrans").Value)&"'"
	 titemkeluarobat.open
	 While (NOT titemkeluarobat.EOF)
	 %>
  <tr>
    <td bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((tkeluarobat1.Fields.Item("tglkeluar").Value), 2, 1030) %> </font></div></td>
    <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(titemkeluarobat.Fields.Item("namaobat").Value)%></font></div></td>
    <td bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= FormatNumber((titemkeluarobat.Fields.Item("jmlbiji").Value), 0, -2, -2, -1) %></font></div></td>
  </tr>
  <%
	  titemkeluarobat.MoveNext()
	  Wend
	  If (titemkeluarobat.CursorType > 0) Then
		titemkeluarobat.MoveFirst
	  Else
		 titemkeluarobat.Requery
	  End If
	  	
	Repeat6__index=Repeat6__index+1
	Repeat6__numRows=Repeat6__numRows-1
	tkeluarobat1.MoveNext()
Wend

%>
  <tr>
    <td colspan="3"></td>
  </tr>
</table>
<%
end if
%>
    <% 
	trjugd.close
	trjugd.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket, tindakan  FROM rumahsakit.trjugd  WHERE notrans = '" + cnotrans + "'  ORDER BY tgltrans,nourut ASC"
	trjugd.open
if not trjugd.eof then
%>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style81"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Tindakan 
    </strong></font><strong><font size="2" face="Arial, Helvetica, sans-serif">Ugd</font></strong></div></td>
    <td width="32%" bgcolor="#336699"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
<%
While ((Repeat2__numRows <> 0) AND (NOT trjugd.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((trjugd.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjugd.Fields.Item("tindakan").Value)%></font></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjugd.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat2__index=Repeat2__index+1
  Repeat2__numRows=Repeat2__numRows-1
  trjugd.MoveNext()
Wend
%>
</table>
<%
end if
%>
    <% 
	trjmedis.close
	trjmedis.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, tindakan, tarif, ket, kpegawai, nama  FROM rumahsakit.trjmedis  WHERE notrans = '" + cnotrans + "'  ORDER BY tgltrans,nourut ASC"
	trjmedis.open
if not trjmedis.eof then
%>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style81"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Tanggal</font></strong></font></div></td>
    <td width="50%" bgcolor="#336699"><div align="left" class="style81"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Tindakan 
    Medis</font></strong></font></div></td>
    <td width="32%" bgcolor="#336699"><div align="left" class="style81"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
<%
While ((Repeat3__numRows <> 0) AND (NOT trjmedis.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((trjmedis.Fields.Item("tgltrans").Value), 2, 2070) %> </font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjmedis.Fields.Item("tindakan").Value)%> Dokter : <%=(trjmedis.Fields.Item("nama").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjmedis.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat3__index=Repeat3__index+1
  Repeat3__numRows=Repeat3__numRows-1
  trjmedis.MoveNext()
Wend
%>
</table>
<%
end if
%>
  <% 
  tinputlaborat11.close
  tinputlaborat11.Source = "SELECT date_format(tgltrans, '%d/%m/%Y') as tgltrans,notrans  FROM laboratorium.tinputlaborat1  WHERE knotrans = '" + cnotrans + "'"
  tinputlaborat11.open
if not tinputlaborat11.eof then
%>
<table width="100%" border="1">
  <tr>
    <td width="15%" bgcolor="#336699"><div align="center" class="style70 style16 style78 style81">
      <div align="left">
        <div align="center"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Tanggal</font></strong></font></div>
      </div>
    </div></td>
    <td bgcolor="#336699"><div align="center" class="style82">
      <div align="left"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Golongan</font></strong></font></div>
    </div></td>
    <td bgcolor="#336699"><div align="center" class="style70 style78 style16 style81">
      <div align="left"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Laboratorium</font></strong></font></div>
    </div></td>
    <td bgcolor="#336699"><div align="center" class="style87 style70 style41 style16 style81">
      <div align="center"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Hasil</font></strong></font></div>
    </div></td>
    <td bgcolor="#336699"><div align="center" class="style87 style70 style41 style16 style81">
      <div align="center"><font face="Arial, Helvetica, sans-serif"><strong><font size="2">Normal</font></strong></font></div>
    </div></td>
  </tr>
<%
While ((Repeat1__numRows <> 0) AND (NOT tinputlaborat11.EOF)) 
	 tinputlaborat2.close
tinputlaborat2.Source = "SELECT tinputlaborat2.notrans,tinputlaborat2.nourut,tinputlaborat2.klaboratorium,tinputlaborat2.kgolongan,tinputlaborat2.hasil,ttindlab.laboratorium  FROM tinputlaborat2 Inner Join ttindlab ON tinputlaborat2.klaboratorium = ttindlab.klaboratorium  WHERE tinputlaborat2.notrans = '"&(tinputlaborat11.Fields.Item("notrans").Value)&"'  ORDER BY nourut"
	 
	 tinputlaborat2.open
	 While (NOT tinputlaborat2.EOF)
	 %>
  <tr>
    <td bgcolor="#FFFFFF"><div align="right" class="style61 style67 style70">
      <div align="center" class="style40"><%= DoDateTime((tinputlaborat11.Fields.Item("tgltrans").Value), 2, 1030) %></div>
    </div></td>
    <td bgcolor="#FFFFFF"><div align="left" class="style70 style16 style37"><span class="style20 style16 style40">
      <%
While (NOT tgolongan.EOF)
if tgolongan.Fields.Item("kgolongan").Value=tinputlaborat2.Fields.Item("kgolongan").Value Then 
	response.Write(tgolongan.Fields.Item("golongan").Value)
end if
  tgolongan.MoveNext()
Wend
If (tgolongan.CursorType > 0) Then
  tgolongan.MoveFirst
Else
  tgolongan.Requery
End If
%>
    </span></div></td>
    <td bgcolor="#FFFFFF"><span class="style70 style31 style16 style40"><%=trim(tinputlaborat2.Fields.Item("laboratorium").Value) %></span></td>
    <td bgcolor="#FFFFFF"><div align="center" class="style62"><span class="style31 "><%=trim(tinputlaborat2.Fields.Item("hasil").Value) %> <span class="style20">
      <%
While (NOT ttindlab1.EOF)
if ttindlab1.Fields.Item("klaboratorium").Value=tinputlaborat2.Fields.Item("klaboratorium").Value Then 
	csatuan=ttindlab1.Fields.Item("satuan").Value
	cnormal=ttindlab1.Fields.Item("normal").Value
end if
  ttindlab1.MoveNext()
Wend
If (ttindlab1.CursorType > 0) Then
 ttindlab1.MoveFirst
Else
  ttindlab1.Requery
End If
%>
    </span></span><span class="style20 style31 style37 "><%=csatuan %></span></div></td>
    <td bgcolor="#FFFFFF"><div align="center" class="style16 style70 style40"><span class="style16 style20 style31 style37"><%=cnormal %></span></div></td>
  </tr>
  <%
	  tinputlaborat2.MoveNext()
	  Wend
	  If (tinputlaborat2.CursorType > 0) Then
		tinputlaborat2.MoveFirst
	  Else
		 tinputlaborat2.Requery
	  End If
	  	
	Repeat1__index=Repeat1__index+1
	Repeat1__numRows=Repeat1__numRows-1
	tinputlaborat11.MoveNext()
Wend

%>
  <tr>
    <td colspan="5"></td>
  </tr>
</table>
<%
end if
%>
    <% 
trjpp.close	
trjpp.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket,hasil, tindakan  FROM rumahsakit.trjpp  WHERE notrans = '" + cnotrans + "'  and ktindakan<>'005' ORDER BY tgltrans,nourut ASC"
trjpp.open 
if not trjpp.eof then
%>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#336699"><div align="center" class="style81"><strong><font face="Arial, Helvetica, sans-serif"><font size="2">Tanggal</font></font></strong></div></td>
    <td bgcolor="#336699"><div align="left" class="style81"><strong><font face="Arial, Helvetica, sans-serif"><font size="2">      Pemeriksaan Penunjang</font></font></strong></div></td>
    <td bgcolor="#336699"><div align="left" class="style81"><strong><font size="2" face="Arial, Helvetica, sans-serif">Keterangan</font></strong></div></td>
    <td bgcolor="#336699"><div align="left" class="style81"><strong><font size="2" face="Arial, Helvetica, sans-serif">Hasil Pembacaan </font></strong></div></td>
  </tr>
<%
While ((Repeat4__numRows <> 0) AND (NOT trjpp.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((trjpp.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjpp.Fields.Item("tindakan").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjpp.Fields.Item("ket").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="justify"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trjpp.Fields.Item("hasil").Value)%></font></div></td>
    </tr>
    <% 
  Repeat4__index=Repeat4__index+1
  Repeat4__numRows=Repeat4__numRows-1
  trjpp.MoveNext()
Wend
%>
    <% 
trontgenpasien.close
trontgenpasien.Source = "SELECT tgltrans, jenispemeriksaan, hasil, anjuran,kpemeriksaan FROM rumahsakit.trontgenpasien WHERE knotrans = '" + Replace(tinputlaborat2__MMColParam, "'", "''") + "' and ktujuan<>13"
trontgenpasien.open
	
While ((Repeat7__numRows <> 0) AND (NOT trontgenpasien.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((trontgenpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79"><font face="Arial, Helvetica, sans-serif">
	  <% 
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="1" then 
			response.Write("Rontgen")
	  end if
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="2" then 
			response.Write("USG")
	  end if
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="3" then 
			response.Write("CT - Scan")
	  end if
	  %>
      </font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79"><font face="Arial, Helvetica, sans-serif"><%=(trontgenpasien.Fields.Item("jenispemeriksaan").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79">
        <div align="justify"><font face="Arial, Helvetica, sans-serif"><%=(trontgenpasien.Fields.Item("hasil").Value)%></font></div>
      </div></td>
    </tr>
    <% 
  Repeat7__index=Repeat7__index+1
  Repeat7__numRows=Repeat7__numRows-1
  trontgenpasien.MoveNext()
Wend
%>
</table>
<%
end if
%>


<%
'end if
%>

<p>
  <%
  tpasienrj.MoveNext()
Wend
If (tpasienrj.CursorType > 0) Then
  tpasienrj.MoveFirst
Else
  tpasienrj.Requery
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
tpasienrj.Close()
Set tpasienrj = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
ttind_ugd.Close()
Set ttind_ugd = Nothing
%>
<%
trjugd.Close()
Set trjugd = Nothing
%>
<%
ttind_keperawatan.Close()
Set ttind_keperawatan = Nothing
%>
<%
trjmedis.Close()
Set trjmedis = Nothing
%>
<%
ttind_pp.Close()
Set ttind_pp = Nothing
%>
<%
trjpp.Close()
Set trjpp = Nothing
%>
<%
tkeluarobat1.Close()
Set tkeluarobat = Nothing
%>
<%
titemkeluarobat.Close()
Set titemkeluarobat = Nothing
%>
<%
tinputlaborat11.Close()
Set tinputlaborat1 = Nothing
%>
<%
tinputlaborat2.Close()
Set tinputlaborat2 = Nothing
%>
<%
tgolongan.Close()
Set tgolongan = Nothing
%>
<%
ttindlab1.Close()
Set ttindlab1 = Nothing
%>
<%
ttujuan.Close()
Set ttujuan = Nothing
%>
<%
trontgenpasien.Close()
Set trontgenpasien = Nothing
%>
