<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'On Error Resume Next
Dim MemberIDHidden,MemberID,MemberName,Grade, StrSql
Dim DialStatus
DialStatus = Request.Form("DialStatus")

StrSql = "begin tran"
StrSql = StrSql & vbCrLf & "update SettingTable set"
StrSql = StrSql & vbCrLf & "	DialStatus ='" & DialStatus & "'"
StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "

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
            document.location.href="Permission.asp?MessageType=error&Message=전화상태 조정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="Permission.asp?MessageType=success&Message=전화상태 조정 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
