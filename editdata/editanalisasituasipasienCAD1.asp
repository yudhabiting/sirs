<%@LANGUAGE="VBSCRIPT"%>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<!--#include file="../Connections/datarspermata.asp" -->

<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_update")) = "form1" and CStr(Request("ckondisiku")) = "2") Then

  If (Not MM_abortEdit) Then
    ' execute the delete
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputanalisasituasi WHERE notrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble

    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputanalisasituasipasien.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If

End If
%>

<%
If (CStr(Request("MM_update")) = "form1" and CStr(Request("ckondisiku")) = "1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "UPDATE rspermata.tinputanalisasituasi SET tgltrans = ?, analisasituasi = ?, kpegawai=?, shift = ? WHERE notrans = ? and nourut = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("ctgltrans"), Request.Form("ctgltrans"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, -1, Request.Form("canalisasituasi")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 6, Request.Form("ckpegawai")) ' adLongVarChar

    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 1, Request.Form("cshift")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "../inputdata/inputanalisasituasipasien.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
cnotrans=request.QueryString("cnotrans")
%>

<%
Dim tinputanalisasituasi__MMColParam
tinputanalisasituasi__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputanalisasituasi__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputanalisasituasi
Dim tinputanalisasituasi_cmd
Dim tinputanalisasituasi_numRows

Set tinputanalisasituasi_cmd = Server.CreateObject ("ADODB.Command")
tinputanalisasituasi_cmd.ActiveConnection = MM_datarspermata_STRING
tinputanalisasituasi_cmd.CommandText = "SELECT * FROM rspermata.vtinputanalisasituasi WHERE notrans = ? order by tgltrans,nourut" 
tinputanalisasituasi_cmd.Prepared = true
tinputanalisasituasi_cmd.Parameters.Append tinputanalisasituasi_cmd.CreateParameter("param1", 200, 1, 15, tinputanalisasituasi__MMColParam) ' adVarChar

Set tinputanalisasituasi = tinputanalisasituasi_cmd.Execute
tinputanalisasituasi_numRows = 0
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
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,statustransaksi FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
%>
<%
Dim tinputanalisasituasiedit__MMColParam1
tinputanalisasituasiedit__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputanalisasituasiedit__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputanalisasituasiedit__MMColParam2
tinputanalisasituasiedit__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputanalisasituasiedit__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputanalisasituasiedit
Dim tinputanalisasituasiedit_cmd
Dim tinputanalisasituasiedit_numRows

Set tinputanalisasituasiedit_cmd = Server.CreateObject ("ADODB.Command")
tinputanalisasituasiedit_cmd.ActiveConnection = MM_datarspermata_STRING
tinputanalisasituasiedit_cmd.CommandText = "SELECT * FROM rspermata.tinputanalisasituasi WHERE notrans = ? and nourut = ?" 
tinputanalisasituasiedit_cmd.Prepared = true
tinputanalisasituasiedit_cmd.Parameters.Append tinputanalisasituasiedit_cmd.CreateParameter("param1", 200, 1, 255, tinputanalisasituasiedit__MMColParam1) ' adVarChar
tinputanalisasituasiedit_cmd.Parameters.Append tinputanalisasituasiedit_cmd.CreateParameter("param2", 5, 1, -1, tinputanalisasituasiedit__MMColParam2) ' adDouble

Set tinputanalisasituasiedit = tinputanalisasituasiedit_cmd.Execute
tinputanalisasituasiedit_numRows = 0
%>
<%
Dim tpegawai__MMColParam
tpegawai__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tpegawai__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = ?" 
tpegawai_cmd.Prepared = true
tpegawai_cmd.Parameters.Append tpegawai_cmd.CreateParameter("param1", 200, 1, 6, tpegawai__MMColParam) ' adVarChar

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
Repeat1__index = 0
tinputanalisasituasi_numRows = tinputanalisasituasi_numRows + Repeat1__numRows
%>
<%
Dim MM_paramName 
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

Dim MM_keepNone
Dim MM_keepURL
Dim MM_keepForm
Dim MM_keepBoth

Dim MM_removeList
Dim MM_item
Dim MM_nextItem

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then
  MM_removeList = MM_removeList & "&" & MM_paramName & "="
End If

MM_keepURL=""
MM_keepForm=""
MM_keepBoth=""
MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each MM_item In Request.QueryString
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & MM_nextItem & Server.URLencode(Request.QueryString(MM_item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each MM_item In Request.Form
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & MM_nextItem & Server.URLencode(Request.Form(MM_item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
If (MM_keepBoth <> "") Then 
  MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
End If
If (MM_keepURL <> "")  Then
  MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
End If
If (MM_keepForm <> "") Then
  MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)
End If

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit Analisa Situasi</title>
<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />
<script language="javascript" type="text/javascript">
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

//-->
</script>
<script type="text/javascript">
<!--


function simpandata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;


if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else {
	document.forms['form1'].elements['ckondisiku'].value='1';
	document.forms['form1'].submit();
}
}


function hapusdata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;


if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else {
	document.forms['form1'].elements['ckondisiku'].value='2';
	var r=confirm("Anda yakin mau menghapus data ini!");
	if (r==true)
	  {
		document.forms['form1'].submit();
	  }
	}
}



function isValidDate(ctanggal)
{
if (ctanggal != '0000-00-00') {
//var dateStr=document.getElementById('cf06').value;
var dateStr=ctanggal;
//var datePat=/^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;
var datePat=/^(\d{2}|\d{4})(\/|-)(\d{1,2})\2(\d{1,2})$/;
var matchArray = dateStr.match(datePat); // is the format ok?
if (matchArray == null) {
alert("Isian Tanggal Salah");
return false;
}
month = matchArray[3]; // parse date into variables
day = matchArray[4];
year = matchArray[1];
if (month < 1 || month > 12) { // check month range
alert("bulan 1 sampai 12.");
return false;
}
if (day < 1 || day > 31) {
alert("Hari 1 sampai 31.");
return false;
}
if ((month==4 || month==6 || month==9 || month==11) && day==31) {
alert("Bulan "+month+" tidak nyampai 31 hari!");
return false;
}
if (month == 2) { // check for february 29th
var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
if (day>29 || (day==29 && !isleap)) {
alert("February " + year + " tidak mempunyai " + day + " hari!");
return false;
}
}
return true; // date is valid
}
return true; // date is valid
}

//-->



//-->
</script>

<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 14px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 14px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 14px; color:#0000FF}
a:link {text-decoration: none;font-size: 14px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 14px; color:#FFFFFF; }

body {
	background-color:#CCC;
	color:#000;
	font-size:15px;
}
.fontku1 {
	color:#fff;
	font-size:15px;
}

.drop_menu {
background:#369;
padding:0;
margin:0;
list-style-type:none;
height:35px;
padding-left:5px;
position:fixed;
margin-top:150px;
width:985px;
z-index: 10;
}
.drop_menu li { float:left; }
.drop_menu li a {
padding:10px 30px;
display:block;
color:#fff;
text-decoration:none;
font:15px arial, verdana, sans-serif;
}
 
/* Submenu */
.drop_menu ul {
position:absolute;
left:-9999px;
top:-9999px;
list-style-type:none;
}
.drop_menu li:hover { position:relative; background:#369; }
.drop_menu li:hover ul {
left:0px;
top:35px;
padding:0px;


    overflow:auto;
    max-height:380px;
    overflow-x:hidden;

}
 
.drop_menu li:hover ul li a {
padding:7px;
display:block;
width:250px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

-->
</style>
</head>
<body onLoad="doOnLoad();">

	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans"]);
		}
	</script>



  <link rel="STYLESHEET" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.css">
	<link rel="stylesheet" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>	
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
<script>
		dhtmlx.skin = "dhx_skyblue";
	</script>

	<!-- wraper -->
	<div id="wrapper">
		<!-- shell -->
		<div class="shell">
			<!-- container -->
			<div class="container1">
				<!-- header -->
			  <header id="header1">
					<h1 id="logo1"><a href="#"></a></h1>
			  </header>
 
<div class="drop">
<ul class="drop_menu">
<li><a href='../menuutama.asp'>Menu Utama</a></li>
<li><a href='../exit.asp'>Keluar Aplikasi</a></li>

<li>
<a href='#'>Pendaftaran  Pasien</a>
<ul>
<li><a href="../master/masterpasien.asp" >Input Pasien</a></li>
<li><a href="../daftar/caripasien.asp" >Cari Pasien</a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=1" >Daftar Tunggu Rawat Jalan</a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=2" >Daftar Tunggu Rawat Inap</a></li>
<li><a href="../daftar/daftarpasienmondok.asp">Daftar Pasien Mondok</a></li>
</ul>
</li>

<li>
<a href='#'>Transaksi  Pasien</a>
<ul>
<li><a href="editrawatpasien.asp?cnotrans=<%=cnotrans%>" >Rawat Pasien</a></li>
<li><a href="../inputdata/inputkelaspasien.asp?citem=1&cnotrans=<%=cnotrans%>" >Ruangan Pasien</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=11&ckgoltindakan=11&cnotrans=<%=cnotrans%>" >Visite Dokter</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=2&ckgoltindakan=01&cnotrans=<%=cnotrans%>" >Tindakan IGD</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=3&ckgoltindakan=02&cnotrans=<%=cnotrans%>" >Tindakan Keperawatan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=4&ckgoltindakan=03&cnotrans=<%=cnotrans%>" >Tindakan Medis</a></li>
<li><a href="../inputdata/inputlaboratpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>" >Pemeriksaan Laboratorium</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=6&ckgoltindakan=10&cnotrans=<%=cnotrans%>" >Pemeriksaan Radiologi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=7&ckgoltindakan=09&cnotrans=<%=cnotrans%>" >Pemeriksaan Fisioterapi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=8&ckgoltindakan=08&cnotrans=<%=cnotrans%>" >Tindakan Persalinan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=10&ckgoltindakan=07&cnotrans=<%=cnotrans%>" >Tindakan Gigi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=13&ckgoltindakan=12&cnotrans=<%=cnotrans%>" >Pelayanan Gizi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=12&ckgoltindakan=06&cnotrans=<%=cnotrans%>" >Tindakan Operasi</a></li>
<li><a href="../inputdata/inputanalisasituasipasien.asp?citem=15&cnotrans=<%=cnotrans%>">Analisa Situasi</a></li>
<li><a href="../daftar/daftarpemberianobatpasien.asp?citem=9&cnotrans=<%=cnotrans%>" target="_blank">Daftar Pemberian Obat</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=16&ckgoltindakan=13&cnotrans=<%=cnotrans%>" >Tindakan Non Medis</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=17&ckgoltindakan=14&cnotrans=<%=cnotrans%>" >Potongan Pasien</a></li>
<li><a href="../inputdata/inputpembayaranpasien.asp?citem=14&cnotrans=<%=cnotrans%>">Pembayaran Pasien</a></li>
<li><a href="../inputdata/rincianbeayapasien.asp?cnotrans=<%=cnotrans%>" target="_blank">Rincian Pembiayaan Pasien</a></li>
</ul>
</li>

<li>
<a href='#'>Daftar Tindakan Pasien</a>
<ul>
<li><a href="../daftar/daftartindakanpasien2.asp?citem=<%=citem%>&ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cstatuspasien=<%=cstatuspasien%>">Cari Input Tindakan</a></li>
<li><a href="../daftar/daftartindakanpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>&cstatuspasien=<%=cstatuspasien%>">Cari Input Laboratorium</a></li>
<li><a href="../inputdata/cetaktindakanpasien.asp?citem=<%=citem%>&ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>" target="_blank" >Rekam Medik Perkunjungan</a></li>
<li><a href='../daftar/rekammedik.asp?cnocm=<%=(trawatpasien.Fields.Item("nocm").Value)%>' target='_blank'>Rekam Medik Semua Kunjungan</a></li>
</ul>
</li>


</ul>
</div>      
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

    


		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
<table width="100%" class="fontku1">
              <tr>
                <td width="16%" class="style4"><span class="style3">Notrans</span></td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%" class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">NoCM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputanalisasituasiedit.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Analisa Situasi</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="canalisasituasi" id="canalisasituasi" cols="70" rows="3"><%=(tinputanalisasituasiedit.Fields.Item("analisasituasi").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Petugas</span></td>
                <td><div align="center">:</div></td>
                <td>
      <select name="ckpegawai" id="ckpegawai">
        <option value="" <%If (Not isNull(Session("MM_userid"))) Then If ("" = CStr(Session("MM_userid"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
        <%
While (NOT tpegawai.EOF)
%>
        <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull(Session("MM_userid"))) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr(Session("MM_userid"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
        <%
  tpegawai.MoveNext()
Wend
If (tpegawai.CursorType > 0) Then
  tpegawai.MoveFirst
Else
  tpegawai.Requery
End If
%>
      </select>
                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Shift</span></td>
                <td><div align="center">:</div></td>
                <td><select name="cshift" id="cshift">
                  <option value="1" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("1" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pagi</option>
                  <option value="2" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("2" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Siang</option>
                  <option value="3" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("3" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Malam</option>
                </select></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong><strong>

<%
if cstatustransaksi<>"T" then
%>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>              
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="hapusdata()"/>
<%
end if
%>                  

                  
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(tinputanalisasituasiedit.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputanalisasituasiedit.Fields.Item("nourut").Value)%>" />
                
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                </strong></strong></strong></td>
                </tr>
            </table>
            <input type="hidden" name="MM_insert" value="form1" />
            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputanalisasituasiedit.Fields.Item("notrans").Value %>" />
          </form>
		    <div  id="gridanalisasituasi">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" align="left">Asuhan Kebidanan</td>
		          <td width="70px" align="left">Shit </td>
		          <td width="250px" align="left">Petugas</td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputanalisasituasi.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(tinputanalisasituasi.Fields.Item("tgltrans").Value)%></td>
		          <td height="22"><a href="editanalisasituasipasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & tinputanalisasituasi.Fields.Item("notrans").Value & "&cnourut=" & tinputanalisasituasi.Fields.Item("nourut").Value %>"><%=(tinputanalisasituasi.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(tinputanalisasituasi.Fields.Item("analisasituasi").Value)%></td>
		          <td><%
				  if (tinputanalisasituasi.Fields.Item("shift").Value)="1" then
				  	response.Write("Pagi")
				  elseif (tinputanalisasituasi.Fields.Item("shift").Value)="2" then
				  	response.Write("Siang")
				  else
				  	response.Write("Malam")
				  end if
				  %>
                  </td>
		          <td><%=(tinputanalisasituasi.Fields.Item("petugas").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputanalisasituasi.MoveNext()
Wend
%>
	          </table>
		    </div>
    	  <div class="cleaner"></div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

			  <div id="footer"><!-- end of footer-cols -->
					<div class="footer-bottom">
				    <p class="copy">&copy; Copyright 2017 -  Kalboya@yahoo.com</p>
						<div class="cl">&nbsp;</div>
					</div>
			  </div>


			</div>
		</div>
	</div>
</body>
</html>
<%
tinputanalisasituasi.Close()
Set tinputanalisasituasi = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tinputanalisasituasiedit.Close()
Set tinputanalisasituasiedit = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
