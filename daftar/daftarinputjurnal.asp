<%@LANGUAGE="VBSCRIPT"%>
<%
cposisimenu="atas0"
cnotrans=request.QueryString("cnotrans")
cuserid=trim(Session("MM_userid"))
cstatususer=(trim(Session("MM_statususer")))

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
cnourutmenu=request.QueryString("cnourutmenu")
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



-->
</style>
</head>

<body onload="doOnLoad();pilihanfocus();" onfocus="parent_disable();" onclick="parent_disable();">

	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.css"></link>
	<link rel="stylesheet" type="text/css" href="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/skins/dhtmlxcalendar_dhx_skyblue.css"></link>
	<script src="../dhtml/dhtmlxCalendar/dhtmlxCalendar/codebase/dhtmlxcalendar.js"></script>

			  <script>
		var myCalendar;
		function doOnLoad() {
			myCalendar = new dhtmlXCalendarObject(["dtgltrans1","dtgltrans2"]);
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
      
<table align="center" id="dg" class="easyui-datagrid"  style="width:auto;height:auto" title="Daftar Input Jurnal Harian"  idField="nourut"    url="../include/transaksiJSON.asp?dtgltrans1='xxxxx'&ctabel=tabel07"   toolbar="#toolbar" 
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
tkodeakuntansi.Close()
Set tkodeakuntansi = Nothing
%>
