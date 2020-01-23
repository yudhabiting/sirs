<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas4"
cnotrans=request.QueryString("cnotrans")
cuserid=trim(Session("MM_userid"))
cstatususer=(trim(Session("MM_statususer")))

chome="../"
clogintolak=chome&"tolak.asp"

if (trim(Session("MM_statususer")))="" then
	Response.Redirect(clogintolak) 
end if
%>
<%

cnotrans=request.QueryString("cnotrans")
cnotransobat=request.QueryString("cnotransobat")
if cnotransobat="" then
	cnotransobat=request.form("cnotransobat")
end if
citem=trim(request.QueryString("citem"))

cnourutmenu=request.QueryString("cnourutmenu")
cnourut=request.QueryString("cnourut")
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
'BATAS COPYAN
%>


<%
Dim trawatpasien
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,kkelas,statuspasien,statustransaksi FROM rspermata.trawatpasien WHERE notrans = '"&cnotrans&"'" 
trawatpasien_cmd.Prepared = true

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cstatuspasien=trim(trawatpasien.Fields.Item("statuspasien").Value)
cnocm=(trawatpasien.Fields.Item("nocm").Value)
if cstatuspasien="1" then
	cjudulform="Edit  "&cjudulform & " Rawat Jalan"
	filecetak="cetakhasillaboratRJ.asp"
else
	cjudulform="Edit "&cjudulform & " Rawat Inap"
	filecetak="cetakhasillaboratRI.asp"

end if


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
Dim tinputobatpasien
Dim tinputobatpasien_cmd
Dim tinputobatpasien_numRows

Set tinputobatpasien_cmd = Server.CreateObject ("ADODB.Command")
tinputobatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputobatpasien_cmd.CommandText = "SELECT * FROM rspermata.tinputobat WHERE notrans = '"&cnotrans&"' and nourut  = '"&cnourut&"' and notransobat  = '"&cnotransobat&"'" 
tinputobatpasien_cmd.Prepared = true
Set tinputobatpasien = tinputobatpasien_cmd.Execute
tinputobatpasien_numRows = 0
ckobat=(tinputobatpasien.Fields.Item("kobat").Value)
cobat=(tinputobatpasien.Fields.Item("obat").Value)

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
				if (ckondisiku=='CARI'){
					caridata();
					}
				else if  (ckondisiku=='EDIT'){
					simpandata2();
					}
				else if  (ckondisiku=='HAPUS'){
					hapusdata();
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







function onDblClickRowGRID3(index,row) {
	ckobat = row.kobat;
	cobat = row.obat;
	chjual = row.tarif;
	csakhir = row.sakhir;
	document.forms['form1'].elements['ckobat'].value=ckobat;
	document.forms['form1'].elements['cobat'].value=cobat;
	document.forms['form1'].elements['csakhir'].value=csakhir;
	document.forms['form1'].elements['ctarif'].value=chjual;

	$('#ctariftitik').numberbox('setValue', chjual);
	var ctarif = chjual;
	var cjumlah=document.forms['form1'].elements['cjumlah'].value;
	csubtotal=cjumlah*ctarif;
	document.forms['form1'].elements['csubtotal'].value=csubtotal;
	$('#csubtotaltitik').numberbox('setValue', csubtotal);

}


function totaltarif1(cjumlahobat)
{
	var cjumlah=cjumlahobat;
//	var ctarif=document.forms['form1'].elements['ctarif'].value;
	var ctarif = $('#ctariftitik').numberbox('getValue');
	document.forms['form1'].elements['ctarif'].value=ctarif;

	if (ctarif==''){
		document.forms['form1'].elements['csubtotal'].value=0;
		$('#csubtotaltitik').numberbox('setValue', 0);
	}
	else {
	csubtotal=cjumlah*ctarif;
	document.forms['form1'].elements['csubtotal'].value=csubtotal;
	$('#csubtotaltitik').numberbox('setValue', csubtotal);

	}
}
function totaltarif2(chargaobat)
{
	var ctarif = chargaobat;
	var ctarif = ctarif.replace(",", "");
	var ctarif1=document.forms['form1'].elements['ctarif'].value;
	var cjumlah=document.forms['form1'].elements['cjumlah'].value;
	if (ctarif!=ctarif) {
		document.forms['form1'].elements['ctarif'].value=ctarif;
	}
	csubtotal=(cjumlah)*(ctarif);
	document.forms['form1'].elements['csubtotal'].value=csubtotal;
	$('#csubtotaltitik').numberbox('setValue', csubtotal);


}


function refreshtable()
{
	var cnotrans='<%=(cnotrans)%>';
	var cnotransobat='<%=(cnotransobat)%>';

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?cnotrans='+encodeURIComponent(cnotrans)+'&cnotransobat='+encodeURIComponent(cnotransobat)+'&ctabel=transaksi10A',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');


}



function caridata()
{
var cnotrans='<%=(cnotrans)%>';
var cnotransobat='<%=(cnotransobat)%>';
var cnourut='<%=(cnourut)%>';
var cstatuspasien='<%=(cstatuspasien)%>';

var citem='<%=(citem)%>';

window.location = "../daftar/daftarpemberianobatpasien.asp?cnotrans=<%=cnotrans%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
}


function inputdata()
{
	var cnotrans='<%=(cnotrans)%>';
	var cnotransobat = document.forms['form1'].elements['cnotransobat'].value;

	window.location = "../inputdata/inputobatpasien2.asp?citem=<%=citem%>&cnotrans="+cnotrans+"&cnotransobat="+cnotransobat+"&cnourutmenu=<%=cnourutmenu%>";
}  


function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  


function simpandata2()
{

var ctarif = $('#ctariftitik').numberbox('getValue');
var csubtotal = $('#csubtotaltitik').numberbox('getValue');

document.forms['form1'].elements['ctarif'].value=ctarif;
document.forms['form1'].elements['csubtotal'].value=csubtotal;
//alert(document.forms['form1'].elements['ctarif'].value);



var cnotrans='<%=(cnotrans)%>';
var cnotransobat = document.forms['form1'].elements['cnotransobat'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;

var ckobat = document.forms['form1'].elements['ckobat'].value;
var ckobat1 = document.forms['form1'].elements['ckobat1'].value;
var cobat = document.forms['form1'].elements['cobat'].value;
var cobat1 = document.forms['form1'].elements['cobat1'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
var cjumlah = document.forms['form1'].elements['cjumlah'].value;
var cjumlah1 = document.forms['form1'].elements['cjumlah1'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var csubtotal = document.forms['form1'].elements['csubtotal'].value;
var cket = document.forms['form1'].elements['cket'].value;

if (cnotransobat == '') {
alert("Notrans Obat kosong, mohon dicek")
document.forms['form1'].elements['cnotransobat'].focus();
return false;
}
else if (cnotrans == '') {
alert("Notrans  kosong, mohon dicek")
document.forms['form1'].elements['cnotrans'].focus();
return false;
}
else if (ckobat == '') {
alert("Obat kosong, mohon dicek")
document.forms['form1'].elements['ckobat'].focus();
return false;
}
else if (cjumlah == '') {
alert("Jumlah kosong, mohon dicek")
document.forms['form1'].elements['cjumlah'].focus();
return false;
}
else if (ctarif == '') {
alert("Harga kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
else if (csubtotal == '') {
alert("Subtotal kosong, mohon dicek")
document.forms['form1'].elements['csubtotal'].focus();
return false;
}
else if (ckpegawai == '') {
alert("Petugas Input kosong, mohon dicek")
document.forms['form1'].elements['ckpegawai'].focus();
return false;
}

else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else {


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


	window.location = "../inputdata/inputobatpasien2.asp?citem=<%=citem%>&cnotrans="+cnotrans+"&cnotransobat="+cnotransobat+"&cnourutmenu=<%=cnourutmenu%>";

		
					}
				 }

					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&ckobat="+encodeURIComponent(ckobat)+"&ckobat1="+encodeURIComponent(ckobat1)+"&cobat="+encodeURIComponent(cobat)+"&cobat1="+encodeURIComponent(cobat1)+"&ctarif="+encodeURIComponent(ctarif)+"&csubtotal="+encodeURIComponent(csubtotal)+"&cket="+encodeURIComponent(cket)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cjumlah="+encodeURIComponent(cjumlah)+"&cjumlah1="+encodeURIComponent(cjumlah1)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnotransobat="+encodeURIComponent(cnotransobat)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel24");
		



//	document.forms['form1'].submit();
	}
}


function hapusdata()
{
var ckobat = document.forms['form1'].elements['ckobat1'].value;
var cobat = document.forms['form1'].elements['cobat1'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var cjumlah = document.forms['form1'].elements['cjumlah1'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var csubtotal = document.forms['form1'].elements['csubtotal'].value;

var cnotrans='<%=(cnotrans)%>';
var cnotransobat='<%=(cnotransobat)%>';
var cnourut='<%=(cnourut)%>';

var citem='<%=(citem)%>';

if (ckobat == '') {
alert("obat kosong, mohon dicek")
document.forms['form1'].elements['ckobat'].focus();
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
//					refreshtable();

						window.location = "../inputdata/inputobatpasien2.asp?cnotrans=<%=cnotrans%>&cnotransobat=<%=cnotransobat%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
					}
				 }
					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ckobat="+encodeURIComponent(ckobat)+"&cobat="+encodeURIComponent(cobat)+"&cnourut="+encodeURIComponent(cnourut)+"&cjumlah="+encodeURIComponent(cjumlah)+"&ctarif="+encodeURIComponent(ctarif)+"&csubtotal="+encodeURIComponent(csubtotal)+"&cnotransobat="+encodeURIComponent(cnotransobat)+"&cnotrans="+encodeURIComponent(cnotrans)+"&ctabel=tabel25");



//		document.forms['form1'].submit();


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


function obatfocus() {
$('#cnamaobat').next().find('input').focus()
}


	var isCtrl = false;
		document.onkeydown=function(e){
		if(e.which == 114 && isCtrl == false) { //f3
			 simpandata1('CARI');
			 return false;
		}
		else if(e.which == 115 && isCtrl == false) { //f4
			 simpandata1('EDIT');
		}
	}



//-->
</script>

<body onLoad="doOnLoad();obatfocus();" onFocus="parent_disable();" onclick="parent_disable();">

	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans"]);
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
                <td width="77%"><%
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
                <td width="3%" >&nbsp;</td>
                <td width="19%" >Notrans</td>
                <td width="1%">:</td>
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
              <tr>
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Notrans Resep</td>
                <td>:</td>
                <td><%=cnotransobat%></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Tanggal</td>
                <td>:</td>
                <td><input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((date()), 2, 7177) %>" size="12" maxlength="10" /></td>
                </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Obat</td>
                <td>:</td>
                <td><input id="cnamaobat" name="cnamaobat" value="<%=cobat%>" style="width:300px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:700,
                panelHeight:350,
                url: '../include/comboLISTDATAmaster.asp?cnotrans=<%=cnotrans%>&ctabel=tabel03',
                idField:'obat',
                textField:'obat',
                fitColumns:true,
                mode:'remote',
				pagePosition:top,
                method:'get',
                pagination:true,
                columns:[[
                    {field:'kobat',title:'Kode',width:70,sortable:true},
                    {field:'obat',title:'Barang',width:250,sortable:true},
                    {field:'tarif',title:'Harga Jual',align:'right',width:60,sortable:true},
                    {field:'sakhir',title:'Stok',align:'right',width:60,sortable:true}
                ]],
                onSelect:onDblClickRowGRID3
 	">
                  </input></td>
                </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Stok Akhir </td>
                <td>:</td>
                <td><input name="csakhir" type="text" id="csakhir" size="5" readonly></td>
                </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Jml Pemberian</td>
                <td>:</td>
                <td><input name="cjumlah" type="text" id="cjumlah" size="5" maxlength="5" value="<%=(tinputobatpasien.Fields.Item("jumlah").Value)%>" onblur="totaltarif1(this.value)"></td>
                </tr>

              <tr>
                <td >&nbsp;</td>
                <td >Tarif</td>
                <td>:</td>
                <td>
 <input onblur="totaltarif2(this.value)" name="ctariftitik" id="ctariftitik" class="easyui-numberbox" value="<%=(tinputobatpasien.Fields.Item("tarif").Value)%>" data-options="label:'Number in the United States',labelPosition:'top', min:0,precision:0,groupSeparator:',',width:'100%'" >
                 <input name="ctarif" type="hidden" id="ctarif" value="<%=(tinputobatpasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" />
                </td>
              </tr>
              
              <tr>
                <td >&nbsp;</td>
                <td >Subtotal</td>
                <td>:</td>
                <td>
  <input name="csubtotaltitik" id="csubtotaltitik" class="easyui-numberbox" value="<%=(tinputobatpasien.Fields.Item("subtotal").Value)%>" data-options="label:'Number in the United States',labelPosition:'top', min:0,precision:0,groupSeparator:',',width:'100%'" readonly>
                <input type="hidden"  name="csubtotal" type="text" id="csubtotal" size="20" maxlength="10" value="<%=(tinputobatpasien.Fields.Item("subtotal").Value)%>" readonly>
                </td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Keterangan </td>
                <td>:</td>
                <td><input name="cket" type="text" id="cket" size="50" maxlength="80" value="<%=(tinputobatpasien.Fields.Item("ket").Value)%>"/></td>
                </tr>
              <tr>
                <td >&nbsp;</td>
                <td >Petugas</td>
                <td>:</td>
                <td><select name="ckpegawai" id="ckpegawai">
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
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                <strong>
<%
if cstatustransaksi<>"T" then
%>
<input type="button" name="simpan" id="simpan" value="Edit Data ( F4 )" onclick="simpandata1('EDIT')" class="tombolku2"/>
<input type="button" name="simpan" id="simpan" value="Hapus Data" onclick="simpandata1('HAPUS')" class="tombolku2"/>
<input type="button" name="simpan" id="simpan" value="Input Obat Baru" onclick="simpandata1('INPUT')" class="tombolku2"/>
<%
end if
%>
<input type="button" name="simpan" id="simpan" value="Cari Resep Obat ( F3 )" onclick="simpandata1('CARI')" class="tombolku2"/>

                </strong>
                </strong></strong></td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>

<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="Daftar Pemberian Obat Pasien"  idField="notrans"    url="../include/daftartransaksiJSON.asp?cnotrans=<%=cnotrans%>&cnotransobat=<%=cnotransobat%>&ctabel=transaksi10A"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:25" align="center"  formatter="linkrawatjalan">No</th>
<th field="tgltrans" width="100px" align="center" sortable="true" >Tgl Trans</th>
<th field="obat" width="400px" align="left" sortable="true">Obat</th>
</tr>
</thead >
<thead >
<tr>
<th field="jumlah" width="100px" align="right" sortable="true" >Jumlah</th>
<th field="tarif" width="100px" align="right" sortable="true" >Harga</th>
<th field="subtotal" width="100px" align="right" sortable="true" >Subtotal</th>
<th field="ket" width="350px" align="left" sortable="true" >Keterangan</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="notransobat" width="50px" align="left" sortable="true" hidden="true">notransobat</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnotransobat = row.notransobat;
    var cnourut = row.nourut;
	var cnourutmenu=<%=cnourutmenu%>;
    var url = '../editdata/editobatpasien.asp?cnotrans='+cnotrans+'&cnotransobat='+cnotransobat+'&cnourut='+cnourut+'&citem=<%=citem%>'+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
    }	
</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>



    <input type="hidden" name="MM_insert" value="form1" />
    <input type="hidden" name="cpertama" value="1" />
    <input type="hidden" name="cnotransobat" id="cnotransobat" value="<%=cnotransobat%>" />
    <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
    <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputobatpasien.Fields.Item("nourut").Value)%>" />
     <input name="cjumlah1" type="hidden" id="cjumlah1" value="<%=(tinputobatpasien.Fields.Item("jumlah").Value)%>" />

    <input name="ckobat" type="hidden" id="ckobat" value="<%=(ckobat)%>" />
    <input name="ckobat1" type="hidden" id="ckobat1" value="<%=(ckobat)%>" />
    <input name="cobat" type="hidden" id="cobat" value="<%=(cobat)%>" />
    <input name="cobat1" type="hidden" id="cobat1" value="<%=(cobat)%>" />



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
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
tinputobatpasien.Close()
Set tinputobatpasien = Nothing
%>
