<%@LANGUAGE="VBSCRIPT" %>
<!--#include file="../../Connections/datatokonusantara.asp" -->
<%
Dim tbulan
Dim tbulan_numRows

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datatokonusantara_STRING
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

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Contoh Grafik</title>

<link rel="stylesheet" type="text/css" href="../../include/jqueryeasyui/themes/metro-red/easyui.css">
<link rel="stylesheet" type="text/css" href="../../include/jqueryeasyui/demo/demo.css"/>
<script type="text/javascript" src="../../include/jqueryeasyui/jquery.min.js"></script>
<script type="text/javascript" src="../../include/jqueryeasyui/jquery.easyui.min.js"></script>

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
<script type="text/javascript">
//var dataku = [3,6,5,1,2,3,1,6];

var dataku1 = [];
var categories = [];	    
</script>

<script type="text/javascript">

function ajaxTANGGAL() {
$.ajax({ 
    type: "POST", 
    url: "hitungtanggal.asp", 
    data: 
	{ 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value ,
	ctabel: '01'
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");

	kategoriku1=kategoriku0[0];
	kategoriku2=kategoriku0[1];
//	alert(kategoriku4);

	var kategoriku_1 = kategoriku1.split(","); 
	var kategoriku_2 = $.map(kategoriku2.split(','), function(value){
		return parseInt(value, 10);
	});
 
   chart.xAxis[0].setCategories(kategoriku_1);
   chart.series[0].setData(kategoriku_2);


},
    error: function(){
    alert("Gagal");
}
           });
}
</script>

<script type="text/javascript" src="../../include/Highcharts/jquery171.min.js"></script>
</head>
	<body>
<form action="" method="POST"  name="form1">
    
  <table width="100%">
    <tr class="fontku">
      <td>Mulai Tanggal</td>
      <td align="center">:</td>
      <td><input type="text" name="dtgltrans1" id="dtgltrans1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/></td>
    </tr>
    <tr class="fontku">
      <td>Sampai Tanggal</td>
      <td align="center">:</td>
      <td><input type="text" name="dtgltrans2" id="dtgltrans2" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/></td>
    </tr>
    <tr>
      <td width="11%">&nbsp;</td>
      <td width="2%">&nbsp;</td>
      <td width="87%">
      <input type="button" name="button1" id="button1" value="lihat" onClick="ajaxTANGGAL()">
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>            

<script src="../../include/Highcharts/Highcharts/js/highcharts.js"></script>
<script src="../../include/Highcharts/exporting.js"></script>
<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
<script type="text/javascript">
var chart = new Highcharts.Chart({
        chart: {
            zoomType: 'xy',
			renderTo: 'container'
		},
        title: {
            text: 'Grafik Pemasukan & Pengeluaran',
            x: -20 //center
        },
        subtitle: {
            text: 'Tahun 2015 Toko Nusantara',
            x: -20
        },
        xAxis: {
				categories: categories
        },
        yAxis: 
		[
			{
				min: 0,
				title: {
					text: 'Jumlah1'
				},
				plotLines: [{
					value: 0,
					width: 1,
					color: '#808080'
				}],
				labels: {
					formatter: function () {
						return Highcharts.numberFormat(this.value,0);
					}
				}		
			}
			
		],
	    tooltip: {
	       formatter: function() {
	       		return '<b>'+ this.series.name +'</b><br/>'+
	       		this.x +': Rp.'+ Highcharts.numberFormat(this.y,0);
	      	}
	    },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
         series: 
		 [
		 {
			type: 'spline',
			name: 'Pemasukan',
			data: dataku1
		 }
		 ]

});

$('#export').click(function() {
    chart.exportChart();
});

		</script>	

</body>
</html>
