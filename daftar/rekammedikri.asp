<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
'Response.ContentType = "application/vnd.ms-excel"
'Response.AddHeader "Content-Disposition", "attachment; filename=cobaexcel.xls"
'Response.ContentType = "application/msword"
'Response.AddHeader "Content-Disposition", "attachment; filename=cobaword.doc"
%>

<%
' *** Logout the current user.
MM_Logout = CStr(Request.ServerVariables("URL")) & "?MM_Logoutnow=1"
If (CStr(Request("MM_Logoutnow")) = "1") Then
  Session.Contents.Remove("MM_Username")
  Session.Contents.Remove("MM_UserAuthorization")
  MM_logoutRedirectPage = "../index.asp"
  ' redirect with URL parameters (remove the "MM_Logoutnow" query param).
  if (MM_logoutRedirectPage = "") Then MM_logoutRedirectPage = CStr(Request.ServerVariables("URL"))
  If (InStr(1, UC_redirectPage, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
    MM_newQS = "?"
    For Each Item In Request.QueryString
      If (Item <> "MM_Logoutnow") Then
        If (Len(MM_newQS) > 1) Then MM_newQS = MM_newQS & "&"
        MM_newQS = MM_newQS & Item & "=" & Server.URLencode(Request.QueryString(Item))
      End If
    Next
    if (Len(MM_newQS) > 1) Then MM_logoutRedirectPage = MM_logoutRedirectPage & MM_newQS
  End If
  Response.Redirect(MM_logoutRedirectPage)
End If
%>
<!--#include file="../Connections/datarumahsakit.asp" -->
<!--#include file="../Connections/dataapotik.asp" -->
<!--#include file="../Connections/datalaboratorium.asp" -->
<%
Dim tpenyakit
Dim tpenyakit_numRows

Set tpenyakit = Server.CreateObject("ADODB.Recordset")
tpenyakit.ActiveConnection = MM_datarumahsakit_STRING
tpenyakit.Source = "SELECT * FROM rumahsakit.tpenyakit ORDER BY penyakit ASC"
tpenyakit.CursorType = 0
tpenyakit.CursorLocation = 2
tpenyakit.LockType = 1
tpenyakit.Open()

tpenyakit_numRows = 0
%>
<%
Dim tpasienri__MMColParam
tpasienri__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tpasienri__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tpasienri
Dim tpasienri_numRows

Set tpasienri = Server.CreateObject("ADODB.Recordset")
tpasienri.ActiveConnection = MM_datarumahsakit_STRING
tpasienri.Source = "SELECT * FROM rumahsakit.tpasienri WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'"
tpasienri.CursorType = 0
tpasienri.CursorLocation = 2
tpasienri.LockType = 1
tpasienri.Open()

tpasienri_numRows = 0
%>
<%
Dim tkelas
Dim tkelas_numRows

Set tkelas = Server.CreateObject("ADODB.Recordset")
tkelas.ActiveConnection = MM_datarumahsakit_STRING
tkelas.Source = "SELECT * FROM rumahsakit.tkelas"
tkelas.CursorType = 0
tkelas.CursorLocation = 2
tkelas.LockType = 1
tkelas.Open()

tkelas_numRows = 0
%>
<%
Dim tpegawai__MMColParam
tpegawai__MMColParam = "02"
If (Request("MM_EmptyValue") <> "") Then 
  tpegawai__MMColParam = Request("MM_EmptyValue")
End If
%>
<%
Dim tpegawai
Dim tpegawai_numRows

Set tpegawai = Server.CreateObject("ADODB.Recordset")
tpegawai.ActiveConnection = MM_datarumahsakit_STRING
tpegawai.Source = "SELECT nourut, nip, nama FROM rumahsakit.tpegawai WHERE bagian = '" + Replace(tpegawai__MMColParam, "'", "''") + "' ORDER BY nama ASC"
tpegawai.CursorType = 0
tpegawai.CursorLocation = 2
tpegawai.LockType = 1
tpegawai.Open()

tpegawai_numRows = 0
%>
<%
Dim ttind_ugd
Dim ttind_ugd_numRows

Set ttind_ugd = Server.CreateObject("ADODB.Recordset")
ttind_ugd.ActiveConnection = MM_datarumahsakit_STRING
ttind_ugd.Source = "SELECT * FROM rumahsakit.ttind_ugd ORDER BY tindakan ASC"
ttind_ugd.CursorType = 0
ttind_ugd.CursorLocation = 2
ttind_ugd.LockType = 1
ttind_ugd.Open()

ttind_ugd_numRows = 0
%>
<%
Dim triugd
Dim triugd_numRows

Set triugd = Server.CreateObject("ADODB.Recordset")
triugd.ActiveConnection = MM_datarumahsakit_STRING
triugd.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket, tindakan  FROM rumahsakit.triugd  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  ORDER BY tgltrans,nourut ASC"
triugd.CursorType = 0
triugd.CursorLocation = 2
triugd.LockType = 1
triugd.Open()

triugd_numRows = 0
%>
<%
Dim ttind_keperawatan
Dim ttind_keperawatan_numRows

Set ttind_keperawatan = Server.CreateObject("ADODB.Recordset")
ttind_keperawatan.ActiveConnection = MM_datarumahsakit_STRING
ttind_keperawatan.Source = "SELECT * FROM rumahsakit.ttind_keperawatan ORDER BY tindakan ASC"
ttind_keperawatan.CursorType = 0
ttind_keperawatan.CursorLocation = 2
ttind_keperawatan.LockType = 1
ttind_keperawatan.Open()

ttind_keperawatan_numRows = 0
%>
<%
Dim trikeperawatan
Dim trikeperawatan_numRows

Set trikeperawatan = Server.CreateObject("ADODB.Recordset")
trikeperawatan.ActiveConnection = MM_datarumahsakit_STRING
trikeperawatan.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket, tindakan,ketobat  FROM rumahsakit.trikeperawatan  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  ORDER BY tgltrans,nourut ASC"
trikeperawatan.CursorType = 0
trikeperawatan.CursorLocation = 2
trikeperawatan.LockType = 1
trikeperawatan.Open()

trikeperawatan_numRows = 0
%>
<%
Dim trimedis
Dim trimedis_numRows

Set trimedis = Server.CreateObject("ADODB.Recordset")
trimedis.ActiveConnection = MM_datarumahsakit_STRING
trimedis.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, tindakan, tarif, ket, kpegawai, nama  FROM rumahsakit.trimedis  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  ORDER BY tgltrans,nourut ASC"
trimedis.CursorType = 0
trimedis.CursorLocation = 2
trimedis.LockType = 1
trimedis.Open()

trimedis_numRows = 0
%>
<%
Dim ttind_pp
Dim ttind_pp_numRows

Set ttind_pp = Server.CreateObject("ADODB.Recordset")
ttind_pp.ActiveConnection = MM_datarumahsakit_STRING
ttind_pp.Source = "SELECT * FROM rumahsakit.ttind_pp ORDER BY tindakan ASC"
ttind_pp.CursorType = 0
ttind_pp.CursorLocation = 2
ttind_pp.LockType = 1
ttind_pp.Open()

ttind_pp_numRows = 0
%>
<%
Dim tripp
Dim tripp_numRows

Set tripp = Server.CreateObject("ADODB.Recordset")
tripp.ActiveConnection = MM_datarumahsakit_STRING
tripp.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, ktindakan, tarif, ket,hasil, tindakan  FROM rumahsakit.tripp  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  and ktindakan<>'005' ORDER BY tgltrans,nourut ASC"
tripp.CursorType = 0
tripp.CursorLocation = 2
tripp.LockType = 1
tripp.Open()

tripp_numRows = 0
%>
<%
Dim trikelas
Dim trikelas_numRows

Set trikelas = Server.CreateObject("ADODB.Recordset")
trikelas.ActiveConnection = MM_datarumahsakit_STRING
trikelas.Source = "SELECT notrans, date_format(tglmasuk, '%Y/%m/%d') as tglmasuk, date_format(tglkeluar, '%Y/%m/%d') as tglkeluar, jmlhari, nourut, kkelas, case tarif is not null when 0 then 0 else tarif end as tarif, ket, kelas,administrasi  FROM rumahsakit.trikelas  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  ORDER BY tglmasuk,nourut ASC"
trikelas.CursorType = 0
trikelas.CursorLocation = 2
trikelas.LockType = 1
trikelas.Open()

trikelas_numRows = 0
%>
<%
Dim tvisite
Dim tvisite_numRows

Set tvisite = Server.CreateObject("ADODB.Recordset")
tvisite.ActiveConnection = MM_datarumahsakit_STRING
tvisite.Source = "SELECT * FROM rumahsakit.tvisite ORDER BY kvisite ASC"
tvisite.CursorType = 0
tvisite.CursorLocation = 2
tvisite.LockType = 1
tvisite.Open()

tvisite_numRows = 0
%>
<%
Dim trivisite
Dim trivisite_numRows

Set trivisite = Server.CreateObject("ADODB.Recordset")
trivisite.ActiveConnection = MM_datarumahsakit_STRING
trivisite.Source = "SELECT notrans, date_format(tgltrans, '%Y/%m/%d') as tgltrans, nourut, kvisite, tarif, ket, kpegawai, nama  FROM rumahsakit.trivisite  WHERE notrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'  ORDER BY tgltrans ASC"
trivisite.CursorType = 0
trivisite.CursorLocation = 2
trivisite.LockType = 1
trivisite.Open()

trivisite_numRows = 0
%>
<%
Dim tkeluarobat1
Dim tkeluarobat1_numRows

Set tkeluarobat1 = Server.CreateObject("ADODB.Recordset")
tkeluarobat1.ActiveConnection = MM_dataapotik_STRING
'tkeluarobat.Source = "SELECT *,date_format(tglkeluar, '%d/%m/%Y') as tglkeluar,coalesce(potongan,0) as potongan,coalesce(btindakan,0) as btindakan,coalesce(sum(total),0) as total,coalesce(totalbayar,0) as totalbayar  FROM apotik.tkeluarobat  WHERE knotrans = '" + Replace(tkeluarobat__MMColParam, "'", "''") + "' group by total"
tkeluarobat1.Source = "SELECT notrans,date_format(tglkeluar, '%Y/%m/%d') as tglkeluar FROM apotik.tkeluarobat  WHERE knotrans = '" + Replace(tpasienri__MMColParam, "'", "''") + "'"
tkeluarobat1.CursorType = 0
tkeluarobat1.CursorLocation = 2
tkeluarobat1.LockType = 1
tkeluarobat1.Open()
tkeluarobat1_numRows = 0
%>
<%
Dim titemkeluarobat__MMColParam
titemkeluarobat__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  titemkeluarobat__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim titemkeluarobat
Dim titemkeluarobat_numRows

Set titemkeluarobat = Server.CreateObject("ADODB.Recordset")
titemkeluarobat.ActiveConnection = MM_dataapotik_STRING
titemkeluarobat.Source = "SELECT notrans FROM apotik.titemkeluarobat WHERE notrans = '" + Replace(titemkeluarobat__MMColParam, "'", "''") + "'"
titemkeluarobat.CursorType = 0
titemkeluarobat.CursorLocation = 2
titemkeluarobat.LockType = 1
titemkeluarobat.Open()

titemkeluarobat_numRows = 0
%>

<%
Dim Repeat0__numRows
Dim Repeat0__index

Repeat0__numRows = -1
Repeat0__index = 0
trikelas_numRows = trikelas_numRows + Repeat0__numRows
%>


<%
Dim tinputlaborat1__MMColParam
tinputlaborat1__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputlaborat1__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputlaborat11
Dim tinputlaborat11_numRows

Set tinputlaborat11 = Server.CreateObject("ADODB.Recordset")
tinputlaborat11.ActiveConnection = MM_datalaboratorium_STRING
tinputlaborat11.Source = "SELECT date_format(tgltrans, '%d/%m/%Y') as tgltrans,notrans  FROM laboratorium.tinputlaborat1  WHERE knotrans = '" + Replace(tinputlaborat1__MMColParam, "'", "''") + "'"
tinputlaborat11.CursorType = 0
tinputlaborat11.CursorLocation = 2
tinputlaborat11.LockType = 1
tinputlaborat11.Open()
tinputlaborat11_numRows = 0
%>
<%
Dim tinputlaborat2__MMColParam
tinputlaborat2__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputlaborat2__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputlaborat2
Dim tinputlaborat2_numRows

Set tinputlaborat2 = Server.CreateObject("ADODB.Recordset")
tinputlaborat2.ActiveConnection = MM_datalaboratorium_STRING
tinputlaborat2.Source = "SELECT notrans  FROM laboratorium.tinputlaborat2  WHERE notrans = '" + Replace(tinputlaborat2__MMColParam, "'", "''") + "'"
tinputlaborat2.CursorType = 0
tinputlaborat2.CursorLocation = 2
tinputlaborat2.LockType = 1
tinputlaborat2.Open()

tinputlaborat2_numRows = 0
%>
<%
Dim trontgenpasien
Dim trontgenpasien_numRows

Set trontgenpasien = Server.CreateObject("ADODB.Recordset")
trontgenpasien.ActiveConnection = MM_datarumahsakit_STRING
trontgenpasien.Source = "SELECT tgltrans, jenispemeriksaan, hasil, anjuran,kpemeriksaan FROM rumahsakit.trontgenpasien WHERE knotrans = '" + Replace(tinputlaborat2__MMColParam, "'", "''") + "' and ktujuan=13"
trontgenpasien.CursorType = 0
trontgenpasien.CursorLocation = 2
trontgenpasien.LockType = 1
trontgenpasien.Open()

trontgenpasien_numRows = 0
%>
<%
Dim tgolongan
Dim tgolongan_numRows

Set tgolongan = Server.CreateObject("ADODB.Recordset")
tgolongan.ActiveConnection = MM_datalaboratorium_STRING
tgolongan.Source = "SELECT * FROM laboratorium.tgollab ORDER BY kgolongan ASC"
tgolongan.CursorType = 0
tgolongan.CursorLocation = 2
tgolongan.LockType = 1
tgolongan.Open()

tgolongan_numRows = 0
%>
<%
Dim ttindlab1
Dim ttindlab1_numRows

Set ttindlab1 = Server.CreateObject("ADODB.Recordset")
ttindlab1.ActiveConnection = MM_datalaboratorium_STRING
ttindlab1.Source = "SELECT KLABORATORIUM, SATUAN, NORMAL FROM laboratorium.ttindlab"
ttindlab1.CursorType = 0
ttindlab1.CursorLocation = 2
ttindlab1.LockType = 1
ttindlab1.Open()

ttindlab1_numRows = 0
%>

<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
trikeperawatan_numRows = trikeperawatan_numRows + Repeat1__numRows
%>

<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = -1
Repeat2__index = 0
triugd_numRows = triugd_numRows + Repeat2__numRows
%>
<%
Dim Repeat3__numRows
Dim Repeat3__index

Repeat3__numRows = -1
Repeat3__index = 0
trimedis_numRows = trimedis_numRows + Repeat3__numRows
%>
<%
Dim Repeat4__numRows
Dim Repeat4__index

Repeat4__numRows = -1
Repeat4__index = 0
tripp_numRows = tripp_numRows + Repeat4__numRows
%>
<%
Dim Repeat5__numRows
Dim Repeat5__index

Repeat5__numRows = -1
Repeat5__index = 0
trivisite_numRows = trivisite_numRows + Repeat5__numRows
%>
<%
Dim Repeat6__numRows
Dim Repeat6__index

Repeat6__numRows = -1
Repeat6__index = 0
tkeluarobat6_numRows = tkeluarobat6_numRows + Repeat6__numRows
%>

<%
Dim Repeat7__numRows
Dim Repeat7__index

Repeat7__numRows = -1
Repeat7__index = 0
trontgentpsien7_numRows = trontgentpsien7_numRows + Repeat7__numRows
%>


<html>
<head>
<title>Catatan Medik</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--


function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
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

<script language="VBScript">
<!--
	sub simpan_onclick()
			form1.submit
	end sub
	sub window_onload()
		dim hrdate,blndate,thndate,mydate,fdate
		fdate=setlocale("en-za")
		hrdate=day(form1.ctglmasuk.value)
		blndate=month(form1.ctglmasuk.value)
		thndate=year(form1.ctglmasuk.value)
		mydate=dateserial(thndate,blndate,hrdate)
		form1.ctglmasuk.value=formatdatetime(mydate,vbShortDate)
		hrdate=day(form1.ctglkeluar.value)
		blndate=month(form1.ctglkeluar.value)
		thndate=year(form1.ctglkeluar.value)
		mydate=dateserial(thndate,blndate,hrdate)
		form1.ctglkeluar.value=formatdatetime(mydate,vbShortDate)

	end sub	
-->
</script>
<style type="text/css">
<!--
.style16 {font-family: Arial, Helvetica, sans-serif}
.style33 {font-family: "Lucida Sans"; font-size: 9px; color: #000000;}
.style50 {	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 12px;
}
.style40 {font-size: 12px}
.style41 {
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.style37 {color: #000000}
.style59 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000; font-weight: bold; }
.style61 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #000000; }
.style62 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style67 {font-size: 10px}
.style78 {color: #000000; font-weight: bold; font-family: Arial, Helvetica, sans-serif;}
.style79 {font-size: 14px}
-->
</style>
</head>

<body onLoad="MM_preloadImages('../jpg/rekammedik1.jpg','../jpg/ruang1.jpg','../jpg/visitedokter1.jpg','../jpg/tindakan.jpg');MM_showHideLayers('Layertindakan','','inherit')" onClick="MM_showHideLayers('Layertindakan','','inherit')">
<table width="100%">
  <tr align="center">
    <td width="24%"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">No 
      Transaksi</font></div></td>
    <td width="76%"><div align="left"><font color="#000000" size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("notrans").Value)%> </font></div></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Nocm</font></div></td>
    <td><font size="2" face="Lucida Console">: <font color="#000000"> <strong><%=(tpasienri.Fields.Item("nocm").Value)%></strong> </font></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Lucida Console">No Registrasi</font></div></td>
    <td><font size="2" face="Lucida Console">: </font><font color="#000000" size="2" face="Lucida Console"><%=(tpasienri.Fields.Item("noreg").Value)%></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Nama</font></div></td>
    <td><font size="2" face="Lucida Console">: <strong><%=(tpasienri.Fields.Item("nama").Value)%></strong></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Alamat</font></div></td>
    <td><font size="2" face="Lucida Console"> : <%=(tpasienri.Fields.Item("alamat").Value)%></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Umur </font></div></td>
    <td><font size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("umurthn").Value)%> tahun / <%=(tpasienri.Fields.Item("umurbln").Value)%> bulan / <%=(tpasienri.Fields.Item("umurhr").Value)%> hari</font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Jenis 
      Kelamin</font></div></td>
    <td><font size="2" face="Lucida Console">:
      <%
if tpasienri.Fields.Item("jeniskel").Value ="L"  Then
	response.Write("Laki-laki")
else
	response.Write("Perempuan")
end if 
%>
    </font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Gejala 
      yang dirasakan</font></div></td>
    <td><font size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("gejala").Value)%></font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Diagnosa 
      Penyakit Masuk</font></div></td>
    <td><font size="2" face="Lucida Console">:
      <%
While (NOT tpenyakit.EOF)
if tpenyakit.Fields.Item("kpenyakit").Value=tpasienri.Fields.Item("kpenyakit1").Value Then 
	 response.Write(tpenyakit.Fields.Item("penyakit").Value)
end if
  tpenyakit.MoveNext()
Wend
If (tpenyakit.CursorType > 0) Then
  tpenyakit.MoveFirst
Else
  tpenyakit.Requery
End If
%>
    </font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Diagnosa 
      Penyakit Keluar</font></div></td>
    <td><font size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("kpenyakit2").Value)%> </font></td>
  </tr>
  <tr>
    <td align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Komplikasi</font></div></td>
    <td><font size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("komplikasi").Value)%> </font></td>
  </tr>
  <tr>
    <td height="32" align="center"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">Penyebab 
      luar cedera &amp; keracunan/morfologi neoflasma</font></div></td>
    <td><font size="2" face="Lucida Console">: <%=(tpasienri.Fields.Item("penyebab").Value)%> </font></td>
  </tr>
</table>
<hr>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Ruangan :</a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="10%" height="22" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Tgl 
    Masuk </font></strong></div></td>
    <td width="10%" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Tgl 
      Keluar</font></strong></div></td>
    <td width="35%" bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Ruangan 
    </font></strong></div></td>
    <td width="10%" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Jml 
    Hari</font></strong></div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Keterangan</font></strong></div></td>
  </tr>
    <% 
While ((Repeat0__numRows <> 0) AND (NOT trikelas.EOF)) 
%>
    <tr>
      <td height="23"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%=DoDateTime((trikelas.Fields.Item("tglmasuk").Value), 2, 1030)%></font></div></td>
      <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trikelas.Fields.Item("tglkeluar").Value)%></font></div></td>
      <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"> <%=(trikelas.Fields.Item("kelas").Value)%></font></div></td>
      <td> <div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trikelas.Fields.Item("jmlhari").Value)%> </font></div></td>
      <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trikelas.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat0__index=Repeat0__index+1
  Repeat0__numRows=Repeat0__numRows-1
  trikelas.MoveNext()
Wend
%>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Obat    :</a></font></strong></p>
<table width="100%" border="1">
  <tr>
    <td width="15%" bgcolor="#CCCCCC"><div align="center" class="style33 style50 style70 style16">
      <div align="left">
        <div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong> Tanggal</strong></font></div>
      </div>
    </div></td>
    <td width="50%" bgcolor="#CCCCCC"><div align="center" class="style59 style70 style16 style40 style41">
      <div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Obat</strong></font></div>
    </div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="center" class="style50 style70 style16">
      <div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong> Jumlah Biji </strong></font></div>
    </div></td>
  </tr>
  <tr>
    <td colspan="3"></td>
  </tr>
  <% 
While ((Repeat6__numRows <> 0) AND (NOT tkeluarobat1.EOF)) 
	 titemkeluarobat.close
	 titemkeluarobat.Source = " select titemkeluarobat.kobat,titemkeluarobat.kgolobat,titemkeluarobat.jmlbiji,titemkeluarobat.subtotal,tmasterobat.namaobat From titemkeluarobat Inner Join tmasterobat ON titemkeluarobat.kobat = tmasterobat.kobat  WHERE  titemkeluarobat.notrans='"&(tkeluarobat1.Fields.Item("notrans").Value)&"'"
	 titemkeluarobat.open
	 While (NOT titemkeluarobat.EOF)
	 %>
  <tr>
    <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((tkeluarobat1.Fields.Item("tglkeluar").Value), 2, 1030) %> </font></div></td>
    <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(titemkeluarobat.Fields.Item("namaobat").Value)%></font></div></td>
    <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= FormatNumber((titemkeluarobat.Fields.Item("jmlbiji").Value), 0, -2, -2, -1) %></font></div></td>
  </tr>
  <%
	  titemkeluarobat.MoveNext()
	  Wend
	  If (titemkeluarobat.CursorType > 0) Then
		titemkeluarobat.MoveFirst
	  Else
		 titemkeluarobat.Requery
	  End If
	  	
	Repeat6__index=Repeat6__index+1
	Repeat6__numRows=Repeat6__numRows-1
	tkeluarobat1.MoveNext()
Wend

%>
  <tr>
    <td colspan="3"></td>
  </tr>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Visite Dokter   :</a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#CCCCCC"><div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Visite 
      Dokter </strong></font></div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
  <% 
While ((Repeat5__numRows <> 0) AND (NOT trivisite.EOF)) 
%>
  <tr>
    <td height="23"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((trivisite.Fields.Item("tgltrans").Value), 2, 1030) %> </font></div></td>
    <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif">
      <%
While (NOT tvisite.EOF)
If (trivisite.Fields.Item("kvisite").Value)=(tvisite.Fields.Item("kvisite").Value) then
	response.Write(tvisite.Fields.Item("visite").Value)
end if
  tvisite.MoveNext()
Wend
If (tvisite.CursorType > 0) Then
  tvisite.MoveFirst
Else
  tvisite.Requery
End If
%>
      </select>
      Dokter : <%=(trivisite.Fields.Item("nama").Value)%></font></div></td>
    <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trivisite.Fields.Item("ket").Value)%></font></div></td>
  </tr>
  <% 
  Repeat5__index=Repeat5__index+1
  Repeat5__numRows=Repeat5__numRows-1
  trivisite.MoveNext()
Wend
%>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Tindakan Ugd : </a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#CCCCCC"><div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Tindakan 
      </strong></font><strong><font size="2" face="Arial, Helvetica, sans-serif">Ugd</font></strong></div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
    <% 
While ((Repeat2__numRows <> 0) AND (NOT triugd.EOF)) 
%>
    <tr>
      <td height="23"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((triugd.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td><font size="2" face="Arial, Helvetica, sans-serif"><%=(triugd.Fields.Item("tindakan").Value)%></font></td>
      <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(triugd.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat2__index=Repeat2__index+1
  Repeat2__numRows=Repeat2__numRows-1
  triugd.MoveNext()
Wend
%>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Tindakan Keperawatan : </a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#CCCCCC"><div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Tanggal</strong></font></div></td>
    <td width="50%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Tindakan 
    </strong></font> <strong><font size="2" face="Arial, Helvetica, sans-serif">Keperawatan</font></strong></div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Obat / Keterangan</strong></font></div></td>
  </tr>
    <% 
While ((Repeat1__numRows <> 0) AND (NOT trikeperawatan.EOF)) 
%>
    <tr>
      <td height="23"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((trikeperawatan.Fields.Item("tgltrans").Value), 2, 2070) %> </font></div></td>
      <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trikeperawatan.Fields.Item("tindakan").Value)%></font></div></td>
      <td><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"> <%=(trikeperawatan.Fields.Item("ketobat").Value)%> <strong>Ket</strong> <strong>:</strong> <%=(trikeperawatan.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  trikeperawatan.MoveNext()
Wend
%>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Tindakan Medis : </a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#CCCCCC"><div align="center"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Tanggal</font></strong></font></div></td>
    <td width="50%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Tindakan 
    Medis</font></strong></font></div></td>
    <td width="32%" bgcolor="#CCCCCC"><div align="left"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><strong>Keterangan</strong></font></div></td>
  </tr>
    <% 
While ((Repeat3__numRows <> 0) AND (NOT trimedis.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"><%= DoDateTime((trimedis.Fields.Item("tgltrans").Value), 2, 2070) %> </font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trimedis.Fields.Item("tindakan").Value)%> Dokter : <%=(trimedis.Fields.Item("nama").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(trimedis.Fields.Item("ket").Value)%></font></div></td>
    </tr>
    <% 
  Repeat3__index=Repeat3__index+1
  Repeat3__numRows=Repeat3__numRows-1
  trimedis.MoveNext()
Wend
%>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Laboratorium  : </a></font></strong></p>
<table width="100%" border="1">
  <tr>
    <td width="15%" bgcolor="#CCCCCC"><div align="center" class="style70 style16 style78">
      <div align="left">
        <div align="center"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Tanggal</font></strong></font></div>
      </div>
    </div></td>
    <td bgcolor="#CCCCCC"><div align="center" class="style16">
      <div align="left"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Golongan</font></strong></font></div>
    </div></td>
    <td bgcolor="#CCCCCC"><div align="center" class="style70 style78 style16">
      <div align="left"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Laboratorium</font></strong></font></div>
    </div></td>
    <td bgcolor="#CCCCCC"><div align="center" class="style87 style70 style41 style16">
      <div align="center"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Hasil</font></strong></font></div>
    </div></td>
    <td bgcolor="#CCCCCC"><div align="center" class="style87 style70 style41 style16">
      <div align="center"><font color="#000000" face="Arial, Helvetica, sans-serif"><strong><font size="2">Normal</font></strong></font></div>
    </div></td>
  </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT tinputlaborat11.EOF)) 
	 tinputlaborat2.close
tinputlaborat2.Source = "SELECT tinputlaborat2.notrans,tinputlaborat2.nourut,tinputlaborat2.klaboratorium,tinputlaborat2.kgolongan,tinputlaborat2.hasil,ttindlab.laboratorium  FROM tinputlaborat2 Inner Join ttindlab ON tinputlaborat2.klaboratorium = ttindlab.klaboratorium  WHERE tinputlaborat2.notrans = '"&(tinputlaborat11.Fields.Item("notrans").Value)&"'  ORDER BY nourut"
	 
	 tinputlaborat2.open
	 While (NOT tinputlaborat2.EOF)
	 %>
  <tr>
    <td><div align="right" class="style61 style67 style70">
      <div align="center" class="style40"><%= DoDateTime((tinputlaborat11.Fields.Item("tgltrans").Value), 2, 1030) %></div>
    </div></td>
    <td><div align="left" class="style70 style16 style37"><span class="style20 style16 style40">
      <%
While (NOT tgolongan.EOF)
if tgolongan.Fields.Item("kgolongan").Value=tinputlaborat2.Fields.Item("kgolongan").Value Then 
	response.Write(tgolongan.Fields.Item("golongan").Value)
end if
  tgolongan.MoveNext()
Wend
If (tgolongan.CursorType > 0) Then
  tgolongan.MoveFirst
Else
  tgolongan.Requery
End If
%>
    </span></div></td>
    <td><span class="style70 style31 style16 style40"><%=trim(tinputlaborat2.Fields.Item("laboratorium").Value) %></span></td>
    <td><div align="center" class="style62"><span class="style31 "><%=trim(tinputlaborat2.Fields.Item("hasil").Value) %> <span class="style20">
      <%
While (NOT ttindlab1.EOF)
if ttindlab1.Fields.Item("klaboratorium").Value=tinputlaborat2.Fields.Item("klaboratorium").Value Then 
	csatuan=ttindlab1.Fields.Item("satuan").Value
	cnormal=ttindlab1.Fields.Item("normal").Value
end if
  ttindlab1.MoveNext()
Wend
If (ttindlab1.CursorType > 0) Then
 ttindlab1.MoveFirst
Else
  ttindlab1.Requery
End If
%>
    </span></span><span class="style20 style31 style37 "><%=csatuan %></span></div></td>
    <td><div align="center" class="style16 style70 style40"><span class="style16 style20 style31 style37"><%=cnormal %></span></div></td>
  </tr>
  <%
	  tinputlaborat2.MoveNext()
	  Wend
	  If (tinputlaborat2.CursorType > 0) Then
		tinputlaborat2.MoveFirst
	  Else
		 tinputlaborat2.Requery
	  End If
	  	
	Repeat1__index=Repeat1__index+1
	Repeat1__numRows=Repeat1__numRows-1
	tinputlaborat11.MoveNext()
Wend

%>
  <tr>
    <td colspan="5"></td>
  </tr>
</table>
<p><strong><font size="2" face="Arial, Helvetica, sans-serif"><a href="#">Pemeriksaan Penunjang  : </a></font></strong></p>
<table width="100%" border="1">
  <tr bgcolor="#FFFFCC">
    <td width="15%" bgcolor="#CCCCCC"><div align="center"><strong><font color="#000000" face="Arial, Helvetica, sans-serif"><font size="2">Tanggal</font></font></strong></div></td>
    <td bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000" face="Arial, Helvetica, sans-serif"><font size="2">      Pemeriksaan Penunjang</font></font></strong></div></td>
    <td bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Keterangan</font></strong></div></td>
    <td bgcolor="#CCCCCC"><div align="left"><strong><font color="#000000" size="2" face="Arial, Helvetica, sans-serif">Hasil Pembacaan </font></strong></div></td>
  </tr>
    <% 
While ((Repeat4__numRows <> 0) AND (NOT tripp.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((tripp.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(tripp.Fields.Item("tindakan").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left"><font size="2" face="Arial, Helvetica, sans-serif"><%=(tripp.Fields.Item("ket").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="justify"><font size="2" face="Arial, Helvetica, sans-serif"><%=(tripp.Fields.Item("hasil").Value)%></font></div></td>
    </tr>
    <% 
  Repeat4__index=Repeat4__index+1
  Repeat4__numRows=Repeat4__numRows-1
  tripp.MoveNext()
Wend
%>
    <% 
While ((Repeat7__numRows <> 0) AND (NOT trontgenpasien.EOF)) 
%>
    <tr>
      <td height="23" bgcolor="#FFFFFF"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif"> <%= DoDateTime((trontgenpasien.Fields.Item("tgltrans").Value), 2, 2070) %></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79"><font face="Arial, Helvetica, sans-serif">
	  <% 
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="1" then 
			response.Write("Rontgen")
	  end if
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="2" then 
			response.Write("USG")
	  end if
	  if (trontgenpasien.Fields.Item("kpemeriksaan").Value)="3" then 
			response.Write("CT - Scan")
	  end if
	  %>
      </font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79"><font face="Arial, Helvetica, sans-serif"><%=(trontgenpasien.Fields.Item("jenispemeriksaan").Value)%></font></div></td>
      <td bgcolor="#FFFFFF"><div align="left" class="style79">
        <div align="justify"><font face="Arial, Helvetica, sans-serif"><%=(trontgenpasien.Fields.Item("hasil").Value)%></font></div>
      </div></td>
    </tr>
    <% 
  Repeat7__index=Repeat7__index+1
  Repeat7__numRows=Repeat7__numRows-1
  trontgenpasien.MoveNext()
Wend
%>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>

<%
tpenyakit.Close()
Set tpenyakit = Nothing
%>
<%
tpasienri.Close()
Set tpasienri = Nothing
%>
<%
tkelas.Close()
Set tkelas = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
ttind_ugd.Close()
Set ttind_ugd = Nothing
%>
<%
triugd.Close()
Set triugd = Nothing
%>
<%
ttind_keperawatan.Close()
Set ttind_keperawatan = Nothing
%>
<%
trikeperawatan.Close()
Set trikeperawatan = Nothing
%>
<%
trimedis.Close()
Set trimedis = Nothing
%>
<%
ttind_pp.Close()
Set ttind_pp = Nothing
%>
<%
tripp.Close()
Set tripp = Nothing
%>
<%
trikelas.Close()
Set trikelas = Nothing
%>
<%
tvisite.Close()
Set tvisite = Nothing
%>
<%
trivisite.Close()
Set trivisite = Nothing
%>
<%
tkeluarobat1.Close()
Set tkeluarobat = Nothing
%>
<%
titemkeluarobat.Close()
Set titemkeluarobat = Nothing
%>
<%
tinputlaborat11.Close()
Set tinputlaborat1 = Nothing
%>
<%
tinputlaborat2.Close()
Set tinputlaborat2 = Nothing
%>
<%
tgolongan.Close()
Set tgolongan = Nothing
%>
<%
ttindlab1.Close()
Set ttindlab1 = Nothing
%>
<%
trontgenpasien.Close()
Set trontgenpasien = Nothing
%>
