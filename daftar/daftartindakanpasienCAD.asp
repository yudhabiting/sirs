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
Dim vtinputtindakanpasien__MMColParam
vtinputtindakanpasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputtindakanpasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputtindakanpasien
Dim vtinputtindakanpasien_cmd
Dim vtinputtindakanpasien_numRows

Set vtinputtindakanpasien_cmd = Server.CreateObject ("ADODB.Command")
vtinputtindakanpasien_cmd.ActiveConnection = MM_datarspermata_STRING
vtinputtindakanpasien_cmd.CommandText = "SELECT *, REPLACE(REPLACE(hasil, '\r', ''), '\n', '</br>') as hasil FROM rspermata.vinputlaboratpasien WHERE notrans = ? and kgoltindakan = '"&ckgoltindakan&"'    order by notranstindakan,nourut" 
vtinputtindakanpasien_cmd.Prepared = true
vtinputtindakanpasien_cmd.Parameters.Append vtinputtindakanpasien_cmd.CreateParameter("param1", 200, 1, 15, vtinputtindakanpasien__MMColParam) ' adVarChar

Set vtinputtindakanpasien = vtinputtindakanpasien_cmd.Execute
vtinputtindakanpasien_numRows = 0
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
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
vtinputobatpasien_numRows = vtinputobatpasien_numRows + Repeat1__numRows
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
<title>Daftar Pemberian Obat Pasien</title>
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
<a href='#'>Laboratorium</a>
<ul>
<li><a href="../inputdata/inputlaboratpasien.asp?cnotrans=<%=cnotrans%>&ckgoltindakan=05" >Input Pemeriksaan Laborat Baru</a></li>
<li><a href="../daftar/daftarinputperawatan.asp?citem=5&ckgoltindakan=05&cstatuspasien=2">Input Pemeriksaan Laborat Pasien Baru</a></li>
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


<form action="" method="get" name="form1">
<table width="100%" class="fontku1">
  <tr>
    <td width="2%">&nbsp;</td>
    <td width="7%" class="style4"><span class="style3">NoCM</span></td>
    <td width="2%"><div align="center">:</div></td>
    <td width="89%" class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td class="style4"><span class="style3">Nama</span></td>
    <td><div align="center">:</div></td>
    <td class="style5"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td class="style4"><span class="style3">Alamat</span></td>
    <td><div align="center">:</div></td>
    <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td class="style4"><span class="style3">Umur</span></td>
    <td><div align="center">:</div></td>
    <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td class="style4"><span class="style3">Total Lab.</span></td>
    <td>:</td>
    <td class="style4">Rp. <%= FormatNumber(totaltindakan, 2, -2, -2, -1) %></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td><input name="citem" type="hidden" id="citem" value="<%=request.querystring("citem")%>" />
      </font></td>
  </tr>
  </table>
<table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
  <tr bgcolor="#FF0000">
      <td width="100px" align="center">Tanggal</td>
    <td width="100px" align="center">Notransaksi Tindakan</td>
    <td width="50px" align="center">No </br> Urut</td>
    <td width="250px" >Tindakan</td>
    <td width="60px" align="right">Tarif</td>
    <td width="*" align="left">Pemeriksaan </td>
    <td width="*" align="left">Hasil</td>
    <td width="*" align="left">Dokter</td>
  </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputtindakanpasien.EOF)) 
%>
  <tr>
      <td><%=(vtinputtindakanpasien.Fields.Item("tgltrans").Value)%></td>
    <td height="22"><a href="../inputdata/inputlaboratpasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputtindakanpasien.Fields.Item("notrans").Value & "&cnourut=" & vtinputtindakanpasien.Fields.Item("nourut").Value  & "&ckgoltindakan=" & (vtinputtindakanpasien.Fields.Item("kgoltindakan").Value) & "&cnotranstindakan=" & (vtinputtindakanpasien.Fields.Item("notranstindakan").Value)%>"><%=(vtinputtindakanpasien.Fields.Item("notranstindakan").Value)%></a></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("nourut").Value)%></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("tindakan").Value)%></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("tarif").Value)%></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("pemeriksaan").Value)%></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("hasil").Value)%></td>
    <td><%=(vtinputtindakanpasien.Fields.Item("dokter").Value)%></td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputtindakanpasien.MoveNext()
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
vtinputtindakanpasien.Close()
Set vtinputtindakanpasien = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
