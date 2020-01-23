<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
if (trim(Session("MM_Username")))=""  then
	Response.Redirect("../tolak.asp")
end if
%>
<%
Dim trawatpasien__MMColParam1
trawatpasien__MMColParam1 = "1"
If (Request.Form("ctanggal1")   <> "") Then 
  trawatpasien__MMColParam1 = Request.Form("ctanggal1")  
End If
%>
<%
Dim trawatpasien__MMColParam2
trawatpasien__MMColParam2 = "1"
If (Request.Form("ctanggal2")    <> "") Then 
  trawatpasien__MMColParam2 = Request.Form("ctanggal2")   
End If
%>
<%
Dim trawatpasien__MMColParam3
trawatpasien__MMColParam3 = "1"
If (Request.Form("cstatuspasien")      <> "") Then 
  trawatpasien__MMColParam3 = Request.Form("cstatuspasien")     
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT * FROM rspermata.trawatpasien WHERE tglmasuk >= ? and tglmasuk <= ? and statuspasien = ?  and trawatpasien.krumahsakit='" + Session("MM_Username") + "' ORDER BY tglmasuk ASC" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 255, trawatpasien__MMColParam1) ' adVarChar
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param2", 200, 1, 255, trawatpasien__MMColParam2) ' adVarChar
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param3", 200, 1, 255, trawatpasien__MMColParam3) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 50
Repeat1__index = 0
trawatpasien_numRows = trawatpasien_numRows + Repeat1__numRows
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
<title>Daftar Input Pasien</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="../template/templat04/style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="../template/templat04/js/cufon-yui.js"></script>
<script type="text/javascript" src="../template/templat04/js/arial.js"></script>
<script type="text/javascript" src="../template/templat04/js/cuf_run.js"></script>
<!-- CuFon ends -->
<style type="text/css">
<!--
.style2 {font-size: 16px}
.style9 {color: #666666}
.style19 {
	color: #FFFFFF;
	font-weight: bold;
}
.style20 {color: #000000}
.style22 {color: #000000; font-size: 14px; }
.style24 {color: #000000; font-size: 14px; font-weight: bold; }
.style25 {
	font-size: 14px;
	font-weight: bold;
}
.style27 {color: #000000; font-weight: bold; }
-->
</style>
</head>
<body>
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
          <li class="active"><a href="../menuutama.asp">Home</a></li>
          <li><a href="../editdata/menuutama.asp"></a></li>
          <li><a href="../editdata/menuutama.asp"></a></li>
          <li><a href="../editdata/menuutama.asp"></a></li>
          <li></li>
        </ul>
      </div>
      <div class="clr"></div>
    </div>
  </div>

  <div class="content">
    <div class="content_resize">
      <div class="sidebar">
        <div class="gadget">
      <form action="" method="post" name="form1" id="form1">
        <table width="100%">
          <tr>
            <td width="14%"><span class="style22">Mulai Tanggal </span></td>
            <td width="3%"><div align="center"><span class="style24">:</span></div></td>
            <td width="83%"><input name="ctanggal1" type="text" id="ctanggal1" value="<%=request.form("ctanggal1")%>" /> 
              Tahun / Bulan / Tanggal </td>
          </tr>
          <tr>
            <td><span class="style22">Sampai Tanggal </span></td>
            <td><div align="center"><span class="style24">:</span></div></td>
            <td><input name="ctanggal2" type="text" id="ctanggal2" value="<%=request.form("ctanggal2")%>" />
              Tahun / Bulan / Tanggal </td>
          </tr>
          <tr>
            <td><span class="style22">Status Berobat</span></td>
            <td><div align="center"><span class="style24">:</span></div></td>
            <td>
			<select name="cstatuspasien" id="cstatuspasien">
                <option value="1" <%If (Not isNull((request.form("cstatuspasien")))) Then If ("1" = CStr((request.form("cstatuspasien")))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Jalan</option>
                <option value="2" <%If (Not isNull((request.form("cstatuspasien")))) Then If ("2" = CStr((request.form("cstatuspasien")))) Then Response.Write("SELECTED") : Response.Write("")%>>Rawat Inap</option>
              </select>
              <input type="submit" name="Submit" value="OK" /></td>
          </tr>
          
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="right"></div></td>
          </tr>
        </table>
        <table width="100%" border="1" align="center">
          <tr bgcolor="#FFFFCC">
            <td align="center" bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">Tanggal Masuk </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">Tanggal Keluar </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">No Cm </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">Umur Thn </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">Umur Bln </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans"><font size="2">Umur Hari </font> </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans"><font size="2">Jenis Kel </font> </font></div></td>
            <td bgcolor="#006699"><div align="center" class="style19"><font size="2" face="Lucida Sans">Kode ICD </font></div></td>
            <td bgcolor="#006699">&nbsp;</td>
          </tr>
          <% 
		  trawatpasien_total=0
While ((Repeat1__numRows <> 0) AND (NOT trawatpasien.EOF)) 
trawatpasien_total=trawatpasien_total+1
%>
          <tr bgcolor="#CCFF99">
            <td height="19" align="center" bgcolor="#FFFFFF"><div align="left" class="style20">
              <div align="center"><strong><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("tglmasuk").Value)%></font></strong></div>
            </div></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="style27"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("tglkeluar").Value)%></font></span></div></td>
            <td bgcolor="#FFFFFF"><span class="style27"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("nocm").Value)%></font></span></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="style20"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("umurthn").Value)%></font></span></div></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="style20"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("umurbln").Value)%></font></span></div></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="style20"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("umurhr").Value)%></font></span></div></td>
            <td bgcolor="#FFFFFF"><div align="center"><span class="style20"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("jeniskel").Value)%></font></span></div></td>
            <td bgcolor="#FFFFFF"><span class="style20"><font size="2" face="Lucida Sans"><%=(trawatpasien.Fields.Item("kodeinadrg").Value)%></font></span></td>
            <td bgcolor="#FFFFFF"> <div align="center"><a href="editrawatpasien.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "cnotrans=" & trawatpasien.Fields.Item("notrans").Value %>"> E D I T </a></div></td>
          </tr>
          <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  trawatpasien.MoveNext()
Wend
%>
        </table>
        <p class="style20">Total : <span class="style25"><%=(trawatpasien_total)%></span> Pasien </p>
      </form>
        </div>
      </div>
      <div class="clr"></div>
    </div>
  </div>

  <div class="footer">
    <div class="footer_resize">
      <p><span class="lf">&copy; Copyright<span class="style9"> : </span></span><span class="style9">Kalboya@yahoo.com</span></p>
    </div>
  </div>
</div>
</body>
</html>

<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
