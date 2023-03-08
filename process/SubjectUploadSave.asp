<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim StrSql
On Error Resume Next
Dbcon.begintrans
StrSql =                   "insert into SubjectTable"
StrSql = StrSql & vbCrLf & "select SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, RF11, InsertTime, Quorum2, Myear"
StrSql = StrSql & vbCrLf & "from SubjectTableTemp"
StrSql = StrSql & vbCrLf & "truncate table SubjectTableTemp" & vbCrLf
'PrintSql StrSql
'Response.End
Dbcon.Execute(StrSql)
if Err.Description <> "" then
    Dbcon.RollbackTrans
    Response.Write "<script language='javascript'>alert('모집단위정보 가져오기가 불가능 합니다. - " & Replace(Err.Description, "'", " ") & "');</script>"
else
    Dbcon.CommitTrans
end If
Dbcon.Close
Set Dbcon=Nothing
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <SCRIPT LANGUAGE="JavaScript">
        opener.document.location.reload();
        self.close();
    </SCRIPT>
</head>
<body style="padding-top:0;">
</body>
</html>
