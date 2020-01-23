<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas3"
cnotrans=request.QueryString("cnotrans")
cnourut=request.QueryString("cnourut")
cuserid=trim(Session("MM_userid"))
cstatususer=(trim(Session("MM_statususer")))

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
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("select coalesce((bayar),0) as totalpembayaran, coalesce((sisa),0) as totalsisa,statusedit  from tinputpembayaran where notrans='"&Request.QueryString("cnotrans")&"' and nourut='"&cnourut&"'") 
	if isnull(tnourut2("statusedit"))=true then
		Response.Redirect(clogintolak) 
	else
	  	if tnourut2("statusedit")="T" then
			Response.Redirect(clogintolak) 
		end if
	end if

	if isnull(tnourut2("totalpembayaran"))=true then
		ctotalpembayaran=0
	else
	  	ctotalpembayaran=cstr(tnourut2("totalpembayaran"))+0	
	end if
	if isnull(tnourut2("totalsisa"))=true then
		ctotalsisa=0
	else
	  	ctotalsisa=cstr(tnourut2("totalsisa"))+0	
	end if
	ctotalbayar=(ctotalpembayaran)+(ctotalsisa)
	ctotalbayarasli=ctotalbayar
%>


<%
Dim tinputpembayaran
Dim tinputpembayaran_cmd
Dim tinputpembayaran_numRows

Set tinputpembayaran_cmd = Server.CreateObject ("ADODB.Command")
tinputpembayaran_cmd.ActiveConnection = MM_datarspermata_STRING
tinputpembayaran_cmd.CommandText = "SELECT * FROM rspermata.tinputpembayaran WHERE notrans = '"&cnotrans&"'  and nourut = '"&cnourut&"' order by tgltrans,nourut" 
tinputpembayaran_cmd.Prepared = true

Set tinputpembayaran = tinputpembayaran_cmd.Execute
tinputpembayaran_numRows = 0
%>
<%
Dim trawatpasien
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,total,statustransaksi,statuspasien FROM rspermata.trawatpasien WHERE notrans='"&cnotrans&"'" 
trawatpasien_cmd.Prepared = true

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cstatuspasien=(trawatpasien.Fields.Item("statuspasien").Value)
ctotalbeayars=cstr(trawatpasien.Fields.Item("total").Value)+0

if cstatuspasien="1" then
	cjudulform="Edit  "&cjudulform & " Rawat Jalan"
else
	cjudulform="Edit "&cjudulform & " Rawat Inap"

end if

%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = '"&Session("MM_userid")&"'" 
tpegawai_cmd.Prepared = true

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

<script src="../include/terbilang.js"></script>

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
				else if  (ckondisiku=='CARI'){
					caridata();
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



function refreshtable()
{
var cnotrans = document.forms['form1'].elements['cnotrans'].value;

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?cnotrans='+encodeURIComponent(cnotrans)+'&ctabel=transaksi09',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');


}

function hurufkapitalkata( str )
{
    var pieces = str.split(" ");
    for ( var i = 0; i < pieces.length; i++ )
    {
        var j = pieces[i].charAt(0).toUpperCase();
        pieces[i] = j + pieces[i].substr(1);
    }
    return pieces.join(" ");
}

function hurufkapitalkalimat(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function angkaku(){
 //memanggil fungsi terbilang() dari file terbilang.js
 var nilai = document.forms['form1'].elements['ctotalbayar'].value;
 var hasil = (terbilang(nilai));
 var ctotalrupiah=hasil.trim()+ " Rupiah";
 ctotalrupiah=hurufkapitalkata(ctotalrupiah);
 document.forms['form1'].elements['cterbilang'].value=ctotalrupiah;
 }

function hitungsisa()
{
var ctotalbayar = document.forms['form1'].elements['ctotalbayar'].value;
var cbayar = document.forms['form1'].elements['cbayar'].value;
document.forms['form1'].elements['csisa'].value=ctotalbayar-cbayar;
	var csisa=document.forms['form1'].elements['csisa'].value;
	if (csisa<=0) {
	document.forms['form1'].elements['clunas'].value='L';
	}
	else {
	document.forms['form1'].elements['clunas'].value='B';
	}
}

function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  


function simpandata2()
{
var cnourutmenu = document.forms['form1'].elements['cnourutmenu'].value;
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;
var ctotalbayar = document.forms['form1'].elements['ctotalbayar'].value;
var cpembayar = document.forms['form1'].elements['cpembayar'].value;
var cpasien = document.forms['form1'].elements['cpasien'].value;
var cket = document.forms['form1'].elements['cket'].value;
var cbayar = document.forms['form1'].elements['cbayar'].value;
var csisa = document.forms['form1'].elements['csisa'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;

if (cnotrans == '') {
alert("Notrans kosong, mohon dicek")
document.forms['form1'].elements['cnotrans'].focus();
return false;
}
else if (cnourut == '') {
alert("Nourut  kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else if (cbayar == '') {
alert("bayar kosong, mohon dicek")
document.forms['form1'].elements['cbayar'].focus();
return false;
}
else if (csisa == '') {
alert("sisa / hutang kosong, mohon dicek")
document.forms['form1'].elements['csisa'].focus();
return false;
}

else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else if (ckpegawai == '') {
alert("Pegawai kosong, mohon dicek")
document.forms['form1'].elements['ckpegawai'].focus();
return false;
}

else {

		document.forms['form1'].elements['csisa'].value=ctotalbayar-cbayar;
		var csisa=document.forms['form1'].elements['csisa'].value;
		if (csisa<=0) {
		document.forms['form1'].elements['clunas'].value='L';
		}
		else {
		document.forms['form1'].elements['clunas'].value='B';
		}
		clunas=document.forms['form1'].elements['clunas'].value;

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
		//			document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
//					refreshtable();

//					document.forms['form1'].elements['canalisasituasi'].value='';

						window.location = "../inputdata/inputpembayaranpasien.asp?cnotrans=<%=cnotrans%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";

					}
				 }


					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&ctotalbayar="+encodeURIComponent(ctotalbayar)+"&cbayar="+encodeURIComponent(cbayar)+"&csisa="+encodeURIComponent(csisa)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&clunas="+encodeURIComponent(clunas)+"&cket="+encodeURIComponent(cket)+"&cpembayar="+encodeURIComponent(cpembayar)+"&cpasien="+encodeURIComponent(cpasien)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel21");
		



	}
}



function hapusdata()
{
var cnourutmenu = document.forms['form1'].elements['cnourutmenu'].value;
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
var ctotalbayarasli = document.forms['form1'].elements['ctotalbayarasli'].value;

if (cnotrans == '') {
alert("Notrans kosong, mohon dicek")
document.forms['form1'].elements['cnotrans'].focus();
return false;
}
else if (cnourut == '') {
alert("Nourut  kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else if (ckpegawai == '') {
alert("Pegawai kosong, mohon dicek")
document.forms['form1'].elements['ckpegawai'].focus();
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

						window.location = "../inputdata/inputpembayaranpasien.asp?cnotrans=<%=cnotrans%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
					}
				 }
					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ckpegawai="+encodeURIComponent(ckpegawai)+"&ctotalbayarasli="+encodeURIComponent(ctotalbayarasli)+"&cnotrans="+encodeURIComponent(cnotrans)+"&cnourut="+encodeURIComponent(cnourut)+"&ctabel=tabel22");



//		document.forms['form1'].submit();


	  }
	}
}

function inputdata()
{

var cnourutmenu = document.forms['form1'].elements['cnourutmenu'].value;
var cnotrans = document.forms['form1'].elements['cnotrans'].value;
window.location = "../inputdata/inputpembayaranpasien.asp?cnotrans=<%=cnotrans%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
}

 function cetakkuitansi(notransku,nourutku,nourutmenuku)  
 {
	var cnotrans = notransku;
	var cnourut = nourutku;
	var cnourutmenu = nourutmenuku;

	window.location = "../inputdata/kuitansipasien.asp?cnotrans="+cnotrans+"&cnourut="+cnourut+"&cnourutmenu="+cnourutmenu;



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
<body onLoad="doOnLoad(), angkaku();" onfocus="parent_disable();" onclick="parent_disable();">

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
<script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans"]);
		}
	</script>




<table width="100%" class="fontku1">
              <tr>
                <td width="2%" class="style4">&nbsp;</td>
                <td width="14%" class="style4"><span class="style3">Notrans</span></td>
                <td width="1%"><div align="center">:</div></td>
                <td width="83%" class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">NoCM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
              </tr>
                <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Total beaya RS</span></td>
                <td><div align="center">:</div></td>
                <td class="style5">Rp. <%= FormatNumber((ctotalbeayars), 2, -2, -2, -1) %></td>
                </tr>

              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Total yg harus dibayar</span></td>
                <td><div align="center">:</div></td>
                <td class="style5">Rp. <%= FormatNumber((ctotalbayar), 2, -2, -2, -1) %></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Terbilang</span></td>
                <td><div align="center">:</div></td>
                <td class="style5"><input name="cterbilang" type="text" id="cterbilang" size="100" /></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime(tinputpembayaran.Fields.Item("tgltrans").Value, 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Bayar</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cbayar" type="text" id="cbayar" size="15" onblur="hitungsisa(this.value)" value="<%=(tinputpembayaran.Fields.Item("bayar").Value)%>"/></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Sisa</span></td>
                <td><div align="center">:</div></td>
                <td><input name="csisa" type="text" id="csisa"  size="15" readonly value="<%=(tinputpembayaran.Fields.Item("sisa").Value)%>"/></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Ket / Guna Membayar</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cket" cols="70" rows="1" id="cket" ><%=(tinputpembayaran.Fields.Item("ket").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4">Telah Terima Dari</td>
                <td><div align="center">:</div></td>
                <td><input name="cpembayar" type="text" id="cpembayar" size="75" maxlength="50" value="<%=(tinputpembayaran.Fields.Item("pembayar").Value)%>"/></td>
              </tr>

              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Petugas</span></td>
                <td><div align="center">:</div></td>
                <td>
      <select name="ckpegawai" id="ckpegawai">
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
      </select>
                </td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
 
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata1('EDIT')" class="tombolku2"/>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="simpandata1('HAPUS')" class="tombolku2"/>
                <input name="button2" type="button" class="tombolku2" id="button2" value="Input Pembayaran Baru"  onclick="simpandata1('INPUT')">

                 </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>



<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="<%=cjudulform%>"  idField="notrans"    url="../include/daftartransaksiJSON.asp?cnotrans=<%=cnotrans%>&ctabel=transaksi09"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th field="cetakkuitansi1" align="center" formatter="linkkuitansi">Cetak Kuitansi</th>
<th data-options="field:'nourut',width:75" align="center"  formatter="linkrawatjalan">No</th>
<th field="tgltrans" width="100px" align="center" sortable="true" >Tanggal</th>
<th field="ket" width="200px" align="left" sortable="true">Keterangan</th>
</tr>
</thead >
<thead >
<tr>
<th field="pembayar" width="200px" align="left" sortable="true"  >Pembayar</th>
<th field="bayar" width="100px" align="right" sortable="true"  >Bayar</th>
<th field="sisa" width="100px" align="right" sortable="true"  >Sisa</th>
<th field="keteranganlunas" width="100px" align="center" sortable="true"  >Status</th>
<th field="pegawai" width="200px" align="center" sortable="true"  >Pegawai</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="lunas" width="50px" align="left" sortable="true" hidden="true">lunas</th>
<th field="statusedit" width="50px" align="left" sortable="true" hidden="true">statusedit</th>

</tr>
</thead>
</table>

<script>

function linkkuitansi(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
    var cnourutmenu = <%=cnourutmenu%>;
//    return '<a href="#" onclick="return cetakkuitansi(\''+cnotrans+'\',\''+cnourut+'\',\''+cnourutmenu+'\');"><button type="button">Cetak Kuitansi</button></a>';
    return '<a href="../inputdata/kuitansipasien.asp?cnotrans='+cnotrans+'&cnourut='+cnourut+'&cnourutmenu='+cnourutmenu+'" target="blank"><button type="button">Cetak Kuitansi</button></a>';

    }
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnourut = row.nourut;
    var cnourutmenu = <%=cnourutmenu%>;
    var cstatusedit = row.statusedit;
	if (cstatusedit == 'Y') {
		var url = '../editdata/editpembayaranpasien.asp?cnotrans='+cnotrans+'&cnourut='+cnourut+'&cnourutmenu='+cnourutmenu+'&citem=<%=citem%>';
	   return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';

	}	
   else {
	   return cnourut;
   }
}	
</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>


            <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
			<input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputpembayaran.Fields.Item("nourut").Value)%>" />
            <input name="clunas" type="hidden" id="clunas" value="<%=(tinputpembayaran.Fields.Item("lunas").Value)%>"  />
            <input name="ctotalbayar" type="hidden" id="ctotalbayar" value="<%= ctotalbayar %>"  />
            <input name="ctotalbayarasli" type="hidden" id="ctotalbayarasli" value="<%= ctotalbayarasli %>"  />
            <input type="hidden" name="cpasien"  id="cpasien" value="<%=(trawatpasien.Fields.Item("nama").Value)%>"  />
            <input type="hidden" name="cnama"  id="cnama" value="<%=(trawatpasien.Fields.Item("nama").Value)%>"  />
            <input type="hidden" name="MM_insert" value="form1" />



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
tinputpembayaran.Close()
Set tinputpembayaran = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
