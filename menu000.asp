<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
if lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("tolak.asp") 
end if
%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->
<!--#include file="include/tableMENUATAS.asp" -->

<%
Dim tpegawai__MMColParam
tpegawai__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tpegawai__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = ?" 
tpegawai_cmd.Prepared = true
tpegawai_cmd.Parameters.Append tpegawai_cmd.CreateParameter("param1", 200, 1, 6, tpegawai__MMColParam) ' adVarChar

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>

<!DOCTYPE html>
<html lang="en">	
<head>
<meta charset="utf-8">
<title>Menu Utama</title>
		<link href="template/menu000/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="template/menu000/css/font-awesome.css" rel="stylesheet">
		<link href="template/menu000/css/style.css" rel="stylesheet">

<script type="text/javascript" src="template/menu000/js/jquery.min1.js"></script> 
<script src="template/menu000/js/devoops.js"></script>

		<style>
        #breadcrumb {
        padding: 0;
        line-height: 40px;
 /* warna dasar blok menu sebelah kiri */
        background: -moz-linear-gradient( #3C0 , #396);
		color:#FFF;
        }
        .breadcrumb > li > a:hover, .breadcrumb > li:last-child > a {
        color: #D8D8D8;
		color:#FFF;
        }
        .breadcrumb > li > a {
        color: #D8D8D8;
		color:#FFF;
        }
        .breadcrumb > li + li::before {
        padding: 0 5px;
        content:"";
        }

        </style>
    

</head>
<body>

<header class="navbar">
	<div class="container-fluid expanded-panel">
		<div class="row" >

			<div id="logo" class="col-xs-12 col-sm-2" style="overflow: hidden; white-space: nowrap; height: 70px;">
            <img src="icon/logoPERMATA.png" width="180" height="60">
			</div>

			<div id="top-panel" class="col-xs-12 col-sm-10">
				<div class="row">
					<div class="col-xs-8 col-sm-8 top-panel-right text-center">
							<h3 style="padding-top: 10px;"><span style="white-space:nowrap"></span></h3>
					</div>

					<div class="col-xs-4 col-sm-4 top-panel-right text-right">
						<ul class="nav navbar-nav pull-right panel-menu">
							<li>
<p>
								<font size="+3"><span class="fontjudul2"> Menu Utama </span> </font>
								<font size="+1"><span class="fontjudul1"> | <%=tpegawai.Fields.Item("nama").Value%> </span> </font>
</p>
							</li>

							<li>

							</li>
						</ul>
					</div>                   
				</div>
                
			</div>
		</div>
	</div>


        <div class="row hidden-xs" style="max-height: 40px; overflow:hidden;">
    
            <!--menu sebelah kiri-->
                <div id="breadcrumb" class="col-xs-6" style="padding-left: 25px;white-space:nowrap;z-index:1000">
                    <a href="#" class="show-sidebar">
                      <i class="fa fa-bars"></i>
                    </a>
                    <ol class="breadcrumb" style="padding-left: 30px;">
                      <li class="hidden-xs"><a href="menuutama.asp">Beranda</a></li>
                      <li class="hidden-xs"><a href="exit.asp">Log Out</a></li>
                    </ol>
                </div>
    
            <!--menu sebelah kanan-->
                <div style="height:40px;padding-top:10px;padding-bottom:5px;background: -moz-linear-gradient( #3C0 , #396);" class="col-xs-6" >
                      <ul class="nav navbar-nav pull-right">
                          <li>
                                    <div class="wdt text-right">
                                        menu sebelah kanan &nbsp;&nbsp;&nbsp;
                                    </div>
                          </li>
                          <li>
                                    <div class="wdt text-right">
                                         menu sebelah kanan &nbsp;&nbsp;&nbsp; 
                                    </div>
                          </li>

                       </ul>
                </div>
	</div>

</header>



<div id="main" class="container-fluid sidebar-show" style="overflow:visible;background:#6C6;">
	<div class="row">
		<div id="sidebar-left" class="col-xs-2 col-sm-2" >
			<ul class="nav main-menu">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle">
						<i class="fa fa-keyboard-o"></i>
						<span class="hidden-xs">Development</span>
					</a>
					<ul class="dropdown-menu">
                        <li><a href="#" rel="nofollow">Laporan Keuangan Jasa medis Perbulan</a></li>
                        <li><a href="#" rel="nofollow">GO Formatter</a></li>
                        <li><a href="#" rel="nofollow">HTML Formatter</a></li>
                        <li><a href="#" rel="nofollow">Javascript Formatter</a></li>
                        <li><a href="#" rel="nofollow">Javascript Obfuscate</a></li>
                        <li><a href="#" rel="nofollow">JSON Formatter</a></li>
                        <li><a href="#" rel="nofollow">JSON Editor</a></li>
                        <li><a href="#" rel="nofollow">XML Formatter</a></li>
					</ul>
				</li>
			</ul>

<!--#include file="include/menuINPUT.asp" -->

		</div>





		<!--Start Content-->
	<div id="content" class="col-xs-12 col-sm-10" style="min-height:1000px;padding-left:0px; padding-right:0px;">
            <div class="row-fluid"> 
                <div class="box"><div class="box-content"><center>
                    <h2>RS Permata Purworejo</h2></center><br />
                </div>
            </div>

            <div style="padding: 20px;text-align:center;">
 								&copy; Design By |<font size="+1"><span class="fontjudul1"> Kalboya@yahoo.com </span> </font>

            </div>
		</div>
		<!--End Content-->
	</div>
</div>
</html>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<!--#include file="include/tableMENUBAWAH.asp" -->
