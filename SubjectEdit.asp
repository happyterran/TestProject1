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
'Response.Write Request.Form("Checkbox").Count
'Response.Write Request.Form("Checkbox")(1)
'Response.Write Request.Form("SubjectCodeHidden")(1)
Dim SubjectCodeHidden, SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum, QuorumFix, RegistrationFee
Dim i, j, StrSql
StrSql = ""
StrSql = StrSql & vbCrLf & "Declare @SubjectCode varchar(30)"
StrSql = StrSql & vbCrLf & "Declare @Division0 varchar(20)"
StrSql = StrSql & vbCrLf & "Declare @Subject varchar(50)"
StrSql = StrSql & vbCrLf & "Declare @Division1 varchar(50)"
StrSql = StrSql & vbCrLf & "Declare @Division2 varchar(20)"
StrSql = StrSql & vbCrLf & "Declare @Division3 varchar(20)"

StrSql = StrSql & vbCrLf & "Declare @QuorumFix int"
StrSql = StrSql & vbCrLf & "Declare @Quorum2 int"

If Request.Form("Checkbox").count>0 Then
	StrSql = StrSql & vbCrLf & "begin tran"
	for i= 1 to Request.Form("Checkbox").count
		j = Request.Form("Checkbox")(i)
		SubjectCodeHidden = Request.Form("SubjectCodeHidden")(j)
		Quorum = Request.Form("Quorum")(j)
		QuorumFix = Request.Form("QuorumFix")(j)

		'히스토리 기록
        StrSql = StrSql & vbCrLf & "select @SubjectCode=SubjectCode, @Division0=Division0, @Subject=Subject, @Division1=Division1, @Division2=Division2, @Division3=Division3 from SubjectTable where SubjectCode ='" & SubjectCodeHidden & "'"
		StrSql = StrSql & vbCrLf & "select @QuorumFix=Quorum from SubjectTable where SubjectCode ='" & SubjectCodeHidden & "'"
		StrSql = StrSql & vbCrLf & "select @Quorum2 = " & Quorum & " - Quorum from SubjectTable where SubjectCode ='" & SubjectCodeHidden & "'"

		'StrSql = StrSql & vbCrLf & "If @Quorum2<>0 "
		StrSql = StrSql & vbCrLf & "begin "
		StrSql = StrSql & vbCrLf & "Insert Into SubjectTableHistory "
		StrSql = StrSql & vbCrLf & "(SubjectCode, Division0, Subject, Division1, Division2, Division3, QuorumFix, Quorum, Quorum2, MemberID, InsertTime)values(" 
		StrSql = StrSql & vbCrLf & "@SubjectCode"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@Division0"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@Subject"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@Division1"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@Division2"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@Division3"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",@QuorumFix"  & vbCrLf'원본
		StrSql = StrSql & vbCrLf & ",'" & Quorum & "'"  & vbCrLf'수정
		StrSql = StrSql & vbCrLf & ",@Quorum2"  & vbCrLf'변동
		StrSql = StrSql & vbCrLf & ",'" & Session("MemberID") & "'"  & vbCrLf
		StrSql = StrSql & vbCrLf & ",getdate()) " 
		StrSql = StrSql & vbCrLf & "End " 

		'업데이트 반영
		StrSql = StrSql & vbCrLf & "update SubjectTable set"
		StrSql = StrSql & vbCrLf & "Quorum ='" & Quorum & "'"
		StrSql = StrSql & vbCrLf & ",QuorumFix ='" & QuorumFix & "'"
		StrSql = StrSql & vbCrLf & ",InsertTIme = getdate()"
		StrSql = StrSql & vbCrLf & "where SubjectCode ='" & SubjectCodeHidden & "'"

	next
	StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "
	
	'PrintSql StrSql
	'Response.End
	Dbcon.Execute StrSql
End If

'Response.End


		Session("FormSubjectDivision3") = Request.Form("FormSubjectDivision3")
'	End If
'	If Request.Form("FormSubjectDivision2") <> Session("FormSubjectDivision2") Then 
		Session("FormSubjectDivision2") = Request.Form("FormSubjectDivision2")
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectDivision1") <> Session("FormSubjectDivision1") Then 
		Session("FormSubjectDivision1") = Request.Form("FormSubjectDivision1")
'		Session("FormSubjectDivision2") = ""
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectSubject") <> Session("FormSubjectSubject") Then
		Session("FormSubjectSubject") = Request.Form("FormSubjectSubject")
'		Session("FormSubjectDivision1") = ""
'		Session("FormSubjectDivision2") = ""
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectDivision0") <> Session("FormSubjectDivision0") Then 
		Session("FormSubjectDivision0") = Request.Form("FormSubjectDivision0")
%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<%'Response.Redirect "RootSubject.asp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;" onload="document.MenuForm.submit();">

<FORM METHOD="POST" ACTION="RootSubject.asp" Name="MenuForm">
    <input type="hidden" name="SelectCount"          value="<%=Session("SelectCount")%>">
    <input type="hidden" name="FormSubjectDivision0" value="<%=Session("FormSubjectDivision0")%>">
    <input type="hidden" name="FormSubjectSubject"   value="<%=Session("FormSubjectSubject")%>">
    <input type="hidden" name="FormSubjectDivision1" value="<%=Session("FormSubjectDivision1")%>">
    <input type="hidden" name="FormSubjectDivision2" value="<%=Session("FormSubjectDivision2")%>">
    <input type="hidden" name="FormSubjectDivision3" value="<%=Session("FormSubjectDivision3")%>">
    <%If Err.Description <> "" Then%>
        <input type="hidden" name="MessageType"      value="error">
        <input type="hidden" name="Message"          value="모집단위 수정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
        <input type="hidden" name="MessageType"      value="success">
        <input type="hidden" name="Message"          value="모집단위 수정 완료.">
    <%End If%>
</FORM>

</body>
</html>