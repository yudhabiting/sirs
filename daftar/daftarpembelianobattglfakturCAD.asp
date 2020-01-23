<%@LANGUAGE="VBSCRIPT" %>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="farmasi" then
elseif lcase(trim(Session("MM_statususer")))="keuangan" then
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
Dim vtmasukobat__MMColParam1
vtmasukobat__MMColParam1 = "1"
If (Request.QueryString("cnofaktur") <> "") Then 
  vtmasukobat__MMColParam1 = Request.QueryString("cnofaktur")
End If
%>
<%
Dim vtmasukobat__MMColParam2
vtmasukobat__MMColParam2 = "1"
If (Request.QueryString("cksuplier") <> "") Then 
  vtmasukobat__MMColParam2 = Request.QueryString("cksuplier")
End If
%>
<%
Dim vtmasukobat__MMColParam3
vtmasukobat__MMColParam3 = "1"
If (Request.QueryString("clunas")  <> " ") Then 
  vtmasukobat__MMColParam3 = Request.QueryString("clunas") 
End If
%>
<%
Dim vtmasukobat
Dim vtmasukobat_numRows

Set vtmasukobat = Server.CreateObject("ADODB.Recordset")
vtmasukobat.ActiveConnection = MM_datarspermata_STRING
vtmasukobat.Source = "SELECT * FROM rspermata.vtmasukobat  WHERE nofaktur like '%" + Replace(vtmasukobat__MMColParam1, "'", "''") + "%' and ksuplier like '%" + Replace(vtmasukobat__MMColParam2, "'", "''") + "%' and lunas like '%" + Replace(vtmasukobat__MMColParam3, "'", "''") + "%' ORDER BY tglfaktur,suplier ASC"
vtmasukobat.CursorType = 0
vtmasukobat.CursorLocation = 2
vtmasukobat.LockType = 1
vtmasukobat.Open()

vtmasukobat_numRows = 0
%>
<%
Dim tsuplier
Dim tsuplier_cmd
Dim tsuplier_numRows

Set tsuplier_cmd = Server.CreateObject ("ADODB.Command")
tsuplier_cmd.ActiveConnection = MM_datarspermata_STRING
tsuplier_cmd.CommandText = "SELECT * FROM rspermata.tsuplier ORDER BY suplier ASC" 
tsuplier_cmd.Prepared = true

Set tsuplier = tsuplier_cmd.Execute
tsuplier_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 100
Repeat1__index = 0
vtmasukobat_numRows = vtmasukobat_numRows + Repeat1__numRows
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
<title>Daftar Pembelian Obat Berdasarkan Tgl Faktur</title>
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
                <li><a href="../inputdata/inputobatmasuk.asp">Input Pembelian Obat</a></li>
                <li></li>
                <li ></li>
                <li class="current"></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
      <form action="daftarpembelianobattglfaktur1.asp" method="get" name="form1">
<p>&nbsp;</p>
<table width="100%">
		  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglfaktur1","ctglfaktur2"]);
		}
	</script>

  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Dari Tanggal Faktur</font></span></div></td>
    <td align="center">:</td>
    <td><div align="left">
        <input name="ctglfaktur1" type="text" id="ctglfaktur1" value="<%=request.querystring("ctglfaktur1")%>" size="15" />
        <span class="style11">Tahun / Bulan / Tanggal </span></div></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Sampai Tanggal Faktur</font></span></div></td>
    <td align="center">:</td>
    <td><div align="left">
      <input name="ctglfaktur2" type="text" id="ctglfaktur2" value="<%=request.querystring("ctglfaktur2")%>" size="15" />
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
    <td width="15%"><div align="right"><font size="2" face="Lucida Sans">No Faktur</font></div></td>
    <td width="1%" align="center">:</td>
    <td width="84%"><font color="white">
      <input name="cnofaktur" type="text" id="cnofaktur" value="<%=request.querystring("cnofaktur")%>" size="30" maxlength="15" />
      </font></td>
  </tr>
  <tr>
    <td><div align="right"><font size="2" face="Lucida Sans">S<span class="style11">uplier</span></font></div></td>
    <td align="center">:</td>
    <td><select name="cksuplier" id="cksuplier">
      <option value=""></option>
      <%
While (NOT tsuplier.EOF)
%>
      <option value="<%=(tsuplier.Fields.Item("ksuplier").Value)%>"><%=(tsuplier.Fields.Item("suplier").Value)%></option>
      <%
  tsuplier.MoveNext()
Wend
If (tsuplier.CursorType > 0) Then
  tsuplier.MoveFirst
Else
  tsuplier.Requery
End If
%>
    </select></td>
  </tr>
  <tr>
    <td><div align="right"><span class="style11"><font size="2" face="Lucida Sans">Status </font></span></div></td>
    <td align="center">:</td>
    <td><select name="clunas" id="clunas">
      <option value=" " <%If (Not isNull(request.querystring("clunas"))) Then If (" " = CStr(request.querystring("clunas"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>SEMUA DATA</option>
      <option value="B" <%If (Not isNull(request.querystring("clunas"))) Then If ("B" = CStr(request.querystring("clunas"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>BELUM LUNAS</option>
      <option value="L" <%If (Not isNull(request.querystring("clunas"))) Then If ("L" = CStr(request.querystring("clunas"))) Then Response.Write("selected=""selected""") : Response.Write("")%>>LUNAS</option>
      </select>
      <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table width="100%" align="center" class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
  <tr bgcolor="#9999FF">
    <td width="70px" align="center">Tgl Faktur</td>
    <td width="150px" align="left"> No Faktur</td>
    <td width="70px" align="center">Tgl Terima</td>
    <td width="100px" align="center">Tgl Jatuh Tempo</td>
    <td width="250px" align="left"> Suplier</td>
    <td width="100px" align="center">Status </td>
    <td width="80px" align="right">Sub Total</td>
    <td width="50px" align="right">Pajak</td>
    <td width="80px" align="right">Total</td>
  </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT vtmasukobat.EOF)) 
%>
  <tr>
    <td align="center"><a href="../inputdata/inputobatmasuk1.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtmasukobat.Fields.Item("notrans").Value %>"><%=(vtmasukobat.Fields.Item("tglfaktur").Value)%></a></td>
    <td align="center"><%=(vtmasukobat.Fields.Item("nofaktur").Value)%></td>
    <td><%=(vtmasukobat.Fields.Item("tglterima").Value)%></td>
    <td><%=(vtmasukobat.Fields.Item("tgljatuhtempo").Value)%></td>
    <td><%=(vtmasukobat.Fields.Item("suplier").Value)%></td>
    <td><% 
	  if(vtmasukobat.Fields.Item("lunas").Value)="L"then
	  	response.Write("LUNAS")
	  else
	  	response.Write("BELUM LUNAS")
	  end if
	  %></td>
    <td><%= FormatNumber((vtmasukobat.Fields.Item("total").Value), 0, 0, -2, -1) %></td>
    <td><%=(vtmasukobat.Fields.Item("pajak").Value)%></td>
    <td><%= FormatNumber((vtmasukobat.Fields.Item("grandtotal").Value), 0, 0, -2, -1) %></td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtmasukobat.MoveNext()
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
vtmasukobat.Close()
Set vtmasukobat = Nothing
%>
<%
tsuplier.Close()
Set tsuplier = Nothing
%>

<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>
