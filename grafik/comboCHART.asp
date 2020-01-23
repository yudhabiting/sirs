<script type="text/javascript">
var ctabel = <%=ctabel%>;

if (ctabel=='11') {

   var chart = new Highcharts.Chart({
   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
      "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
        chart: {
            zoomType: 'xy',
			renderTo: 'container',
			options3d: {
					enabled: true,
					alpha: 0,
					beta: 0,
					depth: 50,
					viewDistance: 25
				},
                type: 'column'				
		},
		
        title: {
			 fontSize: '16px',
			 fontWeight: 'bold',
			 textTransform: 'uppercase',
             text: '<%=cjudul%>'
        },
		plotOptions: {
            column: {
                depth: 25
            }
        },
        xAxis: [{
            categories: categories,
            crosshair: true
        }],
        yAxis: 
		[
			{
				min: 0,
				title: {
					text: '<%=clegend0%>'
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
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
			series: [
			{
				name: '<%=clegend1%>',
				type: '',
				data: dataku1,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 40
	
			}, {
				name: '<%=clegend2%>',
				type: '',
				data: dataku2,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 30		
			}, {
				name: '<%=clegend3%>',
				type: '',
				data: dataku3,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 20		
			}, {
				name: '<%=clegend4%>',
				type: '',
				data: dataku4,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 10		
			}
		  ]

    });


}
else if (ctabel=='12') {

	var chart = new Highcharts.Chart({
	   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
		  "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
			chart: {
				zoomType: 'xy',
				renderTo: 'container',
				options3d: {
						enabled: true,
						alpha: 0,
						beta: 0,
						depth: 50,
						viewDistance: 25
					},
                type: 'column'				
			},
			title: {
				 fontSize: '16px',
				 fontWeight: 'bold',
				 textTransform: 'uppercase',
				 text: '<%=cjudul%>'
			},
			plotOptions: {
				column: {
					depth: 25
				}
			},
			xAxis: [{
				categories: categories,
				crosshair: true
			}],
			yAxis: 
			[
				{
					min: 0,
					title: {
						text: '<%=clegend0%>'
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
				shared: true
			},
			legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'middle',
				borderWidth: 0
			},
				series: [
				{
					name: '<%=clegend1%>',
					type: '',
					data: dataku1,
					tooltip: {
						valueSuffix: ''
					}
		
				}
			  ]
	
		});
}


else if (ctabel=='1002'||ctabel=='2002') {

   var chart = new Highcharts.Chart({
   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
      "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
        chart: {
            zoomType: 'xy',
			renderTo: 'container',
			options3d: {
					enabled: true,
					alpha: 0,
					beta: 0,
					depth: 50,
					viewDistance: 25
				},
                type: 'column'				
		},
		
        title: {
			 fontSize: '16px',
			 fontWeight: 'bold',
			 textTransform: 'uppercase',
             text: '<%=cjudul%>'
        },
		plotOptions: {
            column: {
                depth: 25
            }
        },
        xAxis: [{
            categories: categories,
            crosshair: true
        }],
        yAxis: 
		[
			{
				min: 0,
				title: {
					text: '<%=clegend0%>'
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
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
			series: [
			{
				name: '<%=clegend1%>',
				type: '',
				data: dataku1,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 60
	
			}, {
				name: '<%=clegend2%>',
				type: '',
				data: dataku2,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 50		
			}, {
				name: '<%=clegend3%>',
				type: '',
				data: dataku3,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 40		
			}, {
				name: '<%=clegend4%>',
				type: '',
				data: dataku4,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 30		
			}, {
				name: '<%=clegend5%>',
				type: '',
				data: dataku5,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 20		
			}, {
				name: '<%=clegend6%>',
				type: '',
				data: dataku6,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 10		
			}
		  ]

    });


}



else if (ctabel=='1003'||ctabel=='2003') {

   var chart = new Highcharts.Chart({
   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
      "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
        chart: {
            zoomType: 'xy',
			renderTo: 'container',
			options3d: {
					enabled: true,
					alpha: 0,
					beta: 0,
					depth: 50,
					viewDistance: 25
				},
                type: 'column'				
		},
		
        title: {
			 fontSize: '16px',
			 fontWeight: 'bold',
			 textTransform: 'uppercase',
             text: '<%=cjudul%>'
        },
		plotOptions: {
            column: {
                depth: 25
            }
        },
        xAxis: [{
            categories: categories,
            crosshair: true
        }],
        yAxis: 
		[
			{
				min: 0,
				title: {
					text: '<%=clegend0%>'
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
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
			series: [
			{
				name: '<%=clegend1%>',
				type: '',
				data: dataku1,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 100
	
			}, {
				name: '<%=clegend2%>',
				type: '',
				data: dataku2,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 90		
			}, {
				name: '<%=clegend3%>',
				type: '',
				data: dataku3,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 80		
			}, {
				name: '<%=clegend4%>',
				type: '',
				data: dataku4,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 70		
			}, {
				name: '<%=clegend5%>',
				type: '',
				data: dataku5,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 60		
			}, {
				name: '<%=clegend6%>',
				type: '',
				data: dataku6,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 50		
			}, {
				name: '<%=clegend7%>',
				type: '',
				data: dataku7,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 40		
			}, {
				name: '<%=clegend8%>',
				type: '',
				data: dataku8,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 30		
			}, {
				name: '<%=clegend9%>',
				type: '',
				data: dataku9,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 20		
			}, {
				name: '<%=clegend10%>',
				type: '',
				data: dataku10,
				tooltip: {
					valueSuffix: ''
				},
                zIndex: 10		
			}
		  ]

    });


}


else if (ctabel=='1004'||ctabel=='1005'||ctabel=='1006'||ctabel=='1007'||ctabel=='2004') {

	var chart = new Highcharts.Chart({
	   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
		  "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
			chart: {
				zoomType: 'xy',
				renderTo: 'container',
				options3d: {
						enabled: true,
						alpha: 0,
						beta: 0,
						depth: 50,
						viewDistance: 25
					},
                type: 'column'			
			},
			title: {
				 fontSize: '16px',
				 fontWeight: 'bold',
				 textTransform: 'uppercase',
				 text: '<%=cjudul%>'
			},
			plotOptions: {
				column: {
					depth: 25
				}
			},
			xAxis: [{
				categories: categories,
				crosshair: true
			}],
			yAxis: 
			[
				{
					min: 0,
					title: {
						text: '<%=clegend0%>'
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
				shared: true
			},
			legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'middle',
				borderWidth: 0
			},
				series: [
				{
					name: '<%=clegend1%>',
					type: '',
					data: dataku1,
					tooltip: {
						valueSuffix: ''
					},
                zIndex: 10
		
				}
			  ]
	
		});




}



else {

	var chart = new Highcharts.Chart({
	   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
		  "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
			chart: {
				zoomType: 'xy',
				renderTo: 'container',
				options3d: {
						enabled: true,
						alpha: 0,
						beta: 0,
						depth: 50,
						viewDistance: 25
					},
                type: 'column'			
			},
			title: {
				 fontSize: '16px',
				 fontWeight: 'bold',
				 textTransform: 'uppercase',
				 text: '<%=cjudul%>'
			},
			plotOptions: {
				column: {
					depth: 25
				}
			},
			xAxis: [{
				categories: categories,
				crosshair: true
			}],
			yAxis: 
			[
				{
					min: 0,
					title: {
						text: '<%=clegend0%>'
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
				shared: true
			},
			legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'middle',
				borderWidth: 0
			},
				series: [
				{
					name: '<%=clegend1%>',
					type: '',
					data: dataku1,
					tooltip: {
						valueSuffix: ''
					},
                zIndex: 20
		
				}, {
					name: '<%=clegend2%>',
					type: '',
					data: dataku2,
					tooltip: {
						valueSuffix: ''
					},
                zIndex: 10		
				}
			  ]
	
		});




}
	
$(function () {

    function showValues() {
        $('#R0-value').html(chart.options.chart.options3d.alpha);
        $('#R1-value').html(chart.options.chart.options3d.beta);
    }

    // Activate the sliders
    $('#R0').on('change', function () {
        chart.options.chart.options3d.alpha = this.value;
        showValues();
        chart.redraw(false);
    });
    $('#R1').on('change', function () {
        chart.options.chart.options3d.beta = this.value;
        showValues();
        chart.redraw(false);
    });

    showValues();

});

		</script>	
