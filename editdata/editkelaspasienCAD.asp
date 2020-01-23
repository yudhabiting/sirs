<%@LANGUAGE="VBSCRIPT"%>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>

<%
cnotrans=request.QueryString("cnotrans")
citem=request.QueryString("citem")

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
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputkelas WHERE notrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    Set tnourut1 = Server.CreateObject("ADODB.connection")
    tnourut1.open = MM_datarspermata_STRING
    set tnourut2=tnourut1.execute ("update trawatpasien set totalruangan=(select sum(tarif) from tinputkelas where notrans='"&Request.QueryString("cnotrans")&"') where notrans='"&Request.QueryString("cnotrans")&"'") 
    set tnourut2=tnourut1.execute ("update trawatpasien set total = (coalesce(totaltindakan,0)+coalesce(totalobat,0)+coalesce(totalruangan,0)+coalesce(totalvisite,0)+coalesce(administrasi,0)-coalesce(totalpotongan,0)) where notrans='"&Request.QueryString("cnotrans")&"'") 
  

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputkelaspasien.asp"
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
    MM_editCmd.CommandText = "UPDATE rspermata.tinputkelas SET tglmasuk = ?, kkelas = ?, ket = ?, tarif = ?, tglkeluar = ?, jamkeluar = ?, jmlhari = ? WHERE notrans = ? and nourut = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("ctglmasuk"), Request.Form("ctglmasuk"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 2, Request.Form("ckkelas")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 50, Request.Form("cket")) ' adLongVarChar
     MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 5, 1, -1, MM_IIF(Request.Form("ctarif"), Request.Form("ctarif"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 135, 1, -1, MM_IIF(Request.Form("ctglkeluar"), Request.Form("ctglkeluar"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 135, 1, -1, MM_IIF(Request.Form("cjamkeluar"), Request.Form("cjamkeluar"), null)) ' adDBTimeStamp
     MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 5, 1, -1, MM_IIF(Request.Form("cjmlhari"), Request.Form("cjmlhari"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
	
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("update trawatpasien set tglkeluar='"&Request.form("ctglkeluar")&"', kkelas='"&Request.form("ckkelas")&"' where notrans='"&Request.QueryString("cnotrans")&"'") 
  set tnourut2=tnourut1.execute ("update trawatpasien set totalruangan=(select sum(tarif) from tinputkelas where notrans='"&Request.QueryString("cnotrans")&"') where notrans='"&Request.QueryString("cnotrans")&"'") 
  set tnourut2=tnourut1.execute ("update trawatpasien set total = (coalesce(totaltindakan,0)+coalesce(totalobat,0)+coalesce(totalruangan,0)+coalesce(totalvisite,0)+coalesce(administrasi,0)-coalesce(totalpotongan,0)) where notrans='"&Request.QueryString("cnotrans")&"'") 
	
  End If
End If
%>
<%
Dim vtinputkelaspasien__MMColParam
vtinputkelaspasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputkelaspasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputkelaspasien
Dim vtinputkelaspasien_cmd
Dim vtinputkelaspasien_numRows

Set vtinputkelaspasien_cmd = Server.CreateObject ("ADODB.Command")
vtinputkelaspasien_cmd.ActiveConnection = MM_datarspermata_STRING
vtinputkelaspasien_cmd.CommandText = "SELECT * FROM rspermata.vtinputkelaspasien WHERE notrans = ? order by tglmasuk,nourut" 
vtinputkelaspasien_cmd.Prepared = true
vtinputkelaspasien_cmd.Parameters.Append vtinputkelaspasien_cmd.CreateParameter("param1", 200, 1, 15, vtinputkelaspasien__MMColParam) ' adVarChar

Set vtinputkelaspasien = vtinputkelaspasien_cmd.Execute
vtinputkelaspasien_numRows = 0
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
Dim tkelas
Dim tkelas_cmd
Dim tkelas_numRows

Set tkelas_cmd = Server.CreateObject ("ADODB.Command")
tkelas_cmd.ActiveConnection = MM_datarspermata_STRING
tkelas_cmd.CommandText = "SELECT * FROM rspermata.tkelas order by kelas" 
tkelas_cmd.Prepared = true

Set tkelas = tkelas_cmd.Execute
tkelas_numRows = 0
%>
<%
cdaftartarif=""
While (NOT tkelas.EOF)
  cdaftartarif=cdaftartarif&" "&"kode"&(tkelas.Fields.Item("kkelas").Value)&(tkelas.Fields.Item("tarif").Value)
  tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%>

<%
Dim tinputkelaspasien__MMColParam
tinputkelaspasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputkelaspasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputkelaspasien__MMColParam2
tinputkelaspasien__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputkelaspasien__MMColParam2 = Request.QueryString("cnourut")
End If
%>

<%
Dim tinputkelaspasien
Dim tinputkelaspasien_cmd
Dim tinputkelaspasien_numRows

Set tinputkelaspasien_cmd = Server.CreateObject ("ADODB.Command")
tinputkelaspasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputkelaspasien_cmd.CommandText = "SELECT * FROM rspermata.tinputkelas WHERE notrans = ? and nourut = ?" 
tinputkelaspasien_cmd.Prepared = true
tinputkelaspasien_cmd.Parameters.Append tinputkelaspasien_cmd.CreateParameter("param1", 200, 1, 15, tinputkelaspasien__MMColParam) ' adVarChar
tinputkelaspasien_cmd.Parameters.Append tinputkelaspasien_cmd.CreateParameter("param2", 5, 1, -1, tinputkelaspasien__MMColParam2) ' adDouble

Set tinputkelaspasien = tinputkelaspasien_cmd.Execute
tinputkelaspasien_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
vtinputkelaspasien_numRows = vtinputkelaspasien_numRows + Repeat1__numRows
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
<title>Edit Ruangan Pasien</title>
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

function hitungtgl() {
var ctanggal1 = document.forms['form1'].elements['ctglmasuk'].value;
var ctanggal2 = document.forms['form1'].elements['ctglkeluar'].value;
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
if (ctanggal2 == '') {
	alert("tgl keluar kosong");
}
else if (ckkelas=='') {
	alert("ruangan keluar kosong");
	}
else {
	var day=1000*60*60*24;
	var today = new Date(ctanggal1);
	var date = new Date(ctanggal2);
	if (date<today ) 
		{
		alert("tanggal keluar lebih kecil dari pada tanggal masuk");	
		}
	else {
		cjmlhari=Math.ceil((date.getTime()-today.getTime())/(day));
		cjmlhari=cjmlhari+1
		tarifku(document.forms['form1'].elements['ckkelas'].value)
		var ctarif = document.forms['form1'].elements['ctarif'].value;
		document.forms['form1'].elements['cjmlhari'].value=cjmlhari;
		document.forms['form1'].elements['ctarif'].value=cjmlhari*ctarif;
		}
	}
}
function tarifku(cktindakan)
{
	var txt1='<%=(cdaftartarif)%>';
	spl = txt1.split(" ");
	var txt2="kode"+cktindakan;
	for(i = 0; i < spl.length; i++)
	{
		var kodetindakan=spl[i].toString();
		var kodetindakan=kodetindakan.substring(0,6);
		if (kodetindakan==txt2) {
			var panjang=spl[i].length;
			var jmltarif=spl[i].substring(6,panjang);
			document.forms['form1'].elements['ctarif'].value=jmltarif;
			
		}
	}
}

function hapusdata()
{
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;


if (ckkelas == '') {
alert("kelas kosong, mohon dicek")
document.forms['form1'].elements['ckkelas'].focus();
return false;
}
else if (cnourut == '') {
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


function simpandata()
{
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctglmasuk'].value;
var ctanggal2 = document.forms['form1'].elements['ctglkeluar'].value;
var cjmlhari = document.forms['form1'].elements['cjmlhari'].value;


if (ckkelas == '') {
alert("kelas kosong, mohon dicek")
document.forms['form1'].elements['ckkelas'].focus();
return false;
}
else if (ctarif == '') {
alert("tarif kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
else if (cjmlhari == '') {
alert("jumlah hari kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctglmasuk'].focus();
		return false
	}

else {
	document.forms['form1'].elements['ckondisiku'].value='1';
	document.forms['form1'].submit();
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
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk", "ctglkeluar"]);
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
                <td width="2%" >&nbsp;</td>
                <td width="12%" >Notrans</td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%" ><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Nourut</td>
                <td><div align="center">:</div></td>
                <td class="style6"><%=(tinputkelaspasien.Fields.Item("nourut").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >NoCM</td>
                <td><div align="center">:</div></td>
                <td ><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Nama</td>
                <td><div align="center">:</div></td>
                <td ><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Alamat</td>
                <td><div align="center">:</div></td>
                <td ><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Umur</td>
                <td><div align="center">:</div></td>
                <td ><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Tanggal Masuk</td>
                <td><div align="center">:</div></td>
                <td>
                <input name="ctglmasuk" type="text" id="ctglmasuk" value="<%= DoDateTime((tinputkelaspasien.Fields.Item("tglmasuk").Value), 2, 7177) %>" size="12" maxlength="10" />
                </td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Tanggal Keluar</td>
                <td><div align="center">:</div></td>
                <td>
                  <input name="ctglkeluar" type="text" id="ctglkeluar" value="<%= DoDateTime((tinputkelaspasien.Fields.Item("tglkeluar").Value), 2, 7177) %>" size="12" maxlength="10"/>
                  Jam Keluar :
                <input name="cjamkeluar" type="text" id="cjamkeluar" value="<%=(tinputkelaspasien.Fields.Item("jamkeluar").Value)%>" size="10"/>
                </td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Jml Hari</td>
                <td><div align="center">:</div></td>
                <td><input name="cjmlhari" type="text" id="cjmlhari" value="<%=(tinputkelaspasien.Fields.Item("jmlhari").Value)%>" size="5" /></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >kelas</td>
                <td><div align="center">:</div></td>
                <td>
                <select name="ckkelas" id="ckkelas" onChange="tarifku(this.value)">
                  <option value="" <%If (Not isNull((tinputkelaspasien.Fields.Item("kkelas").Value))) Then If ("" = CStr((tinputkelaspasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tkelas.EOF)
%>
                  <option value="<%=(tkelas.Fields.Item("kkelas").Value)%>" <%If (Not isNull((tinputkelaspasien.Fields.Item("kkelas").Value))) Then If (CStr(tkelas.Fields.Item("kkelas").Value) = CStr((tinputkelaspasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelas.Fields.Item("kelas").Value)%></option>
                  <%
  tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%>
                </select>
                </td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Keterangan </td>
                <td><div align="center">:</div></td>
                <td><input name="cket" type="text" id="cket" value="<%=(tinputkelaspasien.Fields.Item("ket").Value)%>" size="80" maxlength="80" /></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Tarif</td>
                <td><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputkelaspasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>

<%
if cstatustransaksi<>"T" then
%>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="hapusdata()"/>
<%
end if
%>                  

                  
                  <input type="button" name="hitung" id="hitung" value="hitung tarif" onclick="hitungtgl()" />
                 
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputkelaspasien.Fields.Item("nourut").Value)%>" />
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                </td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
		    <div  id="gridkelas">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal Masuk</td>
		          <td width="100px" align="center">Tanggal Keluar</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="200px" align="left">Ruangan</td>
		          <td width="100px" align="right">Tarif</td>
		          <td width="*" align="center">ket </td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputkelaspasien.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(vtinputkelaspasien.Fields.Item("tglmasuk").Value)%></td>
		          <td><%=(vtinputkelaspasien.Fields.Item("tglkeluar").Value)%></td>
		          <td height="22"><a href="../editdata/editkelaspasien.asp?citem=<%=citem%>&<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputkelaspasien.Fields.Item("notrans").Value & "&cnourut=" & vtinputkelaspasien.Fields.Item("nourut").Value %>"><%=(vtinputkelaspasien.Fields.Item("nourut").Value)%></a></td>
		          <td><%
While (NOT tkelas.EOF)
if (tkelas.Fields.Item("kkelas").Value)=(vtinputkelaspasien.Fields.Item("kkelas").Value) then
	response.Write(tkelas.Fields.Item("kelas").Value)
end if
  tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%></td>
		          <td><%=(vtinputkelaspasien.Fields.Item("tarif").Value)%></td>
		          <td><%=(vtinputkelaspasien.Fields.Item("ket").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputkelaspasien.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputkelaspasien.Fields.Item("notrans").Value %>" />
          </form>
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
vtinputkelaspasien.Close()
Set vtinputkelaspasien = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
tinputkelaspasien.Close()
Set tinputkelaspasien = Nothing
%>
