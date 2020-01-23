<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="include/md5A.asp"-->
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
Dim trumahsakit
Dim trumahsakit_numRows

Set trumahsakit = Server.CreateObject("ADODB.Recordset")
trumahsakit.ActiveConnection = MM_datarspermata_STRING
trumahsakit.Source = "SELECT rumahsakit, krumahsakit FROM rspermata.trumahsakit ORDER BY krumahsakit ASC"
trumahsakit.CursorType = 0
trumahsakit.CursorLocation = 2
trumahsakit.LockType = 1
trumahsakit.Open()

trumahsakit_numRows = 0
%>
<%
' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
	MM_valUsername=CStr(Request.Form("cusername"))
	If MM_valUsername <> "" Then
	
		MM_valUserid=CStr(Request.Form("cuserid"))
		MM_valUsername=CStr(Request.Form("cusername"))
		MM_password1=CStr(Request.Form("cpassword"))
		MM_kabupaten1=CStr(Request.Form("ckkabupaten"))
	
		If MM_valUsername <> "" Then
		
			cuserid	=	CStr(Request.Form("cuserid"))
			Set tnourut1 = Server.CreateObject("ADODB.connection")
			tnourut1.open = MM_datarspermata_STRING
			set tnourut2=tnourut1.execute ("SELECT statususer,password,krumahsakit,nama FROM tpegawai where nourut ='"&cuserid&"'")
			
			if tnourut2.eof then
				response.Redirect("gagal.asp")
			else
				varstatususer=Encode(trim(tnourut2("statususer")))
				varpassword1=Encode(trim(CStr(Request.Form("cpassword"))))
				varpassword2=trim(tnourut2("password"))
				varpassword3=varpassword1&varstatususer
	
				if varpassword3<>varpassword2 then
					response.Redirect("gagal.asp")
				else
		
					Session("MM_userid") = MM_valUserid   	
					Session("MM_username") = MM_valUsername   	
					Session("MM_password") = MM_password1   
					Session("MM_kabupaten") = MM_kabupaten1   		
					Session("MM_statususer") = trim(tnourut2("statususer"))  		
					Session("MM_statusaplikasi") = trim(tnourut2("statususer"))    		
					Session("MM_nama") = trim(tnourut2("nama"))    		
					Session("MM_krumahsakit") = trim(tnourut2("krumahsakit"))     		
					response.Redirect("menuutama.asp")
				end if
			end if
	
	End If

End If
%>

<!DOCTYPE html>
<html lang="en">	
<head>
<meta charset="utf-8">
<title>Login Gagal</title>
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

<SCRIPT LANGUAGE="JavaScript">
<!--
var text="Username & Password Salah, Silahkan Login Ulang..!  ";
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
<script type="text/javascript">

function loginku()
{
var cuserid = document.forms['form1'].elements['cuserid'].value;
var cusername = document.forms['form1'].elements['cusername'].value;
var cpassword = document.forms['form1'].elements['cpassword'].value;
var ckkabupaten = document.forms['form1'].elements['ckkabupaten'].value;


if ((cuserid)==''){
		document.forms['form1'].elements['cuserid'].focus();
		alert('Username tidak boleh kosong')
		return false
	}
else if ((cusername)==''){
		document.forms['form1'].elements['cusername'].focus();
		alert('Unit Kerja tidak boleh kosong')
		return false
	}
else if ((cpassword)==''){
		document.forms['form1'].elements['cpassword'].focus();
		alert('Password tidak boleh kosong')
		return false
	}
else if ((ckkabupaten)==''){
		document.forms['form1'].elements['ckkabupaten'].focus();
		alert('Kabupaten tidak boleh kosong')
		return false
	}
	
else {
	document.forms['form1'].submit();
}
}
function coba()
{
	alert('coba');
}
</script>

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

					<div class="col-xs-4 col-sm-4 top-panel-right text-right">
						<ul class="nav navbar-nav pull-right panel-menu">
							<li>
<p>
								<font size="+3"><span class="fontjudul2"> Login Aplikasi </span> </font>
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
                    </a>
                    <ol class="breadcrumb" style="padding-left: 30px;">
                      <li class="hidden-xs"></li>
                    </ol>
                </div>
    
            <!--menu sebelah kanan-->
                <div style="height:40px;padding-top:10px;padding-bottom:5px;background: -moz-linear-gradient( #3C0 , #396);" class="col-xs-6" >
                      <ul class="nav navbar-nav pull-right">

                       </ul>
                </div>
	</div>

</header>



<div id="main" class="container-fluid sidebar-show" style="overflow:visible;background:#6C6;">
	<div class="row">


</br>


		<!--Start Content-->
	<div id="content" class="col-xs-12 col-sm-10" style="min-height:1000px;padding-left:0px; padding-right:0px;">
</br>

            <div class="row-fluid"> 
                <div class="box"><div class="box-content"><center>
								
 
 					  <form name="form1" method="POST" action="<%=MM_LoginAction%>">
					  <table width="100%">
					    
					    <tr>
					      <td colspan="3" align="center">&nbsp;</td>
				        </tr>
					    <tr>
					      <td colspan="3" align="center">&nbsp;</td>
				        </tr>
					    <tr>
					      <td colspan="3" align="center"><font size="+3"><span class="fontjudul1"> <DIV ID="textDestination" align="center"></DIV> </span> </font></td>
				        </tr>

<SCRIPT LANGUAGE="JavaScript">
<!--
startTyping(text, 50, "textDestination");
//-->
</script>
					    <tr>
					      <td colspan="3" align="center">&nbsp;</td>
				        </tr>
					    <tr>
					      <td colspan="3" align="center">&nbsp;</td>
				        </tr>
					    <tr>
					      <td width="40%" align="right"><font size="2" face="Lucida Sans">Username</font></td>
					      <td width="1%" align="center">:</td>
					      <td width="58%"><font size="2" face="Lucida Sans">
					        <input name="cuserid" type="text" id="cuserid" size="50" class="textku1"/>
					      </font></td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td>&nbsp;</td>
				        </tr>
					    <tr>
					      <td align="right"><font size="2">Password</font></td>
					      <td align="center">:</td>
					      <td><font size="2" face="Lucida Sans">
					        <input name="cpassword" type="password" id="cpassword" size="50"  class="textku1" />
					      </font></td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td>&nbsp;</td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td><font size="2" face="Lucida Sans">
					        <input type="button" name="Button" value="Login" onClick="loginku()" class="tombolku1"/>
				          <input name="cusername"  id="cusername" type="hidden" value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>">
					      <input name="ckkabupaten"  id="ckkabupaten" type="hidden" value="<%=(tkabupaten.Fields.Item("kkabupaten").Value)%>">
					      </font></td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td>&nbsp;</td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td>&nbsp;</td>
				        </tr>
					    <tr>
					      <td align="right">&nbsp;</td>
					      <td align="center">&nbsp;</td>
					      <td>&nbsp;</td>
				        </tr>
					    </table>
    </form>

 
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
tkabupaten.Close()
Set tkabupaten = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>