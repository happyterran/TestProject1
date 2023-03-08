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
		<a href="popup.contents.asp">팝업 테스트</a><br/>
		<a href="javascript: $popup.resize(0,0,window.name); setTimeout($popup.opener().document.location.href='default.asp' ,2000)">팝업 테스트</a><br/>
		<br/>
		<script type="text/javascript">
			document.write("Frame Name : "+window.name);
		</script>
		<br/>
		<br/>
			<input type="button" value="$popup.open(...)" onClick="$popup.open('/popup.contents.asp');"  /> &nbsp;  
			<input type="button" value="$popup.close()" onClick="$popup.close();"  /><br/>
		<br/>
			<input type="button" value="$popup.opener().document.title" onClick="alert($popup.opener().document.title);"  /><br/>
		<br/>
			<input type="button" value="$popup.showAlt()" onClick="$popup.showAlt();"  /> &nbsp; 
			<input type="button" value="$popup.hideAlt()" onClick="$popup.hideAlt();"  /><br/>
			<input type="button" value="$popup.resize()" onClick="$popup.resize(0,0,window.name);"  /><br/>
		<br/>
		
		<hr size="1" />
		<form name="thisForm">
			<div style="padding:15px 0 10px 0;"><h3>Form 전송 테스트 (POST/GET 모두 사용가능)</h3></div>
			<strong>+ Method</strong> : <select name="methodType" style="width:150px;">
						<option value="POST">POST</option>
						<option value="GET">GET</option>
					</select><br/>
			+ Param1 : <input type="text" name="param1" style="width:150px;margin:6px 0 3px 0;" /><br/>
			+ Param2 : <input type="text" name="param2" style="width:150px;margin:3px 0 3px 0;" /><br/>
			<input type="button" id="btn-submit"  value='$popup.submit( "FormName" );' style="margin:5px 0 5px 0;" /><br/>
		</form>
	</div>
</div>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->