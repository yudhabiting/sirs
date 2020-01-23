<%@LANGUAGE="VBSCRIPT"%>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
cuserid=trim(Session("MM_userid"))

%>

<!--#include file="../Connections/datarspermata.asp" -->
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


%>
<%
  Set tnourut1 = Server.CreateObject("ADODB.connection")
  tnourut1.open = MM_datarspermata_STRING
  set tnourut2=tnourut1.execute ("select kkelas,(select kriteria from tkelas where kkelas=trawatpasien.kkelas) as kkriteria, kasuransi from trawatpasien  where notrans='"&Request.QueryString("cnotrans")&"'") 

'awal
'  if isnull(tnourut2("kkriteria"))=true then
'       ctarifkelas2="TARIFRJ"
'  else
'	ctarifkelas1=tnourut2("kkriteria")
'	if ctarifkelas1="1" then
'		ctarifkelas2="TARIF1"
'	elseif ctarifkelas1="2" then
'		ctarifkelas2="TARIF2"
'	elseif ctarifkelas1="3" then
'		ctarifkelas2="TARIF3"
'	elseif ctarifkelas1="4" then
'		ctarifkelas2="TARIF4"
'	elseif ctarifkelas1="5" then
'		ctarifkelas2="TARIF5"
'	else
'		ctarifkelas2="TARIFRJ"
'	end if 	
 ' end if
 
'baru
	if isnull(tnourut2("kasuransi"))=true or tnourut2("kasuransi")="" then

		  if isnull(tnourut2("kkriteria"))=true then
			   ctarifkelas2="TARIFRJ"
		  else
			ctarifkelas1=tnourut2("kkriteria")
			if ctarifkelas1="1" then
				ctarifkelas2="TARIFVIP"
			elseif ctarifkelas1="2" then
				ctarifkelas2="TARIFUTAMA"
			elseif ctarifkelas1="3" then
				ctarifkelas2="TARIFKELAS1"
			elseif ctarifkelas1="4" then
				ctarifkelas2="TARIFKELAS2"
			elseif ctarifkelas1="5" then
				ctarifkelas2="TARIFKELAS3"
			else
				ctarifkelas2="TARIFRJ"
			end if 	
		  end if 
  	else
			ckasuransi=tnourut2("kasuransi")
			ctarifkelas2="TARIFASURANSI"&ckasuransi

	END IF
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
Dim trawatpasien__MMColParam
trawatpasien__MMColParam = "1"
If (Request.QueryString("cnotrans") <> "") Then 
  trawatpasien__MMColParam = Request.QueryString("cnotrans")
End If
%>
<%
Dim trawatpasien
Dim trawatpasien_cmd
Dim trawatpasien_numRows

Set trawatpasien_cmd = Server.CreateObject ("ADODB.Command")
trawatpasien_cmd.ActiveConnection = MM_datarspermata_STRING
trawatpasien_cmd.CommandText = "SELECT notrans, nocm, nama, alamat, tglmasuk, umurthn, umurbln, umurhr,statustransaksi,statuspasien FROM rspermata.trawatpasien WHERE notrans = ?" 
trawatpasien_cmd.Prepared = true
trawatpasien_cmd.Parameters.Append trawatpasien_cmd.CreateParameter("param1", 200, 1, 15, trawatpasien__MMColParam) ' adVarChar

Set trawatpasien = trawatpasien_cmd.Execute
trawatpasien_numRows = 0
%>
<%
cstatustransaksi=(trawatpasien.Fields.Item("statustransaksi").Value)
cstatuspasien=(trawatpasien.Fields.Item("statuspasien").Value)

if cstatuspasien="2" then
	filecetak="../inputdata/cetakhasillaboratRI.asp"
else
	filecetak="../inputdata/cetakhasillaboratRJ.asp"
end if

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
if ckgoltindakan="03" OR ckgoltindakan="05" OR ckgoltindakan="06"  or ckgoltindakan="07"  or ckgoltindakan="08" OR ckgoltindakan="10" OR ckgoltindakan="11" then
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



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edit Laboratorium Pasien</title>
<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
<link rel="stylesheet" href="../template/templat05/css/flexslider.css" type="text/css" media="all" />


<link rel="stylesheet" type="text/css" href="../include/jqueryeasyui/themes/metro-blue/easyui.css">
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


<script type="text/javascript">

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
				else {
					simpandata2();
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

 </script>
	<script>
		window.dhx_globalImgPath="../../include/";
	</script>


	<link rel="STYLESHEET" type="text/css" href="file:///D|/inetpub/campuran/aplikasi/include/dhtmlxcombo.css">
	<script  src="../dhtml/dhtmlxCombo/codebase/dhtmlxcommon.js"></script>
	<script  src="../dhtml/dhtmlxCombo/codebase/dhtmlxcombo.js"></script>
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



function simpandata1(cstatussimpan)
{
	document.forms['form1'].elements['ckondisiku'].value = cstatussimpan;
	ajaxFunctionlogin();
}  


function simpandata2()
{

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
					xmlhttp.send("ctanggal1="+encodeURIComponent(ctanggal1)+"&cktindakan="+encodeURIComponent(cktindakan)+"&ctarif="+encodeURIComponent(ctarif)+"&cpemeriksaan="+encodeURIComponent(cpemeriksaan)+"&chasil="+encodeURIComponent(chasil)+"&ckpegawai="+encodeURIComponent(ckpegawai)+"&cdokter="+encodeURIComponent(cdokter)+"&ckgoltindakan="+encodeURIComponent(ckgoltindakan)+"&cnourut="+encodeURIComponent(cnourut)+"&cnotranstindakan="+encodeURIComponent(cnotranstindakan)+"&cnotrans="+encodeURIComponent(cnotrans)+"&ctabel=tabel07");

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

						window.location = "../inputdata/inputlaboratpasien2.asp?cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ckgoltindakan=<%=ckgoltindakan%>&citem=<%=citem%>";
	
					}
				 }
					xmlhttp.open("POST","../include/saveJSON02.asp",true);
					xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					xmlhttp.send("cktindakan="+encodeURIComponent(cktindakan)+"&ckgoltindakan="+encodeURIComponent(ckgoltindakan)+"&cnourut="+encodeURIComponent(cnourut)+"&ctarif="+encodeURIComponent(ctarif)+"&cnotranstindakan="+encodeURIComponent(cnotranstindakan)+"&cnotrans="+encodeURIComponent(cnotrans)+"&ctabel=tabel08");



//		document.forms['form1'].submit();


	  }
	}
}


function isValidDate(ctanggal)
{
if (ctanggal != '0000-00-00') {
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
return true; // date is valid
}

//-->



//-->
</script>

<style type="text/css">
<!--
a {font-family: Tahoma; font-size: 14px; color:#FFFFFF;}
a:visited {text-decoration: none;font-size: 14px; color:#FF0000}
a:hover {font-family: Tahoma; font-size: 14px; color:#0000FF}
a:link {text-decoration: none;font-size: 14px; color:#FF0000}
a:active {font-family: Tahoma; font-size: 14px; color:#FFFFFF; }

.style3 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
.style4 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	font-weight:bold;
	color: #fff;
}
body {
	background-color:#CCC;
	color:#000;
	font-size:15px;
}
.fontku1 {
	color:#fff;
	font-size:15px;
}

.drop_menu {
background:#369;
padding:0;
margin:0;
list-style-type:none;
height:35px;
padding-left:5px;
position:fixed;
margin-top:120px;
width:985px;
z-index: 10;
}
.drop_menu li { float:left; }
.drop_menu li a {
padding:10px 30px;
display:block;
color:#fff;
text-decoration:none;
font:15px arial, verdana, sans-serif;
}
 
/* Submenu */
.drop_menu ul {
position:absolute;
left:-9999px;
top:-9999px;
list-style-type:none;
}
.drop_menu li:hover { position:relative; background:#369; }
.drop_menu li:hover ul {
left:0px;
top:35px;
padding:0px;


    overflow:auto;
    max-height:380px;
    overflow-x:hidden;

}
 
.drop_menu li:hover ul li a {
padding:7px;
display:block;
width:290px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

-->
</style>
</head>
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



  <link rel="STYLESHEET" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.css">
	<link rel="stylesheet" type="text/css" href="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>		
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>	
<script  src="../DHTML/DHTMLgrid/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
<script>
		dhtmlx.skin = "dhx_skyblue";
	</script>
	<!-- wraper -->
	<div id="wrapper">
		<!-- shell -->
		<div class="shell">
			<!-- container -->
			<div class="container1">
				<!-- header -->
			  <header id="header1">
					<h1 id="logo1"><a href="#"></a></h1>
			  </header>
 
<div class="drop">
<ul class="drop_menu">
<li><a href='../menuutama.asp'>Menu Utama</a></li>
<li><a href='../exit.asp'>Keluar Aplikasi</a></li>


<li>
<a href='#'>Transaksi  Pasien</a>
<ul>
<li><a href="editrawatpasien.asp?cnotrans=<%=cnotrans%>" >Rawat Pasien</a></li>
<li><a href="../inputdata/inputkelaspasien.asp?citem=1&cnotrans=<%=cnotrans%>" >Ruangan Pasien</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=11&ckgoltindakan=11&cnotrans=<%=cnotrans%>" >Visite Dokter</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=2&ckgoltindakan=01&cnotrans=<%=cnotrans%>" >Tindakan IGD</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=3&ckgoltindakan=02&cnotrans=<%=cnotrans%>" >Tindakan Keperawatan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=4&ckgoltindakan=03&cnotrans=<%=cnotrans%>" >Tindakan Medis</a></li>
<li><a href="../inputdata/inputlaboratpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>" >Pemeriksaan Laboratorium</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=6&ckgoltindakan=10&cnotrans=<%=cnotrans%>" >Pemeriksaan Radiologi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=7&ckgoltindakan=09&cnotrans=<%=cnotrans%>" >Pemeriksaan Fisioterapi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=8&ckgoltindakan=08&cnotrans=<%=cnotrans%>" >Tindakan Persalinan</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=10&ckgoltindakan=07&cnotrans=<%=cnotrans%>" >Tindakan Gigi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=13&ckgoltindakan=12&cnotrans=<%=cnotrans%>" >Pelayanan Gizi</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=12&ckgoltindakan=06&cnotrans=<%=cnotrans%>" >Tindakan Operasi</a></li>
<li><a href="../inputdata/inputanalisasituasipasien.asp?citem=15&cnotrans=<%=cnotrans%>">Analisa Situasi</a></li>
<li><a href="../daftar/daftarpemberianobatpasien.asp?citem=9&cnotrans=<%=cnotrans%>" target="_blank">Daftar Pemberian Obat</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=16&ckgoltindakan=13&cnotrans=<%=cnotrans%>" >Tindakan Non Medis</a></li>
<li><a href="../inputdata/inputtindakanpasien.asp?citem=17&ckgoltindakan=14&cnotrans=<%=cnotrans%>" >Potongan Pasien</a></li>

<li><a href="../inputdata/inputpembayaranpasien.asp?citem=14&cnotrans=<%=cnotrans%>">Pembayaran Pasien</a></li>
<li><a href="../inputdata/rincianbeayapasien.asp?cnotrans=<%=cnotrans%>" target="_blank">Rincian Pembiayaan Pasien</a></li>
</ul>
</li>

<li>
<a href='#'>Laboratorium</a>
<ul>
<li><a href="../daftar/daftartindakanpasien.asp?citem=5&ckgoltindakan=05&cnotrans=<%=cnotrans%>&cstatuspasien=<%=cstatuspasien%>">Cari Input Labaratorium</a></li>
<li><a href="<%=filecetak%>?citem=5&cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>" target="_blank" >Cetak Pemeriksaan Laborat</a></li>
<li><a href="../inputdata/inputlaboratpasien.asp?citem=5&cnotrans=<%=cnotrans%>&ckgoltindakan=05" >Input Pemeriksaan Laborat Baru</a></li>
<li><a href="../daftar/daftarinputperawatan.asp?citem=5&ckgoltindakan=05&cstatuspasien=2">Input  Pemeriksaan Laborat Pasien Baru</a></li>
</ul>
</li>


</ul>
</div>   

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

		  <form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1" id="form1">
<table width="100%" class="fontku1">
              <tr>
                <td width="3%" class="style4">&nbsp;</td>
                <td width="19%" class="style4"><span class="style3">Notrans</span></td>
                <td width="1%" ><div align="center">:</div></td>
                <td class="style5"><%=(trawatpasien.Fields.Item("notrans").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">NoCM</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nocm").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Nama</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("nama").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Alamat</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("alamat").Value)%></td>
              </tr>
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Umur</span></td>
                <td><div align="center">:</div></td>
                <td class="style4"><%=(trawatpasien.Fields.Item("umurthn").Value)%></td>
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
              <tr>
                <td class="style4">&nbsp;</td>
                <td class="style4"><span class="style3">Keterangan Pemeriksaan</span></td>
                <td><div align="center">:</div></td>
                <td><input name="cpemeriksaan" type="text" id="cpemeriksaan" value="<%=(tinputtindakanpasien.Fields.Item("pemeriksaan").Value)%>" size="80" maxlength="80" /></td>
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
                <td width="3%"  class="style4">&nbsp;</td>
                <td width="19%"  class="style4"><span class="style3">Tarif</span></td>
                <td width="1%"  ><div align="center">:</div></td>
                <td><input name="ctarif" type="text" id="ctarif" value="<%=(tinputtindakanpasien.Fields.Item("tarif").Value)%>" size="10" maxlength="10" /></td>
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
                  <input type="button" name="simpan" id="simpan" value="Edit Data" onclick="simpandata1('EDIT')"/>
                  <input type="button" name="button" id="button" value="Hapus Data" onclick="simpandata1('HAPUS')"/>
<%
end if
%>       
                
                </td>
              </tr>
</table>
           
               <input name="cnotrans" type="hidden" id="cnotrans" value="<%=(trawatpasien.Fields.Item("notrans").Value)%>" />
                <input name="cnourut" type="hidden" id="cnourut" value="<%=(tinputtindakanpasien.Fields.Item("nourut").Value)%>" />
                <input name="cnotranstindakan" type="hidden" id="cnotranstindakan" value="<%=(tinputtindakanpasien.Fields.Item("notranstindakan").Value)%>" />
                
                <input name="ckondisiku" type="hidden" id="ckondisiku" value="" />
                </strong></strong>


<table align="center" id="dg" class="easyui-datagrid"  style="width:975px;height:auto" title="Daftar Item"  idField="notrans"    url="../include/daftartransaksiJSON.asp?ckgoltindakan=<%=ckgoltindakan%>&cnotrans=<%=cnotrans%>&cnotranstindakan=<%=cnotranstindakan%>&ctabel=transaksi01A"   toolbar="#toolbar" 
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
<th field="TINDAKAN" width="175px" align="left" sortable="true">Tindakan</th>
</tr>
</thead >
<thead >
<tr>
<th field="tarif" width="70px" align="right" sortable="true" >Tarif</th>
<th field="pemeriksaan" width="200px" align="center" sortable="true" >Pemeriksaan</th>
<th field="hasil" width="350px" align="left" sortable="true"  formatter="formatA">Hasil</th>
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

    var url = 'editlaboratpasien.asp?cnotrans='+cnotrans+'&cnotranstindakan='+cnotranstindakan+'&cnourut='+cnourut+'&ckgoltindakan='+ckgoltindakan+'&citem=<%=citem%>';
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

<input type="hidden" name="cuserid" id="cuserid"  value="<%=cuserid%>">
	<div  id="csessionku">
    	<input type="hidden" name="csessionku" id="csessionku" value="">
	</div>            

            <input type="hidden" name="MM_update" value="form1" />
            <input type="hidden" name="MM_recordId" value="<%= tinputtindakanpasien.Fields.Item("notrans").Value %>" />
          </form>
    	  <div class="cleaner"></div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

			  <div id="footer"><!-- end of footer-cols -->
					<div class="footer-bottom">
				    <p class="copy">&copy; Copyright 2017 -  Kalboya@yahoo.com</p>
						<div class="cl">&nbsp;</div>
					</div>
			  </div>


			</div>
		</div>
	</div>
</body>
</html>
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
trawatpasien.Close()
Set trawatpasien = Nothing
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
