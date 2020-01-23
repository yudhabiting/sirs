<%@LANGUAGE="VBSCRIPT"%>
<%
if lcase(trim(Session("MM_statususer")))="root" then
elseif lcase(trim(Session("MM_statususer")))="direktur" then
elseif lcase(trim(Session("MM_statususer")))="EDP" then
elseif lcase(trim(Session("MM_statususer")))="keuangan" then
elseif lcase(trim(Session("MM_statususer")))="farmasi" then
else 
	Response.Redirect("../tolak.asp") 
end if
%>
<% 
if lcase(cstatususer)="root" then 
	chidden=""
elseif lcase(cstatususer)="keuangan" then
	chidden=""
elseif lcase(cstatususer)="farmasi" then
	chidden=""
else
	chidden=""
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->

<%
Dim tgolobat
Dim tgolobat_cmd
Dim tgolobat_numRows

Set tgolobat_cmd = Server.CreateObject ("ADODB.Command")
tgolobat_cmd.ActiveConnection = MM_datarspermata_STRING
tgolobat_cmd.CommandText = "SELECT * FROM rspermata.tgolobat" 
tgolobat_cmd.Prepared = true

Set tgolobat = tgolobat_cmd.Execute
tgolobat_numRows = 0
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
<%
dtgltrans1 = DoDateTime((date), 2, 1042) 
%>
<html >
<head>

<title>LAP PERINCIAN OBAT PERPASIEN</title>

<link rel="stylesheet" href="../template/templat05/css/style.css" type="text/css" media="all" />
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
<!--



function refreshtable()
{
var cnocm = document.forms['form1'].elements['cnocm'].value;
var cnama = document.forms['form1'].elements['cnama'].value;
var calamat = document.forms['form1'].elements['calamat'].value;
var cnopas = document.forms['form1'].elements['cnopas'].value;


	$('#dg').datagrid({  
			   url:'../include/laporanJSON2.asp?cnocm='+encodeURIComponent(cnocm)+'&cnama='+encodeURIComponent(cnama)+'&calamat='+encodeURIComponent(calamat)+'&cnopas='+encodeURIComponent(cnopas)+'&ctabel=lap03',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					showFooter:true,
					pageSize:50,
					pageList: [50,100,500,1000]
			});  
//	$('#dg').datagrid('reload');

}


//-->
</script>
 

<style type="text/css">
<!--
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
margin-top:150px;
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

 
 
</head>
<body onLoad="fokusku();">
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
<form action="" method="POST"  name="form1">
    

   <table width="100%" align="center" class="fontku1">
   <tr>
     <td>&nbsp;</td>
     <td width="12%"><div align="right">No CM</div></td>
     <td width="1%" align="center">:</td>
     <td width="87%"><input name="cnocm" type="text" id="cnocm" size="10" maxlength="6" /></td>
     </tr>
   <tr>
     <td width="3%">&nbsp;</td>
     <td><div align="right">Nama</div></td>
     <td align="center">:</td>
     <td><input name="cnama" type="text" id="cnama" size="40" maxlength="30" /></td>
     </tr>
   <tr>
     <td>&nbsp;</td>
     <td><div align="right">Alamat</div></td>
     <td align="center">:</td>
     <td><input name="calamat" type="text" id="calamat" size="60" maxlength="50" /></td>
     </tr>
   <tr>
     <td>&nbsp;</td>
     <td><div align="right">No CM Lama </div></td>
     <td align="center">:</td>
     <td><input name="cnopas" type="text" id="cnopas" /></td>
     </tr>
   <tr>
     <td>&nbsp;</td>
     <td><div align="right">Status Berobat</div></td>
     <td align="center">:</td>
     <td><select name="cstatuspasien" id="cstatuspasien">
       <option value="2" <%If (Not isNull(cstatuspasien)) Then If ("2" = CStr(cstatuspasien)) Then Response.Write("selected=""selected""") : Response.Write("")%>>Rawat Inap</option>
     </select></td>
     </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td><input type="button" name="button1" id="button1" value="Lihat Data"  onClick="refreshtable()"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
   </table>

<table align="center" id="dg" class="easyui-datagrid"  style="width:975px;height:auto" title="Daftar Pasien Rawat Inap"  idField="kobat"    url="../include/laporanJSON2.asp?cnocm='+encodeURIComponent(cnocm)+'&cnama='+encodeURIComponent(cnama)+'&calamat='+encodeURIComponent(calamat)+'&cnopas='+encodeURIComponent(cnopas)&ctabel=lap03"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th field="rincianobat" align="center" formatter="formatrincianobat">Rincian Obat</th>
<th field="notrans" width="130px" align="center" sortable="true" >Notrans</th>
<th field="nama" width="250px" align="left" sortable="true" >Nama</th>
</tr>
</thead >
<thead >
<tr>
<th field="nocm" width="75px" align="center" sortable="true" >No CM</th>
<th field="tglmasuk" width="100px" align="center" sortable="true" >Tgl Masuk</th>
<th field="tglkeluar" width="100px" align="center" sortable="true" >Tgl Keluar</th>
<th field="umurthn" width="50px" align="center" sortable="true" >Umur </br>Thn</th>
<th field="umurbln" width="50px" align="center" sortable="true" >Umur </br>Bln</th>
<th field="alamat" width="350px" align="left" sortable="true" >Alamat</th>
<th field="orangtuan" width="200px" align="left" sortable="true" >Penanggungjawab</th>
<th field="kelas" width="250px" align="left" sortable="true" >Ruangan</th>
</tr>
</thead>
</table>



<script type="text/javascript">




 function rincianobatpasien(nocmku,notransku)  
 {
	var r = confirm("Cetak Rincian Obat, Lanjutkan  ??");
	if (r == true) {
//		alert(nocmku);
window.open('rincianobatpasien.asp?cnotrans='+notransku,'winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=yes,scrollbars=yes,resizable=no,width=1500,height=600');
		return false;

	}
	if (r == false) {
//		alert(notransku);
		return false;
	}
}

function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }

function formatrincianobat(value,row){
    var nocm = row.nocm;
    var notrans = row.notrans;
    return '<a href="#"  onclick="return rincianobatpasien(\''+nocm+'\',\''+notrans+'\');"><button>Rincian Obat</button></a>';
    }

 
function formatrp(val,row){
return number_format(val,2,',','.');
};
function number_format(num,dig,dec,sep) {
x=new Array();
s=(num<0?"-":"");
num=Math.abs(num).toFixed(dig).split(".");
r=num[0].split("").reverse();
for(var i=1;i<=r.length;i++){x.unshift(r[i-1]);if(i%3==0&&i!=r.length)x.unshift(sep);}
return s+x.join("")+(num[1]?dec+num[1]:"");
}

</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>





</form>            


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
tgolobat.Close()
Set tgolobat = Nothing
%>
