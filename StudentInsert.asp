<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%Dim SearchTitle, SearchString, GotoPage
SearchTitle  = getParameter(Request("SearchTitle"),"")
SearchString = getParameter(Request("SearchString"),"")
GotoPage = getParameter(Request("GotoPage"),"")
'Response.write SearchTitle
'Response.write SearchString
'Response.End

On Error Resume Next
'Response.Write Request.Form("Checkbox").Count
Dim SubjectCode,StudentNumber,StudentName,Ranking,Score,AccountNumber,Tel1,Tel2,Tel3,Tel4,Tel5,Citizen1,Citizen2,ETC1,ETC2,ETC3
Dim i, j, StrSql

SubjectCode = Request.Form("InsertSubjectCode")
StudentNumber = Request.Form("InsertStudentNumber")
StudentName = getParameter(Request.Form("InsertStudentName"), "")
Ranking = Request.Form("InsertRanking")
Score = Request.Form("InsertScore")
AccountNumber = getParameter(Request.Form("InsertAccountNumber"), "")
Tel1 = Request.Form("InsertTel1")
Tel2 = Request.Form("InsertTel2")
Tel3 = Request.Form("InsertTel3")
Tel4 = Request.Form("InsertTel4")
Tel5 = Request.Form("InsertTel5")
Citizen1 = Request.Form("InsertCitizen1")
Citizen2 = Request.Form("InsertCitizen2")
ETC1 = Request.Form("InsertETC1")
ETC2 = Request.Form("InsertETC2")
ETC3 = Request.Form("InsertETC3")

StrSql = "begin tran"
StrSql = StrSql & vbCrLf & "Insert Into StudentTable ("
StrSql = StrSql & vbCrLf & "	SubjectCode, StudentNumber, StudentName, Ranking, Score, AccountNumber, "
StrSql = StrSql & vbCrLf & "	Tel1, Tel2, Tel3, Tel4, Tel5, "
StrSql = StrSql & vbCrLf & "	Citizen1, Citizen2, ETC1, ETC2, ETC3, InsertTIme"
StrSql = StrSql & vbCrLf & ") values ("
StrSql = StrSql & vbCrLf & "	'"& SubjectCode &"', '"& StudentNumber &"', '"& StudentName &"', "& Ranking &", '"& Score &"', '"& AccountNumber &"', "
StrSql = StrSql & vbCrLf & "	'"& Tel1 &"', '"& Tel2 &"', '"& Tel3 &"', '"& Tel4 &"', '"& Tel5 &"', "
StrSql = StrSql & vbCrLf & "	'"& Citizen1 &"', '"& Citizen2 &"', '"& ETC1 &"', '"& ETC2 &"', '"& ETC3 &"', getdate()"
StrSql = StrSql & vbCrLf & ");"
StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "

'PrintSql StrSql
'Response.End
Dbcon.Execute StrSql
%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;" onload="document.MenuForm.submit();">

<FORM METHOD="POST" ACTION="RootStudent.asp" Name="MenuForm">
    <input type="hidden" name="FormSubjectDivision0" value="<%=Session("FormSubjectDivision0")%>">
    <input type="hidden" name="FormSubjectSubject"   value="<%=Session("FormSubjectSubject")%>">
    <input type="hidden" name="FormSubjectDivision1" value="<%=Session("FormSubjectDivision1")%>">
    <input type="hidden" name="FormSubjectDivision2" value="<%=Session("FormSubjectDivision2")%>">
    <input type="hidden" name="FormSubjectDivision3" value="<%=Session("FormSubjectDivision3")%>">
    <input type="hidden" name="SearchString"         value="<%=Request.Form("SearchString")%>">
    <input type="hidden" name="SearchTitle"          value="<%=Request.Form("SearchTitle")%>">
    <input type="hidden" name="GotoPage"             value="<%=Request.Form("GotoPage")%>">
    <%If Err.Description <> "" Then%>
        <input type="hidden" name="MessageType"      value="error">
        <input type="hidden" name="Message"          value="지원자 입력이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="지원자 입력 완료.">
    <%End If%>
</FORM>

</body>
</html>