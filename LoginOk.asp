<%Option Explicit%>
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/function.asp" -->
<%
Dim MemberID, Password, SavePassword
MemberID = getQueryFilter(Request.Form("MemberID"))
Password = getQueryFilter(Request.Form("Password"))
SavePassword = Request.Form("SavePassword")
Dim StrSql, Rs, Rs1
Set Rs = Server.CreateObject("ADODB.Recordset")
Set Rs1 = Server.CreateObject("ADODB.Recordset")
StrSql = "select MemberID from Member where MemberID='"&MemberID&"'"
'Response.write StrSql
'Response.end
Rs.Open StrSql, Dbcon, 1, 1
StrSql = "select * from Member where MemberID='"&MemberID&"' and Password='"&Password&"'"
Rs1.Open StrSql, Dbcon, 1, 1
'Response.Write StrSql
'Response.write Rs.RecordCount
'Response.end
IF Rs.RecordCount = 0 Then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>document.location.href='Login.asp?LoginCheck=존재하지 않는 ID입니다';</SCRIPT>"
ElseIF Rs1.RecordCount = 0 Then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>document.location.href='Login.asp?LoginCheck=비밀번호가 틀렸습니다';</SCRIPT>"
ElseIF Rs1("Grade")="게스트" then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>document.location.href='Login.asp?LoginCheck=관리자의 승인이 필요 합니다';</SCRIPT>"
else
	Session("MemberID") = MemberID
	Session("MemberName") = Rs1("MemberName")
	Session("Position") = Rs1("Position")
	Session("PositionRegistRecord") = Rs1("PositionRegistRecord")
    Session("PositionStudentDetail") = Rs1("PositionStudentDetail")
	Session("PositionPluralRecord") = Rs1("PositionPluralRecord")
	Session("Grade") = Rs1("Grade")
	Session.Timeout = 120
    Response.Cookies("MemberID") = MemberID
    Response.Cookies("Password") = Password
    Response.Cookies("SavePassword") = SavePassword
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>document.location.href='/Root.asp';</SCRIPT>"
End IF

Rs.close
Set Rs=Nothing
Rs1.close
Set Rs1=Nothing
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->