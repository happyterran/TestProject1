<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
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
StrSql =                   "--미작업(RemainCount) = 정원-등록예정-등록완료"
StrSql = StrSql & vbCrLf & "--커트라인(RankingCutLine) = 정원+포기+미등록+환불+기환불"
StrSql = StrSql & vbCrLf & ""
StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
StrSql = StrSql & vbCrLf & "select @Degree = '255'"
If Session("FormStatsDegree") <> "" Then
StrSql = StrSql & vbCrLf & "select @Degree = '" & Session("FormStatsDegree") & "'"
End If
StrSql = StrSql & vbCrLf & "select A.SubjectCode,A.Division0,A.Division1,A.Subject,A.Division2,A.Division3,A.QuorumFix,A.Quorum"
StrSql = StrSql & vbCrLf & ",isnull(SC.StudentCount,'0') as StudentCount"
StrSql = StrSql & vbCrLf & ",isnull(RPC.ResultCount,'0') as RegistPlanCount"
StrSql = StrSql & vbCrLf & ",isnull(UC.ResultCount,'0') as UndecidedCount"
StrSql = StrSql & vbCrLf & ",isnull(NCC.ResultCount,'0') as NonConnectedCount"
StrSql = StrSql & vbCrLf & ",isnull(RC.ResultCount,'0') as RegistCount"
StrSql = StrSql & vbCrLf & ",isnull(AC.ResultCount,'0') as AbandonCount"
StrSql = StrSql & vbCrLf & ",isnull(NR.ResultCount,'0') as NonRegistCount"
StrSql = StrSql & vbCrLf & ",isnull(RF.ResultCount,'0') as RefundCount"
StrSql = StrSql & vbCrLf & "from SubjectTable A"
StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "    select SubjectCode, Count(*) as StudentCount from StudentTable group by SubjectCode"
StrSql = StrSql & vbCrLf & ") SC"
StrSql = StrSql & vbCrLf & "on SC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '6'"   '등록예정
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") RPC"
StrSql = StrSql & vbCrLf & "on RPC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '4'"   '미결정
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") UC"
StrSql = StrSql & vbCrLf & "on UC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '5'"   '미연결
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") NCC"
StrSql = StrSql & vbCrLf & "on NCC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '2'"   '등록완료
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") RC"
StrSql = StrSql & vbCrLf & "on RC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '3'"   '포기
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") AC"
StrSql = StrSql & vbCrLf & "on AC.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '7'"   '미등록
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") NR"
StrSql = StrSql & vbCrLf & "on NR.SubjectCode = A.SubjectCode"

StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
StrSql = StrSql & vbCrLf & "	from RegistRecord A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
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
StrSql = StrSql & vbCrLf & "	where A.Result = '10'"   '환불
StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
StrSql = StrSql & vbCrLf & ") RF"
StrSql = StrSql & vbCrLf & "on RF.SubjectCode = A.SubjectCode"
StrSql = StrSql & vbCrLf & "where 1=1"
StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
'StrSql = StrSql & vbCrLf & "order by A.SubjectCode, B.StatsResult" 
'StrSql = StrSql & vbCrLf & "order by Subject, Division0, Division1, Division2"
StrSql = StrSql & vbCrLf & "order by Subject, Division2 desc, Division0, Division1"

'모집단위, 구분2, 모집시기, 구분1
'StrSql = StrSql & vbCrLf & "order by substring(A.SubjectCode,4,2), substring(A.SubjectCode,7,2), substring(A.SubjectCode,1,2), right(A.SubjectCode,1)" 
'PrintSql StrSql
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
	FileName="전체통계"
Else
	FileName=FileName&" 전체통계"
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
        <td style="border-bottom: 1px solid #000000;">모집시기</td>
        <td style="border-bottom: 1px solid #000000;">구분1</td>
        <td style="border-bottom: 1px solid #000000;">학과명</td>
        <td style="border-bottom: 1px solid #000000;">구분2</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">구분3</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">지원자</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">정원</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">모집</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">변동</td>
        <td style="border-bottom: 1px solid #000000;">등록예정</td>
        <td style="border-bottom: 1px solid #000000;">미결정</td>
        <td style="border-bottom: 1px solid #000000;">미연결</td>
        <td style="border-bottom: 1px solid #000000;">미작업</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">등록완료</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">자원</td>
        <td style="border-bottom: 1px solid #000000;">포기</td>
        <td style="border-bottom: 1px solid #000000;">미등록</td>
        <td style="border-bottom: 1px solid #000000;">환불</td>
    </tr>
	<%
	Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum
	Dim RegistCount ,AbandonCount ,UndecidedCount ,NonConnectedCount ,WrongNumberCount ,NonRegistCount ,RefundCount, StudentCount, RegistPlanCount, RemainCount, ResourceCount
	Dim BGColor
    Dim QuorumFixTotalSum, QuorumTotalSum, RegistCountSum, AbandonCountSum, UndecidedCountSum, NonConnectedCountSum, WrongNumberCountSum, NonRegistCountSum, RefundCountSum, StudentCountTotalSum, RegistPlanCountSum, RemainCountSum, ResourceCountSum
    RemainCountSum = 0
    ResourceCountSum = 0
    BGColor="#f0f0f0"
    Dim QuorumFix, QuorumDIffrence, QuorumDIffrenceTemp
    Dim QuorumSum, QuorumFixSum, QuorumDIffrenceSum, ODR, SubjectBefore, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp, StudentCountSum
    ShowSum = FALSE
    Dim ResourceCountColor
	do Until Rs1.EOF
		SubjectCode= getParameter(  Rs1("SubjectCode"),  "&nbsp;")
		'Subject= getParameter(  Rs1("Subject") , "&nbsp;")
		Division0= getParameter(  Rs1("Division0") , "&nbsp;")
		Division1= getParameter(  Rs1("Division1") , "&nbsp;")
		'Division2= getParameter(  Rs1("Division2") , "&nbsp;")
		Division3= getParameter(  Rs1("Division3") , "&nbsp;")
		Quorum= getIntParameter(  Rs1("Quorum") , 0)
		QuorumFix= getIntParameter(  Rs1("QuorumFix") , 0)
                                
        'SubjectBefore 는 MoveNext 직전의 Subject
        SubjectBefore = Subject
        Subject = getParameter(Rs1("Subject"), "")
        'ODR = getParameter(Rs1("ODR"), "")

        Dim Division2Before
        'Division2Before 는 MoveNext 직전의 Division2
        Division2Before = Division2
        Division2= getParameter(  Rs1("Division2") , "")

        '이전학과명과 현재학과명이 다르면 ShowSum = true
        'If ( SubjectBefore <> Subject and SubjectBefore<>"" ) or ( Division2Before<> Division2 and Division2Before<>"") Then 
        'If SubjectBefore<>"" And (SubjectBefore <> Subject or Division2Before <> Division2) Then
		If SubjectBefore<>"" And (SubjectBefore <> Subject) Then
            ShowSum = true
        End If

        'QuorumDIffrenceSum 폰트 컬러
        QuorumDIffrenceSumTemp = QuorumDIffrenceSum
        QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSumTemp)
        If QuorumDIffrenceSum>0 Then 
            QuorumDIffrenceSumTemp = "+" & QuorumDIffrenceSumTemp
            QuorumDIffrenceSumColor="#0000FF"
        ElseIf QuorumDIffrenceSum=0 Then
            QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
            QuorumDIffrenceSumColor="#000000"
        ElseIf QuorumDIffrenceSum<0 Then
            QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
            QuorumDIffrenceSumColor="#FF0000"
        End If

        RegistCount= getIntParameter( Rs1("RegistCount") , 0)
        AbandonCount= getIntParameter(  Rs1("AbandonCount") , 0)
        UndecidedCount= getIntParameter(  Rs1("UndecidedCount") , 0)
        NonConnectedCount= getIntParameter(  Rs1("NonConnectedCount") , 0)
        RegistPlanCount= getIntParameter(  Rs1("RegistPlanCount") , 0)
        NonRegistCount= getIntParameter(  Rs1("NonRegistCount") , 0)
        RefundCount= getIntParameter(  Rs1("RefundCount") , 0)
        StudentCount= getIntParameter(  Rs1("StudentCount") , 0)
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
        If BGColor = "#ffffff" Then 
            BGColor="#f0f0f0"
        ElseIf BGColor="#f0f0f0" Then
            BGColor="#ffffff"
        End If
        
        QuorumFixTotalSum = QuorumFixTotalSum + QuorumFix
        QuorumTotalSum = QuorumTotalSum + Quorum
        RegistCountSum = RegistCountSum + RegistCount
        AbandonCountSum = AbandonCountSum + AbandonCount
        UndecidedCountSum = UndecidedCountSum + UndecidedCount
        NonConnectedCountSum = NonConnectedCountSum +NonConnectedCount
        WrongNumberCountSum = WrongNumberCountSum + WrongNumberCount
        NonRegistCountSum = NonRegistCountSum + NonRegistCount
        RefundCountSum = RefundCountSum + RefundCount
        StudentCountTotalSum = StudentCountTotalSum + StudentCount
        RegistPlanCountSum = RegistPlanCountSum + RegistPlanCount
        If RemainCount > 0 Then
            RemainCountSum = RemainCountSum + RemainCount
        End If
        If ResourceCount > 0 Then
            ResourceCountSum = ResourceCountSum + ResourceCount
        End If

        QuorumDIffrence=Quorum-QuorumFix
        QuorumDIffrenceTemp=QuorumDIffrence
        QuorumDIffrenceTemp=cStr(QuorumDIffrenceTemp)
        
        'QuorumDIffrence 폰트 컬러
        If QuorumDIffrence>0 Then 
            QuorumDIffrenceTemp = "+" & QuorumDIffrenceTemp
            FontColor="#0000FF"
        ElseIf QuorumDIffrence=0 Then
            QuorumDIffrenceTemp = ""
            FontColor="#000000"
        ElseIf QuorumDIffrence<0 Then
            QuorumDIffrenceTemp = QuorumDIffrenceTemp
            FontColor="#FF0000"
        End If

        ResourceCountColor="#000000"
        'ResourceCount 폰트 컬러
        If ResourceCount<0 Then
            ResourceCountColor="#FF0000"
        End If
        %>
        <%If ShowSum Then%>
            <TR>
                <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">소계</TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-left: 1px solid; border-right: 1px solid;" ><%=StudentCountSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid;" ><%=QuorumFixSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid;" ><%=QuorumSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
                <TD colspan="5" style="background-color: #e7e7e7; border-left: 1px solid; border-right: 1px solid"></TD>
                <TD colspan="1" style="background-color: #e7e7e7; border-right: 1px solid"></TD>
                <TD colspan="3" style="background-color: #e7e7e7;"></TD>
            </TR>
            <%'표시 했으면 QuorumDiffrenceSum 이 0 이 맞는지 검사 
            If QuorumDIffrenceSum <> 0 Then ShowError = true
            '그리고, 0 으로 리셋
            StudentCountSum = 0
            QuorumSum = 0
            QuorumFixSum = 0
            QuorumDIffrenceSum = 0
            ShowSum=false
            '소계 표시했으면 bgcolor='FFFFFF'
            BGColor="#ffffff"
        End If
        'Sum 누적
        StudentCountSum = StudentCountSum + StudentCount
        QuorumSum = QuorumSum + Quorum
        QuorumFixSum = QuorumFixSum + QuorumFix
        QuorumDIffrenceSum = QuorumDIffrenceSum + QuorumDIffrence%>
		<TR <%=BGColor%>>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=SubjectCode%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Division0%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@; text-align: left; padding-left: 20px"><%=Division1%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Subject%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Division2%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; border-right: 1px solid #000000;"><%=Division3%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=StudentCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=QuorumFix%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=Quorum%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; color: <%=FontColor%>;"><%=QuorumDIffrenceTemp%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RegistPlanCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=UndecidedCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonConnectedCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RemainCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=RegistCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=ResourceCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=AbandonCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonRegistCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RefundCount%></TD>
		</TR>
		<%Rs1.MoveNext
	Loop
	Rs1.Close
	Set Rs1 = Nothing

    'QuorumDiffrenceSum 폰트 컬러
    QuorumDIffrenceSumTemp = QuorumDIffrenceSum
    QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSumTemp)
    If QuorumDIffrenceSum>0 Then 
        QuorumDIffrenceSumTemp = "+" & QuorumDIffrenceSumTemp
        QuorumDIffrenceSumColor="#0000FF"
    ElseIf QuorumDIffrenceSum=0 Then
        QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
        QuorumDIffrenceSumColor="#000000"
    ElseIf QuorumDIffrenceSum<0 Then
        QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
        QuorumDIffrenceSumColor="#FF0000"
    End If%>

        <TR>
            <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">소계</TD>
            <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-left: 1px solid; border-right: 1px solid;" ><%=StudentCountSum%></TD>
            <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid;" ><%=QuorumFixSum%></TD>
            <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid; color: <%=QuorumDiffrenceSumColor%>; " ><%=QuorumSum%></TD>
            <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>; "><%=QuorumDiffrenceSumTemp%></TD>
            <TD colspan="5" style="background-color: #e7e7e7; border-left: 1px solid; border-right: 1px solid"></TD>
            <TD colspan="1" style="background-color: #e7e7e7; border-right: 1px solid"></TD>
            <TD colspan="3" style="background-color: #e7e7e7;"></TD>
        </TR>

        <!-- ########## 총 합 ########## -->
        <%'QuorumDiffrenceSum 총합 폰트 컬러
        QuorumDIffrenceSum = QuorumTotalSum - QuorumFixTotalSum
        If QuorumDIffrenceSum>0 Then 
            QuorumDIffrenceSumTemp = "+" & cStr(QuorumDIffrenceSum)
            QuorumDIffrenceSumColor="#0000FF"
        ElseIf QuorumDIffrenceSum=0 Then
            QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSum)
            QuorumDIffrenceSumColor="#000000"
        ElseIf QuorumDIffrenceSum<0 Then
            QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSum)
            QuorumDIffrenceSumColor="#FF0000"
        End If%>
        <TR>
            <TD nowrap style="border-top: 1px solid #000000; border-right: 1px solid #000000" colspan="6"><B>총합</B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;"><B><%=StudentCountTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;"><B><%=QuorumFixTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000; color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumDIffrenceSumTemp%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=RegistPlanCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=UndecidedCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=NonConnectedCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-top: 1px solid #000000;"><B><%=RemainCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;"><B><%=RegistCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; border-top: 1px solid #000000;"><B><%=ResourceCountSum%></B></TD>
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
