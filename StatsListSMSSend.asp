<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Frame.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Response.buffer=true

'#################################################################################
'##�а� ���� ������ Ȱ���� �ٽ��׸� ����
'#################################################################################
Dim Rs1, StrSql, SubStrSql
SubStrSql = ""
If Session("FormStatsSubject") <> "" Then
	SubStrSql =					"and Subject = '" & Session("FormStatsSubject") & "'"
End If
If Session("FormStatsDivision0") <> "" Then
	SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & Session("FormStatsDivision0") & "'"
End If
If Session("FormStatsDivision1") <> "" Then
	SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & Session("FormStatsDivision1") & "'"
End If
If Session("FormStatsDivision2") <> "" Then
	SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & Session("FormStatsDivision2") & "'"
End If
If Session("FormStatsDivision3") <> "" Then
	SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormStatsDivision3") & "'"
End If
'���۾� ����ô� Degree�� ���� �߰��� �־��Ѵ�.
'Result, MemberID, Inserttime �˻� ����
If Session("FormStatsResult")<>1 Then
    If Session("FormStatsDegree") <> "" Then
        SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & Session("FormStatsDegree") & "'"
    End If
    If Session("FormStatsResult") <> 0 Then
        If Session("FormStatsResult") = 1 Then
            SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
        Else
            SubStrSql = SubStrSql & vbCrLf & "and Result = '" & Session("FormStatsResult") & "'"
        End If
    End If
    If Session("FormStatsMemberID") <> "" Then
        SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & Session("FormStatsMemberID") & "'"
    End If
    If Session("InsertTime1") <> "" Then
        SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime >= '" & Session("InsertTime1") & " 00:00:00'"
    End If
    If Session("InsertTime2") <> "" Then
        SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime <= '" & Session("InsertTime2") & " 23:59:59.999'"
    End If
End If
'If Session("FormStatsResultType") <> "" Then
'	SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormStatsResultType") & "'"
'End If
'Response.write SubStrSql & "<BR>"
'Response.End

Dim OrderStrSql
If Session("FormStatsOrderType") = "" Then
	OrderStrSql = "order by ET.SubjectCode, ET.Ranking"
Else
	OrderStrSql = "order by " & Session("FormStatsOrderType")
End If
'Response.write OrderStrSql
'Response.End


Set Rs1 = Server.CreateObject("ADODB.Recordset")

'----------------------------------------------------------------------------------
' �ش簪 ��������
'----------------------------------------------------------------------------------
'������� ���� ���� ����, �Ѽ��� �ҽ� ����, ��������
If Session("FormStatsResult")=1 Then
	StrSql = ""
	StrSql = StrSql & vbCrLf & "--�������(RemainCount) = ����-��Ͽ���-��ϿϷ�"
	StrSql = StrSql & vbCrLf & "--ĿƮ����(RankingCutLine) = ����+����+�̵��+ȯ��+��ȯ��"
	StrSql = StrSql & vbCrLf & ""
	StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
	StrSql = StrSql & vbCrLf & "select @Degree = '" & Session("FormStatsDegree") &"'"
	StrSql = StrSql & vbCrLf & "-- select @Degree = '4' �κ��� ���ڸ� ��ȸ�Ͻ� ������ ���� �Ͻ� �� �����ϼ���."
	StrSql = StrSql & vbCrLf & "-- ����� 4���� ���, �̵�� ������ ����  �Է¿Ϸ�� �����̰�, 5���� �뺸�����ڿ� �� ����� �����ϴ� ���� �Դϴ�."
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "select a.*, et.SubjectCode, et.StudentNumber, et.StudentName, et.Ranking, Tel1, Tel2, Tel3, Tel4, Tel5, cr.idx"
	StrSql = StrSql & vbCrLf & ", null Degree, null Tel, null MemberID, null Receiver, null Result, null SaveFile, null Memo, null InsertTime, 0 CallCountIsNull, 1 ResultIsNull"
	StrSql = StrSql & vbCrLf & "from"
	StrSql = StrSql & vbCrLf & "("
	StrSql = StrSql & vbCrLf & "	select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
	StrSql = StrSql & vbCrLf & "	--��ϿϷ�+��Ͽ����� �ѹ��� ����"
	StrSql = StrSql & vbCrLf & "	, Quorum - isnull(r.RegistCount,0) Remain"
	StrSql = StrSql & vbCrLf & "	--����+�̵��+ȯ��+��ȯ���� �ѹ��� ����"
	StrSql = StrSql & vbCrLf & "	, Quorum + isnull(b.AbadonCount,0) RankingCutLine"
	StrSql = StrSql & vbCrLf & "	, Quorum"
	StrSql = StrSql & vbCrLf & "	, isnull(r.RegistCount,0) RegistCount"
	StrSql = StrSql & vbCrLf & "	, isnull(b.AbadonCount,0) AbadonCount"
	StrSql = StrSql & vbCrLf & "	from SubjectTable a"
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "	--��ϿϷ�+��Ͽ����� �ѹ��� ����"
	StrSql = StrSql & vbCrLf & "	left outer join"
	StrSql = StrSql & vbCrLf & "	("
	StrSql = StrSql & vbCrLf & "		select A.SubjectCode, '2' Result, isnull(count(*),0) as RegistCount"
	StrSql = StrSql & vbCrLf & "		from RegistRecord A"
	StrSql = StrSql & vbCrLf & "		inner join"
	StrSql = StrSql & vbCrLf & "		("
	StrSql = StrSql & vbCrLf & "			select StudentNumber, max(IDX) as MaxIDX "
	StrSql = StrSql & vbCrLf & "			from RegistRecord"
	StrSql = StrSql & vbCrLf & "			where Degree <=@Degree"
	StrSql = StrSql & vbCrLf & "			group by StudentNumber"
	StrSql = StrSql & vbCrLf & "		) B"
	StrSql = StrSql & vbCrLf & "		on A.StudentNumber = B.StudentNumber"
	StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
	StrSql = StrSql & vbCrLf & "		where result = 2 or result = 6"
	StrSql = StrSql & vbCrLf & "		group by A.SubjectCode"
	StrSql = StrSql & vbCrLf & "	) r"
	StrSql = StrSql & vbCrLf & "	on a.SubjectCode = r.SubjectCode"
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "	--����+�̵��+ȯ��+��ȯ���� �ѹ��� ����"
	StrSql = StrSql & vbCrLf & "	left outer join"
	StrSql = StrSql & vbCrLf & "	("
	StrSql = StrSql & vbCrLf & "		select A.SubjectCode, '3' Result, isnull(count(*),0) as AbadonCount"
	StrSql = StrSql & vbCrLf & "		--select *"
	StrSql = StrSql & vbCrLf & "		from RegistRecord A"
	StrSql = StrSql & vbCrLf & "		inner join"
	StrSql = StrSql & vbCrLf & "		("
	StrSql = StrSql & vbCrLf & "			select StudentNumber, max(IDX) as MaxIDX "
	StrSql = StrSql & vbCrLf & "			from RegistRecord"
	StrSql = StrSql & vbCrLf & "			where Degree <=@Degree"
	StrSql = StrSql & vbCrLf & "			group by StudentNumber"
	StrSql = StrSql & vbCrLf & "		) B"
	StrSql = StrSql & vbCrLf & "		on A.StudentNumber = B.StudentNumber"
	StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
	StrSql = StrSql & vbCrLf & "		where result = 3 or result = 7 or result = 10 or result = 11"
	StrSql = StrSql & vbCrLf & "		group by A.SubjectCode"
	StrSql = StrSql & vbCrLf & "	) b"
	StrSql = StrSql & vbCrLf & "	on a.SubjectCode = b.SubjectCode"
	StrSql = StrSql & vbCrLf & "	where Quorum - isnull(r.RegistCount,0) > 0"
	StrSql = StrSql & vbCrLf & ") a"
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "left outer join StudentTable et"
	StrSql = StrSql & vbCrLf & "on a.SubjectCode = et.SubjectCode"
	StrSql = StrSql & vbCrLf & "and a.RankingCutLine >= et.Ranking"
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "left outer join RegistRecord cr"
	StrSql = StrSql & vbCrLf & "on et.StudentNumber = cr.StudentNumber"
	StrSql = StrSql & vbCrLf & ""

    StrSql = StrSql & vbCrLf & "where 1=1 "
    If Session("FormStatsDegree")="" Then
        StrSql = StrSql & vbCrLf & "and 1=2 "               '��������ڴ� ���������� �ʼ���. ������ ������ �ǵ������� ����Ʈ�� ����
    End If
    StrSql = StrSql & vbCrLf & "and cr.IDX is Null"         '��������ڴ� ��ȭ����� ���� �����ڸ�
    StrSql = StrSql & vbCrLf & "and et.IDX is Not Null"     '��������ڴ� �����ڰ� �����ϴ� ����������

	StrSql = StrSql & vbCrLf & SubStrSql
	StrSql = StrSql & vbCrLf & OrderStrSql
Else
	If Session("FormStatsResultType")="" Then
		StrSql =          "select"
		StrSql = StrSql & vbCrLf & "		C.StudentNumber, C.StudentName, C.Ranking, Tel1, Tel2, Tel3, Tel4, Tel5"
		StrSql = StrSql & vbCrLf & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & "		, isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & "		, isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "inner join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'���γ����� �׻� Group By �� �̿��� ���� ����� ��ȸ������ �ϴ� ������ �����Ǹ� �ش� �������� �Էµ� ������� ��ȸ�ؾ��Ѵ�
		If Session("FormStatsDegree") <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable C"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = C.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on C.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where 1=1"
		StrSql = StrSql & vbCrLf & "	" & SubStrSql & vbCrLf
		StrSql = StrSql & vbCrLf & "order by D.SubjectCode, C.Ranking"
	Else
		StrSql =          "select"
		StrSql = StrSql & vbCrLf & "		C.StudentNumber, C.StudentName, C.Ranking"
		StrSql = StrSql & vbCrLf & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & "		, isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & "		, isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "left outer join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'���γ����� �׻� Group By �� �̿��� ���� ����� ��ȸ������ �ϴ� ������ �����Ǹ� �ش� �������� �Էµ� ������� ��ȸ�ؾ��Ѵ�
		If Session("FormStatsDegree") <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable C"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = C.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on C.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where 1=1"
		StrSql = StrSql & vbCrLf & "	" & SubStrSql & vbCrLf
		StrSql = StrSql & vbCrLf & "order by D.SubjectCode, C.Ranking"
	End If
End If
'Response.Write StrSql
'Response.End

Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime, i
Dim	DefaultPath
	
Dim FormCheckbox, SMSBody, FormSEndURL
SMSBody = Replace(getParameter(Request.Form("FormSMSBody"),""),vbCrLf,vbLf)
Dim chkTel(5)
chkTel(1) = getparameter(Request.Form("chkTel1"), "")
chkTel(2) = getparameter(Request.Form("chkTel2"), "")
chkTel(3) = getparameter(Request.Form("chkTel3"), "")
chkTel(4) = getparameter(Request.Form("chkTel4"), "")
chkTel(5) = getparameter(Request.Form("chkTel5"), "")
Dim j, Rs, DbconSMS, Destination, FormSMSDestination, FormSMSSubjectCode, FormSMSStudentNumber, FormSMSStudentName, FormSMSDivision0, FormSMSSubject
Dim StudentCount, SMSSEndCount, Tel(5), TempSMSBody, TempSMSBodyLength, LongistSMSBody, LongistLength
If Session("SMSConfirm")="1" and SMSBody<>"" Then
	Rs1.Open StrSql, Dbcon, 1, 1
	If Not Rs1.EOF Then
		SMSSEndCount = 0
		FormSMSDestination = ""
		Do Until Rs1.EOF
			SubjectCode		= getparameter(Rs1("SubjectCode"),  "")
			StudentNumber	= getparameter(Rs1("StudentNumber"),  "")
			StudentName	= getparameter(Rs1("StudentName"),  "")
			Division0		= getparameter(Rs1("Division0"),  "")
			Subject			= getparameter(Rs1("Subject"),  "") 
			Tel(0) = DestinationFiltering(getparameter(Rs1("Tel"),  ""))
			Tel(1) = DestinationFiltering(getparameter(Rs1("Tel1"), ""))
			Tel(2) = DestinationFiltering(getparameter(Rs1("Tel2"), ""))
			Tel(3) = DestinationFiltering(getparameter(Rs1("Tel3"), ""))
			Tel(4) = DestinationFiltering(getparameter(Rs1("Tel4"), ""))
			Tel(5) = DestinationFiltering(getparameter(Rs1("Tel5"), ""))
			StudentCount = StudentCount + 1

			TempSMSBody = Replace(Replace(SMSBody,"@�̸�@",StudentName),"@�а���@",Subject)
			TempSMSBodyLength = ByteLen(TempSMSBody)
			If LongistLength<TempSMSBodyLength Then
				LongistLength=TempSMSBodyLength
				LongistSMSBody=Replace(TempSMSBody,vbLf,"\n")
			End If

			'��ȭ�� ��ȭ�ߴ� ��ȣ�� �߼��� �ʿ䰡 ����.
			'For i = 0 to 2
			'����� ��ȣ�θ� �߼��ض�.
			For i = 1 to 5
				If left(Tel(i) , 3) = "010" or left(Tel(i) , 3) = "011" or left(Tel(i) , 3) = "016" or left(Tel(i) , 3) = "017" or left(Tel(i) , 3) = "018" or left(Tel(i) , 3) = "019" or left(Tel(i) , 3) = "070" Then
					'�ߺ��߼� ������ ���� ��ȭ2�� ������ ������ �����߰� ����
					'Response.write InStr(StrSql, Tel(i))
					'Response.End
					'Response.write chkTel(i)
					If chkTel(i)<>"" And InStr(FormSMSDestination, Tel(i)) = 0 Then
						SMSSEndCount = SMSSEndCount + 1

						'post ��� ��ȯ���� ����
						'FormSMSDestination = FormSMSDestination & "&tran_phone=" & DestinationFiltering(Tel(i))

						'post ��� ��ȯ���� �߰�
						FormSMSDestination	= FormSMSDestination	& "<input type='hidden' name='tran_phone'   value='" & Tel(i)        & "'>" & vbCrLf
						FormSMSSubjectCode	= FormSMSSubjectCode	& "<input type='hidden' name='SubjectCode'  value='" & SubjectCode   & "'>" & vbCrLf
						FormSMSStudentNumber=FormSMSStudentNumber	& "<input type='hidden' name='StudentNumber'value='" & StudentNumber & "'>" & vbCrLf
						FormSMSStudentName	= FormSMSStudentName	& "<input type='hidden' name='StudentName'  value='" & StudentName   & "'>" & vbCrLf
						FormSMSDivision0	= FormSMSDivision0		& "<input type='hidden' name='Division0'    value='" & Division0     & "'>" & vbCrLf
						FormSMSSubject		= FormSMSSubject		& "<input type='hidden' name='Subject'      value='" & Subject       & "'>" & vbCrLf

					End If
				End If
			Next
					
			Rs1.MoveNext
		Loop

		'Response.write FormSMSDestination
		'Response.End
		
		'post ��� ��ȯ���� ����
		'FormSendURL = "http://s.metissoft.com/sms/MetisStatsSMSSend.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & FormSMSDestination
	Else
        Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('SMS �߼�','���ǿ� �´� ����� �����ϴ�.');</SCRIPT>"
	End If
	Rs1.Close
	Set Rs1 = Nothing
Else
    Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('SMS �߼�','SMS �߼ۿ��ΰ� ���� �ֽ��ϴ�. ȯ�漳������ ������ �ּ���.');</SCRIPT>"
End If

%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<%'=SMSBOdy%>
<%'=SMSSendCount%>
<%'=Session("SMSConfirm")%>
<%If LongistLength>80 Then%>
    <SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('SMS �߼�','80����Ʈ�� �ʰ��Ͽ� �߼��� �� �����ϴ�. <br><br><%=Replace(LongistSMSBody,"\n","<br>")%> <br><br><%=LongistLength%>����Ʈ.');</SCRIPT>
<%ElseIf Session("SMSConfirm")="1" And SMSSendCount > 0 then%>

	<%'post ��� ��ȯ���� ����
	'Response.Redirect FormSendURL%>
	<%'=FormSendURL%>

    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <!-- #include virtual = "/Include/Head.asp" -->
		<SCRIPT LANGUAGE="JavaScript">
		function SubmitFunction(){
			if( confirm('<%=StudentCount%>���� <%=SMSSendCount%>���� SMS�� �߼��մϴ�.\n���� �� ������ <%=LongistLength%>����Ʈ�� �Ʒ��� �����ϴ�. \n\n<%=LongistSMSBody%> \n\nȸ�Ź�ȣ: <%=Session("CallBack")%> \n\n�߼��� �����ұ��?')==true ) {
				SMSSendForm.submit();
			}
		}
		</SCRIPT>
	</HEAD>
	<BODY onload="SubmitFunction();">
	<!-- 'post ��� ��ȯ���� �߰� -->
	<FORM METHOD="POST" name="SMSSendForm" ACTION="http://s.metissoft.com/sms/MetisStatsSMSSendBWCForm.asp">
		<input type="hidden" name="tran_id" value="MetisSmsSender">
		<input type="hidden" name="tran_pwd" value="freyja00">
		<input type="hidden" name="tran_msg" value="<%=SMSBody%>">
		<input type="hidden" name="tran_callback" value="<%=Session("CallBack")%>">
		<input type="hidden" name="StudentCount" value="<%=StudentCount%>">
		<%=FormSMSDestination%>
		<%=FormSMSSubjectCode%>
		<%=FormSMSStudentNumber%>
		<%=FormSMSStudentName%>
		<%=FormSMSDivision0%>
		<%=FormSMSSubject%>
	</FORM>
	</BODY>
	</HTML>

<%End If%>
