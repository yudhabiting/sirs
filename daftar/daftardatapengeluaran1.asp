<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="admin" then
elseif lcase(trim(Session("MM_statususer")))="front office" then
elseif lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("../tolak.asp") 
else 
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
Dim tinputpengeluaran__MMColParam1
tinputpengeluaran__MMColParam1 = "%"
If (Request.QueryString("cpengeluaran") <> "") Then 
  tinputpengeluaran__MMColParam1 = Request.QueryString("cpengeluaran")
End If
%>
<%
Dim tinputpengeluaran__MMColParam2
tinputpengeluaran__MMColParam2 = "1"
If (Request.QueryString("ctgltrans1")  <> "") Then 
  tinputpengeluaran__MMColParam2 = Request.QueryString("ctgltrans1") 
End If
%>
<%
Dim tinputpengeluaran__MMColParam3
tinputpengeluaran__MMColParam3 = "1"
If (Request.QueryString("ctgltrans2")  <> "") Then 
  tinputpengeluaran__MMColParam3 = Request.QueryString("ctgltrans2") 
End If
%>
<%
Dim tinputpengeluaran
Dim tinputpengeluaran_numRows

Set tinputpengeluaran = Server.CreateObject("ADODB.Recordset")
tinputpengeluaran.ActiveConnection = MM_datarspermata_STRING
if Request.QueryString("cektgl")=2 then
tinputpengeluaran.Source = "SELECT * FROM rspermata.vtinputpengeluaran  WHERE  pengeluaran like '%" + Replace(tinputpengeluaran__MMColParam1, "'", "''") + "%'  ORDER BY tgltrans,nourut ASC"
else
tinputpengeluaran.Source = "SELECT * FROM rspermata.vtinputpengeluaran  WHERE  pengeluaran like '%" + Replace(tinputpengeluaran__MMColParam1, "'", "''") + "%'  and tgltrans >= '" + Replace(tinputpengeluaran__MMColParam2, "'", "''") + "' and tgltrans <= '" + Replace(tinputpengeluaran__MMColParam3, "'", "''") + "' ORDER BY tgltrans,nourut ASC"
end if
tinputpengeluaran.CursorType = 0
tinputpengeluaran.CursorLocation = 2
tinputpengeluaran.LockType = 1
tinputpengeluaran.Open()

tinputpengeluaran_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 1000
Repeat1__index = 0
tinputpengeluaran_numRows = tinputpengeluaran_numRows + Repeat1__numRows
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
<title>Daftar Pengeluaran</title>
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

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
  <div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../inputdata/inputpengeluaran.asp">Input Pengeluaran </a></li>
                <li class="current"></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
      <form name="form1" method="get">
<p>&nbsp;</p>
<table width="100%">
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans1","ctgltrans2"]);
		}
	</script>

  <tr>
    <td width="12%"><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Dari Tanggal </font></span></div></td>
    <td width="1%" align="center">:</td>
    <td width="87%"><div align="left">
        <input name="ctgltrans1" type="text" id="ctgltrans1" value="<%=request.querystring("ctgltrans1")%>" size="15" />
        <span class="style11">Tahun / Bulan / Tanggal </span></div></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Sampai Tanggal </font></span></div></td>
    <td align="center">:</td>
    <td><div align="left">
        <input name="ctgltrans2" type="text" id="ctgltrans2" value="<%=request.querystring("ctgltrans2")%>" size="15" />
        <span class="style11">Tahun / Bulan / Tanggal </span></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td><p>
      <label>
        <input <%If (CStr(request.querystring("cektgl")) = CStr("1")) Then Response.Write("checked=""checked""") : Response.Write("")%> type="radio" name="cektgl" value="1" id="cektgl_0" />
        Dengan Tanggal</label>
      <br />
      <label>
        <input <%If (CStr(request.querystring("cektgl")) = CStr("2")) Then Response.Write("checked=""checked""") : Response.Write("")%> type="radio" name="cektgl" value="2" id="cektgl_1" />
        Tanpa Tanggal</label>
      <br />
    </p></td>
  </tr>
  <tr>
    <td><div align="right"><font size="2" face="Lucida Sans">Keterangan</font></div></td>
    <td align="center">:</td>
    <td><font size="2" face="Lucida Sans">
      <input name="cpengeluaran" type="text" id="cpengeluaran" value="<%=request.querystring("cpengeluaran")%>" size="60" maxlength="50" />
      </font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td><input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
    <tr bgcolor="#9999FF">
      <td width="100px">Tgl Pengeluaran</td>
      <td width="50px" align="center" bgcolor="#FF0000">Jam</td>
      <td width="70px" align="center"> No Urut</td>
      <td width="*"> Keterangan</td>
      <td width="150px" align="left" bgcolor="#FF0000">Petugas</td>
      <td width="75px">Rp.</td>
      </tr>
    <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputpengeluaran.EOF)) 
ctgltransku=tinputpengeluaran.Fields.Item("tgltrans").Value
hari=day(ctgltransku)
bulan=month(ctgltransku)
tahun=year(ctgltransku)
ctgltransku=cstr(tahun)+"-"+cstr(bulan)+"-"+cstr(hari)

%>
    <tr>
      <td align="center"><%=(tinputpengeluaran.Fields.Item("tgltrans").Value)%></td>
      <td bgcolor="#FFFFCC"><%=FormatDateTime(tinputpengeluaran.Fields.Item("jam").Value,4)%></td>
      <td align="center"><A HREF="../editdata/editpengeluaran.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ctgltrans=" & ctgltransku & "&cnourut=" & tinputpengeluaran.Fields.Item("nourut").Value%>"><%=(tinputpengeluaran.Fields.Item("nourut").Value)%></A></td>
      <td><%=(tinputpengeluaran.Fields.Item("pengeluaran").Value)%></td>
      <td bgcolor="#FFFFCC"><%=(tinputpengeluaran.Fields.Item("petugas").Value)%></td>
      <td align="right"><%=(tinputpengeluaran.Fields.Item("tarif").Value)%></td>
      </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputpengeluaran.MoveNext()
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
tinputpengeluaran.Close()
Set tinputpengeluaran = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

