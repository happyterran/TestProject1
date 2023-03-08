<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
On Error Resume Next
Dim Table
Dim FormDivision0, FormSubject, FormDivision1, FormDivision2, FormDivision3
Dim StrSql
Table = getParameter( request.querystring("Table"), "" )
FormDivision0    =getParameter( request.querystring("FormDivision0"), "" )
FormSubject    =getParameter( request.querystring("FormSubject")  , "" )
FormDivision1    =getParameter( request.querystring("FormDivision1"), "" )
FormDivision2    =getParameter( request.querystring("FormDivision2"), "" )
FormDivision3    =getParameter( request.querystring("FormDivision3"), "" )
Dim FormQuestion
FormQuestion     = Trim(FormDivision0 & " " & FormDivision1 & " " & FormSubject & " " & FormDivision2 & " " & FormDivision3) & " "
'Response.Write FormQuestion
'Response.End
If FormDivision0="" And FormSubject="" And  FormDivision1="" And  FormDivision2="" And  FormDivision3="" Then
    StrSql =                   "truncate Table " & Table
Else
    StrSql =                   "delete a from " & Table & " a"
    StrSql = StrSql & vbCrLf & "join SubjectTable b"
    StrSql = StrSql & vbCrLf & "on a.Subjectcode=b.Subjectcode"
    If FormDivision0<>"" then
    StrSql = StrSql & vbCrLf & "and b.Division0='" & FormDivision0 & "'"
    End If
    If FormSubject<>"" then
    StrSql = StrSql & vbCrLf & "and b.Subject='" & FormSubject & "'"
    End If
    If FormDivision1<>"" then
    StrSql = StrSql & vbCrLf & "and b.Division1='" & FormDivision1 & "'"
    End If
    If FormDivision2<>"" then
    StrSql = StrSql & vbCrLf & "and b.Division2='" & FormDivision2 & "'"
    End If
    If FormDivision3<>"" then
    StrSql = StrSql & vbCrLf & "and b.Division3='" & FormDivision3 & "'"
    End If
End If
'asdf
'PrintSql StrSql
'response.End
Dbcon.Execute(StrSql)%>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<%Dim TableName
Select Case Table
    Case "SubjectTable"
        TableName="모집단위"
    Case "SubjectTableHistory"
        TableName="모집단위 히스토리"
    Case "StudentTable"
        TableName="지원자"
    Case "RegistRecord"
        TableName="등록결과"
    Case "Member"
        TableName="사용자정보"
    Case ""
        TableName=""
End Select%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <SCRIPT LANGUAGE="JavaScript">
            var f=parent.document.MessageForm;
            f.MessageType.value="error";
            f.Message.value="<%If FormQuestion<>"" Then%> <%=FormQuestion%>  <%=TableName%> 삭제에<%Else%> <%=TableName%> 전체삭제에<%End If%> 실패했습니다.    -    <%=Replace(Err.Description, "'", " ")%>";
            f.submit();
        </SCRIPT>
    <%Else%>
        <SCRIPT LANGUAGE="JavaScript">
            var f=parent.document.MessageForm;
            f.MessageType.value="success";
            f.Message.value="<%If FormQuestion<>"" Then%> <%=FormQuestion%>  <%=TableName%> 삭제<%Else%> <%=TableName%> 전체삭제<%End If%> 완료.";
            f.submit();
        </SCRIPT>
    <%End If%>
</head>
<body style="padding-top:0;">
</body>
</html>

