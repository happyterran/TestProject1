<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim StrSql
On Error Resume Next
StrSql =                   ""
StrSql = StrSql & vbCrLf & "insert into StudentTable"
StrSql = StrSql & vbCrLf & "( SubjectCode, StudentNumber, StudentName, Ranking, Score, AccountNumber, Tel1, Tel2, Tel3, Tel4, Tel5, Address, Citizen1, Citizen2, ETC1, ETC2, ETC3, InsertTime )"
StrSql = StrSql & vbCrLf & "select ETx.SubjectCode, ETx.StudentNumber, ETx.StudentName, ETx.Ranking, ETx.Score, ETx.AccountNumber, ETx.Tel1, ETx.Tel2, ETx.Tel3, ETx.Tel4, ETx.Tel5, ETx.Address, ETx.Citizen1, ETx.Citizen2, ETx.ETC1, ETx.ETC2, ETx.ETC3, ETx.InsertTime"
StrSql = StrSql & vbCrLf & "from ##StudentTable ETx" & vbCrLf
StrSql = StrSql & vbCrLf & "if @@error = 0 drop table ##StudentTable" & vbCrLf
'PrintSql StrSql
'Response.End
Dbcon.Execute(StrSql)
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <script type="text/javascript">
        <%if Err.Description <> "" then%>
            alert('업로드에 실패했습니다.\n<%=Replace(Err.Description, "'", " ")%>');
            self.close();
        <%Else%>
            //alert("정상적으로 완료 되었습니다");
			opener.document.location.href='/RootStudent.asp';
            self.close();
        <%End If%>
    </script>
</head>
<body style="padding-top:0;">
</body>
</html>
