<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas2"
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
' nourut menu input pendaftaran
cnourutmenu=request.QueryString("cnourutmenu")

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
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,kkelas,statustransaksi,statuspasien FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cnocm=(trawatpasien.Fields.Item("nocm").Value)
cstatuspasien=trim(trawatpasien.Fields.Item("statuspasien").Value)

if cstatuspasien="1" then
	cjudulform="Daftar  "&cjudulform & " Rawat Jalan"
else
	cjudulform="Daftar "&cjudulform & " Rawat Inap"

end if

%>


<% 
cnotrans=request.QueryString("cnotrans")
citem=request.QueryString("citem")
ckgoltindakan=request.QueryString("ckgoltindakan")

if ckgoltindakan="05" then
	ckolomhidden0="show"
else
	ckolomhidden0="none"
end if

if ckgoltindakan="05" or ckgoltindakan="10" then
	ckolomhidden1="show"
	ckolomhidden2="show"
	ckolomhidden3="show"
else
	ckolomhidden1="none"
	ckolomhidden2="none"
	ckolomhidden3="none"
end if


if ckgoltindakan="03" or ckgoltindakan="05" or ckgoltindakan="06"  or ckgoltindakan="07" or ckgoltindakan="08" or ckgoltindakan="10" or ckgoltindakan="11" then
	ckolomhidden4="show"
	ckolomtrue01=""
else
	ckolomhidden4="none"
	ckolomtrue01="hidden='true'"

end if


' kolom dokter
if ckgoltindakan="01" or  ckgoltindakan="02" or ckgoltindakan="09" or ckgoltindakan="12" or ckgoltindakan="13" then
	ckolomtrue02="hidden='true'"
else
	ckolomtrue02=""
end if

' kolom notranstindakan
if ckgoltindakan="05" then
	ckolomtrue03=""
else
	ckolomtrue03="hidden='true'"
end if

if ckgoltindakan="11" then
	cnamatindakan="Visite Dokter"
else
	cnamatindakan="Tindakan"
end if

if ckgoltindakan="10" then
	cketeranganpemeriksaan="Kesan"
else
	cketeranganpemeriksaan="Keterangan"
end if


%>

<%
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("select sum(tarif) as totaltindakan from tinputtindakan where kgoltindakan='05' and notrans='"&Request.QueryString("cnotrans")&"'") 
	if isnull(tnourut2("totaltindakan"))=true then
		totaltindakan=0
	else
	  	totaltindakan=tnourut2("totaltindakan")	
	end if
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
ttindakan__MMColParam1=ckgoltindakan
ttindakan__MMColParam2 = ckjenistindakan
%>
<%
Dim ttindakan
Dim ttindakan_cmd
Dim ttindakan_numRows

Set ttindakan_cmd = Server.CreateObject ("ADODB.Command")
ttindakan_cmd.ActiveConnection = MM_datarspermata_STRING
ttindakan_cmd.CommandText = "SELECT * FROM rspermata.ttindakan WHERE  kgoltindakan like ? and kjenistindakan like '%"&ckjenistindakan&"%'  ORDER BY tindakan ASC" 
ttindakan_cmd.Prepared = true
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param1", 200, 1, 255, "%" + ttindakan__MMColParam1 + "%") ' adVarChar

Set ttindakan = ttindakan_cmd.Execute
ttindakan_numRows = 0
%>
<%
cdaftartarif=""
While (NOT ttindakan.EOF)
  cdaftartarif=cdaftartarif&" "&"kode"&(ttindakan.Fields.Item("ktindakan").Value)&(ttindakan.Fields.Item("tarif").Value)
  ttindakan.MoveNext()
Wend
If (ttindakan.CursorType > 0) Then
  ttindakan.MoveFirst
Else
  ttindakan.Requery
End If
%>



<%
Dim tgoltindakan
Dim tgoltindakan_cmd
Dim tgoltindakan_numRows

Set tgoltindakan_cmd = Server.CreateObject ("ADODB.Command")
tgoltindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tgoltindakan_cmd.CommandText = "SELECT * FROM rspermata.tgoltindakan where kgoltindakan ='"&ckgoltindakan&"' order by goltindakan " 
tgoltindakan_cmd.Prepared = true

Set tgoltindakan = tgoltindakan_cmd.Execute
tgoltindakan_numRows = 0
%>
<%
Dim tjenistindakan
Dim tjenistindakan_cmd
Dim tjenistindakan_numRows

Set tjenistindakan_cmd = Server.CreateObject ("ADODB.Command")
tjenistindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tjenistindakan_cmd.CommandText = "SELECT * FROM rspermata.tjenistindakan  where kgoltindakan ='"&ckgoltindakan&"'" 
tjenistindakan_cmd.Prepared = true

Set tjenistindakan = tjenistindakan_cmd.Execute
tjenistindakan_numRows = 0
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
if ckgoltindakan="03" OR ckgoltindakan="05" OR ckgoltindakan="06"  or ckgoltindakan="07"  or ckgoltindakan="08" OR ckgoltindakan="10" OR ckgoltindakan="11" then
  tdokter__MMColParam = "02"
else
  tdokter__MMColParam = "XX"
end if  
%>
<%
Dim tdokter
Dim tdokter_cmd
Dim tdokter_numRows

Set tdokter_cmd = Server.CreateObject ("ADODB.Command")
tdokter_cmd.ActiveConnection = MM_datarspermata_STRING
tdokter_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE jabatan = ?" 
tdokter_cmd.Prepared = true
tdokter_cmd.Parameters.Append tdokter_cmd.CreateParameter("param1", 200, 1, 6, tdokter__MMColParam) ' adVarChar

Set tdokter = tdokter_cmd.Execute
tdokter_numRows = 0
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
				if  (ckondisiku=='CARI'){
					simpandata2();
					}
				else {
					inputdata();
					}
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
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
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

 function ajaxFunction(cgoltindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url="../include/comboJENISTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("ckjenistindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);



var xmlHttp1;  
   try    {xmlHttp1=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp1=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url1="../include/comboTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url1=url1+"&sid="+Math.random()	
   xmlHttp1.onreadystatechange=function()      
   {if(xmlHttp1.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp1.responseText;}
   } 
    xmlHttp1.open("GET",url1,true);    xmlHttp1.send(null);	
   }  


 function ajaxFunction1(cjenistindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var jenistindakanku=cjenistindakan
   var ckgoltindakanku = document.forms['form1'].elements['ckgoltindakan'].value;
   url="../include/comboTINDAKAN1.asp?ckjenistindakan="+jenistindakanku+"&ckgoltindakan="+ckgoltindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  


function refreshtable()
{
	var cnotrans='<%=(cnotrans)%>';

	var ctanggal1 = document.forms['form1'].elements['ctanggal1'].value;
	var ctanggal2 = document.forms['form1'].elements['ctanggal2'].value;
	var cnotranstindakan = document.forms['form1'].elements['cnotranstindakan'].value;
	
	var ckjenistindakan = document.forms['form1'].elements['ckjenistindakan'].value;
	var ckgoltindakan = document.forms['form1'].elements['ckgoltindakan'].value;
	
	var cktindakan = document.forms['form1'].elements['cktindakan'].value;
	var cdokter = document.forms['form1'].elements['ckdokter'].value;
	var cpemeriksaan = document.forms['form1'].elements['cpemeriksaan'].value;
	var chasil = document.forms['form1'].elements['chasil'].value;
	
	var cstatustanggal = document.getElementById("cstatustanggal").checked;
//alert(cstatustanggal);


	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?ctanggal1='+encodeURIComponent(ctanggal1)+'&ctanggal2='+encodeURIComponent(ctanggal2)+'&cktindakan='+encodeURIComponent(cktindakan)+'&cpemeriksaan='+encodeURIComponent(cpemeriksaan)+'&chasil='+encodeURIComponent(chasil)+'&cdokter='+encodeURIComponent(cdokter)+'&ckgoltindakan='+encodeURIComponent(ckgoltindakan)+'&ckjenistindakan='+encodeURIComponent(ckjenistindakan)+'&cnotrans='+encodeURIComponent(cnotrans)+'&cnotranstindakan='+encodeURIComponent(cnotranstindakan)+'&cstatustanggal='+encodeURIComponent(cstatustanggal)+'&ctabel=transaksi01B',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');


}

function simpandata2()
{
	refreshtable();
}


function inputdata()
{


var ckgoltindakan='<%=(ckgoltindakan)%>';
var cnotrans='<%=(cnotrans)%>';
var cnotranstindakan='<%=(cnotranstindakan)%>';
var cnourut='<%=(cnourut)%>';

var citem='<%=(citem)%>';

window.location = "../inputdata/inputpemeriksaanpenunjangpasien2.asp?cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ckgoltindakan=<%=ckgoltindakan%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
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

<body onload="doOnLoad();" onfocus="parent_disable();" onclick="parent_disable();">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>

	<script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctanggal1","ctanggal2"]);
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
    <td width="3%" >&nbsp;</td>
    <td width="19%" >Ruangan</td>
    <td width="1%"> :</td>
    <td><%
While (NOT tkelas.EOF)
	if (tkelas.Fields.Item("Kkelas").Value)=(trawatpasien.Fields.Item("kkelas").Value) then
		response.write(tkelas.Fields.Item("kelas").Value)
	end if
  	tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Notrans</td>
    <td >:</td>
    <td ><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >NoCM</td>
    <td>:</td>
    <td ><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Nama</td>
    <td>:</td>
    <td ><%=(trawatpasien.Fields.Item("nama").Value)%></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Alamat</td>
    <td>:</td>
    <td ><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Umur</td>
    <td>:</td>
    <td ><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
  </tr>
   <tr style="display: <%=ckolomhidden0%>;">
    <td >&nbsp;</td>
    <td ><span class="style3">Total Lab.</span></td>
    <td>&nbsp;</td>
    <td ><span class="style4">Rp. <%= FormatNumber(totaltindakan, 2, -2, -2, -1) %></span></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td colspan="3" ><hr /></td>
    </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Dari Tanggal</td>
    <td>:</td>
    <td><input name="ctanggal1" type="text" id="ctanggal1" value="<%= DoDateTime((date()), 2, 7177) %>" size="13" maxlength="10" />       
      Sampai Tanggal : 
      <input name="ctanggal2" type="text" id="ctanggal2" value="<%= DoDateTime((date()), 2, 7177) %>" size="13" maxlength="10" />
      <input type="checkbox" name="cstatustanggal" id="cstatustanggal" />
      <label for="cstatustanggal">Pencarian Tanpa Periode Tanggal</label></td>
  </tr>

 <tr style="display: <%=ckolomhidden1%>;">
    <td >&nbsp;</td>
    <td >Notrans Tindakan</td>
    <td>:</td>
    <td><input name="cnotranstindakan" type="text" id="cnotranstindakan" size="20" maxlength="20" /></td>
  </tr>

 
  <tr>
    <td width="3%" >&nbsp;</td>
    <td width="19%" >Golongan Tindakan</td>
    <td width="1%">:</td>
    <td width="77%"><select name="ckgoltindakan" id="ckgoltindakan" onChange="ajaxFunction(this.value)">
      <%
While (NOT tgoltindakan.EOF)
%>
      <option value="<%=(tgoltindakan.Fields.Item("kgoltindakan").Value)%>" <%If (Not isNull(ckgoltindakan)) Then If (CStr(tgoltindakan.Fields.Item("kgoltindakan").Value) = ckgoltindakan) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tgoltindakan.Fields.Item("goltindakan").Value)%></option>
      <%
  tgoltindakan.MoveNext()
Wend
If (tgoltindakan.CursorType > 0) Then
  tgoltindakan.MoveFirst
Else
  tgoltindakan.Requery
End If
%>
      </select></td>
  </tr>
  <tr style="display: <%=ckolomhidden2%>;">
    <td >&nbsp;</td>
    <td >Jenis  Tindakan</td>
    <td>:</td>
    <td><div  id="ckjenistindakan">
      <select name="ckjenistindakan" id="ckjenistindakan" onChange="ajaxFunction1(this.value)">
        <option value="" 
        </option>
        <%                
While (NOT tjenistindakan.EOF)
%>
        <option value="<%=(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value)%>" <%If (Not isNull(ckjenistindakan)) Then If (CStr(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value) = ckjenistindakan) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tjenistindakan.Fields.Item("JENISTINDAKAN").Value)%></option>
        <%
  tjenistindakan.MoveNext()
Wend
If (tjenistindakan.CursorType > 0) Then
  tjenistindakan.MoveFirst
Else
  tjenistindakan.Requery
End If
%>
      </select>
    </div></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td ><%=cnamatindakan%></td>
    <td>:</td>
    <td><div  id="cktindakan">
      <select name="cktindakan" id="cktindakan" >
        <option value="" 
        </option>
        <%
While (NOT ttindakan.EOF)
%>
        <option value="<%=(ttindakan.Fields.Item("KTINDAKAN").Value)%>"><%=(ttindakan.Fields.Item("TINDAKAN").Value)%></option>
        <%
  ttindakan.MoveNext()
Wend
If (ttindakan.CursorType > 0) Then
  ttindakan.MoveFirst
Else
  ttindakan.Requery
End If
%>
      </select>
    </div></td>
  </tr>
  <tr style="display: <%=ckolomhidden3%>;">
    <td >&nbsp;</td>
    <td >Hasil</td>
    <td>:</td>
    <td><input name="chasil" type="text" id="chasil" size="80" maxlength="80" /></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td ><%=cketeranganpemeriksaan%></td>
    <td>:</td>
    <td><input name="cpemeriksaan" type="text" id="cpemeriksaan" size="80" maxlength="80" /></td>
  </tr>

  <tr style="display: <%=ckolomhidden4%>;">
                <td >&nbsp;</td>
                <td >Dokter</td>
                <td>:</td>
                <td><select name="ckdokter" id="ckdokter">
                  <option value=""></option>
                  <%
While (NOT tdokter.EOF)
%>
                  <option value="<%=(tdokter.Fields.Item("nourut").Value)%>" <%If (Not isNull(ckdokter)) Then If (CStr(tdokter.Fields.Item("nourut").Value) = ckdokter) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tdokter.Fields.Item("nama").Value)%></option>
                  <%
  tdokter.MoveNext()
Wend
If (tdokter.CursorType > 0) Then
  tdokter.MoveFirst
Else
  tdokter.Requery
End If
%>
                </select></td>
              </tr>
  <tr >
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr >
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td>
	<input type="button" name="simpan" id="simpan" value="O K" onClick="simpandata1('CARI')" class="tombolku2" />
</td>
  </tr>
  <tr >
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
 
  </table>
<p>&nbsp;</p>
<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="<%=cjudulform%>"  idField="notrans"    url="../include/daftartransaksiJSON.asp?ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ctabel=transaksi01B"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:40" align="center"  formatter="linkrawatjalan">No</th>
<th field="notranstindakan" width="120px" align="center" sortable="true" <%=ckolomtrue03%>>Notrans Tindakan</th>
<th field="tgltrans" width="100px" align="center" sortable="true" >Tgl Tindakan</th>
<% if ckgoltindakan="03" or ckgoltindakan="05" or ckgoltindakan="07" or ckgoltindakan="10" then%>
<th field="TINDAKAN" width="250px" align="left" sortable="true"><%=cnamatindakan%></th>
<% else %>
<th field="TINDAKAN" width="400px" align="left" sortable="true"><%=cnamatindakan%></th>
<% end if %>

</tr>
</thead >
<thead >
<tr>
<th field="hasil" width="275px" align="left" sortable="true"  formatter="formatA" <%=ckolomtrue01%>>Hasil</th>

<% if ckgoltindakan="03" or ckgoltindakan="05" or ckgoltindakan="07" or ckgoltindakan="10" then%>
<th field="pemeriksaan" width="225px" align="left" sortable="true" ><%=cketeranganpemeriksaan%></th>
<% else %>
<th field="pemeriksaan" width="400px" align="left" sortable="true" ><%=cketeranganpemeriksaan%></th>
<% end if %>

<th field="dokter" width="200px" align="left" sortable="true" <%=ckolomtrue01%>>Dokter</th>
<th field="tarif" width="90px" align="right" sortable="true" >Tarif</th>
<th field="kgoltindakan" width="50px" align="left" sortable="true" hidden="true">kgoltindakan</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="notrans" width="100px" align="center" sortable="true" hidden="true" >Notrans</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnotranstindakan = row.notranstindakan;
    var cnourut = row.nourut;
    var ckgoltindakan = row.kgoltindakan;
	var cnourutmenu = <%=cnourutmenu%>;
     var cstatuspasien = <%=cstatuspasien%>;
	if (ckgoltindakan == '05' || ckgoltindakan=='09' || ckgoltindakan=='10') {
	    var url = '../editdata/editpemeriksaanpenunjangpasien.asp?cnotrans='+cnotrans+'&cnotranstindakan='+cnotranstindakan+'&cnourut='+cnourut+'&ckgoltindakan='+ckgoltindakan+'&cstatuspasien='+cstatuspasien+'&citem=<%=citem%>'+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
	}	
	else {
	    var url = '../editdata/edittindakanpasien.asp?cnotrans='+cnotrans+'&cnotranstindakan='+cnotranstindakan+'&cnourut='+cnourut+'&ckgoltindakan='+ckgoltindakan+'&cstatuspasien='+cstatuspasien+'&citem=<%=citem%>'+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
	}
}	
function formatA(value,row,index){  
            return '<span cellhasil='+index+' class="easyui-tooltip">' + value + '</span>';  
}  	
</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

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
ttindakan.Close()
Set ttindakan = Nothing
%>

<%
tgoltindakan.Close()
Set tgoltindakan = Nothing
%>
<%
tjenistindakan.Close()
Set tjenistindakan = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
tdokter.Close()
Set tdokter = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
