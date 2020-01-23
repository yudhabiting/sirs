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
				response.Redirect("loginULANG.asp")
			else
				varstatususer=Encode(trim(tnourut2("statususer")))
				varpassword1=Encode(trim(CStr(Request.Form("cpassword"))))
				varpassword2=trim(tnourut2("password"))
				varpassword3=varpassword1&varstatususer
	
				if varpassword3<>varpassword2 then
					response.Redirect("loginULANG.asp")
				else
		
					Session("MM_userid") = MM_valUserid   	
					Session("MM_username") = MM_valUsername   	
					Session("MM_password") = MM_password1   
					Session("MM_kabupaten") = MM_kabupaten1   		
					Session("MM_statususer") = trim(tnourut2("statususer"))  		
					Session("MM_statusaplikasi") = trim(tnourut2("statususer"))    		
					Session("MM_nama") = trim(tnourut2("nama"))    		
					Session("MM_krumahsakit") = trim(tnourut2("krumahsakit"))     		
'					response.Redirect("menuutama.asp")
					response.write "<script>"
					response.write "window.close();</script>"
				end if
			end if
	
	End If

End If
%>
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

<!DOCTYPE html>
<html >
<head>
  <meta charset="utf-8">
  <title>LOGIN KADALUARSA</title>
  
  
  <link rel='stylesheet prefetch' href='template/LOGIN001/css/bootstrap.min.css'>

      <link rel="stylesheet" href="template/LOGIN001/css/style.css">
      <style type="text/css">
      body {
	background-color: #09C;
}
      </style>
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
    <div class="wrapper">
<form name="form1" method="POST" action="<%=MM_LoginAction%>" class="form-signin">       
      <h2 class="form-signin-heading">Login</h2>
      <input name="cuserid" type="text" autofocus required class="form-control" id="cuserid" placeholder="Username" />
      <input type="password" class="form-control" name="cpassword" id="cpassword" placeholder="Password" required/>      
      <button class="btn btn-lg btn-primary btn-block" type="button" onClick="loginku()">Login</button>   
					        <input name="ckkabupaten"  id="ckkabupaten" type="hidden" value="<%=(tkabupaten.Fields.Item("kkabupaten").Value)%>">
					        <input name="cusername"  id="cusername" type="hidden" value="<%=(trumahsakit.Fields.Item("krumahsakit").Value)%>">

    </form>
  </div>
  
  
</body>
</html>
<%
tkabupaten.Close()
Set tkabupaten = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>