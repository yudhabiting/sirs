<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datarspermata.asp" -->
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
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_delete")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  If (Not MM_abortEdit) Then
    ' execute the delete
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputkelas WHERE notrans = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputkelaspasien.asp"
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
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<%
cnotrans=request.QueryString("cnotrans")
%>
<%
Dim vtinputkelaspasien__MMColParam
vtinputkelaspasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputkelaspasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputkelaspasien
Dim vtinputkelaspasien_cmd
Dim vtinputkelaspasien_numRows

Set vtinputkelaspasien_cmd = Server.CreateObject ("ADODB.Command")
vtinputkelaspasien_cmd.ActiveConnection = MM_datarspermata_STRING
vtinputkelaspasien_cmd.CommandText = "SELECT * FROM rspermata.vtinputkelaspasien WHERE notrans = ? order by tgltrans,nourut" 
vtinputkelaspasien_cmd.Prepared = true
vtinputkelaspasien_cmd.Parameters.Append vtinputkelaspasien_cmd.CreateParameter("param1", 200, 1, 15, vtinputkelaspasien__MMColParam) ' adVarChar

Set vtinputkelaspasien = vtinputkelaspasien_cmd.Execute
vtinputkelaspasien_numRows = 0
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
cdaftartarif=""
While (NOT tkelas.EOF)
  cdaftartarif=cdaftartarif&" "&"kode"&(tkelas.Fields.Item("kkelas").Value)&(tkelas.Fields.Item("tarif").Value)
  tkelas.MoveNext()
Wend
If (tkelas.CursorType > 0) Then
  tkelas.MoveFirst
Else
  tkelas.Requery
End If
%>

<%
Dim tinputkelaspasien__MMColParam
tinputkelaspasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputkelaspasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputkelaspasien__MMColParam2
tinputkelaspasien__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputkelaspasien__MMColParam2 = Request.QueryString("cnourut")
End If
%>

<%
Dim tinputkelaspasien
Dim tinputkelaspasien_cmd
Dim tinputkelaspasien_numRows

Set tinputkelaspasien_cmd = Server.CreateObject ("ADODB.Command")
tinputkelaspasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputkelaspasien_cmd.CommandText = "SELECT * FROM rspermata.tinputkelas WHERE notrans = ? and nourut = ? " 
tinputkelaspasien_cmd.Prepared = true
tinputkelaspasien_cmd.Parameters.Append tinputkelaspasien_cmd.CreateParameter("param1", 200, 1, 15, tinputkelaspasien__MMColParam) ' adVarChar
tinputkelaspasien_cmd.Parameters.Append tinputkelaspasien_cmd.CreateParameter("param2", 5, 1, -1, tinputkelaspasien__MMColParam2) ' adDouble

Set tinputkelaspasien = tinputkelaspasien_cmd.Execute
tinputkelaspasien_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
vtinputkelaspasien_numRows = vtinputkelaspasien_numRows + Repeat1__numRows
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
<title>Edit Ruangan Pasien</title>
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
<script type="text/javascript">
<!--
function tarifku(cktindakan)
{
	var txt1='<%=(cdaftartarif)%>';
	spl = txt1.split(" ");
	var txt2="kode"+cktindakan;
	for(i = 0; i < spl.length; i++)
	{
		var kodetindakan=spl[i].toString();
		var kodetindakan=kodetindakan.substring(0,6);
		if (kodetindakan==txt2) {
			var panjang=spl[i].length;
			var jmltarif=spl[i].substring(6,panjang);
			document.forms['form1'].elements['ctarif'].value=jmltarif;
			
		}
	}
}

function simpandata()
{
var ckkelas = document.forms['form1'].elements['ckkelas'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;


if (ckkelas == '') {
alert("kelas kosong, mohon dicek")
document.forms['form1'].elements['ckkelas'].focus();
return false;
}
else if (ctarif == '') {
alert("tarif kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
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
a:visited {text-decoration: none;font-size: 11px; color:#FF0000}
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
<body onLoad="doOnLoad();">

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
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="editrawatpasien.asp?cnotrans=<%=(cnotrans)%>">Rawat Pasien</a></li>
                <li><a href="../inputdata/inputkelaspasien.asp?cnotrans=<%=(cnotrans)%>">Input Ruangan</a></li>
  <li><a href="../inputdata/inputtindakanpasien.asp?cnotrans=<%=(cnotrans)%>">Input Tindakan</a></li>
                <li></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT  RUANGAN PASIEN</h2>
		    <table width="100%">
              <tr>
                <td width="16%" class="style4"><span class="style3">Notrans</span></td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%" class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">NoCM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputkelaspasien.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">kelas</span></td>
                <td><div align="center">:</div></td>
                <td>
                <select name="ckkelas" id="ckkelas" onChange="tarifku(this.value)">
                  <option value="" <%If (Not isNull((tinputkelaspasien.Fields.Item("kkelas").Value))) Then If ("" = CStr((tinputkelaspasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tkelas.EOF)
%>
                  <option value="<%=(tkelas.Fields.Item("kkelas").Value)%>" <%If (Not isNull((tinputkelaspasien.Fields.Item("kkelas").Value))) Then If (CStr(tkelas.Fields.Item("kkelas").Value) = CStr((tinputkelaspasien.Fields.Item("kkelas").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tkelas.Fields.Item("kelas").Value)%></option>
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
                <td class="style4"><span class="style3">Keterangan </span></td>
                <td><div align="center">:</div></td>
                <td><input name="cket" type="text" id="cket" value="<%=(tinputkelaspasien.Fields.Item("ket").Value)%>" size="80" maxlength="80" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tarif</span></td>
                <td><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputkelaspasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Simpan" onclick="simpandata()"/>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                </strong></strong></td>
                </tr>
            </table>
		    <div  id="gridkelas">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="200px" align="left">Ruangan</td>
		          <td width="100px" align="right">Tarif</td>
		          <td width="*" align="center">ket </td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputkelaspasien.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(vtinputkelaspasien.Fields.Item("tgltrans").Value)%></td>
		          <td height="22"><a href="editkelaspasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputkelaspasien.Fields.Item("notrans").Value & "&cnourut=" & vtinputkelaspasien.Fields.Item("nourut").Value %>"><%=(vtinputkelaspasien.Fields.Item("nourut").Value)%></a></td>
		          <td>
		            <%
While (NOT tkelas.EOF)
if (tkelas.Fields.Item("kkelas").Value)=(vtinputkelaspasien.Fields.Item("kkelas").Value) then
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
		          <td><%=(vtinputkelaspasien.Fields.Item("tarif").Value)%></td>
		          <td><%=(vtinputkelaspasien.Fields.Item("ket").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputkelaspasien.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="MM_delete" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= vtinputkelaspasien.Fields.Item("notrans").Value %>" />
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
vtinputkelaspasien.Close()
Set vtinputkelaspasien = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
tinputkelaspasien.Close()
Set tinputkelaspasien = Nothing
%>
