<%@LANGUAGE="VBSCRIPT"%>
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
Dim trawatpasien__MMColParam1
trawatpasien__MMColParam1 = "%"
If (Request.QueryString("ckkelas") <> "") Then 
  trawatpasien__MMColParam1 = Request.QueryString("ckkelas")
End If
%>
<%
Dim trawatpasien__MMColParam3
trawatpasien__MMColParam3 = "%"
If (Request.QueryString("cnama") <> "") Then 
  trawatpasien__MMColParam3 = Request.QueryString("cnama")
End If
%>
<%
Dim trawatpasien__MMColParam4
trawatpasien__MMColParam4 = "%"
If (Request.QueryString("calamat") <> "") Then 
  trawatpasien__MMColParam4 = Request.QueryString("calamat")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT notrans, nocm, statuspasien, tglmasuk,kkelas,nopas,  nama, umurthn,umurbln, alamat,orangtua FROM rspermata.trawatpasien  WHERE kkelas like '%" + Replace(trawatpasien__MMColParam1, "'", "''") + "%' and nama like '%" + Replace(trawatpasien__MMColParam3, "'", "''") + "%' and alamat like '%" + Replace(trawatpasien__MMColParam4, "'", "''") + "%'   and statuspasien ='2' and (carakeluar='' or isnull(carakeluar)) ORDER BY nama,tglmasuk ASC"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()

trawatpasien_numRows = 0
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
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
trawatpasien_numRows = trawatpasien_numRows + Repeat1__numRows
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Daftar Pasien Yang Sedang Mondok</title>
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
<body onLoad="doOnLoad();">
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
<br />


<form action="daftarpasienmondok.asp" method="get" name="form1">
<table width="100%" class="fontku1">
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk1","ctglmasuk2"]);
		}
	</script>
  <tr>
    <td width="2%">&nbsp;</td>
    <td width="7%"><div align="left">Ruangan</div></td>
    <td width="1%" align="center">:</td>
    <td width="90%">
      <select name="ckkelas" id="ckkelas">
        <option value="" <%If (Not isNull(request.querystring("ckkelas"))) Then If ("" = CStr(request.querystring("ckkelas"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
        <%
While (NOT tkelas.EOF)
%>
        <option value="<%=(tkelas.Fields.Item("kkelas").Value)%>" <%If (Not isNull(request.querystring("ckkelas"))) Then If (CStr(tkelas.Fields.Item("kkelas").Value) = CStr(request.querystring("ckkelas"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelas.Fields.Item("kelas").Value)%></option>
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
    <td>&nbsp;</td>
    <td><div align="left">Nama</div></td>
    <td align="center">:</td>
    <td>
      <input name="cnama" type="text" id="cnama" value="<%=request.querystring("cnama")%>" size="40" maxlength="30" />
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="left">Alamat</div></td>
    <td align="center">:</td>
    <td>
      <input name="calamat" type="text" id="calamat" value="<%=request.querystring("calamat")%>" size="60" maxlength="50" />
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>
      <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
    <tr bgcolor="#9999FF">
      <td width="100px">Tgl Berobat</td> 
      <td width="100px"> No CM</td>
      <td width="200px"> Nama</td>
      <td width="50px">Umur Thn</td>
      <td width="50px">Umur Bln</td>
      <td width="250px">Alamat</td>
      <td width="120px">Orang Tua / Suami</td>
      <td width="120px">Ruangan</td>
      </tr>
    <% 
While ((Repeat1__numRows <> 0) AND (NOT trawatpasien.EOF)) 
%>
    <tr>
      <td align="center"><%=(trawatpasien.Fields.Item("tglmasuk").Value)%></td> 
      <td align="center"><A HREF="../editdata/editrawatpasien.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "cnotrans=" & trawatpasien.Fields.Item("notrans").Value%>"><%=(trawatpasien.Fields.Item("nocm").Value)%></A></td>
      <td><%=(trawatpasien.Fields.Item("nama").Value)%></td>
      <td align="right"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
      <td align="right"><%=(trawatpasien.Fields.Item("umurbln").Value)%></td>
      <td><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
      <td><%=(trawatpasien.Fields.Item("orangtua").Value)%></td>
      <td>
        <%
While (NOT tkelas.EOF)
if (tkelas.Fields.Item("kkelas").Value)=(trawatpasien.Fields.Item("kkelas").Value) Then 
	response.Write(tkelas.Fields.Item("kelas").Value)
end if
  tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%>
      </td>
      </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  trawatpasien.MoveNext()
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
tkelas.Close()
Set tkelas = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

