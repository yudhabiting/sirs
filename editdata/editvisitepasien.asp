<%@LANGUAGE="VBSCRIPT"%>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="admin" then
elseif lcase(trim(Session("MM_statususer")))="dokter" then
elseif lcase(trim(Session("MM_statususer")))="bidan" then
elseif lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("../tolak.asp") 
else 
	Response.Redirect("../tolak.asp") 
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->
<%
cnotrans=request.QueryString("cnotrans")
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
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputvisite WHERE notrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble

    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("update trawatpasien set totalvisite=(select sum(tarif) from tinputvisite where notrans='"&Request.QueryString("cnotrans")&"') where notrans='"&Request.QueryString("cnotrans")&"'") 
  set tnourut2=tnourut1.execute ("update trawatpasien set total = (totaltindakan+totalobat+totalruangan+totalvisite+karcis) where notrans='"&Request.QueryString("cnotrans")&"'") 

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputvisitepasien.asp"
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
    MM_editCmd.CommandText = "UPDATE rspermata.tinputvisite SET tgltrans = ?, kvisite = ?, kpegawai = ?, pemeriksaanfisik = ?, tarif = ? WHERE notrans = ? and nourut = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("ctgltrans"), Request.Form("ctgltrans"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 3, Request.Form("ckvisite")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 6, Request.Form("ckpegawai")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, -1, Request.Form("cpemeriksaanfisik")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("ctarif"), Request.Form("ctarif"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
  End If
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("update trawatpasien set totalvisite=(select sum(tarif) from tinputvisite where notrans='"&Request.QueryString("cnotrans")&"') where notrans='"&Request.QueryString("cnotrans")&"'") 
  set tnourut2=tnourut1.execute ("update trawatpasien set total = (totaltindakan+totalobat+totalruangan+totalvisite+karcis) where notrans='"&Request.QueryString("cnotrans")&"'") 

  
End If
%>
<%
Dim tvisite
Dim tvisite_cmd
Dim tvisite_numRows

Set tvisite_cmd = Server.CreateObject ("ADODB.Command")
tvisite_cmd.ActiveConnection = MM_datarspermata_STRING
tvisite_cmd.CommandText = "SELECT * FROM rspermata.tvisite ORDER BY urut ASC" 
tvisite_cmd.Prepared = true

Set tvisite = tvisite_cmd.Execute
tvisite_numRows = 0
%>
<%
cdaftartarif=""
While (NOT tvisite.EOF)
  cdaftartarif=cdaftartarif&" "&"kode"&(tvisite.Fields.Item("kvisite").Value)&(tvisite.Fields.Item("tarif").Value)
  tvisite.MoveNext()
Wend
If (tvisite.CursorType > 0) Then
  tvisite.MoveFirst
Else
  tvisite.Requery
End If
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
Dim vtinputvisitepasien_cmd
Dim vtinputvisitepasien_numRows

Set vtinputvisitepasien_cmd = Server.CreateObject ("ADODB.Command")
vtinputvisitepasien_cmd.ActiveConnection = MM_datarspermata_STRING
vtinputvisitepasien_cmd.CommandText = "SELECT * FROM rspermata.vtinputvisitepasien WHERE notrans = ? order by tgltrans,nourut" 
vtinputvisitepasien_cmd.Prepared = true
vtinputvisitepasien_cmd.Parameters.Append vtinputvisitepasien_cmd.CreateParameter("param1", 200, 1, 15, vtinputvisitepasien__MMColParam) ' adVarChar

Set vtinputvisitepasien = vtinputvisitepasien_cmd.Execute
vtinputvisitepasien_numRows = 0
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
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr, anamnese FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
Dim tinputvisitepasien__MMColParam1
tinputvisitepasien__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputvisitepasien__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputvisitepasien__MMColParam2
tinputvisitepasien__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputvisitepasien__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputvisitepasien
Dim tinputvisitepasien_cmd
Dim tinputvisitepasien_numRows

Set tinputvisitepasien_cmd = Server.CreateObject ("ADODB.Command")
tinputvisitepasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputvisitepasien_cmd.CommandText = "SELECT * FROM rspermata.tinputvisite WHERE notrans = ? and nourut = ? " 
tinputvisitepasien_cmd.Prepared = true
tinputvisitepasien_cmd.Parameters.Append tinputvisitepasien_cmd.CreateParameter("param1", 200, 1, 255, tinputvisitepasien__MMColParam1) ' adVarChar
tinputvisitepasien_cmd.Parameters.Append tinputvisitepasien_cmd.CreateParameter("param2", 5, 1, -1, tinputvisitepasien__MMColParam2) ' adDouble

Set tinputvisitepasien = tinputvisitepasien_cmd.Execute
tinputvisitepasien_numRows = 0
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
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE jabatan = ?" 
tpegawai_cmd.Prepared = true
tpegawai_cmd.Parameters.Append tpegawai_cmd.CreateParameter("param1", 200, 1, 2, tpegawai__MMColParam) ' adVarChar

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
Repeat1__index = 0
vtinputvisitepasien_numRows = vtinputvisitepasien_numRows + Repeat1__numRows
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
<title>Edit Visite Dokter</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
	<link rel="STYLESHEET" type="text/css" href="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.css">
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
function tarifku(ckvisite)
{
	var txt1='<%=(cdaftartarif)%>';
	spl = txt1.split(" ");
	var txt2="kode"+ckvisite;
	for(i = 0; i < spl.length; i++)
	{
		var kodevisite=spl[i].toString();
		var kodevisite=kodevisite.substring(0,7);
		if (kodevisite==txt2) {
			var panjang=spl[i].length;
			var jmltarif=spl[i].substring(7,panjang);
			document.forms['form1'].elements['ctarif'].value=jmltarif;
			
		}
	}
}

function simpandata()
{
var ckvisite = document.forms['form1'].elements['ckvisite'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;


if (ckvisite == '') {
alert("visite kosong, mohon dicek")
document.forms['form1'].elements['ckvisite'].focus();
return false;
}
else if (ctarif == '') {
alert("tarif kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
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
var ckvisite = document.forms['form1'].elements['ckvisite'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;


if (ckvisite == '') {
alert("visite kosong, mohon dicek")
document.forms['form1'].elements['ckvisite'].focus();
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
a {font-family: Tahoma; font-size: 11px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 11px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 11px; color:#0000FF}
a:link {text-decoration: none;font-size: 11px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 11px; color:#FFFFFF; }
.style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style4 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-weight:bold;
	color: #F00;
}
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

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
<div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../daftar/rekammedik.asp?cnocm=<%=(trawatpasien.Fields.Item("nocm").Value)%>" target="_blank">Rekam Medik</a></li>
                <li><a href="../inputdata/inputvisitepasien.asp?cnotrans=<%=(cnotrans)%>">Input Pemeriksaan Dokter</a></li>
                <li><a href="../inputdata/inputobatpasien.asp?cnotrans=<%=(cnotrans)%>">Input Obat</a></li>
                <li><a href="../daftar/daftarinputperawatan.asp?citem=3">Daftar Pasien</a></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT PEMERIKSAAN / VISITE DOKTER</h2>
		    <table width="100%">
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
                <td class="style4"><span class="style3">Anamnese</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><textarea name="textarea" id="textarea" cols="60" rows="15"><%=(trawatpasien.Fields.Item("anamnese").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputvisitepasien.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Ruang</span></td>
                <td><div align="center">:</div></td>
                <td>
                <select name="ckvisite" id="ckvisite" onChange="tarifku(this.value)">
                  <option value="" <%If (Not isNull((tinputvisitepasien.Fields.Item("kvisite").Value))) Then If ("" = CStr((tinputvisitepasien.Fields.Item("kvisite").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tvisite.EOF)
%>
                  <option value="<%=(tvisite.Fields.Item("Kvisite").Value)%>" <%If (Not isNull((tinputvisitepasien.Fields.Item("kvisite").Value))) Then If (CStr(tvisite.Fields.Item("Kvisite").Value) = CStr((tinputvisitepasien.Fields.Item("kvisite").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tvisite.Fields.Item("visite").Value)%></option>
                  <%
  tvisite.MoveNext()
Wend
If (tvisite.CursorType > 0) Then
  tvisite.MoveFirst
Else
  tvisite.Requery
End If
%>
                </select>
                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Dokter</span></td>
                <td><div align="center">:</div></td>
                <td><select name="ckpegawai" id="ckpegawai">
                  <option value="" <%If (Not isNull((tinputvisitepasien.Fields.Item("kpegawai").Value))) Then If ("" = CStr((tinputvisitepasien.Fields.Item("kpegawai").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tpegawai.EOF)
%>
                  <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull((tinputvisitepasien.Fields.Item("kpegawai").Value))) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr((tinputvisitepasien.Fields.Item("kpegawai").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
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
                <td class="style4"><span class="style3">Pemeriksaan Dokter</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cpemeriksaanfisik" id="cpemeriksaanfisik" cols="60" rows="10"><%=(tinputvisitepasien.Fields.Item("pemeriksaanfisik").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tarif</span></td>
                <td><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputvisitepasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputvisitepasien.Fields.Item("nourut").Value)%>" />
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                </strong></strong></td>
                </tr>
            </table>
		    <div  id="gridvisite">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" >visite</td>
		          <td width="60px" align="right">Tarif</td>
		          <td width="*" align="left">Dokter</td>
		          <td width="*" align="left"><span class="style3">Pemeriksaan Fisik</span></td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputvisitepasien.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(vtinputvisitepasien.Fields.Item("tgltrans").Value)%></td>
		          <td><a href="../editdata/editvisitepasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputvisitepasien.Fields.Item("notrans").Value & "&cnourut=" & vtinputvisitepasien.Fields.Item("nourut").Value %>"><%=(vtinputvisitepasien.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(vtinputvisitepasien.Fields.Item("visite").Value)%></td>
		          <td><%=(vtinputvisitepasien.Fields.Item("tarif").Value)%></td>
		          <td><%=(vtinputvisitepasien.Fields.Item("nama").Value)%></td>
		          <td><%=(vtinputvisitepasien.Fields.Item("pemeriksaanfisik").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputvisitepasien.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputvisitepasien.Fields.Item("notrans").Value %>" />
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
tvisite.Close()
Set tvisite = Nothing
%>
<%
vtinputvisitepasien.Close()
Set vtinputvisitepasien = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tinputvisitepasien.Close()
Set tinputvisitepasien = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
