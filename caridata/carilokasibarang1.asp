<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datainventaris.asp" -->
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<%
Dim tlokasi
Dim tlokasi_cmd
Dim tlokasi_numRows

Set tlokasi_cmd = Server.CreateObject ("ADODB.Command")
tlokasi_cmd.ActiveConnection = MM_datainventaris_STRING
tlokasi_cmd.CommandText = "SELECT * FROM inventaris.tlokasi ORDER BY LOKASI ASC" 
tlokasi_cmd.Prepared = true

Set tlokasi = tlokasi_cmd.Execute
tlokasi_numRows = 0
%>
<%
Dim tbarang
Dim tbarang_cmd
Dim tbarang_numRows

Set tbarang_cmd = Server.CreateObject ("ADODB.Command")
tbarang_cmd.ActiveConnection = MM_datainventaris_STRING
tbarang_cmd.CommandText = "SELECT * FROM inventaris.tbarang ORDER BY BARANG ASC" 
tbarang_cmd.Prepared = true

Set tbarang = tbarang_cmd.Execute
tbarang_numRows = 0
%>
<%
Dim tinputlokasibarang__MMColParam1
tinputlokasibarang__MMColParam1 = "%"
If (Request.Form("cklokasi") <> "") Then 
  tinputlokasibarang__MMColParam1 = Request.Form("cklokasi")
End If
%>
<%
Dim tinputlokasibarang__MMColParam2
tinputlokasibarang__MMColParam2 = "%"
If (Request.Form("cbarang") <> "") Then 
  tinputlokasibarang__MMColParam2 = Request.Form("cbarang")
End If
%>
<%
Dim tinputlokasibarang__MMColParam3
tinputlokasibarang__MMColParam3 = "%"
If (Request.Form("cnamapaket") <> "") Then 
  tinputlokasibarang__MMColParam3 = Request.Form("cnamapaket")
End If
%>
<%
Dim tinputlokasibarang__MMColParam4
tinputlokasibarang__MMColParam4 = "%"
If (Request.Form("cket") <> "") Then 
  tinputlokasibarang__MMColParam4 = Request.Form("cket")
End If
%>
<%
Dim tinputlokasibarang
Dim tinputlokasibarang_cmd
Dim tinputlokasibarang_numRows

Set tinputlokasibarang_cmd = Server.CreateObject ("ADODB.Command")
tinputlokasibarang_cmd.ActiveConnection = MM_datainventaris_STRING
tinputlokasibarang_cmd.CommandText = "SELECT * FROM inventaris.vtinputlokasibarang WHERE klokasi like  ? and barang like ? and namapaket  like ? and ket  like ?" 
tinputlokasibarang_cmd.Prepared = true
tinputlokasibarang_cmd.Parameters.Append tinputlokasibarang_cmd.CreateParameter("param1", 200, 1, 255, "%" + tinputlokasibarang__MMColParam1 + "%") ' adVarChar
tinputlokasibarang_cmd.Parameters.Append tinputlokasibarang_cmd.CreateParameter("param2", 200, 1, 255, "%" + tinputlokasibarang__MMColParam2 + "%") ' adVarChar
tinputlokasibarang_cmd.Parameters.Append tinputlokasibarang_cmd.CreateParameter("param3", 200, 1, 255, "%" + tinputlokasibarang__MMColParam3 + "%") ' adVarChar
tinputlokasibarang_cmd.Parameters.Append tinputlokasibarang_cmd.CreateParameter("param4", 200, 1, 255, "%" + tinputlokasibarang__MMColParam4 + "%") ' adVarChar

Set tinputlokasibarang = tinputlokasibarang_cmd.Execute
tinputlokasibarang_numRows = 0
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
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tinputlokasibarang_numRows = tinputlokasibarang_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cari Lokasi Barang</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
	<link rel="STYLESHEET" type="text/css" href="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.css">
	<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcommon.js"></script>
	<script  src="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.js"></script>
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
<script src="../include/terbilang.js"></script>

<script type="text/javascript">
<!--

function simpandata()
{
var cklokasi = document.forms['form1'].elements['cklokasi'].value;
var cbarang = document.forms['form1'].elements['cbarang'].value;
var cnamapaket = document.forms['form1'].elements['cnamapaket'].value;
var cket = document.forms['form1'].elements['cket'].value;

if (cklokasi == '' && cbarang=='' && cnamapaket=='' && cket=='') {
alert("Isian tidak boleh kosong semua, mohon dicek")
document.forms['form1'].elements['cklokasi'].focus();
return false;
}

else {
	document.forms['form1'].submit();
}
}



function isValidDate(ctanggal)
{
if (ctanggal != '0000-00-00') {
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
return true; // date is valid
}

//-->



//-->
</script>

<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 11px; color:#FFFFFF;}
a:pemjumlahand {text-decoration: none;font-size: 11px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 11px; color:#0000FF}
a:link {text-decoration: none;font-size: 11px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 11px; color:#FFFFFF; }
.style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style4 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-weight:bold;
	color: #F00;
}
-->
</style>
</head>
<body onLoad="doOnLoad(), angkaku();">

	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
<script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans"]);
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

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
<div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../menuutama.asp">H o m e</a></li>
                <li><a href="../master/inputbarang.asp">Master Barang</a></li>
                <li><a href="../inputdata/inputlokasibarang.asp">Input Lokasi Barang </a></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form method="post"  name="form1" id="form1">
		    <h2 class="title">CARI LOKASI BARANG</h2>
		    <table width="100%">
              <tr>
                <td width="16%" class="style4">Lokasi</td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%" class="style4"><select name="cklokasi" id="cklokasi">
                  <option value="" <%If (Not isNull(request.form("cklokasi"))) Then If ("" = CStr(request.form("cklokasi"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tlokasi.EOF)
%>
                  <option value="<%=(tlokasi.Fields.Item("KLOKASI").Value)%>" <%If (Not isNull(request.form("cklokasi"))) Then If (CStr(tlokasi.Fields.Item("KLOKASI").Value) = CStr(request.form("cklokasi"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tlokasi.Fields.Item("LOKASI").Value)%></option>
                  <%
  tlokasi.MoveNext()
Wend
If (tlokasi.CursorType > 0) Then
  tlokasi.MoveFirst
Else
  tlokasi.Requery
End If
%>
                </select></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Barang</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><input name="cbarang" type="text" id="cbarang" size="50" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Nama Paket</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><input name="cnamapaket" type="text" id="cnamapaket" value="<%=request.form("cnamapaket")%>" size="50" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Keterangan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cket" cols="50" rows="1" id="cket"><%=request.form("cket")%></textarea></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Cari Data" onclick="simpandata()"/>
                </strong></strong></td>
                </tr>
            </table>
		    <div  id="gridpemjumlahan">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" align="left">Lokasi</td>
		          <td width="*" align="left">Barang</td>
		          <td width="*" align="center">Nama Paket</td>
		          <td width="150px" align="right">Jumlah</td>
		          <td align="center">Keterangan</td>
		          <td align="center">&nbsp;</td>
	            </tr>
		        <% n=0
While ((Repeat1__numRows <> 0) AND (NOT tinputlokasibarang.EOF)) 
n=n+1
%>
		        <tr bgcolor="#FFFFCC">
		          <td height="22"><%=n%></td>
		          <td><a href="../inputdata/inputlokasibarang1.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cklokasi=" & tinputlokasibarang.Fields.Item("klokasi").Value %>"><%=(tinputlokasibarang.Fields.Item("lokasi").Value)%></a></td>
		          <td><%=(tinputlokasibarang.Fields.Item("barang").Value)%></td>
		          <td><%=(tinputlokasibarang.Fields.Item("namapaket").Value)%></td>
		          <td align="right"><%= FormatNumber(tinputlokasibarang.Fields.Item("jumlah").Value, 2, -2, -2, -1) %></td>
		          <td align="left"><%=(tinputlokasibarang.Fields.Item("ket").Value)%></td>
		          <td align="center"><a href="../editdata/editlokasibarang.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & tinputlokasibarang.Fields.Item("notrans").Value  & "&cklokasi=" & tinputlokasibarang.Fields.Item("klokasi").Value  %>">Edit</a></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputlokasibarang.MoveNext()
Wend
%>
	          </table>
		    </div>
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
    	Copyright © 2017 agoes irdianto - kalboya@yahoo.com    </div> 
    <!-- end of footer -->
<!--  Free Website Templates @ TemplateMo.com  -->
</div>
<div align=center></div>
</body>
</html>
<%
tlokasi.Close()
Set tlokasi = Nothing
%>
<%
tbarang.Close()
Set tbarang = Nothing
%>
<%
tinputlokasibarang.Close()
Set tinputlokasibarang = Nothing
%>
