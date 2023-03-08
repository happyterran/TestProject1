<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'On Error Resume Next
Dim TestDestination, TestResult, TestDivision0
TestDestination = getParameter(Request.Form("TestDestination"), "")
TestResult = getParameter(Request.Form("TestResult"), "")
TestDivision0 = getParameter(Request.Form("TestDivision0"), "")

Dim Rs, StrSql
Set Rs = Server.CreateObject("ADODB.Recordset")
'SettingTable
StrSql	= "select top 1 * from SettingTable order by IDX Desc"
'PrintSql StrSql
'Response.End
Rs.Open StrSql, Dbcon, 1, 1
Session("SMSConfirm") = Rs("SMSConfirm")
Session("SMSAutoConfirm") = Rs("SMSAutoConfirm")
Session("UniveRsityName") = Rs("UniveRsityName")
Session("CallBack") = Rs("CallBack")
Session("SMSBodyRegistrationFee") = Rs("SMSBodyRegistrationFee")
Session("SMSBodyAccountNumber") = Rs("SMSBodyAccountNumber")
Session("SMSBodyRegistrationTime") = Rs("SMSBodyRegistrationTime")
Rs.Close
'Degree
StrSql	= "select * from Degree2 order by IDX desc"
Rs.Open StrSql, Dbcon, 1, 1
Do Until Rs.EOF
	If TestDivision0 = Rs("Division0") Then
		Session("FormDegree") = Rs("Degree")
		Session("RegistrationTime") = Rs("RegistrationMonth") & "월"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs("RegistrationDay") & "일"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs("RegistrationHour") & "시"
		Exit Do
	End If
	Rs.MoveNext
Loop
Rs.Close
'SubjectTable
Dim RegistrationFeeTemp
StrSql	= "select top 1 * from SubjectTable order by IDX desc"
Rs.Open StrSql, Dbcon, 1, 1
RegistrationFeeTemp = Rs("RegistrationFee")
Rs.Close
'StudentTable
Dim StudentNumberTemp, StudentNameTemp, AccountNumberTemp, SMSbody, FormSEndURL
StrSql	= "select top 1 AccountNumber from StudentTable order by Ranking asc"
Rs.Open StrSql, Dbcon, 1, 1
AccountNumberTemp = Rs("AccountNumber")
Rs.Close
Set Rs = Nothing


If Session("SMSConfirm")="1" and Session("SMSAutoConfirm")="1" Then
	SMSbody=""
	StrSql = ""
	If left(TestDestination , 3) = "010" or left(TestDestination , 3) = "011" or left(TestDestination , 3) = "016" or left(TestDestination , 3) = "017" or left(TestDestination , 3) = "018" or left(TestDestination , 3) = "019" Then
		SMSBody = SMSBody & "[" & Session("UniveRsityName") & "]"
		If TestResult = "포기" Then
			SMSBody = SMSBody & "홍길동님의 최종 결정은 포기 입니다."
		ElseIf TestResult = "등록예정" Then
			SMSBody = SMSBody & "홍길동님의 "
			If Session("SMSBodyRegistrationFee")="1" Then
				SMSBody = SMSBody & "등록금" & RegistrationFeeTemp & "원 "
			End If
			If Session("SMSBodyAccountNumber")="1" Then
				SMSBody = SMSBody & AccountNumberTemp & " "
			End If
			If Session("SMSBodyRegistrationTime")="1" Then
				'SMSBody = SMSBody & "기한" & Session("RegistrationTime") & " "
				SMSBody = SMSBody & "등록 기간은 " & Session("RegistrationTime") & "까지"
			End If
			If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
				SMSBody = SMSBody & "최종 결정은 등록예정 입니다."
			End If
		End If
		
		'StrSql =	StrSql & "Insert into smscli_tbl (destination, body, callback, SMSMemberID) values ("
		'StrSql = StrSql & vbCrLf & " '" & TestDestination & "'"
		'StrSql = StrSql & vbCrLf & ",'" & SMSBody & "'" 
		'StrSql = StrSql & vbCrLf & ",'" & Session("CallBack") & "','metis')"

		FormSEndURL = "http://s.metissoft.com/sms/MetisSmsSEnd.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & "&tran_phone=" & TestDestination
	Else
		'Response.Redirect "DegreeSetting.asp?MessageType=error&Message=테스트 발송할 핸드폰 번호가 올바르지 않습니다.."
		Response.Redirect "DegreeSetting.asp?MessageType=error&Message=" & Server.URLEncode("테스트 발송할 핸드폰 번호가 올바르지 않습니다..")
		'Response.End
	End If
Else
	'Response.Redirect "DegreeSetting.asp?MessageType=error&Message=SMS 자동통보가 아니오로 설정되어 있습니다. 발송을 할 수 없습니다.\n본 테스트는 통화 직후 발송되는 SMS 자동통보 테스트 입니다."
	Response.Redirect "DegreeSetting.asp?MessageType=error&Message=" & Server.URLEncode("SMS 자동통보가 아니오로 설정되어 있습니다. 발송을 할 수 없습니다.\n본 테스트는 통화 직후 발송되는 SMS 자동통보 테스트 입니다.")
	'Response.End
End If

'Response.Write FormSEndURL
'Response.End '전화를 끊는 순간 입력되는 순간 기록해야 한다
'Dim DbconSMS
'Set DbconSMS = Server.CreateObject("ADODB.Connection") 
'DbconSMS.Open "provider=SqlOLEDB.1;Password=ky6140;PeRsist Security Info=True;User ID=MetisSmsSender; Initial Catalog=SMS3;Data source=mobilekiss.metissoft.com;Connect Timeout=5;"
'DbconSMS.Execute StrSql
'DbconSMS.Close
'set DbconSMS = Nothing
%>

<!-- #include virtual = "/Include/DbClose.asp" -->

<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
    <%If Err.Description <> "" Then%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=error&Message=SMS 발송이 불가능 합니다.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=다음과 같이 테스트 SMS가 발송되었습니다. <br> <%=SMSBody%>&FormSendURL=<%=Server.URLEncode(FormSendURL)%>"
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
