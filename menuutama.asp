<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
if lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect("tolak.asp") 
end if
%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->
<!--#include file="include/tableMENUKIRI.asp" -->
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
 /* warna dasar blok menu sebelah kiri 
	background: -moz-linear-gradient(#369, #333);
	background:#333 linear-gradient(#3C6, #333);
*/
        background: -moz-linear-gradient( #3C0 , #333);

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





.menuku {
	width: 100%;
	margin: 0;
	padding: 0;
	list-style: none;

	/* background Menu Utama */

    background: -moz-linear-gradient( #3C0 , #396);
    background: -moz-linear-gradient( #3C0 , #333);

	border-radius: 0px 0px 10px 10px;
	box-shadow: 0 2px 1px #9c9c9c;
	transition: 1s ease-in-out;
	-moz-transition: 1s ease-in-out;
}
.menuku li {
	float: right;
	padding: 0;
	position: relative;
}


.menuku a {
	float: right;
	padding: 10px 20px 7px 20px;
	color: #fff;
	text-decoration: none;
	text-shadow: 0 1px 0 #000;
}
.menuku li:hover > a {
	font-weight:bold;
	font-size:13px;
	text-shadow: 	0 0px 0 #CFC,
				    0 0px 0px rgba(0,0,0,0);
	color:#fff;

}

.menuku li:hover > ul {
	display: block;
}
.menuku:after {
	visibility: hidden;
	display: block;
	font-size: 0;
	content: " ";
	clear: both;
	height: 0;
}

.menuku ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: none;
	position: absolute;
	top: 35px;
	left: 0;
	z-index: 9999;
	/* background anak menu */
    background: -moz-linear-gradient( #093 , #396);
	border-radius: 0px;
	box-shadow: 0 2px 1px #9c9c9c;
}
.menuku ul li {
	float: none;
	margin: 0;
	padding: 0;
	display: block;
	box-shadow: 0 1px 0 #111, 0 2px 0 #777;
}

.menuku ul a {
	padding: 7px;
	height: auto;
	display: block;
	white-space: nowrap;
	float: none;
	text-transform: none;
}

.menuku ul a:hover {
	/* background cursor anak menu */
	background: #363;
	background: -moz-linear-gradient(#04acec, #0186ba);
	background: linear-gradient(#3C3, #363);
}
.menuku ul li:first-child a {
	border-radius: 5px 5px 0 0;
}
.menuku ul li:first-child a:after {
	content: " ";
	position: absolute;
	left: 30px;
	top: -8px;
	width: 0;
	height: 0;
	border-left: 1px solid transparent;
	border-right: 1px solid transparent;
	border-bottom: 1px solid #333;
}
.menuku ul li:first-child a:hover:after {
	border-bottom-color: #04acec;
}
.menuku ul li:last-child {
	box-shadow: none;
}
.menuku ul li:last-child a {
	border-radius: 0 0 10px 10px;
}


        </style>
    

</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
var text=" Login Id : <%=tpegawai.Fields.Item("nama").Value%> ";
var delay=50;
var currentChar=1;
var destination="[not defined]";

function type()
{
  if (document.getElementById)
  {
    var dest=document.getElementById(destination);
    if (dest)// && dest.innerHTML)
    {
      dest.innerHTML=text.substr(0, currentChar);
      //dest.innerHTML+=text[currentChar-1];
      currentChar++
      if (currentChar>text.length)
      {
        currentChar=1;
        setTimeout("type()", 5000);
      }
      else
      {
        setTimeout("type()", delay);
      }
    }
  }
}

function startTyping(textParam, delayParam, destinationParam)
{
  text=textParam;
  delay=delayParam;
  currentChar=1;
  destination=destinationParam;
  type();
}

//-->
</SCRIPT>    

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
								<font size="+1"><span class="fontjudul4"> <DIV ID="textDestination" align="center"></DIV> </span> </font>
							</li>
						</ul>
					</div>                   
				</div>
                
			</div>
		</div>
	</div>

<SCRIPT LANGUAGE="JavaScript">
<!--
startTyping(text, 50, "textDestination");
//-->
</script>
    
            <!--menu sebelah kiri-->
                <div id="breadcrumb" class="col-xs-6" style="padding-left: 25px;white-space:nowrap;z-index:1000; width:5px">
                    <a href="#" class="show-sidebar">
                      <i class="fa fa-bars"></i>
                    </a>
                    <ol class="breadcrumb" style="padding-left: 30px;">
                      <li class="hidden-xs">Menu Transaksi Pasien</li>
                    </ol>
                </div>


            <!--menu sebelah kanan-->

<!--#include file="include/menuINPUTatas.asp" -->
 
   

</header>



<div id="main" class="container-fluid sidebar-show" style="overflow:visible;background:#6C6;">
	<div class="row">
		<div id="sidebar-left" class="col-xs-2 col-sm-2" >
<!--#include file="include/menuINPUTkiri.asp" -->

		</div>





		<!--Start Content-->
	<div id="content" class="col-xs-12 col-sm-10" style="min-height:1000px;padding-left:0px; padding-right:0px;">
</br>
            <div class="row-fluid"> 
                <div class="box"><div class="box-content"><center>

</br>
</br>
</br>
</br>
</br>
                   
                    <font size="+2"><span class="fontjudul3"> Sistem Informasi Manajemen Rumah Sakit </span> </font> </br>
                    <font size="+4"><span class="fontjudul1">  RS PERMATA  </span> </font> </br>
                    <font size="+1"><span class="fontjudul3"> Jl. Mayjend Sutoyo No. 75 Purworejo </span> </font>
</br>
</br>
</br>
</br>
</br>

                    </center><br />
                </div>
            </div>

            <div style="padding: 20px;text-align:center;">
 								&copy; Design By |<font size="+1"><span class="fontjudul2"> Kalboya@yahoo.com </span> </font>

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
