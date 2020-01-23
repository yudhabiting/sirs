<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
	cnamafile="datasptp.xls"

'   Response.ContentType = "application/vnd.ms-excel"
'	Response.AddHeader "Content-Disposition", "attachment; filename="&cnamafile

'	Response.ContentType = "application/msword"

%>
<html>
<head>

    <title>Data printing</title>
    <style type="text/css">
body{background:white;margin:0px;padding:0px;font-size:13px;text-align:left;}
.pb{font-size:13px;border-collapse:collapse;}
.pb th{font-weight:bold;text-align:center;border:1px solid #333333;padding:2px; color:#FFF; background-color:#666;}
.pb td{border:1px solid #333333;padding:2px;}
</style>
</head>
<body >
<div id="exportdetails">
<script type="text/javascript">
document.write(window.dialogArguments);
window.open('data:application/vnd.ms-excel,' + encodeURIComponent(window.dialogArguments)); 		

    </script>
</div>
</body>

</html>
