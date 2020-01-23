<%

txt1=lcase(trim("analiskesehatan asper bidan dokter direktur EDP farmasi fisioterapi frontoffice gizi keuangan laboratorium perawat radiologi rekammedik umum administrasi"))
txt2=lcase(trim("direktur"))
ccocok="false"
a=Split(txt1)
for each x in a
    txt3=lcase(trim(x))
	if txt2=txt3 then
		ccocok="true"
	end if
next

response.Write(ccocok)



%> 