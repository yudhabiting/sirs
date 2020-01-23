<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas6"
cuserid=trim(Session("MM_userid"))
cstatususer=lcase(trim(Session("MM_statususer")))

chome="../"
clogintolak=chome&"tolak.asp"

if lcase(trim(Session("MM_statususer")))="" then
	Response.Redirect(clogintolak) 
end if
%>
<!--#include file="../Connections/datarspermata.asp" -->
<!--#include file="../include/tableMENUKIRI.asp" -->
<!--#include file="../include/tableMENUATAS2.asp" -->
<%
' validasi status user
txt1=lcase(trim(cstatususer))

txt2=lcase(trim(ccstatusaplikasiinput))
ccocok="false"
a=Split(txt2)
for each x in a
    txt3=lcase(trim(x))
	if txt1=txt3 then
		ccocok="true"
	end if
next
if ccocok="false" then
	Response.Redirect(clogintolak) 
end if

txt2edit=lcase(trim(ccstatusaplikasiedit))
ccocokedit="false"
a=Split(txt2edit)
for each x in a
    txt3=lcase(trim(x))
	if txt1=txt3 then
		ccocokedit="true"
	end if
next


cstatuspasien=request.QueryString("cstatuspasien")

%>


<%
Dim tpegawaiLOGIN__MMColParam
tpegawaiLOGIN__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tpegawaiLOGIN__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tpegawaiLOGIN
Dim tpegawaiLOGIN_cmd
Dim tpegawaiLOGIN_numRows

Set tpegawaiLOGIN_cmd = Server.CreateObject ("ADODB.Command")
tpegawaiLOGIN_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawaiLOGIN_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = ?" 
tpegawaiLOGIN_cmd.Prepared = true
tpegawaiLOGIN_cmd.Parameters.Append tpegawaiLOGIN_cmd.CreateParameter("param1", 200, 1, 6, tpegawaiLOGIN__MMColParam) ' adVarChar

Set tpegawaiLOGIN = tpegawaiLOGIN_cmd.Execute
tpegawaiLOGIN_numRows = 0
%>

<%
'BATAS COPYAN
%>


<%
citem=trim(request.QueryString("citem"))


ckgoltindakan=trim(request.QueryString("ckgoltindakan"))
ckgoltindakan1=request.QueryString("ckgoltindakan1")
if ckgoltindakan="" then
	ckgoltindakan=trim(request.form("ckgoltindakan"))
end if
ckjenistindakan=trim(request.QueryString("ckjenistindakan"))
if ckjenistindakan="" then
	ckjenistindakan=trim(request.form("ckjenistindakan"))
	if ckjenistindakan="" then
		ckjenistindakan="%"
	end if
end if

cnotrans=request.QueryString("cnotrans")
cnotranstindakan=request.QueryString("cnotranstindakan")
if cnotranstindakan="" then
	cnotranstindakan=request.form("cnotranstindakan")
end if

cnourut=request.QueryString("cnourut")
cnourutmenu=request.QueryString("cnourutmenu")

if ckgoltindakan="10" then
	cketeranganpemeriksaan="Kesan"
else
	cketeranganpemeriksaan="Keterangan"
end if

%>
<%
			   ctarifkelas2="TARIFRJ"
%>
<%
ttindakan__MMColParam1=ckgoltindakan
ttindakan__MMColParam2 = ckjenistindakan
%>
<%
Dim ttindakan
Dim ttindakan_cmd
Dim ttindakan_numRows

Set ttindakan_cmd = Server.CreateObject ("ADODB.Command")
ttindakan_cmd.ActiveConnection = MM_datarspermata_STRING
ttindakan_cmd.CommandText = "SELECT *,"&ctarifkelas2&" as tarif FROM rspermata.ttindakan WHERE  kgoltindakan like ? and kjenistindakan like '%"&ckjenistindakan&"%'  ORDER BY tindakan ASC" 
ttindakan_cmd.Prepared = true
ttindakan_cmd.Parameters.Append ttindakan_cmd.CreateParameter("param1", 200, 1, 255, "%" + ttindakan__MMColParam1 + "%") ' adVarChar

Set ttindakan = ttindakan_cmd.Execute
ttindakan_numRows = 0
%>
<%
cdaftartarif=""
While (NOT ttindakan.EOF)
  cdaftartarif=cdaftartarif&" "&"kode"&(ttindakan.Fields.Item("ktindakan").Value)&(ttindakan.Fields.Item("tarif").Value)
  ttindakan.MoveNext()
Wend
If (ttindakan.CursorType > 0) Then
  ttindakan.MoveFirst
Else
  ttindakan.Requery
End If
%>


<%
Dim tgoltindakan
Dim tgoltindakan_cmd
Dim tgoltindakan_numRows

Set tgoltindakan_cmd = Server.CreateObject ("ADODB.Command")
tgoltindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tgoltindakan_cmd.CommandText = "SELECT * FROM rspermata.tgoltindakan where kgoltindakan ='"&ckgoltindakan&"' order by goltindakan " 
tgoltindakan_cmd.Prepared = true

Set tgoltindakan = tgoltindakan_cmd.Execute
tgoltindakan_numRows = 0
%>
<%
Dim tjenistindakan
Dim tjenistindakan_cmd
Dim tjenistindakan_numRows

Set tjenistindakan_cmd = Server.CreateObject ("ADODB.Command")
tjenistindakan_cmd.ActiveConnection = MM_datarspermata_STRING
tjenistindakan_cmd.CommandText = "SELECT * FROM rspermata.tjenistindakan  where kgoltindakan ='"&ckgoltindakan&"'" 
tjenistindakan_cmd.Prepared = true

Set tjenistindakan = tjenistindakan_cmd.Execute
tjenistindakan_numRows = 0
%>
<%
Dim tpemeriksaanrujukan__MMColParam
tpemeriksaanrujukan__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tpemeriksaanrujukan__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim tpemeriksaanrujukan
Dim tpemeriksaanrujukan_cmd
Dim tpemeriksaanrujukan_numRows

Set tpemeriksaanrujukan_cmd = Server.CreateObject ("ADODB.Command")
tpemeriksaanrujukan_cmd.ActiveConnection = MM_datarspermata_STRING
tpemeriksaanrujukan_cmd.CommandText = "SELECT * FROM rspermata.tpemeriksaanrujukan WHERE notrans = ?" 
tpemeriksaanrujukan_cmd.Prepared = true
tpemeriksaanrujukan_cmd.Parameters.Append tpemeriksaanrujukan_cmd.CreateParameter("param1", 200, 1, 15, tpemeriksaanrujukan__MMColParam) ' adVarChar

Set tpemeriksaanrujukan = tpemeriksaanrujukan_cmd.Execute
tpemeriksaanrujukan_numRows = 0
%>
<%
cstatuspasien=1
cnocm=(tpemeriksaanrujukan.Fields.Item("nocm").Value)
cjudulform="Edit "&cjudulform 

%>
<%
Dim tinputtindakanpasien__MMColParam1
tinputtindakanpasien__MMColParam1 = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  tinputtindakanpasien__MMColParam1 = Request.QueryString("cnotrans")
End If
%>
<%
Dim tinputtindakanpasien__MMColParam2
tinputtindakanpasien__MMColParam2 = "1"
If (Request.QueryString("cnourut") <> "") Then 
  tinputtindakanpasien__MMColParam2 = Request.QueryString("cnourut")
End If
%>
<%
Dim tinputtindakanpasien
Dim tinputtindakanpasien_cmd
Dim tinputtindakanpasien_numRows

Set tinputtindakanpasien_cmd = Server.CreateObject ("ADODB.Command")
tinputtindakanpasien_cmd.ActiveConnection = MM_datarspermata_STRING
tinputtindakanpasien_cmd.CommandText = "SELECT * FROM rspermata.tinputtindakan WHERE notrans = ? and nourut = ?  and notranstindakan like '%"&cnotranstindakan&"%'  " 
tinputtindakanpasien_cmd.Prepared = true
tinputtindakanpasien_cmd.Parameters.Append tinputtindakanpasien_cmd.CreateParameter("param1", 200, 1, 255, tinputtindakanpasien__MMColParam1) ' adVarChar
tinputtindakanpasien_cmd.Parameters.Append tinputtindakanpasien_cmd.CreateParameter("param2", 5, 1, -1, tinputtindakanpasien__MMColParam2) ' adDouble

Set tinputtindakanpasien = tinputtindakanpasien_cmd.Execute
tinputtindakanpasien_numRows = 0
%>

<%
Dim tpegawai__MMColParam
tpegawai__MMColParam = "1"
If (Session("MM_userid") <> "") Then 
  tpegawai__MMColParam = Session("MM_userid")
End If
%>
<%
Dim tpegawai
Dim tpegawai_cmd
Dim tpegawai_numRows

Set tpegawai_cmd = Server.CreateObject ("ADODB.Command")
tpegawai_cmd.ActiveConnection = MM_datarspermata_STRING
tpegawai_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE nourut = ?" 
tpegawai_cmd.Prepared = true
tpegawai_cmd.Parameters.Append tpegawai_cmd.CreateParameter("param1", 200, 1, 6, tpegawai__MMColParam) ' adVarChar

Set tpegawai = tpegawai_cmd.Execute
tpegawai_numRows = 0
%>

<%
if ckgoltindakan="03" OR ckgoltindakan="05" OR ckgoltindakan="06"  or ckgoltindakan="07"  or ckgoltindakan="08" or ckgoltindakan="09" OR ckgoltindakan="10" OR ckgoltindakan="11" then
  tdokter__MMColParam = "02"
else
  tdokter__MMColParam = "XX"
end if  
%>
<%
Dim tdokter
Dim tdokter_cmd
Dim tdokter_numRows

Set tdokter_cmd = Server.CreateObject ("ADODB.Command")
tdokter_cmd.ActiveConnection = MM_datarspermata_STRING
tdokter_cmd.CommandText = "SELECT * FROM rspermata.tpegawai WHERE jabatan = ?" 
tdokter_cmd.Prepared = true
tdokter_cmd.Parameters.Append tdokter_cmd.CreateParameter("param1", 200, 1, 6, tdokter__MMColParam) ' adVarChar

Set tdokter = tdokter_cmd.Execute
tdokter_numRows = 0
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
<html lang="en">	
<head>
<meta charset="utf-8">
<title><%=cjudulform%></title>
		<link href="../template/menu000/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="../template/menu000/css/font-awesome.css" rel="stylesheet">
		<link href="../template/menu000/css/style.css" rel="stylesheet">

		<link href="../template/menu000/css/formatmenu01.css" rel="stylesheet">



<script type="text/javascript" src="../template/menu000/js/jquery.min1.js"></script> 
<script src="../template/menu000/js/devoops.js"></script>

    

</head>



<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/metro-green/easyui.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/demo/demo.css"/>
<script type="text/javascript" src="../include/jqueryeasyui/jquery-1.6.min.js"></script>
<script type="text/javascript" src="../include/jqueryeasyui/jquery.min.js"></script>


<script type="text/javascript" src="../include/jqueryeasyui/jquery.easyui.min.js"></script>
<script src="../include/jqueryeasyui/datagrid-filter.js" type="text/javascript"></script>
<script type="text/javascript" src="../include/jqueryeasyui/print.js"></script>
<script type="text/javascript" src="../include/jqueryeasyui/excel.js"></script>
<!--#include file="../include/filterDATAGRID.asp" -->


<script language="javascript" type="text/javascript">
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
</script>
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

//-->
</script>
<script type="text/javascript">
<!--

 function ajaxFunctionlogin(filesimpan)  
 {
   var ckondisiku = document.forms['form1'].elements['ckondisiku'].value;
   var cuserid = document.forms['form1'].elements['cuserid'].value;
   var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
	url="../include/cekLOGINED.asp?cuserid="+cuserid
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   	{
	   document.getElementById ("csessionku").innerHTML=xmlHttp.responseText;
	   var csessionku =document.forms['form1'].elements['csessionku'].value;
	   var cuserid = document.forms['form1'].elements['cuserid'].value;
//		alert(document.forms['form1'].elements['csessionku'].value);
		if (csessionku==''){
			loginulang();
			}
		else if (csessionku!=cuserid){
			alert("User ID yg anda Masukan tidak sesuai dengan User ID Login Sebelumnya, silahkan Login Ulang");
		}

		else {
				if (ckondisiku=='HAPUS'){
					hapusdata();
					}
				else if  (ckondisiku=='EDIT'){
					simpandata2();
					}
				else if  (ckondisiku=='CARI'){
					caridata();
					}
				else {
					inputdata();
					}
			}


	}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  

// window login ulang
var popupWindow=null;
function loginulang()
	{ 
		var w = 500;
		var h = 500;
		var left = Number((screen.width/2)-(w/2));
		var tops = Number((screen.height/2)-(h/2));
		
		if(popupWindow && !popupWindow.closed)
		   popupWindow.focus();
		else
		   popupWindow = window.open('../loginulang.asp','winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+w+', height='+h+', top='+tops+', left='+left);
	}


// fungsi disable parent window	
function parent_disable() 
	{
  		if(popupWindow && !popupWindow.closed)
    	popupWindow.focus();
	}





        function createTooltip(){  
            $('#dg').datagrid('getPanel').find('.easyui-tooltip').each(function(){  
                var index = parseInt($(this).attr('cellhasil'));  
                $(this).tooltip({  
                    content: $('<div></div>'),  
                    onUpdate: function(cc){  
                        var row = $('#dg').datagrid('getRows')[index];  
                        var content = row.alamat;  
                        cc.panel({  
                            width:500,  
                            content:content  
                        });  
                    },  
	            onShow: function(){
                $(this).tooltip('arrow').css('left', 1);
                $(this).tooltip('tip').css('left', $(this).offset().left);
            }
					
                });  
            });  
        }  


function tarifku(cktindakan)
{
	var txt1='<%=(cdaftartarif)%>';
	spl = txt1.split(" ");
	var txt2="kode"+cktindakan;
	for(i = 0; i < spl.length; i++)
	{
		var kodetindakan=spl[i].toString();
		var kodetindakan=kodetindakan.substring(0,10);
		if (kodetindakan==txt2) {
			var panjang=spl[i].length;
			var jmltarif=spl[i].substring(10,panjang);
			document.forms['form1'].elements['ctarif'].value=jmltarif;
			$('#ctariftitik').numberbox('setValue', jmltarif);			
			
		}
	}
}

 function ajaxFunction(cgoltindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url="../include/comboJENISTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("ckjenistindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);



var xmlHttp1;  
   try    {xmlHttp1=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp1=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var goltindakanku=cgoltindakan
	url1="../include/comboTINDAKAN.asp?ckgoltindakan="+goltindakanku
   url1=url1+"&sid="+Math.random()	
   xmlHttp1.onreadystatechange=function()      
   {if(xmlHttp1.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp1.responseText;}
   } 
    xmlHttp1.open("GET",url1,true);    xmlHttp1.send(null);	
   }  


 function ajaxFunction1(cjenistindakan)  
 {var xmlHttp;  
   try    {xmlHttp=new XMLHttpRequest();}  
   catch (e)    {try      {xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");}    
   catch (e)    {try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}      
   catch (e)    {alert("Your browser does not support AJAX");return false;}}}    
   var jenistindakanku=cjenistindakan
	url="../include/comboTINDAKAN1.asp?ckjenistindakan="+jenistindakanku
   url=url+"&sid="+Math.random()	
   xmlHttp.onreadystatechange=function()      
   {if(xmlHttp.readyState==4)        
   {document.getElementById ("cktindakan").innerHTML=xmlHttp.responseText;}
   } 
    xmlHttp.open("GET",url,true);    xmlHttp.send(null);
   }  


function refreshtable()
{
	var ckgoltindakan='<%=(ckgoltindakan)%>';
	var cnotrans='<%=(cnotrans)%>';
	var cnotranstindakan='<%=(cnotranstindakan)%>';

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?ckgoltindakan='+encodeURIComponent(ckgoltindakan)+'&cnotrans='+encodeURIComponent(cnotrans)+'&cnotranstindakan='+encodeURIComponent(cnotranstindakan)+'&ctabel=transaksi01A',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');


}



function caridata()
{
var ckgoltindakan='<%=(ckgoltindakan)%>';
var cnotrans='<%=(cnotrans)%>';
var cnotranstindakan='<%=(cnotranstindakan)%>';
var cnourut='<%=(cnourut)%>';
var cstatuspasien='<%=(cstatuspasien)%>';

var citem='<%=(citem)%>';

window.location = "../daftar/daftarpemeriksaanrujukan.asp?cnotrans=<%=cnotrans%>&ckgoltindakan=<%=ckgoltindakan%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
}

function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  


function simpandata2()
{
var ctarif = $('#ctariftitik').numberbox('getValue');
document.forms['form1'].elements['ctarif'].value=ctarif;
//alert(document.forms['form1'].elements['ctarif'].value);

var ckgoltindakan='<%=(ckgoltindakan)%>';
var cnotrans='<%=(cnotrans)%>';
var cnotranstindakan='<%=(cnotranstindakan)%>';
var cnourut='<%=(cnourut)%>';
var citem='<%=(citem)%>';


var cktindakan = document.forms['form1'].elements['cktindakan'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;
var ctanggal1 = document.forms['form1'].elements['ctgltrans'].value;
var ckpegawai = document.forms['form1'].elements['ckpegawai'].value;
var cdokter = document.forms['form1'].elements['cdokter'].value;
var cpemeriksaan = document.forms['form1'].elements['cpemeriksaan'].value;
var chasil = document.forms['form1'].elements['chasil'].value;


if (cktindakan == '') {
alert("tindakan kosong, mohon dicek")
document.forms['form1'].elements['cktindakan'].focus();
return false;
}
else if (ctarif == '') {
alert("tarif kosong, mohon dicek")
document.forms['form1'].elements['ctarif'].focus();
return false;
}
else if (isValidDate(ctanggal1)==false){
		document.forms['form1'].elements['ctgltrans'].focus();
		return false
	}
else {

				var xmlhttp;
				if (window.XMLHttpRequest)
				  {// code for IE7+, Firefox, Chrome, Opera, Safari
				  xmlhttp=new XMLHttpRequest();
				  }
				else
				  {// code for IE6, IE5
				  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  }
				xmlhttp.onreadystatechange=function()
				  {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
					{

					document.forms['form1'].elements['ckondisiku'].value = '';
					refreshtable();
					}
				 }
					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&cktindakan="+encodeURIComponent(cktindakan)+"&ctarif="+encodeURIComponent(ctarif)+"&cpemeriksaan="+encodeURIComponent(cpemeriksaan)+"&chasil="+encodeURIComponent(chasil)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cdokter="+encodeURIComponent(cdokter)+"&ckgoltindakan="+encodeURIComponent(ckgoltindakan)+"&cnourut="+encodeURIComponent(cnourut)+"&cnotranstindakan="+encodeURIComponent(cnotranstindakan)+"&cnotrans="+encodeURIComponent(cnotrans)+"&ctabel=tabel07B");

//	document.forms['form1'].elements['ckondisiku'].value='1';
//	document.forms['form1'].submit();

	}
}


function hapusdata()
{
var cktindakan = document.forms['form1'].elements['cktindakan'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;

var ckgoltindakan='<%=(ckgoltindakan)%>';
var cnotrans='<%=(cnotrans)%>';
var cnotranstindakan='<%=(cnotranstindakan)%>';
var cnourut='<%=(cnourut)%>';

var citem='<%=(citem)%>';

if (cktindakan == '') {
alert("tindakan kosong, mohon dicek")
document.forms['form1'].elements['cktindakan'].focus();
return false;
}
else if (cnourut == '') {
alert("nourut kosong, mohon dicek")
document.forms['form1'].elements['cnourut'].focus();
return false;
}
else {
	document.forms['form1'].elements['ckondisiku'].value='2';
	var r=confirm("Anda yakin mau menghapus data ini!");
	if (r==true)
	  {



				var xmlhttp;
				if (window.XMLHttpRequest)
				  {// code for IE7+, Firefox, Chrome, Opera, Safari
				  xmlhttp=new XMLHttpRequest();
				  }
				else
				  {// code for IE6, IE5
				  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				  }
				xmlhttp.onreadystatechange=function()
				  {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
					{
//					refreshtable();

						window.location = "../inputdata/inputpemeriksaanrujukan2.asp?cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ckgoltindakan=<%=ckgoltindakan%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
					}
				 }
					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("cktindakan="+encodeURIComponent(cktindakan)+"&ckgoltindakan="+encodeURIComponent(ckgoltindakan)+"&cnourut="+encodeURIComponent(cnourut)+"&ctarif="+encodeURIComponent(ctarif)+"&cnotranstindakan="+encodeURIComponent(cnotranstindakan)+"&cnotrans="+encodeURIComponent(cnotrans)+"&ctabel=tabel08B");



//		document.forms['form1'].submit();


	  }
	}
}



function inputdata()
{
var cktindakan = document.forms['form1'].elements['cktindakan'].value;
var cnourut = document.forms['form1'].elements['cnourut'].value;
var ctarif = document.forms['form1'].elements['ctarif'].value;

var ckgoltindakan='<%=(ckgoltindakan)%>';
var cnotrans='<%=(cnotrans)%>';
var cnotranstindakan='<%=(cnotranstindakan)%>';
var cnourut='<%=(cnourut)%>';

var citem='<%=(citem)%>';

window.location = "../inputdata/inputpemeriksaanrujukan2.asp?cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ckgoltindakan=<%=ckgoltindakan%>&citem=<%=citem%>&cstatuspasien=<%=cstatuspasien%>&cnourutmenu=<%=cnourutmenu%>";
	
}


function isValidDate(ctanggal)
{
//var dateStr=document.getElementById('cf06').value;
var dateStr=ctanggal;
//var datePat=/^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;
var datePat=/^(\d{2}|\d{4})(\/|-)(\d{1,2})\2(\d{1,2})$/;
var matchArray = dateStr.match(datePat); // is the format ok?
if (matchArray == null) {
alert("Isian Tanggal Salah");
return false;
}
month = matchArray[3]; // parse date into variables
day = matchArray[4];
year = matchArray[1];
if (month < 1 || month > 12) { // check month range
alert("bulan 1 sampai 12.");
return false;
}
if (day < 1 || day > 31) {
alert("Hari 1 sampai 31.");
return false;
}
if ((month==4 || month==6 || month==9 || month==11) && day==31) {
alert("Bulan "+month+" tidak nyampai 31 hari!");
return false;
}
if (month == 2) { // check for february 29th
var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
if (day>29 || (day==29 && !isleap)) {
alert("February " + year + " tidak mempunyai " + day + " hari!");
return false;
}
}
return true; // date is valid
}




//-->
</script>
<script language="JavaScript">
<!-- Begin


var timerID = null;
var timerRunning = false;
function stopclock (){
if(timerRunning)
clearTimeout(timerID);
timerRunning = false;
}
function showtime () {
	
	
var now = new Date();
var hours = now.getHours();
var minutes = now.getMinutes();
var seconds = now.getSeconds()
var timeValue = "" + ((hours >12) ? hours -12 :hours)
if (timeValue == "0") timeValue = 12;
timeValue += ((minutes < 10) ? ":0" : ":") + minutes
timeValue += ((seconds < 10) ? ":0" : ":") + seconds
timeValue += (hours >= 12) ? " PM" : " AM"
document.form1.cjamdaftar.value = timeValue;

timerID = setTimeout("showtime()",1000);
timerRunning = true;
}
function startclock() {
stopclock();
showtime();
}

function tglsekarang() {
var todayDate=new Date();
var date=todayDate.getDate();
var month=todayDate.getMonth()+1;
var year=todayDate.getFullYear();
document.form1.ctgldaftar.value=year+'/'+month+'/'+date;
}

// End -->
</script>

<body onLoad="doOnLoad();" onFocus="parent_disable();" onclick="parent_disable();">

<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctgltrans"]);
		}
	</script>

<header class="navbar">
	<div class="container-fluid expanded-panel">
		<div class="row" >

			<div id="logo" class="col-xs-12 col-sm-2" style="overflow: hidden; white-space: nowrap; height: 70px;">
            <img src="../icon/logoPERMATA.png" width="180" height="60">
			</div>

			<div id="top-panel" class="col-xs-12 col-sm-10">
				<div class="row">
					<div class="col-xs-8 col-sm-8 top-panel-right text-center">
							<h3 style="padding-top: 10px;"><span style="white-space:nowrap"></span></h3>
					</div>

                   <div class="fontjudul1" align="right" style="font-size:20px; margin-right:20px;"> <%=cjudulform%> </div>
					<div class="col-xs-4 col-sm-4 top-panel-right text-right">
						<ul class="nav navbar-nav pull-right panel-menu">
							<li>
								<font size="+1"><span class="fontjudul4">  </span> </font>
							</li>
						</ul>
					</div>                   
				</div>
                
			</div>
		</div>
	</div>

    
            <!--menu sebelah kiri-->
                <div id="breadcrumb" class="col-xs-6" style="padding-left: 25px;white-space:nowrap;z-index:1000; width:5px">
                    <a href="#" class="show-sidebar">
                      <i class="fa fa-bars"></i>
                    </a>
                    <ol class="breadcrumb" style="padding-left: 30px;">
                      <li class="hidden-xs">Menu Transaksi Pasien</li>
                    </ol>
                </div>


            <!--menu sebelah kanan-->

			<!--#include file="../include/menuINPUTatas.asp" -->
 
</header>



<div id="main" class="container-fluid sidebar-show" style="overflow:visible;background:#6C6;">
	<div class="row">
		<div id="sidebar-left" class="col-xs-2 col-sm-2" >

			<!--#include file="../include/menuINPUTkiri.asp" -->

		</div>





		<!--Start Content-->
	<div id="content" class="col-xs-12 col-sm-10" style="min-height:1000px;padding-left:0px; padding-right:0px;">
</br>
 <div align="right" style="margin-right:20px">Login ID : @ <span class="blink" style="font-size:14px"><%=tpegawaiLOGIN.Fields.Item("nama").Value%></span>  </div>                 

            <div class="row-fluid"> 
                <div class="box"><div class="box-content"><center>


		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
<table width="100%" class="fontku1">
              <tr>
                <td width="3%" class="style4">&nbsp;</td>
                <td width="19%" class="style4"><span class="style3">Notrans</span></td>
                <td width="1%" ><div align="center">:</div></td>
                <td class="style5"><%=(tpemeriksaanrujukan.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">No CM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(tpemeriksaanrujukan.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(tpemeriksaanrujukan.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(tpemeriksaanrujukan.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(tpemeriksaanrujukan.Fields.Item("umurthn").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Tanggal</span></td>
                <td><div align="center">:</div></td>
                <td><font size="2" face="Arial, Helvetica, sans-serif">
                <input name="ctgltrans" type="text" id="ctgltrans" value="<%= DoDateTime((tinputtindakanpasien.Fields.Item("tgltrans").Value), 2, 7177) %>" size="15" maxlength="10" />
                </font></td>
              </tr>
              <tr>
                <td width="1%" class="style4">&nbsp;</td>
                <td width="16%" class="style4"><span class="style3">Golongan Tindakan</span></td>
                <td width="1%"><div align="center">:</div></td>
                <td width="82%">
                <select name="ckgoltindakan" id="ckgoltindakan" onChange="ajaxFunction(this.value)">
                  <%
While (NOT tgoltindakan.EOF)
%>
                  <option value="<%=(tgoltindakan.Fields.Item("Kgoltindakan").Value)%>" <%If (Not isNull((request.QueryString("ckgoltindakan")))) Then If (CStr(tgoltindakan.Fields.Item("kgoltindakan").Value) = CStr((request.QueryString("ckgoltindakan")))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tgoltindakan.Fields.Item("goltindakan").Value)%></option>
                  <%
  tgoltindakan.MoveNext()
Wend
If (tgoltindakan.CursorType > 0) Then
  tgoltindakan.MoveFirst
Else
  tgoltindakan.Requery
End If
%>
                </select></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Jenis  Tindakan</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div class="style17" id="ckjenistindakan">
                <select name="ckjenistindakan" id="ckjenistindakan" onChange="ajaxFunction1(this.value)">
<%
While (NOT tjenistindakan.EOF)
%>
                  <option value="<%=(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value)%>" <%If (Not isNull(request.form("ckjenistindakan"))) Then If (CStr(tjenistindakan.Fields.Item("KJENISTINDAKAN").Value) = CStr(request.form("ckjenistindakan"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tjenistindakan.Fields.Item("JENISTINDAKAN").Value)%></option>
                  <%
  tjenistindakan.MoveNext()
Wend
If (tjenistindakan.CursorType > 0) Then
  tjenistindakan.MoveFirst
Else
  tjenistindakan.Requery
End If
%>
                </select>
                </div>
                </td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Tindakan</span></td>
                <td><div align="center">:</div></td>
                <td>
                <div class="style17" id="cktindakan">
                <select name="cktindakan" id="cktindakan" onChange="tarifku(this.value)">
                  <option value="" <%If (Not isNull((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then If ("" = CStr((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT ttindakan.EOF)
%>
                  <option value="<%=(ttindakan.Fields.Item("KTINDAKAN").Value)%>" <%If (Not isNull((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then If (CStr(ttindakan.Fields.Item("KTINDAKAN").Value) = CStr((tinputtindakanpasien.Fields.Item("ktindakan").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(ttindakan.Fields.Item("TINDAKAN").Value)%></option>
                  <%
  ttindakan.MoveNext()
Wend
If (ttindakan.CursorType > 0) Then
  ttindakan.MoveFirst
Else
  ttindakan.Requery
End If
%>
                </select>
                </div>
                </td>
              </tr>


</table>
<%
if ckgoltindakan<>"14" and ckgoltindakan<>"13" then
' input  tindakan
%>
<table width="100%" class="fontku1">

<%
else
' input  Potongan dan tindakan non medis

%>
<table width="100%" class="fontku1" hidden="true">

<%
end if
%>


              <tr>
                <td width="3%" class="style4">&nbsp;</td>
                <td width="19%" class="style4"><span class="style3">Hasil Pemeriksaan</span></td>
                <td width="1%" ><div align="center">:</div></td>
                <td><textarea name="chasil" id="chasil" cols="60" rows="3"><%=(tinputtindakanpasien.Fields.Item("hasil").Value)%></textarea></td>
              </tr>
              <tr>
                <td >&nbsp;</td>
                <td ><%=cketeranganpemeriksaan%></td>
                <td>:</td>
                <td><textarea name="cpemeriksaan" type="text" id="cpemeriksaan" cols="60" rows="5" ><%=(tinputtindakanpasien.Fields.Item("pemeriksaan").Value)%></textarea></td>
              </tr>

              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Dokter</span></td>
                <td><div align="center">:</div></td>
                <td><select name="cdokter" id="cdokter">
                  <option value="" <%If (Not isNull(tinputtindakanpasien.Fields.Item("kdokter").Value)) Then If ("" = CStr(tinputtindakanpasien.Fields.Item("kdokter").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
                  <%
While (NOT tdokter.EOF)
%>
                  <option value="<%=(tdokter.Fields.Item("nourut").Value)%>" <%If (Not isNull(tinputtindakanpasien.Fields.Item("kdokter").Value)) Then If (CStr(tdokter.Fields.Item("nourut").Value) = CStr(tinputtindakanpasien.Fields.Item("kdokter").Value)) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tdokter.Fields.Item("nama").Value)%></option>
                  <%
  tdokter.MoveNext()
Wend
If (tdokter.CursorType > 0) Then
  tdokter.MoveFirst
Else
  tdokter.Requery
End If
%>
                </select></td>
              </tr>
            </table>

<table width="100%" class="fontku1" >

              <tr>
                <td width="3%"  >&nbsp;</td>
                <td width="19%"  >Tarif</td>
                <td width="1%"  ><div align="center">:</div></td>
                <td>
 <input value="<%=(tinputtindakanpasien.Fields.Item("tarif").Value)%>" name="ctariftitik" id="ctariftitik" class="easyui-numberbox" value="0" data-options="label:'Number in the United States',labelPosition:'top', min:0,precision:0,groupSeparator:',',width:'100%'">
                 <input name="ctarif" type="hidden" id="ctarif" value="0" size="10" maxlength="10" value="<%=(tinputtindakanpasien.Fields.Item("tarif").Value)%>"/>
                </td>
              </tr>

              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Petugas</span></td>
                <td><div align="center">:</div></td>
                <td><select name="ckpegawai" id="ckpegawai">
        <option value="" <%If (Not isNull(Session("MM_userid"))) Then If ("" = CStr(Session("MM_userid"))) Then Response.Write("selected=""selected""") : Response.Write("")%>></option>
        <%
While (NOT tpegawai.EOF)
%>
        <option value="<%=(tpegawai.Fields.Item("nourut").Value)%>" <%If (Not isNull(Session("MM_userid"))) Then If (CStr(tpegawai.Fields.Item("nourut").Value) = CStr(Session("MM_userid"))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(tpegawai.Fields.Item("nama").Value)%></option>
        <%
  tpegawai.MoveNext()
Wend
If (tpegawai.CursorType > 0) Then
  tpegawai.MoveFirst
Else
  tpegawai.Requery
End If
%>
      </select></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>

</table>

<table width="100%" class="fontku1" >

              <tr>
                <td width="3%"  ></td>
                <td width="19%" ></td>
                <td width="1%"  ></td>
                <td>
<%
if cstatustransaksi<>"T" then
%>
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata1('EDIT')" class="tombolku2"/>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="simpandata1('HAPUS')" class="tombolku2"/>
                <input name="button2" type="button" class="tombolku2" id="button2" value="Input Tindakan Baru"  onclick="simpandata1('INPUT')">

<%
end if
%>       
                <input type="button" name="simpan" id="simpan" value="Daftar Rujukan" onclick="simpandata1('CARI')" class="tombolku2"/>
                </td>
              </tr>
              <tr>
                <td  ></td>
                <td ></td>
                <td  ></td>
                <td>&nbsp;</td>
              </tr>
</table>
           
               <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(tpemeriksaanrujukan.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputtindakanpasien.Fields.Item("nourut").Value)%>" />
                <input name="cnotranstindakan" type="hidden" id="cnotranstindakan" value="<%=(tinputtindakanpasien.Fields.Item("notranstindakan").Value)%>" />
                
                </strong></strong>


<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="<%=cjudulform%>"  idField="notrans"    url="../include/daftartransaksiJSON.asp?ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ctabel=transaksi01A"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:25" align="center"  formatter="linkrawatjalan">No</th>
<th field="tgltrans" width="100px" align="center" sortable="true" >Tgl Tindakan</th>
<th field="TINDAKAN" width="200px" align="left" sortable="true">Tindakan</th>
</tr>
</thead >
<thead >
<tr>
<th field="tarif" width="70px" align="right" sortable="true" >Tarif</th>
<th field="hasil" width="350px" align="left" sortable="true"  formatter="formatA">Hasil</th>
<th field="pemeriksaan" width="300px" align="left" sortable="true" ><%=cketeranganpemeriksaan%></th>
<th field="dokter" width="150px" align="left" sortable="true" >Dokter</th>
<th field="kgoltindakan" width="50px" align="left" sortable="true" hidden="true">kgoltindakan</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnotranstindakan = row.notranstindakan;
    var cnourut = row.nourut;
     var ckgoltindakan = row.kgoltindakan;
	var cnourutmenu=<%=cnourutmenu%>;

    var url = 'editpemeriksaanrujukan.asp?cnotrans='+cnotrans+'&cnotranstindakan='+cnotranstindakan+'&cnourut='+cnourut+'&ckgoltindakan='+ckgoltindakan+'&citem=<%=citem%>'+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnourut+'</a>';
    }	
function formatA(value,row,index){  
            return '<span cellhasil='+index+' class="easyui-tooltip">' + value + '</span>';  
        }  	
</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>

            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputtindakanpasien.Fields.Item("notrans").Value %>" />


<input type="hidden" name="cuserid" id="cuserid"  value="<%=cuserid%>">
	<div  id="csessionku">
    	<input type="hidden" name="csessionku" id="csessionku" value="">
	</div>            

                <input name="ckondisiku" type="hidden" id="ckondisiku" value="" />
				<input type="hidden" name="cnourutmenu" id="cnourutmenu"  value="<%=cnourutmenu%>">

</form>



                    </center><br />
                </div>
            </div>

            <div style="padding: 20px;text-align:center;">
 								&copy; Design By |<font size="+1"><span class="fontjudul2" style="font-size:20px"> Kalboya@yahoo.com </span> </font>

            </div>
		</div>
		<!--End Content-->
	</div>
</div>
</html>
<%
tpegawaiLOGIN.Close()
Set tpegawaiLOGIN = Nothing
%>
<!--#include file="../include/tableMENUBAWAH.asp" -->


<%
ttindakan.Close()
Set ttindakan = Nothing
%>
<%
tgoltindakan.Close()
Set tgoltindakan = Nothing
%>
<%
tjenistindakan.Close()
Set tjenistindakan = Nothing
%>
<%
tpemeriksaanrujukan.Close()
Set tpemeriksaanrujukan = Nothing
%>
<%
tinputtindakanpasien.Close()
Set tinputtindakanpasien = Nothing
%>
<%
tpegawai.Close()
Set tpegawai = Nothing
%>
<%
tdokter.Close()
Set tdokter = Nothing
%>
