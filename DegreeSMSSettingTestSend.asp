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
		Session("RegistrationTime") = Rs("RegistrationMonth") & "��"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs("RegistrationDay") & "��"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs("RegistrationHour") & "��"
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
		If TestResult = "����" Then
			SMSBody = SMSBody & "ȫ�浿���� ���� ������ ���� �Դϴ�."
		ElseIf TestResult = "��Ͽ���" Then
			SMSBody = SMSBody & "ȫ�浿���� "
			If Session("SMSBodyRegistrationFee")="1" Then
				SMSBody = SMSBody & "��ϱ�" & RegistrationFeeTemp & "�� "
			End If
			If Session("SMSBodyAccountNumber")="1" Then
				SMSBody = SMSBody & AccountNumberTemp & " "
			End If
			If Session("SMSBodyRegistrationTime")="1" Then
				'SMSBody = SMSBody & "����" & Session("RegistrationTime") & " "
				SMSBody = SMSBody & "��� �Ⱓ�� " & Session("RegistrationTime") & "����"
			End If
			If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
				SMSBody = SMSBody & "���� ������ ��Ͽ��� �Դϴ�."
			End If
		End If
		
		'StrSql =	StrSql & "Insert into smscli_tbl (destination, body, callback, SMSMemberID) values ("
		'StrSql = StrSql & vbCrLf & " '" & TestDestination & "'"
		'StrSql = StrSql & vbCrLf & ",'" & SMSBody & "'" 
		'StrSql = StrSql & vbCrLf & ",'" & Session("CallBack") & "','metis')"

		FormSEndURL = "http://s.metissoft.com/sms/MetisSmsSEnd.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & "&tran_phone=" & TestDestination
	Else
		'Response.Redirect "DegreeSetting.asp?MessageType=error&Message=�׽�Ʈ �߼��� �ڵ��� ��ȣ�� �ùٸ��� �ʽ��ϴ�.."
		Response.Redirect "DegreeSetting.asp?MessageType=error&Message=" & Server.URLEncode("�׽�Ʈ �߼��� �ڵ��� ��ȣ�� �ùٸ��� �ʽ��ϴ�..")
		'Response.End
	End If
Else
	'Response.Redirect "DegreeSetting.asp?MessageType=error&Message=SMS �ڵ��뺸�� �ƴϿ��� �����Ǿ� �ֽ��ϴ�. �߼��� �� �� �����ϴ�.\n�� �׽�Ʈ�� ��ȭ ���� �߼۵Ǵ� SMS �ڵ��뺸 �׽�Ʈ �Դϴ�."
	Response.Redirect "DegreeSetting.asp?MessageType=error&Message=" & Server.URLEncode("SMS �ڵ��뺸�� �ƴϿ��� �����Ǿ� �ֽ��ϴ�. �߼��� �� �� �����ϴ�.\n�� �׽�Ʈ�� ��ȭ ���� �߼۵Ǵ� SMS �ڵ��뺸 �׽�Ʈ �Դϴ�.")
	'Response.End
End If

'Response.Write FormSEndURL
'Response.End '��ȭ�� ���� ���� �ԷµǴ� ���� ����ؾ� �Ѵ�
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
            document.location.href="DegreeSetting.asp?MessageType=error&Message=SMS �߼��� �Ұ��� �մϴ�.    -    <%=Replace(Err.Description, "'", " ")%>"
        </script>
    <%Else%>
        <script language='javascript'>
            document.location.href="DegreeSetting.asp?MessageType=success&Message=������ ���� �׽�Ʈ SMS�� �߼۵Ǿ����ϴ�. <br> <%=SMSBody%>&FormSendURL=<%=Server.URLEncode(FormSendURL)%>"
        </script>
    <%End If%>

</head>
<body style="padding-top:0;">
</body>
</html>
