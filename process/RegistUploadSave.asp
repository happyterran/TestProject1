<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim StrSql
On Error Resume Next


StrSql = StrSql & vbCrLf & "insert into RegistRecord"
StrSql = StrSql & vbCrLf & "(SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime)"
StrSql = StrSql & vbCrLf & "select SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime"
StrSql = StrSql & vbCrLf & "from ##RegistRecord "
StrSql = StrSql & vbCrLf & "if @@error = 0 drop table ##RegistRecord"


'PrintSql StrSql
'Response.End
Dbcon.Execute(StrSql)
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;" onload="document.MenuForm.submit();self.close();">
<!--<body style="padding-top:0;">-->

<FORM METHOD="POST" ACTION="/RootRegist.asp" Name="MenuForm" testtarget="Root">
    <%If Err.Description <> "" Then%>
        <input type="hidden" name="MessageType"      value="error">
        <input type="hidden" name="Message"          value="등록결과 업로드에 실패했습니다..    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="등록결과 업로드 완료.">
    <%End If%>    
</FORM>

</body>
</html>

