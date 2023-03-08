<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim FormCheckbox, SMSBody, FormSEndURL
FormCheckbox = Request.Form("Checkbox")
SMSBody = Request.Form("SMSBody")
'Response.write Request.Form("FormCheckbox").count & "<BR>"
'Response.write SMSBody & "<BR>"

Dim i, j, StrSql, Rs, DbconSMS, Destination, FormSMSDestination
If Session("SMSConfirm")="1" and SMSBody<>"" and Request.Form("Checkbox").count>0 Then
	Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSql =          "select Tel1, Tel2, Tel3, Tel4, Tel5"
	StrSql = StrSql & vbCrLf & "from StudentTable"
	StrSql = StrSql & vbCrLf & "where StudentNumber ='" & Request.Form("Checkbox")(1) & "'"
	for i= 2 to Request.Form("Checkbox").count
		StrSql = StrSql & vbCrLf & "or StudentNumber ='" & Request.Form("Checkbox")(i) & "'"
	next
	StrSql = StrSql & vbCrLf & "order by Ranking"
	'Response.Write StrSql
	'Response.End
	Rs.Open StrSql, Dbcon, 1, 1
	
	If Rs.RecordCount>0 Then
		Do Until Rs.EOF
			for j = 0 to 4
				Destination = Rs(j)
				If left(Destination, 3) = "010" or left(Destination, 3) = "011" or left(Destination, 3) = "016" or left(Destination, 3) = "017" or left(Destination, 3) = "018" or left(Destination, 3) = "019" Then
				exit for
				End If
			next
			Rs.MoveNext
			FormSMSDestination = FormSMSDestination & "&tran_phone=" & DestinationFiltering(Destination)
		loop
		FormSEndURL = "http://s.metissoft.com/sms/MetisSmsSend.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & FormSMSDestination
		'Response.Write FormSEndURL
        'Response.End
	End If
	Rs.Close
Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS를 발송하지 않음으로 설정되어 있습니다. 발송을 할 수 없습니다.')</SCRIPT>"
End If
Set Rs = Nothing
%>
<!-- #include virtual = "/Include/DbClose.asp" -->

<FORM METHOD=POST name="SMSSEndFinishForm" ACTION="Root.asp">
<input type=hidden name="FormSEndURL" value="<%=FormSEndURL%>">
</FORM>
<SCRIPT LANGUAGE="JavaScript">
<!--
	SMSSEndFinishForm.submit();
	//location.href="<%=FormSEndURL%>";
//-->
</SCRIPT>

<%
'get로 넘어가면 단체 문자를 보낸 후 지원자 세부사항을 본 후 켄슬 하여 지원자 리스트 보면 get 주소가 문자 발송 주소로 되어서
'post로 바꿈
'Response.Write "<script language='javascript'>document.location.href='Root.asp?FormSEndURL=" & Server.URLEncode(FormSEndURL) & "'</script>"
%>