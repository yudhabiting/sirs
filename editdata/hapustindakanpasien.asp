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
    MM_editCmd.CommandText = "DELETE FROM rspermata.tinputtindakan WHERE notrans = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 15, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../inputdata/inputtindakanpasien.asp"
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
Dim ttindakan__MMColParam1
ttindakan__MMColParam1 = "%"
If (Request.Form("cktindakan") <> "") Then 
  ttindakan__MMColParam1 = Request.Form("cktindakan")
End If
%>
<%
Dim ttindakan__MMColParam2
ttindakan__MMColParam2 = "%"
If (Request.Form("ctindakan") <> "") Then 
  ttindakan__MMColParam2 = Request.Form("ctindakan")
End If
%>
<%
Dim ttindakan__MMColParam3
ttindakan__MMColParam3 = "%"
If (Request.Form("ckgoltindakan")   <> "") Then 
  ttindakan__MMColParam3 = Request.Form("ckgoltindakan")  
End If
%>
<%
Dim ttindakan__MMColParam4
ttindakan__MMColParam4 = "%"
If (Request.Form("ckjenistindakan")  <> "") Then 
  ttindakan__MMColParam4 = Request.Form("ckjenistindakan") 
End If
%>
<%
Dim ttindakan
Dim ttindakan_cmd
Dim ttindakan_numRows

Set ttindakan_cmd = Server.CreateObject ("ADODB.Command")
ttindakan_cmd.ActiveConnection = MM_datarspermata_STRING
ttindakan_cmd.CommandText = "SELECT * FROM rspermata.ttindakan WHERE ktindakan LIKE ? and tindakan LIKE ? and kgoltindakan LIKE ? and kjenistindakan LIKE ? ORDER BY kgoltindakan,tindakan ASC" 
ttindakan_cmd.Prepared = true
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param1", 200, 1, 10, "%" + ttindakan__MMColParam1 + "%") ' adVarChar
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param2", 200, 1, 100, "%" + ttindakan__MMColParam2 + "%") ' adVarChar
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param3", 200, 1, 255, "%" + ttindakan__MMColParam3 + "%") ' adVarChar
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param4", 200, 1, 255, "%" + ttindakan__MMColParam4 + "%") ' adVarChar

Set ttindakan = ttindakan_cmd.Execute
ttindakan_numRows = 0
%>
<%
Dim tgoltindakan
Dim tgoltindakan_cmd
Dim tgoltindakan_numRows

Set tgoltindakan_cmd = Server.CreateObject ("ADODB.Command")
tgoltindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tgoltindakan_cmd.CommandText = "SELECT * FROM rspermata.tgoltindakan" 
tgoltindakan_cmd.Prepared = true

Set tgoltindakan = tgoltindakan_cmd.Execute
tgoltindakan_numRows = 0
%>
<%
Dim tjenistindakan
Dim tjenistindakan_cmd
Dim tjenistindakan_numRows

Set tjenistindakan_cmd = Server.CreateObject ("ADODB.Command")
tjenistindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tjenistindakan_cmd.CommandText = "SELECT * FROM rspermata.tjenistindakan" 
tjenistindakan_cmd.Prepared = true

Set tjenistindakan = tjenistindakan_cmd.Execute
tjenistindakan_numRows = 0
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
vtinputtindakanpasien_cmd.CommandText = "SELECT * FROM rspermata.vtinputtindakanpasien WHERE notrans = ? order by tgltrans,nourut" 
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
Dim tinputtindakanpasien__MMColParam1
tinputtindakanpasien__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputtindakanpasien__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputtindakanpasien__MMColParam2
tinputtindakanpasien__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputtindakanpasien__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputtindakanpasien
Dim tinputtindakanpasien_cmd
Dim tinputtindakanpasien_numRows

Set tinputtindakanpasien_cmd = Server.CreateObject ("ADODB.Command")
tinputtindakanpasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputtindakanpasien_cmd.CommandText = "SELECT * FROM rspermata.tinputtindakan WHERE notrans = ? and nourut = ? " 
tinputtindakanpasien_cmd.Prepared = true
tinputtindakanpasien_cmd.Parameters.Append tinputtindakanpasien_cmd.CreateParameter("param1", 200, 1, 255, tinputtindakanpasien__MMColParam1) ' adVarChar
tinputtindakanpasien_cmd.Parameters.Append tinputtindakanpasien_cmd.CreateParameter("param2", 5, 1, -1, tinputtindakanpasien__MMColParam2) ' adDouble

Set tinputtindakanpasien = tinputtindakanpasien_cmd.Execute
tinputtindakanpasien_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
Repeat1__index = 0
vtinputtindakanpasien_numRows = vtinputtindakanpasien_numRows + Repeat1__numRows
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
<title>Edit Tindakan Pasien</title>
<meta name="keywords" content="Business Template, xhtml css, free web design template" />
<meta name="description" content="Business Template - free web design template provided by templatemo.com" />
<link href="../template/templat06/templatemo_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
 function ajaxFunction(cgoltindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url="../include/comboJENISTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("ckjenistindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);



var xmlHttp1;  
   try    {xmlHttp1=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp1=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url1="../include/comboTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url1=url1+"&sid="+Math.random()	
   xmlHttp1.onreadystatechange=function()      
   {if(xmlHttp1.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp1.responseText;}
   } 
    xmlHttp1.open("GET",url1,true);    xmlHttp1.send(null);	
   }  


 function ajaxFunction1(cjenistindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var jenistindakanku=cjenistindakan
	url="../include/comboTINDAKAN1.asp?ckjenistindakan="+jenistindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  

 </script>
	<script>
		window.dhx_globalImgPath="../../include/";
	</script>


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

function simpandata()
{
var cktindakan = document.forms['form1'].elements['cktindakan'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;


if (cktindakan == '') {
alert("tindakan kosong, mohon dicek")
document.forms['form1'].elements['cktindakan'].focus();
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
                <li><a href="../inputdata/inputtindakanpasien.asp?cnotrans=<%=(cnotrans)%>">Input Tindakan Pasien</a></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT  TINDAKAN PASIEN</h2>
		    <table width="100%">
              <tr>
                <td class="style4"><span class="style3">Notrans</span></td>
                <td><div align="center">:</div></td>
                <td class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
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
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputtindakanpasien.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td width="16%" class="style4"><span class="style3">Golongan Tindakan</span></td>
                <td width="2%"><div align="center">:</div></td>
                <td width="82%"><select name="ckgoltindakan" id="ckgoltindakan" onChange="ajaxFunction(this.value)">
                  <option value="" <%If (Not isNull(request.form("ckgoltindakan"))) Then If ("" = CStr(request.form("ckgoltindakan"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tgoltindakan.EOF)
%>
                  <option value="<%=(tgoltindakan.Fields.Item("kgoltindakan").Value)%>" <%If (Not isNull(request.form("ckgoltindakan"))) Then If (CStr(tgoltindakan.Fields.Item("kgoltindakan").Value) = CStr(request.form("ckgoltindakan"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tgoltindakan.Fields.Item("goltindakan").Value)%></option>
                  <%
  tgoltindakan.MoveNext()
Wend
If (tgoltindakan.CursorType > 0) Then
  tgoltindakan.MoveFirst
Else
  tgoltindakan.Requery
End If
%>
                </select></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Jenis  Tindakan</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div class="style17" id="ckjenistindakan">
                <select name="ckjenistindakan" id="ckjenistindakan" onChange="ajaxFunction1(this.value)">
                  <option value="" <%If (Not isNull(request.form("ckjenistindakan"))) Then If ("" = CStr(request.form("ckjenistindakan"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tjenistindakan.EOF)
%>
                  <option value="<%=(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value)%>" <%If (Not isNull(request.form("ckjenistindakan"))) Then If (CStr(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value) = CStr(request.form("ckjenistindakan"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tjenistindakan.Fields.Item("JENISTINDAKAN").Value)%></option>
                  <%
  tjenistindakan.MoveNext()
Wend
If (tjenistindakan.CursorType > 0) Then
  tjenistindakan.MoveFirst
Else
  tjenistindakan.Requery
End If
%>
                </select>
                </div>
                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tindakan</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div class="style17" id="cktindakan">
                <select name="cktindakan" id="cktindakan">
                  <option value="" <%If (Not isNull((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then If ("" = CStr((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT ttindakan.EOF)
%>
                  <option value="<%=(ttindakan.Fields.Item("KTINDAKAN").Value)%>" <%If (Not isNull((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then If (CStr(ttindakan.Fields.Item("KTINDAKAN").Value) = CStr((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(ttindakan.Fields.Item("TINDAKAN").Value)%></option>
                  <%
  ttindakan.MoveNext()
Wend
If (ttindakan.CursorType > 0) Then
  ttindakan.MoveFirst
Else
  ttindakan.Requery
End If
%>
                </select>
                </div>
                </td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Keterangan Pemeriksaan</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cpemeriksaan" type="text" id="cpemeriksaan" value="<%=(tinputtindakanpasien.Fields.Item("pemeriksaan").Value)%>" size="80" maxlength="80" /></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Hasil Pemeriksaan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="chasil" id="chasil" cols="60" rows="3"><%=(tinputtindakanpasien.Fields.Item("hasil").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tarif</span></td>
                <td><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputtindakanpasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Simpan" onclick="simpandata()"/>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputtindakanpasien.Fields.Item("nourut").Value)%>" />
                </strong></strong></td>
                </tr>
            </table>
		    <div  id="gridtindakan">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" >Tindakan</td>
		          <td width="60px" align="right">Tarif</td>
		          <td width="*" align="center">Pemeriksaan </td>
		          <td width="*" align="center">Hasil</td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputtindakanpasien.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(vtinputtindakanpasien.Fields.Item("tgltrans").Value)%></td>
		          <td><a href="../editdata/edittindakanpasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputtindakanpasien.Fields.Item("notrans").Value & "&cnourut=" & vtinputtindakanpasien.Fields.Item("nourut").Value %>"><%=(vtinputtindakanpasien.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(vtinputtindakanpasien.Fields.Item("tindakan").Value)%></td>
		          <td><%=(vtinputtindakanpasien.Fields.Item("tarif").Value)%></td>
		          <td><%=(vtinputtindakanpasien.Fields.Item("pemeriksaan").Value)%></td>
		          <td><%=(vtinputtindakanpasien.Fields.Item("hasil").Value)%></td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputtindakanpasien.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="MM_delete" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputtindakanpasien.Fields.Item("notrans").Value %>" />
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
ttindakan.Close()
Set ttindakan = Nothing
%>
<%
tgoltindakan.Close()
Set tgoltindakan = Nothing
%>
<%
tjenistindakan.Close()
Set tjenistindakan = Nothing
%>
<%
vtinputtindakanpasien.Close()
Set vtinputtindakanpasien = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tinputtindakanpasien.Close()
Set tinputtindakanpasien = Nothing
%>
