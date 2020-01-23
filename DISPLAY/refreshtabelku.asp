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


<body>

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

  
</body>
<%
tketersediantt.Close()
Set tketersediantt = Nothing
%>

<%
tketersediantt1.Close()
Set tketersediantt1 = Nothing
%>
