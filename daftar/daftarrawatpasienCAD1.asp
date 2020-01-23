<%@LANGUAGE="VBSCRIPT"%>
<%
if trim(Session("MM_Username"))="" then
			Response.Redirect("../tolak.asp")
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->

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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Daftar Kunjungan Pasien</title>
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


<script language="javascript" type="text/javascript">
function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
</script>
<script type="text/javascript">
<!--

function caridata()
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
var cnocm = document.forms['form1'].elements['cnocm'].value;
var cnopas = document.forms['form1'].elements['cnopas'].value;
var cnama = document.forms['form1'].elements['cnama'].value;
var calamat = document.forms['form1'].elements['calamat'].value;
var cstatuspasien = document.forms['form1'].elements['cstatuspasien'].value;

	$('#dg').datagrid({  
			   url:'../include/daftartransaksiJSON.asp?cnocm='+encodeURIComponent(cnocm)+'&cnopas='+encodeURIComponent(cnopas)+'&cnama='+encodeURIComponent(cnama)+'&calamat='+encodeURIComponent(calamat)+'&cstatuspasien='+encodeURIComponent(cstatuspasien)+'&ctabel=transaksi04',
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
margin-top:130px;
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
width:250px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

-->
</style>
</head>
<body onLoad="doOnLoad();">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>



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
<a href='#'>Pendaftaran  Pasien</a>
<ul>
<li><a href="../daftar/caripasien.asp" >Cari Pasien</a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=1" >Daftar Tunggu Rawat Jalan</a></li>
<li><a href="../inputdata/daftartunggu.asp?ctunggu=2" >Daftar Tunggu Rawat Inap</a></li>
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


<form action="daftarpasienmondok.asp" method="get" name="form1">
<table width="100%" class="fontku1">
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["ctglmasuk1","ctglmasuk2"]);
		}
	</script>
          <tr>
                <td>&nbsp;</td>
                <td><div align="right">No CM</div></td>
                <td align="center">:</td>
                <td><input name="cnocm" type="text" id="cnocm" value="<%=request.querystring("cnocm")%>" size="10" maxlength="6" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td align="left"><div align="right">No CM Lama </div></td>
            <td align="center">:</td>
            <td><input name="cnopas" type="text" id="cnopas" value="<%=request.querystring("cnopas")%>" /></td>
          </tr>
          <tr>
    <td width="2%">&nbsp;</td>
    <td><div align="right">Nama</div></td>
    <td width="1%" align="center">:</td>
    <td width="87%">
      <input name="cnama" type="text" id="cnama" value="<%=request.querystring("cnama")%>" size="40" maxlength="30" />
      </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">Alamat</div></td>
    <td align="center">:</td>
    <td>
      <input name="calamat" type="text" id="calamat" value="<%=request.querystring("calamat")%>" size="60" maxlength="50" />
    </td>
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
    <td>
      <input name="cari" type="button" id="cari" value="Cari Data" onclick="caridata()"/>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<table align="center" id="dg" class="easyui-datagrid"  style="width:975px;height:auto" title="Daftar Kunjungan Pasien"  idField="notrans"    url="../include/daftartransaksiJSON.asp?cnocm=xxxxx&ctabel=transaksi04"   toolbar="#toolbar" 
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
</tr>
</thead>
</table>

<script>
function linkrawatjalan(value,row){
    var cnotrans = row.notrans;
    var cnocm = row.nocm;

    var url = '../editdata/editrawatpasien.asp?cnotrans='+cnotrans;
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
tkelas.Close()
Set tkelas = Nothing
%>
<%
trumahsakit.Close()
Set trumahsakit = Nothing
%>

