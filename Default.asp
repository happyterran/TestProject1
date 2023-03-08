<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->

<script language = "javascript">

    var url = "/Login.asp"
    var h = (screen.height) ? (screen.height - 90) : 1;	
    var w = (screen.width) ? (screen.width - 20) : 1;
	if (w>1400)
	{
		w = "1400"
	}
    var newwin = window.open(url, "Root","windowscreen,toolbar=no,status=no,location=no,directories=no,scrollbars=YES,resizable=YES,width="+w+",height="+h+",left=0,top=0");
    if (navigator.appVersion.indexOf("MSIE 7.0") >= 0){
        //window.open(url + "blink.html", "_self").close();
    } else if (navigator.appVersion.indexOf("MSIE 8.0") >= 0){
        //window.open(url + "blink.html", "_self").close();
    } else if (navigator.appVersion.indexOf("MSIE 9.0") >= 0){
        //window.open(url + "blink.html", "_self").close();
    }else {
        self.opener = self;
        //self.close();
    }
</script>
<%Response.End%>