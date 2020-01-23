<%@LANGUAGE="VBSCRIPT" %>
<%
caplikasi =  trim(Session("MM_caplikasi"))
chome="../"
if caplikasi="" then
			Response.Redirect(chome&"../tolak.asp")
end if
%>

<!--#include file="../../Connections/datatokonusantara.asp" -->
<!--#include file="../../include/tableMENUATAS.asp" -->
<%
cjudul = tsubmenujudul.Fields.Item("keterangan").Value
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
<title><%=cjudul%></title>

<link href="../../template/templat08/templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="../../template/menu001/menuku.css" rel="stylesheet" type="text/css" />

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
var dataku2 =  [];

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
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '02' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");

	kategoriku1=kategoriku0[0];
	kategoriku2=kategoriku0[1];
	kategoriku3=kategoriku0[2];
//	alert(kategoriku4);

	var kategoriku_1 = kategoriku1.split(","); 
	var kategoriku_2 = $.map(kategoriku2.split(','), function(value){
		return parseInt(value, 10);
	});
	var kategoriku_3 = $.map(kategoriku3.split(','), function(value){
		return parseInt(value, 10);
	});
 
   chart.xAxis[0].setCategories(kategoriku_1);
   chart.series[0].setData(kategoriku_2);
   chart.series[1].setData(kategoriku_3);


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
<div id="templatemo_container">

  <div id="templatemo_header">
</br>
   	 <img src="../../template/templat08/images/templatemo_site_header.jpg"  />
    </div>
     
  <div id="templatemo_banner">

     	<img src="../../template/templat08/images/templatemo_banner_image.jpg" border="0" />     </div><!-- end of menu -->
    


  

<!--#include file="../../include/menuINPUT.asp" -->





  <div id="templatemo_content">  
    	<div id="templatemo_content_left">


    	  <h1><%=cjudul%></h1>
<form action="" method="POST"  name="form1">
    
  <table width="100%">
    <tr class="fontku">
      <td>&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr class="fontku">
      <td>Mulai Tanggal</td>
      <td align="center">:</td>
      <td><input type="text" name="dtgltrans1" id="dtgltrans1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/></td>
    </tr>
    <tr class="fontku">
      <td>Sampai Tanggal</td>
      <td align="center">:</td>
      <td><input type="text" name="dtgltrans2" id="dtgltrans2" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/>
      <input type="button" name="button1" id="button1" value="O K" onClick="ajaxTANGGAL()"></td>
    </tr>
    <tr>
      <td width="11%">&nbsp;</td>
      <td width="2%">&nbsp;</td>
      <td width="87%">&nbsp;</td>
    </tr>
  </table>
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
            text: '<%=cjudul%>'
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
					text: 'Dalam Rupiah'
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
		
        series: [{
            name: 'Pembelian',
            type: 'spline',
            data: dataku1,
            tooltip: {
                valueSuffix: ''
            }

        }, {
            name: 'Penjualan',
            type: 'spline',
            data: dataku2,
            tooltip: {
                valueSuffix: ''
            }
        }]
    });





		</script>	

          <div class="cleaner_with_height">&nbsp;</div>
      </div> <!-- end of ocntent left -->
        
 
        
        <div class="cleaner">&nbsp;</div>
  </div>
    
     <div id="templatemo_footer_panel">
       <div id="footer_right"> Copyright © 2015 - Kalboya@yahoo.com <br />
       </div>
       <div class="cleaner">&nbsp;</div>
    </div>
</div>

</body>
</html>
<!--#include file="../../include/tableMENUBAWAH.asp" -->
