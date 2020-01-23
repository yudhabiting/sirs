<%@LANGUAGE="VBSCRIPT" %>
<%
chome=""
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->
<%
ckmenu1=request.querystring("ckmenu1")
ckmenu2=request.querystring("ckmenu2")

Dim tsubmenujudul
Dim tsubmenujudul_cmd
Dim tsubmenujudul_numRows

Set tsubmenujudul_cmd = Server.CreateObject ("ADODB.Command")
tsubmenujudul_cmd.ActiveConnection = MM_datarspermata_STRING
tsubmenujudul_cmd.CommandText = "SELECT * FROM rspermata.tmenu2 WHERE  kmenu1='"&ckmenu1&"' AND  kmenu2='"&ckmenu2&"'" 
tsubmenujudul_cmd.Prepared = true

Set tsubmenujudul = tsubmenujudul_cmd.Execute
tsubmenujudul_numRows = 0

%>

<%
cjudul   = tsubmenujudul.Fields.Item("keterangan").Value
ctabel   = tsubmenujudul.Fields.Item("ctabel").Value
clegend0 = tsubmenujudul.Fields.Item("legend0").Value
clegend1 = tsubmenujudul.Fields.Item("legend1").Value
clegend2 = tsubmenujudul.Fields.Item("legend2").Value
clegend3 = tsubmenujudul.Fields.Item("legend3").Value
clegend4 = tsubmenujudul.Fields.Item("legend4").Value
clegend5 = tsubmenujudul.Fields.Item("legend5").Value
clegend6 = tsubmenujudul.Fields.Item("legend6").Value
clegend7 = tsubmenujudul.Fields.Item("legend7").Value
clegend8 = tsubmenujudul.Fields.Item("legend8").Value
clegend9 = tsubmenujudul.Fields.Item("legend9").Value
clegend10 = tsubmenujudul.Fields.Item("legend10").Value
%>

<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>					
function DoDateTime(str, nNamedFormat, nLCID)				
	dim strRet								
	dim nOldLCID								
										
	strRet = str								
	If (nLCID > -1) Then							
		oldLCID = Session.LCID						
	End If									
										
	On Error Resume Next							
										
	If (nLCID > -1) Then							
		Session.LCID = nLCID						
	End If									
										
	If ((nLCID < 0) Or (Session.LCID = nLCID)) Then				
		strRet = FormatDateTime(str, nNamedFormat)			
	End If									
										
	If (nLCID > -1) Then							
		Session.LCID = oldLCID						
	End If									
										
	DoDateTime = strRet							
End Function									
</SCRIPT>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=cjudul%></title>
<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />

<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/metro-red/easyui.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/demo/demo.css"/>

<script type="text/javascript" src="../include/Highcharts/jquery171.min.js"></script>

<script type="text/javascript" src="../include/jqueryeasyui/jquery.min.js"></script>
<script type="text/javascript" src="../include/jqueryeasyui/jquery.easyui.min.js"></script>

<script type="text/javascript">
function myformatter(date){
var y = date.getFullYear();
var m = date.getMonth()+1;
var d = date.getDate();
return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
if (!s) return new Date();
var ss = (s.split('-'));
var y = parseInt(ss[0],10);
var m = parseInt(ss[1],10);
var d = parseInt(ss[2],10);
if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
return new Date(y,m-1,d);
} else {
return new Date();
}
}

</script>
<script type="text/javascript">
//var dataku = [3,6,5,1,2,3,1,6];

var dataku1 =  [];
var dataku2 =  [];
var dataku3 =  [];
var dataku4 =  [];
var dataku5 =  [];
var dataku6 =  [];
var dataku7 =  [];
var dataku8 =  [];
var dataku9 =  [];
var dataku10 =  [];


var categories = [];	    
</script>

 <!--#include file="comboONKLICK.asp" -->
<form action="" method="POST"  name="form1">
 
<!--#include file="comboFORM1.asp" -->
 
</form>            

<script src="../include/Highcharts/Highcharts/js/highcharts.js"></script>
<script src="../include/Highcharts/Highcharts/js/highcharts-3d.js"></script>

<script src="../include/Highcharts/exporting.js"></script>
<div id="container" style="min-width: 400px; height: 550px; margin: 0 auto"></div>


 <!--#include file="comboCHART.asp" -->




<div id="sliders">
	<table>
		<tr><td>Alpha Angle</td><td><input id="R0" type="range" min="0" max="45" value="0"/> <span id="R0-value" class="value"></span></td></tr>
	    <tr><td>Beta Angle</td><td><input id="R1" type="range" min="0" max="45" value="0"/> <span id="R1-value" class="value"></span></td></tr>
	</table>
</div>
          <div class="cleaner_with_height">&nbsp;</div>
      </div> <!-- end of ocntent left -->
        
 
        
</body>
</html>
<%
tsubmenujudul.Close()
Set tsubmenujudul = Nothing
%>