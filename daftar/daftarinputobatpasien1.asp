<%@LANGUAGE="VBSCRIPT" %>
<!--#include file="../Connections/datarspermata.asp" -->
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
<%
citem=request.QueryString("citem")
cstatuspasien=request.QueryString("cstatuspasien")
select case citem
	case 1
		fileku="../inputdata/inputkelaspasien.asp"
	case 2
		fileku="../inputdata/inputpasienpasien.asp"
end select
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
Dim trawatpasien__MMColParam1
trawatpasien__MMColParam1 = "%"
If (Request.QueryString("cnocm") <> "") Then 
  trawatpasien__MMColParam1 = Request.QueryString("cnocm")
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
Dim trawatpasien__MMColParam5
trawatpasien__MMColParam5 = "1"
If (Request.QueryString("ctglmasuk") <> "") Then 
  trawatpasien__MMColParam5 = Request.QueryString("ctglmasuk")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
if cstatuspasien="2" then
trawatpasien.Source = "SELECT notrans, nocm, statuspasien, tglmasuk,kkelas,nopas,  nama, umurthn,umurbln, alamat,orangtua FROM rspermata.vtdaftarinputobat  WHERE nocm like '%" + Replace(trawatpasien__MMColParam1, "'", "''") + "%'  and nama like '%" + Replace(trawatpasien__MMColParam3, "'", "''") + "%' and alamat like '%" + Replace(trawatpasien__MMColParam4, "'", "''") + "%'   and statuspasien ='2' and (carakeluar='' or isnull(carakeluar)) and pengobatan='B' group by notrans ORDER BY nama,tglmasuk ASC"
else
trawatpasien.Source = "SELECT notrans, nocm, statuspasien, tglmasuk,kkelas,nopas,  nama, umurthn,umurbln, alamat,orangtua FROM rspermata.vtdaftarinputobat  WHERE nocm like '%" + Replace(trawatpasien__MMColParam1, "'", "''") + "%' and nama like '%" + Replace(trawatpasien__MMColParam3, "'", "''") + "%' and alamat like '%" + Replace(trawatpasien__MMColParam4, "'", "''") + "%'   and statuspasien ='1' and tglmasuk = '" + Replace(trawatpasien__MMColParam5, "'", "''") + "'  and pengobatan='B' group by notrans  ORDER BY nama,tglmasuk ASC"
end if
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
<title>Daftar Input Data Item Perawatan</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
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
a:visited {text-decoration: none;font-size: 11px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 11px; color:#0000FF}
a:link {text-decoration: none;font-size: 11px; color:#FF0000}
a:active {
	font-family: Tahoma;
	font-size: 16px;
	color: #FFFFFF;
}

body {
	background-color: #FFFFFF;
}
.style1 {color: #FFFFFF}
.style2 {font-size: 14px}
.style11 {font-size: 12px}
-->
</style></head>
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
      <form action="" method="get" name="form1">
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
      <input name="ctglmasuk" type="hidden" id="ctglmasuk" value="<%=request.querystring("ctglmasuk")%>" />
    </font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
    <tr bgcolor="#9999FF">
      <td width="100px">Tgl Berobat</td> 
      <td width="70px"> No CM</td>
      <td width="150px"> Nama</td>
      <td width="60px">Umur Thn</td>
      <td width="60px">Umur Bln</td>
      <td width="200px">Alamat</td>
      <td width="120px">Orang Tua / Suami</td>
      <td width="100px">Status Pasien</td>
      <td width="100px">Ruangan</td>
      </tr>
    <% 
	citem=request.QueryString("citem")
select case citem
	case 1
		fileku="../inputdata/inputkelaspasien.asp"
	case 2
		fileku="../inputdata/inputtindakanpasien.asp"
	case 3
		fileku="../inputdata/inputvisitepasien.asp"
	case 4
		fileku="../inputdata/inputobatpasien.asp"
	case 5
		fileku="../inputdata/inputanalisasituasipasien.asp"
	case 6
		fileku="../inputdata/inputpembayaranpasien.asp"
	case 7
		fileku="../inputdata/reseppasien.asp"
	case else
		fileku="../editdata/editrawatpasien.asp"
end select
%>
<%
While ((Repeat1__numRows <> 0) AND (NOT trawatpasien.EOF)) 
%>

    <tr>
      <td align="center"><%=(trawatpasien.Fields.Item("tglmasuk").Value)%></td> 
      <td align="center"><A HREF="<%=fileku%>?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "cnotrans=" & trawatpasien.Fields.Item("notrans").Value%>"><%=(trawatpasien.Fields.Item("nocm").Value)%></A></td>
      <td class="style2"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
      <td align="right"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
      <td align="right"><%=(trawatpasien.Fields.Item("umurbln").Value)%></td>
      <td><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
      <td><%=(trawatpasien.Fields.Item("orangtua").Value)%></td>
      <td>
	  <% 
	  if(trawatpasien.Fields.Item("statuspasien").Value)="1"then
	  	response.Write("RAWAT JALAN")
	  else
	  	response.Write("RAWAT INAP")
	  end if
	  %></td>
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

