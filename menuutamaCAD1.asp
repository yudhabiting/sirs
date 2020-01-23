<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
if lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("tolak.asp") 
end if
%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->
<!--#include file="include/tableMENUATAS.asp" -->
<!DOCTYPE html>
<html lang="en" style="-webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%;">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
	<title>Menu Utama</title>
	<link rel="stylesheet" href="template/templat05/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="template/templat05/css/flexslider.css" type="text/css" media="all" />
	
	<script src="template/templat05/js/jquery-1.8.0.min.js" type="text/javascript"></script>
	<script src="template/templat05/js/jquery.flexslider-min.js" type="text/javascript"></script>
	<script src="template/templat05/js/functions.js" type="text/javascript"></script>

<link href="template/menu001/menuku.css" rel="stylesheet" type="text/css" />


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
				</header>

<!--#include file="include/menuINPUT.asp" -->
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
    RS Permata Spesialis : memberikan pelayanan kesehatan yang bersifat spesialistis ditiap unit pelayanan sesuai dengan bidang keahlian masing-masing. rspermata Umum : memberikan pelayanan kesehatan yang bersifat umum sesuai dengan standar pelayanan medis yang ditetapkan.
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
</br>
</br>
</br>
</br>

				<div id="footer"><!-- end of footer-cols -->
					<div class="footer-bottom">
				    <p class="copy">&copy; Copyright 2017 -  Kalboya@yahoo.com</p>
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
<!--#include file="include/tableMENUBAWAH.asp" -->
