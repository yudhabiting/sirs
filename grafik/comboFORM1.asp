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

  <table width="100%">
    <tr class="fontku">
      <td>&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>

 <%
if ctabel="01001"  or ctabel="1002"  or ctabel="1003"   or ctabel="1004"   or ctabel="1005"  or ctabel="1006"  or ctabel="1007" or ctabel="02" or ctabel="05" or ctabel="07"   or ctabel="09"  then
%>    

    <tr class="fontku">
      <td>Mulai Tanggal</td>
      <td align="center">:</td>
      <td>
      <input type="text" name="dtgltrans1" id="dtgltrans1" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/>
      </td>
    </tr>
    <tr class="fontku">
      <td>Sampai Tanggal</td>
      <td align="center">:</td>
      <td>
      <input type="text" name="dtgltrans2" id="dtgltrans2" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" value="<%= DoDateTime((date), 2, 1042) %>" style="width:100px"  required="true"/>
      </td>
    </tr>

<%
end if
%>    

<%
if ctabel="02001" or ctabel="2002"  OR ctabel="2003"  OR ctabel="2004" or ctabel="04" or ctabel="06" OR ctabel="08" OR ctabel="10" or ctabel="11" or ctabel="12" then
%>    

    <tr class="fontku">
      <td>Tahun</td>
      <td align="center">:</td>
      <td>
      <input type="text" name="ctahun" id="ctahun"  value="<%=year(date()) %>" style="width:50px"  />
      </td>
    </tr>

<%
end if
%>    

<%
if ctabel="1007"  OR ctabel="2004"  then
%>    

    <tr class="fontku">
                <td>Obat</td>
                <td align="center">:</td>
                <td>
<input id="ckobat" style="width:300px;"></input>
    <script type="text/javascript">
        $(function(){
            $('#ckobat').combogrid({
                panelWidth:600,
                panelHeight:350,
                url: '../include/masterJSON.asp?ctabel=tabel04',
                idField:'kobat',
                textField:'obat',
                mode:'remote',
                fitColumns:true,
				pagePosition:top,
                pagination:true,
                onClickRow:onDblClickRowGRID1,
                onSelect :onDblClickRowGRID1,
                columns:[[
                    {field:'kobat',title:'Kode',width:60,sortable:true},
                    {field:'obat',title:'Obat',width:180,sortable:true}
                ]]
            });
        });

function onDblClickRowGRID1(index,row) {
	cobat = row.obat;
	document.forms['form1'].elements['cnamaobat'].value=cobat;
//	alert(cobat);
}

    </script>
                </td>
              </tr>
			<input name="cnamaobat" id="cnamaobat"  type="hidden" value="" />
<%
end if
%>    


<%
if  ctabel="12" then
%>    

    <tr class="fontku">
                <td>Suplier</td>
                <td align="center">:</td>
                <td>
<input id="cksuplierbarang" style="width:300px;"></input>
    <script type="text/javascript">
        $(function(){
            $('#cksuplierbarang').combogrid({
                panelWidth:800,
                panelHeight:400,
                url: '../../include/comboLISTDATAmaster.asp?ctabel=02&ctampil=Y',
                idField:'ksuplierbarang',
                textField:'suplierbarang',
                mode:'remote',
                fitColumns:true,
				pagePosition:top,
                pagination:true,
                columns:[[
                    {field:'ksuplierbarang',title:'Kode',width:100,sortable:true},
                    {field:'suplierbarang',title:'Suplier',width:600,sortable:true},
                    {field:'alamat',title:'Alamat',width:300,sortable:true},
                    {field:'telp',title:'Telp',width:200,sortable:true}
                ]]
            });
        });
    </script>
                </td>
              </tr>

<%
end if
%>    


<%
if ctabel="1002"  or ctabel="2002"   or ctabel="1004"  or ctabel="1005"  or ctabel="1006" or ctabel="1007"  OR ctabel="2004"  then
%>    

    <tr class="fontku">
      <td>Status Pasien </td>
                <td align="center">:</td>
      <td>
      <select name="cstatuspasien" id="cstatuspasien">
        <option value="">SEMUA DATA</option>
        <option value="1">RAWAT JALAN</option>
        <option value="2">RAWATINAP</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if ctabel="1003" OR ctabel="2003" then
%>    

    <tr class="fontku">
      <td>Status Pasien </td>
                <td align="center">:</td>
      <td>
      <select name="cstatuspasien" id="cstatuspasien">
        <option value="1">RAWAT JALAN</option>
      </select>
      </td>
    </tr>
<%
end if
%>    


<%
if ctabel="01001"   or ctabel="1002"  or ctabel="2002"  or ctabel="1003"  OR ctabel="2003"   or ctabel="1004"  or ctabel="1005"  or ctabel="1006"   or ctabel="1007" or ctabel="2004" or ctabel="02" or ctabel="02001"  or ctabel="04"   or ctabel="05"  or ctabel="06"  or ctabel="07"  or ctabel="08"  or ctabel="09"  or ctabel="10"  or ctabel="11"  or ctabel="12" then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 1</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik1" id="cjenisgrafik1">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    
<%
if ctabel="01001"   or ctabel="1002"  or ctabel="2002"  or ctabel="1003"  OR ctabel="2003" or ctabel="02" or ctabel="02001"  or ctabel="04"   or ctabel="05"  or ctabel="06"  or ctabel="07"  or ctabel="08"  or ctabel="09"  or ctabel="10"  or ctabel="11"  then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 2</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik2" id="cjenisgrafik2">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if ctabel="11"   or ctabel="1002"   or ctabel="2002"  or ctabel="1003"  OR ctabel="2003" then
%>    


    <tr class="fontku">
      <td>Type Grafik Data 3</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik3" id="cjenisgrafik3">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    


<%
if ctabel="11" or ctabel="1002"  or ctabel="2002"  or ctabel="1003"  OR ctabel="2003" then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 4</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik4" id="cjenisgrafik4">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    


<%
if  ctabel="1002" or ctabel="2002"  or ctabel="1003"   OR ctabel="2003" then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 5</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik5" id="cjenisgrafik5">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if  ctabel="1002" or ctabel="2002"  or ctabel="1003"   OR ctabel="2003" then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 6</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik6" id="cjenisgrafik6">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if  ctabel="1003" OR ctabel="2003"   then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 7</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik7" id="cjenisgrafik7">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if  ctabel="1003" OR ctabel="2003"   then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 8</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik8" id="cjenisgrafik8">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if  ctabel="1003" OR ctabel="2003"   then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 9</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik9" id="cjenisgrafik9">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    

<%
if  ctabel="1003" OR ctabel="2003"   then
%>    

    <tr class="fontku">
      <td>Type Grafik Data 10</td>
                <td align="center">:</td>
      <td>
      <select name="cjenisgrafik10" id="cjenisgrafik10">
        <option value="column">COLUMN</option>
        <option value="line">LINE</option>
        <option value="spline">SPLINE</option>
        <option value="area">AREA</option>
        <option value="areaspline">AREASPLINE</option>
        <option value="pie">PIE</option>
      </select>
      </td>
    </tr>
<%
end if
%>    


    <tr class="fontku">
      <td>&nbsp;</td>
      <td align="center">&nbsp;</td>
      <td>
<%
if ctabel="01001"  or  ctabel="02"  or ctabel="07"   or ctabel="09"  then
%>    

      <input type="button" name="button1" id="button1" value="O K" onClick="ajaxTANGGAL()">

<%
elseif ctabel="1002"  then
%>    

      <input type="button" name="button2" id="button2" value="O K" onClick="ajaxTANGGAL1()">

<%
elseif ctabel="1003" then
%>    

      <input type="button" name="button2" id="button2" value="O K" onClick="ajaxTANGGAL2()">

<%
elseif ctabel="1004" OR ctabel="1005"  or ctabel="1006"  then
%>    

      <input type="button" name="button2" id="button2" value="O K" onClick="ajaxTANGGAL3()">

<%
elseif ctabel="1007" then
%>    

      <input type="button" name="button2" id="button2" value="O K" onClick="ajaxTANGGAL4()">



<%
elseif ctabel="02001" or ctabel="04" then
%>    

      <input type="button" name="button3" id="button3" value="O K" onClick="ajaxBULAN()">


<%
elseif ctabel="2002" then
%>    

      <input type="button" name="button3" id="button3" value="O K" onClick="ajaxBULAN1()">

<%
elseif ctabel="2003" then
%>    

      <input type="button" name="button3" id="button3" value="O K" onClick="ajaxBULAN2()">


<%
elseif ctabel="2004" then
%>    

      <input type="button" name="button3" id="button3" value="O K" onClick="ajaxBULAN3()">



<%
elseif ctabel="05" then
%>    

      <input type="button" name="button4" id="button4" value="O K" onClick="ajaxBARANG1()">
<%
elseif ctabel="06"  then
%>    

      <input type="button" name="button5" id="button5" value="O K" onClick="ajaxBARANG2()">

<%
elseif ctabel="08" OR ctabel="10" then
%>    
      <input type="button" name="button6" id="button6" value="O K" onClick="ajaxTAHUN1()">
<%
elseif ctabel="11" then
%>    

      <input type="button" name="button7" id="button7" value="O K" onClick="ajaxTAHUN2()">

<%
elseif ctabel="12" then
%>    

      <input type="button" name="button8" id="button8" value="O K" onClick="ajaxTAHUN3()">


<%
end if
%>    

      </td>
    </tr>

    <tr>
      <td width="11%">&nbsp;</td>
      <td width="2%">&nbsp;</td>
      <td width="87%">&nbsp;</td>
    </tr>
  </table>
