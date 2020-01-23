<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/datarspermata.asp" -->
<!--#include file="Connections/datamysql.asp" -->

<%
Dim tkelas
Dim tkelas_cmd
Dim tkelas_numRows

Set tkelas_cmd = Server.CreateObject ("ADODB.Command")
tkelas_cmd.ActiveConnection = MM_datarspermata_STRING
tkelas_cmd.CommandText = "SELECT kkelas, kelas, coalesce(jmlbed,0) as jmlbed FROM rspermata.tkelas where tampil='Y' ORDER BY kriteria ASC" 
tkelas_cmd.Prepared = true

Set tkelas = tkelas_cmd.Execute
tkelas_numRows = 0
%>

<%
Dim trawatpasien
Dim trawatpasien_numRows

Set trawatpasien = Server.CreateObject("ADODB.Recordset")
trawatpasien.ActiveConnection = MM_datarspermata_STRING
trawatpasien.Source = "SELECT coalesce(count(notrans),0) as  jmlpasien, kkelas FROM rspermata.trawatpasien  WHERE statuspasien ='2' and (carakeluar='' or isnull(carakeluar)) group by kkelas"
trawatpasien.CursorType = 0
trawatpasien.CursorLocation = 2
trawatpasien.LockType = 1
trawatpasien.Open()

trawatpasien_numRows = 0
%>


<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
tkelas_numRows = tkelas_numRows + Repeat1__numRows
%>

<%
'session.Timeout=240
'SessionStateSection.Timeout="true" max="1000" timeout="00:10:00"
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>RS Permata</title>
	
<style type="text/css">
.style12 {font-size: 24px; 	color:#FFF;
 font-family: Geneva, Arial, Helvetica, sans-serif; }
.style13 {color: #333333; font-family: Verdana, Arial, Helvetica, sans-serif; }
.style14 {font-size: 15px; 	color:#000; font-family: Geneva, Arial, Helvetica, sans-serif; }
.style15 {font-size: 15px; 	color:#FFF; font-family: Geneva, Arial, Helvetica, sans-serif; }
.style16 {font-size: 18px; 	color:#000; font-family: Geneva, Arial, Helvetica, sans-serif; }
.style17 {font-size: 20px; 	color:#000; font-family:Arial, Helvetica, sans-serif; }
.style18 {font-size: 20px; 	color:#000; font-family: "Brush Script MT"; }

.style2 {	font-size: 16px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	color: #003333;
}
body {
	background-color: #FFC;
}
</style>
</head>
<body>
<div align="center">
					    <table width="90%">
					      <tr>
					        <td colspan="3" align="center" class="flexslider">&nbsp;</td>
				          </tr>
					      <tr>
					        <td colspan="3" align="center" class="flexslider"><span class="active"><span class="style12"><img src="template/templat05/css/images/logo.png" width="482" height="113" usemap="#Map"></span></span></td>
				          </tr>
					      <tr>
					        <td colspan="3" align="center" class="flexslider">&nbsp;</td>
				          </tr>
					      <tr>
					        <td width="44%" rowspan="2" align="right"><img src="icon/cover.jpg" width="283" height="213"></td>
					        <td width="4%" align="left" valign="bottom">&nbsp;</td>
					        <td width="52%" height="108" align="left" valign="bottom"><p><span class="style17">dr. Zufrial Arief, Sp.OG</br>
					        </span>				            <span class="style18">Spesialis Kandungan</span></p></td>
				          </tr>
					      <tr>
					        <td align="left" valign="top">&nbsp;</td>
					        <td align="left" valign="top"><span class="style18">Alamat</span> : Desa Gumayun No. 33 Rt. 08 Rw. 03 Gumayun </br>DukuhwaruTegal Telp. 0283-6196365</td>
				          </tr>
				        </table>
					    <table width="70%">
					      <tr>
					        <td colspan="2" align="center" class="style14">&nbsp;</td>
				          </tr>
					      <tr>
					        <td colspan="2" align="center" class="style14"><span class="style16">Informasi Jadwal Praktek Dokter</span></td>
				          </tr>
					      </table>
					    <table width="50%" border="1">
					      <tr class="style15">
					        <td width="29%" align="center" bgcolor="#6F9846">&nbsp;</td>
					        <td width="16%" align="center" bgcolor="#6F9846" class="style14"><span class="style15">Pagi</span></td>
					        <td width="18%" align="center" bgcolor="#6F9846" class="style15">Sore</td>
				          </tr>
					      <tr>
					        <td align="center" bgcolor="#FFFFFF" class="style14">- Senin sampai Sabtu</td>
					        <td align="center" bgcolor="#FFFFFF" class="style14">06.00 - 08.00</td>
					        <td align="center" bgcolor="#FFFFFF" class="style14">16.00 - 20.00</td>
				          </tr>
					      <tr>
					        <td align="center" bgcolor="#FFFFFF" class="style14">- Hari Minggu / hari besar</td>
					        <td align="center" bgcolor="#FFFFFF" class="style14">Libur</td>
					        <td align="center" bgcolor="#FFFFFF"><span class="style14">Libur</span></td>
				          </tr>
				        </table>
					    <table width="70%">
					      <tr>
					        <td colspan="2" align="center" class="style14">&nbsp;</td>
				          </tr>
					      <tr>
					        <td colspan="2" align="center" class="style14"><span class="style16">Informasi Ketersediaan Ruang Rawat Inap</span></td>
				          </tr>
                        </table>
					    <table width="50%" border="1">
					      <tr class="style15">
					        <td width="43%" align="center" bgcolor="#6F9846">Kamar</td>
					        <td width="57%" align="center" bgcolor="#6F9846">Jumlah Tempat Tidur Tersedia</td>
				          </tr>
                          <% 
While ((Repeat1__numRows <> 0) AND (NOT tkelas.EOF))

ckkelas=(tkelas.Fields.Item("kelas").Value)
cjmlbed=cstr(tkelas.Fields.Item("jmlbed").Value)
cjmlkamarkosong=cjmlbed 

While (NOT trawatpasien.EOF)
if (tkelas.Fields.Item("kkelas").Value)=(trawatpasien.Fields.Item("kkelas").Value) Then 
	cjmlpasien=cstr(trawatpasien.Fields.Item("jmlpasien").Value)
	cjmlkamarkosong=cjmlbed-cjmlpasien
end if
  trawatpasien.MoveNext()
Wend
If (trawatpasien.CursorType > 0) Then
  trawatpasien.MoveFirst
Else
  trawatpasien.Requery
End If

%>
  <tr class="style14">
    <td align="center" bgcolor="#FFFFFF"><%=(tkelas.Fields.Item("kelas").Value)%></td>
    <td align="center" bgcolor="#FFFFFF"><%=(cjmlkamarkosong)%> tempat tidur</td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  tkelas.MoveNext()
Wend
%>

                        </table>
					    <table width="70%">
					      <tr>
					        <td colspan="2" align="center" class="style14">&nbsp;</td>
				          </tr>
					      <tr>
					        <td colspan="2" align="center" class="style14"><span class="style16">Kami siap memberikan pelayanan kesehatan:</span></td>
				          </tr>
  </table>
					    <table width="50%" border="1">
					      <tr class="style15">
					        <td width="7%" align="center" bgcolor="#6F9846">No</td>
					        <td width="93%" align="center" bgcolor="#6F9846" class="style14"><span class="style15">Pelayanan</span></td>
				          </tr>
					      <tr>
					        <td align="center" bgcolor="#FFFFFF" class="style14">1</td>
					        <td align="left" bgcolor="#FFFFFF" class="style14">Rawat jalan termasuk ANC, Intranatal, Post Natal, KB dan Bayi</td>
				          </tr>
					      <tr>
					        <td align="center" bgcolor="#FFFFFF" class="style14">2</td>
					        <td align="left" bgcolor="#FFFFFF" class="style14">Rawat inap termasuk bersalin dan kehamilan dengan patologi</td>
				          </tr>
					      <tr>
					        <td align="center" bgcolor="#FFFFFF" class="style14">3</td>
					        <td align="left" bgcolor="#FFFFFF" class="style14">Pemeriksaan penunjang (Laboratorium &amp; Instalasi Farmasi)</td>
				          </tr>
				        </table>
					    <p>&nbsp;</p>
  <p>&nbsp;</p>
  
  
</div>

<map name="Map">
  <area shape="rect" coords="125,24,250,64" href="index.asp">
</map>
</body>
</html>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
trawatpasien.Close()
Set trawatpasien = Nothing
%>
