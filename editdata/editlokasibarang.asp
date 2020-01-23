<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datainventaris.asp" -->
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>

<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datainventaris_STRING
    MM_editCmd.CommandText = "UPDATE inventaris.tinputlokasibarang SET klokasi = ?, kbarang = ?, namapaket = ?, jumlah = ?, ket = ? WHERE notrans = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 201, 1, 3, Request.Form("cklokasi")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 201, 1, 10, Request.Form("ckbarang")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 50, Request.Form("cnamapaket")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 5, 1, -1, MM_IIF(Request.Form("cjumlah"), Request.Form("cjumlah"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 201, 1, 50, Request.Form("cket")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputlokasibarang1.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
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
Dim tinputlokasibarangedit__MMColParam1
tinputlokasibarangedit__MMColParam1 = "1"
If (Request.QueryString("cnotrans")  <> "") Then 
  tinputlokasibarangedit__MMColParam1 = Request.QueryString("cnotrans") 
End If
%>
<%
Dim tinputlokasibarangedit
Dim tinputlokasibarangedit_cmd
Dim tinputlokasibarangedit_numRows

Set tinputlokasibarangedit_cmd = Server.CreateObject ("ADODB.Command")
tinputlokasibarangedit_cmd.ActiveConnection = MM_datainventaris_STRING
tinputlokasibarangedit_cmd.CommandText = "SELECT * FROM inventaris.tinputlokasibarang WHERE notrans= ? " 
tinputlokasibarangedit_cmd.Prepared = true
tinputlokasibarangedit_cmd.Parameters.Append tinputlokasibarangedit_cmd.CreateParameter("param1", 200, 1, 255, tinputlokasibarangedit__MMColParam1) ' adVarChar

Set tinputlokasibarangedit = tinputlokasibarangedit_cmd.Execute
tinputlokasibarangedit_numRows = 0
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
<title>Edit Lokasi Barang</title>
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
var ckbarang = document.forms['form1'].elements['ckbarang'].value;
var cjumlah = document.forms['form1'].elements['cjumlah'].value;

if (cklokasi == '') {
alert("Lokasi kosong, mohon dicek")
document.forms['form1'].elements['cklokasi'].focus();
return false;
}
else if (ckbarang == '') {
alert("Barang kosong, mohon dicek")
document.forms['form1'].elements['ckbarang'].focus();
return false;
}

else if (cjumlah == '' || cjumlah<0 ) {
alert("jumlah  tidak boleh kosong atau dibawah 0, mohon dicek")
document.forms['form1'].elements['cjumlah'].focus();
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
                <li><a href="../inputdata/inputlokasibarang.asp">Input Lokasi Barang Lainnya </a></li>
                <li><a href="../inputdata/inputlokasibarang1.asp?cklokasi=<%=(tinputlokasibarangedit.Fields.Item("klokasi").Value)%>">Input Lokasi Barang </a></li>
                <li><a href="../caridata/carilokasibarang.asp">Cari Lokasi Barang</a></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT  LOKASI BARANG</h2>
		    <table width="100%">
              <tr>
                <td width="16%" class="style4">Lokasi</td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%" class="style4"><select name="cklokasi" id="cklokasi">
                  <option value="" <%If (Not isNull((tinputlokasibarangedit.Fields.Item("klokasi").Value))) Then If ("" = CStr((tinputlokasibarangedit.Fields.Item("klokasi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tlokasi.EOF)
%>
                  <option value="<%=(tlokasi.Fields.Item("KLOKASI").Value)%>" <%If (Not isNull((tinputlokasibarangedit.Fields.Item("klokasi").Value))) Then If (CStr(tlokasi.Fields.Item("KLOKASI").Value) = CStr((tinputlokasibarangedit.Fields.Item("klokasi").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tlokasi.Fields.Item("LOKASI").Value)%></option>
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
                <td class="style4"><select name="ckbarang" id="ckbarang">
                  <option value="" <%If (Not isNull((tinputlokasibarangedit.Fields.Item("kbarang").Value))) Then If ("" = CStr((tinputlokasibarangedit.Fields.Item("kbarang").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tbarang.EOF)
%>
                  <option value="<%=(tbarang.Fields.Item("KBARANG").Value)%>" <%If (Not isNull((tinputlokasibarangedit.Fields.Item("kbarang").Value))) Then If (CStr(tbarang.Fields.Item("KBARANG").Value) = CStr((tinputlokasibarangedit.Fields.Item("kbarang").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tbarang.Fields.Item("BARANG").Value)%></option>
                  <%
  tbarang.MoveNext()
Wend
If (tbarang.CursorType > 0) Then
  tbarang.MoveFirst
Else
  tbarang.Requery
End If
%>
                </select></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Nama Paket</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><input name="cnamapaket" type="text" id="cnamapaket" value="<%=(tinputlokasibarangedit.Fields.Item("namapaket").Value)%>" size="50" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Jumlah</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cjumlah" type="text" id="cjumlah" value="<%=(tinputlokasibarangedit.Fields.Item("jumlah").Value)%>" size="15" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Keterangan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cket" cols="50" rows="1" id="cket"><%=(tinputlokasibarangedit.Fields.Item("ket").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tahun Pembelian</span></td>
                <td><div align="center">:</div></td>
                <td><input name="ctahunbeli" type="text" id="ctahunbeli" size="10" maxlength="4" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Harga Perolehan</span></td>
                <td><div align="center">:</div></td>
                <td><input name="chargabeli" type="text" id="chargabeli" size="20" maxlength="10" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Prosentase Penyusutan</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cprosensusut" type="text" id="cprosensusut" size="10" maxlength="5" />
                  <span class="style3">Per Tahun</span></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Simpan" onclick="simpandata()"/>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(tinputlokasibarangedit.Fields.Item("notrans").Value)%>" />
                </strong></strong></td>
                </tr>
            </table>
		    <div  id="gridpemjumlahan"></div>
            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputlokasibarangedit.Fields.Item("notrans").Value %>" />
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
tinputlokasibarangedit.Close()
Set tinputlokasibarangedit = Nothing
%>
