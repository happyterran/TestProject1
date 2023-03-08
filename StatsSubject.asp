<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck_Admin.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;">

<!-- GNB starts -->
	<!-- #include virtual = "/Include/GNB.asp" -->
<!-- GNB ends -->

<!-- Header starts -->
	<!-- include virtual = "/Include/Header.asp" -->
<!-- Header ends -->

<!-- Main content starts -->

<div class="content">

  	<!-- Sidebar -->
	    <!-- #include virtual = "/Include/Sidebar.asp" -->
  	<!-- Sidebar ends -->

  	<!-- Main bar -->
  	<div class="mainbar">

      <!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left"><i class="icon-list"></i> 종합통계</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/StatsSubject.asp" class="bread-current">종합통계</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

		<!-- 190118 Select부분 StatsSubjectDropDownSelect.asp 페이지로 분리 -->
	    <!-- #include virtual = "/StatsSubjectDropDownSelect.asp" -->
                <%
                Dim Timer1
                Timer1=Timer()

				Dim DegreeCheck,Rs1

				' 카운터 변수
				Dim SubjectCode, Division0, Division1, Subject, Division2, Division3, QuorumFix, Quorum, QuorumDIffrence, StudentCount
				DIm	RegistPlanCount, UndecidedCount, NonConnectedCount, RegistCount, AbandonCount, NonRegistCount, RefundCount, ResourceCount, RemainCount
				
				' 소계가 나오는 조건 
				Dim SubjectCount, SubjectCountNumber

				' 소계 변수
				DIm	SubTotStudentCount, SubTotQuorum, SubTotQuorumFix, SubTotQuorumDIffrence, SubTotRegistPlanCount, SubTotUndecidedCount
				DIm	SubTotNonConnectedCount, SubTotRemainCount, SubTotRegistCount, SubTotResourceCount, SubTotAbandonCount, SubTotNonRegistCount, SubTotRefundCount, SubTotResourceCountMinus

				' 미작업 시 맨 아래 표시되는 항목 tr를 구분하기 위한 변수
				Dim RecordCountNumber

				' 변동을 구분하기 위한 변수
				Dim QuorumDIffrenceTemp

				' 총계 변수
				Dim totStudentCountSum, totQuorumSum, totQuorumFixSum, totQuorumDIffrenceSum, totRegistPlanCountSum, totUndecidedCountSum, totNonConnectedCountSum
				Dim totRemainCountSum, totRegistCountSum, totResourceCountSum, totResourceCountSumMinus, totAbandonCountSum, totNonRegistCountSum, totRefundCountSum
				
				' 컬러 변수
				Dim BGColor, ResourceCountColor, FontColor, totFontColor, totFontColorSum
				BGColor="#f0f0f0"

				'차수선택이 없을시 기본으로 255 적용
				DegreeCheck = Session("FormStatsDegree")
				If DegreeCheck = "" Then DegreeCheck = "255"
                Set Rs1 = Server.CreateObject("ADODB.Recordset")
				
				'#################################################################################
				'## 190131 기존 쿼리를 up_StatsSubject 프로시저로 통일
				'## up_StatsSubject 프로시저를 이용할시 
				'## 1.StatsSubjectCount_View 쿼리.sql
				'## 2.up_StatsSubject 쿼리.sql
				'## 두개 가져다가 실행
				'## DropDownSelect를 따로 분리했기 때문에
				'## /StatsSubjectDropDownSelect.asp도 가져다 저장
				'##
				'##
				'## 프로시저 학과표시 값
				'## 전체학과      CheckCount : 1
				'## 미작업학과    CheckCount : 2
				'## 자원부족학과  CheckCount : 3
				'#################################################################################

				Dim CheckCount,CheckResourceCount
				If SelectCount = "" Or SelectCount = "전체" Then 
					   CheckCount = "1"
				Elseif SelectCount = "미작업" Then
					   CheckCount = "2"
				Elseif SelectCount = "자원부족" Then
					   CheckCount = "3"
				End If
				StrSql =  "exec dbo.up_StatsSubject '" & DegreeCheck & "','" & Session("FormStatsSubject") & "','" & Session("FormStatsDivision0") & "','" & Session("FormStatsDivision1") & "','" & Session("FormStatsDivision2") & "','" & Session("FormStatsDivision3") & "'," & CheckCount & ""
                'PrintSql StrSql
                'Response.End
                Rs1.CursorLocation = 3
                Rs1.CursorType = 3
                Rs1.LockType = 3
                Rs1.Open StrSql, Dbcon%>

                  <div class="widget" style="margin-top: 0; padding-top: 0;">
                    <div class="widget-head">
                      <div class="pull-left">모집단위 리스트 : <%=Rs1.RecordCount%></div>
                      <div class="widget-icons pull-right">
                      
                        <button type="button" class="btn btn-success" onclick="document.location.href='StatsSubjectFileDownloadExcel.asp';">
                            <i class="icon-save bigger-120"></i> 파일저장
                        </button>
                        &nbsp; &nbsp; 
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd invoice" style="padding: 0;">
                        <div class="row-fluid">

                          <div class="span12">
                            <table class="table table-striped table-hover table-bordered" style="atable-layout: fixed;">
                                <colgroup>
									<col width="6%"></col>
									<col width="5%"></col>
									<col width="11%"></col>
									<col width="6%"></col>
									<col width="4%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
								</colgroup>
                              <thead>
                                <tr>
									<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">모집코드</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">모집시기</td>
									<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">학과명</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분1</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분2</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분3</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">지원자</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">정원</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">모집</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">변동</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">등록예정</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미결정</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미연결</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미작업</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">등록완료</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">자원</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">포기</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미등록</td>
                                    <td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">환불</td>
                                </tr>
                              </thead>
                                <%if Rs1.eof then%>
                                    <tbody>
                                    <TR><TD colspan="18" style="height: 40; text-align: center;">모집단위 기록이 없습니다.<BR>
                                    </tbody>
                                <%else%>
                              <tbody>
								<!--190118 하단에 있는 총합을 jquery로 최상단으로 올리기 위한 비어있는 tr-->
									<tr id="TotalSum"></tr>
								<%
 
							do Until Rs1.EOF
								SubjectCode = getParameter(  Rs1("SubjectCode"),  "&nbsp;") '학과코드
								Division0 = getParameter(  Rs1("Division0"),  "&nbsp;") '모집시기
								Division1 = getParameter(  Rs1("Division1"),  "&nbsp;") '구분1
								Subject = getParameter(  Rs1("Subject"),  "&nbsp;") '학과명
								Division2 = getParameter(  Rs1("Division2"),  "&nbsp;") '구분2
								Division3 = getParameter(  Rs1("Division3"),  "&nbsp;") '구분3
								QuorumFix = getIntParameter(  Rs1("QuorumFix") , 0) '정원
								Quorum = getIntParameter(  Rs1("Quorum") , 0) '모집
								QuorumDIffrence = getIntParameter(  Rs1("QuorumDIffrence") , 0) '변동
								SubjectCount = getIntParameter( Rs1("SubjectCount") , 0) '소계구분을 위한 학과 갯수
								StudentCount = Rs1("StudentCount") '지원자
								RegistPlanCount = Rs1("RegistPlanCount") '등록예정
								UndecidedCount = Rs1("UndecidedCount") '미결정
								NonConnectedCount = Rs1("NonConnectedCount") '미연결
								RegistCount = Rs1("RegistCount") '등록완료
								AbandonCount = Rs1("AbandonCount") '포기
								NonRegistCount = Rs1("NonRegistCount") '미등록
								RefundCount = Rs1("RefundCount") '환불
								ResourceCount = Rs1("ResourceCount") '자원
								RemainCount = Rs1("RemainCount") '미작업

								'배경 컬러								
								If BGColor = "#fafafa" Then 
									BGColor="#f0f0f0"
								ElseIf BGColor="#f0f0f0" Then
									BGColor="#fafafa"
								End If

								'변동 카운터 폰트 컬러
                                If QuorumDIffrence>0 Then 
									FontColor="#0000FF"
                                ElseIf QuorumDIffrence=0 Then
									FontColor="#000000"
                                ElseIf QuorumDIffrence<0 Then
									FontColor="#FF0000"
                                End If

								'변동 소계 폰트 컬러
								If SubTotQuorumDIffrence>0 Then 
									totFontColor="#0000FF"
                                ElseIf SubTotQuorumDIffrence=0 Then
									totFontColor="#000000"
                                ElseIf SubTotQuorumDIffrence<0 Then
									totFontColor="#FF0000"
                                End If

                                '자원 폰트 컬러
								ResourceCountColor="#000000"
                                If ResourceCount<0 Then
                                    ResourceCountColor="#FF0000"
                                End If

								SubTotResourceCountMinus = 0

								'통계 출력
							%>
								<TR>
									<TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=SubjectCode%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Division0%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Subject%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 0px; text-align: left;"><INPUT TYPE="text" NAME="SubjectCode" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division1%>"></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Division2%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Division3%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-left: #AAA 2px solid; border-right: #AAA 2px solid;" ><%=FormatNumber(StudentCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=FormatNumber(QuorumFix,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=FormatNumber(Quorum,0)%></TD>
                                    <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; font-weight:bold; color: <%=FontColor%>;"><%=FormatNumber(QuorumDIffrence,0)%></td>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-left: #AAA 2px solid;" ><%=FormatNumber(RegistPlanCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=FormatNumber(UndecidedCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=FormatNumber(NonConnectedCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; background-color: #E1F2FF;" ><%=FormatNumber(RemainCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=FormatNumber(RegistCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid; border-right: #AAA 2px solid #000000; color: <%=ResourceCountColor%>"><%=FormatNumber(ResourceCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=FormatNumber(AbandonCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=FormatNumber(NonRegistCount,0)%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=FormatNumber(RefundCount,0)%></TD>
                                </TR>

<%
								'190118 소계 구분을 위한 학과 갯수와 비교할 학과 별 루프 횟수
								SubjectCountNumber = SubjectCountNumber +1
								
								'190118 미작업 시 맨 아래 표시되는 항목 tr를 구분하기 위해 RecordCount와 비교할 전체 루프 횟수
								If SelectCount="미작업" Then
									RecordCountNumber = RecordCountNumber +1
								End If

								'소계합산
								SubTotStudentCount = SubTotStudentCount + StudentCount '지원자 소계
								SubTotQuorumFix = SubTotQuorumFix + QuorumFix '정원 소계
								SubTotQuorum = SubTotQuorum + Quorum '모집 소계
								SubTotQuorumDIffrence = SubTotQuorumDIffrence + QuorumDIffrence '변동 소계
								'If SubTotQuorumDIffrence <> 0 Then QuorumDIffrenceTemp = TRUE '변동이 0이 아닐 때를 구분하기 위한 변수
								SubTotRegistPlanCount = SubTotRegistPlanCount + RegistPlanCount '등록예정 소계
								SubTotUndecidedCount = SubTotUndecidedCount + UndecidedCount '미결정 소계
								SubTotNonConnectedCount = SubTotNonConnectedCount + NonConnectedCount '미연결 소계
								If RemainCount > 0 Then SubTotRemainCount = SubTotRemainCount + RemainCount '미작업 소계
								SubTotRegistCount = SubTotRegistCount + RegistCount '등록완료 소계
								If ResourceCount >= 0 Then
								SubTotResourceCount = SubTotResourceCount + ResourceCount '자원 소계 플러스
								Else
									SubTotResourceCountMinus = SubTotResourceCountMinus+ResourceCount '자원 소계 마이너스
								End If
								If SubTotResourceCountMinus <> "" Then SubTotResourceCount = SubTotResourceCount + SubTotResourceCountMinus '자원 소계(플러스+마이너스)
								SubTotAbandonCount = SubTotAbandonCount + AbandonCount '포기 소계
								SubTotNonRegistCount = SubTotNonRegistCount + NonRegistCount '미등록 소계
								SubTotRefundCount = SubTotRefundCount + RefundCount '환불 소계

								'190118 동일 학과의 모든 레코드가 출력되면 계산된 소계를 출력한다.
								'전체와 미작업의 경우에만 소계를 출력한다.
								If SubjectCount = SubjectCountNumber Then
									If (SelectCount="" Or SelectCount="전체" Or SelectCount="미작업") Then
								'배경 컬러								
								If BGColor = "#fafafa" Then 
									BGColor="#f0f0f0"
								ElseIf BGColor="#f0f0f0" Then
									BGColor="#fafafa"
								End If%>
										<TR>
											<TD colspan="6" style="background-color: <%=BGColor%>; text-align: left; padding-left: 165px;">소계</TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; font-weight:bold; border-left: #AAA 2px solid; border-right: #AAA 2px solid;" ><%=FormatNumber(SubTotStudentCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=FormatNumber(SubTotQuorumFix,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=FormatNumber(SubTotQuorum,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; font-weight:bold; color: <%=totFontColor%>"><%=FormatNumber(SubTotQuorumDIffrence,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; "><%=FormatNumber(SubTotRegistPlanCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; "><%=FormatNumber(SubTotUndecidedCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; "><%=FormatNumber(SubTotNonConnectedCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; background-color: #72D1FF; "><%=FormatNumber(SubTotRemainCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=FormatNumber(SubTotRegistCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=FormatNumber(SubTotResourceCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; "><%=FormatNumber(SubTotAbandonCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; "><%=FormatNumber(SubTotNonRegistCount,0)%></TD>
											<TD colspan="1" style="background-color: <%=BGColor%>; text-align: right; padding-right: 10px; "><%=FormatNumber(SubTotRefundCount,0)%></TD>
										</TR>
										<%'미작업의 경우 최하단에는 항목 출력을 하지 않는다. 미작업은 총합을 사용하지 않기 때문에.
										  '미작업도 총합을 사용하는 경우에는 해당 조건을 가리면 된다.
										If SelectCount <> "자원부족" And RecordCountNumber <> Rs1.RecordCount Then%>
										<tr>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">모집코드</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">모집시기</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">학과명</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분1</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분2</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">구분3</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">지원자</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">정원</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">모집</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">변동</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">등록예정</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미결정</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미연결</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미작업</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">등록완료</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">자원</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">포기</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">미등록</td>
											<td colspan="1" style="background-color: #E0E0E0; padding: 7px 0px 6px 0px; text-align: center;">환불</td>
										</tr>
										<%End iF%>
										<%
										If SubTotQuorumDIffrence <> 0 Then QuorumDIffrenceTemp = TRUE '변동이 0이 아닐 때를 구분하기 위한 변수
										'같은 학과 기준 루프 횟수 초기화
										SubjectCountNumber = 0

										'소계 초기화
										SubTotStudentCount = 0
										SubTotQuorumFix = 0
										SubTotQuorum = 0
										SubTotQuorumDIffrence = 0
										SubTotRegistPlanCount = 0
										SubTotUndecidedCount = 0
										SubTotNonConnectedCount = 0
										SubTotRemainCount = 0
										SubTotRegistCount = 0
										SubTotResourceCount = 0
										SubTotAbandonCount = 0
										SubTotNonRegistCount = 0
										SubTotRefundCount = 0

										'배경 컬러 초기화
										BGColor = "#f0f0f0"
									End If
								End If
								
                                '총계합산
								totStudentCountSum = totStudentCountSum + StudentCount '지원자 총계
								totQuorumSum = totQuorumSum + Quorum '모집 총계
								totQuorumFixSum = totQuorumFixSum + QuorumFix '정원 총계
								totQuorumDIffrenceSum = totQuorumDIffrenceSum + QuorumDIffrence '변동 총계
								totRegistPlanCountSum = totRegistPlanCountSum + RegistPlanCount '등록예정 총계
								totUndecidedCountSum = totUndecidedCountSum + UndecidedCount '미결정 총계
								totNonConnectedCountSum = totNonConnectedCountSum + NonConnectedCount '미연결 총계
								totRemainCountSum = totRemainCountSum + RemainCount '미작업 총계
								totRegistCountSum = totRegistCountSum + RegistCount '등록완료 총계
								totAbandonCountSum = totAbandonCountSum + AbandonCount '포기 총계
								totNonRegistCountSum = totNonRegistCountSum + NonRegistCount '미등록 총계
								totRefundCountSum = totRefundCountSum + RefundCount '환불 총계
								'총계의 경우 플러스와 마이너스를 합치지 않고, 따로 표시하여 준다.
								If ResourceCount >= 0 Then
									totResourceCountSum = totResourceCountSum + ResourceCount '자원 총계 플러스
								Else
									totResourceCountSumMinus = totResourceCountSumMinus + ResourceCount '자원총계 마이너스
                                End If
                              
								%>
                                <%Rs1.MoveNext
                            Loop
                            Rs1.Close
                            Set Rs1 = Nothing
							%>
 
                                <!-- 190118 총합 전체에만 출력한다. -->
                                <%								
								'변동 총합 폰트 컬러
								If totQuorumDIffrenceSum>0 Then 
									totFontColorSum="#0000FF"
                                ElseIf totQuorumDIffrenceSum=0 Then
									totFontColorSum="#000000"
                                ElseIf totQuorumDIffrenceSum<0 Then
									totFontColorSum="#FF0000"
                                End If
								%>
								<TR class="LastTr">
                                    <TD colspan="6" style="background-color: #FFFFFF; text-align: left; padding-left: 165px;"><B>총합</B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; border-right: #AAA 2px solid;"><B><%=FormatNumber(totStudentCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=FormatNumber(totQuorumFixSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid; color: <%=totFontColorSum%>; "><B><%=FormatNumber(totQuorumSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; color: <%=totFontColorSum%>; "><B><%=FormatNumber(totQuorumDIffrenceSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid"><B><%=FormatNumber(totRegistPlanCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=FormatNumber(totUndecidedCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=FormatNumber(totNonConnectedCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; background-color: #72D1FF;"><B><%=FormatNumber(totRemainCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=FormatNumber(totRegistCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=FormatNumber(totResourceCountSum,0)%><br><font color="red"><%=FormatNumber(totResourceCountSumMinus,0)%></font></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=FormatNumber(totAbandonCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=FormatNumber(totNonRegistCountSum,0)%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=FormatNumber(totRefundCountSum,0)%></B></TD>
                                </TR>
                              </tbody>
                                <%End If%>
                            </table>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </FORM>

<!-- myModalRoot -->
<div id="myModalRoot" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalRootLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <a href="#myModalRoot" id="myModalRootButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
        <h3 id="myModalRootLabel">경고창 예시입니다.</h3>
        <!-- myModalRootButton -->
    </div>
    <div class="modal-body">
        <p id="myModalRootMessage">이곳에 문구가 표시됩니다.</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
</div>
<!-- TruncateFrame -->
<div class="row-fluid">
    <div class="span12" id="FrameDiv">
        <iframe name="TruncateFrame" src="" width="100%" height="0" scrolling="no" frameborder="0" marginwidth="0" marginheight="0"></iframe>
    </div>
</div>
<!-- MessageForm -->
<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MessageForm" testtarget="Root">
    <input type="hidden" name="MessageType" value="">
    <input type="hidden" name="Message"     value="">
</FORM>
		    </div>
          </div>
		</div>
        </div>
		<!-- Matter ends -->
    </div>
   <!-- Mainbar ends -->	    	
   <div class="clearfix"></div>
</div>
<!-- Content ends -->

<!-- Footer starts -->
<footer>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
            <!-- Copyright info -->
            <p class="copy">Copyright &copy; 2013 | <a href="#">MetisSoft, Inc.</a> </p>
      </div>
    </div>
  </div>
</footer> 	

<!-- Footer ends -->

<!-- Scroll to top -->
<span class="totop"><a href="#"><i class="icon-chevron-up"></i></a></span> 

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

<!-- 변동소계가 0이 아닌 학과가 있을 때 에러메시지를 출력한다.-->
<% If QuorumDIffrenceTemp <> 0 Then%>
<SCRIPT LANGUAGE="JavaScript">
	$(window).load(function(){noty({text: '변동소계가 0 이 아닌 모집단위가 있습니다. <br>모집인원을 정확히 확인해 주세요.',layout:'top',type:'error',timeout:5000});})
</SCRIPT>
<%End If%>

<!--190118 아래에 출력한 총계를 최상단에 append한다.-->
<SCRIPT type="text/javascript"> 
var cloneEle = $(".LastTr td").clone(); //선택한 요소를 복사.
$("#TotalSum").append(cloneEle);

</SCRIPT>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<!-- 결과 적용 Notification -->
<%If Request.Form("Message")<>"" Then
    Dim MessageType, Message
    MessageType=getParameter(Request.Form("MessageType"),"success")
    Message    =getParameter(Request.Form("Message"),"")%>
    <script language='javascript'>
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:5000});
    </script>
<%End If%>

