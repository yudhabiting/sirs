<html>
<head>

<style>
.ratakanan { text-align : right; }
</style>

<script language="JavaScript">
function formatangka(objek) {
   a = objek.value;
   b = a.replace(/[^\d]/g,"");
   c = "";
   panjang = b.length;
   j = 0;
   for (i = panjang; i > 0; i--) {
     j = j + 1;
     if (((j % 3) == 1) && (j != 1)) {
       c = b.substr(i-1,1) + "." + c;
     } else {
       c = b.substr(i-1,1) + c;
     }
   }
   objek.value = c;
}
function pesan() {
		var cangkaku=document.forms['f'].elements['a'].value;
		var output = cangkaku.replace(/[^\d]/g,"");
		alert(output);

}

</script>

</head>
<body>

<form name="f">
<input type="text"
       name="a"
       onkeyup="formatangka(this)"
       class="ratakanan">
<input type="button" name="button" id="button" value="Button" onClick="pesan();">
</form>

</body>
</html>