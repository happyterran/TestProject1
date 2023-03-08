<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim FormStudentNumber, FormCommand, FormDialedTel, FormTelTemp, FormReceiver, FormResult, FormMemo, FormSMSBody, FormSMSTelTemp, FormSEndURL
FormStudentNumber = Request.Form("FormStudentNumber")
FormCommand = GetParameter(Request.Form("FormCommand"), "")
FormDialedTel = Request.Form("FormDialedTel")
FormTelTemp = GetParameter(Request.Form("FormTelTemp"), "")
FormReceiver = GetParameter(Request.Form("FormReceiver"), "")
FormResult = GetParameter(Request.Form("FormResult"), "")
FormMemo = Request.Form("FormMemo")
FormSMSBody = Request.Form("FormSMSBody")
FormSMSTelTemp = Request.Form("FormSMSTelTemp")

FormSEndURL = Request("FormSEndURL")

'Response.write "FormSEndURL: " &FormSEndURL & "<br>"
'Response.write "SMSConfirm: " & Session("SMSConfirm") & "<br>"
'Response.write "FormSMSBody: " & FormSMSBody & "<br>"
%>
<!--
<TABLE border=1>
<TR>
	<TD>FormStudentNumber</TD>
	<TD><%=FormStudentNumber%></TD>
</TR>
<TR>
	<TD>FormCommand</TD>
	<TD><%=FormCommand%></TD>
</TR>
<TR>
	<TD>FormDialedTel</TD>
	<TD><%=FormDialedTel%></TD>
</TR>
<TR>
	<TD>FormTelTemp</TD>
	<TD><%=FormTelTemp%></TD>
</TR>
<TR>
	<TD>FormReceiver</TD>
	<TD><%=FormReceiver%></TD>
</TR>
<TR>
	<TD>FormResult</TD>
	<TD><%=FormResult%></TD>
</TR>
<TR>
	<TD>FormMemo</TD>
	<TD><%=FormMemo%></TD>
</TR>
<TR>
	<TD>FormSMSBody</TD>
	<TD><%=FormSMSBody%></TD>
</TR>
<TR>
	<TD>FormSMSTelTemp</TD>
	<TD><%=FormSMSTelTemp%></TD>
</TR>
</TABLE>
-->
<%
'Response.End
On Error Resume Next

Dim i, j, StrSql, Rs, DbconSMS, Destination, Tel(5)
Dim FormSMSDestination
If Session("SMSConfirm")="1" and (FormSMSBody<>"" or FormSEndURL<>"") Then
	StrSql = ""
	If left(FormSMSTelTemp , 3) = "010" or left(FormSMSTelTemp , 3) = "011" or left(FormSMSTelTemp , 3) = "016" or left(FormSMSTelTemp , 3) = "017" or left(FormSMSTelTemp , 3) = "018" or left(FormSMSTelTemp , 3) = "019" Then '임시전화가 핸드폰이면
			FormSMSDestination = DestinationFiltering(FormSMSTelTemp) 
	Else
		Set Rs = Server.CreateObject("ADODB.RecordSet")
		StrSql =          "select Tel1, Tel2, Tel3, Tel4, Tel5"
		StrSql = StrSql & vbCrLf & "from StudentTable"
		StrSql = StrSql & vbCrLf & "where StudentNumber ='" & FormStudentNumber & "'"
		'Response.Write StrSql
		'Response.End
		Rs.Open StrSql, Dbcon, 1, 1
		Tel(1) = Rs("Tel1")
		Tel(2) = Rs("Tel2")
		Tel(3) = Rs("Tel3")
		Tel(4) = Rs("Tel4")
		Tel(5) = Rs("Tel5")
		Rs.Close
		Set Rs = Nothing
		for i = 1 to 5
			If left(Tel(i) , 3) = "010" or left(Tel(i) , 3) = "011" or left(Tel(i) , 3) = "016" or left(Tel(i) , 3) = "017" or left(Tel(i) , 3) = "018" or left(Tel(i) , 3) = "019" Then
				FormSMSDestination = DestinationFiltering(Tel(i)) 
				exit for
			End If
		next
	End If

    If Err.Description <> "" Then
        Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS 발송이 실패했습니다.\n" & Err.Description & "');</SCRIPT>"
        Err.Clear 
        Response.End
    End If

Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS를 발송하지 않음으로 설정되어 있습니다. 발송을 할 수 없습니다.')</SCRIPT>"
	Response.End
End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->
		
<FORM METHOD=POST name="SMSSendFinishForm" ACTION="http://s.metissoft.com/sms/MetisSmsSend.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=<%=FormSMSBody%>&tran_callback=<%=Session("CallBack")%>&tran_phone=<%=FormSMSDestination%>">
    <!--
    <input type="hidden" name="SEndURL" value='<%=FormSEndURL%>'>
    -->
    <!--
    <INPUT TYPE="submit">
    -->
</FORM>
<SCRIPT LANGUAGE="JavaScript">
<!--
    SMSSendFinishForm.submit();
    //location.href="<%=FormSendURL%>";
//-->
</SCRIPT>