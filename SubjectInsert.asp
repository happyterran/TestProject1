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
Dim SubjectCodeCHK, SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum, QuorumFix, RegistrationFee
Dim i, j, Rs, StrSql, SubjectCodeCount

SubjectCode = getParameter(Request.Form("InsertSubjectCode"), "")
Subject = getParameter(Request.Form("InsertSubject"), "")
Division0 = getParameter(Request.Form("InsertDivision0"), "")
Division1 = getParameter(Request.Form("InsertDivision1"), "")
Division2 = getParameter(Request.Form("InsertDivision2"), "")
Division3 = getParameter(Request.Form("InsertDivision3"), "")
Quorum = Request.Form("InsertQuorum")
QuorumFix = Request.Form("InsertQuorumFix")
RegistrationFee = Request.Form("InsertRegistrationFee")

'Set Rs = Server.CreateObject("ADODB.RecordSet")
'StrSql="select count(*) as SubjectCodeCount from SubjectTable where SubjectCode='" & SubjectCode & "';"
'Rs.Open StrSql, Dbcon, 1, 1
'	SubjectCodeCount = Rs("SubjectCodeCount")
'Rs.close
'set Rs=nothing
SubjectCodeCount = 0

StrSql = ""
StrSql = StrSql & vbCrLf & "begin tran"

'StrSql = StrSql & vbCrLf & "begin "
'StrSql = StrSql & vbCrLf & "Insert Into SubjectTableHistory "
'StrSql = StrSql & vbCrLf & "(SubjectCode, Division0, Subject, Division1, Division2, Division3, QuorumFix, Quorum, Quorum2, MemberID, InsertTime)values(" 
'StrSql = StrSql & vbCrLf & "'" & SubjectCode & "'" 
'StrSql = StrSql & vbCrLf & ",'" & Division0 & "'" 
'StrSql = StrSql & vbCrLf & ",'" & Subject & "'" 
'StrSql = StrSql & vbCrLf & ",'" & Division1 & "'" 
'StrSql = StrSql & vbCrLf & ",'" & Division2 & "'" 
'StrSql = StrSql & vbCrLf & ",'" & Division3 & "'"
'StrSql = StrSql & vbCrLf & ",'" & QuorumFix & "'"
'StrSql = StrSql & vbCrLf & ",'" & Quorum & "'"
'StrSql = StrSql & vbCrLf & ",0"
'StrSql = StrSql & vbCrLf & ",'" & Session("MemberID") & "'"
'StrSql = StrSql & vbCrLf & ",getdate()) " 
'StrSql = StrSql & vbCrLf & "End " 

'업데이트 반영
StrSql = StrSql & vbCrLf & "Insert Into SubjectTable "
StrSql = StrSql & vbCrLf & "(SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, RegistrationFee, InsertTime, QuorumFix, MYear)values(" 
StrSql = StrSql & vbCrLf & "'" & SubjectCode & "'" 
StrSql = StrSql & vbCrLf & ",'" & Division0 & "'" 
StrSql = StrSql & vbCrLf & ",'" & Subject & "'" 
StrSql = StrSql & vbCrLf & ",'" & Division1 & "'" 
StrSql = StrSql & vbCrLf & ",'" & Division2 & "'" 
StrSql = StrSql & vbCrLf & ",'" & Division3 & "'"
StrSql = StrSql & vbCrLf & ",'" & Quorum & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationFee & "'"
StrSql = StrSql & vbCrLf & ",getdate() " 
StrSql = StrSql & vbCrLf & ",'" & QuorumFix & "'"
StrSql = StrSql & vbCrLf & ",left(convert(varchar(10), getdate(), 112), 4) "
StrSql = StrSql & vbCrLf & ") " 
StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "

'PrintSql StrSql
'Response.End
Dbcon.Execute StrSql

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
        <input type="hidden" name="Message"          value="모집단위 입력이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>">
    <%Else%>
		<%If SubjectCodeCount = 0 then%>
			<input type="hidden" name="MessageType"      value="success">
			<input type="hidden" name="Message"          value="모집단위 입력 완료.">
		<%Else%>
			<input type="hidden" name="MessageType"      value="error">
			<input type="hidden" name="Message"          value="모집단위 입력이 불가능 합니다.    -    입력하신 단위코드가 이미 존재합니다.">
		<%End If%>
    <%End If%>
</FORM>

</body>
</html>