<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Contoh Grafik</title>

		<script type="text/javascript" src="../../include/Highcharts/jquery171.min.js"></script>
        
	<script type="text/javascript">
$(function () {
    var chart;
    $(document).ready(function() {
        $.getJSON("../../include/comboGRAFIK.asp", function(json) {
	    
		    chart = new Highcharts.Chart({
	            chart: {
	                renderTo: 'container',
	                type: 'line',
	                marginRight: 130,
	                marginBottom: 25
	            },
	            title: {
	                text: 'Pemasukan & Pengeluaran',
	                x: -20 //center
	            },
	            subtitle: {
	                text: '',
	                x: -20
	            },
	            xAxis: {
	                categories: []
	            },
	            yAxis: {
	                title: {
	                    text: 'R u p i a h'
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
	                verticalAlign: 'top',
	                x: -10,
	                y: 100,
	                borderWidth: 0
	            },
	            series: json
	        });
	    });
    
    });
    
});
		</script>
	</head>
	<body>
  <script src="../../include/Highcharts/Highcharts/js/highcharts.js"></script>
  <script src="../../include/Highcharts/exporting.js"></script>

<div id="container" style="min-width: 400px; height: 300px; margin: 0 auto"></div>

	</body>
</html>
