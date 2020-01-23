<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
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
Dim tpasien__MMColParam1
tpasien__MMColParam1 = "%"
If (Request.QueryString("cnocm") <> "") Then 
  tpasien__MMColParam1 = Request.QueryString("cnocm")
End If
%>
<%
Dim tpasien__MMColParam3
tpasien__MMColParam3 = "%"
If (Request.QueryString("cnama") <> "") Then 
  tpasien__MMColParam3 = Request.QueryString("cnama")
End If
%>
<%
Dim tpasien__MMColParam4
tpasien__MMColParam4 = "%"
If (Request.QueryString("calamat") <> "") Then 
  tpasien__MMColParam4 = Request.QueryString("calamat")
End If
%>
<%
Dim tpasien__MMColParam5
tpasien__MMColParam5 = "%"
If (Request.QueryString("cnopas")  <> "") Then 
  tpasien__MMColParam5 = Request.QueryString("cnopas") 
End If
%>
<%
Dim tpasien
Dim tpasien_numRows

Set tpasien = Server.CreateObject("ADODB.Recordset")
tpasien.ActiveConnection = MM_datarspermata_STRING
tpasien.Source = "SELECT nocm,nopas,  nama, umurthn,umurbln, alamat,orangtua FROM rspermata.tpasien  WHERE nocm like '%" + Replace(tpasien__MMColParam1, "'", "''") + "%' and nama like '%" + Replace(tpasien__MMColParam3, "'", "''") + "%' and alamat like '%" + Replace(tpasien__MMColParam4, "'", "''") + "%' and nopas like '%" + Replace(tpasien__MMColParam5, "'", "''") + "%'  ORDER BY nama ASC"
tpasien.CursorType = 0
tpasien.CursorLocation = 2
tpasien.LockType = 1
tpasien.Open()

tpasien_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tpasien_numRows = tpasien_numRows + Repeat1__numRows
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
<!--
Design by http://www.FreeWebsiteTemplateZ.com
Released for free under a Creative Commons Attribution 3.0 License
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Daftar Pasien</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="../template/templat04/style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="../template/templat04/js/cufon-yui.js"></script>
<script type="text/javascript" src="../template/templat04/js/arial.js"></script>
<script type="text/javascript" src="../template/templat04/js/cuf_run.js"></script>
<!-- CuFon ends -->


<script type="text/javascript">
<!--

function caridata()
{
	document.forms['form1'].submit();
}

</script>

<style type="text/css">
<!--
.style1 {font-size: 14px}
.style2 {font-size: 16px}
.style8 {font-size: 17px}
.style9 {color: #666666}
-->
</style>

</head>
<body onload="startclock();tglsekarang()">




<div class="main">

  <div class="header">
    <div class="header_resize">
      <div class="logo">
        <h1>Sistem Informasi rspermata</br>
              <span class="style2">design by : Agoes</span></h1>
      </div>
      <div class="clr"></div>
      <div class="menu_nav">
        <ul>
          <li class="active"><blink><a title="menu utama" href="../menuutama.asp">Home</a></blink></li>
          <li class="active"><blink><a title="menu utama" href="caripasien.asp">cari Pasien</a></blink></li>
          <li class="active"><blink><a title="menu utama" href="../master/masterpasien.asp">Input Pasien</a></blink></li>
          <li class="active"><blink><a title="Daftar Tunggu" href="../inputdata/daftartunggu.asp">Daftar Tunggu</a></blink></li>
          
        </ul>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="content">
    <div class="content_resize">
    </br>
      <form name="form1" method="get">
<table width="100%">
    <tr bgcolor="#9999FF"> 
      <td width="5%" bgcolor="#224681"> <div align="center"><font color="#FFFFFF"><strong><font size="2" face="Lucida Sans">No 
        CM</font></strong></font></div></td>
      <td width="12%" bgcolor="#224681"> <div align="center"><font color="#FFFFFF"><strong><font size="2" face="Lucida Sans">Nama</font></strong></font></div></td>
      <td width="10%" align="center" bgcolor="#224681"><font color="#FFFFFF"><strong><font size="2" face="Lucida Sans">Umur</font></strong></font></td>
      <td width="23%" bgcolor="#224681"> <div align="center"><font color="#FFFFFF"><strong><font size="2" face="Lucida Sans">Alamat</font></strong></font></div></td>
      <td width="10%" align="center" bgcolor="#224681"><font color="#FFFFFF"><strong><font size="2" face="Lucida Sans">Orang Tua / Suami</font></strong></font></td>
      </tr>
    <% 
While ((Repeat1__numRows <> 0) AND (NOT tpasien.EOF)) 
%>
    <tr> 
      <td bgcolor="#57A7D2"><div align="center" class="style15"><font size="2" face="Lucida Sans"><A HREF="../editdata/editpasien.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "cnocm=" & tpasien.Fields.Item("nocm").Value%>" class="style16"><%=(tpasien.Fields.Item("nocm").Value)%></A></font></div></td>
      <td bgcolor="#57A7D2" class="style19"><font size="2" face="Lucida Sans"><%=(tpasien.Fields.Item("nama").Value)%></font></td>
      <td align="center" bgcolor="#57A7D2"><span class="style15"><font size="2" face="Lucida Sans"><%=(tpasien.Fields.Item("umurthn").Value)%> Thn <%=(tpasien.Fields.Item("umurbln").Value)%> Bln </font></span></td>
      <td bgcolor="#57A7D2"><span class="style15"><font size="2" face="Lucida Sans"><%=(tpasien.Fields.Item("alamat").Value)%></font></span></td>
      <td bgcolor="#57A7D2"><span class="style15"><font size="2" face="Lucida Sans"><%=(tpasien.Fields.Item("orangtua").Value)%></font></span></td>
      </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tpasien.MoveNext()
Wend
%>
  </table>
      </form>
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
tpasien.Close()
Set tpasien = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>
