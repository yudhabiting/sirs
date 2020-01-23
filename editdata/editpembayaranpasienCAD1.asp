<%@LANGUAGE="VBSCRIPT"%>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="edp" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="administrasi" then
elseif lcase(trim(Session("MM_statususer")))="keuangan" then
elseif lcase(trim(Session("MM_statususer")))="frontoffice" then
else 
	Response.Redirect("../tolak.asp") 
end if
%>


<!--#include file="../Connections/datarspermata.asp" -->
<%
cnotrans=request.QueryString("cnotrans")
Set tnourut1 = Server.CreateObject("ADODB.connection")
tnourut1.open = MM_datarspermata_STRING

%>

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
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputpembayaran WHERE notrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble

    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
  set tnourut2=tnourut1.execute ("update trawatpasien set lunas=(if(total-(select sum(bayar)  from tinputpembayaran where notrans='"&Request.form("cnotrans")&"')<=0,'L','B')) where notrans='"&Request.QueryString("cnotrans")&"'") 
  set tnourut2=tnourut1.execute ("update trawatpasien set totalbayar=(select sum(bayar) from tinputpembayaran where notrans=trawatpasien.notrans) where notrans='"&Request.QueryString("cnotrans")&"'") 

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputpembayaranpasien.asp"
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
    MM_editCmd.CommandText = "UPDATE rspermata.tinputpembayaran SET tgltrans = ?, bayar = ?, sisa = ?, ket = ? WHERE notrans = ? and nourut=?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("ctgltrans"), Request.Form("ctgltrans"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cbayar"), Request.Form("cbayar"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 5, 1, -1, MM_IIF(Request.Form("csisa"), Request.Form("csisa"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 70, Request.Form("cket")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
	if Request.Form("clunas")="L" then
  set tnourut2=tnourut1.execute ("update trawatpasien set lunas='L' where notrans='"&Request.form("cnotrans")&"'") 
  else
  set tnourut2=tnourut1.execute ("update trawatpasien set lunas='B' where notrans='"&Request.form("cnotrans")&"'") 
  end if
  set tnourut2=tnourut1.execute ("update trawatpasien set totalbayar=(select sum(bayar) from tinputpembayaran where notrans=trawatpasien.notrans) where notrans='"&Request.QueryString("cnotrans")&"'") 

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "../inputdata/inputpembayaranpasien.asp"
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
Dim tinputpembayaran__MMColParam
tinputpembayaran__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputpembayaran__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputpembayaran
Dim tinputpembayaran_cmd
Dim tinputpembayaran_numRows

Set tinputpembayaran_cmd = Server.CreateObject ("ADODB.Command")
tinputpembayaran_cmd.ActiveConnection = MM_datarspermata_STRING
tinputpembayaran_cmd.CommandText = "SELECT * FROM rspermata.tinputpembayaran WHERE notrans = ? order by tgltrans,nourut" 
tinputpembayaran_cmd.Prepared = true
tinputpembayaran_cmd.Parameters.Append tinputpembayaran_cmd.CreateParameter("param1", 200, 1, 15, tinputpembayaran__MMColParam) ' adVarChar

Set tinputpembayaran = tinputpembayaran_cmd.Execute
tinputpembayaran_numRows = 0
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
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,total FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
Dim tinputpembayaranedit__MMColParam1
tinputpembayaranedit__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputpembayaranedit__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputpembayaranedit__MMColParam2
tinputpembayaranedit__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputpembayaranedit__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputpembayaranedit
Dim tinputpembayaranedit_cmd
Dim tinputpembayaranedit_numRows

Set tinputpembayaranedit_cmd = Server.CreateObject ("ADODB.Command")
tinputpembayaranedit_cmd.ActiveConnection = MM_datarspermata_STRING
tinputpembayaranedit_cmd.CommandText = "SELECT * FROM rspermata.tinputpembayaran WHERE notrans = ? and nourut = ?" 
tinputpembayaranedit_cmd.Prepared = true
tinputpembayaranedit_cmd.Parameters.Append tinputpembayaranedit_cmd.CreateParameter("param1", 200, 1, 255, tinputpembayaranedit__MMColParam1) ' adVarChar
tinputpembayaranedit_cmd.Parameters.Append tinputpembayaranedit_cmd.CreateParameter("param2", 5, 1, -1, tinputpembayaranedit__MMColParam2) ' adDouble

Set tinputpembayaranedit = tinputpembayaranedit_cmd.Execute
tinputpembayaranedit_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
Repeat1__index = 0
tinputpembayaran_numRows = tinputpembayaran_numRows + Repeat1__numRows
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
<title>Edit Pembayaran</title>
<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />
<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcommon.js"></script>
<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.js"></script>
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
function hitungsisa()
{
var csisa1 = document.forms['form1'].elements['csisa1'].value;
var csisa = document.forms['form1'].elements['csisa'].value;
var cbayar = document.forms['form1'].elements['cbayar'].value;
var cbayar1 = document.forms['form1'].elements['cbayar1'].value;
document.forms['form1'].elements['csisa'].value=parseInt(csisa1)+parseInt(cbayar1)-parseInt(cbayar);
	var csisa=document.forms['form1'].elements['csisa'].value;
	if (csisa<=0) {
	document.forms['form1'].elements['clunas'].value='L';
	}
	else {
	document.forms['form1'].elements['clunas'].value='B';
	}
}

function hapusdata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;
var csisa1 = document.forms['form1'].elements['csisa1'].value;
var csisa = document.forms['form1'].elements['csisa'].value;
var cbayar = document.forms['form1'].elements['cbayar'].value;
var cbayar1 = document.forms['form1'].elements['cbayar1'].value;

if (cbayar == '') {
alert("bayar kosong, mohon dicek")
document.forms['form1'].elements['cbayar'].focus();
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
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;
var csisa1 = document.forms['form1'].elements['csisa1'].value;
var csisa = document.forms['form1'].elements['csisa'].value;
var cbayar = document.forms['form1'].elements['cbayar'].value;
var cbayar1 = document.forms['form1'].elements['cbayar1'].value;

if (cbayar == '') {
alert("bayar kosong, mohon dicek")
document.forms['form1'].elements['cbayar'].focus();
return false;
}

else if (csisa == '') {
alert("sisa / hutang kosong, mohon dicek")
document.forms['form1'].elements['csisa'].focus();
return false;
}

else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else {
document.forms['form1'].elements['csisa'].value=parseInt(csisa1)+parseInt(cbayar1)-parseInt(cbayar);
	var csisa=document.forms['form1'].elements['csisa'].value;
	if (csisa<=0) {
	document.forms['form1'].elements['clunas'].value='L';
	}
	else {
	document.forms['form1'].elements['clunas'].value='B';
	}
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

.style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style4 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-weight:bold;
	color: #fff;
}
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
<li><a href="../inputdata/kuitansipasien.asp?cnotrans=<%=cnotrans%>&cnourut=<%=(tinputpembayaranedit.Fields.Item("nourut").Value)%>" target="_blank">Kuitansi Pasien</a></li>

</ul>
</li></ul>
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
                <td width="1%" class="style4">&nbsp;</td>
                <td width="14%" class="style4"><span class="style3">Notrans</span></td>
                <td width="1%"><div align="center">:</div></td>
                <td width="83%" class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">NoCM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputpembayaranedit.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Bayar</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cbayar" type="text" id="cbayar" value="<%=(tinputpembayaranedit.Fields.Item("bayar").Value)%>" size="15" onblur="hitungsisa(this.value)"/></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Sisa</span></td>
                <td><div align="center">:</div></td>
                <td><input name="csisa" type="text" id="csisa" value="<%=(tinputpembayaranedit.Fields.Item("sisa").Value)%>" size="15" readonly="readonly"/></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Keterangan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cket" cols="70" rows="1" id="cket"><%=(tinputpembayaranedit.Fields.Item("ket").Value)%></textarea></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong><strong><strong>
                  <strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>
                  </strong></strong>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="hapusdata()"/>
                </strong></strong>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                <span class="style4">
                <input name="clunas" type="hidden" id="clunas" value="<%=(tinputpembayaranedit.Fields.Item("lunas").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputpembayaranedit.Fields.Item("nourut").Value)%>" />
                <input name="csisa1" type="hidden" id="csisa1" value="<%=(tinputpembayaranedit.Fields.Item("sisa").Value)%>" />
                <input name="cbayar1" type="hidden" id="cbayar1" value="<%=(tinputpembayaranedit.Fields.Item("bayar").Value)%>" />
                </span><strong><strong>
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                </strong></strong></strong></strong></td>
              </tr>
            </table>
            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputpembayaranedit.Fields.Item("notrans").Value %>" />
          </form>
           
		    <div  id="gridpembayaran">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" align="left">Keterangan</td>
		          <td width="*" align="left">Pembayar</td>
		          <td width="150px" align="right">Bayar</td>
		          <td width="100" align="right">Kekurangan / Sisa</td>
		          <td width="100px" align="center">Status </td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputpembayaran.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(tinputpembayaran.Fields.Item("tgltrans").Value)%></td>
		          <td height="22"><a href="editpembayaranpasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & tinputpembayaran.Fields.Item("notrans").Value & "&cnourut=" & tinputpembayaran.Fields.Item("nourut").Value %>"><%=(tinputpembayaran.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(tinputpembayaran.Fields.Item("ket").Value)%></td>
		          <td><%=(tinputpembayaran.Fields.Item("pembayar").Value)%></td>
		          <td><%= FormatNumber(tinputpembayaran.Fields.Item("bayar").Value, 2, -2, -2, -1) %></td>
		          <td><%= FormatNumber(tinputpembayaran.Fields.Item("sisa").Value, 2, -2, -2, -1) %></td>
		          <td><span class="style3">
		            <%
				if (tinputpembayaran.Fields.Item("lunas").Value)="L" then
					response.Write("Lunas")
				else
					response.Write("Belum Lunas")
				end if
				%>
		          </span></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputpembayaran.MoveNext()
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
tinputpembayaran.Close()
Set tinputpembayaran = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tinputpembayaranedit.Close()
Set tinputpembayaranedit = Nothing
%>
