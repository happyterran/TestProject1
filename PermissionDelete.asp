<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
On Error Resume Next
Dim i, j, StrSql, item, MemberIDHidden
If Request.Form("Checkbox").count>0 Then
	StrSql =          "delete Member"

	j = Request.Form("Checkbox")(1)
	MemberIDHidden = Request.Form("MemberIDHidden")(j)
	StrSql = StrSql & vbCrLf & "where MemberID ='" & MemberIDHidden & "'"

	for i = 2 to Request.Form("Checkbox").count
		j = Request.Form("Checkbox")(i)
	MemberIDHidden = Request.Form("MemberIDHidden")(j)
		StrSql = StrSql & vbCrLf & "or MemberID ='" & MemberIDHidden & "'"
	next

	'Response.Write StrSql
	Dbcon.Execute StrSql
End If

%>
<!-- #include virtual = "/Include/DbClose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="Permission.asp?MessageType=error&Message=사용자 삭제가 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="Permission.asp?MessageType=success&Message=사용자 정보 삭제 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
