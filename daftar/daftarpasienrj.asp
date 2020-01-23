<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<!--#include file="../Connections/databumil.asp" -->
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%
Dim tpuskesmas__MMColParam
tpuskesmas__MMColParam = "%"
If (Session("MM_Username") <> "") Then 
  tpuskesmas__MMColParam = Session("MM_Username")
End If
%>
<%
Dim tpuskesmas
Dim tpuskesmas_numRows

Set tpuskesmas = Server.CreateObject("ADODB.Recordset")
tpuskesmas.ActiveConnection = MM_databumil_STRING
tpuskesmas.Source = "SELECT puskesmas, kpuskesmas  FROM bumil.tpuskesmas  WHERE trim(puskesmas) = '" + Replace(tpuskesmas__MMColParam, "'", "''") + "'  ORDER BY kpuskesmas ASC"

tpuskesmas.CursorType = 0
tpuskesmas.CursorLocation = 2
tpuskesmas.LockType = 1
tpuskesmas.Open()
kodepuskesmas=mid((tpuskesmas.Fields.Item("kpuskesmas").Value),5,5)
kodepuskesmas1=left((tpuskesmas.Fields.Item("kpuskesmas").Value),9)
kodepuskesmas2=(tpuskesmas.Fields.Item("kpuskesmas").Value)
IF  right(tpuskesmas.Fields.Item("kpuskesmas").Value,1)="A" then
	tpuskesmas.close
	tpuskesmas.Source = "SELECT puskesmas, kpuskesmas  FROM bumil.tpuskesmas  WHERE left(kpuskesmas,9) = '" + kodepuskesmas1 + "'  ORDER BY kpuskesmas ASC"
else
	tpuskesmas.close
	tpuskesmas.Source = "SELECT puskesmas, kpuskesmas  FROM bumil.tpuskesmas  WHERE kpuskesmas = '" + kodepuskesmas2 + "'  ORDER BY kpuskesmas ASC"
end if
tpuskesmas.open()

tpuskesmas_numRows = 0
%>
<%
Dim tpasienrj__MMColParam2
tpasienrj__MMColParam2 = "%"
If (Request.QueryString("cnama")   <> "") Then 
  tpasienrj__MMColParam2 = Request.QueryString("cnama")  
End If
%>
<%
Dim tpasienrj__MMColParam3
tpasienrj__MMColParam3 = "%"
If (Request.QueryString("calamat")   <> "") Then 
  tpasienrj__MMColParam3 = Request.QueryString("calamat")  
End If
%>

<%
Dim tpasienrj
Dim tpasienrj_numRows

Set tpasienrj = Server.CreateObject("ADODB.Recordset")
tpasienrj.ActiveConnection = MM_databumil_STRING
IF  right(tpuskesmas.Fields.Item("kpuskesmas").Value,1)="A" then
	tpasienrj.Source = "SELECT *  FROM bumil.tpasienrj  WHERE left(kpuskesmas,9) = '"&kodepuskesmas1&"' and  nama<>'50' and nama like '%" + Replace(tpasienrj__MMColParam2, "'", "''") + "%' and alamat like '%" + Replace(tpasienrj__MMColParam3, "'", "''") + "%'  ORDER BY tgltrans,nama,notrans  ASC"
else
	tpasienrj.Source = "SELECT *  FROM bumil.tpasienrj  WHERE kpuskesmas = '"&kodepuskesmas2&"'  and  nama<>'50' and nama like '%" + Replace(tpasienrj__MMColParam2, "'", "''") + "%' and alamat like '%" + Replace(tpasienrj__MMColParam3, "'", "''") + "%'  ORDER BY tgltrans,nama,notrans  ASC"
end if
tpasienrj.CursorType = 0
tpasienrj.CursorLocation = 2
tpasienrj.LockType = 1
tpasienrj.Open()

tpasienrj_numRows = 0
%>
<%
Dim tpenyakit
Dim tpenyakit_numRows

Set tpenyakit = Server.CreateObject("ADODB.Recordset")
tpenyakit.ActiveConnection = MM_databumil_STRING
tpenyakit.Source = "SELECT * FROM bumil.tpenyakit"
tpenyakit.CursorType = 0
tpenyakit.CursorLocation = 2
tpenyakit.LockType = 1
tpenyakit.Open()

tpenyakit_numRows = 0
%>
<%
Dim tkelompok
Dim tkelompok_numRows

Set tkelompok = Server.CreateObject("ADODB.Recordset")
tkelompok.ActiveConnection = MM_databumil_STRING
tkelompok.Source = "SELECT * FROM bumil.tkelompok ORDER BY kelompok ASC"
tkelompok.CursorType = 0
tkelompok.CursorLocation = 2
tkelompok.LockType = 1
tkelompok.Open()

tkelompok_numRows = 0
%>
<%
			if request.QueryString("kondisi")="1" then
'				ctgltrans1=request.QueryString("ctgltrans")
'				ctgltrans2=request.QueryString("ctgltrans2")
				cnama=request.QueryString("cnama")
				calamat=request.QueryString("calamat")
		
			else
'				ctgltrans1=date
'				ctgltrans2=date
				cnama=request.QueryString("cnama")
				calamat=request.QueryString("calamat")
			end if
			%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tpasienrj_numRows = tpasienrj_numRows + Repeat1__numRows
%>
<%

'  *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

Dim tpasienrj_total
Dim tpasienrj_first
Dim tpasienrj_last

' set the record count
tpasienrj_total = tpasienrj.RecordCount

' set the number of rows displayed on this page
If (tpasienrj_numRows < 0) Then
  tpasienrj_numRows = tpasienrj_total
Elseif (tpasienrj_numRows = 0) Then
  tpasienrj_numRows = 1
End If

' set the first and last displayed record
tpasienrj_first = 1
tpasienrj_last  = tpasienrj_first + tpasienrj_numRows - 1

' if we have the correct record count, check the other stats
If (tpasienrj_total <> -1) Then
  If (tpasienrj_first > tpasienrj_total) Then
    tpasienrj_first = tpasienrj_total
  End If
  If (tpasienrj_last > tpasienrj_total) Then
    tpasienrj_last = tpasienrj_total
  End If
  If (tpasienrj_numRows > tpasienrj_total) Then
    tpasienrj_numRows = tpasienrj_total
  End If
End If
%>

<%
' *** Recordset Stats: if we don't know the record count, manually count them

If (tpasienrj_total = -1) Then

  ' count the total records by iterating through the recordset
  tpasienrj_total=0
  While (Not tpasienrj.EOF)
    tpasienrj_total = tpasienrj_total + 1
    tpasienrj.MoveNext
  Wend

  ' reset the cursor to the beginning
  If (tpasienrj.CursorType > 0) Then
    tpasienrj.MoveFirst
  Else
    tpasienrj.Requery
  End If

  ' set the number of rows displayed on this page
  If (tpasienrj_numRows < 0 Or tpasienrj_numRows > tpasienrj_total) Then
    tpasienrj_numRows = tpasienrj_total
  End If

  ' set the first and last displayed record
  tpasienrj_first = 1
  tpasienrj_last = tpasienrj_first + tpasienrj_numRows - 1
  
  If (tpasienrj_first > tpasienrj_total) Then
    tpasienrj_first = tpasienrj_total
  End If
  If (tpasienrj_last > tpasienrj_total) Then
    tpasienrj_last = tpasienrj_total
  End If

End If
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Design by http://www.FreeWebsiteTemplateZ.com
Released for free under a Creative Commons Attribution 3.0 License
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Daftar Kunjungan Pasien</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="../template/templat04/style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="../template/templat04/js/cufon-yui.js"></script>
<script type="text/javascript" src="../template/templat04/js/arial.js"></script>
<script type="text/javascript" src="../template/templat04/js/cuf_run.js"></script>
<!-- CuFon ends -->


<script type="text/javascript">
<!--

 function ajaxFunction()  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var namaku=form1.cnama.value
   var alamatku=form1.calamat.value
   var ctgltrans=form1.ctgltrans.value
   var ctgltrans2=form1.ctgltrans2.value
   url="../include/daftarpasienrj.asp?cnama="+namaku+"&ctgltrans="+ctgltrans+"&calamat="+alamatku+"&ctgltrans2="+ctgltrans2;
   url=url+"&sid="+Math.random()	

   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("daftarpasienrj").innerHTML=xmlHttp.responseText;}} 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  



function lihatdata()
{
	document.forms['form1'].submit();
}

function isValidDate(el)
{
//var dateStr=document.getElementById('cf06').value;
var dateStr=el.value;
//var datePat=/^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;
var datePat=/^(\d{2}|\d{4})(\/|-)(\d{1,2})\2(\d{1,2})$/;
var matchArray = dateStr.match(datePat); // is the format ok?
if (matchArray == null) {
alert("Format Tanggal Salah.");
el.focus();
return false;

}
month = matchArray[3]; // parse date into variables
day = matchArray[4];
year = matchArray[1];
if (month < 1 || month > 12) { // check month range
alert("bulan 1 sampai 12.");
el.focus();
return false;
}
if (day < 1 || day > 31) {
alert("Hari 1 sampai 31.");
el.focus();
return false;
}
if ((month==4 || month==6 || month==9 || month==11) && day==31) {
alert("Bulan "+month+" tidak nyampai 31 hari!");
el.focus();
return false;
}
if (month == 2) { // check for february 29th
var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
if (day>29 || (day==29 && !isleap)) {
alert("February " + year + " tidak mempunyai " + day + " hari!");
el.focus();
return false;
}
}
return true; // date is valid
}




//-->
</script>
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
	a:link { color: #FFFFFF; }
	a:visited {	color: yellow; }
	a:hover { color: #ff0000; }
	a:active { color: #ff0000; }
	h1,h2,h3,h4,h5,h6 {	font-family: Verdana, Arial, Helvetica, sans-serif; }
	h2 { font-size: 120%; color: #666666; }
	body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #FFF;
}

.style1 {font-size: 14px}
.style2 {font-size: 16px}
.style8 {font-size: 17px}
.style9 {color: #666666}
-->
</style>

</head>
<body onLoad="startclock();tglsekarang()">




<div class="main">

  <div class="header">
    <div class="header_resize">
      <div class="logo">
        <h1>Sistem Informasi Ibu Hamil</br>
              <span class="style2">Dinas Kesehatan Kabupaten Cilacap</span></h1>
      </div>
      <div class="clr"></div>
      <div class="menu_nav">
        <ul>
          <li class="active"><blink><a title="menu utama" href="../menuutama.asp">Home</a></blink></li>
        </ul>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="content">
    <div class="content_resize">
	<form action="daftarpasienrj.asp" method="get" name="form1">
  <table width="100%"  bgcolor="#59A9D5">
        <tr>
          <td width="12%">&nbsp;</td>
          <td width="88%">&nbsp;</td>
        </tr>
        <tr>
          <td align="right">Nama</td>
          <td>:            
            <input name="cnama" type="text" id="cnama" value="<%=cnama%>" size="50" maxlength="30" onBlur="ajaxFunction()"/></td>
        </tr>
        <tr>
          <td align="right">Alamat</td>
          <td>: 
            
            <input name="calamat" type="text" id="calamat" value="<%=calamat%>" size="60" maxlength="80" />
            <font color="#FFFFFF">
            <input name="OK" type="button" id="OK" value="OK" onClick="lihatdata()">
            <input type="hidden" name="kondisi" value="1" />
          </font></td>
        </tr>
      </table>
    </form>

<div id="daftarpasienrj">
  <table width="100%" border="1">

    <tr bgcolor="#9999FF">
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style3 style5"><font color="#FFFFFF">No 
        Transaksi</font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">No 
        CM</font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">No 
        Asuransi</font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">Tgl 
        Transaksi </font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">Nama</font></div></td>
      <td colspan="3" bgcolor="#003366"><div align="center" class="style3 style26"><font color="#FFFFFF">Umur</font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style3 style26"><font color="#FFFFFF">Jenis Kel </font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">Alamat</font></div></td>
      <td rowspan="2" bgcolor="#003366"><div align="center" class="style6"><font color="#FFFFFF">Status Melahirkan</font></div></td>
      </tr>
    <tr bgcolor="#9999FF">
      <td bgcolor="#003366"><div align="center" class="style3 style26"><font color="#FFFFFF">Tahun</font></div></td>
      <td bgcolor="#003366"><div align="center" class="style3 style26"><font color="#FFFFFF">Bulan</font></div></td>
      <td bgcolor="#003366"><div align="center" class="style3 style26"><font color="#FFFFFF">Hari</font></div></td>
    </tr>
    
    <% 
While ((Repeat1__numRows <> 0) AND (NOT tpasienrj.EOF)) 
%>
<%
if Repeat1__numRows<>0 then
	if tpasienrj.Fields.Item("nama").Value="04" then
''		fileku="editbumil.asp?"
		fileku="../edit/editrawatjalan.asp?"
	else
		fileku="../edit/editrawatjalan.asp?"
	end if
else
	fileku=""
end if
%>

    <tr> 
      <td width="15%" height="19" bgcolor="#61A5CB"> 
        <div align="center" class="style26 style32"><A HREF="<%=fileku%><%= MM_keepNone & MM_joinChar(MM_keepNone) & "cnotrans=" & tpasienrj.Fields.Item("notrans").Value %>" class="style4"><%=(tpasienrj.Fields.Item("notrans").Value)%></A> </div></td>
      <td width="5%" bgcolor="#61A5CB"><div align="center" class="style4 style26 style32"><%=(tpasienrj.Fields.Item("nocm").Value)%></div></td>
      <td width="10%" bgcolor="#61A5CB"><div align="center" class="style32"><span class="style4 style26"><%=(tpasienrj.Fields.Item("noasuransi").Value)%></span></div></td>
      <td width="10%" bgcolor="#61A5CB"><div align="center" class="style4 style26 style32"><%= DoDateTime((tpasienrj.Fields.Item("tgltrans").Value), 2, 2070) %></div></td>
      <td bgcolor="#61A5CB"><div align="left" class="style32"><span class="style4 style26"><%=(tpasienrj.Fields.Item("nama").Value)%></span></div></td>
      <td bgcolor="#61A5CB"><div align="center" class="style4 style32"><span class="style26"><%=(tpasienrj.Fields.Item("umurthn").Value)%></span></div></td>
      <td bgcolor="#61A5CB"><div align="center" class="style32"><span class="style4 style26"><span class="style4"><%=(tpasienrj.Fields.Item("umurbln").Value)%></span></span></div></td>
      <td bgcolor="#61A5CB"><div align="center" class="style32"><span class="style4 style26"><span class="style4"><%=(tpasienrj.Fields.Item("umurhr").Value)%></span></span></div></td>
      <td bgcolor="#61A5CB"><div align="center" class="style32"><span class="style4 style26"><%=(tpasienrj.Fields.Item("jeniskel").Value)%></span></div></td>
      <td bgcolor="#61A5CB"><div align="left" class="style32"><span class="style4 style26"><%=(tpasienrj.Fields.Item("alamat").Value)%></span></div></td>
      <td align="center" bgcolor="#61A5CB"><span class="style4 style26">
	  <%
	  if (tpasienrj.Fields.Item("selesai").Value)="2" then
	  	response.Write("Sudah Melahirkan")
	   else
	  	response.Write("Belum Melahirkan")	   
	  end if
	  %></span></td>
      </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tpasienrj.MoveNext()
Wend
%>
  </table>
      <p>&nbsp;</p>
      <div class="clr"></div>
    </div>
  </div>
<div id='navbar-footer'>
  <div class="footer">
    <div class="footer_resize">
      <p><span class="lf">&copy; Copyright<span class="style9"> : </span></span><span class="style9">By : Kalboya</span></p>
    </div>
  </div>
  </div>
</div>
</body>
</html>
<%
tpasienrj.Close()
Set tpasienrj = Nothing
%>
<%
tpenyakit.Close()
Set tpenyakit = Nothing
%>
<%
tkelompok.Close()
Set tkelompok = Nothing
%>
<%
tpuskesmas.Close()
Set tpuskesmas = Nothing
%>