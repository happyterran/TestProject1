

        <%Dim Timer1
        Timer1=Timer()
        'if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림

        '##############################
        '##학과 종합 통계
        '##############################
        if Session("FormUsedLine")<>"" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 or ( Session("Grade")="관리자" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0) then

            'StrSql =		"exec up_SubjectStats '" & Session("FormSubjectCode") & "'"

            StrSql =		"select ResultCode, Result, ResultCount"
            StrSql = StrSql & vbCrLf & "From ResultCode D"
            StrSql = StrSql & vbCrLf & "left outer join"
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select IsNull(Result,1) as ResultIsNull, count(*) as ResultCount"
            StrSql = StrSql & vbCrLf & "	from"
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber, Result"
            StrSql = StrSql & vbCrLf & "		from RegistRecord"
            StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	) A"
            StrSql = StrSql & vbCrLf & "	inner join"
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
            StrSql = StrSql & vbCrLf & "		from RegistRecord"
            StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "		group by StudentNumber"
            StrSql = StrSql & vbCrLf & "	) B"
            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
            StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
            StrSql = StrSql & vbCrLf & "	"
            StrSql = StrSql & vbCrLf & "	right outer join "
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select StudentNumber"
            StrSql = StrSql & vbCrLf & "		from StudentTable"
            StrSql = StrSql & vbCrLf & "		where SubjectCode = '" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	) C"
            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
            'StrSql = StrSql & vbCrLf & "	where result = @FormResult"
            StrSql = StrSql & vbCrLf & "	group by Result"
            StrSql = StrSql & vbCrLf & ") E"
            StrSql = StrSql & vbCrLf & "on D.Result = E.ResultIsNull"
            StrSql = StrSql & vbCrLf & "union all "
            StrSql = StrSql & vbCrLf & "select 8, 8 as Result, Quorum as ResultCount"
            StrSql = StrSql & vbCrLf & "from SubjectTable G"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "union all"
            StrSql = StrSql & vbCrLf & "select 9, 9 as Result, Count(*) as ResultCount"
            StrSql = StrSql & vbCrLf & "from  StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "order by ResultCode"

        '	Response.Write StrSql
        '	response.end
            Dim Rs12
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            Rs12.CursorLocation = 3
            Rs12.CursorType = 3
            Rs12.LockType = 3
            Rs12.Open StrSql, Dbcon
            
        '	Dim Register, Remainder, Resource, Calling, Resign, UnDecided, NonConnect, WrongNumber, NonRegister
            Dim ResultArr(10)
            if Rs12.Recordcount > 0 then
                For I = 1 to Rs12.RecordCount
                    ResultArr(i) = GetIntParameter(Rs12("ResultCount"), 0)
                    Rs12.MoveNext		
                Next
            end if
            Rs12.close
            set Rs12 = Nothing

        '##########################################################################################
        '## 미작업(RemainCount) 추출, Session("RemainRecordCount") 추출
        '## 
        '## 미작업과 충원용 잔여(RaRoot)은 다르다.
        '## 미작업(RemainCount)						= SubjectStats.asp 에서 보여질 미작업 
        '## Session("RemainRecordCount")	= RemainFrameSrc.asp 에서 보여질 인원수
        '##########################################################################################

            Dim RemainCount

            '자원이 0보다 크다면 ( if 지원자-정원-포기-미등록-환불 > 0 then )
            if ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10) >= 0 then
                '(자원이 0 이상일 경우)
                '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(자원)-(제외)
                '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(지원자-정원-포기-미등록-환불)-(포기+미등록+환불)
                '미작업 = 정원-등록예정-미결정-미연결-등록완료
                RemainCount = ResultArr(8)-ResultArr(6)-ResultArr(4)-ResultArr(5)-ResultArr(2)
                'Session("RemainRecordCount") = 미작업+미결정+미연결
                'Session("RemainRecordCount") = (정원-등록예정-미결정-미연결-등록완료)+미결정+미연결
                'Session("RemainRecordCount") = 정원-등록예정-등록완료
                Session("RemainRecordCount") = ResultArr(8)-ResultArr(6)-ResultArr(2)
                'SP_Remain 배제용 예외처리
            else
                '(자원이 0보다 작을경우)
                '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(제외)
                '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(포기+미등록+환불)
                '미작업 = 지원자-등록예정-미결정-미연결-등록완료-포기-미등록-환불
                'Response.Write ResultArr(9)-ResultArr(6)-ResultArr(4)-ResultArr(5)-ResultArr(2)-ResultArr(3)-ResultArr(7)-ResultArr(10)
                '그러나 결국 RegistRecord = Null 인 인원이 미작업 이다 그러므로
                '미작업 = DB미작업
                RemainCount = ResultArr(1)
                'Remain = 미작업+미결정+미연결
                'Remain = (DB미작업)+미결정+미연결
                Session("RemainRecordCount") = ResultArr(1)+ResultArr(4)+ResultArr(5)
                'SP_Remain 배제용 예외처리
            end if
            'Response.Write RemainCount
            'Response.Write Session("RemainRecordCount") & ","

            '정원
            Session("Quorum") = ResultArr(8)
            '커트라인(RankingCutLine) = 정원+포기+미등록+환불
            Session("RankingCutLine") = ResultArr(8)+ResultArr(3)+ResultArr(7)+ResultArr(10)
        '	'작업결과(ResultRecordCount) = 등록예정+등록완료+포기+미등록+환불
        '	Session("ResultRecordCount")=ResultArr(6)+ResultArr(2)+ResultArr(3)+ResultArr(7)+ResultArr(10)
            'SP_Remain 배제용 예외처리

        '##############################
        '## 우선선발대상자 빼기 ranking이 0 또는 마이너스인 인원 추출&제외
        '##############################
            '순위<=0인 학생만큼 RankingCutLine을 줄인다
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            StrSql =       "select Count(*) Count from StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "and Ranking <= 0"
            'Response.Write StrSql
            Rs12.Open StrSql, Dbcon
            if Rs12.eof = false then
                Session("RankingCutLine") = Session("RankingCutLine") - Rs12("Count")
            end if
            Rs12.Close
            set Rs12 = nothing
            'Response.Write Session("RankingCutLine") & ","

        '##############################
        '## 명지전문대 2지망 문제 대안
        '##############################
            '1. 2지망 합격자는 1지망에 결과입력 없이 간다. 1지망 지원자수정에서 ETC3에 2지망 지원정보를 입력해 두고, 충원 순위가 되었을 때 Remain.asp 메모란에 표시, StudentDetail.asp 에서 얼랏 표시해서 선택권 부여로 자연히 해결
            '2. 커트라인을 벗어나는 학생의 결과를 별도로 구해서 Session("RankingCutLine") 감산 처리하고 상단에 붉은 문구와 얼랏 메세지 둘 다 띄워서 1번 사항을 무시한 입력에도 대처
            '3. SP_Remain 에서도 select top Session("RemainRecordCount") 준수해서 해당 건수만 리스트업.
            Dim Rs13, OverCount
            Set Rs13 = Server.CreateObject("ADODB.Recordset")
            StrSql =		"select *"
            StrSql = StrSql & vbCrLf & "from RegistRecord CR"
            StrSql = StrSql & vbCrLf & "inner join"
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
            StrSql = StrSql & vbCrLf & "	from RegistRecord"
            StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	group by StudentNumber"
            StrSql = StrSql & vbCrLf & ") B"
            StrSql = StrSql & vbCrLf & "on CR.StudentNumber = B.StudentNumber"
            StrSql = StrSql & vbCrLf & "and CR.IDX = B.MaxIDX"
            StrSql = StrSql & vbCrLf & "join StudentTable ET"
            StrSql = StrSql & vbCrLf & "on CR.StudentNumber = ET.StudentNumber"
            StrSql = StrSql & vbCrLf & "and ET.Ranking > '" & Session("RankingCutLine") & "'"
            StrSql = StrSql & vbCrLf & "where Result<>4 and Result<>5"
            'Response.Write StrSql
            'Response.End
            Rs13.Open StrSql, Dbcon, 1, 1
            If Not Rs13.EOF Then
                OverCount = cInt(Rs13.RecordCount)
                Session("RankingCutLine") = Session("RankingCutLine") - OverCount
            End If
            Rs13.Close
            Set Rs13 = Nothing
            'Response.Write OverCount
            'Response.Write Session("RankingCutLine") & ","
            'Response.End

        '##############################
        '## RankingCutLinePlural 추출
        '##############################
            '동순위자일괄합격 수정사항
            '랭킹컷트라인에 여러명이 있다면 (동순위자 발생 이라면)
            'Session("RankingCutLine") = Session("RankingCutLine") + 동순위자 수
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            StrSql =       "select top 1 Ranking, Count(*) Count from StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "and Ranking <= '" & Session("RankingCutLine") & "'"
            StrSql = StrSql & vbCrLf & "group by Ranking"
            StrSql = StrSql & vbCrLf & "order by Ranking desc"
            'Response.Write StrSql
            Rs12.Open StrSql, Dbcon

            Dim RankingCutLinePlural, TempRankingCutLine 
            if Rs12.eof then
                RankingCutLinePlural = 0
                TempRankingCutLine = Session("RankingCutLine")
            else
                RankingCutLinePlural = getIntParameter(Rs12("Count"),0)
                TempRankingCutLine = Rs12("Ranking")
            end if
            'Response.Write TempRankingCutLine & "<BR>"

            Rs12.Close
            set Rs12 = nothing
            'Response.Write RankingCutLinePlural
            '동순위자가 있으면 RemainRecordCount 계산 다시해야 한다, 커트라인 아래로 최종석차 + 동순위자수 - 1
            if RankingCutLinePlural > 1 then
                'Session("RemainRecordCount") = TempRankingCutLine + RankingCutLinePlural - Session("RankingCutLine") -1
                Session("RemainRecordCount") = Session("RemainRecordCount") + TempRankingCutLine + RankingCutLinePlural - Session("RankingCutLine") -1
                'SP_Remain 배제용 예외처리
                '-1을 하는 이유는 RankingCutLinePlural가 동순위자의 인원수 이므로 기존의 한명을 빼기 때문이다
                Response.Write "<h4><FONT COLOR='#FF5555'>※커트라인에 동순위자들이 존재합니다. 통계를 철저히 확인하면서 진행하세요.</FONT></h4>"
            end if
            'Response.Write RemainCount
            'Response.Write Session("RemainRecordCount") & ", "
            'Response.Write Session("RankingCutLine")
            %>





          <div class="row-fluid">
            <div class="span12">

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">전체지원자: <%=ResultArr(9)%></div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize" id="subjectStats" onclick="PositionChange()"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content" id="courseStatsWidgetContent" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%end if %>>
                <!-- <div class="widget-content" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%End If%>> -->
                  <div class="padd invoice" style="padding:0;">
                    <div class="row-fluid">

                      <div class="span12">
                        <table class="table table-striped table-hover table-bordered">
                            <colgroup><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col></colgroup>
                            <thead>
                                <tr>
                                  <th colspan="5" style="text-align: center; background-color: #d9edf7;">모집인원: <%=ResultArr(8)%></th>
                                  <th colspan="1" style="text-align: center; background-color: #FFFBC8;">자원: <%=ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10)%></th>
                                  <th colspan="3" style="text-align: center; background-color: #FFE1E1;">제외: <%=ResultArr(3)+ResultArr(7)+ResultArr(10)%></th>
                                </tr>
                                <tr>
                                  <th style="text-align: center; cursor: pointer;" >등록예정</th>
                                  <th style="text-align: center; cursor: pointer;" >미결정</th>
                                  <th style="text-align: center; cursor: pointer;">미연결</th>
                                  <th style="text-align: center; cursor: pointer;">미작업</th>
                                  <th style="text-align: center; cursor: pointer;">등록완료</th>
                                  <th colspan="1" style="text-align: center;">자원</th>
                                  <th style="text-align: center; cursor: pointer;">포기</th>
                                  <th style="text-align: center; cursor: pointer;">미등록</th>
                                  <th style="text-align: center; cursor: pointer;">환불</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(6)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(4)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(5)%></td>
                                  <td colspan="1" style="text-align: center;"><%=RemainCount%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(2)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(3)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(7)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(10)%></td>
                                </tr>
                            </tbody>
                        </table>
                      </div>

                    </div>
                  </div><!-- 
                  <div class="widget-foot">
                    <button class="btn pull-right">Send Invoice</button>
                    <div class="clearfix"></div>
                  </div> -->
                </div>
              </div>  
              
            </div>
          </div>


        <%End if%>
        <%'End if ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림%>