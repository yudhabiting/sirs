<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
Dim trumahsakit
Dim trumahsakit_numRows

Set trumahsakit = Server.CreateObject("ADODB.Recordset")
trumahsakit.ActiveConnection = MM_datarspermata_STRING
trumahsakit.Source = "SELECT rumahsakit, krumahsakit  FROM rspermata.trumahsakit"
trumahsakit.CursorType = 0
trumahsakit.CursorLocation = 2
trumahsakit.LockType = 1
trumahsakit.Open()
trumahsakit_numRows = 0
%>
<%
Dim tpasien__MMColParam1
tpasien__MMColParam1 = "%"
If (Request.QueryString("cnocm") <> "") Then 
  tpasien__MMColParam1 = Request.QueryString("cnocm")
End If
%>
<%
Dim tpasien__MMColParam3
tpasien__MMColParam3 = "%"
If (Request.QueryString("cnama") <> "") Then 
  tpasien__MMColParam3 = Request.QueryString("cnama")
End If
%>
<%
Dim tpasien__MMColParam4
tpasien__MMColParam4 = "%"
If (Request.QueryString("calamat") <> "") Then 
  tpasien__MMColParam4 = Request.QueryString("calamat")
End If
%>
<%
Dim tpasien__MMColParam5
tpasien__MMColParam5 = "%"
If (Request.QueryString("cnopas")  <> "") Then 
  tpasien__MMColParam5 = Request.QueryString("cnopas") 
End If
%>
<%
Dim tpasien
Dim tpasien_numRows

Set tpasien = Server.CreateObject("ADODB.Recordset")
tpasien.ActiveConnection = MM_datarspermata_STRING
tpasien.Source = "SELECT nocm,nopas,  nama, umurthn,umurbln, alamat,orangtua FROM rspermata.tpasien  WHERE nocm like '%" + Replace(tpasien__MMColParam1, "'", "''") + "%' and nama like '%" + Replace(tpasien__MMColParam3, "'", "''") + "%' and alamat like '%" + Replace(tpasien__MMColParam4, "'", "''") + "%' and nopas like '%" + Replace(tpasien__MMColParam5, "'", "''") + "%'  ORDER BY nama ASC"
tpasien.CursorType = 0
tpasien.CursorLocation = 2
tpasien.LockType = 1
tpasien.Open()

tpasien_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tpasien_numRows = tpasien_numRows + Repeat1__numRows
%>
<%
Dim MM_paramName 
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

Dim MM_keepNone
Dim MM_keepURL
Dim MM_keepForm
Dim MM_keepBoth

Dim MM_removeList
Dim MM_item
Dim MM_nextItem

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then
  MM_removeList = MM_removeList & "&" & MM_paramName & "="
End If

MM_keepURL=""
MM_keepForm=""
MM_keepBoth=""
MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each MM_item In Request.QueryString
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & MM_nextItem & Server.URLencode(Request.QueryString(MM_item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each MM_item In Request.Form
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & MM_nextItem & Server.URLencode(Request.Form(MM_item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
If (MM_keepBoth <> "") Then 
  MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
End If
If (MM_keepURL <> "")  Then
  MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
End If
If (MM_keepForm <> "") Then
  MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)
End If

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Daftar Pasien</title>
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
<li><a href='../../exit.asp'>Keluar Aplikasi</a></li>

<li>
<a href='#'>Pendaftaran  Pasien</a>
<ul>
<li><a href="../daftar/caripasien.asp" >Cari Pasien</a></li>
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

<form name="form1" method="get">
<p>&nbsp;</p>
<table width="100%" class="fontku1">
  <tr>
    <td width="13%"><div align="right">No CM</div></td>
    <td width="87%">: 
      <input name="cnocm" type="text" id="cnocm" value="<%=request.querystring("cnocm")%>" size="10" maxlength="6" />
    </font></td>
  </tr>
  <tr>
    <td><div align="right">Nama</div></td>
    <td>:
      <input name="cnama" type="text" id="cnama" value="<%=request.querystring("cnama")%>" size="40" maxlength="30" />
    </font></td>
  </tr>
  <tr>
    <td><div align="right">Alamat</div></td>
    <td>:
      <input name="calamat" type="text" id="calamat" value="<%=request.querystring("calamat")%>" size="60" maxlength="50" />
    </font></td>
  </tr>
  <tr>
    <td><div align="right">No CM Lama </div></td>
    <td>: 
        <input name="cnopas" type="text" id="cnopas" value="<%=request.querystring("cnopas")%>" />
        <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
    <tr bgcolor="#9999FF"> 
      <td width="100px"> No CM</td>
      <td width="250px"> Nama</td>
      <td width="60px">Umur Thn</td>
      <td width="60px">Umur Bln</td>
      <td>Alamat</td>
      <td width="150px">Orang Tua / Suami</td>
      </tr>
    <% 
While ((Repeat1__numRows <> 0) AND (NOT tpasien.EOF)) 
%>
    <tr> 
      <td align="center"><A HREF="../editdata/editpasien.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "cnocm=" & tpasien.Fields.Item("nocm").Value%>"><%=(tpasien.Fields.Item("nocm").Value)%></A></td>
      <td><%=(tpasien.Fields.Item("nama").Value)%></td>
      <td align="right"><%=(tpasien.Fields.Item("umurthn").Value)%></td>
      <td align="right"><%=(tpasien.Fields.Item("umurbln").Value)%></td>
      <td><%=(tpasien.Fields.Item("alamat").Value)%></td>
      <td><%=(tpasien.Fields.Item("orangtua").Value)%></td>
      </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tpasien.MoveNext()
Wend
%>
  </table>
      </form>
    	  <div class="cleaner"></div>
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
<%
tpasien.Close()
Set tpasien = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

