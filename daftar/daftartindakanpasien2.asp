<%@LANGUAGE="VBSCRIPT" %>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<!--#include file="../Connections/datarspermata.asp" -->
<% 
citem=request.QueryString("citem")
cstatuspasien=request.QueryString("cstatuspasien")
ckgoltindakan=request.QueryString("ckgoltindakan")
cnotrans=request.QueryString("cnotrans")
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
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,kkelas,statustransaksi FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
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
tgoltindakan_cmd.CommandText = "SELECT * FROM rspermata.tgoltindakan order by goltindakan " 
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Daftar Tindakan Pasien</title>
<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />

<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/metro-blue/easyui.css">
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
<script type="text/javascript">
<!--

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


function caridata()
{
	document.forms['form1'].submit();
}

</script>
<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 14px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 14px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 14px; color:#0000FF}
a:link {text-decoration: none;font-size: 14px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 14px; color:#FFFFFF; }

body {
	background-color:#CCC;
	color:#000;
	font-size:15px;
}
.fontku1 {
	color:#fff;
	font-size:15px;
}

.drop_menu {
background:#369;
padding:0;
margin:0;
list-style-type:none;
height:35px;
padding-left:5px;
position:fixed;
margin-top:120px;
width:985px;
z-index: 10;
}
.drop_menu li { float:left; }
.drop_menu li a {
padding:10px 30px;
display:block;
color:#fff;
text-decoration:none;
font:15px arial, verdana, sans-serif;
}
 
/* Submenu */
.drop_menu ul {
position:absolute;
left:-9999px;
top:-9999px;
list-style-type:none;
}
.drop_menu li:hover { position:relative; background:#369; }
.drop_menu li:hover ul {
left:0px;
top:35px;
padding:0px;


    overflow:auto;
    max-height:380px;
    overflow-x:hidden;

}
 
.drop_menu li:hover ul li a {
padding:7px;
display:block;
width:290px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

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
			myCalendar = new dhtmlXCalendarObject(["ctanggal1","ctanggal2"]);
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


	<!-- wraper -->
	<div id="wrapper">
		<!-- shell -->
		<div class="shell">
			<!-- container -->
			<div class="container1">
				<!-- header -->
			  <header id="header1">
					<h1 id="logo1"><a href="#"></a></h1>
			  </header>
 
<div class="drop">
<ul class="drop_menu">
<li><a href='../menuutama.asp'>Menu Utama</a></li>
<li><a href='../exit.asp'>Keluar Aplikasi</a></li>
<li>
<a href='#'>Transaksi  Pasien</a>
<ul>
<li><a href="../editdata/editrawatpasien.asp?cnotrans=<%=cnotrans%>" >Rawat Pasien</a></li>
<li><a href="../inputdata/inputkelaspasien.asp?citem=1&cnotrans=<%=cnotrans%>" >Ruangan Pasien</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=11&ckgoltindakan=11&cnotrans=<%=cnotrans%>" >Visite Dokter</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=2&ckgoltindakan=01&cnotrans=<%=cnotrans%>" >Tindakan IGD</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=3&ckgoltindakan=02&cnotrans=<%=cnotrans%>" >Tindakan Keperawatan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=4&ckgoltindakan=03&cnotrans=<%=cnotrans%>" >Tindakan Medis</a></li>
<li><a href="../inputdata/inputlaboratpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>" >Pemeriksaan Laboratorium</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=6&ckgoltindakan=10&cnotrans=<%=cnotrans%>" >Pemeriksaan Radiologi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=7&ckgoltindakan=09&cnotrans=<%=cnotrans%>" >Pemeriksaan Fisioterapi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=8&ckgoltindakan=08&cnotrans=<%=cnotrans%>" >Tindakan Persalinan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=10&ckgoltindakan=07&cnotrans=<%=cnotrans%>" >Tindakan Gigi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=13&ckgoltindakan=12&cnotrans=<%=cnotrans%>" >Pelayanan Gizi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=12&ckgoltindakan=06&cnotrans=<%=cnotrans%>" >Tindakan Operasi</a></li>
<li><a href="daftar/daftarpemberianobatpasien.asp?citem=9&cnotrans=<%=cnotrans%>" target="_blank">Daftar Pemberian Obat</a></li>
<li><a href="../inputdata/inputanalisasituasipasien.asp?citem=15&cnotrans=<%=cnotrans%>" >Analisa Situasi</a></li>

<li><a href="../inputdata/inputpembayaranpasien.asp?citem=14&cnotrans=<%=cnotrans%>">Pembayaran Pasien</a></li>
<li><a href="../inputdata/rincianbeayapasien.asp?cnotrans=<%=cnotrans%>" target="_blank">Rincian Pembiayaan Pasien</a></li>
</ul>
</li>

<li>
<a href='#'>Daftar Tindakan Pasien</a>
<ul>
<li><a href="../daftar/daftartindakanpasien2.asp?citem=<%=citem%>&ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cstatuspasien=<%=cstatuspasien%>">Cari Input Tindakan</a></li>
<li><a href="../daftar/daftartindakanpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>&cstatuspasien=<%=cstatuspasien%>">Cari Input Laboratorium</a></li>
<li><a href="../inputdata/cetaktindakanpasien.asp?citem=<%=citem%>&ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>" target="_blank" >Rekam Medik Perkunjungan</a></li>
<li><a href='../daftar/rekammedik.asp?cnocm=<%=(trawatpasien.Fields.Item("nocm").Value)%>' target='_blank'>Rekam Medik Semua Kunjungan</a></li>
</ul>
</li>


</ul>
</div>   
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />


<form action="" method="get" name="form1">
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
  <tr>
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

  <tr>
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
  <tr>
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
    <td >Tindakan</td>
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
  <tr>
    <td >&nbsp;</td>
    <td >Keterangan Pemeriksaan</td>
    <td>:</td>
    <td><input name="cpemeriksaan" type="text" id="cpemeriksaan" size="80" maxlength="80" /></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >Hasil</td>
    <td>:</td>
    <td><input name="chasil" type="text" id="chasil" size="80" maxlength="80" /></td>
  </tr>
               <tr>
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
                </select>
      <input type="button" name="simpan" id="simpan" value="Cari Data" onClick="refreshtable()"/></td>
              </tr>
 
</table>
<p>&nbsp;</p>
<table align="center" id="dg" class="easyui-datagrid"  style="width:975px;height:auto" title="Daftar Tindakan  Pasien"  idField="notrans"    url="../include/daftartransaksiJSON.asp?ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ctabel=transaksi01B"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:25" align="center"  formatter="linkrawatjalan">No</th>
<th field="tgltrans" width="100px" align="center" sortable="true" >Tgl Tindakan</th>
<th field="TINDAKAN" width="175px" align="left" sortable="true">Tindakan</th>
</tr>
</thead >
<thead >
<tr>
<th field="tarif" width="70px" align="right" sortable="true" >Tarif</th>
<th field="pemeriksaan" width="200px" align="center" sortable="true" >Pemeriksaan</th>
<th field="hasil" width="350px" align="left" sortable="true"  formatter="formatA">Hasil</th>
<th field="dokter" width="150px" align="left" sortable="true" >Dokter</th>
<th field="kgoltindakan" width="50px" align="left" sortable="true" hidden="true">kgoltindakan</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="notrans" width="100px" align="center" sortable="true" hidden="true" >Notrans</th>
<th field="notranstindakan" width="100px" align="center" sortable="true" hidden="true" >Notrans Tindakan</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnotranstindakan = row.notranstindakan;
    var cnourut = row.nourut;
    var ckgoltindakan = row.kgoltindakan;
	    var url = '../editdata/edittindakanpasien.asp?cnotrans='+cnotrans+'&cnotranstindakan='+cnotranstindakan+'&cnourut='+cnourut+'&ckgoltindakan='+ckgoltindakan+'&citem=<%=citem%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
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


</form>
    	  <div class="cleaner"></div>
<br />
<br />
<br />
<br />
<br />
<br />

			  <div id="footer"><!-- end of footer-cols -->
					<div class="footer-bottom">
				    <p class="copy">&copy; Copyright 2017 -  Kalboya@yahoo.com</p>
						<div class="cl">&nbsp;</div>
					</div>
			  </div>


			</div>
		</div>
	</div>

</body>
</html>
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
