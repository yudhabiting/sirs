<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<% 
dim nourut1,nourut2,cnourut,koderumahsakit
cnourut=0
nourut1=0
%>

<!--#include file="../Connections/datarspermata.asp" -->
<%
' *** Edit Operations: declare variables

Dim MM_editAction
Dim MM_abortEdit
Dim MM_editQuery
Dim MM_editCmd

Dim MM_editConnection
Dim MM_editTable
Dim MM_editRedirectUrl
Dim MM_editColumn
Dim MM_recordId

Dim MM_fieldsStr
Dim MM_columnsStr
Dim MM_fields
Dim MM_columns
Dim MM_typeArray
Dim MM_formVal
Dim MM_delim
Dim MM_altVal
Dim MM_emptyVal
Dim MM_i

MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Request.QueryString
End If

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
' *** Update Record: set variables

If (CStr(Request("MM_update")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  MM_editConnection = MM_datarspermata_STRING
  MM_editTable = "rspermata.tpasien"
  MM_editColumn = "nocm"
  MM_recordId = "'" + Request.Form("MM_recordId") + "'"
  if (CStr(Request("cdaftar")) = "D") then
	  MM_editRedirectUrl = "../inputdata/inputrawatpasien.asp?cnocm="&MM_recordId
  else
	  MM_editRedirectUrl = ""
  end if
  MM_fieldsStr  = "cnopas|value|cnoasuransi|value|ctgldaftar|value|cjamdaftar|value|cnama|value|calamat|value|ckkecamatan|value|ckkelurahan|value|cumurthn|value|cumurbln|value|cumurhr|value|cjeniskel|value|cpekerjaan|value|corangtua|value|ckkelompok|value|cstatuspasien|value|ckarcis|value|ckunjungan|value|cdaftar|value|ckrumahsakit|value"
  MM_columnsStr = "nopas|',none,''|noasuransi|',none,''|tgldaftar|',none,NULL|jamdaftar|',none,NULL|nama|',none,''|alamat|',none,''|kkecamatan|',none,''|kkelurahan|',none,''|umurthn|none,none,NULL|umurbln|none,none,NULL|umurhr|none,none,NULL|jeniskel|',none,''|pekerjaan|',none,''|orangtua|',none,''|kkelompok|',none,''|statuspasien|',none,''|karcis|none,none,NULL|kunjungan|',none,''|daftar|',none,''|krumahsakit|',none,''"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

End If
%>
<%
' *** Update Record: construct a sql update statement and execute it

If (CStr(Request("MM_update")) <> "" And CStr(Request("MM_recordId")) <> "") Then

  ' create the sql update statement
  MM_editQuery = "update " & MM_editTable & " set "
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_formVal = MM_fields(MM_i+1)
    MM_typeArray = Split(MM_columns(MM_i+1),",")
    MM_delim = MM_typeArray(0)
    If (MM_delim = "none") Then MM_delim = ""
    MM_altVal = MM_typeArray(1)
    If (MM_altVal = "none") Then MM_altVal = ""
    MM_emptyVal = MM_typeArray(2)
    If (MM_emptyVal = "none") Then MM_emptyVal = ""
    If (MM_formVal = "") Then
      MM_formVal = MM_emptyVal
    Else
      If (MM_altVal <> "") Then
        MM_formVal = MM_altVal
      ElseIf (MM_delim = "'") Then  ' escape quotes
        MM_formVal = "'" & Replace(MM_formVal,"'","''") & "'"
      Else
        MM_formVal = MM_delim + MM_formVal + MM_delim
      End If
    End If
    If (MM_i <> LBound(MM_fields)) Then
      MM_editQuery = MM_editQuery & ","
    End If
    MM_editQuery = MM_editQuery & MM_columns(MM_i) & " = " & MM_formVal
  Next
  MM_editQuery = MM_editQuery & " where " & MM_editColumn & " = " & MM_recordId 

  If (Not MM_abortEdit) Then
    ' execute the update
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
    If (MM_editRedirectUrl <> "") Then
      Response.Redirect(MM_editRedirectUrl)
    End If
  End If

End If
%>
<%
Dim tpasien__MMColParam1
tpasien__MMColParam1 = "1"
If (Request.QueryString("cnocm")  <> "") Then 
  tpasien__MMColParam1 = Request.QueryString("cnocm") 
End If
%>
<%
Dim tpasien
Dim tpasien_numRows

Set tpasien = Server.CreateObject("ADODB.Recordset")
tpasien.ActiveConnection = MM_datarspermata_STRING
tpasien.Source = "SELECT *  FROM rspermata.tpasien  WHERE nocm = '" + Replace(tpasien__MMColParam1, "'", "''") + "'"
tpasien.CursorType = 0
tpasien.CursorLocation = 2
tpasien.LockType = 1
tpasien.Open()

tpasien_numRows = 0
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
Dim trumahsakit__MMColParam
trumahsakit__MMColParam = "1"
If (Session("MM_Username") <> "") Then 
  trumahsakit__MMColParam = Session("MM_Username")
End If
%>
<%
Dim trumahsakit
Dim trumahsakit_cmd
Dim trumahsakit_numRows

Set trumahsakit_cmd = Server.CreateObject ("ADODB.Command")
trumahsakit_cmd.ActiveConnection = MM_datarspermata_STRING
trumahsakit_cmd.CommandText = "SELECT * FROM rspermata.trumahsakit WHERE krumahsakit = ?" 
trumahsakit_cmd.Prepared = true
trumahsakit_cmd.Parameters.Append trumahsakit_cmd.CreateParameter("param1", 200, 1, 5, trumahsakit__MMColParam) ' adVarChar

Set trumahsakit = trumahsakit_cmd.Execute
trumahsakit_numRows = 0
%>

<%
Dim tkelompok
Dim tkelompok_numRows

Set tkelompok = Server.CreateObject("ADODB.Recordset")
tkelompok.ActiveConnection = MM_datarspermata_STRING
tkelompok.Source = "SELECT * FROM rspermata.tkelompok"
tkelompok.CursorType = 0
tkelompok.CursorLocation = 2
tkelompok.LockType = 1
tkelompok.Open()

tkelompok_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Design by http://www.FreeWebsiteTemplateZ.com
Released for free under a Creative Commons Attribution 3.0 License
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Edit Pasien</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="../template/templat04/style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="../template/templat04/js/cufon-yui.js"></script>
<script type="text/javascript" src="../template/templat04/js/arial.js"></script>
<script type="text/javascript" src="../template/templat04/js/cuf_run.js"></script>
<!-- CuFon ends -->
<script type="text/javascript">
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
 </script>
	<script>
		window.dhx_globalImgPath="../../include/";
	</script>


	<link rel="STYLESHEET" type="text/css" href="../../include/dhtmlxcombo.css">
	<script  src="../../include/dhtmlxcommon.js"></script>
	<script  src="../../include/dhtmlxcombo.js"></script>


<script type="text/javascript">
<!--

function simpandata()
{
var cnama = document.forms['form1'].elements['cnama'].value;
var ctgldaftar = document.forms['form1'].elements['ctgldaftar'].value;
var ckarcis = document.forms['form1'].elements['ckarcis'].value;
var cumurthn = document.forms['form1'].elements['cumurthn'].value;
var cumurbln = document.forms['form1'].elements['cumurbln'].value;
var cumurhr = document.forms['form1'].elements['cumurhr'].value;
var ckkelompok1 = document.forms['form1'].elements['ckkelompok1'].value;
 
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

else {
	document.forms['form1'].elements['ckkelompok'].value=ckkelompok1.substring(0,1);
	document.forms['form1'].elements['ckarcis'].value=ckkelompok1.substring(1,5);
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
.style1 {font-size: 14px}
.style2 {font-size: 16px}
.style8 {font-size: 17px}
.style9 {color: #666666}
-->
</style>

</head>
<body onload="startclock();tglsekarang()">
<div class="main">

  <div class="header">
    <div class="header_resize">
      <div class="logo">
        <h1>Sistem Informasi rspermata</br>
              <span class="style2">design by : Agoes</span></h1>
      </div>
      <div class="clr"></div>
      <div class="menu_nav">
        <ul>
          <li class="active"><blink><a title="menu utama" href="../menuutama.asp">Home</a></blink></li>
          <li class="active"><blink><a title="menu utama" href="../master/masterpasien.asp">Input Pasien</a></blink></li>
          <li class="active"><blink><a title="menu utama" href="../daftar/caripasien.asp">Cari Pasien</a></blink></li>
        </ul>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="content">
    <div class="content_resize">

<form name="form1" method="POST" action="<%=MM_editAction%>">
  <table width="100%" height="576" bgcolor="#59A9D5">
    <tr align="center">
      <td colspan="2"></td>
    </tr>
    <tr align="center">
      <td width="24%">&nbsp;</td>
      <td width="76%">&nbsp;</td>
    </tr>
    <tr align="center">
      <td><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">No 
        CM</font></strong></div></td>
      <td><font color="white"></font>
        <div align="left"><font color="white"><strong><font size="2" face="Arial, Helvetica, sans-serif">
          <input name="cnocm" type="text" disabled="disabled" id="cnocm" value="<%=(tpasien.Fields.Item("nocm").Value)%>" size="10" maxlength="6" />
          <font color="yellow">NoCM Lama
            <input name="cnopas" type="text" id="cnopas" value="<%=(tpasien.Fields.Item("nopas").Value)%>" size="15" maxlength="10" />
            </font><a href="Masterpasien.asp"></a></font></strong></font></div></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">No 
        Asuransi</font></strong></div></td>
      <td><input name="cnoasuransi" type="text" id="cnoasuransi" value="<%=(tpasien.Fields.Item("noasuransi").Value)%>" size="20" maxlength="15" /></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Tanggal 
        Daftar</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="ctgldaftar" type="text" id="ctgldaftar" value="<%=(tpasien.Fields.Item("tgldaftar").Value)%>" size="15" maxlength="10" />
        Jam
        <input name="cjamdaftar" type="text" id="cjamdaftar" value="<%=time()%>" size="10" maxlength="8" />
      </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Nama</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="cnama" type="text" id="cnama" value="<%=(tpasien.Fields.Item("nama").Value)%>" size="50" maxlength="30" />
      </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Alamat</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="calamat" type="text" id="calamat" value="<%=(tpasien.Fields.Item("alamat").Value)%>" size="70" maxlength="50" />
      </font></strong></td>
    </tr>
    <tr>
      <td height="26" align="center"><div align="right"><font color="yellow"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kecamatan</font></strong></font></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <select name="ckkecamatan" id="ckkecamatan"  onchange="ajaxFunction(this.value)">
          <option value="" <%If (Not isNull((tpasien.Fields.Item("kkecamatan").Value))) Then If ("" = CStr((tpasien.Fields.Item("kkecamatan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
          <%
While (NOT tkecamatan.EOF)
%>
          <option value="<%=(tkecamatan.Fields.Item("kkecamatan").Value)%>" <%If (Not isNull((tpasien.Fields.Item("kkecamatan").Value))) Then If (CStr(tkecamatan.Fields.Item("kkecamatan").Value) = CStr((tpasien.Fields.Item("kkecamatan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkecamatan.Fields.Item("kecamatan").Value)%></option>
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
      </font></strong></td>
    </tr>
    <tr>
      <td height="26" align="center"><div align="right"><font color="yellow"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kelurahan</font></strong></font></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <div id="ckkelurahan">
          <select name="ckkelurahan" id="ckkelurahan">
            <option value="" <%If (Not isNull((tpasien.Fields.Item("kkelurahan").Value))) Then If ("" = CStr((tpasien.Fields.Item("kkelurahan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
            <%
While (NOT tkelurahan.EOF)
%>
            <option value="<%=(tkelurahan.Fields.Item("kkelurahan").Value)%>" <%If (Not isNull((tpasien.Fields.Item("kkelurahan").Value))) Then If (CStr(tkelurahan.Fields.Item("kkelurahan").Value) = CStr((tpasien.Fields.Item("kkelurahan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelurahan.Fields.Item("kelurahan").Value)%></option>
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
          </div>
        </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Umur 
        Tahun</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurthn" type="text" id="cumurthn" value="<%=(tpasien.Fields.Item("umurthn").Value)%>" size="5" maxlength="3" />
        </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Umur 
        Bulan</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurbln" type="text" id="cumurbln" value="<%=(tpasien.Fields.Item("umurbln").Value)%>" size="5" maxlength="3" />
      </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Umur 
        Hari</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurhr" type="text" id="cumurhr" value="<%=(tpasien.Fields.Item("umurhr").Value)%>" size="5" maxlength="3" />
      </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Jenis 
        Kelamin</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <select name="cjeniskel" id="cjeniskel">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If (" " = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="L" <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If ("L" = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>LAKI-LAKI</option>
          <option value="P" <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If ("P" = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>PEREMPUAN</option>
          </select>
        </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Pekerjaan</font></strong></div></td>
      <td><span class="style17"><font color="yellow">
        <input name="cpekerjaan" type="text" id="cpekerjaan" value="<%=(tpasien.Fields.Item("pekerjaan").Value)%>" size="30" maxlength="20" />
      </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Orang 
        Tua / Suami</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="corangtua" type="text" id="corangtua" value="<%=(tpasien.Fields.Item("orangtua").Value)%>" size="50" maxlength="30" />
        </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Kelompok</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <select name="ckkelompok1" id="ckkelompok1">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("kkelompok").Value))) Then If (" " = CStr((tpasien.Fields.Item("kkelompok").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
          <%
While (NOT tkelompok.EOF)
%>
          <option value="<%=(tkelompok.Fields.Item("kkelompok").Value+cstr(tkelompok.Fields.Item("karcis").Value))%>" <%If (Not isNull((tpasien.Fields.Item("kkelompok").Value))) Then If (CStr(tkelompok.Fields.Item("kkelompok").Value) = CStr((tpasien.Fields.Item("kkelompok").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelompok.Fields.Item("kelompok").Value)%></option>
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
      </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Tujuan 
        Berobat</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <select name="cstatuspasien" id="cstatuspasien">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If (" " = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="1" <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If ("1" = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Jalan</option>
          <option value="2" <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If ("2" = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Inap</option>
        </select>
        &nbsp; </font></strong></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Karcis</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <input name="ckarcis" type="text" id="ckarcis" value="<%=(tpasien.Fields.Item("karcis").Value)%>" size="10" maxlength="6" />
        </font></strong></td>
    </tr>
    <tr>
      <td height="28" align="center"><div align="right"><font color="yellow"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kunjungan</font></strong></font></div></td>
      <td><select name="ckunjungan" id="ckunjungan">
        <option value="B" <%If (Not isNull("L")) Then If ("B" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Baru</option>
        <option value="L" <%If (Not isNull("L")) Then If ("L" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Lama</option>
        <option value="" <%If (Not isNull("L")) Then If ("" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
      </select></td>
    </tr>
    <tr>
      <td align="center"><div align="right"><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">Daftar</font></strong></div></td>
      <td><strong><font color="yellow" size="2" face="Arial, Helvetica, sans-serif">
        <select name="cdaftar" id="cdaftar">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If (" " = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="D" <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If ("D" = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Daftar</option>
          <option value="T" <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If ("T" = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Tidak 
            Daftar</option>
        </select>
      </font></strong></td>
    </tr>
    <tr>
      <td height="28" align="center"><div align="right"><font color="yellow"><strong><font size="2" face="Arial, Helvetica, sans-serif">rumahsakit</font></strong></font></div></td>
      <td><select name="ckrumahsakit" id="ckrumahsakit">
        <%
While (NOT trumahsakit.EOF)
%>
        <option value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>" <%If (Not isNull((tpasien.Fields.Item("krumahsakit").Value))) Then If (CStr(trumahsakit.Fields.Item("krumahsakit").Value) = CStr((tpasien.Fields.Item("krumahsakit").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(trumahsakit.Fields.Item("rumahsakit").Value)%></option>
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
        <strong><font color="yellow">
        <input type="button" name="simpan" id="simpan" value="Simpan" onclick="simpandata()"/>
        </font></strong></td>
    </tr>
    <tr>
      <td height="28" colspan="2" align="center"><hr /></td>
    </tr>
  </table>
    <input type="hidden" name="MM_update" value="form1">
    <input type="hidden" name="MM_recordId" value="<%= tpasien.Fields.Item("nocm").Value %>">
    <input type="hidden" name="MM_recordId1" value="<%= tpasien.Fields.Item("krumahsakit").Value %>">
    <input name="ckkelompok" type="hidden" id="ckkelompok" />
</form>
      <div class="clr"></div>
    </div>
  </div>
<div id='navbar-footer'>
  <div class="footer">
    <div class="footer_resize">
      <p><span class="lf">&copy; Copyright<span class="style9"> : </span></span><span class="style9">By : Kalboya</span></p>
    </div>
  </div>
  </div>
</div>
</body>
</html>
<%
tkecamatan.Close()
Set tkecamatan = Nothing
%>
<%
tkelurahan.Close()
Set tkelurahan = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>
<%
tkelompok.Close()
Set tkelompok = Nothing
%>
<%
tpasien.Close()
Set tpasien = Nothing
%>
