<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas3"
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
cnourutmenu=request.QueryString("cnourutmenu")
cstatuspasien=request.QueryString("cstatuspasien")

cnotrans=request.QueryString("cnotrans")
cnourut=request.QueryString("cnourut")
citem=request.QueryString("citem")
ctarifkelas2="tarif"
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
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,statustransaksi,statuspasien FROM rspermata.trawatpasien WHERE notrans = '"&Request.QueryString("cnotrans")&"'"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cstatuspasien=(trawatpasien.Fields.Item("statuspasien").Value)
cnocm=(trawatpasien.Fields.Item("nocm").Value)
cjudulform="Ruangan"
if cstatuspasien="1" then
	cjudulform="Edit  "&cjudulform & " Rawat Jalan"
else
	cjudulform="Edit "&cjudulform & " Rawat Inap"

end if

%>
<%
Dim tkelas
Dim tkelas_numRows

Set tkelas = Server.CreateObject("ADODB.Recordset")
tkelas.ActiveConnection = MM_datarspermata_STRING
tkelas.Source = "SELECT * FROM rspermata.tkelas order by kelas"
tkelas.CursorType = 0
tkelas.CursorLocation = 2
tkelas.LockType = 1
tkelas.Open()

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
Dim tinputkelaspasien
Dim tinputkelaspasien_numRows

Set tinputkelaspasien = Server.CreateObject("ADODB.Recordset")
tinputkelaspasien.ActiveConnection = MM_datarspermata_STRING
tinputkelaspasien.Source = "SELECT * FROM rspermata.tinputkelas WHERE notrans = '"&cnotrans&"' and nourut = '"&cnourut&"' "
tinputkelaspasien.CursorType = 0
tinputkelaspasien.CursorLocation = 2
tinputkelaspasien.LockType = 1
tinputkelaspasien.Open()

tinputkelaspasien_numRows = 0
%>

<%
Dim tpegawai
Dim tpegawai_numRows

Set tpegawai = Server.CreateObject("ADODB.Recordset")
tpegawai.ActiveConnection = MM_datarspermata_STRING
tpegawai.Source = "SELECT * FROM rspermata.tpegawai WHERE nourut = '"&Session("MM_userid")&"' "
tpegawai.CursorType = 0
tpegawai.CursorLocation = 2
tpegawai.LockType = 1
tpegawai.Open()

tpegawai_numRows = 0
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

<link rel="stylesheet" type="text/css" href="../include/CSS/styletombol.css"/>

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
				if (ckondisiku=='HAPUS'){
					hapusdata();
					}
				else if  (ckondisiku=='EDIT'){
					simpandata2();
					}
				else if  (ckondisiku=='HITUNG'){
					hitungtgl();
					}
				else if  (ckondisiku=='INPUT'){
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
//		cjmlhari=cjmlhari+1
		tarifku(document.forms['form1'].elements['ckkelas'].value)
		var ctarif = document.forms['form1'].elements['ctarif'].value;
		document.forms['form1'].elements['cjmlhari'].value=cjmlhari;
		document.forms['form1'].elements['ctarif'].value=cjmlhari*ctarif;
		$('#ctariftitik').numberbox('setValue', cjmlhari*ctarif);			
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
			$('#ctariftitik').numberbox('setValue', jmltarif);			
			
		}
	}
}

function refreshtable()
{
	var cnotrans='<%=(cnotrans)%>';

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?cnotrans='+encodeURIComponent(cnotrans)+'&ctabel=transaksi08',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');

}


function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  

function simpandata2()
{
var ctarif = $('#ctariftitik').numberbox('getValue');
document.forms['form1'].elements['ctarif'].value=ctarif;
//alert(document.forms['form1'].elements['ctarif'].value);


var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctglmasuk'].value;
var ctanggal2 = document.forms['form1'].elements['ctglkeluar'].value;
var cjamkeluar = document.forms['form1'].elements['cjamkeluar'].value;
var cjmlhari = document.forms['form1'].elements['cjmlhari'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
var cket = document.forms['form1'].elements['cket'].value;


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
else if (cnotrans == '') {
alert("Notrans kosong, mohon dicek")
return false;
}
else if (cnourut == '') {
alert("Nourut kosong, mohon dicek")
return false;
}

else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctglmasuk'].focus();
		return false
	}
else if (ckpegawai == '') {
	alert("Petugas Entry Data kosong, mohon dicek")
	document.forms['form1'].elements['ckpegawai'].focus();
	return false;
}

else {
//	document.forms['form1'].submit();

				var xmlhttp;
				if (window.XMLHttpRequest)
				  {// code for IE7+, Firefox, Chrome, Opera, Safari
				  xmlhttp=new XMLHttpRequest();
				  }
				else
				  {// code for IE6, IE5
				  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  }
				xmlhttp.onreadystatechange=function()
				  {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						document.forms['form1'].elements['ckondisiku'].value = '';
						refreshtable();
					}
				 }

					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&ctanggal2="+encodeURIComponent(ctanggal2)+"&cjamkeluar="+encodeURIComponent(cjamkeluar)+"&ckkelas="+encodeURIComponent(ckkelas)+"&cjmlhari="+encodeURIComponent(cjmlhari)+"&ctarif="+encodeURIComponent(ctarif)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cket="+encodeURIComponent(cket)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel18");



}
}


function hapusdata()
{
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctglmasuk'].value;
var ctanggal2 = document.forms['form1'].elements['ctglkeluar'].value;
var cjamkeluar = document.forms['form1'].elements['cjamkeluar'].value;
var cjmlhari = document.forms['form1'].elements['cjmlhari'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
var cket = document.forms['form1'].elements['cket'].value;


if (cnotrans == '') {
	alert("Notrans kosong, mohon dicek")
	return false;
}
else if (cnourut == '') {
	alert("Nourut kosong, mohon dicek")
	return false;
}
else if (ckpegawai == '') {
	alert("Petugas Entry Data kosong, mohon dicek")
	document.forms['form1'].elements['ckpegawai'].focus();
	return false;
}

else {
//	document.forms['form1'].submit();

	var r=confirm("Anda yakin mau menghapus data ini!");
	if (r==true)
	  	{

				var xmlhttp;
				if (window.XMLHttpRequest)
				  {// code for IE7+, Firefox, Chrome, Opera, Safari
				  xmlhttp=new XMLHttpRequest();
				  }
				else
				  {// code for IE6, IE5
				  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  }
				xmlhttp.onreadystatechange=function()
				  {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
					{
//						document.forms['form1'].elements['ckondisiku'].value = '';
//						refreshtable();
						window.location = "../inputdata/inputkelaspasien.asp?cnotrans=<%=cnotrans%>&cnourutmenu=<%=cnourutmenu%>&citem=<%=citem%>";
					}
				 }

					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&ctanggal2="+encodeURIComponent(ctanggal2)+"&cjamkeluar="+encodeURIComponent(cjamkeluar)+"&ckkelas="+encodeURIComponent(ckkelas)+"&cjmlhari="+encodeURIComponent(cjmlhari)+"&ctarif="+encodeURIComponent(ctarif)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cket="+encodeURIComponent(cket)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel19");


	  	}
	}


}



function inputdata()
{
var cstatuspasien ='<%=(cstatuspasien)%>';
var cnotrans='<%=(cnotrans)%>';
var cnourut='<%=(cnourut)%>';
var citem='<%=(citem)%>';
window.location = "../inputdata/inputkelaspasien.asp?cnotrans=<%=cnotrans%>&citem=<%=citem%>";
	
}

function updatekebpjs(uploadbpjsku,notransku,nourutku,kkelasku)
{
	var ckrumahsakit = document.forms['form1'].elements['ckrumahsakit'].value;
	var ctglupload = document.forms['form1'].elements['ctglupload'].value;
	var cjamupload = document.forms['form1'].elements['cjamupload'].value;
	var cuploadbpjs = uploadbpjsku;
	//alert(cuploadbpjs);
	var cnotrans = notransku;
    var cnourut = nourutku;
	var ckkelas = kkelasku;

if (ckrumahsakit == '') {
	alert("Rumah Sakit kosong, mohon dicek")
	document.forms['form1'].elements['ckrumahsakit'].focus();
	return false;
}
else {
		var xmlhttp;
		var params = "ckrumahsakit="+encodeURIComponent(ckrumahsakit)+"&cuploadbpjs="+encodeURIComponent(cuploadbpjs)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ckkelas="+encodeURIComponent(ckkelas)+"&ctglupload="+encodeURIComponent(ctglupload)+"&cjamupload="+encodeURIComponent(cjamupload)+"&ctabel=tabel02";
		if (window.XMLHttpRequest)
		  {
		  xmlhttp=new XMLHttpRequest();
		  }
		else
		  {
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }

		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				cdataku=xmlhttp.responseText;
				alert(cdataku);
				refreshtable();

			}
		  }
		xmlhttp.open("POST","../include/jsonBPJS.asp",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.setRequestHeader("Content-length", params.length);
		xmlhttp.setRequestHeader("Connection", "close");
		xmlhttp.send(params);

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
    .datagrid-body td{
        vertical-align: top;
    }

body {
	background-color:#9CC;
	color:#000;
	font-size:15px;
}

.fontku1{
	color:#000;
}

    .datagrid-body td{
        vertical-align: middle;
    }

-->
</style>
</head>
<body onLoad="doOnLoad();" onFocus="parent_disable();" onclick="parent_disable();">

<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk","ctglkeluar"]);
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
                <td width="1%" >&nbsp;</td>
                <td width="10%" >Notrans</td>
                <td width="1%"><div align="center">:</div></td>
                <td  ><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
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
                <td >Kelas / Ruang</td>
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
                <td   >&nbsp;</td>
                <td   >Tarif</td>
                <td   ><div align="center">:</div></td>
                <td>
 <input value="<%=(tinputkelaspasien.Fields.Item("tarif").Value)%>" name="ctariftitik" id="ctariftitik" class="easyui-numberbox" value="0" data-options="label:'Number in the United States',labelPosition:'top', min:0,precision:0,groupSeparator:',',width:'100%'">
                 <input name="ctarif" type="hidden" id="ctarif" value="0" size="10" maxlength="10" value="<%=(tinputkelaspasien.Fields.Item("tarif").Value)%>"/>
                </td>
              </tr>

 
               <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Petugas</span></td>
                <td><div align="center">:</div></td>
                <td><select name="ckpegawai" id="ckpegawai">
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
      </select></td>
              </tr>
               <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>

<%
if cstatustransaksi<>"T" then
%>
<a class="button button-yellow" href="#" onclick="simpandata1('EDIT')">
  Edit <strong>Data</strong>
</a>
<a class="button button-yellow" href="#" onclick="simpandata1('HAPUS')">
  Hapus <strong>Data</strong>
</a>
<a class="button button-yellow" href="#" onclick="simpandata1('HITUNG')">
  Hitung <strong>Tarif</strong>
</a>
<a class="button button-yellow" href="#" onclick="simpandata1('INPUT')">
  Ruangan <strong>Baru</strong>
</a>
<%
end if
%>                  

                  
                 
<input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />             
<input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputkelaspasien.Fields.Item("nourut").Value)%>" />
<input type="hidden" id="ckrumahsakit" name="ckrumahsakit" value="<%=Session("MM_krumahsakit")%>">
<input type="hidden" id="ctglupload" name="ctglupload" value="<%= DoDateTime((date), 2, 1042) %>">
<input type="hidden" id="cjamupload" name="cjamupload" value="<%=cjam%>">

                </td>
                </tr>
            </table>

			
<table align="center" id="dg" class="easyui-datagrid"  style="width:1280px;height:auto" title="<%=cjudulform%>"  idField="notrans"    url="../include/daftartransaksiJSON.asp?cnotrans=<%=cnotrans%>&ctabel=transaksi08"    
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th field="upload1" align="center" formatter="formatupload1">Upload </br>BPJS</th>
<th field="upload2" align="center" formatter="formatupload2">Upload </br>BPJS</th>
<th field="statusupload" width="75px" align="center" sortable="true" >Status </br>Upload</th>
<th data-options="field:'nourut',width:35" align="center"  formatter="linkrawatjalan">No</th>
<th field="tglmasuk" width="100px" align="center" sortable="true" >Tgl Masuk</th>
<th field="tglkeluar" width="100px" align="center" sortable="true" >Tgl Keluar</th>
<th field="jamkeluar" width="100px" align="center" sortable="true" >Jam Keluar</th>
<th field="kelas" width="200px" align="left" sortable="true">Ruangan</th>
</tr>
</thead >
<thead >
<tr>
<th field="kgolkelas" width="120px" align="left" sortable="true" >Kelas</th>
<th field="jmlhari" width="100px" align="right" sortable="true" >Jml Hari</th>
<th field="tarif" width="100px" align="right" sortable="true" >Tarif</th>
<th field="ket" width="300px" align="left" sortable="true" >Keterangan</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="kkelas" width="50px" align="left" sortable="true" hidden="true">kkelas</th>
</tr>
</thead>

</table>
<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
    var cnourutmenu = <%=cnourutmenu%>;

    var url = '../editdata/editkelaspasien.asp?cnotrans='+cnotrans+'&cnourut='+cnourut+'&cnourutmenu='+cnourutmenu+'&citem=<%=citem%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
    }	
function formatupload1(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
	var ckkelas = row.kkelas;
    return '<a href="#" onclick="return updatekebpjs(\'EDIT\',\''+cnotrans+'\',\''+cnourut+'\',\''+ckkelas+'\');"><button type="button" class="button button-red">Update</button></a>';
    }	
function formatupload2(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
	var ckkelas = row.kkelas;	
    return '<a href="#" onclick="return updatekebpjs(\'HAPUS\',\''+cnotrans+'\',\''+cnourut+'\',\''+ckkelas+'\');"><button type="button" class="button button-red">Delete</button></a>';
    }	
</script>			
			

			
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
