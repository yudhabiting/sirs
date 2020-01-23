<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas2"
cnotrans=request.QueryString("cnotrans")
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
trawatpasien_cmd.CommandText = "SELECT *,coalesce(administrasi,0) as administrasi, coalesce(totalruangan,0) as totalruangan,coalesce(totaltindakan,0) as totaltindakan, coalesce(totalobat,0) as totalobat, coalesce(total,0) as total FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 5, 1, -1, trawatpasien__MMColParam) ' adDouble

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cnocm=(trawatpasien.Fields.Item("nocm").Value)
cstatuspasien=(trawatpasien.Fields.Item("statuspasien").Value)
if cstatuspasien="2" then
	cjudulform="Edit Pasien Rawat Inap"
else
	cjudulform="Edit Pasien Rawat Jalan"
end if
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
  MM_editTable = "rspermata.trawatpasien"
  MM_editColumn = "notrans"
  MM_recordId = "'" + Request.Form("MM_recordId") + "'"
  MM_editRedirectUrl = "editrawatpasien.asp"
  MM_fieldsStr  = "cstatuspasien|value|cktujuan|value|ckkelas|value|cnopas|value|cnoasuransi|value|cnosep|value|ctglmasuk|value|ctglkeluar|value|cnama|value|calamat|value|ckkecamatan|value|ckkelurahan|value|ctgllahir|value|cumurthn|value|cumurbln|value|cumurhr|value|cjeniskel|value|corangtua|value|ckkelompok|value|ckasuransi|value|csyaratasuransi|value|ckunjungan|value|ctinggibadan|value|cberatbadan|value|cgejala|value|canamnese|value|ckasus|value|ckpenyakiticd1|value|ckodeicd1|value|cpenyakiticd1|value|ckpenyakiticd2|value|ckodeicd2|value|cpenyakiticd2|value|ckpenyakit2|value|cterapi|value|ckpegawai|value|ckspesialisasi|value|cadministrasi|value|ctotalinacbg|value|ckeluar|value|ccarakeluar|value|ckarcis|value|ckrumahsakit|value|cnocm|value|cnik|value|cpekerjaan|value|ctelp|value|criwayatpenyakit|value|ckpengirim|value"
  MM_columnsStr = "statuspasien|',none,''|ktujuan|',none,''|kkelas|',none,''|nopas|',none,''|noasuransi|',none,''|nosep|',none,''|tglmasuk|',none,NULL|tglkeluar|',none,NULL|nama|',none,''|alamat|',none,''|kkecamatan|',none,''|kkelurahan|',none,''|tgllahir|',none,NULL|umurthn|none,none,NULL|umurbln|none,none,NULL|umurhr|none,none,NULL|jeniskel|',none,''|orangtua|',none,''|kkelompok|',none,''|kasuransi|',none,''|syaratasuransi|',none,''|kunjungan|',none,''|tinggibadan|none,none,NULL|beratbadan|none,none,NULL|gejala|',none,''|anamnese|',none,''|kasus|',none,''|kpenyakiticd1|',none,''|kodeicd1|',none,''|penyakiticd1|',none,''|kpenyakiticd2|',none,''|kodeicd2|',none,''|penyakiticd2|',none,''|kpenyakit2|',none,''|terapi|',none,''|kpegawai|',none,''|kspesialisasi|',none,''|administrasi|none,none,NULL|totalinacbg|none,none,NULL|keluar|',none,''|carakeluar|',none,''|karcis|none,none,NULL|krumahsakit|',none,''|nocm|',none,''|nik|',none,''|pekerjaan|',none,''|telp|',none,''|riwayatpenyakit|',none,''|kpengirim|',none,''"


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
ttujuan_cmd.CommandText = "SELECT * FROM rspermata.ttujuan where tampil='Y' ORDER BY tujuan ASC" 
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
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE jabatan='02'" 
tpegawai_cmd.Prepared = true
tpegawai_cmd.Parameters.Append tpegawai_cmd.CreateParameter("param1", 200, 1, 6, tpegawai__MMColParam) ' adVarChar

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>
<%
Dim tspesialisasi__MMColParam
tspesialisasi__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tspesialisasi__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tspesialisasi
Dim tspesialisasi_cmd
Dim tspesialisasi_numRows

Set tspesialisasi_cmd = Server.CreateObject ("ADODB.Command")
tspesialisasi_cmd.ActiveConnection = MM_datarspermata_STRING
tspesialisasi_cmd.CommandText = "SELECT * FROM rspermata.tspesialisasi"
tspesialisasi_cmd.Prepared = true
tspesialisasi_cmd.Parameters.Append tspesialisasi_cmd.CreateParameter("param1", 200, 1, 6, tspesialisasi__MMColParam) ' adVarChar

Set tspesialisasi = tspesialisasi_cmd.Execute
tspesialisasi_numRows = 0
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

		else {
			simpandata2();
		}



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


function onDblClickRowGRID1(index,row) {
	ckpenyakiticd = row.kpenyakiticd;
	ckodeicd = row.kodeicd;
	cpenyakiticd = row.penyakiticd;
	document.forms['form1'].elements['ckpenyakiticd1'].value=ckpenyakiticd;
	document.forms['form1'].elements['ckodeicd1'].value=ckodeicd;
	document.forms['form1'].elements['cpenyakiticd1'].value=cpenyakiticd;
}

function onDblClickRowGRID2(index,row) {
	ckpenyakiticd = row.kpenyakiticd;
	ckodeicd = row.kodeicd;
	cpenyakiticd = row.penyakiticd;
	document.forms['form1'].elements['ckpenyakiticd2'].value=ckpenyakiticd;
	document.forms['form1'].elements['ckodeicd2'].value=ckodeicd;
	document.forms['form1'].elements['cpenyakiticd2'].value=cpenyakiticd;
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

function simpandata2()
{
var cnama = document.forms['form1'].elements['cnama'].value;
var ctglmasuk = document.forms['form1'].elements['ctglmasuk'].value;
var ckarcis = document.forms['form1'].elements['ckarcis'].value;
var cumurthn = document.forms['form1'].elements['cumurthn'].value;
var cumurbln = document.forms['form1'].elements['cumurbln'].value;
var cumurhr = document.forms['form1'].elements['cumurhr'].value;
var ckkelompok = document.forms['form1'].elements['ckkelompok'].value;
var csyaratasuransi = document.forms['form1'].elements['csyaratasuransi'].value;
var ctinggibadan = document.forms['form1'].elements['ctinggibadan'].value;
var cberatbadan = document.forms['form1'].elements['cberatbadan'].value;
var ctotalinacbg = document.forms['form1'].elements['ctotalinacbg'].value;
if (ckkelompok == '2' || ckkelompok == '3') {
	document.forms['form1'].elements['ctotalinacbg'].value=ctotalinacbg;
}
else {
	document.forms['form1'].elements['ctotalinacbg'].value=0;
}

 
if (cnama == '') {
alert("Nama kosong, mohon dicek")
document.forms['form1'].elements['cnama'].focus();
return false;
}
else if (ctglmasuk == '') {
alert("Tgl Daftar kosong, mohon dicek")
document.forms['form1'].elements['ctglmasuk'].focus();
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
	var ctanggal = document.forms['form1'].elements['ctglmasuk'].value;
	if (isValidDate(ctanggal)==false){
		document.forms['form1'].elements['ctglmasuk'].focus();
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
document.form1.ctglmasuk.value=year+'/'+month+'/'+date;
}

// End -->
</script>

<body onload="doOnLoad();tglsekarang()">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk","ctgllahir"]);
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
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><div align="right" >Status Berobat </div></td>
              <td><div align="center" >:</div></td>
              <td><select name="cstatuspasien" id="cstatuspasien">
                <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("statuspasien").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("statuspasien").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Jalan</option>
                <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("statuspasien").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("statuspasien").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Inap</option>
              </select></td>
            </tr>
            <tr>
              <td><div align="right" >Tujuan  Berobat </div></td>
              <td><div align="center" >:</div></td>
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
              <td><div align="right" > Ruangan </div></td>
              <td><div align="center" >:</div></td>
              <td>
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
              </td>
            </tr>
            <tr>
              <td width="16%"><div align="right" >
                Notrans
              </div></td>
              <td width="3%"><div align="center" >:</div></td>
              <td width="81%"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
            </tr>
            <tr>
              <td><div align="right" >Nocm</div></td>
              <td><div align="center" >:</div></td>
              <td class="style3"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
            </tr>
            <tr>
              <td><div align="right" >Nopas</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cnopas" type="text" id="cnopas" value="<%=(trawatpasien.Fields.Item("nopas").Value)%>" /></td>
            </tr>
            <tr>
              <td><div align="right" >No Asuransi</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cnoasuransi" type="text" id="cnoasuransi" value="<%=(trawatpasien.Fields.Item("noasuransi").Value)%>" /></td>
            </tr>
			<tr>
              <td><div align="right" >No SEP</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cnosep" type="text" id="cnosep" value="<%=(trawatpasien.Fields.Item("nosep").Value)%>" /></td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right">No 
                Identitas</div></td>
              <td><div align="center">:</div></td>
              <td><input name="cnik" type="text" id="cnik" value="<%=(trawatpasien.Fields.Item("nik").Value)%>"  maxlength="20"  size="30"/></td>
            </tr>
            <tr>
              <td><div align="right" >Tgl Masuk </div></td>
              <td><div align="center" >:</div></td>
              <td>	
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk","ctglkeluar","ctgllahir"]);
		}
	</script>

			  <div align="left" >
                <input name="ctglmasuk" type="text" id="ctglmasuk" value="<%= DoDateTime((trawatpasien.Fields.Item("tglmasuk").Value), 2, 7177) %>" size="15" maxlength="10" />
              <span >Jam
              <input name="cjamdaftar" type="text" id="cjamdaftar" value="<%= FormatDateTime(trawatpasien.Fields.Item("jammasuk").Value,3) %>" size="10" maxlength="8" />
              </div></td>
            </tr>
            <tr>
              <td><div align="right" >Tgl Keluar </div></td>
              <td><div align="center" >:</div></td>
              <td><div align="left">
                <input name="ctglkeluar" type="text" id="ctglkeluar" value="<%= DoDateTime((trawatpasien.Fields.Item("tglkeluar").Value), 2, 7177) %>" size="15" />
              </div></td>
            </tr>
            <tr>
              <td><div align="right" >Nama </div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cnama" type="text" id="cnama" size="70" value="<%=(trawatpasien.Fields.Item("nama").Value)%>"  /></td>
            </tr>
            <tr>
              <td><div align="right" >Alamat</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="calamat" type="text" id="calamat" size="100" value="<%=(trawatpasien.Fields.Item("alamat").Value)%>"  /></td>
            </tr>
            <tr>
              <td height="26" align="center"><div align="right" >Kecamatan</div></td>
              <td><div align="center">:</div></td>
              <td><span >
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
              </td>
            </tr>
            <tr>
              <td height="26" align="center"><div align="right" >Kelurahan</div></td>
              <td><div align="center">:</div></td>
              <td><div  id="ckkelurahan"> 
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
              </div></td>
            </tr>
            
       <tr>
        <td height="24" align="center"><div align="right">Tgl Lahir</div></td>
        <td align="center"><strong>:</strong></td>
        <td><input name="ctgllahir" type="text" id="ctgllahir" size="10" maxlength="10" value="<%= DoDateTime((trawatpasien.Fields.Item("tgllahir").Value), 2, 7177) %>">
          <input type="button" name="button" id="button" value="Hitung Umur" onClick="hitungusia()"></td>
      </tr>


            <tr>
              <td><div align="right" >Umur Tahun </div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cumurthn" type="text" id="cumurthn" value="<%=(trawatpasien.Fields.Item("umurthn").Value)%>"  /></td>
            </tr>
            <tr>
              <td><div align="right" >Umur Bulan </div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cumurbln" type="text" id="cumurbln" value="<%=(trawatpasien.Fields.Item("umurbln").Value)%>"  /></td>
            </tr>
            <tr>
              <td><div align="right" >Umur Hari </div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cumurhr" type="text" id="cumurhr" value="<%=(trawatpasien.Fields.Item("umurhr").Value)%>"  /></td>
            </tr>
            <tr>
              <td><div align="right" >Jenis Kelamin </div></td>
              <td><div align="center" >:</div></td>
              <td><select name="cjeniskel" id="cjeniskel">
                <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("jeniskel").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("jeniskel").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Laki-laki</option>
                <option value="P" <%If (Not isNull((trawatpasien.Fields.Item("jeniskel").Value))) Then If ("P" = CStr((trawatpasien.Fields.Item("jeniskel").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Perempuan</option>
              </select></td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right">Pekerjaan</div></td>
              <td><div align="center">:</div></td>
              <td>
                <input name="cpekerjaan" type="text" id="cpekerjaan" value="<%=(trawatpasien.Fields.Item("pekerjaan").Value)%>" size="30" maxlength="30" />
              </td>
            </tr>
            <tr>
              <td height="24" align="center"><div align="right">Telp</div></td>
              <td><div align="center">:</div></td>
              <td><input name="ctelp" type="text" id="ctelp" value="<%=(trawatpasien.Fields.Item("telp").Value)%>" maxlength="15" /></td>
            </tr>
            <tr>
              <td align="center"><div align="right" >Orang Tua / Suami</div></td>
              <td><div align="center">:</div></td>
              <td>
                <input name="corangtua" type="text" id="corangtua" value="<%=(trawatpasien.Fields.Item("orangtua").Value)%>"  maxlength="30" />
              </td>
            </tr>
            <tr>
              <td><div align="right" >Kelompok </div></td>
              <td><div align="center" >:</div></td>
              <td>
                <select name="ckkelompok" id="ckkelompok" onchange="ubahasuransi(this.value)">
 		<option value=""></option>
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
              </td>
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
                  <option value="<%=(tasuransi.Fields.Item("kasuransi").Value)%>" <%If (Not isNull((trawatpasien.Fields.Item("kasuransi").Value))) Then If (CStr(tasuransi.Fields.Item("kasuransi").Value) = CStr((trawatpasien.Fields.Item("kasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tasuransi.Fields.Item("asuransi").Value)%></option>
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
              <td height="28" align="center"><div align="right" >Syarat Asuransi</div></td>
              <td><div align="center" >:</div></td>
              <td>
                <select name="csyaratasuransi" id="csyaratasuransi">
                  <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("syaratasuransi").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Belum Menyerahkan</option>
                  <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("syaratasuransi").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Sudah Menyerahkan</option>
                  <option value="0" <%If (Not isNull((trawatpasien.Fields.Item("syaratasuransi").Value))) Then If ("0" = CStr((trawatpasien.Fields.Item("syaratasuransi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
                </select>
              </td>
            </tr>


            <tr>
              <td colspan=3>
<hr>
              </td>
            </tr>
			
            <tr>
              <td height="28" align="center"><div align="right" >Kunjungan</div></td>
              <td><div align="center" >:</div></td>
              <td>
                <select name="ckunjungan" id="ckunjungan">
                  <option value="B" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("B" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Baru</option>
                  <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Kunjungan Lama</option>
                  <option value="" <%If (Not isNull((trawatpasien.Fields.Item("kunjungan").Value))) Then If ("" = CStr((trawatpasien.Fields.Item("kunjungan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
                </select>
              </td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" >Tinggi Badan</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="ctinggibadan" type="text" id="ctinggibadan" value="<%= (trawatpasien.Fields.Item("tinggibadan").Value) %>" size="10" maxlength="10" onBlur="koma1()"/>
              <span class="styleku1">Cm</td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" >Berat Badan</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cberatbadan" type="text" id="cberatbadan" value="<%= (trawatpasien.Fields.Item("beratbadan").Value) %>" size="10" maxlength="10"  onblur="koma2()"/> 
              <span class="styleku1">Kg</td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" >Anamnese</div></td>
              <td><div align="center" >:</div></td>
              <td><textarea name="canamnese" id="canamnese" cols="60" rows="5"><%= (trawatpasien.Fields.Item("anamnese").Value) %></textarea></td>
            </tr>
            <tr>
              <td height="28" align="center"><div align="right" >Riwayat Penyakit</div></td>
              <td><div align="center" >:</div></td>
              <td><textarea name="criwayatpenyakit" id="criwayatpenyakit" cols="60" rows="3"><%= (trawatpasien.Fields.Item("riwayatpenyakit").Value) %></textarea></td>
            </tr>
            <tr>
              <td><div align="right" >Kasus Penyakit </div></td>
              <td><div align="center" >:</div></td>
              <td><select name="ckasus" id="ckasus">
                <option value="B" <%If (Not isNull((trawatpasien.Fields.Item("kasus").Value))) Then If ("B" = CStr((trawatpasien.Fields.Item("kasus").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Baru</option>
                <option value="L" <%If (Not isNull((trawatpasien.Fields.Item("kasus").Value))) Then If ("L" = CStr((trawatpasien.Fields.Item("kasus").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Lama</option>
              </select></td>
            </tr>




            <tr>
              <td><div align="right" > Diagnosa Masuk ICD X</div></td>
              <td><div align="center" >:</div></td>
              <td><div align="left">
 <input id="ckpenyakiticd1A" name="ckpenyakiticd1A" style="width:500px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:900,
                panelHeight:350,
                url: '../include/comboLISTDATAmaster.asp?ctabel=tabel07&ctampil=Y&ckpenyakiticd1=XXX',
                idField:'kpenyakiticd',
                textField:'penyakiticd',
                fitColumns:true,
                mode:'remote',
		pagePosition:top,
                method:'get',
                pagination:true,
                columns:[[
                    {field:'kpenyakiticd',title:'No Urut',width:10,sortable:true},
                    {field:'kodeicd',title:'Kode ICD',width:20,sortable:true},
                    {field:'penyakiticd',title:'Penyakit',width:100,sortable:true}
                ]],
                onSelect:onDblClickRowGRID1
 	">
</input>
<script type="text/javascript">
$(function(){
$('#ckpenyakiticd1A').combogrid('setValue', '<%=trawatpasien.Fields.Item("penyakiticd1").Value%>');
});
</script>    
Kode ICD : 
<input size="10" readonly="true"  name="ckodeicd1" type="text" id="ckodeicd1" value="<%=trawatpasien.Fields.Item("kodeicd1").Value%>" /> 
<input size="10" readonly="true"  name="cpenyakiticd1" type="hidden" id="cpenyakiticd1" value="<%=trawatpasien.Fields.Item("penyakiticd1").Value%>" />	 						  	
<input size="10" readonly="true"  name="ckpenyakiticd1" type="hidden" id="ckpenyakiticd1" value="<%=trawatpasien.Fields.Item("kpenyakiticd1").Value%>" />	 						  	

              </div></td>
            </tr>


            <tr>
              <td><div align="right" > Diagnosa Keluar ICD X</div></td>
              <td><div align="center" >:</div></td>
              <td><div align="left">
 <input id="ckpenyakiticd2A" name="ckpenyakiticd2A" style="width:500px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:900,
                panelHeight:350,
                url: '../include/comboLISTDATAmaster.asp?ctabel=tabel07&ctampil=Y&ckpenyakiticd2=XXX',
                idField:'kpenyakiticd',
                textField:'penyakiticd',
                fitColumns:true,
                mode:'remote',
		pagePosition:top,
                method:'get',
                pagination:true,
                columns:[[
                    {field:'kpenyakiticd',title:'No Urut',width:10,sortable:true},
                    {field:'kodeicd',title:'Kode ICD',width:20,sortable:true},
                    {field:'penyakiticd',title:'Penyakit',width:100,sortable:true}
                ]],
                onSelect:onDblClickRowGRID2
 	">
</input>
<script type="text/javascript">
$(function(){
$('#ckpenyakiticd2A').combogrid('setValue', '<%=trawatpasien.Fields.Item("penyakiticd2").Value%>');
});
</script>    
Kode ICD : 
<input size="10" readonly="true"  name="ckodeicd2" type="text" id="ckodeicd2" value="<%=trawatpasien.Fields.Item("kodeicd2").Value%>" /> 
<input size="10" readonly="true"  name="cpenyakiticd2" type="hidden" id="cpenyakiticd2" value="<%=trawatpasien.Fields.Item("penyakiticd2").Value%>" />	 						  	
<input size="10" readonly="true"  name="ckpenyakiticd2" type="hidden" id="ckpenyakiticd2" value="<%=trawatpasien.Fields.Item("kpenyakiticd2").Value%>" />	 						  	

              </div></td>
            </tr>


            <tr>
              <td><div align="right" > Diagnosa Keluar </div></td>
              <td><div align="center" >:</div></td>
              <td><input name="ckpenyakit2" type="text" id="ckpenyakit2" size="68" value="<%=trawatpasien.Fields.Item("kpenyakit2").Value%>"/></td>
            </tr>




            <tr>
              <td><div align="right" > Terapi</div></td>
              <td><div align="center" >:</div></td>
              <td><textarea name="cterapi" id="cterapi" cols="60" rows="5"><%= (trawatpasien.Fields.Item("terapi").Value) %></textarea></td>
            </tr>
            <tr>
              <td><div align="right" > Administrasi</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="cadministrasi" type="text" id="cadministrasi" value="<%=(trawatpasien.Fields.Item("administrasi").Value)%>" /></td>
            </tr>
            <tr>
              <td><div align="right" > Klaim BPJS Sesuai Kelas</div></td>
              <td><div align="center" >:</div></td>
              <td><input name="ctotalinacbg" type="text" id="ctotalinacbg" value="<%=(trawatpasien.Fields.Item("totalinacbg").Value)%>" />
                <span class="fontku2">                khusus pasien BPJS</span></td>
            </tr>

            <tr>
              <td><div align="right" >Keadaan Keluar</div></td>
              <td><div align="center" >:</div></td>
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
              </td>
            </tr>
            <tr>
              <td><div align="right" >Cara Keluar </div></td>
              <td><div align="center" >:</div></td>
              <td><span class="style13">
                <select name="ccarakeluar" id="ccarakeluar">
                  <option value=" " <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If (" " = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>> </option>
                  <option value="1" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("1" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Diijinkan Pulang</option>
                  <option value="2" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("2" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pulang Paksa</option>
                  <option value="3" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("3" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Dirujuk Ke</option>
                  <option value="4" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("4" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Lari</option>
                  <option value="5" <%If (Not isNull((trawatpasien.Fields.Item("carakeluar").Value))) Then If ("5" = CStr((trawatpasien.Fields.Item("carakeluar").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pindah RS Lain</option>
                </select>
              </td>
            </tr>
            <tr>
              <td><div align="right" > Dokter</div></td>
              <td><div align="center" >:</div></td>
              <td><select name="ckpegawai" id="ckpegawai">
                <%
While (NOT tpegawai.EOF)
%>
                <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull(trawatpasien.Fields.Item("kpegawai").Value)) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr(trawatpasien.Fields.Item("kpegawai").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
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
              <td><div align="right" > Spesialisasi</div></td>
              <td><div align="center" >:</div></td>
              <td><select name="ckspesialisasi" id="ckspesialisasi">
                <%
While (NOT tspesialisasi.EOF)
                <option value="<%=(tspesialisasi.Fields.Item("tspesialisasi").Value)%>" <%If (Not isNull(trawatpasien.Fields.Item("kspesialisasi").Value)) Then If (CStr(tspesialisasi.Fields.Item("nourut").Value) = CStr(trawatpasien.Fields.Item("kspesialisasi").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tspesialisasi.Fields.Item("spesialisasi").Value)%></option>
%>
                <%
  tspesialisasi.MoveNext()
Wend
If (tspesialisasi.CursorType > 0) Then
  tspesialisasi.MoveFirst
Else
  tspesialisasi.Requery
End If
%>
              </select>
		</td>
            </tr>
      <tr>
        <td height="24" align="center"><div align="right">Pengirim</div></td>
        <td><div align="center"><strong>:</strong></div></td>
        <td>


 <input id="ckpengirim" name="ckpengirim" style="width:300px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:900,
                panelHeight:350,
                url: '../include/comboLISTDATAmaster.asp?ctabel=tabel01A&ctampil=Y&ckpengirim=<%=trawatpasien.Fields.Item("kpengirim").Value%>',
                idField:'kpengirim',
                textField:'pengirim',
                fitColumns:true,
                mode:'remote',
		pagePosition:top,
                pagination:true,
                method:'get',
                columns:[[
                    {field:'kpengirim',title:'Kode',width:20,sortable:true},
                    {field:'pengirim',title:'Pengirim',width:100,sortable:true},
                    {field:'alamat',title:'Alamat',width:200,sortable:true}
                ]]
 	">
</input>
<script type="text/javascript">
$(function(){
$('#ckpengirim').combogrid('setValue', '<%=trawatpasien.Fields.Item("kpengirim").Value%>');
});
</script>    
<%
if cstatustransaksi<>"T" then
%>
<input type="button" name="simpan" id="simpan" value="Simpan" onClick="simpandata1()" class="tombolku2"/>
<%
end if
%>
   
          </td>
      </tr>
          </table>
          <input type="hidden" name="MM_update" value="form1" />
          <input type="hidden" name="MM_recordId" value="<%= trawatpasien.Fields.Item("notrans").Value %>" />
          <input name="cnocm" type="hidden" id="cnocm" value="<%=(trawatpasien.Fields.Item("nocm").Value)%>" />
		  <input name="ckarcis" type="hidden" id="ckarcis" value="<%=(trawatpasien.Fields.Item("karcis").Value)%>" />
  <input name="ckrumahsakit" type="hidden" id="ckrumahsakit" value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>" />

		<input name="cgejala" type="hidden" id="cgejala" value="<%= (trawatpasien.Fields.Item("gejala").Value) %>" size="80" maxlength="100" />

	<div  id="cumurku">
    	<input type="hidden" name="cumurku" id="cumurku" value="0">
	</div>            




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
trumahsakit.Close()
Set trumahsakit = Nothing
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
tasuransi.Close()
Set tasuransi = Nothing
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
