<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim Table
Table = Trim(Request.Form("Table"))
On Error Resume Next
Dim Sql, Rs
Sql = "BACKUP DATABASE [METIS] TO  DISK = N'C:\MSSQL\Backup\MetisBackupButton.bak' WITH  RETAINDAYS = 14, NOFORMAT, NOINIT,  NAME = N'METIS-전체 데이터베이스 백업', SKIP, NOREWIND, NOUNLOAD,  STATS = 10" & vbCrLf
'Response.Write Sql
'Response.End
Dbcon.Execute(sql)

'Set Rs = Server.CreateObject("ADODB.Recordset")
'Rs.Open Sql, Dbcon
'Dim TruncateTableResult
'TruncateTableResult = Rs("TruncateTableResult")
'Response.write TruncateTableResult
'Response.write Err.Description
'Response.End
'Rs.close
'Set Rs = Nothing
%>

<!-- #include virtual = "/Include/Dbclose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=error&Message=백업이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=데이터베이스 백업 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
