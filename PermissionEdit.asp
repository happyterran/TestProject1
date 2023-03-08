<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
On Error Resume Next
Dim MemberIDHidden,MemberID,MemberName,Grade,MemberSubjectA,MemberSubjectB,MemberDivision0,MemberDivision1
Dim i, j, StrSql
If Request.Form("Checkbox").count>0 Then
	StrSql = "begin tran"
	for i= 1 to Request.Form("Checkbox").count
		j               = Request.Form("Checkbox")(i)
		MemberIDHidden  = getParameter(Request.Form("MemberIDHidden")(j),"")
		MemberID        = getParameter(Request.Form("MemberID")(j),"")
		MemberName      = getParameter(Request.Form("MemberName")(j),"")
		Grade           = getParameter(Request.Form("Grade"&j),"")

'		Response.write j & "<BR>"
'		Response.write MemberIDHidden & "<BR>"
'		Response.write MemberID & "<BR>"
'		Response.write MemberName & "<BR>"
		MemberSubjectA = Request.Form("MemberSubjectA"&j)
		MemberSubjectB = Request.Form("MemberSubjectB"&j)
		MemberDivision0 = Request.Form("MemberDivision0"&j)
		MemberDivision1 = Request.Form("MemberDivision1"&j)

		StrSql = StrSql & vbCrLf & "update Member set"
		StrSql = StrSql & vbCrLf & "	MemberID ='" & MemberID & "'"
		StrSql = StrSql & vbCrLf & ",MemberName ='" & MemberName & "'"
		StrSql = StrSql & vbCrLf & ",Grade ='" & Grade & "'"
		StrSql = StrSql & vbCrLf & ",MemberSubjectA ='" & MemberSubjectA & "'"
		StrSql = StrSql & vbCrLf & ",MemberSubjectB ='" & MemberSubjectB & "'"
		StrSql = StrSql & vbCrLf & ",MemberDivision0 ='" & MemberDivision0 & "'"
		StrSql = StrSql & vbCrLf & ",MemberDivision1 ='" & MemberDivision1 & "'"
		StrSql = StrSql & vbCrLf & ",InsertTIme = getdate()"
		StrSql = StrSql & vbCrLf & "where MemberID ='" & MemberIDHidden & "'"

	next
	StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback "
	
	'Response.Write StrSql
	'Response.End
	Dbcon.Execute StrSql
End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="Permission.asp?MessageType=error&Message=사용자 설정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="Permission.asp?MessageType=success&Message=사용자 정보 수정 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
