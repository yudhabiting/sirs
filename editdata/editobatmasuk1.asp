<%@LANGUAGE="VBSCRIPT"%>
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
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "UPDATE rspermata.titemmasukobat SET nobatch = ?, jmlbox = ?, jmlbiji = ?, harga = ?, subtotal = ? WHERE notrans = ? and  nourut = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 201, 1, 20, Request.Form("cnobatch")) ' adLongVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cjmlbox"), Request.Form("cjmlbox"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 5, 1, -1, MM_IIF(Request.Form("cjmlbiji"), Request.Form("cjmlbiji"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 5, 1, -1, MM_IIF(Request.Form("charga"), Request.Form("charga"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("csubtotal"), Request.Form("csubtotal"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 200, 1, 10, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING

  set tnourut2=tnourut1.execute ("update tobat set smasuk = (smasuk+'"&Request.Form("cjmlbiji1")&"'-'"&Request.Form("cjmlbiji1")&"'), sakhir=((sawal+smasuk)-skeluar) where kobat='"&Request.Form("ckobat")&"'") 

  set tnourut2=tnourut1.execute ("update tmasukobat set total = (select coalesce(sum(subtotal),0) from titemmasukobat where notrans='"&Request.Form("cnotrans")&"'),grandtotal=(((total*pajak)/100)+total) where notrans='"&Request.Form("cnotrans")&"'") 

    MM_editRedirectUrl = "../inputdata/inputobatmasuk1.asp"
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
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_delete")) = "form1" And CStr(Request("MM_recordId")) <> "") Then

  If (Not MM_abortEdit) Then
    ' execute the delete
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_datarspermata_STRING
    MM_editCmd.CommandText = "DELETE FROM rspermata.titemmasukobat WHERE notrans = ? and nourut = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 200, 1, 10, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("cnourut"), Request.Form("cnourut"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING

  set tnourut2=tnourut1.execute ("update tobat set smasuk = (smasuk-'"&Request.Form("cjmlbiji")&"'), sakhir=((sawal+smasuk)-skeluar) where kobat='"&Request.Form("ckobat")&"'") 

  set tnourut2=tnourut1.execute ("update tmasukobat set total = (select coalesce(sum(subtotal),0) from titemmasukobat where notrans='"&Request.Form("cnotrans")&"'),grandtotal=(((total*pajak)/100)+total) where notrans='"&Request.Form("cnotrans")&"'") 


    MM_editRedirectUrl = "../inputdata/inputobatmasuk1.asp"
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
Dim tsuplier
Dim tsuplier_cmd
Dim tsuplier_numRows

Set tsuplier_cmd = Server.CreateObject ("ADODB.Command")
tsuplier_cmd.ActiveConnection = MM_datarspermata_STRING
tsuplier_cmd.CommandText = "SELECT ksuplier, suplier FROM rspermata.tsuplier ORDER BY suplier ASC" 
tsuplier_cmd.Prepared = true

Set tsuplier = tsuplier_cmd.Execute
tsuplier_numRows = 0
%>
<%
Dim tmasukobat__MMColParam
tmasukobat__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tmasukobat__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tmasukobat
Dim tmasukobat_cmd
Dim tmasukobat_numRows

Set tmasukobat_cmd = Server.CreateObject ("ADODB.Command")
tmasukobat_cmd.ActiveConnection = MM_datarspermata_STRING
tmasukobat_cmd.CommandText = "SELECT * FROM rspermata.tmasukobat WHERE notrans = ?" 
tmasukobat_cmd.Prepared = true
tmasukobat_cmd.Parameters.Append tmasukobat_cmd.CreateParameter("param1", 200, 1, 10, tmasukobat__MMColParam) ' adVarChar

Set tmasukobat = tmasukobat_cmd.Execute
tmasukobat_numRows = 0
%>
<%
Dim tobat
Dim tobat_cmd
Dim tobat_numRows

Set tobat_cmd = Server.CreateObject ("ADODB.Command")
tobat_cmd.ActiveConnection = MM_datarspermata_STRING
tobat_cmd.CommandText = "SELECT * FROM rspermata.tobat ORDER BY obat ASC" 
tobat_cmd.Prepared = true

Set tobat = tobat_cmd.Execute
tobat_numRows = 0
%>
<%
Dim titemmasukobat__MMColParam1
titemmasukobat__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  titemmasukobat__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim titemmasukobat__MMColParam2
titemmasukobat__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  titemmasukobat__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim titemmasukobat
Dim titemmasukobat_cmd
Dim titemmasukobat_numRows

Set titemmasukobat_cmd = Server.CreateObject ("ADODB.Command")
titemmasukobat_cmd.ActiveConnection = MM_datarspermata_STRING
titemmasukobat_cmd.CommandText = "SELECT * FROM rspermata.titemmasukobat WHERE notrans = ? and nourut =? " 
titemmasukobat_cmd.Prepared = true
titemmasukobat_cmd.Parameters.Append titemmasukobat_cmd.CreateParameter("param1", 200, 1, 255, titemmasukobat__MMColParam1) ' adVarChar
titemmasukobat_cmd.Parameters.Append titemmasukobat_cmd.CreateParameter("param2", 5, 1, -1, titemmasukobat__MMColParam2) ' adDouble

Set titemmasukobat = titemmasukobat_cmd.Execute
titemmasukobat_numRows = 0
%>
<%
Dim vtinputobatmasuk__MMColParam
vtinputobatmasuk__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  vtinputobatmasuk__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim vtinputobatmasuk
Dim vtinputobatmasuk_cmd
Dim vtinputobatmasuk_numRows

Set vtinputobatmasuk_cmd = Server.CreateObject ("ADODB.Command")
vtinputobatmasuk_cmd.ActiveConnection = MM_datarspermata_STRING
vtinputobatmasuk_cmd.CommandText = "SELECT * FROM rspermata.vtinputobatmasuk WHERE notrans = ?" 
vtinputobatmasuk_cmd.Prepared = true
vtinputobatmasuk_cmd.Parameters.Append vtinputobatmasuk_cmd.CreateParameter("param1", 200, 1, 10, vtinputobatmasuk__MMColParam) ' adVarChar

Set vtinputobatmasuk = vtinputobatmasuk_cmd.Execute
vtinputobatmasuk_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
vtinputobatmasuk_numRows = vtinputobatmasuk_numRows + Repeat1__numRows
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
cnotrans=request.QueryString("cnotrans")
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
<title>Edit Pembelian Obat</title>
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
var ckobat = document.forms['form1'].elements['ckobat'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;


if (ckobat == '') {
alert("obat kosong, mohon dicek")
document.forms['form1'].elements['ckobat'].focus();
return false;
}
else if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else {
	document.forms['form1'].elements['MM_delete'].value='form1';
	document.forms['form1'].elements['MM_update'].value='';
	var r=confirm("Anda yakin mau menghapus data ini!");
	if (r==true)
	  {
		document.forms['form1'].submit();
	  }
	}
}


function inputobat()
{
var ckobat = document.forms['form1'].elements['ckobat'].value;
var cjmlbox = document.forms['form1'].elements['cjmlbox'].value;
var cjmlbiji = document.forms['form1'].elements['cjmlbiji'].value;
var charga = document.forms['form1'].elements['charga'].value;
var csubtotal = document.forms['form1'].elements['csubtotal'].value;


if (ckobat == '') {
alert("obat kosong, mohon dicek")
document.forms['form1'].elements['ckobat'].focus();
return false;
}
else if (cjmlbox == '') {
alert("jml box kosong, mohon dicek")
document.forms['form1'].elements['cjmlbox'].focus();
return false;
}
else if (cjmlbiji == '') {
alert("jml biji kosong, mohon dicek")
document.forms['form1'].elements['cjmlbiji'].focus();
return false;
}
else if (charga == '') {
alert("harga   kosong, mohon dicek")
document.forms['form1'].elements['charga'].focus();
return false;
}
else if (csubtotal == '') {
alert("subtotal  kosong, mohon dicek")
document.forms['form1'].elements['csubtotal'].focus();
return false;
}

else {
	document.forms['form1'].elements['MM_delete'].value='';
	document.forms['form1'].elements['MM_update'].value='form1';
	document.forms['form1'].elements['csubtotal'].value=cjmlbiji*charga;
	document.forms['form1'].submit();
}
}


function subtotal(cjumlahobat)
{
	var cjumlah=cjumlahobat;
	var charga=document.forms['form1'].elements['charga'].value;
	if (charga==''){
		document.forms['form1'].elements['csubtotal'].value=0;
	}
	else {
	document.forms['form1'].elements['csubtotal'].value=cjumlah*charga;
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
.style6 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
}
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
    
   

<div id="templatemo_container">
	<!--  Free CSS Templates @ www.TemplateMo.com  -->
<div id="templatemo_banner"></div>
    
    <div id="templatemo_menu_search">
        <div id="templatemo_menu">
            <ul>
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../exit.asp" class="current">Keluar </a></li>
                <li><a href="../inputdata/inputobatmasuk.asp">Input Pembelian Obat</a></li>
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
		    <h2 class="title">EDIT  PEMBELIAN OBAT</h2>
		    <table width="100%">
              <tr>
                <td width="15%" class="style4"><span class="style3">Notrans</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td class="style5"><%=(tmasukobat.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td width="15%" class="style4"><span class="style3">Tanggal Terima</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td width="86%"><font size="2" face="Arial, Helvetica, sans-serif">
                <%= DoDateTime((tmasukobat.Fields.Item("tglterima").Value), 2, 7177) %>
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal Faktur</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                  <%= DoDateTime((tmasukobat.Fields.Item("tglfaktur").Value), 2, 7177) %>
                <span class="style4"><span class="style3">No Faktur :
                 <%=(tmasukobat.Fields.Item("nofaktur").Value)%>
                </span></span></font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Tanggal Jatuh Tempo</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                  <%= DoDateTime((tmasukobat.Fields.Item("tgljatuhtempo").Value), 2, 7177) %>
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Suplier </span></td>
                <td><div align="center">:</div></td>
                <td>
                 <%
While (NOT tsuplier.EOF)
if (tsuplier.Fields.Item("ksuplier").Value)=(tmasukobat.Fields.Item("ksuplier").Value) Then 
	response.Write(tsuplier.Fields.Item("suplier").Value)
end if 
  tsuplier.MoveNext()
Wend
If (tsuplier.CursorType > 0) Then
  tsuplier.MoveFirst
Else
  tsuplier.Requery
End If
%>
</td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Total</span></td>
                <td><div align="center">:</div></td>
                <td><span class="style6">Rp.<%= FormatNumber((tmasukobat.Fields.Item("total").Value), 0, 0, -2, -1) %></span></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">PPN</span></td>
                <td><div align="center">:</div></td>
                <td><span class="style4"><span class="style3"><%=(tmasukobat.Fields.Item("pajak").Value)%>%</span></span></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Total + PPN</span></td>
                <td><div align="center">:</div></td>
                <td><span class="style6">Rp.<%= FormatNumber((tmasukobat.Fields.Item("grandtotal").Value), 0, 0, -2, -1) %></span></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Status</span></td>
                <td><div align="center">:</div></td>
                <td class="style3"><%
				if (tmasukobat.Fields.Item("lunas").Value)="L" then
					response.Write("Lunas")
				else
					response.Write("Belum Lunas")
				end if
				%></td>
              </tr>
          </table>
		  <form ACTION="<%=MM_editAction%>"   METHOD="POST" name="form1" id="form1">
        
		    <div  id="gridvisite">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" align="left">Obat</td>
		          <td width="100px" align="center">Nobatch</td>
		          <td width="100px" align="right">Jml Box</td>
		          <td width="100px" align="right">Jml Biji</td>
		          <td width="150px" align="right">Harga</td>
		          <td width="150px" align="right">Subtotal </td>
	            </tr>
                <% 
While ((Repeat1__numRows <> 0) AND (NOT vtinputobatmasuk.EOF)) 
%>
  <tr bgcolor="#FFFFCC">
    <td height="22"><a href="../editdata/editobatmasuk1.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputobatmasuk.Fields.Item("notrans").Value & "&cnourut=" & vtinputobatmasuk.Fields.Item("nourut").Value%>"><%=(vtinputobatmasuk.Fields.Item("nourut").Value)%></a><a href="editobatmasuk1.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & vtinputobatmasuk.Fields.Item("notrans").Value %>"></a></td>
    <td><%=(vtinputobatmasuk.Fields.Item("obat").Value)%></td>
    <td><%=(vtinputobatmasuk.Fields.Item("nobatch").Value)%></td>
    <td><%=(vtinputobatmasuk.Fields.Item("jmlbox").Value)%></td>
    <td><%=(vtinputobatmasuk.Fields.Item("jmlbiji").Value)%></td>
    <td><%=(vtinputobatmasuk.Fields.Item("harga").Value)%></td>
    <td><%=(vtinputobatmasuk.Fields.Item("subtotal").Value)%></td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  vtinputobatmasuk.MoveNext()
Wend
%>
              </table>
      </div>

		    <table width="100%">

              
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3"><span class="title"><span class="style4"><span class="style5"><span class="style3">EDIT  ITEM PEMBELIAN OBAT</span></span></span></span></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><span class="style3">No Urut</span></td>
                <td><div align="center">:</div></td>
                <td class="style3"><%=(titemmasukobat.Fields.Item("nourut").Value)%></td>
              </tr>
              <tr>
                <td width="15%"><span class="style3">Obat</span></td>
                <td width="3%"><div align="center">:</div></td>
                <td><select name="ckobat1" id="ckobat1" style="width:328px" disabled="disabled">
                  <option value="" <%If (Not isNull((titemmasukobat.Fields.Item("kobat").Value))) Then If ("" = CStr((titemmasukobat.Fields.Item("kobat").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tobat.EOF)
%>
                  <option value="<%=(tobat.Fields.Item("kobat").Value)%>" <%If (Not isNull((titemmasukobat.Fields.Item("kobat").Value))) Then If (CStr(tobat.Fields.Item("kobat").Value) = CStr((titemmasukobat.Fields.Item("kobat").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tobat.Fields.Item("obat").Value)%></option>
                  <%
  tobat.MoveNext()
Wend
If (tobat.CursorType > 0) Then
  tobat.MoveFirst
Else
  tobat.Requery
End If
%>
                </select>        

</td>
              </tr>
              <tr>
                <td><span class="style3">Nobatch</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cnobatch" type="text" id="cnobatch" value="<%=(titemmasukobat.Fields.Item("nobatch").Value)%>" size="50" /></td>
              </tr>
              <tr>
                <td><span class="style3">Jumlah Box</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cjmlbox" type="text" id="cjmlbox" value="<%=(titemmasukobat.Fields.Item("jmlbox").Value)%>" size="15" /></td>
              </tr>
              <tr>
                <td><span class="style3">Jumlah Biji</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cjmlbiji" type="text" id="cjmlbiji" value="<%=(titemmasukobat.Fields.Item("jmlbiji").Value)%>" size="15" onblur="subtotal(this.value)"/></td>
              </tr>
              <tr>
                <td><span class="style3">Harga</span></td>
                <td><div align="center">:</div></td>
                <td><input name="charga" type="text" id="charga" value="<%=(titemmasukobat.Fields.Item("harga").Value)%>" size="15" /></td>
              </tr>
              <tr>
                <td><span class="style3">Subtotal</span></td>
                <td><div align="center">:</div></td>
                <td><input name="csubtotal" type="text" id="csubtotal" value="<%=(titemmasukobat.Fields.Item("subtotal").Value)%>" size="15" readonly="readonly"/></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="button" name="input" id="input" value="Edit Data" onclick="inputobat()"/>
                  <strong><strong>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="hapusdata()"/>
                  </strong></strong>
<input name="cnotrans" type="hidden" id="cnotrans" value="<%=(titemmasukobat.Fields.Item("notrans").Value)%>" />
<input name="ckobat" type="hidden" id="ckobat" value="<%=(titemmasukobat.Fields.Item("kobat").Value)%>" />
<input name="cnourut" type="hidden" id="cnourut" value="<%=(titemmasukobat.Fields.Item("nourut").Value)%>" />
<input type="hidden" name="MM_recordId" value="<%= tmasukobat.Fields.Item("notrans").Value %>" /><input type="hidden" name="MM_update" value="form1" />
<input type="hidden" name="MM_delete" value="form1" />
<input name="cjmlbiji1" type="hidden" id="cjmlbiji1" value="<%=(titemmasukobat.Fields.Item("jmlbiji").Value)%>" /></td>
              </tr>
            </table>
		  </form>
        
      
<div align="right"></div>
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
tsuplier.Close()
Set tsuplier = Nothing
%>
<%
tmasukobat.Close()
Set tmasukobat = Nothing
%>
<%
tobat.Close()
Set tobat = Nothing
%>
<%
titemmasukobat.Close()
Set titemmasukobat = Nothing
%>
<%
vtinputobatmasuk.Close()
Set vtinputobatmasuk = Nothing
%>
