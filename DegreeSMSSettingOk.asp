<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->

<%
On Error Resume Next
Dim SMSConfirm,UniversityName,CallBack,SMSAutoConfirm,SMSBodyRegistrationFee,SMSBodyAccountNumber,SMSBodyRegistrationTime
SMSConfirm = GetParaMeter(Request.Form("SMSConfirm") , "0")
UniversityName = GetParaMeter(Request.Form("UniversityName") , "")
CallBack = GetParaMeter(Request.Form("CallBack") , "")
SMSAutoConfirm = GetParaMeter(Request.Form("SMSAutoConfirm") , "0")
SMSBodyRegistrationFee = GetParaMeter(Request.Form("SMSBodyRegistrationFee") , "0")
SMSBodyAccountNumber = GetParaMeter(Request.Form("SMSBodyAccountNumber") , "0")
SMSBodyRegistrationTime = GetParaMeter(Request.Form("SMSBodyRegistrationTime") , "0")
'Response.write UniversityName
'Response.write CallBack
'Response.write SMSBodyRegistrationTime


Dim StrSql, Rs
If CallBack<>"" Then
    StrSql = "update SettingTable set"
    StrSql = StrSql & vbCrLf & " SMSConfirm='" & SMSConfirm & "'"
    StrSql = StrSql & vbCrLf & ",CallBack='" & CallBack & "'"
    StrSql = StrSql & vbCrLf & ",insertTime=getdate()"
Else
    StrSql = "update SettingTable set"
    StrSql = StrSql & vbCrLf & " UniversityName='" & UniversityName & "'"
    StrSql = StrSql & vbCrLf & ",SMSAutoConfirm='" & SMSAutoConfirm & "'"
    StrSql = StrSql & vbCrLf & ",SMSBodyRegistrationFee='" & SMSBodyRegistrationFee & "'"
    StrSql = StrSql & vbCrLf & ",SMSBodyAccountNumber='" & SMSBodyAccountNumber & "'"
    StrSql = StrSql & vbCrLf & ",SMSBodyRegistrationTime='" & SMSBodyRegistrationTime & "'"
    StrSql = StrSql & vbCrLf & ",insertTime=getdate()"
End If

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
            document.location.href="DegreeSetting.asp?MessageType=error&Message=SMS 설정이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <%If CallBack<>"" Then%>
            <script language='javascript'>
                document.location.href="DegreeSetting.asp?MessageType=success&Message=일반 SMS 설정 적용 완료."
            </script>
        <%Else%>
            <script language='javascript'>
                document.location.href="DegreeSetting.asp?MessageType=success&Message=자동발송 SMS 설정 적용 완료."
            </script>
        <%End If%>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
