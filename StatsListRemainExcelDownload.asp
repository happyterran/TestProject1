<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>

<%Response.Buffer = False
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"%>
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Const LineNum = 40

Dim FormDivision3, FormDivision2, FormDivision1, FormDivision0, FormSubject, FormResult, FormMemberID, FormResultType, FormDegree

FormDivision3 = Request.Querystring("FormDivision3")
FormDivision2 = Request.Querystring("FormDivision2")
FormDivision1 = Request.Querystring("FormDivision1")
FormDivision0 = Request.Querystring("FormDivision0")
FormSubject =   Request.Querystring("FormSubject")
FormResult =   Request.Querystring("FormResult")
FormMemberID = Request.Querystring("FormMemberID")
FormResultType=Request.Querystring("FormResultType")
FormDegree =   Request.Querystring("FormDegree")

	Dim FileName, FilePath
	Dim ResultTempStr, ReceiverTempStr

'한성대전용 기환불 출력 화면에서만 필요했던 것. 그래서 생략한다. StatsFileDownload_HanSungUniversity.asp
'	If FormResult = "0" Then
'		FormResult = "11"
'	End If
	'결과
	select case FormResult
		case 0
			ResultTempStr = "전체"
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


	'#################################################################################
	'##학과 구분 조건을 활용한 핵심항목 추출
	'#################################################################################
	Dim Rs1, StrSql, SubStrSql
	SubStrSql = ""
	If FormSubject <> "" Then
		SubStrSql =					"and Subject = '" & FormSubject & "'"
	End If
	If FormDivision0 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & FormDivision0 & "'"
	End If
	If FormDivision1 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & FormDivision1 & "'"
	End If
	If FormDivision2 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & FormDivision2 & "'"
	End If
	If FormDivision3 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & FormDivision3 & "'"
	End If
	'Response.write SubStrSql
	'Response.End
	
	Dim OrderStrSql
	If Session("FormStatsOrderType") = "" Then
		'OrderStrSql = "order by ET.SubjectCode, ET.Ranking"
		OrderStrSql = "order by subject, Division0, Division1, ET.Ranking"
	Else
		OrderStrSql = "order by " & Session("FormStatsOrderType")
	End If
	'Response.write OrderStrSql
	'Response.End
	
	Set Rs1 = Server.CreateObject("ADODB.Recordset")

	StrSql = ""
	StrSql = StrSql & vbCrLf & "--미작업(RemainCount) = 정원-등록예정-등록완료"
	StrSql = StrSql & vbCrLf & "--커트라인(RankingCutLine) = 정원+포기+미등록+환불+기환불"
	StrSql = StrSql & vbCrLf & ""
	StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
	StrSql = StrSql & vbCrLf & "select @Degree = '" & FormDegree &"'"
	StrSql = StrSql & vbCrLf & "-- select @Degree = '4' 부분의 숫자를 조회하실 차수로 변경 하신 후 실행하세요."
	StrSql = StrSql & vbCrLf & "-- 현재는 4차의 등록, 미등록 데이터 까지  입력완료된 상태이고, 5차의 전화충원 예정자와 그 목록을 추출하는 쿼리 입니다."
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "select a.*, et.SubjectCode, et.StudentNumber, et.StudentName, et.Ranking, cr.idx"
	StrSql = StrSql & vbCrLf & "from"
	StrSql = StrSql & vbCrLf & "("
	StrSql = StrSql & vbCrLf & "	select a.SubjectCode, Division0, Subject, Division1, Division2"
	StrSql = StrSql & vbCrLf & "	--등록완료+등록예정을 한번에 구해"
	StrSql = StrSql & vbCrLf & "	, Quorum - isnull(r.RegistCount,0) Remain"
	StrSql = StrSql & vbCrLf & "	--포기+미등록+환불+기환불을 한번에 구해"
	StrSql = StrSql & vbCrLf & "	, Quorum + isnull(b.AbadonCount,0) RankingCutLine"
	StrSql = StrSql & vbCrLf & "	, Quorum"
	StrSql = StrSql & vbCrLf & "	, isnull(r.RegistCount,0) RegistCount"
	StrSql = StrSql & vbCrLf & "	, isnull(b.AbadonCount,0) AbadonCount"
	StrSql = StrSql & vbCrLf & "	from SubjectTable a"
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "	--등록완료+등록예정을 한번에 구해"
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

	StrSql = StrSql & vbCrLf & "	--포기+미등록+환불+기환불을 한번에 구해"
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
        StrSql = StrSql & vbCrLf & "and 1=2 "               '충원예정자는 차수지정이 필수다. 차수가 없으면 의도적으로 리스트업 제한
    End If
    StrSql = StrSql & vbCrLf & "and cr.IDX is Null"         '충원예정자는 전화기록이 없는 지원자만
    StrSql = StrSql & vbCrLf & "and et.IDX is Not Null"     '충원예정자는 지원자가 존재하는 모집단위만

	StrSql = StrSql & vbCrLf & SubStrSql
	StrSql = StrSql & vbCrLf & OrderStrSql
	
	'Response.Write StrSql
	'Response.End
	Rs1.Open StrSql, Dbcon, 1, 1

	Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime
	Dim	DefaultPath

	Dim TheFirstExecute, StatsFileDownloadSubjectCode
	TheFirstExecute = 1

	Dim RankingCutLine

	Dim z, i
	i = 0 '연번
	z = 0 '줄번
	Dim pageNumber
	Dim Citizen1, Citizen2, Score, DegreeTemp
	pageNumber = 0

	Dim BackgroundColor
	BackgroundColor = "#EEEEEE"
'##########################################################################################################################################
If Rs1.EOF = false Then

 

    Dim MYear
    If Mid(Date(),6,2)>"05" Then
        MYear = Left(Date()+365,4)
    End If

    filename = Server.URLEncode(MYear & "학년도 " & Division0 & Division1 & " " & (FormDegree+1) & "차 전화충원 예정자") & ".xls"

	Response.ContentType = "application/vnd.ms-excel"
    'Response.AddHeader "Content-Disposition","attachment; filename=" & MYear & "학년도 " & Division0 & Division1 & " " & (FormDegree+1) & "차 전화충원 예정자.xls"
	Response.AddHeader "Content-Disposition","attachment; filename=" & filename%>
	<HTML><HEAD><TITLE>Project METIS 2.0</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style>
	body, table, tr, td, select, textarea, input{ 
			font-family:돋움, seoul, arial, helvetica;
			font-size: 11px;
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

	</HEAD><BODY topmargin=0 leftmargin=0>


	<TABLE align="center" width="800">
	<TR><TD height="15" align="center" style="border-top:1px" colspan="8">&nbsp;</TD></TR>
	<TR><TD height="33" style="font-size: 20px;" align="center" colspan="8"><B><%=MYear%>학년도 <%=Division0 & Division1 & " " & (FormDegree+1)%>차 전화충원 예정자</B></TD></TR>
	<TR><TD style="font-size: 14 px;" align="left" colspan=8><%=Subject%></TD></TR>
	</TABLE>

	<TABLE align="center" border="1" bgcolor="#000000" cellpadding="2" cellspacing="1" width="800" style="table-layout:fixed">
	<TR bgcolor='<%=BackgroundColor%>' align='center' height='20'>
	<TD width="40">연번</TD>
	<TD width="110">수험번호</TD>
	<TD width="80">이름</TD>
	<TD width="60">석차</TD>
	<TD width="110">모집시기</TD>
	<TD width="140">구분1</TD>
	<TD width="110">학과명</TD>
	<TD width="110">구분2</TD>
	<TD width="110">구분3</TD>
	<TD width="60">커트라인</TD>
	</TR>
<%Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('전화충원 예정자','조건에 맞는 결과가 없습니다.');</SCRIPT>"
    Rs1.Close
    Set Rs1=Nothing
    Response.End
End If
'##########################################################################################################################################
'Response.End









'##########################################################################################################################################
If Rs1.EOF = false Then

	'첫 RS1 루프
	do Until Rs1.EOF

		z = z + 1
		i = i + 1
		StudentNumber= Rs1("StudentNumber")
		StudentName= Rs1("StudentName")
		Ranking= Rs1("Ranking")
		SubjectCode= Rs1("SubjectCode")
		Subject= Rs1("Subject")
		Division0= Rs1("Division0")
		Division1= Rs1("Division1")
		Division2= Rs1("Division2")
		RankingCutLine= Rs1("RankingCutLine")

		If BackgroundColor = "#EEEEEE" Then
			BackgroundColor = "#FFFFFF"
		Else
			BackgroundColor = "#EEEEEE"
		End If

		'디버깅용
		If i >1 Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "_" & z & "<BR>"
			'Response.End
		End If
		If i >35 Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "_" & z & "<BR>"
			'Response.End
		End If%>


		<TR bgcolor='<%=BackgroundColor%>' align='center' height='20'>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap align='right' style='padding-right:10px;'><%=i%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap style="mso-number-format:\@"><%=StudentNumber%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap><%=StudentName%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap><%=Ranking%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap align='center'><%=Division0%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@; text-align: left; padding-left: 20px;" nowrap><%=Division1%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" style='word-break:break-all;' nowrap><%=Subject%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap><%=Division2%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap><%=Division3%></TD>
		<TD style="background-color: <%=BackgroundColor%>; mso-number-format:\@;" nowrap><%=RankingCutLine%></TD>
		</TR><%
		'지원자 리스트 프로시져
		'######################################### End


		 If SubjectCode ="511211" Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "_" & z & "<BR>"
			'Response.End
		 End If

		'다음 루프에서 지원자가 동일전형인지 체크하기 위해 StatsFileDownloadSubjectCode = SubjectCode
		StatsFileDownloadSubjectCode = SubjectCode

		'디버깅용
		If i =0 Then
		'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "<BR>"
		 'Response.End
		End If
		If i >1 Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "<BR>"
			'Response.End
		End If
		If i >2 Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "<BR>"
			'Response.End
		End If
		If i >35 Then
			'Response.write SubjectCode & "_" & StatsFileDownloadSubjectCode & "_" & TheFirstExecute & "_" & i & "<BR>"
			'Response.End
		End If


		'정상적으로 한줄을 지원자 표시하면서 넘겼어도
		'40줄을 공백으로 넘겼어도 MoveNext는 해야 다음 데이터가 나온다
		Rs1.MoveNext



	Loop
	'첫번째 RS1 루프%>


<%End If
'##########################################################################################################################################
%>

<!-- #include virtual = "/Include/DbClose.asp" -->

