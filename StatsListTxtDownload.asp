<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>

<%Response.Buffer = False
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%

'Response.AddHeader "Content-Disposition","inline;filename=" & filename
Dim FileName, FilePath
Dim ResultTempStr, ReceiverTempStr
'결과
select case Session("FormStatsResult")
	case 0
		ResultTempStr = "전체"
	case 1
		ResultTempStr = "충원예정"
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
End select

If Session("FormStatsDegree") <>"" Then
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&ResultTempStr&Session("FormStatsMemberID")&Session("FormStatsResultType")&"제"&Session("FormStatsDegree")&"차충원"
Else
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&ResultTempStr&Session("FormStatsMemberID")&Session("FormStatsResultType")
End If

If FileName="" Then
	FileName="전체세부내역"
Else
	FileName=FileName&"세부내역"
End If
'FileName = Server.URLEncode(FileName)

FileName = Server.URLEncode(FileName) & ".txt"

FilePath	= Server.MapPath ("/Download/")&"\"&FileName	

'Response.write FilePath
'Response.contenttype="application/unknown" 
'Response.AddHeader "Content-Disposition","attachment;filename=" & filename

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
'미작업 추출시는 Degree를 쿼리 중간에 둬야한다.
'Result, MemberID, Inserttime 검색 제외
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
	'OrderStrSql = "order by ET.SubjectCode, ET.Ranking"
	OrderStrSql = "order by subject, Division0, Division1, ET.Ranking"
Else
	OrderStrSql = "order by " & Session("FormStatsOrderType")
End If
'Response.write OrderStrSql
'Response.End


Set Rs1 = Server.CreateObject("ADODB.Recordset")

'----------------------------------------------------------------------------------
' 해당값 가져오기
'----------------------------------------------------------------------------------
'충원예정 추출 전용 쿼리, 한성대 소스 쿼리, 충원대상자
If Session("FormStatsResult")=1 Then
	StrSql = ""
	StrSql = StrSql & vbCrLf & "--충원예정(RemainCount) = 정원-등록예정-등록완료"
	StrSql = StrSql & vbCrLf & "--커트라인(RankingCutLine) = 정원+포기+미등록+환불+기환불"
	StrSql = StrSql & vbCrLf & ""
	StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
	StrSql = StrSql & vbCrLf & "select @Degree = '" & Session("FormStatsDegree") &"'"
	StrSql = StrSql & vbCrLf & "-- select @Degree = '4' 부분의 숫자를 조회하실 차수로 변경 하신 후 실행하세요."
	StrSql = StrSql & vbCrLf & "-- 현재는 4차의 등록, 미등록 데이터 까지  입력완료된 상태이고, 5차의 통보예정자와 그 목록을 추출하는 쿼리 입니다."
	StrSql = StrSql & vbCrLf & ""

	StrSql = StrSql & vbCrLf & "select a.*, et.SubjectCode, et.StudentNumber, et.StudentName, et.Ranking, Tel1, Tel2, Tel3, Tel4, Tel5, cr.idx"
	StrSql = StrSql & vbCrLf & ", null Degree, null Tel, null MemberID, null Receiver, null Result, null SaveFile, null Memo, null InsertTime, 0 CallCountIsNull, 1 ResultIsNull"
	StrSql = StrSql & vbCrLf & "from"
	StrSql = StrSql & vbCrLf & "("
	StrSql = StrSql & vbCrLf & "	select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
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
Else
	If Session("FormStatsResultType")="" Then
		StrSql =		"select ET.StudentNumber, ET.StudentName, ET.Ranking"
		StrSql = StrSql & vbCrLf & ", D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & ", A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & ", isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & ", isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & ", ET.Tel1, ET.Tel2, ET.Tel3, ET.Tel4, ET.Tel5"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "inner join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
		If Session("FormStatsDegree") <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable ET"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where 1=1"

		'StrSql = StrSql & vbCrLf & "and D.Subject in ('경영과','기계과','문예창작과','보건의료정보과','부동산경영과','뷰티아트과','사회복지과','사회체육과','산업디자인과','산업시스템경영과','세무회계과','실용음악과','연극영상과','영어과')"
		'StrSql = StrSql & vbCrLf & "and D.Subject in ('유아교육과','음악과','일본어과','전기과','정보통신과','중국어과','지적과','청소년교육복지과','커뮤니케이션디자인과','컴퓨터전자과','컴퓨터정보과','토목과','패션텍스타일·세라믹과','행정과')"


		StrSql = StrSql & vbCrLf & SubStrSql
		StrSql = StrSql & vbCrLf & OrderStrSql
	Else
		StrSql =		"select ET.StudentNumber, ET.StudentName, ET.Ranking"
		StrSql = StrSql & vbCrLf & ", D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & ", A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & ", isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & ", isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & ", ET.Tel1, ET.Tel2, ET.Tel3, ET.Tel4, ET.Tel5"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "left outer join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
		If Session("FormStatsDegree") <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable ET"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where 1=1"
		StrSql = StrSql & vbCrLf & SubStrSql
		StrSql = StrSql & vbCrLf & OrderStrSql
	End If
End If
'Response.Write StrSql
'Response.End
Rs1.Open StrSql, Dbcon, 1, 1

Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime, i
Dim	DefaultPath
Dim Tel1, Tel2, Tel3, Tel4, Tel5
If Not Rs1.EOF Then
	DefaultPath = Server.MapPath ("/Download/") & "\"
	'Response.write DefaultPath
	Dim FSO, F1, Ts, S
	Const ForReading = 1
	'FSO를 선언합니다.
	Set FSO = CreateObject("Scripting.FileSystemObject")
	' 파일을 만듭니다.
	'Response.Write "파일을 쓰고 있습니다 <br>"
	Set F1 = FSO.CreateTextFile( FilePath, True)

	'F1.WriteLine Chr(34) & "수험번호" & Chr(34) & "," & Chr(34) & "이름" & Chr(34) & "," & Chr(34) & "모집코드" & Chr(34) & "," & Chr(34) & "학과" & Chr(34) & "," & Chr(34) & "전형" & Chr(34) & "," & Chr(34) & "구분1" & Chr(34) & "," & Chr(34) & "구분2" & Chr(34) & "," & Chr(34) & "구분3" & Chr(34) & "," & Chr(34) & "차수" & Chr(34) & "," & Chr(34) & "전화번호" & Chr(34) & "," & Chr(34) & "상담원" & Chr(34) & "," & Chr(34) & "수신자" & Chr(34) & "," & Chr(34) & "결과" & Chr(34) & "," & Chr(34) & "전화횟수" & Chr(34) & "," & Chr(34) & "녹음파일" & Chr(34) & "," & Chr(34) & "메모" & Chr(34) & "," & Chr(34) & "작업시각" & Chr(34)
	F1.WriteLine "수험번호	이름	석차	모집코드	전형	학과	구분1	구분2	구분3	차수	발신번호	상담원	수신자	결과	전화횟수	녹음파일	메모	작업시각	전화1	전화2	전화3	전화4	전화5"
	do Until Rs1.EOF
		StudentNumber= Rs1("StudentNumber")
		StudentName= Rs1("StudentName")
		Ranking= Rs1("Ranking")
		SubjectCode= Rs1("SubjectCode")
		Subject= Rs1("Subject")
		Division0= Rs1("Division0")
		Division1= Rs1("Division1")
		Division2= Rs1("Division2")
		Division3= Rs1("Division3")
		Degree= Rs1("Degree")
		Tel= Rs1("Tel")
		MemberID= Rs1("MemberID")
		Receiver= Rs1("Receiver")
		Result= Rs1("ResultIsNull")
		CallCount= Rs1("CallCountIsNull")
		SaveFile= Rs1("SaveFile")
		If SaveFile <>"" Then SaveFile=StudentNumber&SaveFile&".wav"
		Memo= Rs1("Memo")
		InsertTime= Rs1("InsertTime")
		Tel1= getParameter(Rs1("Tel1"), "")
		Tel2= getParameter(Rs1("Tel2"), "")
		Tel3= getParameter(Rs1("Tel3"), "")
		Tel4= getParameter(Rs1("Tel4"), "")
		Tel5= getParameter(Rs1("Tel5"), "")
		i = i + 1
		'결과
		select case Result
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
			'기본값이 미작업 이므로 Else가 필요없다
			'case Else
			'	ResultTempStr = ""
		End select
		'받은사람
		select case Receiver
			case 1
				ReceiverTempStr = "없음"
			case 2
				ReceiverTempStr = "지원자"
			case 3
				ReceiverTempStr = "부모"
			case 4
				ReceiverTempStr = "가족"
			case 5
				ReceiverTempStr = "기타"
			case Else
				ReceiverTempStr = ""
		End select
		'F1.WriteLine "11110036,000111XX,박승현,국어국문학과,정시,0222262356,01190863693,,2"
		'F1.WriteLine Chr(34) & StudentNumber & Chr(34) & "," & Chr(34) & StudentName & Chr(34) & "," & Chr(34) & SubjectCode & Chr(34) & "," & Chr(34) & Subject & Chr(34) & "," & Chr(34) & Division0 & Chr(34) & "," & Chr(34) & Division1 & Chr(34) & "," & Chr(34) & Division2 & Chr(34) & "," & Chr(34) & Division3 & Chr(34) & "," & Chr(34) & Degree & Chr(34) & "," & Chr(34) & Tel & Chr(34) & "," & Chr(34) & MemberID & Chr(34) & "," & Chr(34) & Receiver & Chr(34) & "," & Chr(34) & ResultTempStr & Chr(34) & "," & Chr(34) & CallCount & Chr(34) & "," & Chr(34) & SaveFile & Chr(34) & "," & Chr(34) & Memo & Chr(34) & "," & Chr(34) & InsertTime & Chr(34)
		F1.WriteLine StudentNumber & "	" & StudentName & "	" & Ranking & "	" & SubjectCode & "	" & Division0 & "	" & Subject & "	" & Division1 & "	" & Division2 & "	" & Division3 & "	" & Degree & "	" & Tel & "	" & MemberID & "	" & ReceiverTempStr & "	" & ResultTempStr & "	" & CallCount & "	" & SaveFile & "	" & Memo & "	" & InsertTime & "	" & Tel1 & "	" & Tel2 & "	" & Tel3 & "	" & Tel4 & "	" & Tel5
		Rs1.MoveNext
	Loop
	F1.Close
	set F1 = Nothing
	set FSO = Nothing
	Rs1.Close
	Set Rs1 = Nothing
End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->


<%
If i>0 Then
	Dim user_agent
	Dim content_disp
	Dim contenttype
	Dim objFS, objF, objDownload
	user_agent = Request.ServerVariables("HTTP_USER_AGENT")
	If InStr(user_agent, "MSIE") > 0 Then
        'IE 5.0인 경우.
        If InStr(user_agent, "MSIE 5.0") > 0 Then
            content_disp = "attachment;filename="
            contenttype = "application/x-msdownload"
        'IE 5.0이 아닌 경우.
        Else
            content_disp = "attachment;filename="
            contenttype = "application/unknown"
        End If
	Else
        'Netscape등 기타 브라우저인 경우.
        content_disp = "attachment;filename="
        contenttype = "application/unknown"
	End If
	 
	Response.AddHeader "Content-Disposition", content_disp & filename
	set objFS = Server.CreateObject("Scripting.FileSystemObject")
	set objF = objFS.GetFile(filepath)
	Response.AddHeader "Content-Length", objF.Size
	set objF = Nothing
	set objFS = Nothing
	Response.ContentType = contenttype
	Response.CacheControl = "public"
	 
	Set objDownload = Server.CreateObject("DEXT.FileDownload")
	objDownload.Download filepath
	Set objDownload = Nothing
Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('통계 세부내역','조건에 맞는 결과가 없습니다.');</SCRIPT>"
End If
%>