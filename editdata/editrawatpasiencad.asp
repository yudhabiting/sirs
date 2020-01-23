<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
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
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "UPDATE rspermata.trawatpasien SET statuspasien = ?, ktujuan = ?, kkelas = ?, nopas = ?, noasuransi = ?, tglmasuk = ?, tglkeluar = ?, nama = ?, alamat = ?, kkecamatan = ?, kkelurahan = ?, umurthn = ?, umurbln = ?, umurhr = ?, jeniskel = ?, orangtua = ?, kkelompok = ?, kunjungan = ?, tinggibadan = ?, beratbadan = ?, gejala = ?, kasus = ?, kpenyakit1 = ?, kpenyakit2 = ?, kodeinadrg = ?, terapi = ?, kpegawai = ?, keluar = ?, carakeluar = ?, karcis = ?, krumahsakit = ?, nocm = ?, nik = ?, pekerjaan = ?, telp = ?, riwayatpenyakit = ? WHERE notrans = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 201, 1, 1, Request.Form("cstatuspasien")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 2, Request.Form("cktujuan")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 2, Request.Form("ckkelas")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 10, Request.Form("cnopas")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 201, 1, 15, Request.Form("cnoasuransi")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 135, 1, -1, MM_IIF(Request.Form("ctgldaftar"), Request.Form("ctgldaftar"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 135, 1, -1, MM_IIF(Request.Form("ctglkeluar"), Request.Form("ctglkeluar"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 201, 1, 30, Request.Form("cnama")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 201, 1, 80, Request.Form("calamat")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 201, 1, 7, Request.Form("ckkecamatan")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 201, 1, 10, Request.Form("ckkelurahan")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 5, 1, -1, MM_IIF(Request.Form("cumurthn"), Request.Form("cumurthn"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 5, 1, -1, MM_IIF(Request.Form("cumurbln"), Request.Form("cumurbln"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param14", 5, 1, -1, MM_IIF(Request.Form("cumurhr"), Request.Form("cumurhr"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param15", 201, 1, 1, Request.Form("cjeniskel")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 201, 1, 30, Request.Form("corangtua")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param17", 201, 1, 1, Request.Form("ckkelompok")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param18", 201, 1, 1, Request.Form("ckunjungan")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param19", 5, 1, -1, MM_IIF(Request.Form("ctinggibadan"), Request.Form("ctinggibadan"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param20", 5, 1, -1, MM_IIF(Request.Form("cberatbadan"), Request.Form("cberatbadan"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param21", 201, 1, 100, Request.Form("cgejala")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param22", 201, 1, 1, Request.Form("ckasus")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param23", 201, 1, 4, Request.Form("ckpenyakit1")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param24", 201, 1, 80, Request.Form("ckpenyakit2")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param25", 201, 1, 6, Request.Form("ckodeinadrg")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param26", 201, 1, -1, Request.Form("cterapi")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param27", 201, 1, 6, Request.Form("ckpegawai")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param28", 201, 1, 1, Request.Form("ckeluar")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param29", 201, 1, 1, Request.Form("ccarakeluar")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param30", 5, 1, -1, MM_IIF(Request.Form("ckarcis"), Request.Form("ckarcis"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param31", 201, 1, 5, Request.Form("ckrumahsakit")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param32", 201, 1, 10, Request.Form("cnocm")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param33", 201, 1, 15, Request.Form("cnik")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param34", 201, 1, 30, Request.Form("cpekerjaan")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param35", 201, 1, 15, Request.Form("ctelp")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param36", 201, 1, -1, Request.Form("criwayatpenyakit")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param37", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
  End If
End If
%>
<%
Dim tkecamatan__MMColParam
tkecamatan__MMColParam = "1"
If (Session("MM_kabupaten") <> "") Then 
  tkecamatan__MMColParam = Session("MM_kabupaten")
End If
%>
<%
Dim tkecamatan
Dim tkecamatan_numRows

Set tkecamatan = Server.CreateObject("ADODB.Recordset")
tkecamatan.ActiveConnection = MM_datarspermata_STRING
tkecamatan.Source = "SELECT kecamatan, kkecamatan FROM rspermata.tkecamatan WHERE kkabupaten = '" + Replace(tkecamatan__MMColParam, "'", "''") + "' ORDER BY kecamatan ASC"
tkecamatan.CursorType = 0
tkecamatan.CursorLocation = 2
tkecamatan.LockType = 1
tkecamatan.Open()

tkecamatan_numRows = 0
%>
<%
Dim tkelurahan__MMColParam
tkelurahan__MMColParam = "1"
If (Session("MM_kabupaten") <> "") Then 
  tkelurahan__MMColParam = Session("MM_kabupaten")
End If
%>
<%
Dim tkelurahan
Dim tkelurahan_numRows

Set tkelurahan = Server.CreateObject("ADODB.Recordset")
tkelurahan.ActiveConnection = MM_datarspermata_STRING
tkelurahan.Source = "SELECT * FROM rspermata.tkelurahan WHERE kkabupaten = '" + Replace(tkelurahan__MMColParam, "'", "''") + "' ORDER BY kelurahan ASC"
tkelurahan.CursorType = 0
tkelurahan.CursorLocation = 2
tkelurahan.LockType = 1
tkelurahan.Open()

tkelurahan_numRows = 0
%>

<%
Dim trumahsakit
Dim trumahsakit_cmd
Dim trumahsakit_numRows

Set trumahsakit_cmd = Server.CreateObject ("ADODB.Command")
trumahsakit_cmd.ActiveConnection = MM_datarspermata_STRING
trumahsakit_cmd.CommandText = "SELECT * FROM rspermata.trumahsakit WHERE krumahsakit = '" + Session("MM_username") + "'" 
trumahsakit_cmd.Prepared = true

Set trumahsakit = trumahsakit_cmd.Execute
trumahsakit_numRows = 0
%>
<%
Dim tpenyakitinadrg
Dim tpenyakitinadrg_cmd
Dim tpenyakitinadrg_numRows

Set tpenyakitinadrg_cmd = Server.CreateObject ("ADODB.Command")
tpenyakitinadrg_cmd.ActiveConnection = MM_datarspermata_STRING
tpenyakitinadrg_cmd.CommandText = "SELECT * FROM rspermata.tpenyakitinadrg ORDER BY kodeICD ASC" 
tpenyakitinadrg_cmd.Prepared = true

Set tpenyakitinadrg = tpenyakitinadrg_cmd.Execute
tpenyakitinadrg_numRows = 0
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
trawatpasien_cmd.CommandText = "SELECT *, coalesce(totalruangan,0) as totalruangan,coalesce(totaltindakan,0) as totaltindakan, coalesce(totalobat,0) as totalobat, coalesce(total,0) as total FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 5, 1, -1, trawatpasien__MMColParam) ' adDouble

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
Dim tkelompok
Dim tkelompok_cmd
Dim tkelompok_numRows

Set tkelompok_cmd = Server.CreateObject ("ADODB.Command")
tkelompok_cmd.ActiveConnection = MM_datarspermata_STRING
tkelompok_cmd.CommandText = "SELECT * FROM rspermata.tkelompok" 
tkelompok_cmd.Prepared = true

Set tkelompok = tkelompok_cmd.Execute
tkelompok_numRows = 0
%>
<%
Dim tpenyakit
Dim tpenyakit_cmd
Dim tpenyakit_numRows

Set tpenyakit_cmd = Server.CreateObject ("ADODB.Command")
tpenyakit_cmd.ActiveConnection = MM_datarspermata_STRING
tpenyakit_cmd.CommandText = "SELECT * FROM rspermata.tpenyakit" 
tpenyakit_cmd.Prepared = true

Set tpenyakit = tpenyakit_cmd.Execute
tpenyakit_numRows = 0
%>
<%
Dim ttujuan
Dim ttujuan_cmd
Dim ttujuan_numRows

Set ttujuan_cmd = Server.CreateObject ("ADODB.Command")
ttujuan_cmd.ActiveConnection = MM_datarspermata_STRING
ttujuan_cmd.CommandText = "SELECT * FROM rspermata.ttujuan ORDER BY tujuan ASC" 
ttujuan_cmd.Prepared = true

Set ttujuan = ttujuan_cmd.Execute
ttujuan_numRows = 0
%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE jabatan in ('02','03','24') ORDER BY jabatan, nama ASC" 
tpegawai_cmd.Prepared = true

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>
<%
Dim tkelas
Dim tkelas_cmd
Dim tkelas_numRows

Set tkelas_cmd = Server.CreateObject ("ADODB.Command")
tkelas_cmd.ActiveConnection = MM_datarspermata_STRING
tkelas_cmd.CommandText = "SELECT * FROM rspermata.tkelas ORDER BY kelas ASC" 
tkelas_cmd.Prepared = true

Set tkelas = tkelas_cmd.Execute
tkelas_numRows = 0
%>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit Perawatan Pasien</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
 function ajaxFunction(ckecamatan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var kecamatanku=ckecamatan
	url="../include/comboKELURAHAN.asp?ckkecamatan="+kecamatanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("ckkelurahan").innerHTML=xmlHttp.responseText;}} 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  

function simpandata()
{
var cnama = document.forms['form1'].elements['cnama'].value;
var ctgldaftar = document.forms['form1'].elements['ctgldaftar'].value;
var ckarcis = document.forms['form1'].elements['ckarcis'].value;
var cumurthn = document.forms['form1'].elements['cumurthn'].value;
var cumurbln = document.forms['form1'].elements['cumurbln'].value;
var cumurhr = document.forms['form1'].elements['cumurhr'].value;
var ckkelompok = document.forms['form1'].elements['ckkelompok'].value;
var ctinggibadan = document.forms['form1'].elements['ctinggibadan'].value;
var cberatbadan = document.forms['form1'].elements['cberatbadan'].value;
 
if (cnama == '') {
alert("Nama kosong, mohon dicek")
document.forms['form1'].elements['cnama'].focus();
return false;
}
else if (ctgldaftar == '') {
alert("Tgl Daftar kosong, mohon dicek")
document.forms['form1'].elements['ctgldaftar'].focus();
return false;
}

else if (ckarcis == '') {
alert("karcis  kosong, mohon dicek")
document.forms['form1'].elements['ckarcis'].focus();
return false;
}
else if (cumurthn == '') {
alert("Umur Tahun kosong, mohon dicek")
document.forms['form1'].elements['cumurthn'].focus();
return false;
}
else if (cumurbln == '') {
alert("umur Bulan kosong, mohon dicek")
document.forms['form1'].elements['cumurbln'].focus();
return false;
}
else if (cumurhr == '') {
alert("Umur Hari kosong, mohon dicek")
document.forms['form1'].elements['cumurhr'].focus();
return false;
}
else if (ctinggibadan == '') {
alert("Tinggi Badan Kosong, mohon dicek")
document.forms['form1'].elements['ctinggibadan'].focus();
return false;
}
else if (cberatbadan == '') {
alert("Berat Badan kosong, mohon dicek")
document.forms['form1'].elements['cberatbadan'].focus();
return false;
}

else {
	var ctanggal = document.forms['form1'].elements['ctgldaftar'].value;
	if (isValidDate(ctanggal)==false){
		document.forms['form1'].elements['ctgldaftar'].focus();
		return false
	}
	else {
	document.forms['form1'].submit();
	}
}
}


function koma1()
{
var ctinggibadan = document.forms['form1'].elements['ctinggibadan'].value;
var ctinggibadan=ctinggibadan.replace(/\./g,","); 
 document.forms['form1'].elements['ctinggibadan'].value=ctinggibadan;
}
function koma2()
{
var cberatbadan = document.forms['form1'].elements['cberatbadan'].value;
var cberatbadan=cberatbadan.replace(/\./g,","); 
 document.forms['form1'].elements['cberatbadan'].value=cberatbadan;
}


function isValidDate(ctanggal)
{
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




//-->
</script>
<script language="JavaScript">
<!-- Begin


var timerID = null;
var timerRunning = false;
function stopclock (){
if(timerRunning)
clearTimeout(timerID);
timerRunning = false;
}
function showtime () {
	
	
var now = new Date();
var hours = now.getHours();
var minutes = now.getMinutes();
var seconds = now.getSeconds()
var timeValue = "" + ((hours >12) ? hours -12 :hours)
if (timeValue == "0") timeValue = 12;
timeValue += ((minutes < 10) ? ":0" : ":") + minutes
timeValue += ((seconds < 10) ? ":0" : ":") + seconds
timeValue += (hours >= 12) ? " PM" : " AM"
document.form1.cjamdaftar.value = timeValue;

timerID = setTimeout("showtime()",1000);
timerRunning = true;
}
function startclock() {
stopclock();
showtime();
}

function tglsekarang() {
var todayDate=new Date();
var date=todayDate.getDate();
var month=todayDate.getMonth()+1;
var year=todayDate.getFullYear();
document.form1.ctgldaftar.value=year+'/'+month+'/'+date;
}

// End -->
</script>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
.style1 {font-size: 12px}
.style2 {color: #003333}
.style3 {
	color:#F00;
	font-size:18px;
	font-weight: bold;
}
.styleku1 {
	font-size: 12px;
	color: #000;
}
.styleku4 {
	font-size: 14px;
	color: #000;
}
.styleku5 {
	font-size: 15px;
	color: #000;
	font-weight:bold;
}
-->
</style>

</head>

<body onLoad="doOnLoad();">


  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>




		<link rel="icon" href="../dhtml/dhtmlxCombo/samples/common/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="../dhtml/dhtmlxCombo/samples/common/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="../dhtml/dhtmlxCombo/samples/common/css/style.css" type="text/css" media="screen" />

	  <script>
		window.dhx_globalImgPath="../../codebase/imgs/";
	</script>
	<link rel="STYLESHEET" type="text/css" href="../dhtml/dhtmlxCombo/codebase/dhtmlxcombo.css">
	
	<script  src="../dhtml/dhtmlxCombo/codebase/dhtmlxcommon.js"></script>
	<script  src="../dhtml/dhtmlxCombo/codebase/dhtmlxcombo.js"></script>

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
  <div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../menuutama.asp">Home</a></li>
                <li><a href="../inputdata/inputkelaspasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Ruangan</a></li>
                <li><a href="../inputdata/inputtindakanpasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Tindakan</a></li>
                <li><a href="../inputdata/inputvisitepasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Visite</a></li>
                <li><a href="../inputdata/inputobatpasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Obat</a></li>
                <li><a href="../inputdata/inputanalisasituasipasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Asuhan Kebidanan</a></li>
                <li><a href="../inputdata/inputpembayaranpasien.asp?cnotrans=<%=(trawatpasien.Fields.Item("notrans").Value)%>">Pembayaran</a></li>
                <li><a href="../daftar/rekammedik.asp?cnocm=<%=(trawatpasien.Fields.Item("nocm").Value)%>" target="_blank">Rekam Medik</a></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		<form ACTION="<%=MM_editAction%>" METHOD="POST" id="form1" name="form1">
          <table width="100%">
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Status Berobat </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="cstatuspasien" id="cstatuspasien">
                <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("statuspasien").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("statuspasien").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Jalan</option>
                <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("statuspasien").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("statuspasien").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Inap</option>
              </select></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Tujuan  Berobat </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="cktujuan" id="cktujuan">
                <option value="" <%If (Not isNull((trawatpasien.Fields.Item("ktujuan").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("ktujuan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                <%
While (NOT ttujuan.EOF)
%>
                <option value="<%=(ttujuan.Fields.Item("ktujuan").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("ktujuan").Value))) Then If (CStr(ttujuan.Fields.Item("ktujuan").Value) = CStr((trawatpasien.Fields.Item("ktujuan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(ttujuan.Fields.Item("tujuan").Value)%></option>
                <%
  ttujuan.MoveNext()
Wend
If (ttujuan.CursorType > 0) Then
  ttujuan.MoveFirst
Else
  ttujuan.Requery
End If
%>
              </select></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Ruangan </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><font color="white">
                <select name="ckkelas" id="ckkelas">
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kkelas").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tkelas.EOF)
%>
                  <option value="<%=(tkelas.Fields.Item("kkelas").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kkelas").Value))) Then If (CStr(tkelas.Fields.Item("kkelas").Value) = CStr((trawatpasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelas.Fields.Item("kelas").Value)%></option>
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
              </font></td>
            </tr>
            <tr>
              <td width="16%"><div align="right" class="style1">
                <h2><span class="style12">Notrans</span></h2>
              </div></td>
              <td width="3%"><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td width="81%"><h2 class="style2"><%=(trawatpasien.Fields.Item("notrans").Value)%></h2></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Nocm</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style3"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Nopas</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cnopas" type="text" id="cnopas" value="<%=(trawatpasien.Fields.Item("nopas").Value)%>" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">No Asuransi</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cnoasuransi" type="text" id="cnoasuransi" value="<%=(trawatpasien.Fields.Item("noasuransi").Value)%>" /></td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">No 
                Identitas</font></div></td>
              <td><div align="center"><strong>:</strong></div></td>
              <td><input name="cnik" type="text" id="cnik" value="<%=(trawatpasien.Fields.Item("nik").Value)%>" size="20" maxlength="15" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Tgl Masuk </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td>	
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgldaftar","ctglkeluar"]);
		}
	</script>

			  <div align="left" ><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgldaftar" type="text" id="ctgldaftar" value="<%= DoDateTime((trawatpasien.Fields.Item("tglmasuk").Value), 2, 7177) %>" size="15" maxlength="10" />
              </font><span class="style1">              Tahun / Bulan / Tanggal </span></div></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Tgl Keluar </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><div align="left">
                <input name="ctglkeluar" type="text" id="ctglkeluar" value="<%= DoDateTime((trawatpasien.Fields.Item("tglkeluar").Value), 2, 7177) %>" size="15" />
              <span class="style1">Tahun / Bulan / Tanggal </span></div></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Nama </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cnama" type="text" id="cnama" value="<%=(trawatpasien.Fields.Item("nama").Value)%>" size="35" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Alamat</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="calamat" type="text" id="calamat" value="<%=(trawatpasien.Fields.Item("alamat").Value)%>" size="50" /></td>
            </tr>
            <tr>
              <td height="26" align="center"><div align="right" class="style1"><span class="style12">Kecamatan</span></div></td>
              <td><div align="center">:</div></td>
              <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
                <select name="ckkecamatan" id="ckkecamatan"  onchange="ajaxFunction(this.value)">
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kkecamatan").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kkecamatan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tkecamatan.EOF)
%>
                  <option value="<%=(tkecamatan.Fields.Item("kkecamatan").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kkecamatan").Value))) Then If (CStr(tkecamatan.Fields.Item("kkecamatan").Value) = CStr((trawatpasien.Fields.Item("kkecamatan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkecamatan.Fields.Item("kecamatan").Value)%></option>
                  <%
  tkecamatan.MoveNext()
Wend
If (tkecamatan.CursorType > 0) Then
  tkecamatan.MoveFirst
Else
  tkecamatan.Requery
End If
%>
                </select>
              </font></span></td>
            </tr>
            <tr>
              <td height="26" align="center"><div align="right" class="style1"><span class="style12">Kelurahan</span></div></td>
              <td><div align="center">:</div></td>
              <td><div class="style2" id="ckkelurahan"> <font size="2" face="Arial, Helvetica, sans-serif">
                  <select name="ckkelurahan" id="ckkelurahan">
                    <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kkelurahan").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kkelurahan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                    <%
While (NOT tkelurahan.EOF)
%>
                    <option value="<%=(tkelurahan.Fields.Item("kkelurahan").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kkelurahan").Value))) Then If (CStr(tkelurahan.Fields.Item("kkelurahan").Value) = CStr((trawatpasien.Fields.Item("kkelurahan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelurahan.Fields.Item("kelurahan").Value)%></option>
                    <%
  tkelurahan.MoveNext()
Wend
If (tkelurahan.CursorType > 0) Then
  tkelurahan.MoveFirst
Else
  tkelurahan.Requery
End If
%>
                  </select>
              </font></div></td>
            </tr>
            
            <tr>
              <td><div align="right" class="style1"><span class="style12">Umur Tahun </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cumurthn" type="text" id="cumurthn" value="<%=(trawatpasien.Fields.Item("umurthn").Value)%>" size="5" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Umur Bulan </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cumurbln" type="text" id="cumurbln" value="<%=(trawatpasien.Fields.Item("umurbln").Value)%>" size="5" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Umur Hari </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cumurhr" type="text" id="cumurhr" value="<%=(trawatpasien.Fields.Item("umurhr").Value)%>" size="5" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Jenis Kelamin </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="cjeniskel" id="cjeniskel">
                <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("jeniskel").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("jeniskel").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Laki-laki</option>
                <option value="P" <%If (Not isNull((trawatpasien.Fields.Item("jeniskel").Value))) Then If ("P" = CStr((trawatpasien.Fields.Item("jeniskel").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Perempuan</option>
              </select></td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">Pekerjaan</font></div></td>
              <td><div align="center"><strong>:</strong></div></td>
              <td><span class="style17">
                <input name="cpekerjaan" type="text" id="cpekerjaan" value="<%=(trawatpasien.Fields.Item("pekerjaan").Value)%>" size="30" maxlength="30" />
              </span></td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">Telp</font></div></td>
              <td><div align="center"><strong>:</strong></div></td>
              <td><input name="ctelp" type="text" id="ctelp" value="<%=(trawatpasien.Fields.Item("telp").Value)%>" maxlength="15" /></td>
            </tr>
            <tr>
              <td align="center"><div align="right" class="style1"><span class="style12">Orang Tua / Suami</span></div></td>
              <td><div align="center">:</div></td>
              <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="corangtua" type="text" id="corangtua" value="<%=(trawatpasien.Fields.Item("orangtua").Value)%>" size="50" maxlength="30" />
              </font></strong></span></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Kelompok </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="style17">
                <select name="ckkelompok" id="ckkelompok">
                  <%
While (NOT tkelompok.EOF)
%>
                  <option value="<%=(tkelompok.Fields.Item("kkelompok").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kkelompok").Value))) Then If (CStr(tkelompok.Fields.Item("kkelompok").Value) = CStr((trawatpasien.Fields.Item("kkelompok").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelompok.Fields.Item("kelompok").Value)%></option>
                  <%
  tkelompok.MoveNext()
Wend
If (tkelompok.CursorType > 0) Then
  tkelompok.MoveFirst
Else
  tkelompok.Requery
End If
%>
              </select>
              </span></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" class="style1"><span class="style12">Kunjungan</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="style3"><strong>
                <select name="ckunjungan" id="ckunjungan">
                  <option value="B" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("B" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Baru</option>
                  <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Lama</option>
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
                </select>
              </strong></span></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" class="style1"><span class="style12">Tinggi Badan</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="ctinggibadan" type="text" id="ctinggibadan" value="<%= (trawatpasien.Fields.Item("tinggibadan").Value) %>" size="10" maxlength="10" onBlur="koma1()"/>
              <span class="styleku1">Cm</span></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" class="style1"><span class="style12">Berat Badan</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cberatbadan" type="text" id="cberatbadan" value="<%= (trawatpasien.Fields.Item("beratbadan").Value) %>" size="10" maxlength="10"  onblur="koma2()"/> 
              <span class="styleku1">Kg</span></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" class="style1"><span class="style12">Gejala</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="cgejala" type="text" id="cgejala" value="<%= (trawatpasien.Fields.Item("gejala").Value) %>" size="80" maxlength="100" /></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" class="style1"><span class="style12">Riwayat Penyakit</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><textarea name="criwayatpenyakit" id="criwayatpenyakit" cols="60" rows="5"><%= (trawatpasien.Fields.Item("riwayatpenyakit").Value) %></textarea></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Kasus Penyakit </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="ckasus" id="ckasus">
                <option value="B" <%If (Not isNull((trawatpasien.Fields.Item("kasus").Value))) Then If ("B" = CStr((trawatpasien.Fields.Item("kasus").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Baru</option>
                <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("kasus").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("kasus").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Lama</option>
              </select></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Diagnosa Masuk </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><div align="left">
                <select name="ckpenyakit1" id="ckpenyakit1">
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kpenyakit1").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kpenyakit1").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tpenyakit.EOF)
%>
                  <option value="<%=(tpenyakit.Fields.Item("kpenyakit").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kpenyakit1").Value))) Then If (CStr(tpenyakit.Fields.Item("kpenyakit").Value) = CStr((trawatpasien.Fields.Item("kpenyakit1").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpenyakit.Fields.Item("penyakit").Value)%></option>
                  <%
  tpenyakit.MoveNext()
Wend
If (tpenyakit.CursorType > 0) Then
  tpenyakit.MoveFirst
Else
  tpenyakit.Requery
End If
%>
                </select>
							  	<script>
		var z=dhtmlXComboFromSelect("ckpenyakit1");
	  	z.enableFilteringMode(true);
	</script>

              </div></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Diagnosa Keluar </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="ckpenyakit2" type="text" id="ckpenyakit2" value="<%= (trawatpasien.Fields.Item("kpenyakit2").Value) %>" size="76" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Diagnosa Ina DRG</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><div align="left"><span class="style1">
                <select name="ckodeinadrg" id="ckodeinadrg" style='width:485px;'>
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kodeinadrg").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kodeinadrg").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tpenyakitinadrg.EOF)
%>
                  <option value="<%=(tpenyakitinadrg.Fields.Item("kodeinadrg").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kodeinadrg").Value))) Then If (CStr(tpenyakitinadrg.Fields.Item("kodeinadrg").Value) = CStr((trawatpasien.Fields.Item("kodeinadrg").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpenyakitinadrg.Fields.Item("kodeicd").Value)&" - "&(tpenyakitinadrg.Fields.Item("SUBDIAGNOSA").Value)%></option>
                  <%
  tpenyakitinadrg.MoveNext()
Wend
If (tpenyakitinadrg.CursorType > 0) Then
  tpenyakitinadrg.MoveFirst
Else
  tpenyakitinadrg.Requery
End If
%>
                </select>
              </span>
			  	<script>
		var z=dhtmlXComboFromSelect("ckodeinadrg");
	  	z.enableFilteringMode(true);
	</script>
			

			  </div></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Terapi</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><textarea name="cterapi" id="cterapi" cols="60" rows="5"><%= (trawatpasien.Fields.Item("terapi").Value) %></textarea></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Dokter / Perawat / Bidan</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="ckpegawai" id="ckpegawai">
                <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kpegawai").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kpegawai").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                <%
While (NOT tpegawai.EOF)
%>
                <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kpegawai").Value))) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr((trawatpasien.Fields.Item("kpegawai").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
                <%
  tpegawai.MoveNext()
Wend
If (tpegawai.CursorType > 0) Then
  tpegawai.MoveFirst
Else
  tpegawai.Requery
End If
%>
              </select></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Keadaan Keluar</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="style13">
                <select name="ckeluar" id="ckeluar">
                  <option value=" " <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If (" " = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Sembuh</option>
                  <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Membaik</option>
                  <option value="3" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("3" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Belum Sembuh</option>
                  <option value="4" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("4" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Mati 48 Jam</option>
                  <option value="5" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("5" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Mati</option>
                  <option value="6" <%If (Not isNull((trawatpasien.Fields.Item("keluar").Value))) Then If ("6" = CStr((trawatpasien.Fields.Item("keluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Datang Sudah Mati</option>				  
                </select>
              </span></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Cara Keluar </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="style13">
                <select name="ccarakeluar" id="ccarakeluar">
                  <option value=" " <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If (" " = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
                  <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Diijinkan Pulang</option>
                  <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pulang Paksa</option>
                  <option value="3" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("3" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Dirujuk Ke</option>
                  <option value="4" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("4" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Lari</option>
                  <option value="5" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("5" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pindah RS Lain</option>
                </select>
              </span></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Karcis </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><input name="ckarcis" type="text" id="ckarcis" value="<%=(trawatpasien.Fields.Item("karcis").Value)%>" size="10" /></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Total Beaya Ruangan </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="styleku4">Rp. <%= FormatNumber((trawatpasien.Fields.Item("totalruangan").Value), 0, -2, -2, -1) %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Total Beaya Tindakan</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="styleku4">Rp. <%= FormatNumber((trawatpasien.Fields.Item("totaltindakan").Value), 0, -2, -2, -1) %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Total Beaya Visite</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="styleku4">Rp. <%= FormatNumber((trawatpasien.Fields.Item("totalvisite").Value), 0, -2, -2, -1) %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Total Obat </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="styleku4">Rp. <%= FormatNumber((trawatpasien.Fields.Item("totalobat").Value), 0, -2, -2, -1) %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Grand Total </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="styleku5">Rp. <%= FormatNumber((trawatpasien.Fields.Item("total").Value), 0, 0, -2, -1) %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Status Pembayaran</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td ><%
			  if (trawatpasien.Fields.Item("lunas").Value)="L" then
			  	response.Write("Lunas")
			  else
			  	response.Write("Belum Lunas")
			  end if
			  %></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"> Rumahsakit </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><select name="ckrumahsakit" id="ckrumahsakit">
                <%
While (NOT trumahsakit.EOF)
%><option value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("krumahsakit").Value))) Then If (CStr(trumahsakit.Fields.Item("krumahsakit").Value) = CStr((trawatpasien.Fields.Item("krumahsakit").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(trumahsakit.Fields.Item("rumahsakit").Value)%></option>
                <%
  trumahsakit.MoveNext()
Wend
If (trumahsakit.CursorType > 0) Then
  trumahsakit.MoveFirst
Else
  trumahsakit.Requery
End If
%>
              </select>
                <strong><strong>
                <input type="button" name="simpan" id="simpan" value="Simpan" onClick="simpandata()"/>
              </strong></strong></td>
            </tr>
          </table>
          <input type="hidden" name="MM_update" value="form1" />
          <input type="hidden" name="MM_recordId" value="<%= trawatpasien.Fields.Item("notrans").Value %>" />
          <span class="style17"><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="cnocm" type="hidden" id="cnocm" value="<%=(trawatpasien.Fields.Item("nocm").Value)%>" />
                </font></span></span>
		</form>
    	  <div class="cleaner"></div>
      </div> <!-- end of section 650 left column -->
        <!-- end of section 270  rigth column -->
<div class="cleaner"></div>    
    </div>
    
  <div id="templatemo_footer">
        <ul class="footer_list">
            <li>Rawat Jalan </li>
            <li>Rawat Inap</li>
            <li>Laboratorium</li>
            <li>Fisioteraphi</li>
            <li>Instalasi Farmasi</li>
        </ul> 
        
        <div class="margin_bottom_10"></div>      
    	Copyright © 2015 agoes irdianto - kalboya@yahoo.com    </div> 
    <!-- end of footer -->
<!--  Free Website Templates @ TemplateMo.com  -->
</div>
<div align=center></div>
</body>
</html>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>
<%
tpenyakitinadrg.Close()
Set tpenyakitinadrg = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tkelompok.Close()
Set tkelompok = Nothing
%>
<%
tpenyakit.Close()
Set tpenyakit = Nothing
%>
<%
ttujuan.Close()
Set ttujuan = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
tkecamatan.Close()
Set tkecamatan = Nothing
%>
<%
tkelurahan.Close()
Set tkelurahan = Nothing
%>
