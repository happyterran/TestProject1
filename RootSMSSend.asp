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
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS�� �߼����� �������� �����Ǿ� �ֽ��ϴ�. �߼��� �� �� �����ϴ�.')</SCRIPT>"
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
'get�� �Ѿ�� ��ü ���ڸ� ���� �� ������ ���λ����� �� �� �˽� �Ͽ� ������ ����Ʈ ���� get �ּҰ� ���� �߼� �ּҷ� �Ǿ
'post�� �ٲ�
'Response.Write "<script language='javascript'>document.location.href='Root.asp?FormSEndURL=" & Server.URLEncode(FormSEndURL) & "'</script>"
%>