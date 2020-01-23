<%@LANGUAGE="VBSCRIPT"%>
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
ctgltrans=request.form("ctgltrans")
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
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_update")) = "form1" and CStr(Request("ckondisiku")) = "2") Then

  If (Not MM_abortEdit) Then
    ' execute the delete
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputpengeluaran WHERE tgltrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble

    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputpengeluaran1.asp"
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
If (CStr(Request("MM_update")) = "form1" and CStr(Request("ckondisiku")) = "1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "UPDATE rspermata.tinputpengeluaran SET  jam=?, tarif = ?,  pengeluaran = ?, kpegawai2=?, kpegawai=? WHERE tgltrans = ? and nourut=?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 135, 1, -1, MM_IIF(Request.Form("cjam"), Request.Form("cjam"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("ctarif"), Request.Form("ctarif"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 201, 1, 255, Request.Form("cpengeluaran")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 201, 1, 6, Request.Form("ckpegawai2")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 201, 1, 6, Request.Form("ckpegawai")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 135, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDBTimeStamp
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "../inputdata/inputpengeluaran1.asp"
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
Dim tinputpengeluaranedit__MMColParam
tinputpengeluaranedit__MMColParam = "1"
If (Request.QueryString("ctgltrans") <> "") Then 
  tinputpengeluaranedit__MMColParam = Request.QueryString("ctgltrans")
End If
%>
<%
Dim tinputpengeluaranedit__MMColParam2
tinputpengeluaranedit__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputpengeluaranedit__MMColParam2 = Request.QueryString("cnourut")
End If
%>

<%
Dim tinputpengeluaranedit
Dim tinputpengeluaranedit_cmd
Dim tinputpengeluaranedit_numRows

Set tinputpengeluaranedit_cmd = Server.CreateObject ("ADODB.Command")
tinputpengeluaranedit_cmd.ActiveConnection = MM_datarspermata_STRING
tinputpengeluaranedit_cmd.CommandText = "SELECT * FROM rspermata.tinputpengeluaran WHERE tgltrans = ? and nourut = ? order by tgltrans,nourut" 
tinputpengeluaranedit_cmd.Prepared = true
tinputpengeluaranedit_cmd.Parameters.Append tinputpengeluaranedit_cmd.CreateParameter("param1", 200, 1, 15, tinputpengeluaranedit__MMColParam) ' adVarChar
tinputpengeluaranedit_cmd.Parameters.Append tinputpengeluaranedit_cmd.CreateParameter("param2", 5, 1, -1, tinputpengeluaranedit__MMColParam2) ' adDouble

Set tinputpengeluaranedit =tinputpengeluaranedit_cmd.Execute
tinputpengeluaranedit_numRows = 0
%>


<%
Dim tinputpengeluaran__MMColParam
tinputpengeluaran__MMColParam = "1"
If (Request.QueryString("ctgltrans") <> "") Then 
  tinputpengeluaran__MMColParam = Request.QueryString("ctgltrans")
End If
%>

<%
Dim tinputpengeluaran
Dim tinputpengeluaran_cmd
Dim tinputpengeluaran_numRows

Set tinputpengeluaran_cmd = Server.CreateObject ("ADODB.Command")
tinputpengeluaran_cmd.ActiveConnection = MM_datarspermata_STRING
tinputpengeluaran_cmd.CommandText = "SELECT * FROM rspermata.vtinputpengeluaran WHERE tgltrans = ?  order by tgltrans,nourut" 
tinputpengeluaran_cmd.Prepared = true
tinputpengeluaran_cmd.Parameters.Append tinputpengeluaran_cmd.CreateParameter("param1", 200, 1, 15, tinputpengeluaran__MMColParam) ' adVarChar

Set tinputpengeluaran = tinputpengeluaran_cmd.Execute
tinputpengeluaran_numRows = 0
%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai where status='1' order by nama" 
tpegawai_cmd.Prepared = true

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
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
<title>Edit Pengeluaran</title>
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

function hapusdata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;

if (ctarif == '') {
alert("jumlah kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}

else if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else {
	document.forms['form1'].elements['ckondisiku'].value='2';
	var r=confirm("Anda yakin mau menghapus data ini!");
	if (r==true)
	  {
		document.forms['form1'].submit();
	  }
	}
}

function simpandata()
{
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;


if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else if (ctarif == '') {
alert("tarif kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
	
else {
	document.forms['form1'].elements['ckondisiku'].value='1';
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
a:pengeluarand {text-decoration: none;font-size: 11px; color:#FF0000}
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
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../menuutama.asp">H o m e</a></li>
                <li><a href="../daftar/daftardatapengeluaran.asp">Cari Data Pengeluaran</a></li>
                <li><a href="../inputdata/inputpengeluaran.asp">Input Data Pengeluaran</a></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form  METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT  PENGELUARAN</h2>
		    <table width="100%">
              <tr>
                <td width="16%" class="style4"><span class="style3">Tanggal</span></td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%"><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputpengeluaranedit.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" readonly="readonly"/>
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Jam</span></td>
                <td><div align="center">:</div></td>
                <td><strong>
                  <input name="cjam" type="text" id="cjam" value="<%= FormatDateTime((tinputpengeluaranedit.Fields.Item("jam").Value), 4) %>"  size="10" maxlength="8" readonly="readonly" />
                </strong></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Keterangan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="cpengeluaran" id="cpengeluaran" cols="70" rows="3"><%=(tinputpengeluaranedit.Fields.Item("pengeluaran").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Jumlah</span></td>
                <td><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputpengeluaranedit.Fields.Item("tarif").Value)%>" size="20" maxlength="10" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Petugas</span></td>
                <td><div align="center">:</div></td>
                <td>
                <select name="ckpegawai2" id="ckpegawai2">
                  <option value="" <%If (Not isNull(tinputpengeluaranedit.Fields.Item("kpegawai2").Value)) Then If ("" = CStr(tinputpengeluaranedit.Fields.Item("kpegawai2").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tpegawai.EOF)
%>
                  <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull(tinputpengeluaranedit.Fields.Item("kpegawai2").Value)) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr(tinputpengeluaranedit.Fields.Item("kpegawai2").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
                  <%
  tpegawai.MoveNext()
Wend
If (tpegawai.CursorType > 0) Then
  tpegawai.MoveFirst
Else
  tpegawai.Requery
End If
%>
                </select>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong><strong><strong><strong><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>
                </strong></strong></strong></strong></strong>
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputpengeluaranedit.Fields.Item("nourut").Value)%>" />
                <strong><strong><strong>
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                <input type="hidden" name="MM_update" value="form1" />
                <input type="hidden" name="MM_recordId" value="<%= tinputpengeluaranedit.Fields.Item("tgltrans").Value %>" />
                </strong></strong></strong></strong></strong></td>
                </tr>
            </table>
		    <div  id="gridpengeluaran">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">Jam</td>
		          <td width="90px" align="center">No Urut</td>
		          <td width="*" align="left">Keterangan</td>
		          <td width="150px" align="left">Petugas</td>
		          <td width="100px" align="left">Jumlah </td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputpengeluaran.EOF))
ctgltransku=tinputpengeluaran.Fields.Item("tgltrans").Value
hari=day(ctgltransku)
bulan=month(ctgltransku)
tahun=year(ctgltransku)
ctgltransku=cstr(tahun)+"-"+cstr(bulan)+"-"+cstr(hari)
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(tinputpengeluaran.Fields.Item("tgltrans").Value)%></td>
		          <td><%=FormatDateTime(tinputpengeluaran.Fields.Item("jam").Value,4)%></td>
		          <td height="22"><a href="editpengeluaran.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "ctgltrans=" & ctgltransku & "&cnourut=" & tinputpengeluaran.Fields.Item("nourut").Value %>"><%=(tinputpengeluaran.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(tinputpengeluaran.Fields.Item("pengeluaran").Value)%></td>
		          <td><%=(tinputpengeluaran.Fields.Item("petugas").Value)%></td>
		          <td><%=(tinputpengeluaran.Fields.Item("tarif").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputpengeluaran.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="ckpegawai" value="<%=Session("MM_userid")%>" />
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
tinputpengeluaranedit.Close()
Set tinputpengeluaranedit = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>