<%@LANGUAGE="VBSCRIPT"%>

<%
cstatususer=lcase(trim(Session("MM_statususer")))
if cstatususer="" then
	Response.Redirect("../tolak.asp") 
end if
%>
<% 
if lcase(cstatususer)="root" then 
	chiddenku="true"
	chidden="false"
elseif lcase(cstatususer)="direktur" then
	chiddenku="true"
	chidden="false"
elseif lcase(cstatususer)="keuangan" then
	chiddenku="true"
	chidden="false"
elseif lcase(cstatususer)="EDP" then
	chiddenku="true"
	chidden="false"
elseif lcase(cstatususer)="administrasi" then
	chiddenku="true"
	chidden="false"
else
	chiddenku="hidden"
	chidden="true"
end if
%>

<!--#include file="../Connections/datarspermata.asp" -->
<%
Dim tkodeakuntansi
Dim tkodeakuntansi_numRows

Set tkodeakuntansi = Server.CreateObject("ADODB.Recordset")
tkodeakuntansi.ActiveConnection = MM_datarspermata_STRING
tkodeakuntansi.Source = "SELECT * FROM rspermata.tkodeakuntansi ORDER BY kakuntansi ASC"
tkodeakuntansi.CursorType = 0
tkodeakuntansi.CursorLocation = 2
tkodeakuntansi.LockType = 1
tkodeakuntansi.Open()

tkodeakuntansi_numRows = 0
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
<html >
<head>

<title>Daftar Input Jurnal Harian</title>

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
var dtgltrans1 = document.forms['form1'].elements['dtgltrans1'].value;
var dtgltrans2 = document.forms['form1'].elements['dtgltrans2'].value;

//var ckakuntansi = document.forms['form1'].elements['ckakuntansi'].value;
var ckakuntansi = $('#ckakuntansi').combogrid('getValue');
var cnobukti = document.forms['form1'].elements['cnobukti'].value;
var cketerangan = document.forms['form1'].elements['cketerangan'].value;
var cdebet = document.forms['form1'].elements['cdebet'].value;
var cabaikantgl = document.getElementById('cabaikantgl').checked;
	if (cabaikantgl=='false'||cabaikantgl==''){
			cabaikantgl='0';
		}
			else {
			cabaikantgl='1';
		}
//alert(cabaikantgl);



	$('#dg').datagrid({  
			   url:'../include/transaksiJSON.asp?dtgltrans1='+encodeURIComponent(dtgltrans1)+'&dtgltrans2='+encodeURIComponent(dtgltrans2)+'&ckakuntansi='+encodeURIComponent(ckakuntansi)+'&cnobukti='+encodeURIComponent(cnobukti)+'&cketerangan='+encodeURIComponent(cketerangan)+'&cdebet='+encodeURIComponent(cdebet)+'&cabaikantgl='+encodeURIComponent(cabaikantgl)+'&ctabel=tabel07',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');
//alert(cabaikantgl);


}



function refreshtable1()
{
var dtgltrans1 = document.forms['form1'].elements['dtgltrans1'].value;
var dtgltrans2 = document.forms['form1'].elements['dtgltrans2'].value;

//var ckakuntansi = document.forms['form1'].elements['ckakuntansi'].value;
var ckakuntansi = $('#ckakuntansi').combogrid('getValue');
var cnobukti = document.forms['form1'].elements['cnobukti'].value;
var cketerangan = document.forms['form1'].elements['cketerangan'].value;
var cdebet = document.forms['form1'].elements['cdebet'].value;

var cabaikantgl = document.getElementById('cabaikantgl').checked;
	if (cabaikantgl=='false'||cabaikantgl==''){
			cabaikantgl='0';
		}
			else {
			cabaikantgl='1';
		}


	if (dtgltrans1==''){
			alert(" Kolom Tanggal Kosong, mohon dicek")
			document.forms['form1'].elements['dtgltrans1'].focus();
			return false
		}

			else {

	$('#dg').datagrid({  
			   url:'../include/transaksiJSON.asp?dtgltrans1='+encodeURIComponent(dtgltrans1)+'&dtgltrans2='+encodeURIComponent(dtgltrans2)+'&ckakuntansi='+encodeURIComponent(ckakuntansi)+'&cnobukti='+encodeURIComponent(cnobukti)+'&cketerangan='+encodeURIComponent(cketerangan)+'&cdebet='+encodeURIComponent(cdebet)+'&cabaikantgl='+encodeURIComponent(cabaikantgl)+'&ctabel=tabel07',
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					pageSize:25,
					pageList: [25,50,100,500]
			});  
//	$('#dg').datagrid('reload');

				}

}



function fokusku()
{
//	document.getElementById("button2").disabled = true;
document.getElementById('button1').style.visibility = '<%=chiddenku%>';
}



function isValidDate(ctanggal)
{
if (ctanggal != '') {
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
</script>
<style type="text/css">
<!--

.style12 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 22px;
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
width:250px;
text-indent:15px;
background-color:#089;
}
.drop_menu li:hover ul li a:hover { background:#629; }

-->
</style>
</head>
<body onLoad="doOnLoad();fokusku();">
	  <link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>
			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["dtgltrans1","dtgltrans2"]);
		}
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
                <li><a href="../menuutama.asp">Menu Utama </a></li>
                <li><a href="../master/daftarkodeakuntansi.asp">Daftar Kode Rekening </a></li>
                <li><a href="daftarinputjurnal.asp">Daftar Jurnal Harian </a></li>
                <li><a href="../inputdata/inputjurnal.asp">Input Jurnal Harian</a></li>
          <li><a href="../exit.asp" class="current">Keluar </a></li>
</ul>

</div>   
<br />
<br />
<br />
<br />
<br />
<br />
<br />

<form ACTION="<%=MM_editAction%>" METHOD="POST" name="form1">
 
    <table width="95%" class="fontku1">
      <tr >
        <td colspan="5"></td>
      </tr>
      <tr >
        <td colspan="5" ></td>
      </tr>
      
      <tr >
        <td align="left" class="style4">&nbsp;</td>
        <td height="24" colspan="2" align="left" class="style4">&nbsp;</td>
        <td align="center" class="style4">&nbsp;</td>
        <td class="style4">&nbsp;</td>
      </tr>
      <tr >
        <td width="2%" align="left" class="style4">&nbsp;</td>
        <td height="24" colspan="2" align="left" class="style4"><div  class="style80">Mulai Tanggal  </div></td>
        <td width="2%" align="center" class="style4">:</td>
        <td width="83%" class="style4"><div align="left">
          <input name="dtgltrans1" type="text" id="dtgltrans1" value="<%= DoDateTime((date), 2, 1042) %>" size="15" maxlength="12">
        </div></td>
      </tr>
      <tr >
        <td width="2%" align="left" class="style4">&nbsp;</td>
        <td height="24" colspan="2" align="left" class="style4"><div  class="style80">Sampai Tanggal  </div></td>
        <td width="2%" align="center" class="style4">:</td>
        <td width="83%" class="style4"><div align="left">
          <input name="dtgltrans2" type="text" id="dtgltrans2" value="<%= DoDateTime((date), 2, 1042) %>" size="15" maxlength="12">
        </div></td>
      </tr>
      <tr >
        <td align="left" class="style4">&nbsp;</td>
        <td height="24" colspan="2" align="left" class="style4">&nbsp;</td>
        <td align="center" class="style4">&nbsp;</td>
        <td class="style4"><input type="checkbox" name="cabaikantgl" id="cabaikantgl">
          Abaikan Tanggal</td>
      </tr>
      <tr >
        <td align="left" class="style4">&nbsp;</td>
        <td height="21" colspan="2" align="left" class="style4"><div  class="style80"> Rekening </div></td>
        <td align="center" class="style4">:</td>
        <td class="style4"><div align="left">
          <input name="ckakuntansi" id="ckakuntansi" style="width:300px;">
       <script type="text/javascript">
        $(function(){
            $('#ckakuntansi').combogrid({
                panelWidth:600,
                panelHeight:350,
                url: '../include/masterJSON.asp?ctabel=tabel10',
                idField:'kakuntansi',
                textField:'akuntansi',
                mode:'remote',
                fitColumns:true,
				pagePosition:top,
                pagination:true,
                columns:[[
                    {field:'kakuntansi',title:'Kode',width:60,sortable:true},
                    {field:'akuntansi',title:'Rekening',width:180,sortable:true}
                ]]
            });
        });
    </script>

          
        </div></td>
      </tr>
      <tr>
        <td align="left" class="style4">&nbsp;</td>
        <td height="22" colspan="2" align="left" class="style4"><div class="style80">No Bukti </div></td>
        <td align="center" class="style4">:</td>
        <td class="style4"><div align="left">
          <input name="cnobukti" type="text" id="cnobukti" size="30" maxlength="20">
        </div></td>
      </tr>
      <tr>
        <td align="left" class="style4">&nbsp;</td>
        <td height="21" colspan="2" align="left" class="style4"><div  class="style80">Keterangan</div></td>
        <td align="center" class="style4">:</td>
        <td class="style4"><div align="left">
          <input name="cketerangan" type="text" id="cketerangan" size="70" maxlength="50">
          </div></td>
      </tr>
      <tr>
        <td align="left" class="style4">&nbsp;</td>
        <td height="21" colspan="2" align="left" class="style4"><div  class="style80">Debet / Kredit </div></td>
        <td align="center" class="style4">:</td>
        <td class="style4"><div align="left">
          <select name="cdebet" id="cdebet">
            <option value="">Semua Data</option>
            <option value="D">Debet</option>
            <option value="K">Kredit</option>
            </select>
          </div></td>
      </tr>
      <tr>
        <td align="left" class="style4">&nbsp;</td>
        <td colspan="2" align="left" class="style4">&nbsp;</td>
        <td class="style4">&nbsp;</td>
        <td class="style4"><span class="style80">
          <input name="simpan" type="button" id="simpan" value="Lihat Data"  onClick="refreshtable()"/>
          </span></td>
      </tr>
      <tr>
        <td align="left" class="style4">&nbsp;</td>
        <td colspan="2" align="left" class="style4">&nbsp;</td>
        <td class="style4">&nbsp;</td>
        <td class="style4">&nbsp;</td>
      </tr>
      
      <tr>
        <td colspan="5" align="center" class="style81"></td>
      </tr>
      
      
      <tr>
        <td colspan="5" align="center" class="style81"></td>
      </tr>
    </table>
      
<table align="center" id="dg" class="easyui-datagrid"  style="width:975px;height:auto" title="Daftar Input Jurnal Harian"  idField="nourut"    url="../include/transaksiJSON.asp?dtgltrans1='xxxxx'&ctabel=tabel07"   toolbar="#toolbar" 
data-options="  rownumbers:true,
                singleSelect:true,
                pagination:true,
				pageSize:25,
				pageList: [25,50,100,500]
                ">
<thead data-options="frozen:true">
<tr>
<th field="notrans" width="50px" align="center" sortable="true" hidden="true">Nomer</th>
<th field="tgltrans" width="100px" align="center" sortable="true"  >Tanggal</th>
<th field="kakuntansi" width="120px" align="center" sortable="true"  >Kode Rekening</th>
<th field="akuntansi" width="225px" align="left" sortable="true" >Rekening</th>
</tr>
</thead >
<thead >
<tr>
<th field="nobukti" width="100px" align="center" sortable="true"  data-options="editor:{type:'text'}">No Bukti</th>
<th field="keterangan" width="275px" align="left" sortable="true"  data-options="editor:{type:'text'}">Keterangan</th>
<th field="rupiah" width="75px" align="center" sortable="true"  data-options="editor:{type:'text'}">Rupiah</th>
<th field="debet" width="55px" align="center" sortable="true"  data-options="editor:{type:'text'}">Debet</br>/ Kredit</th>
<th field="statusfinal" width="75px" align="center" sortable="true"  >Transaksi </br>Final</th>

</tr>
</thead>
</table>

<script type="text/javascript">

		
$(function()
	{

		$('#dg').datagrid('enableCellEditing');

		refreshtable()

	});

        </script>


<script type="text/javascript">

function saverow(){

	var selectedrow = $('#dg').datagrid('getSelected');
	var rowIndex = $('#dg').datagrid('getRowIndex', selectedrow);
	$('#dg').datagrid('endEdit',rowIndex);
 
	var rows = $('#dg').datagrid('getChanges');
	$.each(rows, function(i, row) {
		 var index = $('#dg').datagrid('getRowIndex', row);


			notrans = $('#dg').datagrid('getRows')[index]['notrans']
			kakuntansi = $('#dg').datagrid('getRows')[index]['kakuntansi']
			akuntansi = $('#dg').datagrid('getRows')[index]['akuntansi']
			nobukti = $('#dg').datagrid('getRows')[index]['nobukti']
			keterangan = $('#dg').datagrid('getRows')[index]['keterangan']
			rupiah = $('#dg').datagrid('getRows')[index]['rupiah']
			debet = $('#dg').datagrid('getRows')[index]['debet']
			var xmlhttp;
			if (window.XMLHttpRequest)
				 {// code for IE7+, Firefox, Chrome, Opera, Safari
					 xmlhttp=new XMLHttpRequest();
				 }
			else
				 {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				 }
			xmlhttp.open("POST","../include/saveJSON02.asp",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("notrans="+encodeURIComponent(notrans)+"&kakuntansi="+encodeURIComponent(kakuntansi)+"&akuntansi="+encodeURIComponent(akuntansi)+'&nobukti='+encodeURIComponent(nobukti)+'&keterangan='+encodeURIComponent(keterangan)+'&rupiah='+encodeURIComponent(rupiah)+'&debet='+encodeURIComponent(debet)+"&ctabel=tabel15");

//		 alert(yeah);
	});
		refreshtable();
}



function hapusdata(){

	var row = $('#dg').datagrid('getSelected');

	if (row){
	var cnotrans=row.notrans;
	var ckakuntansi=row.kakuntansi;
	var cakuntansi=row.akuntansi;
	var r = confirm("Data Mau Dihapus");
		if (r == true) {
			var xmlhttp;
			if (window.XMLHttpRequest)
				 {// code for IE7+, Firefox, Chrome, Opera, Safari
					 xmlhttp=new XMLHttpRequest();
				 }
			else
				 {// code for IE6, IE5
					  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				 }
			xmlhttp.open("POST","../include/HAPUSDATAGRID.asp",true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("cnotrans="+encodeURIComponent(cnotrans)+"&ckakuntansi="+encodeURIComponent(ckakuntansi)+"&cakuntansi="+encodeURIComponent(cakuntansi)+"&ctabel=tabel05");
			$('#dg').datagrid('reload');
			
		} 
	}
}


function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }


</script>

<div id="toolbar">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="icon:'icon-save',plain:true, disabled:<%=chidden%>"  onClick="saverow()">Simpan Edit</a>
<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" , disabled:<%=chidden%> onClick="hapusdata()">Hapus Data</a>

<a href="javascript:void(0)" class="easyui-linkbutton"  plain="true" icon="icon-undo" onClick="reject()">Batal Edit</a>

<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-reload" onClick="refreshtable()">Refresh</a>
 <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-print"  onclick="CreateFormPage('Print test', $('#dg'));">Print</a>
<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-xls"  onclick="CreateFormPage1('Print test', $('#dg'));">excel</a>

 </div>

 
 <br />
<br />
<br />
 
  
    <input type="hidden" name="MM_insert" value="form1">
  </form>
  

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
tkodeakuntansi.Close()
Set tkodeakuntansi = Nothing
%>
