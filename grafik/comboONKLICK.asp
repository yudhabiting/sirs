<script type="text/javascript">

function ajaxTANGGAL() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 

$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");

	kategoriku1=kategoriku0[0];
	kategoriku2=kategoriku0[1];
	kategoriku3=kategoriku0[2];
//	alert(kategoriku5);

	var kategoriku_1 = kategoriku1.split("=;="); 
	var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
	});
	var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
	});
 
   chart.xAxis[0].setCategories(kategoriku_1);
   chart.series[0].setData(kategoriku_2);
   chart.series[1].setData(kategoriku_3);
   chart.series[0].update({
        type: cjenisgrafik1
    });
   chart.series[1].update({
        type: cjenisgrafik2
    });
//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}


function ajaxTANGGAL1() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var cjenisgrafik3 =  document.forms['form1'].elements['cjenisgrafik3'].value; 
var cjenisgrafik4 =  document.forms['form1'].elements['cjenisgrafik4'].value; 
var cjenisgrafik5 =  document.forms['form1'].elements['cjenisgrafik5'].value; 
var cjenisgrafik6 =  document.forms['form1'].elements['cjenisgrafik6'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");


		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		kategoriku4=kategoriku0[3];
		kategoriku5=kategoriku0[4];
		kategoriku6=kategoriku0[5];
		kategoriku7=kategoriku0[6];


//	alert(kategoriku5);

		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_4 = $.map(kategoriku4.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_5 = $.map(kategoriku5.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_6 = $.map(kategoriku6.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_7 = $.map(kategoriku7.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
 
//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[2].setData(kategoriku_4);
	   chart.series[3].setData(kategoriku_5);
	   chart.series[4].setData(kategoriku_6);
	   chart.series[5].setData(kategoriku_7);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
		chart.series[2].update({
				type: cjenisgrafik3
			});
		chart.series[3].update({
				type: cjenisgrafik4
			});
		chart.series[4].update({
				type: cjenisgrafik5
			});
		chart.series[5].update({
				type: cjenisgrafik6
			});


//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}


function ajaxTANGGAL2() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var cjenisgrafik3 =  document.forms['form1'].elements['cjenisgrafik3'].value; 
var cjenisgrafik4 =  document.forms['form1'].elements['cjenisgrafik4'].value; 
var cjenisgrafik5 =  document.forms['form1'].elements['cjenisgrafik5'].value; 
var cjenisgrafik6 =  document.forms['form1'].elements['cjenisgrafik6'].value; 
var cjenisgrafik7 =  document.forms['form1'].elements['cjenisgrafik7'].value; 
var cjenisgrafik8 =  document.forms['form1'].elements['cjenisgrafik8'].value; 
var cjenisgrafik9 =  document.forms['form1'].elements['cjenisgrafik9'].value; 
var cjenisgrafik10 =  document.forms['form1'].elements['cjenisgrafik10'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");


		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		kategoriku4=kategoriku0[3];
		kategoriku5=kategoriku0[4];
		kategoriku6=kategoriku0[5];
		kategoriku7=kategoriku0[6];
		kategoriku8=kategoriku0[7];
		kategoriku9=kategoriku0[8];
		kategoriku10=kategoriku0[9];
		kategoriku11=kategoriku0[10];


//	alert(kategoriku5);

		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_4 = $.map(kategoriku4.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_5 = $.map(kategoriku5.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_6 = $.map(kategoriku6.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_7 = $.map(kategoriku7.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_8 = $.map(kategoriku8.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_9 = $.map(kategoriku9.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_10 = $.map(kategoriku10.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_11 = $.map(kategoriku11.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
 
//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[2].setData(kategoriku_4);
	   chart.series[3].setData(kategoriku_5);
	   chart.series[4].setData(kategoriku_6);
	   chart.series[5].setData(kategoriku_7);
	   chart.series[6].setData(kategoriku_8);
	   chart.series[7].setData(kategoriku_9);
	   chart.series[8].setData(kategoriku_10);
	   chart.series[9].setData(kategoriku_11);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
		chart.series[2].update({
				type: cjenisgrafik3
			});
		chart.series[3].update({
				type: cjenisgrafik4
			});
		chart.series[4].update({
				type: cjenisgrafik5
			});
		chart.series[5].update({
				type: cjenisgrafik6
			});
		chart.series[6].update({
				type: cjenisgrafik7
			});
		chart.series[7].update({
				type: cjenisgrafik8
			});
		chart.series[8].update({
				type: cjenisgrafik9
			});
		chart.series[9].update({
				type: cjenisgrafik10
			});


//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}



function ajaxTANGGAL3() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 

$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");

	kategoriku1=kategoriku0[0];
	kategoriku2=kategoriku0[1];
//	alert(kategoriku5);

	var kategoriku_1 = kategoriku1.split("=;="); 
	var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
	});
 
   chart.xAxis[0].setCategories(kategoriku_1);
   chart.series[0].setData(kategoriku_2);
   chart.series[0].update({
        type: cjenisgrafik1
    });
//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}


function ajaxTANGGAL4() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
var cnamaobat =  document.forms['form1'].elements['cnamaobat'].value; 

var ckobat = $('#ckobat').combogrid('getValue');

$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	ckobat:  $('#ckobat').combogrid('getValue'), 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
	dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");

	kategoriku1=kategoriku0[0];
	kategoriku2=kategoriku0[1];
//	alert(kategoriku5);

	var kategoriku_1 = kategoriku1.split("=;="); 
	var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
	});

 
   chart.xAxis[0].setCategories(kategoriku_1);
   chart.series[0].setData(kategoriku_2);
   chart.series[0].update({
        type: cjenisgrafik1
    });

//revisi legend
	chart.legend.allItems[0].update({name:cnamaobat});

//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}


function ajaxBULAN() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK2.asp", 
    data: 
	{ 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		
//		alert(kategoriku5);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

	 
	},
    error: function(){
    	alert("Gagal");
	}
  });
}


function ajaxBULAN1() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var cjenisgrafik3 =  document.forms['form1'].elements['cjenisgrafik3'].value; 
var cjenisgrafik4 =  document.forms['form1'].elements['cjenisgrafik4'].value; 
var cjenisgrafik5 =  document.forms['form1'].elements['cjenisgrafik5'].value; 
var cjenisgrafik6 =  document.forms['form1'].elements['cjenisgrafik6'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	ctahun :  document.forms['form1'].elements['ctahun'].value, 
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");


		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		kategoriku4=kategoriku0[3];
		kategoriku5=kategoriku0[4];
		kategoriku6=kategoriku0[5];
		kategoriku7=kategoriku0[6];


//	alert(kategoriku5);

		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_4 = $.map(kategoriku4.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_5 = $.map(kategoriku5.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_6 = $.map(kategoriku6.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_7 = $.map(kategoriku7.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
 
//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[2].setData(kategoriku_4);
	   chart.series[3].setData(kategoriku_5);
	   chart.series[4].setData(kategoriku_6);
	   chart.series[5].setData(kategoriku_7);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
		chart.series[2].update({
				type: cjenisgrafik3
			});
		chart.series[3].update({
				type: cjenisgrafik4
			});
		chart.series[4].update({
				type: cjenisgrafik5
			});
		chart.series[5].update({
				type: cjenisgrafik6
			});


//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}

function ajaxBULAN2() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var cjenisgrafik3 =  document.forms['form1'].elements['cjenisgrafik3'].value; 
var cjenisgrafik4 =  document.forms['form1'].elements['cjenisgrafik4'].value; 
var cjenisgrafik5 =  document.forms['form1'].elements['cjenisgrafik5'].value; 
var cjenisgrafik6 =  document.forms['form1'].elements['cjenisgrafik6'].value; 
var cjenisgrafik7 =  document.forms['form1'].elements['cjenisgrafik7'].value; 
var cjenisgrafik8 =  document.forms['form1'].elements['cjenisgrafik8'].value; 
var cjenisgrafik9 =  document.forms['form1'].elements['cjenisgrafik9'].value; 
var cjenisgrafik10 =  document.forms['form1'].elements['cjenisgrafik10'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
	cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
	ctahun :  document.forms['form1'].elements['ctahun'].value, 
	ctabel:  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
	var kategoriku0 = dtanggalanku.split("{{}}");


		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		kategoriku4=kategoriku0[3];
		kategoriku5=kategoriku0[4];
		kategoriku6=kategoriku0[5];
		kategoriku7=kategoriku0[6];
		kategoriku8=kategoriku0[7];
		kategoriku9=kategoriku0[8];
		kategoriku10=kategoriku0[9];
		kategoriku11=kategoriku0[10];


//	alert(kategoriku5);

		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_4 = $.map(kategoriku4.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_5 = $.map(kategoriku5.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_6 = $.map(kategoriku6.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_7 = $.map(kategoriku7.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_8 = $.map(kategoriku8.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_9 = $.map(kategoriku9.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_10 = $.map(kategoriku10.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_11 = $.map(kategoriku11.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});

 
//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[2].setData(kategoriku_4);
	   chart.series[3].setData(kategoriku_5);
	   chart.series[4].setData(kategoriku_6);
	   chart.series[5].setData(kategoriku_7);
	   chart.series[6].setData(kategoriku_8);
	   chart.series[7].setData(kategoriku_9);
	   chart.series[8].setData(kategoriku_10);
	   chart.series[9].setData(kategoriku_11);

	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
		chart.series[2].update({
				type: cjenisgrafik3
			});
		chart.series[3].update({
				type: cjenisgrafik4
			});
		chart.series[4].update({
				type: cjenisgrafik5
			});
		chart.series[5].update({
				type: cjenisgrafik6
			});
		chart.series[6].update({
				type: cjenisgrafik7
			});
		chart.series[7].update({
				type: cjenisgrafik8
			});
		chart.series[8].update({
				type: cjenisgrafik9
			});
		chart.series[9].update({
				type: cjenisgrafik10
			});


//	chart.options.chart.options3d.enabled=kategoriku5;

},
    error: function(){
    alert("Gagal");
}
           });
}


function ajaxBULAN3() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cstatuspasien =  document.forms['form1'].elements['cstatuspasien'].value; 
var cnamaobat =  document.forms['form1'].elements['cnamaobat'].value; 

var ckobat = $('#ckobat').combogrid('getValue');
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
		ckobat:  $('#ckobat').combogrid('getValue'), 
		cstatuspasien:  document.forms['form1'].elements['cstatuspasien'].value, 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		
//		alert(kategoriku5);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

//revisi legend
	chart.legend.allItems[0].update({name:cnamaobat});

	 
	},
    error: function(){
    	alert("Gagal");
	}
  });
}






function ajaxBARANG1() {
var ckbarang = $('#ckbarang').combogrid('getValue');
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 

if (ckbarang==''){
		alert("Barang  kosong, mohon dicek")
		$('#ckbarang').next().find('input').focus()
		return false
	}
else {
		$.ajax({ 
			type: "POST", 
			url: "comboGRAFIK3.asp", 
			data: 
			{ 
			dtgltrans1:  document.forms['form1'].elements['dtgltrans1'].value, 
			dtgltrans2:  document.forms['form1'].elements['dtgltrans2'].value,
			ckbarang : ckbarang,
			ctabel:  '<%=ctabel%>' 
			},
			dataType: "html",
			success: function(dtanggalanku) {
			var kategoriku0 = dtanggalanku.split("{{}}");
		
			kategoriku1=kategoriku0[0];
			kategoriku2=kategoriku0[1];
			kategoriku3=kategoriku0[2];
//			alert(kategoriku3);
		
			var kategoriku_1 = kategoriku1.split("=;="); 
			var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
			});
			var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
			});
		 
		   chart.xAxis[0].setCategories(kategoriku_1);
		   chart.series[0].setData(kategoriku_2);
		   chart.series[1].setData(kategoriku_3);
		   chart.series[0].update({
				type: cjenisgrafik1
			});
		   chart.series[1].update({
				type: cjenisgrafik2
			});
		//	chart.options.chart.options3d.enabled=kategoriku5;
		
		},
			error: function(){
			alert("Gagal");
		}
	  });
	}
}


function ajaxBARANG2() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var ckbarang = $('#ckbarang').combogrid('getValue');
if (ckbarang==''){
		alert("Barang  kosong, mohon dicek")
		$('#ckbarang').next().find('input').focus()
		return false
	}
else {

$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK3.asp", 
    data: 
	{ 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		ckbarang : ckbarang,
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		
//		alert(kategoriku5);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

	 
		}
	  });
	}
}


function ajaxTAHUN1() {
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 

$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		
//		alert(kategoriku5);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

	 
	},
    error: function(){
    	alert("Gagal");
	}
  });
}


function ajaxTAHUN2() {
var ckbarang = $('#ckbarang').combogrid('getValue');
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
var cjenisgrafik2 =  document.forms['form1'].elements['cjenisgrafik2'].value; 
var cjenisgrafik3 =  document.forms['form1'].elements['cjenisgrafik3'].value; 
var cjenisgrafik4 =  document.forms['form1'].elements['cjenisgrafik4'].value; 
	
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		ckbarang : ckbarang,
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		kategoriku3=kategoriku0[2];
		kategoriku4=kategoriku0[3];
		kategoriku5=kategoriku0[4];
		
//		alert(kategoriku0);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_3 = $.map(kategoriku3.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_4 = $.map(kategoriku4.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});
		var kategoriku_5 = $.map(kategoriku5.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});

//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[1].setData(kategoriku_3);
	   chart.series[2].setData(kategoriku_4);
	   chart.series[3].setData(kategoriku_5);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
		chart.series[1].update({
				type: cjenisgrafik2
			});
		chart.series[2].update({
				type: cjenisgrafik3
			});
		chart.series[3].update({
				type: cjenisgrafik4
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

	 
	},
    error: function(){
    	alert("Gagal");
	}
  });
}


function ajaxTAHUN3() {
var cksuplierbarang = $('#cksuplierbarang').combogrid('getValue');
var cjenisgrafik1 =  document.forms['form1'].elements['cjenisgrafik1'].value; 
	
$.ajax({ 
    type: "POST", 
    url: "comboGRAFIK1.asp", 
    data: 
	{ 
		ctahun :  document.forms['form1'].elements['ctahun'].value, 
		cksuplierbarang : cksuplierbarang,
		ctabel :  '<%=ctabel%>' 
	},
    dataType: "html",
    success: function(dtanggalanku) {
		var kategoriku0 = dtanggalanku.split("{{}}");
	
		kategoriku1=kategoriku0[0];
		kategoriku2=kategoriku0[1];
		
//		alert(kategoriku0);
	
		var kategoriku_1 = kategoriku1.split("=;="); 
		var kategoriku_2 = $.map(kategoriku2.split("=;="), function(value){
			return parseFloat(value.replace(",", "."));
		});

//		alert(kategoriku_5);
	 
	   chart.xAxis[0].setCategories(kategoriku_1);
	   chart.series[0].setData(kategoriku_2);
	   chart.series[0].update({
				type: cjenisgrafik1
			});
//	 chart.options.chart.options3d.alpha=0;
// 	 chart.options.chart.options3d.beta=0;

	 
	},
    error: function(){
    	alert("Gagal");
	}
  });
}

</script>
