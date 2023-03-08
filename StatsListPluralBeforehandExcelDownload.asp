<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>

<%Response.Buffer = False
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'Response.Buffer = False
'Response.AddHeader "Content-Disposition","inline;filename=" & filename

Dim FormDivision3, FormDivision2, FormDivision1, FormDivision0, FormSubject, FormResult, FormMemberID, FormResultType, FormDegree

FormDivision3 = Session("FormStatsDivision3")
FormDivision2 = Session("FormStatsDivision2")
FormDivision1 = Session("FormStatsDivision1")
FormDivision0 = Session("FormStatsDivision0")
FormSubject =   Session("FormStatsSubject")
FormResult =   Session("FormStatsResult")
FormMemberID = Session("FormStatsMemberID")
FormResultType=Session("FormStatsResultType")
FormDegree =   Session("FormStatsDegree")

Dim FileName, FilePath
Dim ResultTempStr, ReceiverTempStr

'결과를 선택하지 않으면 자동포기된 복수지원자만 추출
If FormResult = "0" Then
	'FormResult = "3"
End If
'결과
select case FormResult
	case 0
		ResultTempStr = ""
	case 1
		ResultTempStr = "미작업"
	case 2
		ResultTempStr = "등록완료"
	case 3
		ResultTempStr = "포기"
	case 4
		ResultTempStr = "미결정"
	case 5
		ResultTempStr = "미연결"
	case 6
		ResultTempStr = "등록예정"
	case 7
		ResultTempStr = "미등록"
	case 10
		ResultTempStr = "환불"
	case 11
		ResultTempStr = "기환불"
End select

	If FormDegree <>"" Then
		FileName=FormDivision0&FormSubject&FormDivision1&FormDivision2&FormDivision3&ResultTempStr&FormMemberID&FormResultType&"제"&FormDegree&"차충원"
	Else
		FileName=FormDivision0&FormSubject&FormDivision1&FormDivision2&FormDivision3&ResultTempStr&FormMemberID&FormResultType
	End If
	
	If FileName="" Then
		FileName="복수지원자 사전점검"
	Else
		FileName="복수지원자 사전점검 "&FileName
	End If
'	FilePath	= Server.MapPath ("/Download/")&"\"&FileName	
'	'Response.write FilePath
'	Response.buffer=true
'	'Response.contenttype="application/unknown" 
'	'Response.AddHeader "Content-Disposition","attachment;filename=" & filename

	'#################################################################################
	'##학과 구분 조건을 활용한 핵심항목 추출
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
	If Session("FormStatsDegree") <> "" Then
		'SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & Session("FormStatsDegree") & "'"
	End If
'	If Session("FormStatsResult") <> 0 Then
'		If Session("FormStatsResult") = 1 Then
'			SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
'		Else
'			SubStrSql = SubStrSql & vbCrLf & "and Result = " & Session("FormStatsResult") & ""
'		End If
'	End If
	If Session("FormStatsMemberID") <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & Session("FormStatsMemberID") & "'"
	End If
	
	If Session("InsertTime1") <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime >= '" & Session("InsertTime1") & " 00:00:00'"
	End If
	If Session("InsertTime2") <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime <= '" & Session("InsertTime2") & " 23:59:59.999'"
	End If
	'If Session("FormStatsResultType") <> "" Then
	'	SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormStatsResultType") & "'"
	'End If
	'Response.write SubStrSql
	'Response.End
	
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
	'If FormResultType="" Then
		StrSql =		"select * "
		StrSql = StrSql & vbCrLf & "from StudentTable ET"

		StrSql = StrSql & vbCrLf & "join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "select Citizen1, Citizen2, count(*) c"
		StrSql = StrSql & vbCrLf & "from StudentTable a"
		StrSql = StrSql & vbCrLf & "join SubjectTable b"
		StrSql = StrSql & vbCrLf & "on a.SubjectCode = b.SubjectCode"
		StrSql = StrSql & vbCrLf & "where 1=1"
		StrSql = StrSql &  SubStrSql & vbCrLf
		StrSql = StrSql & vbCrLf & "group by citizen1, citizen2"
		StrSql = StrSql & vbCrLf & "having count(*) >= 2"
		StrSql = StrSql & vbCrLf & ") DET"
		StrSql = StrSql & vbCrLf & "on ET.Citizen1=DET.Citizen1"
		StrSql = StrSql & vbCrLf & "and ET.Citizen2=DET.Citizen2"
		
		StrSql = StrSql & vbCrLf & "inner join "
		StrSql = StrSql & vbCrLf & "("
		
		StrSql = StrSql & vbCrLf & "	select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
		StrSql = StrSql & vbCrLf & "	, Quorum - isnull(r.RegistCount,0) - isnull(rp.RegistPlanCount,0) Remain"
		StrSql = StrSql & vbCrLf & "	, Quorum + isnull(b.AbadonCount,0) + isnull(c.NonRegistCount,0) + isnull(d.RefundCount,0) - isnull(z.ZeroCount,0) RankingCutLine"
		StrSql = StrSql & vbCrLf & "	, Quorum"
		StrSql = StrSql & vbCrLf & "	, isnull(r.RegistCount,0) RegistCount"
		StrSql = StrSql & vbCrLf & "	, isnull(rp.RegistPlanCount,0) RegistPlanCount"
		StrSql = StrSql & vbCrLf & "	, isnull(b.AbadonCount,0) AbadonCount"
		StrSql = StrSql & vbCrLf & "	, isnull(c.NonRegistCount,0) NonRegistCount"
		StrSql = StrSql & vbCrLf & "	, isnull(d.RefundCount,0) RefundCount"
		StrSql = StrSql & vbCrLf & "	, isnull(e.Refund2Count,0) Refund2Count"

		StrSql = StrSql & vbCrLf & "	from SubjectTable a"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistCount"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 2"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) r"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = r.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as AbadonCount"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 3"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) b"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = b.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistPlanCount"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 6"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) rp"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = rp.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as NonRegistCount"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 7"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) c"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = c.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as RefundCount"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 10"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) d"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = d.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select C.SubjectCode, A.Result, isnull(count(*),0) as Refund2Count"
		StrSql = StrSql & vbCrLf & "			   from RegistRecord A"
		StrSql = StrSql & vbCrLf & "			   inner join"
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, max(IDX) as MaxIDX "
		StrSql = StrSql & vbCrLf & "							from RegistRecord"
		StrSql = StrSql & vbCrLf & "							group by StudentNumber"
		StrSql = StrSql & vbCrLf & "			   ) B"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "			   inner join "
		StrSql = StrSql & vbCrLf & "			   ("
		StrSql = StrSql & vbCrLf & "							select StudentNumber, SubjectCode"
		StrSql = StrSql & vbCrLf & "							from StudentTable"
		StrSql = StrSql & vbCrLf & "			   ) C"
		StrSql = StrSql & vbCrLf & "			   on A.StudentNumber = C.StudentNumber"
		StrSql = StrSql & vbCrLf & "			   and A.SubjectCode = C.SubjectCode"
		StrSql = StrSql & vbCrLf & "			   where result = 11"
		StrSql = StrSql & vbCrLf & "			   group by C.SubjectCode, A.Result"
		StrSql = StrSql & vbCrLf & "	) e"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = e.SubjectCode"
		StrSql = StrSql & vbCrLf & "	left outer join"
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "			   select SubjectCode, isnull(count(*),0) as ZeroCount"
		StrSql = StrSql & vbCrLf & "			   from StudentTable"
		StrSql = StrSql & vbCrLf & "			   where ranking=0"
		StrSql = StrSql & vbCrLf & "			   group by SubjectCode"
		StrSql = StrSql & vbCrLf & "	) z"
		StrSql = StrSql & vbCrLf & "	on a.SubjectCode = z.SubjectCode"

		StrSql = StrSql & vbCrLf & ") SubjectStats"
		StrSql = StrSql & vbCrLf & "on ET.SubjectCode = SubjectStats.SubjectCode"
		
		StrSql = StrSql & vbCrLf & "left outer join "
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select CR.StudentNumber StudentNumberRegistRecord, CR.Result, CR.MemberID"
		StrSql = StrSql & vbCrLf & "	from RegistRecord CR "
		StrSql = StrSql & vbCrLf & "	inner join "
		StrSql = StrSql & vbCrLf & "	("
		StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount , max(SaveFile) as MaxSaveFile"
		StrSql = StrSql & vbCrLf & "		from RegistRecord "
		StrSql = StrSql & vbCrLf & "		group by StudentNumber "
		StrSql = StrSql & vbCrLf & "	) CRG"
		StrSql = StrSql & vbCrLf & "	on CR.StudentNumber = CRG.StudentNumber "
		StrSql = StrSql & vbCrLf & "	and CR.IDX = CRG.MaxIDX "
		StrSql = StrSql & vbCrLf & ") CR"
		StrSql = StrSql & vbCrLf & "on ET.StudentNumber = CR.StudentNumberRegistRecord"
		
		StrSql = StrSql & vbCrLf & "order by ET.Citizen1,ET.Citizen2"
	'End If


	'PrintSql StrSql
	'Response.End
	Rs1.Open StrSql, Dbcon, 1, 1

	Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime, i
	Dim	DefaultPath
	Dim Citizen1, Citizen2, fileName2
	If Rs1.RecordCount>0 Then

    fileName2 = fileName
    fileName = Server.URLEncode(FileName)

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","attachment; filename=" & fileName & ".xls"
	%>
	<HTML><HEAD><TITLE>Project METIS 2.0</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style>
	body, table, tr, td, select, textarea, input{ 
		font-family:돋움, seoul, arial, helvetica;
		font-size: 10px;
		color: #000000;
		scrollbar-3dlight-color:595959;
					scrollbar-arrow-color:FFFFFF;
					scrollbar-base-color:CFCFCF;
					scrollbar-darkshadow-color:FFFFFF;
					scrollbar-face-color:CFCFCF;
					scrollbar-highlight-color:FFFFF;
					scrollbar-shadow-color:595959
	}V,form,TEXTAREA,center,option,pre,blockquote {font-family:Verdana;font-size:8pt;color:#333333;}
	</style>
	</HEAD>
	<BODY topmargin=0 leftmargin=0 align="center" >

		<TABLE align="center">
		<TR>
			<TD style="font-size: 22 px;" align="center" colspan="11">&nbsp; </TD>
		</TR>
		<TR><!-- 
			<TD style="font-size: 22 px;" align="center" colspan="11"><%=fileName%></TD> -->
			<TD style="font-size: 22 px;" align="center" colspan="11" style="font-size: 24; font-weight: bold;"><%=fileName2%></TD>
		</TR>
		<TR>
			<TD colspan=8>&nbsp;</TD>
		</TR>
		</TABLE>
		<TABLE align="center" border="1" bgcolor="#000000" cellpadding="2" cellspacing="1" width="" style="table-layout:fixed">
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col>
		<TR bgcolor="#FFFFFF" align="center"><TD>연번</TD><TD>석차</TD>
		<TD>커트라인</TD><TD>전형</TD><TD>모집단위</TD><TD>수험번호</TD>
		<TD>등록의사</TD><TD>성 명</TD><TD>주민번호</TD><TD>상담원</TD><TD>입력시각</TD></TR>
		<%
		Dim z
		z = 0
		Dim RankingCutLine, PluralResult, PluralResultTempStr, Quorum
		do Until Rs1.EOF
			z = z + 1
			StudentNumber= Rs1("StudentNumber")
			StudentName= Rs1("StudentName")
			Citizen1= Rs1("Citizen1")
			Citizen2= Rs1("Citizen2")
			Citizen2= left(Rs1("Citizen2"), 1) & "******"
			Ranking= Rs1("Ranking")
			SubjectCode= Rs1("SubjectCode")
			Subject= Rs1("Subject")
			Division0= Rs1("Division0")
			Division1= Rs1("Division1")
			Division2= Rs1("Division2")
			Division3= Rs1("Division3")
			MemberID= Rs1("MemberID")
			PluralResult= Rs1("Result")
			InsertTime= Rs1("InsertTime")
			RankingCutLine = GetIntParameter(Rs1("RankingCutLine"), 0)
			Quorum = GetIntParameter(Rs1("Quorum"), 0)
			i = i + 1
			'결과
			select case PluralResult
				case 1
					PluralResultTempStr = "추가합격"
				case 2
					PluralResultTempStr = "등록완료"
				case 3
					PluralResultTempStr = "포기"
				case 4
					PluralResultTempStr = "미결정"
				case 5
					PluralResultTempStr = "미연결"
				case 6
					PluralResultTempStr = "등록예정"
				case 7
					PluralResultTempStr = "미등록"
				case 8
					PluralResultTempStr = ""
				case 9
					PluralResultTempStr = ""
				case 10
					PluralResultTempStr = "환불"
				case Else
					PluralResultTempStr = ""
			End Select
			If Ranking > RankingCutLine Then
				PluralResultTempStr = "후보"
			End If
			If PluralResult = 1 and Ranking <= Quorum Then
				PluralResultTempStr = "최초합격"
			End If 

			Response.write "<TR bgcolor='#FFFFFF' align='center' height='23'><TD nowrap align='center' style='padding-right:5px;'>" & i & "</TD><TD nowrap align='center' style='padding-right:5px;'>" & Ranking & "</TD>"
			
			Response.write "<TD nowrap>" & RankingCutLine & "</TD><TD align='left' style='word-break:break-all;' style='padding-left:10px;' width='120'>" & Division0 & " " & Division1 & " " & Division2 & "</TD><TD>" & Subject & " " & Division3 & "</TD><TD nowrap>" & StudentNumber & "</TD>"
			
			Response.write "<TD nowrap>" & PluralResultTempStr & "</TD><TD nowrap>" & StudentName & "</TD><TD nowrap>" & Citizen1 & "-" & Citizen2 &"</TD><TD nowrap>" & MemberID &"</TD><TD nowrap>" & InsertTime &"</TD></TR>"

			Rs1.MoveNext
		Loop
		Response.write "</TABLE>"
	End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->


<%
If i>0 Then

Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('복수지원 사전점검','조건에 맞는 결과가 없습니다.');</SCRIPT>"
End If
%>