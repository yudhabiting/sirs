<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas0"
cnotrans=request.QueryString("cnotrans")
cnourut=request.QueryString("cnourut")
cnourutmenu=request.QueryString("cnourutmenu")

cuserid=trim(Session("MM_userid"))
cstatususer=(trim(Session("MM_statususer")))
citem=trim(request.QueryString("citem"))

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
'BATAS COPYAN
%>


<%
cjudulform="Edit Item Pembelian Obat"
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
Dim tmasukobat
Dim tmasukobat_cmd
Dim tmasukobat_numRows

Set tmasukobat_cmd = Server.CreateObject ("ADODB.Command")
tmasukobat_cmd.ActiveConnection = MM_datarspermata_STRING
tmasukobat_cmd.CommandText = "SELECT * FROM rspermata.tmasukobat WHERE notrans = '"&cnotrans&"'" 
tmasukobat_cmd.Prepared = true

Set tmasukobat = tmasukobat_cmd.Execute
tmasukobat_numRows = 0
csuplier=(tmasukobat.Fields.Item("suplier").Value)
cksuplier=(tmasukobat.Fields.Item("ksuplier").Value)
cpajak=(tmasukobat.Fields.Item("pajak").Value)
%>
<%
Dim titemmasukobat
Dim titemmasukobat_cmd
Dim titemmasukobat_numRows

Set titemmasukobat_cmd = Server.CreateObject ("ADODB.Command")
titemmasukobat_cmd.ActiveConnection = MM_datarspermata_STRING
titemmasukobat_cmd.CommandText = "SELECT * FROM rspermata.titemmasukobat WHERE notrans = '"&cnotrans&"' and nourut  = '"&cnourut&"' " 
titemmasukobat_cmd.Prepared = true
Set titemmasukobat = titemmasukobat_cmd.Execute
titemmasukobat_numRows = 0
cobat=(titemmasukobat.Fields.Item("obat").Value)
ckobat=(titemmasukobat.Fields.Item("kobat").Value)
cjmlbiji=(titemmasukobat.Fields.Item("jmlbiji").Value)

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
		<style type="text/css">
		.style6 {font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
}
        .style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
        </style>
<script type="text/javascript" src="../template/menu000/js/jquery.min1.js"></script> 
<script src="../template/menu000/js/devoops.js"></script>

    

</head>

<script src="../include/scripts/numeral.min.js"></script>

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
					editdata();
					}
				else if  (ckondisiku=='INPUT'){
					inputdata();
					}
				else if  (ckondisiku=='HAPUS'){
					hapusdata();
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







 function  hitungtotal()  
 {
   var cnotrans='<%=(cnotrans)%>';
   var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
	url="../include/comboNOTRANSTOTALANKU.asp?cnotrans="+cnotrans
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   	{
		document.getElementById ("ctotalanku").innerHTML=xmlHttp.responseText;
		document.forms['form1'].elements['ctotalanku'].value=xmlHttp.responseText;
//		alert(document.forms['form1'].elements['ctotalanku'].value);
		cjumlahtotal=document.forms['form1'].elements['ctotalanku'].value;
		var jumlahtotal1 = cjumlahtotal;
		var jumlahtotal2 = jumlahtotal1.split('$$$');
		var jumlahtotal3 = jumlahtotal2[0];
		var jumlahtotal4 = jumlahtotal3.split('value="');
		var jumlahtotal5 = jumlahtotal4[1];
		var ctotal=jumlahtotal5;
		var jumlahtotal5 = jumlahtotal2[1];
		var cpajakrupiah=jumlahtotal5;
		var jumlahtotal3 = jumlahtotal2[2];
		var jumlahtotal4 = jumlahtotal3.split('">');
		var jumlahtotal5 = jumlahtotal4[0];
		var cgrandtotal=jumlahtotal5;
		document.forms['form1'].elements['ctotal'].value=ctotal;
		document.forms['form1'].elements['cpajakrupiah'].value=cpajakrupiah;
		document.forms['form1'].elements['cgrandtotal'].value=cgrandtotal;

		var ctotal = numeral(ctotal).format('0,0');
		var cpajakrupiah = numeral(cpajakrupiah).format('0,0');
		var cgrandtotal = numeral(cgrandtotal).format('0,0');

		document.getElementById ("ctotal1").innerHTML=ctotal;
		document.getElementById ("cpajakrupiah1").innerHTML=<%=cpajak%> + ' % Rp. ' + cpajakrupiah;
		document.getElementById ("cgrandtotal1").innerHTML=cgrandtotal;
//		alert(ctotal);
//		alert(cpajakrupiah);
//		alert(cgrandtotal);
	}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  


function subtotal1(cjumlahobat)
{
	var cjumlah=cjumlahobat;
	var charga=document.forms['form1'].elements['charga'].value;
	if (charga==''){
		document.forms['form1'].elements['csubtotal'].value=0;
	}
	else {
	document.forms['form1'].elements['csubtotal'].value=cjumlah*charga;
	}
}
function subtotal2(chargaobat)
{
	var cjumlah=document.forms['form1'].elements['cjmlbiji'].value;
	var charga=chargaobat;
	if (cjumlah==''){
		document.forms['form1'].elements['cjmlbiji'].value=0;
	}
	else {
	document.forms['form1'].elements['csubtotal'].value=cjumlah*charga;
	}
}


function refreshtable()
{
	var cnotrans='<%=(cnotrans)%>';

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON01.asp?cnotrans='+encodeURIComponent(cnotrans)+'&ctabel=transaksi01',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');


}



function onDblClickRowGRID3(index,row) {
	cksuplier = row.ksuplier;
	csuplier = row.suplier;
	document.forms['form1'].elements['cksuplier'].value=cksuplier;
	document.forms['form1'].elements['csuplier'].value=csuplier;
}

function onDblClickRowGRID4(index,row) {
	ckobat = row.kobat;
	cobat = row.obat;
	chbeli = row.hbeli;
	document.forms['form1'].elements['ckobat'].value=ckobat;
	document.forms['form1'].elements['cobat'].value=cobat;
	document.forms['form1'].elements['charga'].value=chbeli;
}


function caridata()
{
	window.location = "../daftar/daftarpembelianobat.asp?cnourutmenu=<%=cnourutmenu%>";
}

function inputdata()
{
	var cnotrans='<%=(cnotrans)%>';
	window.location = "../inputdata/inputobatmasuk1.asp?cnotrans="+cnotrans+"&cnourutmenu=<%=cnourutmenu%>";
}



function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  



function editdata()
{
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;

var ckobat = document.forms['form1'].elements['ckobat'].value;
var cobat = document.forms['form1'].elements['cobat'].value;
var cnobatch = document.forms['form1'].elements['cnobatch'].value;
var cjmlbox = document.forms['form1'].elements['cjmlbox'].value;
var cjmlbiji = document.forms['form1'].elements['cjmlbiji'].value;
var charga = document.forms['form1'].elements['charga'].value;
var csubtotal = document.forms['form1'].elements['csubtotal'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;


var ckobat1 = document.forms['form1'].elements['ckobat1'].value;
var cobat1 = document.forms['form1'].elements['cobat1'].value;
var cjmlbiji1 = document.forms['form1'].elements['cjmlbiji1'].value;

if (cnotrans == '') {
alert("Notrans kosong, mohon dicek")
document.forms['form1'].elements['cnotrans'].focus();
return false;
}
else if (ckobat == '') {
alert("Obat kosong, mohon dicek")
document.forms['form1'].elements['ckobat'].focus();
return false;
}
else if (cjmlbox == '') {
alert("Jml Box kosong, mohon dicek")
document.forms['form1'].elements['cjmlbox'].focus();
return false;
}

else if (cjmlbiji == '') {
alert("Jml Biji kosong, mohon dicek")
document.forms['form1'].elements['cjmlbiji'].focus();
return false;
}
else if (charga == '') {
alert("Harga kosong, mohon dicek")
document.forms['form1'].elements['charga'].focus();
return false;
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
//								alert("Input Data Sukses");


//						hitungtotal();
//						refreshtable();
//						alert("Edit Data Sukses");
						window.location = "../inputdata/inputobatmasuk1.asp?cnotrans="+cnotrans+"&cnourutmenu=<%=cnourutmenu%>";
	
					}
				 }

					xmlhttp.open("POST","../include/saveJSON03.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ckobat="+encodeURIComponent(ckobat)+"&cobat="+encodeURIComponent(cobat)+"&ckobat1="+encodeURIComponent(ckobat1)+"&cobat1="+encodeURIComponent(cobat1)+"&cnobatch="+encodeURIComponent(cnobatch)+"&cjmlbox="+encodeURIComponent(cjmlbox)+"&cjmlbiji="+encodeURIComponent(cjmlbiji)+"&cjmlbiji1="+encodeURIComponent(cjmlbiji1)+"&charga="+encodeURIComponent(charga)+"&csubtotal="+encodeURIComponent(csubtotal)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel04");
		



//	document.forms['form1'].submit();
	}
}






function hapusdata()
{
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;

var ckobat = document.forms['form1'].elements['ckobat'].value;
var cobat = document.forms['form1'].elements['cobat'].value;
var cnobatch = document.forms['form1'].elements['cnobatch'].value;
var cjmlbox = document.forms['form1'].elements['cjmlbox'].value;
var cjmlbiji = document.forms['form1'].elements['cjmlbiji'].value;
var charga = document.forms['form1'].elements['charga'].value;
var csubtotal = document.forms['form1'].elements['csubtotal'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;


var ckobat1 = document.forms['form1'].elements['ckobat1'].value;
var cobat1 = document.forms['form1'].elements['cobat1'].value;
var cjmlbiji1 = document.forms['form1'].elements['cjmlbiji1'].value;

if (cnotrans == '') {
alert("Notrans kosong, mohon dicek")
document.forms['form1'].elements['cnotrans'].focus();
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
//								alert("Input Data Sukses");


//						hitungtotal();
//						refreshtable();
//						alert("Edit Data Sukses");
						window.location = "../inputdata/inputobatmasuk1.asp?cnotrans="+cnotrans+"&cnourutmenu=<%=cnourutmenu%>";
	
					}
				 }

					xmlhttp.open("POST","../include/saveJSON03.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ckobat="+encodeURIComponent(ckobat)+"&cobat="+encodeURIComponent(cobat)+"&ckobat1="+encodeURIComponent(ckobat1)+"&cobat1="+encodeURIComponent(cobat1)+"&cnobatch="+encodeURIComponent(cnobatch)+"&cjmlbox="+encodeURIComponent(cjmlbox)+"&cjmlbiji="+encodeURIComponent(cjmlbiji)+"&cjmlbiji1="+encodeURIComponent(cjmlbiji1)+"&charga="+encodeURIComponent(charga)+"&csubtotal="+encodeURIComponent(csubtotal)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel05");
		


	  }
//	document.forms['form1'].submit();
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

<body onload="doOnLoad();" onfocus="parent_disable();" onclick="parent_disable();">

	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>

	<script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglterima","ctgljatuhtempo","ctglfaktur"]);
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


		    <table width="100%">
              <tr>
                <td width="15%" class="style4"><span class="style3">Notrans</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td class="style5"><%=(tmasukobat.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td width="15%" class="style4"><span class="style3">Tanggal Terima</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td width="86%"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((tmasukobat.Fields.Item("tglterima").Value), 2, 7177) %></font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal Faktur</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((tmasukobat.Fields.Item("tglfaktur").Value), 2, 7177) %><span class="style4"><span class="style3"> No Faktur :
                 </span></span><span class="style3"><%=(tmasukobat.Fields.Item("nofaktur").Value)%></span><span class="style4"><span class="style3"> </span></span></font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal Jatuh Tempo</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((tmasukobat.Fields.Item("tgljatuhtempo").Value), 2, 7177) %></font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Suplier </span></td>
                <td><div align="center">:</div></td>
                <td>
<%=csuplier%>				</td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Total</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div id="ctotal1" class="style6">
				<%= FormatNumber((tmasukobat.Fields.Item("total").Value), 0, 0, -2, -1) %>
                </div>
               </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">PPN</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div id="cpajakrupiah1" class="style6">
				<%=(tmasukobat.Fields.Item("pajak").Value)%> %  Rp. <%= FormatNumber((tmasukobat.Fields.Item("pajakrupiah").Value), 0, 0, -2, -1) %>
                </div>

                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Total + PPN</span></td>
                <td><div align="center">:</div></td>
                <td >
                <div id="cgrandtotal1" class="style6">
				<%= FormatNumber((tmasukobat.Fields.Item("grandtotal").Value), 0, 0, -2, -1) %>
                </div>
                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Status</span></td>
                <td><div align="center">:</div></td>
                <td><p>
                  <label>
                    <input <%If (CStr((tmasukobat.Fields.Item("lunas").Value)) = CStr("B")) Then Response.Write("checked=""checked""") : Response.Write("")%> type="radio" name="clunas" value="B" id="clunas_0" />
                    Belum Lunas</label>
                  <label>
                    <input <%If (CStr((tmasukobat.Fields.Item("lunas").Value)) = CStr("L")) Then Response.Write("checked=""checked""") : Response.Write("")%> type="radio" name="clunas" value="L" id="clunas_1" />
                    Lunas</label>
                 
                  
                  <br />
                </p></td>
              </tr>
              <tr>
                <td >Petugas</td>
                <td><div align="center">:</div></td>
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
                </select>
                  </select></td>
           </tr>
              <tr>
                <td colspan="3" >&nbsp;</td>
                </tr>
            </table>

		    <table width="100%">

              <tr>
                <td colspan="3"><hr></td>
              </tr>
              <tr>
                <td colspan="3" class="fontjudul1">EDIT ITEM PEMBELIAN OBAT</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td width="15%"><span class="style3">Obat</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td>

<input id="cnamaobat" name="cnamaobat" value="<%=cobat%>" style="width:300px;height:20px;" class="easyui-combogrid" 
	data-options="
                panelWidth:700,
                panelHeight:350,
                url: '../include/comboLISTDATAmaster.asp?ctabel=tabel03A',
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
                    {field:'hbeli',title:'Harga Jual',align:'right',width:60,sortable:true},
                    {field:'sakhir',title:'Stok',align:'right',width:60,sortable:true}
                ]],
                onSelect:onDblClickRowGRID4
 	">
                  </input>


				</td>
              </tr>
              <tr>
                <td><span class="style3">Nobatch</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cnobatch" type="text" id="cnobatch" value="<%=(titemmasukobat.Fields.Item("nobatch").Value)%>" size="30" /></td>
              </tr>
              <tr>
                <td><span class="style3">Jumlah Box</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cjmlbox" type="text" id="cjmlbox" value="<%=(titemmasukobat.Fields.Item("jmlbox").Value)%>" size="15" /></td>
              </tr>
              <tr>
                <td><span class="style3">Jumlah Biji</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cjmlbiji" type="text" id="cjmlbiji" value="<%=(titemmasukobat.Fields.Item("jmlbiji").Value)%>" size="15" onblur="subtotal1(this.value)"/></td>
              </tr>
              <tr>
                <td><span class="style3">Harga</span></td>
                <td><div align="center">:</div></td>
                <td><input name="charga" type="text" id="charga" value="<%=(titemmasukobat.Fields.Item("harga").Value)%>" size="15"  onblur="subtotal2(this.value)"/></td>
              </tr>
              <tr>
                <td><span class="style3">Subtotal</span></td>
                <td><div align="center">:</div></td>
                <td><input name="csubtotal" type="text" id="csubtotal" value="<%=(titemmasukobat.Fields.Item("subtotal").Value)%>" size="15" readonly/></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
<input type="button" name="simpan" id="simpan" value="Edit Item Obat" onclick="simpandata1('EDIT')" class="tombolku2"/>
<input type="button" name="simpan" id="simpan" value="Hapus Item Obat" onclick="simpandata1('HAPUS')" class="tombolku2"/>
<input type="button" name="simpan" id="simpan" value="Cari Data" onclick="simpandata1('CARI')" class="tombolku2"/>
<input type="button" name="simpan" id="simpan" value="Input Item Obat Baru" onclick="simpandata1('INPUT')" class="tombolku2"/>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>



<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="Daftar Pembelian Obat"  idField="notrans"    url="../include/daftartransaksiJSON01.asp?cnotrans=<%=cnotrans%>&ctabel=transaksi01"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:75" align="center"  formatter="linkrawatjalan">No</th>
<th field="kobat" width="100px" align="left" sortable="true">Kode</th>
<th field="obat" width="400px" align="left" sortable="true">Obat</th>
<th field="nobatch" width="200px" align="left" sortable="true">Nobatch</th>
</tr>
</thead >
<thead >
<tr>
<th field="jmlbox" width="100px" align="right" sortable="true" >Jml Box</th>
<th field="jmlbiji" width="100px" align="right" sortable="true" >Jml Biji</th>
<th field="harga" width="100px" align="right" sortable="true" >Harga</th>
<th field="subtotal" width="100px" align="right" sortable="true" >Subtotal</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
	var cnourutmenu=<%=cnourutmenu%>;
    var url = '../editdata/editobatmasuk.asp?cnotrans='+cnotrans+'&cnourut='+cnourut+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
    }	
</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>


    	<input type="hidden" name="csuplier" id="csuplier" value="<%=(tmasukobat.Fields.Item("suplier").Value)%>">
    	<input type="hidden" name="cksuplier" id="cksuplier" value="<%=(tmasukobat.Fields.Item("ksuplier").Value)%>">
    	<input type="hidden" name="cgrandtotal" id="cgrandtotal" value="<%=(tmasukobat.Fields.Item("grandtotal").Value)%>">
    	<input type="hidden" name="ctotal" id="ctotal" value="<%=(tmasukobat.Fields.Item("total").Value)%>">
    	<input type="hidden" name="cpajakrupiah" id="cpajakrupiah" value="<%=(tmasukobat.Fields.Item("pajakrupiah").Value)%>">
    	<input type="hidden" name="cpajak" id="cpajak" value="<%=(tmasukobat.Fields.Item("pajak").Value)%>">



    	<input type="hidden" name="cnotrans" id="cnotrans" value="<%=(cnotrans)%>">
    	<input type="hidden" name="cnourut" id="cnourut" value="<%=(cnourut)%>">
    	<input type="hidden" name="cobat1" id="cobat1" value="<%=cobat%>">
    	<input type="hidden" name="ckobat1" id="ckobat1" value="<%=ckobat%>">
    	<input type="hidden" name="cjmlbiji1" id="cjmlbiji1" value="<%=cjmlbiji%>">

    	<input type="hidden" name="cobat" id="cobat" value="<%=cobat%>">
    	<input type="hidden" name="ckobat" id="ckobat" value="<%=ckobat%>">

	<div  id="ctotalanku">
    	<input type="hidden" name="ctotalanku" id="ctotalanku" value="0">
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
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
tmasukobat.Close()
Set tmasukobat = Nothing
%>
<%
titemmasukobat.Close()
Set titemmasukobat = Nothing
%>
