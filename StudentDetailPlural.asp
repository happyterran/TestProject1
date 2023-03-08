<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
<title>지원자 세부사항</title>
<!-- #include virtual = "/Include/Head.asp" -->

<script type="text/javascript" src="/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery.ui.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.popup.contents.js"></script>
</head>
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

<body style="padding-top: 0; background: #eee url('../img/main-back.png') repeat;" >

<!-- Form area -->
<div id="ui-popup-contents">
    <div class="matter">
        <div class="container-fluid" style="padding: 0;">
            <div class="row-fluid">
                <div class="span12">





<!-- Widget -->
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-content">
        <div class="padd invoice" style="padding: 0;">
            <div class="row-fluid">

                <div class="span12">
                    <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr>
                                <th colspan="1" style="text-align: center;">복수지원 결과</th>
                                <th colspan="1" style="text-align: center;">복수지원 학과</th>
                                <th colspan="1" style="text-align: center;">복수지원 점수</th>
                                <th colspan="1" style="text-align: center;">복수지원 수험번호</th>
                                <th colspan="1" style="text-align: center;">복수지원 석차</th>
                                <th colspan="1" style="text-align: center;">복수지원 커트라인</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            Dim PageSize, GotoPage
                            PageSize = 3
                            GotoPage = getIntParameter(Request.Querystring("GotoPage"), 1)
                            Dim TotalPage,recordCount
                            TotalPage   = 1
                            RecordCount = 0  
                            Dim Citizen1, Citizen2, SubjectCode, Status
                            Citizen1	 = GetParameter(Request.Querystring("Citizen1"), "")
                            Citizen2	 = GetParameter(Request.Querystring("Citizen2"), "")
                            SubjectCode = GetParameter(Request.Querystring("SubjectCode"), "")
                            Status       = GetParameter(Request.Querystring("Status"), "")
                            If Status = "1" Then Status ="대기중"
                            If Status = "2" Then Status ="전화중"
                            If Status = "3" Then Status ="녹음중"
                            Dim Rs2, StrSql
                            Set Rs2 = Server.CreateObject("ADODB.Recordset")

                            StrSql =                   "select *"
                            StrSql = StrSql & vbCrLf & "from"
                            StrSql = StrSql & vbCrLf & "("
                            StrSql = StrSql & vbCrLf & "	select *"
                            StrSql = StrSql & vbCrLf & "	from StudentTable"
                            StrSql = StrSql & vbCrLf & "	where Citizen1='" & Citizen1 & "'"
                            StrSql = StrSql & vbCrLf & "	and Citizen2='" & Citizen2 & "'"
                            StrSql = StrSql & vbCrLf & "	and SubjectCode<>'" & SubjectCode & "'"
                            StrSql = StrSql & vbCrLf & ") a"
                            StrSql = StrSql & vbCrLf & "inner join "
                            StrSql = StrSql & vbCrLf & "("

                            StrSql = StrSql & vbCrLf & "		select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
                            StrSql = StrSql & vbCrLf & "		, Quorum - isnull(r.RegistCount,0) - isnull(rp.RegistPlanCount,0) Remain"
                            StrSql = StrSql & vbCrLf & "		, Quorum + isnull(b.AbadonCount,0) + isnull(c.NonRegistCount,0) + isnull(d.RefundCount,0) - isnull(z.ZeroCount,0) RankingCutLine"
                            StrSql = StrSql & vbCrLf & "		, Quorum"
                            StrSql = StrSql & vbCrLf & "		, isnull(r.RegistCount,0) RegistCount"
                            StrSql = StrSql & vbCrLf & "		, isnull(rp.RegistPlanCount,0) RegistPlanCount"
                            StrSql = StrSql & vbCrLf & "		, isnull(b.AbadonCount,0) AbadonCount"
                            StrSql = StrSql & vbCrLf & "		, isnull(c.NonRegistCount,0) NonRegistCount"
                            StrSql = StrSql & vbCrLf & "		, isnull(d.RefundCount,0) RefundCount"
                            StrSql = StrSql & vbCrLf & "		, isnull(e.Refund2Count,0) Refund2Count"

                            StrSql = StrSql & vbCrLf & "		from SubjectTable a"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistCount"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 2"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) r"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = r.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as AbadonCount"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								where Degree <=255"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 3"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) b"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = b.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistPlanCount"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								where Degree <=255"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 6"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) rp"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = rp.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as NonRegistCount"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								where Degree <=255"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 7"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) c"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = c.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RefundCount"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								where Degree <=255"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 10"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) d"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = d.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as Refund2Count"
                            StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                            StrSql = StrSql & vbCrLf & "				   inner join"
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                            StrSql = StrSql & vbCrLf & "								from RegistRecord"
                            StrSql = StrSql & vbCrLf & "								where Degree <=255"
                            StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   ) B"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "				   inner join "
                            StrSql = StrSql & vbCrLf & "				   ("
                            StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                            StrSql = StrSql & vbCrLf & "								from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   ) C"
                            StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                            StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                            StrSql = StrSql & vbCrLf & "				   where result = 11"
                            StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                            StrSql = StrSql & vbCrLf & "		) e"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = e.SubjectCode"
                            StrSql = StrSql & vbCrLf & "		left outer join"
                            StrSql = StrSql & vbCrLf & "		("
                            StrSql = StrSql & vbCrLf & "				   select SubjectCode, isnull(count(*),0) as ZeroCount"
                            StrSql = StrSql & vbCrLf & "				   from StudentTable"
                            StrSql = StrSql & vbCrLf & "				   where ranking=0"
                            StrSql = StrSql & vbCrLf & "				   group by SubjectCode"
                            StrSql = StrSql & vbCrLf & "		) z"
                            StrSql = StrSql & vbCrLf & "		on a.SubjectCode = z.SubjectCode"

                            StrSql = StrSql & vbCrLf & ") b"
                            StrSql = StrSql & vbCrLf & "on A.SubjectCode = b.SubjectCode"
                            StrSql = StrSql & vbCrLf & "left outer join "
                            StrSql = StrSql & vbCrLf & "("
                            StrSql = StrSql & vbCrLf & "	select CR.StudentNumber StudentNumberRegistRecord, CR.Result"
                            StrSql = StrSql & vbCrLf & "	from RegistRecord CR "
                            StrSql = StrSql & vbCrLf & "	inner join "
                            StrSql = StrSql & vbCrLf & "	("
                            StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount , max(SaveFile) as MaxSaveFile"
                            StrSql = StrSql & vbCrLf & "		from RegistRecord "
                            StrSql = StrSql & vbCrLf & "		group by StudentNumber "
                            StrSql = StrSql & vbCrLf & "	) CRG"
                            StrSql = StrSql & vbCrLf & "	on CR.StudentNumber = CRG.StudentNumber "
                            StrSql = StrSql & vbCrLf & "	and CR.IDX = CRG.MaxIDX "
                            StrSql = StrSql & vbCrLf & ") c"
                            StrSql = StrSql & vbCrLf & "on A.StudentNumber = c.StudentNumberRegistRecord"
                            '순위 밖 지원자 보이지 않는 옵션
                            'StrSql = StrSql & vbCrLf & "where Ranking <= RankingCutLine"
                            StrSql = StrSql & vbCrLf & "order by A.StudentNumber asc"
                            'PrintSql( StrSql)
                            'Response.end
                            Rs2.Open StrSql, Dbcon, 1, 1
                            '----------------------------------------------------------------------------------
                            ' 전체 페이지와 전체 카운터 설정
                            '----------------------------------------------------------------------------------
                            IF (Rs2.BOF and Rs2.EOF) Then
                                recordCount = 0 
                                totalpage   = 0
                            Else
                                recordCount = Rs2.RecordCount
                                Rs2.pagesize = PageSize
                                totalpage   = Rs2.PageCount
                            End if
                            Dim PluralSubjects, PluralSubjectCode, PluralStudentNumber, PluralRanking, PluralScore, PluralResult, PluralResultTempStr
                            Dim PluralDivision0, PluralSubject, PluralDivision1, PluralDivision2, PluralDivision3
                            Dim RankingCutLine, Quorum
                            Dim RCount
                            PluralStudentNumber=""
                            if Rs2.EOF = false Then
                                RCount = Rs2.PageSize
                                Rs2.AbsolutePage = GotoPage
                                Do Until Rs2.EOF or (RCount = 0 )
                                    PluralDivision0 = GetParameter(Rs2("Division0"), "")
                                    PluralSubject		= GetParameter(Rs2("Subject"), "")
                                    PluralDivision1 = GetParameter(Rs2("Division1"), "")
                                    PluralDivision2 = GetParameter(Rs2("Division2"), "")
                                    PluralDivision3 = GetParameter(Rs2("Division3"), "")
                                    PluralSubjects	= PluralDivision0 & " " & PluralSubject & " " & PluralDivision1 & " " & PluralDivision2 & " " & PluralDivision3
                                    PluralSubjectCode = GetParameter(Rs2("SubjectCode"), "")
                                    PluralStudentNumber = GetParameter(Rs2("StudentNumber"), "")
                                    PluralRanking = GetParameter(Rs2("Ranking"), "")
                                    PluralScore = GetParameter(Rs2("Score"), "")
                                    PluralResult = GetIntParameter(Rs2("Result"), 1)
                                    Quorum			= GetIntParameter(Rs2("Quorum"), 0)
                                    RankingCutLine = GetIntParameter(Rs2("RankingCutLine"), 0)
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
                                    end Select
                                    If PluralRanking > RankingCutLine Then
                                        PluralResultTempStr = "순위 밖"
                                    End If
                                    if PluralResult = 1 and PluralRanking <= Quorum then
                                        PluralResultTempStr = "최초합격"
                                    End If 
                                    %>
                                    <tr>
                                        <td colspan="1" style="text-align: center;"><%=PluralResultTempStr%></td>
                                        <%If Session("Grade")="관리자" Then%>
                                        <td colspan="1" style="text-align: center; cursor: pointer;" onClick="StudentDetailChangeSubject(StudentDetailChangeSubjectForm, '<%=Status%>', '<%=PluralStudentNumber%>', '<%=PluralDivision0%>', '<%=PluralSubject%>', '<%=PluralDivision1%>', '<%=PluralDivision2%>', '<%=PluralDivision3%>')" onMouseOver="style.cursor='hand';this.style.backgroundColor='#EEEEEE';" onMouseOut="this.style.backgroundColor='#f9f9f9';" ><%=PluralSubjects%></td>
                                        <%Else%>
                                        <td colspan="1" style="text-align: center;"><%=PluralSubjects%></td>
                                        <%End If%>
                                        <td colspan="1" style="text-align: center;"><%=PluralScore%></td>
                                        <td colspan="1" style="text-align: center;"><%=PluralStudentNumber%></td>
                                        <td colspan="1" style="text-align: center;"><%=PluralRanking%></td>
                                        <td colspan="1" style="text-align: center;"><%=RankingCutLine%></td>
                                    </tr>
                                    <%Rs2.MoveNext
                                    RCount = RCount -1
                                Loop%>
                            <%Else%>
                                <TR><TD colspan="12" style="text-align: center;">복수지원 없음.</TD></TR>
                            <%End If
                            Rs2.close
                            Set Rs2=Nothing%>
                        </tbody>
                    </table>
                </div><!-- span12 -->
            </div><!-- row-fluid -->
        </div><!-- padd invoice -->

        <%If totalpage > 0 Then %>
            <div class="widget-foot" style="padding: 0;">
                <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                    <ul>
                    <%If gotopage>1 Then
                        Response.Write "<li><a href='StudentDetailPlural.asp?gotoPage="&(gotopage-1)&"&Citizen1=" & Citizen1 & "&Citizen2=" & Citizen2 & "&SubjectCode=" & SubjectCode & "&Status=" & Status & "'>Prev</a></li>"
                        Else
                        Response.Write "<li><a >Prev</a></li>"
                    End If%>
                    <%pageViewPluralFrameSrc%>
                    <%If cint(gotopage)<cint(totalpage) Then
                        response.write "<li><a href='StudentDetailPlural.asp?gotoPage="&(gotopage+1)&"&Citizen1=" & Citizen1 & "&Citizen2=" & Citizen2 & "&SubjectCode=" & SubjectCode & "&Status=" & Status & "'>Next</a></li>"
                        Else
                        Response.Write "<li><a >Next</a></li>"
                    End If%>
                    </ul>
                </div>
                <div class="clearfix"></div> 
            </div><!-- widget-foot -->
        <%End If%>
    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->






                </div>
            </div>
        </div>
    </div>
</div>
	
		


<%
' ##################################################################################
' 페이징
' ##################################################################################
Sub pageViewPluralFrameSrc()
    Dim intMyChoice,TotalBlock,i,NowBlock,q
    intMyChoice=10
    If totalpage > 0 then
        TotalBlock = int((totalpage-1)/intMyChoice) '전체블럭수 (블럭은 0부터 시작)
        NowBlock = int((gotoPage-1)/intMyChoice) '현재블럭수
    end if
    If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'블럭에 페이지수가 10개 이상일때
        For i = 1 to intMyChoice
            q=NowBlock*intMyChoice + i
            If(gotoPage-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='StudentDetailPlural.asp?gotoPage="&((NowBlock*intMyChoice)+i)&"&Citizen1=" & Citizen1 & "&Citizen2=" & Citizen2 & "&SubjectCode=" & SubjectCode & "&Status=" & Status & "'>"&q&"</A></li>"
            End If
        Next
    Else'블럭에 페이지수가 10개 이상이 아닐때
        For i = 1 to (totalpage mod intMyChoice) '전체페이지에서 MyChoice로 나눈 나머지페이지
            q=NowBlock*intMyChoice + i
            If(gotoPage-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='StudentDetailPlural.asp?gotoPage="&((NowBlock*intMyChoice)+i)&"&Citizen1=" & Citizen1 & "&Citizen2=" & Citizen2 & "&SubjectCode=" & SubjectCode & "&Status=" & Status & "'>"&q&"</A></li>"
            End If
        Next
    End If
End Sub  
%>
<%If Session("PluralStudentNumber") <> PluralStudentNumber Then%>
	<SCRIPT LANGUAGE="JavaScript">window.onload = function(){alert('복수지원이 존재하는 지원자 입니다.\n작업에 주의해 주세요.');}</SCRIPT>
	<%'Session("PluralStudentNumber") = PluralStudentNumber
End If%>

<FORM METHOD="GET" ACTION="StudentDetailPlural.asp" name="StudentDetailChangeSubjectForm">
	<input type="Hidden" name="FormStudentNumber">
	<input type="Hidden" name="FormDivision0">
	<input type="Hidden" name="FormSubject">
	<input type="Hidden" name="FormDivision1">
	<input type="Hidden" name="FormDivision2">
	<input type="Hidden" name="FormDivision3">
	<input type="Hidden" name="ParentURL">
</FORM>

<!-- JS -->
<script src="js/jquery.js"></script> <!-- jQuery -->
<script src="js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="js/fullcalendar.min.js"></script> <!-- Full Google Calendar - Calendar -->
<script src="js/jquery.rateit.min.js"></script> <!-- RateIt - Star rating -->
<script src="js/jquery.prettyPhoto.js"></script> <!-- prettyPhoto -->

<!-- jQuery Flot -->
<script src="js/excanvas.min.js"></script>
<script src="js/jquery.flot.js"></script>
<script src="js/jquery.flot.resize.js"></script>
<script src="js/jquery.flot.pie.js"></script>
<script src="js/jquery.flot.stack.js"></script>

<!-- jQuery Notification - Noty -->
<script src="js/jquery.noty.js"></script> <!-- jQuery Notify -->
<script src="js/themes/default.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/bottom.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/topRight.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/top.js"></script> <!-- jQuery Notify -->
<!-- jQuery Notification ends -->

<script src="js/sparklines.js"></script> <!-- Sparklines -->
<script src="js/jquery.cleditor.min.js"></script> <!-- CLEditor -->
<script src="js/bootstrap-datetimepicker.min.js"></script> <!-- Date picker -->
<script src="js/jquery.uniform.min.js"></script> <!-- jQuery Uniform -->
<script src="js/jquery.toggle.buttons.js"></script> <!-- Bootstrap Toggle -->
<script src="js/filter.js"></script> <!-- Filter for support page -->
<script src="js/custom.js"></script> <!-- Custom codes -->
<script src="js/charts.js"></script> <!-- Charts & Graphs -->

<!--inline scripts related to this page-->
<script type="text/javascript">
    //window.onload = parent.resizeFrame('PluralFrame');

    function StudentDetailChangeSubject(obj1, DialStatus, FormStudentNumber, FormDivision0, FormSubject, FormDivision1, FormDivision2, FormDivision3){
        var myform = obj1;
        if( DialStatus != "전화중" && DialStatus != "녹음중" ){
            if (confirm('다음 학과로 이동할까요?'+'\n'+FormDivision0+' '+FormSubject+' '+FormDivision1+' '+FormDivision2+' '+FormDivision3+'\n'))
            {
            myform.FormStudentNumber.value = FormStudentNumber;
            myform.FormDivision0.value = FormDivision0;
            myform.FormSubject.value		= FormSubject;
            myform.FormDivision1.value = FormDivision1;
            myform.FormDivision2.value = FormDivision2;
            myform.FormDivision3.value = FormDivision3;
            myform.ParentURL.value		= parent.document.location.href;
            myform.submit();
            }
        }else{
            alert("복수지원전형으로 이동하려면 작업취소나 결과입력을 먼저 하세요.");
        }

    }
</script>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->