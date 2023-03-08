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
        <h2 class="pull-left"><i class="icon-table"></i> 모집단위 관리</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/RootSubject.asp" class="bread-current">모집단위 관리</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">




                <!-- #include virtual = "/SubjectDropDownSelect.asp" -->


                <div class="widget" style="margin-top: 0; padding-top: 0;">
					<div class="widget-head">
					  <div class="pull-left">모집단위 수동입력 </div>
					  <div class="widget-icons pull-right">
						<a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
						<a href="#" class="wclose"><i class="icon-remove"></i></a>
					  </div>  
					  <div class="clearfix"></div>
					</div>
					<div class="widget-content" id="courseStatsWidgetContent" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%end if %>>
					  <div class="padd invoice" style="padding:0;">
						<div class="row-fluid">

						  <div class="span12">
							<table class="table table-striped table-hover table-bordered" style="atable-layout: fixed;">
								<colgroup><col width="13%"></col><col width="7%"></col><col width="13%"></col><col width="15%"></col><col width="6%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="15%"></col></colgroup>
								<tbody>
									<tr>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertSubjectCode" maxlength="22" placeholder="단위코드" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertDivision0" maxlength="20" placeholder="모집시기" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertSubject" maxlength="50" placeholder="학과명" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertDivision1" maxlength="20" placeholder="구분1" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertDivision2" maxlength="20" placeholder="주야" style="width: 80%; margin: 0;"><input type="hidden" name="InsertDivision3" value=""></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertQuorumFix" maxlength="3" placeholder="입학정원" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertQuorum" maxlength="3" placeholder="모집인원" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertRegistrationFee" maxlength="9" placeholder="등록금" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><button type="button" class="btn" style="width: 90%; " onclick="SubjectInsert(document.MenuForm);">모집단위 입력</button></td>
									</tr>
								</tbody>
							</table>
						  </div>

						</div>
					  </div>
					</div>
				</div>  


                <%
                Dim Timer1
                Timer1=Timer()
                Dim FormStudentNumber
                FormStudentNumber = Request.Querystring("FormStudentNumber")
                '#################################################################################
                '##학과 구분 조건을 활용한 SubStrSql
                '#################################################################################
                Dim SubStrSql
                SubStrSql = ""
                If Session("FormSubjectSubject") <> "" Then
                    SubStrSql =					"and Subject = '" & Session("FormSubjectSubject") & "'"
                End If
                If Session("FormSubjectDivision0") <> "" Then
                    SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & Session("FormSubjectDivision0") & "'"
                End If
                If Session("FormSubjectDivision1") <> "" Then
                    SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & Session("FormSubjectDivision1") & "'"
                End If
                If Session("FormSubjectDivision2") <> "" Then
                    SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & Session("FormSubjectDivision2") & "'"
                End If
                If Session("FormSubjectDivision3") <> "" Then
                    SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormSubjectDivision3") & "'"
                End If
                '##################################################################################
                '기본 page setting values
                '##################################################################################
                Dim PageSize, GotoPage
                PageSize = 200
                GotoPage = getintParameter( Request.Querystring("GotoPage"), 1)
                Dim TotalPage,RecordCount
                TotalPage   = 1
                RecordCount = 0   

                '##############################
                '학과 기록
                '##############################
                Dim Rs1
                Set Rs1 = Server.CreateObject("ADODB.Recordset")
                Dim SelectCount
                'SelectCount = getParameter(Request.Form("SelectCount"), 50)
				Response.Write Session("SelectCount")
				If Session("SelectCount") = "" Then Session("SelectCount") = 200
				Response.Write Session("SelectCount")
                SelectCount = getParameter(Session("SelectCount"), 200)
                    
                'StrSql =          "Select top " & PageSize & " *"
                'StrSql = StrSql & vbCrLf & "from SubjectTable"
                'StrSql = StrSql & vbCrLf & "where SubjectCode >="
                'StrSql = StrSql & vbCrLf & "("
                'StrSql = StrSql & vbCrLf & "	select " & resultValue & " as Expr1"
                'StrSql = StrSql & vbCrLf & "	from"
                'StrSql = StrSql & vbCrLf & "	("
                'StrSql = StrSql & vbCrLf & "		select top " & start & " SubjectCode"
                'StrSql = StrSql & vbCrLf & "		from SubjectTable"
                'StrSql = StrSql & vbCrLf & "		order by " & sortQuery & vbCrLf
                'StrSql = StrSql & vbCrLf & "	) as DERIVEDTBL"
                'StrSql = StrSql & vbCrLf & ")"
                'StrSql = StrSql & vbCrLf & "order by SubjectCode asc"
                StrSql = "select top " & SelectCount & " * from SubjectTable where 1=1"
                StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
                'StrSql = StrSql & vbCrLf & "order by SubjectCode"                
                'StrSql = StrSql & vbCrLf & "order by substring(SubjectCode,4,2), substring(SubjectCode,7,2), substring(SubjectCode,1,2), right(SubjectCode,1)"
                'StrSql = StrSql & vbCrLf & "order by Subject, Division0, Division1"
				StrSql = StrSql & vbCrLf & "order by Subject, Division2 desc, Division0, Division1"

                'Response.Write StrSql
                'Rs1.CursorLocation = 3
                'Rs1.CursorType = 3
                'Rs1.LockType = 3
                'Rs1.Open StrSql, Dbcon
                Rs1.Open StrSql, Dbcon, 3

                '----------------------------------------------------------------------------------
                ' 전체 페이지와 전체 카운터 설정
                '----------------------------------------------------------------------------------
                If (Rs1.BOF and Rs1.EOF) Then
                    recordCount = 0 
                    totalpage   = 0
                Else
                    recordCount = Rs1.RecordCount
                    Rs1.pagesize = PageSize
                    totalpage   = Rs1.PageCount
                End If

                If cint(GotoPage)>cint(totalpage) Then GotoPage=totalpage	
                %>
                  <div class="widget" style="margin-top: 0; padding-top: 0;">
                    <div class="widget-head">
                      <div class="pull-left">모집단위 리스트 : <%=RecordCount%></div>
                      <div class="widget-icons pull-right">
                      
                        <button type="button" class="btn" onclick="SubjectEdit(document.MenuForm);">
                            <i class="icon-ok bigger-120"></i> 적용완료
                        </button>
                        <button type="button" class="btn" onclick='SubjectDelete(document.MenuForm);'>
                            <i class="icon-minus-sign bigger-120"></i> 선택삭제
                        </button>
                        <button type="button" class="btn btn-danger" onclick='TruncateTable(this.form); return false;'>
                            <i class="icon-trash bigger-120"></i> 전체삭제
                        </button>
                        <button type="button" class="btn " onclick="window.open('./SubjectUploadDataBase.asp','SubjectUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
                            <i class="icon-hdd bigger-120"></i> 데이터 가져오기
                        </button>
                        <button type="button" class="btn btn-primary" onclick="window.open('./SubjectUpload.asp','SubjectUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
                            <i class="icon-upload-alt bigger-120"></i> 파일로 업로드
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
                                <colgroup><col width="3%"></col><col width="11%"></col><col width="8%"></col><col width="10%"></col><col width="15%"></col><col width="10%"></col><col width="6%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="15%"></col></colgroup>
                              <thead>
                                <tr>
                                  <th colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;"><img src="/images/Dummy.png" width="19" height="19" border="0" onclick="checkall(document.MenuForm);" style="cursor: pointer;" title="전체선택"></th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집코드</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집시기</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">학과명</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분1</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분2</th>
                                  <!--<th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분3</th>-->
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">입학정원</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집인원</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">변동</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">등록금</th>
                                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">입력시각</th>
                                </tr>
                              </thead>
                                <%if Rs1.eof then%>
                                    <tbody>
                                    <TR><TD colspan="11" style="height: 40; text-align: center;">모집단위 기록이 없습니다.<BR>
                                    </tbody>
                                <%else%>
                              <tbody>
                                <%Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum, QuorumFix, QuorumDIffrence, QuorumDIffrenceTemp, RegistrationFee, InsertTime
                                Dim RCount
                                Dim BGColor
                                BGColor = "#f0f0f0"
                                RCount = Rs1.pagesize
                                Rs1.AbsolutePage = GotoPage
                                Dim QuorumSum, QuorumFixSum, QuorumDIffrenceSum, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp
                                Dim SubjectBefore, Division2Before
                                ShowSum = false
                                do Until Rs1.EOF or (RCount = 0 )
                                    RCount = RCount -1
                                    i = i + 1
                                    SubjectCode= Rs1("SubjectCode")
                                    'Subject= Rs1("Subject")
                                    Division0= Rs1("Division0")
                                    Division1= Rs1("Division1")
                                    'Division2= Rs1("Division2")
                                    Division3= Rs1("Division3")
                                    Quorum= getIntParameter(Rs1("Quorum"), 0)
                                    QuorumFix= getIntParameter(Rs1("QuorumFix"), 0)
                                    QuorumDiffrence=Quorum-QuorumFix
                                    QuorumDiffrenceTemp=QuorumDiffrence
                                    QuorumDiffrenceTemp=cStr(QuorumDiffrenceTemp)
                                    
                                    'QuorumDiffrence 폰트 컬러
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
                                    RegistrationFee= Rs1("RegistrationFee")
                                    InsertTime= Rs1("InsertTime")
                                    
                                    'SubjectBefore 는 MoveNext 직전의 Subject#EEEEEE !important
                                    'Division0Before 는 MoveNext 직전의 Division0B
                                    SubjectBefore = Subject
                                    Division2Before = Division2
                                    Subject	= getParameter(Rs1("Subject"), "")
                                    Division2= getParameter(Rs1("Division2"), "")

                                    '이전학과명과 현재학과명이 다르면 ShowSum = true
                                    'If SubjectBefore<>"" And (SubjectBefore <> Subject or Division2Before <> Division2) Then
                                    If SubjectBefore<>"" And (SubjectBefore <> Subject) Then
                                        ShowSum = true
                                    End If

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
                                    End If
                                    If BGColor = "#f0f0f0" Then
                                        BGColor = "#fafafa"
                                    Else BGColor = "#fafafa"
                                        BGColor = "#f0f0f0"
                                    End If%>
                                    <%If ShowSum Then%>
                                        <TR>
                                            <TD colspan="6" style="background-color: #E9E9E9; text-align: left; padding-left: 165px;">소계</TD>
                                            <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px;" ><%=QuorumFixSum%></TD>
                                            <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px;" ><%=QuorumSum%></TD>
                                            <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
                                            <TD colspan="2" style="background-color: #E9E9E9;"></TD>
                                        </TR>
                                        <%'표시 했으면 QuorumDiffrenceSum 이 0 이 맞는지 검사 
                                        'if QuorumDiffrenceSum <> 0 and (left(SubjectCode,1)<>"3" and left(SubjectCode,1)<>"4") then ShowError = true
                                        If QuorumDIffrenceSum <> 0 Then ShowError = true
                                        '그리고, 0 으로 리셋
                                        QuorumSum = 0
                                        QuorumFixSum = 0
                                        QuorumDIffrenceSum = 0
                                        ShowSum=false
                                    End If
                                    'Sum 누적
                                    QuorumSum = QuorumSum + Quorum
                                    QuorumFixSum = QuorumFixSum + QuorumFix
                                    QuorumDIffrenceSum = QuorumDIffrenceSum + QuorumDIffrence%>
                                        <tr>
                                            <input TYPE="hidden" NAME="SubjectCode" value="<%=SubjectCode%>">
                                            <input TYPE="hidden" NAME="Division0" value="<%=Division0%>">
                                            <input TYPE="hidden" NAME="Division1" value="<%=Division1%>">
                                            <input TYPE="hidden" NAME="Subject" value="<%=Subject%>">
                                            <input TYPE="hidden" NAME="Division2" value="<%=Division2%>">
                                            <input type="hidden" name="Division3" value="<%=Division3%>">
											<%'=Session("MemberID")%>
											<%'메티스와 백철훈만 정원 수정 가능
											If Lcase(Session("MemberID")) = "k777fnsl" Or Lcase(Session("MemberID")) = "metissoft" Then%>
											<%Else%>
                                            <input TYPE="hidden" NAME="QuorumFix" value="<%=QuorumFix%>">
											<%End If%>
                                            <input TYPE="hidden" NAME="RegistrationFee" value="<%=RegistrationFee%>">
                                            <input TYPE="hidden" NAME="InsertTime" value="<%=InsertTime%>">

                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;"><input type="Checkbox" name="Checkbox" ID="Checkbox<%=i%>" value="<%=i%>"><input type="hidden" name="SubjectCodeHidden" value="<%=SubjectCode%>"></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;"><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: center; padding: 0px 0px 0px 0px; margin: 0px;"><%=SubjectCode%></span></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;"><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: left; padding: 0px 0px 0px 0px; margin: 0px;"><%=Division0%></span></td>
											<td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;"><span style="background-color: <%=BGColor%>; width: 75%; height: 32px; border:0px; text-align: center; padding: 0px 10px 0px 0px; margin: 0px;"><%=Subject%></span></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: left;"><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: left; padding: 0px 0px 0px 0px; margin: 0px;"><%=Division1%></span></td>
											<td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;"><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: center; padding: 0px 0px 0px 0px; margin: 0px;"><%=Division2%></span></td>
											<%'메티스와 백철훈만 정원 수정 가능
											If Lcase(Session("MemberID")) = "k777fnsl" Or Lcase(Session("MemberID")) = "metissoft" Then%>
												<td colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 0px; text-align: right;"><INPUT TYPE="text" NAME="QuorumFix" style="background-color: <%=BGColor%>; width: 75%; height: 32px; border:0px; text-align: right; padding: 0px 10px 0px 0px; margin: 0px;" maxlength="35" value="<%=QuorumFix%>"  onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></td>
											<%Else%>
												<td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: right;"><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: right; padding: 0px 10px 0px 0px; margin: 0px;"><%=QuorumFix%></span></td>
											<%End If%>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 0px; text-align: right;"><INPUT TYPE="text" NAME="Quorum" style="background-color: <%=BGColor%>; width: 75%; height: 32px; border:0px; text-align: right; padding: 0px 10px 0px 0px; margin: 0px;" maxlength="35" value="<%=Quorum%>"  onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 0px 0px;text-align: right; font-weight:bold; color: <%=FontColor%>;background-color: #E9E9E9; text-align: right; "><%=QuorumDIffrenceTemp%></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: right;" ><span style="background-color: <%=BGColor%>; width: 75%; height: 32px; border:0px; text-align: right; padding: 0px 10px 0px 0px; margin: 0px;"><%=RegistrationFee%></span></td>
                                            <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 0px; text-align: center;" ><span style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: left; padding: 0px 0px 0px 0px; margin: 0px;"><%=Left(InsertTime,10)%><span></td>
                                        </tr>

                                    <%Rs1.MoveNext
                                Loop
                                Rs1.Close
                                Set Rs1 = Nothing
                                    
                                'QuorumDiffrence 폰트 컬러
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
                                    <TD colspan="6" style="background-color: #E9E9E9; text-align: left; padding-left: 165px;">소계</TD>
                                    <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px;" ><%=QuorumFixSum%></TD>
                                    <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px; color: <%=QuorumDiffrenceSumColor%>; " ><%=QuorumSum%></TD>
                                    <TD style="font-weight:bold; background-color: #E9E9E9; text-align: right; padding-right: 10px; color: <%=QuorumDiffrenceSumColor%>; "><%=QuorumDiffrenceSumTemp%></TD>
                                    <TD colspan="2" style="background-color: #E9E9E9;"></TD>
                                </TR>
                                <%'표시 했으면 QuorumDiffrenceSum 이 0 이 맞는지 검사 
                                If QuorumDIffrenceSum <> 0 Then ShowError = true
                                '그리고, 0 으로 리셋
                                QuorumSum = 0
                                QuorumFixSum = 0
                                QuorumDIffrenceSum = 0
                                ShowSum=false%>
                                <tr>
                                    <td colspan="11"  style="text-align: center; padding: 1px 0px 0px 10px;">
                                        <div class="span12">
                                            <!-- <div class="btn-group graphControls"> --><!-- 
                                                <button type="button" class="btn btn-primary" onclick="SubjectEdit(document.MenuForm);">모집단위 수정</button>
                                                <button type="button" class="btn btn-danger" onclick='SubjectDelete(document.MenuForm);'>모집단위 삭제</button> -->
                                            <!-- </div> -->
                                        </div>
                                    </td>
                                </tr>
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
    <input type="hidden" name="SelectCount" value="<%=Session("SelectCount")%>">
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
<script src="js/jquery.placeholders.min.js"></script> <!-- placeholders -->

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

<%If ShowError Then%>
<SCRIPT LANGUAGE="JavaScript">//window.onload = function(){alert('변동소계가 0 이 아닌 전형이 있습니다. 모집인원을 정확히 확인해 주세요.');}</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">//$(window).load(function(){$("#myModalRootLabel").text("모집단위 관리");$("#myModalRootMessage").html("변동소계가 0 이 아닌 전형이 있습니다. <br>모집인원을 정확히 확인해 주세요.");$("#myModalRootButton").click();})</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">$(window).load(function(){noty({text: '<br>변동소계가 0 이 아닌 모집단위가 있습니다. <br>모집인원을 정확히 확인해 주세요.<br>&nbsp;',layout:'top',type:'error',timeout:5000});})</SCRIPT>
<%End If%>

<script type="text/javascript">
    var nSelectFlag = 0;
    function checkall(f){
        //var form = document.frmContentDetail;
        //var form = f;
        var nCheckedCnt = 0;
        for (var nIdx=0; nIdx < f.elements.length; nIdx++){
            var objElement = f.elements[nIdx];
            if (objElement.name == "Checkbox"){
                nCheckedCnt++;
                if (nSelectFlag == 0){
                    objElement.checked = true;
                }else{
                    objElement.checked = false;
                }
            }
        }
        if (nSelectFlag == 0){
            nSelectFlag = 1;	
        }else{
            nSelectFlag = 0;	
        }
    }
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }
	function SubjectInsert(f){
        if(f.InsertSubjectCode.value=="" || f.InsertSubjectCode.value=="단위코드") {
			myModalRootClick("모집단위 수동입력","단위코드를 입력해 주세요.");
			//f.InsertSubjectCode.focus();
			return;
		}
		if(f.InsertDivision0.value=="" || f.InsertDivision0.value=="모집시기") {
			myModalRootClick("모집단위 수동입력","모집시기를 입력해 주세요.");
			//f.InsertDivision0.focus();
			return;
		}
		if(f.InsertSubject.value=="" || f.InsertSubject.value=="학과명") {
			myModalRootClick("모집단위 수동입력","학과명을 입력해 주세요.");
			//f.InsertSubject.focus();
			return;
		}
		/*
		if(f.InsertDivision1.value=="" || f.InsertDivision1.value=="구분1") {
			myModalRootClick("모집단위 수동입력","구분1을 입력해 주세요.");
			//f.InsertDivision1.focus();
			return;
		}
		if(f.InsertDivision2.value=="" || f.InsertDivision2.value=="주야") {
			myModalRootClick("모집단위 수동입력","주야를 입력해 주세요.");
			//f.InsertDivision2.focus();
			return;
		}

		if(f.InsertQuorumFix.value=="" || f.InsertQuorumFix.value=="입학정원") {
			myModalRootClick("모집단위 수동입력","입학정원을 입력해 주세요.");
			//f.InsertQuorumFix.focus();
			return;
		}
		if(f.InsertQuorum.value=="" || f.InsertQuorum.value=="모집인원") {
			myModalRootClick("모집단위 수동입력","모집인원을 입력해 주세요.");
			//f.InsertQuorum.focus();
			return;
		}
		if(f.InsertRegistrationFee.value=="" || f.InsertRegistrationFee.value=="등록금") {
			myModalRootClick("모집단위 수동입력","등록금을 입력해 주세요.");
			//f.InsertRegistrationFee.focus();
			return;
		}
		*/
		if(confirm("모집단위를 입력합니다. 계속하시겠습니까?")==true){
			//IE 10 이하일 경우 value값과 placeholder값이 같으면 공백처리
			if(jQuery.browser.msie && jQuery.browser.version < 10){
				$("input[placeholder]").each(function(){
					if ($(this).val() == $(this).attr("placeholder")) { $(this).val(""); }
				});
			}
			f.action="SubjectInsert.asp";
			f.submit();
		}else{
		   return;
		}
    }
    function SubjectEdit(f){
        var mylength = f.elements.length;
        for(var i = 0; i<mylength; i++){
            var objElement = f.elements[i];
            if (objElement.name == "Checkbox"){
                if(f.elements[i].checked){
                    //if(confirm("선택한 모집단위를 수정합니다. 계속하시겠습니까?")==true){
                        f.action="SubjectEdit.asp";
                        f.submit();
                        return;
                    //}else{
                    //   return;
                    //}
                }
            }
        }
        //alert('수정할 모집단위를 선택해 주세요.')
        myModalRootClick("모집단위 수정","수정할 모집단위를 선택해 주세요");
    }
    function SubjectDelete(f){
        for(var i = 0; i<f.elements.length; i++){
            var objElement = f.elements[i];
            if (objElement.name == "Checkbox"){
                if(f.elements[i].checked){
                    //if(confirm("선택한 모집단위를 삭제합니다. 계속하시겠습니까?")==true){
                        f.action="SubjectDelete.asp";
                        f.submit();
                        return;
                    //}else{
                    //    return;
                    //}
                }
            }
        }
        //alert('삭제할 모집단위를 선택해 주세요.')
        myModalRootClick("모집단위 삭제","삭제할 모집단위를 선택해 주세요");
    }
    function TruncateTable(f){
        var question = "";
        if (f.FormSubjectDivision0.value!=""){
            question = question + f.FormSubjectDivision0.value +" ";
        }
        if (f.FormSubjectSubject.value!=""){
            question = question + f.FormSubjectSubject.value +" ";
        }
        if (f.FormSubjectDivision1.value!=""){
            question = question + f.FormSubjectDivision1.value +" ";
        }
        if (f.FormSubjectDivision2.value!=""){
            question = question + f.FormSubjectDivision2.value +" ";
        }
        if (question==""){
            question = "모든 모집단위를 삭제 할까요?";
        }
        else{
            question = "선택한 " + question + " 모집단위만 삭제할까요?";
        }
        if (confirm(question) ){
            var url = "./process/TruncateTable.asp?table=SubjectTable"
            url = url + '&FormDivision0=<%=Session("FormSubjectDivision0")%>'
            url = url + '&FormSubject=<%=Session("FormSubjectSubject")%>'
            url = url + '&FormDivision1=<%=Session("FormSubjectDivision1")%>'
            url = url + '&FormDivision2=<%=Session("FormSubjectDivision2")%>'
            url = url + '&FormDivision3=<%=Session("FormSubjectDivision3")%>'
            TruncateFrame.document.location.href=url;
        }
    }

</script>

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
