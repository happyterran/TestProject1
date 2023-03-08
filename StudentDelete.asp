<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
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
Dim i, j, StrSql, item, StudentNumberHidden
If Request.Form("Checkbox").count>0 Then
	StrSql =          "delete StudentTable"

	j = Request.Form("Checkbox")(1)
	StudentNumberHidden = Request.Form("StudentNumberHidden")(j)
	StrSql = StrSql & vbCrLf & "where StudentNumber ='" & StudentNumberHidden & "'"

	for i = 2 to Request.Form("Checkbox").count
		j = Request.Form("Checkbox")(i)
	StudentNumberHidden = Request.Form("StudentNumberHidden")(j)
		StrSql = StrSql & vbCrLf & "or StudentNumber ='" & StudentNumberHidden & "'"
	next

	'Response.Write StrSql
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
    <input type="hidden" name="FormSubjectSubject" value="<%=Session("FormSubjectSubject")%>">
    <input type="hidden" name="FormSubjectDivision1" value="<%=Session("FormSubjectDivision1")%>">
    <input type="hidden" name="FormSubjectDivision2" value="<%=Session("FormSubjectDivision2")%>">
    <input type="hidden" name="FormSubjectDivision3" value="<%=Session("FormSubjectDivision3")%>">
    <input type="hidden" name="SearchString"         value="<%=Request.Form("SearchString")%>">
    <input type="hidden" name="SearchTitle"          value="<%=Request.Form("SearchTitle")%>">
    <input type="hidden" name="GotoPage"             value="<%=Request.Form("GotoPage")%>">
    <%If Err.Description <> "" Then%>
        <input type="hidden" name="MessageType"      value="error">
        <input type="hidden" name="Message"          value="지원자 삭제가 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="지원자 삭제 완료.">
    <%End If%>
</FORM>

</body>
</html>