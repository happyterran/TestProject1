<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim Table
Table = Trim(Request.Form("Table"))
'On Error Resume Next
Dim StrSql, Rs
StrSql =                   "truncate table RegistRecord"
StrSql = StrSql & vbCrLf & "truncate table StudentTable"
StrSql = StrSql & vbCrLf & "truncate table SubjectTable"
StrSql = StrSql & vbCrLf & "truncate table StatusRecord"
StrSql = StrSql & vbCrLf & "truncate table SaveFileHistory"
StrSql = StrSql & vbCrLf & "truncate table CallLog"
'Response.Write Sql
'Response.End
Dbcon.Execute(StrSql)
%>

<!-- #include virtual = "/Include/Dbclose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=error&Message=리셋이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=데이터베이스 리셋 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
