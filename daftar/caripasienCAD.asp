<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Cari Pasien</title>
	<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />
<script language="javascript" type="text/javascript">
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
</script>
<script type="text/javascript">
<!--

function caridata()
{
	document.forms['form1'].submit();
}

</script>
<style type="text/css">
<!--
body {
	background-color:#9CC;
	color:#FFF;
	font-size:16px;
}

.drop_menu {
background:#369;
padding:0;
margin:0;
list-style-type:none;
height:35px;
padding-left:5px;
position:fixed;
margin-top:150px;
width:985px;
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
}
 
.drop_menu li:hover ul li a {
padding:7px;
display:block;
width:200px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

-->
</style>
</head>
<body> 
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
<li><a href='../../exit.asp'>Keluar Aplikasi</a></li>

<li>
<a href='#'>Pendaftaran  Pasien</a>
<ul>
<li><a href="../master/masterpasien.asp">Input Pasien </a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=1" >Daftar Tunggu Rawat Jalan</a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=2" >Daftar Tunggu Rawat Inap</a></li>
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
<br />
      <form name="form1" method="get" action="daftarpasien.asp">

<table width="100%" align="left" >
      <tr>
        <td >&nbsp;</td>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="5%" >&nbsp;</td> 
        <td width="12%" >No CM</td>
        <td width="83%">: 
          <input name="cnocm" type="text" id="cnocm" size="10" maxlength="6">
          </td>
      </tr>
      <tr>
        <td >&nbsp;</td> 
        <td >Nama</td>
        <td>: 
          <input name="cnama" type="text" id="cnama" size="40" maxlength="30">
         </td>
      </tr>
      <tr>
        <td >&nbsp;</td> 
        <td >Alamat</td>
        <td>: 
          <input name="calamat" type="text" id="calamat" size="60" maxlength="50">
          </td>
      </tr>
      <tr>
        <td >&nbsp;</td>
        <td >No CM Lama </td>
        <td>: 
            <input name="cnopas" type="text" id="cnopas">
            <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      </table>
  </form>
<br />
<br />
<br />
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
