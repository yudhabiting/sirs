<%@LANGUAGE="VBSCRIPT"%>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="admin" then
elseif lcase(trim(Session("MM_statususer")))="bidan" then
elseif lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("../tolak.asp") 
else 
	Response.Redirect("../tolak.asp") 
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->
<%
cnotrans=request.QueryString("cnotrans")
%>

<%
Dim tinputanalisasituasi__MMColParam
tinputanalisasituasi__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputanalisasituasi__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputanalisasituasi
Dim tinputanalisasituasi_cmd
Dim tinputanalisasituasi_numRows

Set tinputanalisasituasi_cmd = Server.CreateObject ("ADODB.Command")
tinputanalisasituasi_cmd.ActiveConnection = MM_datarspermata_STRING
tinputanalisasituasi_cmd.CommandText = "SELECT * FROM rspermata.tinputanalisasituasi WHERE notrans = ? order by tgltrans,nourut" 
tinputanalisasituasi_cmd.Prepared = true
tinputanalisasituasi_cmd.Parameters.Append tinputanalisasituasi_cmd.CreateParameter("param1", 200, 1, 15, tinputanalisasituasi__MMColParam) ' adVarChar

Set tinputanalisasituasi = tinputanalisasituasi_cmd.Execute
tinputanalisasituasi_numRows = 0
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
Dim tinputanalisasituasiedit__MMColParam1
tinputanalisasituasiedit__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputanalisasituasiedit__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputanalisasituasiedit__MMColParam2
tinputanalisasituasiedit__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputanalisasituasiedit__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputanalisasituasiedit
Dim tinputanalisasituasiedit_cmd
Dim tinputanalisasituasiedit_numRows

Set tinputanalisasituasiedit_cmd = Server.CreateObject ("ADODB.Command")
tinputanalisasituasiedit_cmd.ActiveConnection = MM_datarspermata_STRING
tinputanalisasituasiedit_cmd.CommandText = "SELECT * FROM rspermata.tinputanalisasituasi WHERE notrans = ? and nourut = ?" 
tinputanalisasituasiedit_cmd.Prepared = true
tinputanalisasituasiedit_cmd.Parameters.Append tinputanalisasituasiedit_cmd.CreateParameter("param1", 200, 1, 255, tinputanalisasituasiedit__MMColParam1) ' adVarChar
tinputanalisasituasiedit_cmd.Parameters.Append tinputanalisasituasiedit_cmd.CreateParameter("param2", 5, 1, -1, tinputanalisasituasiedit__MMColParam2) ' adDouble

Set tinputanalisasituasiedit = tinputanalisasituasiedit_cmd.Execute
tinputanalisasituasiedit_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 25
Repeat1__index = 0
tinputanalisasituasi_numRows = tinputanalisasituasi_numRows + Repeat1__numRows
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
<title>Edit Analisa Situasi</title>
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


function simpandata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;


if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else {
	document.forms['form1'].elements['ckondisiku'].value='1';
	document.forms['form1'].submit();
}
}


function hapusdata()
{
var cnourut = document.forms['form1'].elements['cnourut'].value;


if (cnourut == '') {
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
a:analisasituasid {text-decoration: none;font-size: 11px; color:#FF0000}
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
                <li><a href="editrawatpasien.asp?cnotrans=<%=(cnotrans)%>">Rawat Pasien</a></li>
                <li><a href="../inputdata/inputkelaspasien.asp?cnotrans=<%=(cnotrans)%>">Ruang</a></li>
                <li><a href="../inputdata/inputtindakanpasien.asp?cnotrans=<%=(cnotrans)%>">Tindakan</a></li>
                <li><a href="../inputdata/inputobatpasien.asp?cnotrans=<%=(cnotrans)%>">Obat</a></li>
                <li><a href="../inputdata/inputvisitepasien.asp?cnotrans=<%=(cnotrans)%>">Visite</a></li>
                <li><a href="../inputdata/inputpembayaranpasien.asp?cnotrans=<%=(cnotrans)%>">Pembayaran</a></li>
                <li></li>
            </ul>    	
        </div> <!-- end of menu -->
        <div class="cleaner"></div>	
	</div>
    
    <div id="templatemo_content">
    
    	<div class="section_w650 fl">
		  <form  METHOD="POST" name="form1" id="form1">
		    <h2 class="title">EDIT ANALISA SITUASI PASIEN</h2>
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
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputanalisasituasiedit.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Asuhan Kebidanan</span></td>
                <td><div align="center">:</div></td>
                <td><textarea name="canalisasituasi" id="canalisasituasi" cols="70" rows="3"><%=(tinputanalisasituasiedit.Fields.Item("analisasituasi").Value)%></textarea></td>
              </tr>
              <tr>
                <td class="style4"><span class="style3">Shift</span></td>
                <td><div align="center">:</div></td>
                <td><select name="cshift" id="cshift">
                  <option value="1" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("1" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Pagi</option>
                  <option value="2" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("2" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Siang</option>
                  <option value="3" <%If (Not isNull((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then If ("3" = CStr((tinputanalisasituasiedit.Fields.Item("shift").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>>Malam</option>
                </select></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><strong><strong><strong>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata()"/>
                </strong><strong>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="hapusdata()"/>
                  </strong>
                <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputanalisasituasiedit.Fields.Item("nourut").Value)%>" />
                <strong>
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="0" />
                </strong></strong></strong></td>
                </tr>
            </table>
		    <div  id="gridanalisasituasi">
		      <table width="100%" class="dhtmlxGrid" style="width:100%" gridheight="auto" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" lightnavigation="true">
		        <tr bgcolor="#FF0000">
		          <td width="100px" align="center">Tanggal</td>
		          <td width="50px" align="center">No Urut</td>
		          <td width="*" align="left">Asuhan Kebidanan</td>
		          <td width="70px" align="left">Shit </td>
	            </tr>
		        <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputanalisasituasi.EOF)) 
%>
		        <tr bgcolor="#FFFFCC">
		          <td><%=(tinputanalisasituasi.Fields.Item("tgltrans").Value)%></td>
		          <td height="22"><a href="editanalisasituasipasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & tinputanalisasituasi.Fields.Item("notrans").Value & "&cnourut=" & tinputanalisasituasi.Fields.Item("nourut").Value %>"><%=(tinputanalisasituasi.Fields.Item("nourut").Value)%></a></td>
		          <td><%=(tinputanalisasituasi.Fields.Item("analisasituasi").Value)%></td>
		          <td><%
				  if (tinputanalisasituasi.Fields.Item("shift").Value)="1" then
				  	response.Write("Pagi")
				  elseif (tinputanalisasituasi.Fields.Item("shift").Value)="2" then
				  	response.Write("Siang")
				  else
				  	response.Write("Malam")
				  end if
				  %>
                  </td>
	            </tr>
		        <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tinputanalisasituasi.MoveNext()
Wend
%>
	          </table>
		    </div>
            <input type="hidden" name="MM_insert" value="form1" />
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
tinputanalisasituasi.Close()
Set tinputanalisasituasi = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
<%
tinputanalisasituasiedit.Close()
Set tinputanalisasituasiedit = Nothing
%>
