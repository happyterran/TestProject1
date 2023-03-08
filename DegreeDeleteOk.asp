<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->

<%
On Error Resume Next

Dim IDX
IDX = GetParaMeter(Request.Querystring("IDX") , "")

Dim StrSql, Rs
StrSql = StrSql & vbCrLf & "delete Degree2 where IDX='" & IDX & "'"
'Response.Write StrSql
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
            document.location.href="DegreeSetting.asp?MessageType=error&Message=차수와 등록기한 삭제가 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=차수정보 삭제 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
