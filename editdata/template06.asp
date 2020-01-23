<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%> 
<% 
dim nourut1,nourut2,cnourut,kodepuskesmas
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
If (CStr(Request("MM_insert")) = "form1") Then

  Set tpasien1 = Server.CreateObject("ADODB.connection")
  tpasien1.open = MM_datarspermata_STRING
'  set tpasien2=tpasien1.execute ("SELECT max(nocm)+1 as nourut  FROM rspermata.tpasien WHERE left(kpuskesmas,9) = '"&(CStr(Request("ckodepuskesmas1"))&"'")) 
' MASTER PASIEN OFFLINE TIAP PUSTU
  set tpasien2=tpasien1.execute ("SELECT max(nocm)+1 as nourut  FROM rspermata.tpasien") 
cnourut=len(tpasien2("nourut"))
nourut1=(tpasien2("nourut"))
if cnourut=1 then
	nourut1="000000000"&nourut1
end if
if cnourut=2 then
	nourut1="00000000"&nourut1
end if
if cnourut=3 then
	nourut1="0000000"&nourut1
end if
if cnourut=4 then
	nourut1="000000"&nourut1
end if
if cnourut=5 then
	nourut1="00000"&nourut1
end if
if cnourut=6 then
	nourut1="0000"&nourut1
end if
if cnourut=7 then
	nourut1="000"&nourut1
end if
if cnourut=8 then
	nourut1="00"&nourut1
end if
if cnourut=9 then
	nourut1="0"&nourut1
end if
if isnull(tpasien2("nourut"))=true then
	nourut1="0000000001"
end if
end if
%>


<%
' *** Insert Record: set variables

If (CStr(Request("MM_insert")) = "form1") Then

  MM_editConnection = MM_datarspermata_STRING
  MM_editTable = "rspermata.tpasien"
  if (CStr(Request("cdaftar")) = "D") then
	  MM_editRedirectUrl = "../inputdata/inputrawatpasien.asp?cnocm="&nourut1
  else
	  MM_editRedirectUrl = "editpasien.asp?cnocm="&nourut1
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
' *** Insert Record: construct a sql insert statement and execute it

Dim MM_tableValues
Dim MM_dbValues

If (CStr(Request("MM_insert")) <> "") Then
  ' create the sql insert statement
  MM_tableValues = ""
  MM_dbValues = ""
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
      MM_tableValues = MM_tableValues & ","
      MM_dbValues = MM_dbValues & ","
    End If
    MM_tableValues = MM_tableValues & MM_columns(MM_i)
    MM_dbValues = MM_dbValues & MM_formVal
  Next
'  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"
  MM_editQuery = "insert into " & MM_editTable & " (nocm," &  MM_tableValues & ") values ('"& nourut1&"',"& MM_dbValues & ")" 
  If (Not MM_abortEdit) Then
    ' execute the insert
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
If (CStr(Request("MM_insert2")) = "form1") Then
      MM_editRedirectUrl = "masterpasien.asp?ckkecamatan=" &CStr(Request.Form("ckkecamatan"))&"&cnama=" &CStr(Request.Form("cnama"))&"&calamat=" &CStr(Request.Form("calamat"))
      Response.Redirect(MM_editRedirectUrl)

end if
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
If (Request.QueryString("ckkecamatan") <> "") Then 
  tkelurahan__MMColParam = Request.QueryString("ckkecamatan")
End If
%>
<%
Dim tkelurahan
Dim tkelurahan_numRows

Set tkelurahan = Server.CreateObject("ADODB.Recordset")
tkelurahan.ActiveConnection = MM_datarspermata_STRING
tkelurahan.Source = "SELECT kelurahan, kkecamatan, kkelurahan FROM rspermata.tkelurahan WHERE kkecamatan = '" + Replace(tkelurahan__MMColParam, "'", "''") + "' ORDER BY kelurahan ASC"
tkelurahan.CursorType = 0
tkelurahan.CursorLocation = 2
tkelurahan.LockType = 1
tkelurahan.Open()

tkelurahan_numRows = 0
%>
<%
Dim tpuskesmas__MMColParam
tpuskesmas__MMColParam = "%"
If (Session("MM_Username") <> "") Then 
  tpuskesmas__MMColParam = Session("MM_Username")
End If
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
</script>
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


	<link rel="STYLESHEET" type="text/css" href="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.css">
	<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcommon.js"></script>
	<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.js"></script>


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
	document.forms['form2'].elements['MM_insert2'].value='form2';
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
body {
	background-color: #FFFFFF;
}
-->
</style></head>
<body onload="startclock();tglsekarang()">
<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
  <div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../daftar/caripasien.asp">Cari Pasien </a></li>
                <li></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
<form name="form1" method="POST" action="<%=MM_editAction%>">
  <table width="100%" height="484" >
    
      
      <tr>
        <td height="24" align="center">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">No 
          Pasien Lama</font></strong></div></td>
        <td width="2%"><div align="center"><strong>:</strong></div></td>
        <td width="76%"><span class="style17">
          <input name="cnopas" type="text" id="cnopas" value=" " size="15" maxlength="10">
        </span></td>
      </tr>
      <tr>
        <td width="22%" height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">No 
          Asuransi</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><input name="cnoasuransi" type="text" id="cnoasuransi" size="20" maxlength="15"></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Tanggal 
          Daftar</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="ctgldaftar" type="text" id="ctgldaftar" size="10" maxlength="10">
          J<strong>am
            <input name="cjamdaftar" type="text" id="cjamdaftar"  size="10" maxlength="8" readonly="true">
            (format tanggal : THN / BLN / TGL)</strong></span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Nama</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="cnama" type="text" id="cnama" value="<%= request.querystring("cnama") %>" size="50" maxlength="30">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Alamat</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="calamat" type="text" id="calamat" value="<%= request.querystring("calamat") %>" size="70" maxlength="50">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kecamatan</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <select style='width:300px;' name="ckkecamatan" id="ckkecamatan" onChange="ajaxFunction(this.value)">
            <option value="" <%If (Not isNull(request.querystring("ckkecamatan"))) Then If ("" = CStr(request.querystring("ckkecamatan"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
            <%
While (NOT tkecamatan.EOF)
%>
            <option value="<%=(tkecamatan.Fields.Item("kkecamatan").Value)%>" <%If (Not isNull(request.querystring("ckkecamatan"))) Then If (CStr(tkecamatan.Fields.Item("kkecamatan").Value) = CStr(request.querystring("ckkecamatan"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkecamatan.Fields.Item("kecamatan").Value)%></option>
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
        </span></td>
      </tr>
      <tr>
        <td height="25" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kelurahan</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><div class="style17" id="ckkelurahan">
          <select name="ckkelurahan" id="select">
            <option value=""></option>
            <%
While (NOT tkelurahan.EOF)
%>
            <option value="<%=(tkelurahan.Fields.Item("kkelurahan").Value)%>"><%=(tkelurahan.Fields.Item("kelurahan").Value)%></option>
            <%
  tkelurahan.MoveNext()
Wend
If (tkelurahan.CursorType > 0) Then
  tkelurahan.MoveFirst
Else
  tkelurahan.Requery
End If
%>
          </select>          </td>
      </tr>
      
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Umur 
          Tahun</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="cumurthn" type="text" id="cumurthn" value="0" size="5" maxlength="3">
          </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Umur 
          Bulan</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="cumurbln" type="text" id="cumurbln" value="0" size="5" maxlength="3">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Umur 
          Hari</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="cumurhr" type="text" id="cumurhr" value="0" size="5" maxlength="3">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Jenis 
          Kelamin</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <select name="cjeniskel" id="cjeniskel">
            <option value="P">PEREMPUAN</option>
            <option value="L">LAKI-LAKI</option>
          </select>
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Pekerjaan</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="cpekerjaan" type="text" id="cpekerjaan" size="30" maxlength="20">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Orang 
          Tua / Suami</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="corangtua" type="text" id="corangtua" size="50" maxlength="30">
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kelompok</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <select name="ckkelompok1" id="ckkelompok1">
            <%
While (NOT tkelompok.EOF)
%>
            <option value="<%=(tkelompok.Fields.Item("kkelompok").Value+cstr(tkelompok.Fields.Item("karcis").Value))%>"><%=(tkelompok.Fields.Item("kelompok").Value)%></option>
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
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Karcis</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style17">
          <input name="ckarcis" type="text" id="ckarcis" value="0" size="10" maxlength="6">
          </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Kunjungan</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style19">
          <select name="ckunjungan" id="ckunjungan">
            <option value="B">Kunjungan Baru</option>
            <option value="L">Kunjungan Lama</option>
            <option> </option>
            </select>
        </span></td>
      </tr>
      <tr>
        <td height="24" align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Tujuan Berobat</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><select name="cstatuspasien" id="cstatuspasien">
          <option value="1">Rawat Jalan</option>
          <option value="2">Rawat Inap</option>
        </select></td>
      </tr>
      <tr>
        <td align="center"><div align="right"><strong><font size="2" face="Arial, Helvetica, sans-serif">Daftar</font></strong></div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td><span class="style19"><strong>
          <select name="cdaftar" id="cdaftar">
            <option value=" "></option>
            <option value="D">Daftar</option>
            <option value="T">Tidak Daftar</option>
          </select>
          <strong>
            <input type="button" name="simpan" id="simpan" value="Simpan" onclick="simpandata()"/>
            <input type="hidden" name="MM_insert" value="form1" />
            <input name="ckrumahsakit" type="hidden" id="ckrumahsakit" value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>" />
            <input name="ckkelompok" type="hidden" id="ckkelompok" />
</strong></strong></span></td>
      </tr>
      </table>
    </form>
<form action="" method="post" name="form2">
  <div align="right">
    <input type="hidden" name="cnama">
    <input type="hidden" name="calamat">
    <input type="hidden" name="ckkecamatan">
    <input type="hidden" name="MM_insert2" value="form1">
  </div>
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
tkecamatan.Close()
Set tkecamatan = Nothing
%>
<%
tkelurahan.Close()
Set tkelurahan = Nothing
%>
<%
tkelompok.Close()
Set tkelompok = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>
