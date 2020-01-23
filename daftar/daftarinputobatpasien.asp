<%@LANGUAGE="VBSCRIPT" %>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="admin" then
elseif lcase(trim(Session("MM_statususer")))="dokter" then
elseif lcase(trim(Session("MM_statususer")))="apotik" then
elseif lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("../tolak.asp") 
else 
	Response.Redirect("../tolak.asp") 
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Daftar Input Data Item Perawatan</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
<!--
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}

function tglsekarang() {
var todayDate=new Date();
var date=todayDate.getDate();
var month=todayDate.getMonth()+1;
var year=todayDate.getFullYear();
document.form1.ctglmasuk.value=year+'/'+month+'/'+date;
}

function caridata()
{
	document.forms['form1'].submit();
}
//-->

</script>
<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 11px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 11px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 11px; color:#0000FF}
a:link {text-decoration: none;font-size: 11px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 11px; color:#FFFFFF; }

body {
	background-color: #FFFFFF;
}
.style1 {color: #FFFFFF}
.style11 {font-size: 12px}
-->
</style></head>
<body onLoad="tglsekarang()">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>



  <link rel="STYLESHEET" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.css">
	<link rel="stylesheet" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>	
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
	<script>
		dhtmlx.skin = "dhx_skyblue";
	</script>

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
  <div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
          <li><a href="../inputdata/daftartunggu.asp">Daftar Tunggu </a></li>
                <li><a href="../daftar/daftarrawatpasien.asp">Data Kunjungan </a></li>
                <li class="current"></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
      <form action="daftarinputobatpasien1.asp" method="get" name="form1">
<p>&nbsp;</p>
<table width="100%">

  <tr>
    <td width="12%">&nbsp;</td>
    <td width="1%" align="center">:</td>
    <td width="87%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><p><span class="header_02">DAFTAR PASIEN RAWAT JALAN (HARI INI) DAN RAWAT INAP (PASIEN MONDOK)</span></p></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Status Berobat</font></span></div></td>
    <td align="center">:</td>
    <td><select name="cstatuspasien" id="cstatuspasien">
      <option value="1" <%If (Not isNull(request.querystring("cstatuspasien"))) Then If ("1" = CStr(request.querystring("cstatuspasien"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Jalan</option>
      <option value="2" <%If (Not isNull(request.querystring("cstatuspasien"))) Then If ("2" = CStr(request.querystring("cstatuspasien"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Inap</option>
      </select></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">N</font></span><font size="2" face="Lucida Sans">oCM</font></div></td>
    <td align="center">:</td>
    <td><font color="white">
      <input name="cnocm" type="text" id="cnocm" value="<%=request.querystring("cnocm")%>" size="10" maxlength="6" />
      </font></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Nama</font></span></div></td>
    <td align="center">:</td>
    <td><font size="2" face="Lucida Sans">
      <input name="cnama" type="text" id="cnama" value="<%=request.querystring("cnama")%>" size="40" maxlength="30" />
      </font></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Alamat</font></span></div></td>
    <td align="center">:</td>
    <td><font size="2" face="Lucida Sans">
      <input name="calamat" type="text" id="calamat" value="<%=request.querystring("calamat")%>" size="60" maxlength="50" />
    </font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td><font size="2" face="Lucida Sans">
      <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/>
      <input name="citem" type="hidden" id="citem" value="<%=request.querystring("citem")%>" />
      <input type="hidden" name="ctglmasuk" id="ctglmasuk" />
    </font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
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
