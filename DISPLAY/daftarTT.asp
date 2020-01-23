<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%> 
<!--#include file="../Connections/datarspermata.asp" -->
<%
Dim tketersediantt
Dim tketersediantt_numRows

Set tketersediantt = Server.CreateObject("ADODB.Recordset")
tketersediantt.ActiveConnection = MM_datarspermata_STRING
tketersediantt.Source = "select ktersediaantt,tersediantt, " &_
	" (SELECT sum(jmlbed) from tkelas where tkelas.kriteria=ttersediaantt.kriteria  and tkelas.kkelas NOT IN ('10','11')) as jumlahtt1, " &_
	" (SELECT count(tkelas.kriteria) FROM trawatpasien " &_
	" Left Join tkelas ON trawatpasien.kkelas = tkelas.kkelas where tkelas.kriteria=ttersediaantt.kriteria  " &_
	" and trawatpasien.carakeluar='' and trawatpasien.statuspasien='2' group by tkelas.kriteria) as jumlahtt2, " &_
	" ((select jumlahtt1)-(select jumlahtt2)) as jumlahtt3 from ttersediaantt where tampil='Y'"


 

tketersediantt.CursorType = 0
tketersediantt.CursorLocation = 2
tketersediantt.LockType = 1
tketersediantt.Open()

tketersediantt_numRows = 0
%>


<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tketersediantt_numRows = tketersediantt_numRows + Repeat1__numRows
%>



<%
Dim tketersediantt1
Dim tketersediantt1_numRows

Set tketersediantt1 = Server.CreateObject("ADODB.Recordset")
tketersediantt1.ActiveConnection = MM_datarspermata_STRING
tketersediantt1.Source = "select kkelas,kelas, jmlbed as jumlahtt1 , " &_
	" coalesce((SELECT count(trawatpasien.notrans) FROM trawatpasien where trawatpasien.kkelas=tkelas.kkelas  " &_
	" and trawatpasien.carakeluar='' and trawatpasien.statuspasien='2' group by trawatpasien.kkelas),0) as jumlahtt2, " &_
	" ((select jumlahtt1)-(select jumlahtt2)) as jumlahtt3 from tkelas order by kriteria,kelas  "

tketersediantt1.CursorType = 0
tketersediantt1.CursorLocation = 2
tketersediantt1.LockType = 1
tketersediantt1.Open()

tketersediantt1_numRows = 0
%>

<%
Dim Repeat1A__numRows
Dim Repeat1A__index

Repeat1A__numRows = -1
Repeat1A__index = 0
tketersediantt1_numRows = tketersediantt1_numRows + Repeat1A__numRows
%>


<%
ckantor="RS Permata"
calamat1="Jl. Mayjend Sutoyo No. 75 - Purworejo"
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


<!DOCTYPE html>
<html>
<head>
<title>Display Ketersediaan Tempat Tidur</title>
<script src="jquery-latest.js"></script>
<script type="text/javascript">
var auto_refresh = setInterval(
function ()
{
$('#tabelku').load('refreshtabelku.asp?_=' +Math.random()).fadeIn("slow");
}, 5000); // refresh setiap 5 detik
</script>


<style>

.inset h2 {
    color: #444444;
    text-shadow: -1px -1px 1px #000, 1px 1px 1px #ccc;
}
.inset p {
    background: #CCCCCC;
    text-shadow: 0 1px 0 #FFFFFF;
}
.neon {
    color: #D0F8FF;
    text-shadow: 0 0 5px #A5F1FF, 0 0 10px #A5F1FF,
             0 0 20px #A5F1FF, 0 0 30px #A5F1FF,
             0 0 40px #A5F1FF;
}
.threed {
    color: #CCCCCC;
    text-shadow: 0 1px 0 #999999, 0 2px 0 #888888,
             0 3px 0 #777777, 0 4px 0 #666666,
             0 5px 0 #555555, 0 6px 0 #444444,
             0 7px 0 #333333, 0 8px 7px rgba(0, 0, 0, 0.4),
             0 9px 10px rgba(0, 0, 0, 0.2);
			 font-family:Arial, Helvetica, sans-serif;
			 font-size:30px;
}


.arial {
    text-shadow: 1px 1px 0 #FFFFFF, 2px 2px 0 #000000;
}
.castellar {
    color: #FFFFFF;
    text-shadow: -1px 0 0 #000000, 1px 1px 0 #000000,
             2px -1px 0 #000000, 3px 0 0 #000000;
			 font-size:24px;
			 font-family:"Lucida Sans Unicode", "Lucida Grande", sans-serif;
}
.castellar1 {
			 font-size:24px;
			 font-family:"Lucida Sans Unicode", "Lucida Grande", sans-serif;
}

.outline {
color: white;
    text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;
	font-family:Arial, Helvetica, sans-serif;
	font-size:40px;
}


.outline1 {
color: white;
    text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;
	font-family:"Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size:30px;
}





body {
background: linear-gradient(15deg, #CCFF33, white);

}

a:link {
    color: hotpink;
	text-decoration: none;
}

/* visited link */
a:visited {
    color: hotpink;
	text-decoration: none;
}

/* mouse over link */
a:hover {
    color: red;
}
</style>
<meta charset="utf-8">
</head>
	
<body >
<form name="form1" method="POST" action="">
<table width="100%" align="center">
  <tr>
    <td height="42" colspan="2" align="center" bgcolor="#CCFF33" class="outline" >DAFTAR KETERSEDIAAN TEMPAT TIDUR</br> &nbsp; <%=Ucase(ckantor)%> </br> <%=calamat1%> <%=calamat2%></td>
  </tr>
  <tr>

    <td height="700" valign="middle" width="50%">



<marquee scrollamount="3" direction="up" width="100%;" height="100%" align="center">
    <div id="tabelku">
</br>
<span class="outline1">PER GOLONGAN KELAS </span>
<table width="100%" border="5" bordercolor="#FFFFFF" >
     <tr class="castellar">
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">KELAS</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">JML</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">TER</br>PAKAI</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">KO</br>SONG</td>
    </tr>
   
    <% 
While ((Repeat1__numRows <> 0) AND (NOT tketersediantt.EOF)) 
%>
    <tr bgcolor="#FFFFCC" class="castellar1">
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="left"><%=(tketersediantt.Fields.Item("tersediantt").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt.Fields.Item("jumlahtt1").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt.Fields.Item("jumlahtt2").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt.Fields.Item("jumlahtt3").Value) %></td>
    </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tketersediantt.MoveNext()
Wend
%>
  </table>
  </BR>
<span class="outline1">PER RUANGAN </span>
<table width="100%" border="5" bordercolor="#FFFFFF" >
     <tr class="castellar">
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">KELAS</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">JML</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">TER</br>PAKAI</td>
      <td  bordercolor="#FFFFFF" bgcolor="#009900" align="center">KO</br>SONG</td>
    </tr>
   
    <% 
While ((Repeat1A__numRows <> 0) AND (NOT tketersediantt1.EOF)) 
%>
    <tr bgcolor="#FFFFCC" class="castellar1">
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="left"><%=(tketersediantt1.Fields.Item("kelas").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt1.Fields.Item("jumlahtt1").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt1.Fields.Item("jumlahtt2").Value) %></td>
      <td  bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="right"><%=(tketersediantt1.Fields.Item("jumlahtt3").Value) %></td>
    </tr>
    <% 
  Repeat1A__index=Repeat1A__index+1
  Repeat1A__numRows=Repeat1A__numRows-1
  tketersediantt1.MoveNext()
Wend
%>
  </table>

  
</div>
<br></marquee>   


    </td>
    

    <td valign="middle" width="40%">
    <video width="1000" height="720px" controls autoplay loop style="background:black">
      <source src="film01.mp4" type="video/mp4">
    </video>
    </td>

  </tr>


        <div  id="crespon">
                <input name="crespon" type="hidden" id="crespon" value="<%=crespon%>">         
        </div>

  <tr>
    <td height="32" colspan="3" align="center" bgcolor="#CCFF33"><span class="threed"> <%=ucase(csupport)%> </span><span class="castellar"> </span><span class="outline">  Design by : Kalboya@yahoo.com</span> </br>

</td>
  </tr>
</table>
</form>

</body>

</html>
<%
tketersediantt.Close()
Set tketersediantt = Nothing
%>

<%
tketersediantt1.Close()
Set tketersediantt1 = Nothing
%>
