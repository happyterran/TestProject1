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
            document.location.href="DegreeSetting.asp?MessageType=error&Message=�������� �ڵ����� ������ �Ұ��� �մϴ�.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
		<script language='javascript'>
			document.location.href="DegreeSetting.asp?MessageType=success&Message=�������� �ڵ����� ���� ���� �Ϸ�."
		</script>
    <%End If%>
</head>
<body style="padding-top:0;">
</body>
</html>
