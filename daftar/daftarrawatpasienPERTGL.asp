<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas0"
cuserid=trim(Session("MM_userid"))
cstatususer=lcase(trim(Session("MM_statususer")))
cnourutmenu=request.QueryString("cnourutmenu")
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
' nourut menu input pendaftaran

cjudulform=""&cjudulform
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
Dim trumahsakit
Dim trumahsakit_numRows

Set trumahsakit = Server.CreateObject("ADODB.Recordset")
trumahsakit.ActiveConnection = MM_datarspermata_STRING
trumahsakit.Source = "SELECT rumahsakit, krumahsakit  FROM rspermata.trumahsakit"
trumahsakit.CursorType = 0
trumahsakit.CursorLocation = 2
trumahsakit.LockType = 1
trumahsakit.Open()
trumahsakit_numRows = 0
%>
<%
Dim tkelas
Dim tkelas_cmd
Dim tkelas_numRows

Set tkelas_cmd = Server.CreateObject ("ADODB.Command")
tkelas_cmd.ActiveConnection = MM_datarspermata_STRING
tkelas_cmd.CommandText = "SELECT * FROM rspermata.tkelas order by kelas" 
tkelas_cmd.Prepared = true

Set tkelas = tkelas_cmd.Execute
tkelas_numRows = 0
%>


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

					simpandata2();


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


function simpandata1(cstatussimpan)
{
	ajaxFunctionlogin();
}  



function simpandata2()
{
	refreshtable();
}


        function createTooltip(){  
            $('#dg').datagrid('getPanel').find('.easyui-tooltip').each(function(){  
                var index = parseInt($(this).attr('cellhasil'));  
                $(this).tooltip({  
                    content: $('<div></div>'),  
                    onUpdate: function(cc){  
                        var row = $('#dg').datagrid('getRows')[index];  
                        var content = row.nama;  
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
var ctglmasuk1 = document.forms['form1'].elements['ctglmasuk1'].value;
var ctglmasuk2 = document.forms['form1'].elements['ctglmasuk2'].value;
var cstatuspasien = document.forms['form1'].elements['cstatuspasien'].value;
	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?ctglmasuk1='+encodeURIComponent(ctglmasuk1)+'&ctglmasuk2='+encodeURIComponent(ctglmasuk2)+'&cstatuspasien='+encodeURIComponent(cstatuspasien)+'&ctabel=transaksi05',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:25,
					pageList: [25,50,100,500],
					method:'get',
            		onLoadSuccess:function(){  
                		createTooltip();  
			 		}  	
			});  
//	$('#dg').datagrid('reload');


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

<body onload="doOnLoad();" onfocus="parent_disable();" onclick="parent_disable();">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>


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
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk1","ctglmasuk2"]);
		}
	</script>
          <tr>
                <td width="2%">&nbsp;</td>
                <td width="13%"><div align="right">Dari Tanggal</div></td>
                <td width="1%" align="center">:</td>
                <td width="84%"><input name="ctglmasuk1" type="text" id="ctglmasuk1" value="<%=request.querystring("ctglmasuk1")%>"  /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td align="left"><div align="right">Sampai Tanggal </div></td>
            <td align="center">:</td>
            <td><input name="ctglmasuk2" type="text" id="ctglmasuk2" value="<%=request.querystring("ctglmasuk2")%>"  /></td>
          </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">Status Berobat</div></td>
    <td align="center">:</td>
    <td><select name="cstatuspasien" id="cstatuspasien">
      <option value=" " <%If (Not isNull(cstatuspasien)) Then If (" " = CStr(cstatuspasien)) Then Response.Write("selected=""selected""") : Response.Write("")%>>Semua Data</option>
      <option value="1" <%If (Not isNull(cstatuspasien)) Then If ("1" = CStr(cstatuspasien)) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Jalan</option>
      <option value="2" <%If (Not isNull(cstatuspasien)) Then If ("2" = CStr(cstatuspasien)) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Inap</option>
      </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>
      <input name="cari" type="button" id="cari" value="Cari Data" onclick="simpandata1()" class="tombolku2"/>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="Daftar Kunjungan Pasien"  idField="notrans"    url="../include/daftartransaksiJSON.asp?ctglmasuk1=xxxxx&ctabel=transaksi05"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500],
				method:'get',
            	onLoadSuccess:function(){  
                	createTooltip();  
				 }  	
                ">
<thead data-options="frozen:true">
<tr>
<th data-options="field:'nourut',width:70" align="center"  formatter="linkrawatjalan">No CM</th>
<th field="tglmasuk" width="100px" align="center" sortable="true" >Tgl Masuk</th>
<th field="nama" width="200px" align="left" sortable="true" >Nama</th>
</tr>
</thead >
<thead >
<tr>
<th field="alamat" width="400px" align="left" sortable="true" >alamat</th>
<th field="umurthn" width="50px" align="center" sortable="true" >Umur </br>Thn</th>
<th field="umurbln" width="50px" align="center" sortable="true" >Umur </br>Bln</th>
<th field="umurhr" width="50px" align="center" sortable="true" >Umur </br>Hr</th>
<th field="kelompok" width="150px" align="left" sortable="true" >Kelompok</th>
<th field="kelas" width="250px" align="left" sortable="true" >Ruangan</th>
<th field="orangtua" width="150px" align="left" sortable="true" >Orang Tua</th>
<th field="statusberobat" width="150px" align="left" sortable="true" >Status Berobat</th>
<th field="notrans" width="50px" align="left" sortable="true" hidden="true">notrans</th>
<th field="nocm" width="70px" align="left" sortable="true">No CM</th>
<th field="statuspasien" width="50px" align="left" sortable="true" hidden="true">statuspasien</th>
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnocm = row.nocm;
	var cnourutmenu=<%=cnourutmenu%>;
    var cstatuspasien = row.statuspasien;
    var url = '../editdata/editrawatpasien.asp?cnotrans='+cnotrans+'&cstatuspasien='+cstatuspasien+'&cnourutmenu=<%=cnourutmenu%>';
    return '<a target="_parent" href="' + url + '">'+cnocm+'</a>';
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
tkelas.Close()
Set tkelas = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

