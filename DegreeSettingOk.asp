<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->

<%
'On Error Resume Next

Dim Division0, Degree,RegistrationYear,RegistrationMonth,RegistrationDay,RegistrationHour

Division0 = GetParaMeter(Request.Form("Division0") , "")
Degree = Cint(GetIntParaMeter(Request.Form("Degree") , 0))
'RegistrationMonth = GetParaMeter(Request.Form("RegistrationMonth") , "")
'RegistrationDay = GetParaMeter(Request.Form("RegistrationDay") , "")
'RegistrationHour = GetParaMeter(Request.Form("RegistrationHour") , "")

Dim RefundDay1, RefundDay2, RegistrationMinute
RefundDay1 = GetParaMeter(Request.Form("RefundDay1") , "0")
RefundDay2 = GetParaMeter(Request.Form("RefundDay2") , "0")
RegistrationYear	= Mid(RefundDay1, 1, 4)
RegistrationMonth	= Mid(RefundDay1, 6, 2)
RegistrationDay		= Mid(RefundDay1, 9, 2)
RegistrationHour	= Mid(RefundDay2, 1, 2)
RegistrationMinute	= Mid(RefundDay2, 4, 2)
'Response.write RegistrationYear
'Response.write RegistrationMonth
'Response.write RegistrationDay
'Response.write RegistrationHour
'Response.write RegistrationMinute
'Response.End


Dim StrSql, Rs

StrSql =		"If (select count(*) from Degree2 where Division0='" & Division0 & "')>0"
StrSql = StrSql & vbCrLf & "delete Degree2 where Division0='" & Division0 & "'"
StrSql = StrSql & vbCrLf & ""

StrSql = StrSql & vbCrLf & "Insert into Degree2("
StrSql = StrSql & vbCrLf & "Division0,Degree,RegistrationYear,RegistrationMonth,RegistrationDay,RegistrationHour,RegistrationMinute"
StrSql = StrSql & vbCrLf & ",InsertTime) values ("
StrSql = StrSql & vbCrLf & " '" & Division0 & "'"
StrSql = StrSql & vbCrLf & ",'" & Degree & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationYear & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationMonth & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationDay & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationHour & "'"
StrSql = StrSql & vbCrLf & ",'" & RegistrationMinute & "'"
StrSql = StrSql & vbCrLf & ",getdate()"
StrSql = StrSql & vbCrLf & ")"
'PrintSql StrSql
'Response.End

Dbcon.Execute StrSql

%>

<!-- #include virtual = "/Include/DbClose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=error&Message=차수와 등록기한 설정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=차수와 등록기한 설정 완료."
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
