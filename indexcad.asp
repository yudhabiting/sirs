<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->
<%
Dim tkabupaten
Dim tkabupaten_numRows

Set tkabupaten = Server.CreateObject("ADODB.Recordset")
tkabupaten.ActiveConnection = MM_datarspermata_STRING
tkabupaten.Source = "SELECT kabupaten, kkabupaten FROM rspermata.tkabupaten ORDER BY kabupaten ASC"
tkabupaten.CursorType = 0
tkabupaten.CursorLocation = 2
tkabupaten.LockType = 1
tkabupaten.Open()

tkabupaten_numRows = 0
%>
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername=CStr(Request.Form("cusername"))
MM_password1=CStr(Request.Form("cpassword"))
MM_kabupaten1=CStr(Request.Form("ckkabupaten"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="menuutama.asp"
  MM_redirectLoginFailed="gagal.asp"
  MM_flag="ADODB.Recordset"
  set MM_rsUser = Server.CreateObject(MM_flag)
  MM_rsUser.ActiveConnection = MM_datarspermata_STRING
  MM_rsUser.Source = "SELECT user, password"
  If MM_fldUserAuthorization <> "" Then MM_rsUser.Source = MM_rsUser.Source & "," & MM_fldUserAuthorization
  MM_rsUser.Source = MM_rsUser.Source & " FROM rspermata.user WHERE user='" & Replace(MM_valUsername,"'","''") &"' AND password='" & Replace(Request.Form("cpassword"),"'","''") & "'"
  MM_rsUser.CursorType = 0
  MM_rsUser.CursorLocation = 2
  MM_rsUser.LockType = 3
  MM_rsUser.Open
  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    Session("MM_username") = MM_valUsername   	
    Session("MM_password") = MM_password1   	
    Session("MM_kabupaten") = MM_kabupaten1   		
    MM_rsUser.Close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>

<%
'session.Timeout=240
'SessionStateSection.Timeout="true" max="1000" timeout="00:10:00"
%>

<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Request.QueryString
MM_valUsername=CStr(Request.Form("cusername"))
MM_password1=CStr(Request.Form("cpassword"))
MM_kabupaten1=CStr(Request.Form("ckkabupaten"))
If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="menuutama.asp"
  MM_redirectLoginFailed="gagal.asp"
'  MM_redirectLoginSuccess="gagal.asp"
'  MM_redirectLoginFailed="menuutama.asp"
  MM_flag="ADODB.Recordset"
  set MM_rsUser = Server.CreateObject(MM_flag)
  MM_rsUser.ActiveConnection = MM_datamysql_STRING
  MM_rsUser.Source = "SELECT User, Password"
  
  set MM_password2 = Server.CreateObject(MM_flag)
  MM_password2.ActiveConnection = MM_datamysql_STRING
  MM_password2.source="select password('"+MM_password1+"') as password"
  MM_password2.open
  
  If MM_fldUserAuthorization <> "" Then MM_rsUser.Source = MM_rsUser.Source & "," & MM_fldUserAuthorization
  MM_rsUser.Source = MM_rsUser.Source & " FROM mysql.user WHERE User='" & Replace(MM_valUsername,"'","''") &"' AND Password='"& Replace((MM_password2.Fields.Item("Password").Value),"'","''")&"'"
  MM_rsUser.CursorType = 0
  MM_rsUser.CursorLocation = 2
  MM_rsUser.LockType = 3
  MM_rsUser.Open
  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 
    ' username and password match - this is a valid user
    Session("MM_Username") = MM_valUsername
    If (MM_fldUserAuthorization <> "") Then
      Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    Else
      Session("MM_UserAuthorization") = ""
    End If
    if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    End If
    Session("MM_username") = MM_valUsername   	
    Session("MM_password") = MM_password1   	
    Session("MM_kabupaten") = MM_kabupaten1   	
    MM_rsUser.Close
	MM_password2.close
    Response.Redirect(MM_redirectLoginSuccess)
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>

<!DOCTYPE html>
<html lang="en" style="-webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
	<title>Form Login</title>
	<link rel="stylesheet" href="template/templat05/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="template/templat05/css/flexslider.css" type="text/css" media="all" />
	<link href='http://fonts.googleapis.com/css?family=Ubuntu:400,500,700' rel='stylesheet' type='text/css' />
	
	<script src="template/templat05/js/jquery-1.8.0.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
	<script src="template/templat05/js/jquery.flexslider-min.js" type="text/javascript"></script>
	<script src="template/templat05/js/functions.js" type="text/javascript"></script>
<style type="text/css">
.style12 {font-size: 24px; color: #CB4100; font-family: Geneva, Arial, Helvetica, sans-serif; }
.style13 {color: #333333; font-family: Verdana, Arial, Helvetica, sans-serif; }
.style2 {	font-size: 16px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	color: #003333;
}
</style>
</head>
<body>
	<!-- wraper -->
	<div id="wrapper">
		<!-- shell -->
		<div class="shell">
			<!-- container -->
			<div class="container">
				<!-- header -->
				<header id="header">
					<h1 id="logo"><a href="#">Curve</a></h1>
					<!-- search --><!-- end of search -->
				</header>
				<!-- end of header -->
				<!-- navigation -->
				<nav id="navigation">
					<a href="#" class="nav-btn">HOME<span class="arr"></span></a>
					<ul>
						<li class="active"><a href="dashboard.asp">HOME</a></li>
						<li><a href="#">RAWAT JALAN</a></li>
						<li><a href="#">RAWAT INAP</a></li>
						<li><a href="#">INSTALASI FARMASI</a></li>
						<li><a href="#">FISIOTERAPI</a></li>
						<li><a href="#">LABORATORIUM</a></li>
					</ul>
				</nav>
				<!-- end of navigation -->
				<!-- slider -->
				<div class="m-slider">
					<div class="slider-holder">
						<span class="slider-shadow"></span>
						<span class="slider-b"></span>
						<div class="slider flexslider">
							<ul class="slides">
								<li>
									<div class="img-holder">
										<img src="template/templat05/css/images/slide-img1.png" alt="" />
									</div>
									<div class="slide-cnt">
										<h2>RS Permata</h2>
										<div class="box-cnt">
											<p>
    RS Permata  : memberikan pelayanan kesehatan yang bersifat spesialistis ditiap unit pelayanan sesuai dengan bidang keahlian masing-masing. rspermata Umum : memberikan pelayanan kesehatan yang bersifat umum sesuai dengan standar pelayanan medis yang ditetapkan.
    RS Permata : memberikan pelayanan kesehatan gigi bersifat umum maupun spesialistis sesuai dengan standar pelayanan medis. Instalasi Gawat Darurat : memberikan pelayanan medik yang optimal, cepat dan tepat pada penderita gawat darurat berdasarkan kriteria standar baku serta etika kedokteran.
</p>
										</div>
									</div>
								</li>
								<li>
									<div class="img-holder">
										<img src="template/templat05/css/images/slide-img2.png" alt="" />
									</div>
									<div class="slide-cnt">
										<h2>RS Permata</h2>
										<div class="box-cnt">
											<p>
    Laboratorium : kegiatan dibidang laboratorium klinik utk kepentingan diagnosis , 24jam sehari sesuai dng standar pelayanan yang telah ditetapkan. Pemeriksaan Rutin : lama 1jam, Pemeriksaan Kimia Darah  : lama 4 jam. Radiologi : kegiatan dibidang radiologi utk diagnosis terapi bagi penderita rawat jalan maupun rawat inap, 24 jam sehari, juga meliputi pemeriksaan CT Scan, USG. Pemeriksaan rutin : lama 1 jam, Pemeriksaan dengan kontras : lama 3jam. Gizi : penyelenggaraan pelayanan gizi, berupa konsultasi. Apotik : melayani pembelian obat kpd pasien selama 24 jam sehari. 
</p>
										</div>
									</div>
								</li>
								<li>
									<div class="img-holder">
										<img src="template/templat05/css/images/slide-img1.png" alt="" />
									</div>
									<div class="slide-cnt">
										<h2>RS Permata</h2>
										<div class="box-cnt">
											<p>    RS Permata Spesialis : memberikan pelayanan kesehatan yang bersifat spesialistis ditiap unit pelayanan sesuai dengan bidang keahlian masing-masing. rspermata Umum : memberikan pelayanan kesehatan yang bersifat umum sesuai dengan standar pelayanan medis yang ditetapkan.
    RS Permata : memberikan pelayanan kesehatan gigi bersifat umum maupun spesialistis sesuai dengan standar pelayanan medis. Instalasi Gawat Darurat : memberikan pelayanan medik yang optimal, cepat dan tepat pada penderita gawat darurat berdasarkan kriteria standar baku serta etika kedokteran.
</p>
										</div>
										<a href="#" class="grey-btn">request a demo</a>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>		
				<!-- end of slider -->
				<!-- main -->
			  <div class="main">
					<a href="#" class="m-btn-grey grey-btn">request a demo</a>
					<section class="post">
					  <form name="form1" method="POST" action="<%=MM_LoginAction%>">
					  <table width="99%">
					    
					    <tr>
					      <td width="58%"><div align="center"><font size="2" face="Lucida Sans">Username:
					        <input name="cusername" type="text" id="cusername" />
					        </font><font size="2">Password : </font> <font size="2" face="Lucida Sans">
				            <input name="cpassword" type="password" id="cpassword" />
				            <input type="submit" name="Submit" value="Login" />
				            </font>
					        <input name="ckkabupaten"  id="ckkabupaten" type="hidden" value="<%=(tkabupaten.Fields.Item("kkabupaten").Value)%>">
					      </div></td>
				        </tr>
					    </table>
    </form>
					  </section>

				  <section class="testimonial"></section>
			  </div>
				<!-- end of main -->
				<div class="socials">
					<div class="socials-inner">
					  <ul>
				      <li></li>
							<li></li>
							<li></li>
							<li></li>
					  </ul>
					</div>
				</div>
				<div id="footer"><!-- end of footer-cols -->
					<div class="footer-bottom">
				    <p class="copy">&copy; Copyright 2013 - Agoes Irdianto - Kalboya@yahoo.com</p>
						<div class="cl">&nbsp;</div>
					</div>
				</div>
			</div>
			<!-- end of container -->	
		</div>
		<!-- end of shell -->	
	</div>
	<!-- end of wrapper -->
</body>
</html>
<%
tkabupaten.Close()
Set tkabupaten = Nothing
%>