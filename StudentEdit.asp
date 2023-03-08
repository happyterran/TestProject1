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
Dim StudentNumberHidden,SubjectCode,StudentNumber,StudentName,Ranking,Score,AccountNumber,Tel1,Tel2,Tel3,Tel4,Tel5,Citizen1,Citizen2,ETC1,ETC2,ETC3
Dim i, j, StrSql
If Request.Form("Checkbox").count>0 Then
	StrSql = "begin tran"
	for i= 1 to Request.Form("Checkbox").count
		j = Request.Form("Checkbox")(i)
		StudentNumberHidden = Request.Form("StudentNumberHidden")(j)
		SubjectCode = Request.Form("SubjectCode")(j)
		StudentNumber = Request.Form("StudentNumber")(j)
		StudentName = getParameter(Request.Form("StudentName")(j), "")
		Ranking = Request.Form("Ranking")(j)
		Score = Request.Form("Score")(j)
		AccountNumber = getParameter(Request.Form("AccountNumber")(j), "")
		Tel1 = Request.Form("Tel1")(j)
		Tel2 = Request.Form("Tel2")(j)
		Tel3 = Request.Form("Tel3")(j)
		Tel4 = Request.Form("Tel4")(j)
		Tel5 = Request.Form("Tel5")(j)
		Citizen1 = Request.Form("Citizen1")(j)
		'Citizen2 = Request.Form("Citizen2")(j)
		ETC1 = Request.Form("ETC1")(j)
		ETC2 = Request.Form("ETC2")(j)
		ETC3 = Request.Form("ETC3")(j)

		StrSql = StrSql & vbCrLf & "update StudentTable set"
		StrSql = StrSql & vbCrLf & "	SubjectCode ='" & SubjectCode & "'"
		StrSql = StrSql & vbCrLf & ",StudentNumber ='" & StudentNumber & "'"
		StrSql = StrSql & vbCrLf & ",StudentName ='" & StudentName & "'"
		StrSql = StrSql & vbCrLf & ",Ranking ='" & Ranking & "'"
		StrSql = StrSql & vbCrLf & ",Score ='" & Score & "'"
		StrSql = StrSql & vbCrLf & ",AccountNumber ='" & AccountNumber & "'"
		StrSql = StrSql & vbCrLf & ",Tel1 ='" & Tel1 & "'"
		StrSql = StrSql & vbCrLf & ",Tel2 ='" & Tel2 & "'"
		StrSql = StrSql & vbCrLf & ",Tel3 ='" & Tel3 & "'"
		StrSql = StrSql & vbCrLf & ",Tel4 ='" & Tel4 & "'"
		StrSql = StrSql & vbCrLf & ",Tel5 ='" & Tel5 & "'"
		StrSql = StrSql & vbCrLf & ",Citizen1 ='" & Citizen1 & "'"
		'StrSql = StrSql & vbCrLf & ",Citizen2 ='" & Citizen2 & "'"
		StrSql = StrSql & vbCrLf & ",ETC1 ='" & ETC1 & "'"
		StrSql = StrSql & vbCrLf & ",ETC2 ='" & ETC2 & "'"
		StrSql = StrSql & vbCrLf & ",ETC3 ='" & ETC3 & "'"
		StrSql = StrSql & vbCrLf & ",InsertTIme = getdate()"
		StrSql = StrSql & vbCrLf & "where StudentNumber ='" & StudentNumberHidden & "'"

	next
	StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "
	
	'PrintSql StrSql
	'Response.End
	Dbcon.Execute StrSql
End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;" onload="document.MenuForm.submit();">

<FORM METHOD="POST" ACTION="RootStudent.asp" Name="MenuForm" testtarget="Root">
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
        <input type="hidden" name="Message"          value="지원자 수정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="지원자 수정 완료.">
    <%End If%>
</FORM>

</body>
</html>