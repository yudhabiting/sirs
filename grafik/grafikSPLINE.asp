<%@LANGUAGE="VBSCRIPT" %>

<!--#include file="../../Connections/datatokonusantara.asp" -->
<%
Dim tbulan
Dim tbulan_numRows

Set tbulan = Server.CreateObject("ADODB.Recordset")
tbulan.ActiveConnection = MM_datatokonusantara_STRING
tbulan.Source = "SELECT revenue,overhead from tbulan"
tbulan.CursorType = 0
tbulan.CursorLocation = 2
tbulan.LockType = 1
tbulan.Open()
tbulan_numRows = 0

rettxt = "["



rettxt = rettxt & "{""name"": ""Pemasukan"",""data"": ["
While (NOT tbulan.EOF)
	rettxt = rettxt & tbulan.Fields.Item("revenue").Value & ","
	tbulan.MoveNext()
	Wend
If (tbulan.CursorType > 0) Then
	tbulan.MoveFirst
Else
	tbulan.Requery
End If
rettxt = left(rettxt,len(rettxt)-1) &  "]}"



rettxt = rettxt & ","




rettxt = rettxt & "{""name"": ""Pengeluaran"",""data"": ["
While (NOT tbulan.EOF)
	rettxt = rettxt & tbulan.Fields.Item("overhead").Value & ","
	tbulan.MoveNext()
	Wend
If (tbulan.CursorType > 0) Then
	tbulan.MoveFirst
Else
	tbulan.Requery
End If
rettxt = left(rettxt,len(rettxt)-1) &  "]}"



rettxt = rettxt & "]"
result=rettxt

tbulan.Close()
Set tbulan = Nothing
%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Contoh Grafik</title>

<script type="text/javascript" src="../../include/Highcharts/jquery171.min.js"></script>
        
<script type="text/javascript">
var data = <%=rettxt%>;
var categories = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni','Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];	    
//var categories = [1,2,3,4,5,6,7,8,9,10,11,12];	    
	
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'spline'
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
            categories: categories,
            title: {
                text: 'Bulan'
            }
        },
        yAxis: {
            title: {
                text: 'Rupiah'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
	    tooltip: {
	       formatter: function() {
	       		return '<b>'+ this.series.name +'</b><br/>'+
	       		this.x +': '+ this.y;
	      	}
	    },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
         plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: data
    });
});
		</script>	</head>
	<body>
<script src="../../include/Highcharts/Highcharts/js/highcharts.js"></script>
<script src="../../include/Highcharts/exporting.js"></script>

<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>

</body>
</html>
