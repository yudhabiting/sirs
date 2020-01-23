<%@LANGUAGE="VBSCRIPT"%>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("tolak.asp")
end if
%>

<%
' *** Logout the current user.
MM_Logout = CStr(Request.ServerVariables("URL")) & "?MM_Logoutnow=1"
If (CStr(Request("MM_Logoutnow")) = "1") Then
  Session.Contents.Remove("MM_Username")
  Session.Contents.Remove("MM_UserAuthorization")
  MM_logoutRedirectPage = "index.asp"
  ' redirect with URL parameters (remove the "MM_Logoutnow" query param).
  if (MM_logoutRedirectPage = "") Then MM_logoutRedirectPage = CStr(Request.ServerVariables("URL"))
  If (InStr(1, UC_redirectPage, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
    MM_newQS = "?"
    For Each Item In Request.QueryString
      If (Item <> "MM_Logoutnow") Then
        If (Len(MM_newQS) > 1) Then MM_newQS = MM_newQS & "&"
        MM_newQS = MM_newQS & Item & "=" & Server.URLencode(Request.QueryString(Item))
      End If
    Next
    if (Len(MM_newQS) > 1) Then MM_logoutRedirectPage = MM_logoutRedirectPage & MM_newQS
  End If
  Response.Redirect(MM_logoutRedirectPage)
End If
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Design by http://www.FreeWebsiteTemplateZ.com
Released for free under a Creative Commons Attribution 3.0 License
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Menu Utama</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="template/templat04/style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="template/templat04/js/cufon-yui.js"></script>
<script type="text/javascript" src="template/templat04/js/arial.js"></script>
<script type="text/javascript" src="template/templat04/js/cuf_run.js"></script>
<!-- CuFon ends -->
<style type="text/css">
<!--
.style2 {font-size: 16px}
.style8 {font-size: 17px}
.style9 {color: #666666}
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
          <li class="active"><a href="menuutama.asp">Home</a></li>
          <li><a href="<%= MM_Logout %>">Keluar</a></li>


        </ul>
      </div>
      <div class="clr"></div>
    </div>
  </div>

  <div class="content">
    <div class="content_resize">
      <div class="sidebar">
        <div class="gadget">
          <h2 class="star">Menu Master </h2>
          <ul class="sb_menu style2">
            <li><span class="style8"><a href="master/editrs.asp">Identitas Rumah Sakit </a></span></li>
            <li><span class="style8"><a href="master/masterpasien.asp">Identitas Pasien </a></span></li>
            <li><span class="style8"><a href="daftar/caripasien.asp">Cari Data Pasien </a></span></li>
            <li><span class="style8"><a href="master/daftarpenyakitinadrg.asp">Daftar Penyakit </a></span></li>
          </ul>
          <h2 class="star">Menu Transaksi </h2>
          <ul class="sb_menu style2">
            <li><span class="style8"><a href="inputdata/inputrawatpasien.asp">Input Rawat Pasien </a></span></li>
            <li class="style8"><a href="editdata/daftarinputrawatpasien.asp">Daftar Input Data Pasien </a></li>
          </ul>
          <h2 class="star">Menu Pelaporan </h2>
          <ul class="sb_menu style2">
            <li class="style8"><a href="laporan/lapsurvelenRJ.asp">Pelaporan Survailen Rawat Jalan</a></li>
            <li class="style8"><a href="laporan/lapsurvelenRI.asp">Pelaporan Survailen Rawat Inap </a></li>
            <li class="style8"><a href="laporan/lapmorbiditasRJ.asp">Pelaporan Morbiditas Rawat Jalan</a></li>
            <li class="style8"><a href="laporan/lapmorbiditasRI.asp">Pelaporan Morbiditas Rawat Inap </a></li>
          </ul>
          <h2 class="star">Menu Utility </h2>
          <ul class="sb_menu style2">
            <li><a href="utility/inputuser.asp">Input User</a></li>
            <li class="style8"><a href="utility/daftaruser.asp">Daftar User</a></li>
          </ul>
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
