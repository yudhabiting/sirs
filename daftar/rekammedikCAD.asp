<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>
<%
Dim trawatpasien__MMColParam
trawatpasien__MMColParam = "1"
If (Request.QueryString("cnocm") <> "") Then 
  trawatpasien__MMColParam = Request.QueryString("cnocm")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT * FROM rspermata.trawatpasien WHERE nocm = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
Dim vtrekammedik__MMColParam
vtrekammedik__MMColParam = "1"
If (Request.QueryString("cnocm") <> "") Then 
  vtrekammedik__MMColParam = Request.QueryString("cnocm")
End If
%>
<%
Dim vtrekammedik
Dim vtrekammedik_cmd
Dim vtrekammedik_numRows

Set vtrekammedik_cmd = Server.CreateObject ("ADODB.Command")
vtrekammedik_cmd.ActiveConnection = MM_datarspermata_STRING
vtrekammedik_cmd.CommandText = "SELECT * FROM rspermata.vtrekammedik WHERE nocm = ? ORDER BY tglmasuk ASC" 
vtrekammedik_cmd.Prepared = true
vtrekammedik_cmd.Parameters.Append vtrekammedik_cmd.CreateParameter("param1", 200, 1, 10, vtrekammedik__MMColParam) ' adVarChar

Set vtrekammedik = vtrekammedik_cmd.Execute
vtrekammedik_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
vtrekammedik_numRows = vtrekammedik_numRows + Repeat1__numRows
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
<title>Rekam Medik</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!-- Begin


var timerID = null;
var timerRunning = false;
function stopclock (){
if(timerRunning)
clearTimeout(timerID);
timerRunning = false;
}
function showtime () {
	
	
var now = new Date();
var hours = now.getHours();
var minutes = now.getMinutes();
var seconds = now.getSeconds()
var timeValue = "" + ((hours >12) ? hours -12 :hours)
if (timeValue == "0") timeValue = 12;
timeValue += ((minutes < 10) ? ":0" : ":") + minutes
timeValue += ((seconds < 10) ? ":0" : ":") + seconds
timeValue += (hours >= 12) ? " PM" : " AM"
document.form1.cjamdaftar.value = timeValue;

timerID = setTimeout("showtime()",1000);
timerRunning = true;
}
function startclock() {
stopclock();
showtime();
}

function tglsekarang() {
var todayDate=new Date();
var date=todayDate.getDate();
var month=todayDate.getMonth()+1;
var year=todayDate.getFullYear();
document.form1.ctgldaftar.value=year+'/'+month+'/'+date;
}

// End -->
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
.style1 {font-size: 12px}
.style2 {font-size: 20px ; color:#900; font:bold;}
.styleku1 {	font-size: 12px;
	color: #000;
}
.style3 {font-size: 13px ; color:#900; }
.style4 {font-size: 13px ; color:#900; }

div.gridku .obj td{
   white-space: break-word;
}
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

          <table width="100%">
            <tr>
              <td width="39%">&nbsp;</td>
              <td width="3%">&nbsp;</td>
              <td width="58%">&nbsp;</td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12"><span class="style2">NOCM</span></span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style2"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
            </tr>
            <tr>
              <td><div align="right" class="style2">Nama</div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style2"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
            </tr>
            <tr>
              <td><div align="right" class="style1"><span class="style12">Alamat</span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style1"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
            </tr>
            
            <tr>
              <td height="24"><div align="right" class="style1"><span class="style12">Umur  </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style1"><%=(trawatpasien.Fields.Item("umurthn").Value)%> Tahun <%=(trawatpasien.Fields.Item("umurbln").Value)%> Bulan <%=(trawatpasien.Fields.Item("umurhr").Value)%> Hari </td>
            </tr>
            <tr>
              <td height="23"><div align="right" class="style1"><span class="style12">Jenis Kelamin </span></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td class="style1"><%=(trawatpasien.Fields.Item("jeniskel").Value)%></td>
            </tr>
            <tr>
              <td height="21" align="center"><div align="right" class="style1"><font size="2" face="Arial, Helvetica, sans-serif">Tinggi Badan</font></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="styleku1"><%=(trawatpasien.Fields.Item("tinggibadan").Value)%> </span><span class="style1">Cm</span></td>
            </tr>
            <tr>
              <td height="25" align="center"><div align="right" class="style1"><font size="2" face="Arial, Helvetica, sans-serif">Berat Badan</font></div></td>
              <td><div align="center" class="style1"><strong><span class="style12">:</span></strong></div></td>
              <td><span class="styleku1"><%=(trawatpasien.Fields.Item("beratbadan").Value)%></span><span class="style1"> Kg</span></td>
            </tr>
          </table>
<table width="100%"  class="dhtmlxGrid" style="width:*" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true" >
    	    <tr >
    	      <td width="100px" align="center">Tgl Kunjungan</td>
    	      <td width="100px" align="center">Status Berobat</td>
    	      <td width="*" align="center">Gejala</td>
    	      <td width="*" align="center">Penyakit Masuk</td>
    	      <td width="*" align="center">Penyakit Keluar</td>
    	      <td width="*" align="center">Terapi</td>
    	      <td width="*" align="center">Petugas</td>
  </tr>
            <% 
While ((Repeat1__numRows <> 0) AND (NOT vtrekammedik.EOF)) 
%>
  <tr>
    <td align="center"><a href="../editdata/editrawatpasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & trawatpasien.Fields.Item("notrans").Value %>"><%=(vtrekammedik.Fields.Item("tglmasuk").Value)%></a></td>
    <td align="center"><% 
	  if(vtrekammedik.Fields.Item("statuspasien").Value)="1"then
	  	response.Write("RAWAT JALAN")
	  else
	  	response.Write("RAWAT INAP")
	  end if
	  %></td>
    <td align="center"><%=(vtrekammedik.Fields.Item("gejala").Value)%></td>
    <td align="left"><%=(vtrekammedik.Fields.Item("penyakit").Value)%></td>
    <td align="left"><%=(vtrekammedik.Fields.Item("kpenyakit2").Value)%></td>
    <td  align="left"><%=(vtrekammedik.Fields.Item("terapi").Value)%></td>
    <td align="left"><%=(vtrekammedik.Fields.Item("dokter").Value)%></td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtrekammedik.MoveNext()
Wend
%>
</table>
</body>
</html>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
vtrekammedik.Close()
Set vtrekammedik = Nothing
%>
