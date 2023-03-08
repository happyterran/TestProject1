<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%'방법2
'Session.CodePage = "949"'ansi
'Response.Charset = "euc-kr"
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"
%>
<%
Dim Timer1
Timer1=Timer()
	'#################################################################################
	'##학과 구분 조건을 활용한 SubStrSql
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
'	If Session("FormStatsDegree") <> "" Then
'		SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & Session("FormStatsDegree") & "'"
'	End If

'경민대 안철명선생님의 요청으로 결과 조건 부분은 가림
'세부내역에서 결과를 선택하고 전체통계로 넘어오면 결과 세션이 남아있어서 특정 결과값만 가져오다 보니
'무조건 MoveNext하면서 가져오므로 한 학과당 필요 레코드 수가 충족되지 않아 에러남
'	If Session("FormStatsResult") <> 0 Then
'		If Session("FormStatsResult") = 1 Then
			'SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
'		Else
			'SubStrSql = SubStrSql & vbCrLf & "and Result = '" & Session("FormStatsResult") & "'"
'		End If
'	End If
'	If Session("FormStatsMemberID") <> "" Then
'		SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & Session("FormStatsMemberID") & "'"
'	End If
	'Response.Write SubStrSql

'Dim Timer1
'Timer1=Timer()
Dim FormStudentNumber
FormStudentNumber = Request.Querystring("FormStudentNumber")
'##############################
'## 종합통계 - 전체통계
'##############################
'Dim Rs1, StrSql
Set Rs1 = Server.CreateObject("ADODB.Recordset")
'Response.write Session("StatsDegree")
StrSql =       "select A.SubjectCode,A.Division0,A.Subject,A.Division1,A.Division2,A.Division3,A.Quorum,B.StatsResult,C.ResultCount"
StrSql = StrSql & vbCrLf & "from SubjectTable A"
StrSql = StrSql & vbCrLf & "join StatsResultCode B"
StrSql = StrSql & vbCrLf & "on B.StatsResult<>1"
StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where 1=1"

'StrSql = StrSql & vbCrLf & "		where Degree = '" & Session("FormStatsDegree") & "'"
'입력건수는 일단 차수가 지정되면 해당 차수만의 결과를 조회해야한다
If Session("FormStatsDegree") <> "" Then
StrSql = StrSql & vbCrLf & "		and Degree = '" & Session("FormStatsDegree") & "'"
End If
'MemberID는 RegistRecord 에만 있다
If Session("FormStatsMemberID") <> "" Then
StrSql = StrSql & vbCrLf & "		and MemberID = '" & Session("FormStatsMemberID") & "'"
End If

StrSql = StrSql & vbCrLf & "		group by StudentNumber"
StrSql = StrSql & vbCrLf & "	) B"
StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
StrSql = StrSql & vbCrLf & "	inner join "
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
StrSql = StrSql & vbCrLf & "		from StudentTable"
StrSql = StrSql & vbCrLf & "	) C"
StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & "	union all"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select SubjectCode, 11 as Result, Count(*) "
StrSql = StrSql & vbCrLf & "		from StudentTable"
StrSql = StrSql & vbCrLf & "		group by SubjectCode"
StrSql = StrSql & vbCrLf & "	)"
StrSql = StrSql & vbCrLf & ") C"
StrSql = StrSql & vbCrLf & "on A.SubjectCode = C.SubjectCode"
StrSql = StrSql & vbCrLf & "	and B.StatsResult = C.Result"
StrSql = StrSql & vbCrLf & "where 1=1"
StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
'StrSql = StrSql & vbCrLf & "order by A.SubjectCode, B.StatsResult"
StrSql = StrSql & vbCrLf & "order by Subject, Division2 desc, Division0, Division1, B.StatsResult"


'Response.Write StrSql
'Response.End
Rs1.CursorLocation = 3
Rs1.CursorType = 3
Rs1.LockType = 3
Rs1.Open StrSql, Dbcon


Dim FileName
If Session("FormStatsDegree") <>"" Then
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&Session("FormStatsMemberID")&Session("FormStatsResultType")&"제"&Session("FormStatsDegree")&"차충원"
Else
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&Session("FormStatsMemberID")&Session("FormStatsResultType")
End If

If FileName="" Then
	FileName="차수별 입력건수"
Else
	FileName=FileName&" 차수별 입력건수"
End If

FileName=Server.UrlEncode(FileName)
'Response.Write FileName
'Response.end

'FileName=UrlDecode("asd+f123%EA%B0%80%EB%82%98%EB%8B%A4")
'Response.Write FileName
'Response.End

'FileName=UrlDecode(server.UrlEncode(FileName))
'Response.Write FileName
'Response.end



If Rs1.RecordCount>0 Then

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", " filename=" & FileName &".xls"
    %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
	<META http-equiv="Content-Type" content="text/html;charset=utf-8">
  <TITLE> METIS </TITLE>
	<style>
		td{font-size:8pt; text-align:center;}
		.fs15{font-size:15pt;}
		.lb{border-left-width:2px;}
		.rb{border-right-width:2px;}
		.bb{border-bottom-width:2px;}
		.tb{border-top-width:2px;}
		.lbb{border-left-width:2px; border-bottom-width:2px;}
		.rbb{border-right-width:2px; border-bottom-width:2px;}
		.rtb{border-right-width:2px; border-top-width:2px;}
		.ltb{border-left-width:2px; border-top-width:2px;}
		.DisWordSP{letter-spacing:-1pt;}
	</style>
 </HEAD>

<table border="1" cellspacing="0" cellpadding="0" style="border: 1px solid #000000;">
		<tr>
			<td style="border-bottom: 1px solid #000000;">코드</td>
			<td style="border-bottom: 1px solid #000000;">모집구분</td>
			<td style="border-bottom: 1px solid #000000;">학과명</td>
			<td style="border-bottom: 1px solid #000000;">구분1</td>
			<td style="border-bottom: 1px solid #000000;">구분2</td>
			<td style="border-bottom: 1px solid #000000; border-right: #000000 1px solid;">구분3</td>
			<td style="border-bottom: 1px solid #000000;">등록예정</td>
			<td style="border-bottom: 1px solid #000000;">미결정</td>
			<td style="border-bottom: 1px solid #000000;">미연결</td>
			<td style="border-bottom: 1px solid #000000; border-right: #000000 1px solid;">등록완료</td>
			<td style="border-bottom: 1px solid #000000;">포기</td>
			<td style="border-bottom: 1px solid #000000;">미등록</td>
			<td style="border-bottom: 1px solid #000000;">환불</td>
		</tr>
	<%
	Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum
	Dim RegistCount ,AbandonCount ,UndecidedCount ,NonConnectedCount ,WrongNumberCount ,NonRegistCount ,RefundCount, StudentCount, RegistPlanCount, RemainCount, ResourceCount
	Dim BGColor
	Dim QuorumSum, RegistCountSum, AbandonCountSum, UndecidedCountSum, NonConnectedCountSum, WrongNumberCountSum, NonRegistCountSum, RefundCountSum, StudentCountSum, RegistPlanCountSum, RemainCountSum, ResourceCountSum
	RemainCountSum = 0
	ResourceCountSum = 0
	BGColor="background-color: #f0f0f0;"
	Dim QuorumFix, QuorumDIffrence, QuorumDIffrenceTemp
	Dim QuorumFixSum, QuorumDIffrenceSum, ODR, SubjectBefore, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp
	ShowSum = false
	'대전보건대 요청 자원이 마이너스 일 때 붉은색으로 표시
	Dim ResourceCountColor
	do Until Rs1.EOF
		SubjectCode= getParameter(  Rs1("SubjectCode"),  "&nbsp;")
		Subject= getParameter(  Rs1("Subject") , "&nbsp;")
		Division0= getParameter(  Rs1("Division0") , "&nbsp;")
		Division1= getParameter(  Rs1("Division1") , "&nbsp;")
		Division2= getParameter(  Rs1("Division2") , "&nbsp;")
		Division3= getParameter(  Rs1("Division3") , "&nbsp;")
		Quorum= getParameter(  Rs1("Quorum") , "&nbsp;")
		RegistCount= getIntParameter( Rs1("ResultCount") , 0)
		Rs1.MoveNext
		AbandonCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		UndecidedCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		NonConnectedCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		RegistPlanCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		NonRegistCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		RefundCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		StudentCount= getIntParameter(  Rs1("ResultCount") , 0)
		Rs1.MoveNext
		'자원 = 지원자-정원-포기-미등록-환불
		ResourceCount= StudentCount - Quorum - AbandonCount - NonRegistCount - RefundCount
		If ResourceCount >=0 Then
			'(자원이 0 이상일 경우)
			'미작업 = 정원-등록예정-미결정-미연결-등록완료
			RemainCount= Quorum - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount
		Else
			'(자원이 0보다 작을경우)
			'미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(제외)
			'미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(포기+미등록+환불)
			'미작업 = 지원자-등록예정-미결정-미연결-등록완료-포기-미등록-환불
			RemainCount= StudentCount - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount - AbandonCount - NonRegistCount - RefundCount
		End If
		If BGColor = "background-color: #f9f9f9;" Then 
			BGColor="background-color: #f0f0f0;"
		ElseIf BGColor="background-color: #f0f0f0;" Then
			BGColor="background-color: #f9f9f9;"
		End If
		
		QuorumSum = QuorumSum + Quorum
		RegistCountSum = RegistCountSum + RegistCount
		AbandonCountSum = AbandonCountSum + AbandonCount
		UndecidedCountSum = UndecidedCountSum + UndecidedCount
		NonConnectedCountSum = NonConnectedCountSum +NonConnectedCount
		WrongNumberCountSum = WrongNumberCountSum + WrongNumberCount
		NonRegistCountSum = NonRegistCountSum + NonRegistCount
		RefundCountSum = RefundCountSum + RefundCount
		StudentCountSum = StudentCountSum + StudentCount
		RegistPlanCountSum = RegistPlanCountSum + RegistPlanCount
		If RemainCount > 0 Then
			RemainCountSum = RemainCountSum + RemainCount
		End If
		If ResourceCount > 0 Then
			ResourceCountSum = ResourceCountSum + ResourceCount
		End If		
		%>
		<TR <%=BGColor%>>
			<TD nowrap style="mso-number-format:\@;"><%=SubjectCode%></TD>
			<TD nowrap><%=Division0%></TD>
			<TD nowrap><%=Subject%></TD>
			<TD nowrap style="mso-number-format:\@"><%=Division1%></TD>
			<TD nowrap style="mso-number-format:\@; text-align: left; padding-left: 20px"><%=Division2%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; border-right: 1px solid #000000;"><%=Division3%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RegistPlanCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=UndecidedCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonConnectedCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=RegistCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=AbandonCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonRegistCount%></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RefundCount%></TD>
		</TR>
		<%'Rs1.MoveNext
	Loop
	Rs1.Close
	Set Rs1 = Nothing
	%>
		<!-- 신구대 수정사항 ########## 총 합 ########## -->
		<TR bgcolor='#FFFFFF'>
			<TD nowrap style="border-top: 1px solid #000000; border-right: 1px solid #000000" colspan="6"><B>총합</B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=RegistPlanCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=UndecidedCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=NonConnectedCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;"><B><%=RegistCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=AbandonCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=NonRegistCountSum%></B></TD>
			<TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=RefundCountSum%></B></TD>
		</TR>
</TABLE>
<a name="End">
<%Else%>
	<SCRIPT LANGUAGE='JavaScript'> alert('조건에 맞는 결과가 없습니다.'); document.location.href='StatsDropDownSelect.asp'</SCRIPT>
<%End If%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<%'=Timer()-Timer1%>
