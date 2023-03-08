<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%Dim Width, asdf
Width = Request.QueryString("width")
asdf = Request.QueryString("asdf")
'Response.Write Width
'Response.Write asdf%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>지원자 세부사항</title>
	<!-- #include virtual = "/Include/Head.asp" -->
<script type="text/javascript" src="/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery.ui.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.popup.contents.js"></script>
<script type="text/javascript">
$(function() {
	$popup.altHtml('<div class="alt-data" style="left:-155px;"><img src="/images/richscript/ui/popup/alt.benefit.member.gif" width="990" height="377" /></div>');
	
	$("#btn-submit").bind("click", function(e) {
		var f = document.thisForm;
		f.method = f.methodType.value;
		f.action = "/popup.contents.form.asp";
		$popup.submit("thisForm");
	})

    $("#ui-popup-contents").width(<%=Width%>);
    
});
</script>
</head>
<body>

<!-- <div id="ui-popup-contents" style="width:1040px;height:auto;"> -->
<div id="ui-popup-contents" style="width:640px;height:auto;">
	<div style="padding:50px;text-align:center;font-family:Dotum,'돋움';font-size:13px;line-height:18px;">



<%''''''''''''''''''''''''''''''DataSniffer 시작%><%Dim item, i%><table border="1" cellpadding="0" cellspacing="0" width="400"><tr><td colspan="2" height="30"><p align="center"><font size="2" face="돋움"color= "#003399"><b>QueryString으로 넘어온것</b></font></td></tr><%For each item in Request.QueryString%><%for i = 1 to Request.QueryString(item).Count%><tr><td width= "150" height= "25"><font face= "돋움"size="2">&nbsp;Request.Querystring("<%=item%>")</font></td><td width= "250" height= "25"><font face= "돋움"size="2">&nbsp;<%=Request.QueryString(item)(i)%></font></td></tr><%next%><%next%><tr><td colspan="2" height="30"><p align="center"><font size="2" face="돋움"color= "#003399"><b>Form으로 넘어온 것</b></font></td></tr><%i=0%><%For each item in Request.Form%><%for i = 1 to Request.Form(item).Count%><tr><td width= "150"height= "25"><font face= "돋움"size="2">&nbsp;Request.form("<%=item%>")</font></td><td width= "250"height= "25"><font face= "돋움"size="2">&nbsp;<%=Request.form(item)(i)%></font></td></tr><%next%><%next%><%response.write "</table>"%><%response.end%><%''''''''''''''''''''''''''''''DataSniffer 끝%>



	</div>
</div>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->