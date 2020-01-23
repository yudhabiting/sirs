<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas6"
cuserid=trim(Session("MM_userid"))
cstatususer=lcase(trim(Session("MM_statususer")))

chome="../"
clogintolak=chome&"tolak.asp"

if lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect(clogintolak) 
end if
%>
<!--#include file="../Connections/datarspermata.asp" -->
<!--#include file="../include/tableMENUKIRI.asp" -->
<!--#include file="../include/tableMENUATAS2.asp" -->
<%
' validasi status user
txt1=lcase(trim(cstatususer))

txt2=lcase(trim(ccstatusaplikasiinput))
ccocok="false"
a=Split(txt2)
for each x in a
    txt3=lcase(trim(x))
	if txt1=txt3 then
		ccocok="true"
	end if
next
if ccocok="false" then
	Response.Redirect(clogintolak) 
end if

txt2edit=lcase(trim(ccstatusaplikasiedit))
ccocokedit="false"
a=Split(txt2edit)
for each x in a
    txt3=lcase(trim(x))
	if txt1=txt3 then
		ccocokedit="true"
	end if
next
cjudulform="Edit "&cjudulform
%>


<%
Dim tpegawaiLOGIN__MMColParam
tpegawaiLOGIN__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tpegawaiLOGIN__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tpegawaiLOGIN
Dim tpegawaiLOGIN_cmd
Dim tpegawaiLOGIN_numRows

Set tpegawaiLOGIN_cmd = Server.CreateObject ("ADODB.Command")
tpegawaiLOGIN_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawaiLOGIN_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = ?" 
tpegawaiLOGIN_cmd.Prepared = true
tpegawaiLOGIN_cmd.Parameters.Append tpegawaiLOGIN_cmd.CreateParameter("param1", 200, 1, 6, tpegawaiLOGIN__MMColParam) ' adVarChar

Set tpegawaiLOGIN = tpegawaiLOGIN_cmd.Execute
tpegawaiLOGIN_numRows = 0
%>

<%
'BATAS COPYAN
%>


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
  MM_editRedirectUrl = "editpasien.asp"
  MM_fieldsStr  = "cnoantrian|value|cnopas|value|cnoasuransi|value|cnik|value|ctgldaftar|value|cjamdaftar|value|cnama|value|calamat|value|ckkecamatan|value|ckkelurahan|value|ctgllahir|value|cumurthn|value|cumurbln|value|cumurhr|value|cjeniskel|value|cpekerjaan|value|ctelp|value|cibu|value|corangtua|value|ckkelompok|value|ckasuransi|value|csyaratasuransi|value|cstatuspasien|value|ckarcis|value|ckunjungan|value|cdaftar|value|ckrumahsakit|value|cktujuan|value|ckpengirim|value|ckpegawai|value"
  MM_columnsStr = "noantrian|none,none,NULL|nopas|',none,''|noasuransi|',none,''|nik|',none,''|tgldaftar|',none,NULL|jamdaftar|',none,NULL|nama|',none,''|alamat|',none,''|kkecamatan|',none,''|kkelurahan|',none,''|tgllahir|',none,NULL|umurthn|none,none,NULL|umurbln|none,none,NULL|umurhr|none,none,NULL|jeniskel|',none,''|pekerjaan|',none,''|telp|',none,''|ibu|',none,''|orangtua|',none,''|kkelompok|',none,''|kasuransi|',none,''|syaratasuransi|',none,''|statuspasien|',none,''|karcis|none,none,NULL|kunjungan|',none,''|daftar|',none,''|krumahsakit|',none,''|ktujuan|',none,''|kpengirim|',none,''|kpegawai|',none,''"

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
<%
Dim tasuransi
Dim tasuransi_cmd
Dim tasuransi_numRows

Set tasuransi_cmd = Server.CreateObject ("ADODB.Command")
tasuransi_cmd.ActiveConnection = MM_datarspermata_STRING
tasuransi_cmd.CommandText = "SELECT * FROM rspermata.tasuransi" 
tasuransi_cmd.Prepared = true

Set tasuransi = tasuransi_cmd.Execute
tasuransi_numRows = 0
%>
<%
Dim ttujuan
Dim ttujuan_cmd
Dim ttujuan_numRows

Set ttujuan_cmd = Server.CreateObject ("ADODB.Command")
ttujuan_cmd.ActiveConnection = MM_datarspermata_STRING
ttujuan_cmd.CommandText = "SELECT * FROM rspermata.ttujuan where tampil='Y' order by tujuan" 
ttujuan_cmd.Prepared = true

Set ttujuan = ttujuan_cmd.Execute
ttujuan_numRows = 0
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

<!DOCTYPE html>
<html lang="en">	
<head>
<meta charset="utf-8">
<title><%=cjudulform%></title>
		<link href="../template/menu000/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="../template/menu000/css/font-awesome.css" rel="stylesheet">
		<link href="../template/menu000/css/style.css" rel="stylesheet">

		<link href="../template/menu000/css/formatmenu01.css" rel="stylesheet">



<script type="text/javascript" src="../template/menu000/js/jquery.min1.js"></script> 
<script src="../template/menu000/js/devoops.js"></script>

    

</head>



<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/metro-green/easyui.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/demo/demo.css"/>
<script type="text/javascript" src="../include/jqueryeasyui/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../include/jqueryeasyui/jquery.min.js"></script>


<script type="text/javascript" src="../include/jqueryeasyui/jquery.easyui.min.js"></script>
<script src="../include/jqueryeasyui/datagrid-filter.js" type="text/javascript"></script>
<script type="text/javascript" src="../include/jqueryeasyui/print.js"></script>
<script type="text/javascript" src="../include/jqueryeasyui/excel.js"></script>
<!--#include file="../include/filterDATAGRID.asp" -->


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

 function ajaxFunctionlogin(filesimpan)  
 {
   var ckondisiku = document.forms['form1'].elements['ckondisiku'].value;
   var cuserid = document.forms['form1'].elements['cuserid'].value;
   var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
	url="../include/cekLOGINED.asp?cuserid="+cuserid
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   	{
	   document.getElementById ("csessionku").innerHTML=xmlHttp.responseText;
	   var csessionku =document.forms['form1'].elements['csessionku'].value;
	   var cuserid = document.forms['form1'].elements['cuserid'].value;
//		alert(document.forms['form1'].elements['csessionku'].value);
		if (csessionku==''){
			loginulang();
			}
		else if (csessionku!=cuserid){
			alert("User ID yg anda Masukan tidak sesuai dengan User ID Login Sebelumnya, silahkan Login Ulang");
		}

					simpandata2();


	}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  

// window login ulang
var popupWindow=null;
function loginulang()
	{ 
		var w = 500;
		var h = 500;
		var left = Number((screen.width/2)-(w/2));
		var tops = Number((screen.height/2)-(h/2));
		
		if(popupWindow && !popupWindow.closed)
		   popupWindow.focus();
		else
		   popupWindow = window.open('../loginulang.asp','winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+w+', height='+h+', top='+tops+', left='+left);
	}


// fungsi disable parent window	
function parent_disable() 
	{
  		if(popupWindow && !popupWindow.closed)
    	popupWindow.focus();
	}


function simpandata1(cstatussimpan)
{
	ajaxFunctionlogin();
}  



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

function simpandata2()
{
var cnama = document.forms['form1'].elements['cnama'].value;
var ctgldaftar = document.forms['form1'].elements['ctgldaftar'].value;
var ckarcis = document.forms['form1'].elements['ckarcis'].value;
var cumurthn = document.forms['form1'].elements['cumurthn'].value;
var cumurbln = document.forms['form1'].elements['cumurbln'].value;
var cumurhr = document.forms['form1'].elements['cumurhr'].value;
var cktujuan1 = document.forms['form1'].elements['cktujuan1'].value;
var cktujuan = document.forms['form1'].elements['cktujuan'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
 
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
else if (cktujuan1 == '') {
alert("Tujuan Berobat kosong, mohon dicek")
document.forms['form1'].elements['cktujuan1'].focus();
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
else if (ckpegawai == '') {
alert("Petugas kosong, mohon dicek")
document.forms['form1'].elements['ckpegawai'].focus();
return false;
}


else {
	document.forms['form1'].elements['cktujuan'].value=cktujuan1.substring(0,2);
	document.forms['form1'].elements['ckarcis'].value=cktujuan1.substring(2,10);
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

function statuspasienku()
{
	var cstatuspasienku = document.forms['form1'].elements['cstatuspasien'].value;
	if (cstatuspasienku=='2'){
		document.forms['form1'].elements['cktujuan1'].value='010';		
	}
	else {
 		document.forms['form1'].elements['cktujuan1'].value='';		
	}
	
}



function tujuanku()
{
	var cktujuan1 = document.forms['form1'].elements['cktujuan1'].value;
	document.forms['form1'].elements['cktujuan'].value=cktujuan1.substring(0,2);
	document.forms['form1'].elements['ckarcis'].value=cktujuan1.substring(2,10);

	var cktujuan2 = document.forms['form1'].elements['cktujuan'].value;
	if (cktujuan2=='01'){
		document.forms['form1'].elements['cstatuspasien'].value='2';		
	}
	else {
		document.forms['form1'].elements['cstatuspasien'].value='1';		
	}
}


 function ubahasuransi(ckkelompok)  
 { 
	if (ckkelompok != '5') {
		document.forms['form1'].elements['ckasuransi'].value="";
		document.forms['form1'].elements['csyaratasuransi'].value="0";
	}
   }  

 function ubahasuransi2(ckasuransi)  
 { 
	if (ckasuransi != '') {
		document.forms['form1'].elements['ckkelompok'].value="5";
		document.forms['form1'].elements['csyaratasuransi'].value="0";	}	
	else {
		document.forms['form1'].elements['ckkelompok'].value='';
		document.forms['form1'].elements['csyaratasuransi'].value="0";
	}
   }  


 function  hitungusia()  
 {
   
   var ctgllahir = document.forms['form1'].elements['ctgllahir'].value;
   if (ctgllahir == '' ) {
		alert('tanggal lahir kosong');
		document.forms['form1'].elements['ctgllahir'].focus();
	}	
   else {
	   var xmlHttp;  
	   try    {xmlHttp=new XMLHttpRequest();}  
	   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
	   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
	   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
	   url="../include/comboUMURTAHUN.asp?ctgllahir="+ctgllahir
	   url=url+"&sid="+Math.random()	
	   xmlHttp.onreadystatechange=function()      
	   {if(xmlHttp.readyState==4)        
	   	{
			document.getElementById ("cumurku").innerHTML=xmlHttp.responseText;
			document.forms['form1'].elements['cumurku'].value=xmlHttp.responseText;
			cjumlahumur=document.forms['form1'].elements['cumurku'].value;
			var jumlahumur1 = cjumlahumur;
			var jumlahumur2 = jumlahumur1.split('$$$');
			var jumlahumur3 = jumlahumur2[0];
			var jumlahumur4 = jumlahumur3.split('value="');
			var jumlahumur5 = jumlahumur4[1];
			var cumurthn=jumlahumur5;
			var jumlahumur5 = jumlahumur2[1];
			var cumurbln=jumlahumur5;
			var jumlahumur3 = jumlahumur2[2];
			var jumlahumur4 = jumlahumur3.split('">');
			var jumlahumur5 = jumlahumur4[0];
			var cumurhr=jumlahumur5;
			document.forms['form1'].elements['cumurthn'].value=cumurthn;
			document.forms['form1'].elements['cumurbln'].value=cumurbln;
			document.forms['form1'].elements['cumurhr'].value=cumurhr;

		}
   	} 
    	xmlHttp.open("GET",url,true);    xmlHttp.send(null);
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


 function  caripasienku()  
 {
   
   var cnomercm = document.forms['form1'].elements['cnomercm'].value;
   if (cnomercm == '' ) {
		alert('No CM Kosong');
		document.forms['form1'].elements['cnomercm'].focus();
	}	
   else {
	   var xmlHttp;  
	   try    {xmlHttp=new XMLHttpRequest();}  
	   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
	   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
	   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
	   url="../include/comboNOMERCM.asp?cnocm="+cnomercm
	   url=url+"&sid="+Math.random()	
	   xmlHttp.onreadystatechange=function()      
	   {if(xmlHttp.readyState==4)        
	   	{
			document.getElementById ("cnomercmku").innerHTML=xmlHttp.responseText;
			document.forms['form1'].elements['cnomercmku'].value=xmlHttp.responseText;
			cjumlahnomercm=document.forms['form1'].elements['cnomercmku'].value;
			var jumlahnomercm1 = cjumlahnomercm;
			var jumlahnomercm2 = jumlahnomercm1.split('$$$');
			var jumlahnomercm3 = jumlahnomercm2[1];
		   if (jumlahnomercm3 == 'xxxxxx' ) {
				alert('Pasien Dengan Nomer CM Tersebut Tidak Ada..!!!!');
				document.forms['form1'].elements['cjumlahnomercm'].focus();
			}	
		   else {
				window.location = "../editdata/editpasien.asp?cnocm="+jumlahnomercm3+"&cnourutmenu=<%=cnourutmenu%>";
				}

		}
   	} 
    	xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  
}  


// End -->
</script>

<body onload="doOnLoad();startclock();tglsekarang()">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgldaftar","ctgllahir"]);
		}
	</script>

<header class="navbar">
	<div class="container-fluid expanded-panel">
		<div class="row" >

			<div id="logo" class="col-xs-12 col-sm-2" style="overflow: hidden; white-space: nowrap; height: 70px;">
            <img src="../icon/logoPERMATA.png" width="180" height="60">
			</div>

			<div id="top-panel" class="col-xs-12 col-sm-10">
				<div class="row">
					<div class="col-xs-8 col-sm-8 top-panel-right text-center">
							<h3 style="padding-top: 10px;"><span style="white-space:nowrap"></span></h3>
					</div>

                   <div class="fontjudul1" align="right" style="font-size:20px; margin-right:20px;"> <%=cjudulform%> </div>
					<div class="col-xs-4 col-sm-4 top-panel-right text-right">
						<ul class="nav navbar-nav pull-right panel-menu">
							<li>
								<font size="+1"><span class="fontjudul4">  </span> </font>
							</li>
						</ul>
					</div>                   
				</div>
                
			</div>
		</div>
	</div>

    
            <!--menu sebelah kiri-->
                <div id="breadcrumb" class="col-xs-6" style="padding-left: 25px;white-space:nowrap;z-index:1000; width:5px">
                    <a href="#" class="show-sidebar">
                      <i class="fa fa-bars"></i>
                    </a>
                    <ol class="breadcrumb" style="padding-left: 30px;">
                      <li class="hidden-xs">Menu Transaksi Pasien</li>
                    </ol>
                </div>


            <!--menu sebelah kanan-->

			<!--#include file="../include/menuINPUTatas.asp" -->
 
</header>



<div id="main" class="container-fluid sidebar-show" style="overflow:visible;background:#6C6;">
	<div class="row">
		<div id="sidebar-left" class="col-xs-2 col-sm-2" >

			<!--#include file="../include/menuINPUTkiri.asp" -->

		</div>





		<!--Start Content-->
	<div id="content" class="col-xs-12 col-sm-10" style="min-height:1000px;padding-left:0px; padding-right:0px;">
</br>
 <div align="right" style="margin-right:20px">Login ID : @ <span class="blink" style="font-size:14px"><%=tpegawaiLOGIN.Fields.Item("nama").Value%></span>  </div>                 

            <div class="row-fluid"> 
                <div class="box"><div class="box-content"><center>


		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
<table width="100%" class="fontku1">
    <tr align="center">
      <td width="17%">&nbsp;</td>
      <td width="2%">&nbsp;</td>
      <td width="81%">&nbsp;</td>
    </tr>
      <tr>
        <td align="center"><div align="right">No 
          CM </div></td>
        <td align="center"><strong>:</strong></td>
        <td ><input name="cnomercm" type="text" id="cnomercm" value=" " size="15" maxlength="10">
          <input name="find1" type="image" id="find1" style="border-width:0px;width:40px;height:40px"  onClick="caripasienku();return false;" src="../icon/find.jpg" align="middle" /></td>
      </tr>
      <tr>
        <td  colspan="3" align="center"><hr></td>
        </tr>

    <tr align="center">
      <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">No 
        Antrian</font></div></td>
      <td>:</td>
      <td align="left"><input name="cnoantrian" type="text" class="style7" id="cnoantrian" value="<%=(tpasien.Fields.Item("noantrian").Value)%>" size="5" /></td>
    </tr>
    <tr align="center">
      <td><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">No 
        CM</font></div></td>
      <td><div align="center">:</div></td>
      <td>
        <div align="left" class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
          <input name="cnocm" type="text" disabled="disabled" id="cnocm" value="<%=(tpasien.Fields.Item("nocm").Value)%>" size="10" maxlength="6" />
        </font></div></td>
    </tr>
    <tr align="center">
      <td><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif"> NoCM Lama</font></div></td>
      <td><div align="center">:</div></td>
      <td><div align="left"><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cnopas" type="text" id="cnopas" value="<%=(tpasien.Fields.Item("nopas").Value)%>" size="15" maxlength="10" />
      </font></span></div></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">No 
        Asuransi</font></div></td>
      <td><div align="center">:</div></td>
      <td><input name="cnoasuransi" type="text" id="cnoasuransi" value="<%=(tpasien.Fields.Item("noasuransi").Value)%>" size="20" maxlength="15" /></td>
    </tr>
    <tr>
      <td height="24" align="center"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">No 
        Identitas</font></div></td>
      <td><div align="center">:</div></td>
      <td><input name="cnik" type="text" id="cnik" value="<%=(tpasien.Fields.Item("nik").Value)%>" size="35" maxlength="20" /></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Tanggal 
        Daftar</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="ctgldaftar" type="text" id="ctgldaftar" value="<%= DoDateTime((tpasien.Fields.Item("tgldaftar").Value), 2, 7177) %>" size="15" maxlength="10" />
        Jam
        <input name="cjamdaftar" type="text" id="cjamdaftar" value="<%=time()%>" size="10" maxlength="8" />
        </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Nama</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cnama" type="text" id="cnama" value="<%=(tpasien.Fields.Item("nama").Value)%>" size="50" maxlength="30" />
      </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Alamat</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="calamat" type="text" id="calamat" value="<%=(tpasien.Fields.Item("alamat").Value)%>" size="70" maxlength="50" />
      </font></span></td>
    </tr>
    <tr>
      <td height="26" align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Kecamatan</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
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
      </font></span></td>
    </tr>
    <tr>
      <td height="26" align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Kelurahan</font></div></td>
      <td><div align="center">:</div></td>
      <td>        <div class="style2" id="ckkelurahan">
          <font size="2" face="Arial, Helvetica, sans-serif">
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
          </font></div></td>
    </tr>

      <tr>
        <td height="24" align="center"><div align="right">Tgl Lahir</div></td>
        <td align="center"><strong>:</strong></td>
        <td><input name="ctgllahir" type="text" id="ctgllahir" size="10" maxlength="10" value="<%= DoDateTime((tpasien.Fields.Item("tgllahir").Value), 2, 7177) %>">
          <input type="button" name="button" id="button" value="Hitung Umur" onClick="hitungusia()"></td>
      </tr>

    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Umur 
        Tahun</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurthn" type="text" id="cumurthn" value="<%=(tpasien.Fields.Item("umurthn").Value)%>" size="5" maxlength="3" />
        </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Umur 
        Bulan</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurbln" type="text" id="cumurbln" value="<%=(tpasien.Fields.Item("umurbln").Value)%>" size="5" maxlength="3" />
      </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Umur 
        Hari</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cumurhr" type="text" id="cumurhr" value="<%=(tpasien.Fields.Item("umurhr").Value)%>" size="5" maxlength="3" />
      </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Jenis 
        Kelamin</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style2"><font size="2" face="Arial, Helvetica, sans-serif">
        <select name="cjeniskel" id="cjeniskel">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If (" " = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="L" <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If ("L" = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>LAKI-LAKI</option>
          <option value="P" <%If (Not isNull((tpasien.Fields.Item("jeniskel").Value))) Then If ("P" = CStr((tpasien.Fields.Item("jeniskel").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>PEREMPUAN</option>
        </select>
        </font></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Pekerjaan</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style17 style3"><strong>
        <input name="cpekerjaan" type="text" id="cpekerjaan" value="<%=(tpasien.Fields.Item("pekerjaan").Value)%>" size="30" maxlength="30" />
        </strong></span></td>
    </tr>
    <tr>
      <td height="24" align="center"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">Telp</font></div></td>
      <td><div align="center">:</div></td>
      <td><input name="ctelp" type="text" id="ctelp" value="<%=(tpasien.Fields.Item("telp").Value)%>" maxlength="15" /></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Nama Ibu</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="cibu" type="text" id="cibu" value="<%=(tpasien.Fields.Item("ibu").Value)%>" size="50" maxlength="30" />
      </font></strong></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Penanggungjawab</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="corangtua" type="text" id="corangtua" value="<%=(tpasien.Fields.Item("orangtua").Value)%>" size="50" maxlength="30" />
        </font></strong></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Kelompok</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <select name="ckkelompok" id="ckkelompok" onchange="ubahasuransi(this.value)">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("kkelompok").Value))) Then If (" " = CStr((tpasien.Fields.Item("kkelompok").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
          <%
While (NOT tkelompok.EOF)
%>
          <option value="<%=(tkelompok.Fields.Item("kkelompok").Value)%>" <%If (Not isNull((tpasien.Fields.Item("kkelompok").Value))) Then If (CStr(tkelompok.Fields.Item("kkelompok").Value) = CStr((tpasien.Fields.Item("kkelompok").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelompok.Fields.Item("kelompok").Value)%></option>
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
      </font></strong></span></td>
    </tr>
            <tr>
              <td align="right"><div align="right"><span class="btn-success">&nbsp;&nbsp;&nbsp; Khusus Pasien Asuransi &nbsp;&nbsp;&nbsp;</span></div></td>
              <td>&nbsp;</td>
              <td><hr></td>
            </tr>

            <tr>
              <td><div align="right" >Nama Asuransi </div></td>
              <td><div align="center" >:</div></td>
              <td>
                <select name="ckasuransi" id="ckasuransi" onchange="ubahasuransi2(this.value)">
<option value=""> </option>
                  <%
While (NOT tasuransi.EOF)
%>
                  <option value="<%=(tasuransi.Fields.Item("kasuransi").Value)%>" <%If (Not isNull((tpasien.Fields.Item("kasuransi").Value))) Then If (CStr(tasuransi.Fields.Item("kasuransi").Value) = CStr((tpasien.Fields.Item("kasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tasuransi.Fields.Item("asuransi").Value)%></option>
                  <%
  tasuransi.MoveNext()
Wend
If (tasuransi.CursorType > 0) Then
  tasuransi.MoveFirst
Else
  tasuransi.Requery
End If
%>
              </select> 
              </td>
            </tr>
    
    <tr>
      <td align="right">Syarat Asuransi</td>
      <td><div align="center">:</div></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <select name="csyaratasuransi" id="csyaratasuransi">
          <option value="0" <%If (Not isNull((tpasien.Fields.Item("syaratasuransi").Value))) Then If ("0" = CStr((tpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
          <option value="1" <%If (Not isNull((tpasien.Fields.Item("syaratasuransi").Value))) Then If ("1" = CStr((tpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Belum Menyerahkan</option>
          <option value="2" <%If (Not isNull((tpasien.Fields.Item("syaratasuransi").Value))) Then If ("2" = CStr((tpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Sudah Menyerahkan</option>
        </select>
      </font></td>
    </tr>
            <tr>
              <td colspan=3>
<hr>
              </td>
            </tr>    
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Status Pasien</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <select name="cstatuspasien" id="cstatuspasien" onchange="statuspasienku()">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If (" " = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="1" <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If ("1" = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Jalan</option>
          <option value="2" <%If (Not isNull((tpasien.Fields.Item("statuspasien").Value))) Then If ("2" = CStr((tpasien.Fields.Item("statuspasien").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Inap</option>
          </select>
        &nbsp; </font></strong></span></td>
    </tr>
    <tr>
      <td height="24" align="right"><div align="right" class="style3" id="tujuangue1"><font size="2" face="Arial, Helvetica, sans-serif">Tujuan Berobat</font></div></td>
      <td><div id="tujuangue3" align="center">:</div></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif">
        <div id="tujuangue4">
          <select name="cktujuan1" id="cktujuan1" onchange="tujuanku()">
            <option value=""></option>
            <%
While (NOT ttujuan.EOF)
%>
            <option value="<%=(ttujuan.Fields.Item("ktujuan").Value)&(ttujuan.Fields.Item("karcis").Value)%>"><%=(ttujuan.Fields.Item("tujuan").Value)%></option>
            <%
  ttujuan.MoveNext()
Wend
If (ttujuan.CursorType > 0) Then
  ttujuan.MoveFirst
Else
  ttujuan.Requery
End If
%>
          </select>
        </div>
      </font></td>
    </tr>
    <tr>
      <td height="28" align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Kunjungan</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong>
        <select name="ckunjungan" id="ckunjungan">
          <option value="B" <%If (Not isNull("L")) Then If ("B" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Baru</option>
          <option value="L" <%If (Not isNull("L")) Then If ("L" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Lama</option>
          <option value="" <%If (Not isNull("L")) Then If ("" = CStr("L")) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
          </select>
        </strong></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Karcis</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <input name="ckarcis" type="text" id="ckarcis" value="<%=(tpasien.Fields.Item("karcis").Value)%>" size="10" maxlength="6" />
      </font></strong></span></td>
    </tr>
    <tr>
      <td align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Daftar</font></div></td>
      <td><div align="center">:</div></td>
      <td><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif">
        <select name="cdaftar" id="cdaftar">
          <option value=" " <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If (" " = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>></option>
          <option value="D" <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If ("D" = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Daftar</option>
          <option value="T" <%If (Not isNull((tpasien.Fields.Item("daftar").Value))) Then If ("T" = CStr((tpasien.Fields.Item("daftar").Value))) Then Response.Write("SELECTED") : Response.Write("")%>>Tidak 
            Daftar</option>
          </select>
      </font></strong></span></td>
    </tr>


      <tr>
        <td height="24" align="center"><div align="right">Pengirim</div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td>


 <input id="ckpengirim" name="ckpengirim" style="width:300px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:800,
                panelHeight:400,
                url: '../include/comboLISTDATAmaster.asp?ctabel=tabel01&ctampil=Y&ckpengirim=<%=tpasien.Fields.Item("kpengirim").Value%>',
                idField:'kpengirim',
                textField:'pengirim',
                fitColumns:true,
                mode:'remote',
		pagePosition:top,
                pagination:true,
                columns:[[
                    {field:'kpengirim',title:'Kode',width:20,sortable:true},
                    {field:'pengirim',title:'Pengirim',width:100,sortable:true},
                    {field:'alamat',title:'Alamat',width:200,sortable:true}
                ]]
 	">
</input>
<script type="text/javascript">
$(function(){
$('#ckpengirim').combogrid('setValue', '<%=tpasien.Fields.Item("kpengirim").Value%>');
});
</script>    
   
          </td>
      </tr>
    <tr>
      <td height="28" align="center"><div align="right" class="style3"><font size="2" face="Arial, Helvetica, sans-serif">Petugas</font></div></td>
      <td><div align="center">:</div></td>
      <td>
      <select name="ckpegawai" id="ckpegawai">
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
      </select></td>
    </tr>
    <tr>
      <td height="28" colspan="3" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td height="28" align="center">&nbsp;</td>
      <td height="28" align="center">&nbsp;</td>
      <td height="28" align="left"><span class="style3"><strong><font size="2" face="Arial, Helvetica, sans-serif"><strong>
        <input type="button" name="simpan" id="simpan" value="Simpan" onClick="simpandata1()" class="tombolku2"/>
      </strong></font></strong></span></td>
    </tr>
    <tr>
      <td height="28" colspan="3" align="center">&nbsp;</td>
    </tr>
  </table>
    <input type="hidden" name="MM_update" value="form1">
    <input type="hidden" name="MM_recordId" value="<%= tpasien.Fields.Item("nocm").Value %>">
    <input type="hidden" name="MM_recordId1" value="<%= tpasien.Fields.Item("krumahsakit").Value %>">
    <input type="hidden" name="ckrumahsakit" value="<%= tpasien.Fields.Item("krumahsakit").Value %>">
    
	<div  id="cumurku">
    	<input type="hidden" name="cumurku" id="cumurku" value="0">
	</div>            
 	<div  id="cnomercmku">
    	<input type="hidden" name="cnomercmku" id="cnomercmku" value="xxxxxx">
	</div>            
   
    <strong><strong>
    <input type="hidden" name="cktujuan" id="cktujuan" />
    </strong></strong>

<input type="hidden" name="cuserid" id="cuserid"  value="<%=cuserid%>">
	<div  id="csessionku">
    	<input type="hidden" name="csessionku" id="csessionku" value="">
	</div>            

                <input name="ckondisiku" type="hidden" id="ckondisiku" value="" />
				<input type="hidden" name="cnourutmenu" id="cnourutmenu"  value="<%=cnourutmenu%>">

</form>



                    </center><br />
                </div>
            </div>

            <div style="padding: 20px;text-align:center;">
 								&copy; Design By |<font size="+1"><span class="fontjudul2" style="font-size:20px"> Kalboya@yahoo.com </span> </font>

            </div>
		</div>
		<!--End Content-->
	</div>
</div>
</html>
<%
tpegawaiLOGIN.Close()
Set tpegawaiLOGIN = Nothing
%>
<!--#include file="../include/tableMENUBAWAH.asp" -->


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
tasuransi.Close()
Set tasuransi = Nothing
%>
<%
ttujuan.Close()
Set ttujuan = Nothing
%>
<%
tpasien.Close()
Set tpasien = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
