<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="../Connections/datarspermata.asp" -->
<%
Dim tpenyakit
Dim tpenyakit_numRows

Set tpenyakit = Server.CreateObject("ADODB.Recordset")
tpenyakit.ActiveConnection = MM_datarspermata_STRING
tpenyakit.Source = "SELECT * FROM rspermata.tpenyakitinadrg ORDER BY kodeicd ASC"
tpenyakit.CursorType = 0
tpenyakit.CursorLocation = 2
tpenyakit.LockType = 1
tpenyakit.Open()

tpenyakit_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = 100
Repeat1__index = 0
tpenyakit_numRows = tpenyakit_numRows + Repeat1__numRows
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Data Penyakit</title>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

 function ajaxFunction(ckodeicd)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var penyakitku=ckodeicd
	url="../include/gridpenyakit.asp?ckodeicd="+penyakitku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("gridpenyakit").innerHTML=xmlHttp.responseText;}} 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  

//-->
</script>

<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 11px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 11px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 11px; color:#0000FF}
a:link {text-decoration: none;font-size: 11px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 11px; color:#FFFFFF; }
.style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
-->
</style>
</head>
<body>
	  <link rel="STYLESHEET" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.css">
	<link rel="stylesheet" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>	
	<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
	<script>
		dhtmlx.skin = "dhx_skyblue";
	</script>
			<form id="form1" method="post" action="">
			  <h2 class="title">DAFTAR PENYAKIT </h2>
			  <table width="100%">
                <tr>
                  <td width="15%"><span class="style3">Kode ICD </span></td>
                  <td width="2%"><div align="center">:</div></td>
                  <td width="83%"><input name="ckodeicd" type="text" id="ckodeicd" onblur="ajaxFunction(this.value)"/></td>
                </tr>
                <tr>
                  <td><span class="style3">Diagnosa</span></td>
                  <td><div align="center">:</div></td>
                  <td><input name="cdiagnosa" type="text" id="cdiagnosa" size="50" /></td>
                </tr>
                <tr>
                  <td><span class="style3">Subdiagnosa</span></td>
                  <td><div align="center">:</div></td>
                  <td><input name="textfield3" type="text" size="50" /></td>
                </tr>
              </table>
			  <div  id="gridpenyakit">
			  <table class="dhtmlxGrid" gridheight="300px" name="grid2" imgpath="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/imgs/" style="width:*" lightnavigation="true">
                <tr bgcolor="#FF0000">
                  <td width="75%" height="31" bgcolor="#6F7A9F">Kode Penyakit </td>
                  <td bgcolor="#6F7A9F">Kode ICD </td>
                  <td width="*" bgcolor="#6F7A9F">Diagnosa</td>
                  <td width="*" bgcolor="#6F7A9F">Sub Diagnosa </td>
                </tr>
                <% 
While ((Repeat1__numRows <> 0) AND (NOT tpenyakit.EOF)) 
%>
                <tr bgcolor="#FFFFCC">
                  <td height="22"><a href="../master/editpenyakit.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "ckpenyakit=" & tpenyakit.Fields.Item("kodeinadrg").Value %>"><%=(tpenyakit.Fields.Item("kodeinadrg").Value)%></a></td>
                  <td><%=(tpenyakit.Fields.Item("kodeICD").Value)%></td>
                  <td><%=(tpenyakit.Fields.Item("DIAGNOSA").Value)%></td>
                  <td><%=(tpenyakit.Fields.Item("SUBDIAGNOSA").Value)%></td>
                </tr>
                <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tpenyakit.MoveNext()
Wend
%>
              </table>
			  </div>
</form>
</body>
</html>
<%
tpenyakit.Close()
Set tpenyakit = Nothing
%>
