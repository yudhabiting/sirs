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
            zoomType: 'xy'
        },
        title: {
            text: 'Pendapatan & Pengeluaran'
        },
        subtitle: {
            text: 'Toko Nusantara Tahun 2015'
        },
        xAxis: [{
            categories: categories,
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            title: {
                text: 'Pengeluaran',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            opposite: true

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Total',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }

        }, { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Pendapatan',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Total',
            type: 'column',
            yAxis: 1,
            data: <%=rettxt%>,
            tooltip: {
                valueSuffix: ' Rupiah'
            }

        }, {
            name: 'Pendapatan',
            type: 'spline',
            yAxis: 2,
            data: <%=rettxt1%>,
            marker: {
                enabled: false
            },
            dashStyle: 'shortdot',
            tooltip: {
                valueSuffix: ' Rupiah'
            }

        }, {
            name: 'Pengeluaran',
            type: 'spline',
            data: <%=rettxt3%>,
            tooltip: {
                valueSuffix: ' Rupiah'
            }
        }]
    });
});

		</script>	
        </head>
	<body>
<script src="../../include/Highcharts/Highcharts/js/highcharts.js"></script>
<script src="../../include/Highcharts/exporting.js"></script>

<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>

</body>
</html>
