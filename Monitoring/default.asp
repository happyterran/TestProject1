<script language = "javascript">
	var url = "/Monitoring/monitoring_DBASE.asp"

	var h = (screen.height) ? (screen.height - 800) / 2 : 100;	
	var w = (screen.width) ? (screen.width - 1035) / 2 : 100;

	window.open(url, "metis_monitoring","fullscreen,toolbar=no,status=no,location=no,directories=no,scrollbars=YES,resizable=NO,width=1010,height=750,top="+h+",left="+w);

	//''@ 팝업 창 생성 후 부모창은 닫아 주자.

	if (navigator.appVersion.indexOf("MSIE 7.0") >= 0){
		window.open(url + "blink.html", "_self").close();
	} else if (navigator.appVersion.indexOf("MSIE 8.0") >= 0){
		window.open(url + "blink.html", "_self").close();
	} else if (navigator.appVersion.indexOf("MSIE 9.0") >= 0){
		window.open(url + "blink.html", "_self").close();
	}else {

		self.opener = self;
		self.close();

	}

</script>