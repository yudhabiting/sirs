<!--#include file="../../Connections/datarspermata.asp" -->
<%
  dim cjmltanggal,ctgltrans2,ctgltrans1
    cbulan=month(date)
  if len(cbulan)=1 then
	cbulan="0"&cbulan
  end if
  ctahun=year(date)
  dtgltrans1=01
  if len(dtgltrans1)=1 then
	dtgltrans1="0"&dtgltrans1
  end if
  dtgltrans2=day(date)
  if len(dtgltrans2)=1 then
	dtgltrans2="0"&dtgltrans2
  end if

  dtgltrans1=(ctahun&"-"&cbulan&"-"&dtgltrans1)
  dtgltrans2=(ctahun&"-"&cbulan&"-"&dtgltrans2)

  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datasik_STRING
  set tnourut2=tnourut1.execute ("SELECT DATEDIFF('"&dtgltrans2&"','"&dtgltrans1&"') as jumlahtanggal") 

  cjmltanggal=tnourut2("jumlahtanggal")
%>

<%
Dim tbulan
Dim tbulan_numRows

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datarspermata_STRING
tbulan.Source = "SELECT revenue,overhead,kolom3 from tbulan"
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

'Pemasukan
rettxt = "["
While (NOT tbulan.EOF)
	rettxt = rettxt & tbulan.Fields.Item("revenue").Value & ","
	tbulan.MoveNext()
	Wend
If (tbulan.CursorType > 0) Then
	tbulan.MoveFirst
Else
	tbulan.Requery
End If
rettxt = left(rettxt,len(rettxt)-1) &  "]"


'Pengeluaran
rettxt1 = "["
While (NOT tbulan.EOF)
	rettxt1 = rettxt1 & tbulan.Fields.Item("overhead").Value & ","
	tbulan.MoveNext()
	Wend
If (tbulan.CursorType > 0) Then
	tbulan.MoveFirst
Else
	tbulan.Requery
End If
rettxt1 = left(rettxt1,len(rettxt1)-1) &  "]"


'Total
rettxt3 = "["
While (NOT tbulan.EOF)
	rettxt3 = rettxt3 & tbulan.Fields.Item("kolom3").Value & ","
	tbulan.MoveNext()
	Wend
If (tbulan.CursorType > 0) Then
	tbulan.MoveFirst
Else
	tbulan.Requery
End If
rettxt3 = left(rettxt3,len(rettxt3)-1) &  "]"


tbulan.Close()
Set tbulan = Nothing
%>
