<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%Dim SearchTitle, SearchString, GotoPage
'SearchTitle  = getParameter(Request("SearchTitle"),"")
SearchString = getParameter(Request("SearchString"),"")
GotoPage = getParameter(Request("GotoPage"),"")
'Response.write SearchTitle
'Response.write SearchString
'Response.End

On Error Resume Next
'Response.Write getParameter(Request.Form("Checkbox").Count
Dim IDX, SubjectCode, StudentNumber, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo, PluralStudentNumber, InsertTime
Dim i, j, StrSql
If Request.Form("Checkbox").count>0 Then
	StrSql = "begin tran"
	for i= 1 to Request.Form("Checkbox").count
		j = Request.Form("Checkbox")(i)
		IDX             = getParameter(Request.Form("IDXHidden")(j),"")
		SubjectCode     = getParameter(Request.Form("SubjectCode")(j),"")
		StudentNumber   = getParameter(Request.Form("StudentNumber")(j),"")
		Degree          = getParameter(Request.Form("Degree")(j),"")
		Tel             = getParameter(Request.Form("Tel")(j),"")
		UsedLine        = getParameter(Request.Form("UsedLine")(j),"")
		MemberID        = getParameter(Request.Form("MemberID")(j),"")
		SaveFile        = getParameter(Request.Form("SaveFile")(j),"")
        SaveFile        = Replace(SaveFile, ".wav", "")
		Result          = getParameter(Request.Form("Result")(j),"")
        Result          = CastReverseResult(Result)
		Receiver        = getParameter(Request.Form("Receiver")(j),"")
        Receiver        = CastReverseReceiver(Receiver)
		Memo            = getParameter(Request.Form("Memo")(j),"")
		PluralStudentNumber= getParameter(Request.Form("PluralStudentNumber")(j),"")
        InsertTime      = getParameter(Request.Form("InsertTime")(j),"")

		StrSql = StrSql & vbCrLf & "update RegistRecord set"
		StrSql = StrSql & vbCrLf & " Degree ='" & Degree & "'"
		StrSql = StrSql & vbCrLf & ",Tel ='" & Tel & "'"
		StrSql = StrSql & vbCrLf & ",UsedLine ='" & UsedLine & "'"
		StrSql = StrSql & vbCrLf & ",MemberID ='" & MemberID & "'"
		StrSql = StrSql & vbCrLf & ",SaveFile ='" & SaveFile & "'"
		StrSql = StrSql & vbCrLf & ",Result ='" & Result & "'"
		StrSql = StrSql & vbCrLf & ",Receiver ='" & Receiver & "'"
		StrSql = StrSql & vbCrLf & ",Memo ='" & Memo & "'"
		StrSql = StrSql & vbCrLf & ",PluralStudentNumber ='" & PluralStudentNumber & "'"
		'StrSql = StrSql & vbCrLf & ",InsertTime ='" & InsertTime & "'"
		StrSql = StrSql & vbCrLf & "where IDX ='" & IDX & "'"

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

<FORM METHOD="POST" ACTION="RootRegist.asp" Name="MenuForm" testtarget="Root">
    <input type="hidden" name="FormSubjectDivision0" value="<%=Session("FormSubjectDivision0")%>">
    <input type="hidden" name="FormSubjectSubject"   value="<%=Session("FormSubjectSubject")%>">
    <input type="hidden" name="FormSubjectDivision1" value="<%=Session("FormSubjectDivision1")%>">
    <input type="hidden" name="FormSubjectDivision2" value="<%=Session("FormSubjectDivision2")%>">
    <input type="hidden" name="FormSubjectDivision3" value="<%=Session("FormSubjectDivision3")%>">
    <input type="hidden" name="SearchString"         value="<%=getParameter(Request.Form("SearchString"),"")%>">
    <!-- <input type="hidden" name="SearchTitle"          value="<%=getParameter(Request.Form("SearchTitle"),"")%>"> -->
    <input type="hidden" name="GotoPage"             value="<%=getParameter(Request.Form("GotoPage"),"")%>">
    
    <%If Err.Description <> "" Then%>
        <input type="hidden" name="MessageType"      value="error">
        <input type="hidden" name="Message"          value="등록결과 수정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="등록결과 수정 완료.">
    <%End If%>
    
</FORM>

</body>
</html>