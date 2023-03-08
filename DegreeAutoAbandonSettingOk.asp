<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->

<%
On Error Resume Next
Dim AutoAbandon
AutoAbandon	 = GetParaMeter(Request.Form("AutoAbandon") , "")

Dim StrSql, Rs
StrSql = "update SettingTable set"
StrSql = StrSql & vbCrLf & " AutoAbandon='" & AutoAbandon & "'"
StrSql = StrSql & vbCrLf & ",insertTime=getdate()"

'PrintSql StrSql
'Response.End
Dbcon.Execute StrSql
%>

<!-- #include virtual = "/Include/DbClose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=error&Message=복수지원 자동포기 설정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
		<script language='javascript'>
			document.location.href="DegreeSetting.asp?MessageType=success&Message=복수지원 자동포기 설정 적용 완료."
		</script>
    <%End If%>
</head>
<body style="padding-top:0;">
</body>
</html>
