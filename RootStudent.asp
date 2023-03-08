<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
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
        <h2 class="pull-left"><i class="icon-user"></i> 지원자 관리</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/RootStudent.asp" class="bread-current">지원자 관리</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">



                <!-- #include virtual = "/StudentDropDownSelect.asp" -->


                <div class="widget" style="margin-top: 0; padding-top: 0;">
					<div class="widget-head">
					  <div class="pull-left">지원자 수동입력 </div>
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
								<colgroup>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="11%"></col>
									<col width="10%"></col>
									<col width="10%"></col>
									<col width="10%"></col>
									<col width="15%"></col>
								</colgroup>
								<tbody>
									<tr class="TopInputTitle" style="display:none;">
									  <th style="text-align: center; background-color: #fafafa;">단위코드</th>
									  <th style="text-align: center; background-color: #fafafa;">수험번호</th>
									  <th style="text-align: center; background-color: #fafafa;">이름</th>
									  <th style="text-align: center; background-color: #fafafa;">석차</th>
									  <th style="text-align: center; background-color: #fafafa;">점수</th>
									  <th style="text-align: center; background-color: #fafafa;">가상계좌</th>
									  <th style="text-align: center; background-color: #fafafa;">주민1</th>
									  <th style="text-align: center; background-color: #fafafa;">주민2</th>
									  <th style="text-align: center; background-color: #fafafa;">지원자 입력</th> 
									</tr>
									<tr>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertSubjectCode" maxlength="22" placeholder="단위코드" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertStudentNumber" maxlength="20" placeholder="수험번호" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertStudentName" maxlength="20" placeholder="이름" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertRanking" maxlength="9" placeholder="석차" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertScore" maxlength="20" placeholder="점수" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertAccountNumber" maxlength="50" placeholder="가상계좌" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertCitizen1" maxlength="6" placeholder="주민1" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertCitizen2" maxlength="7" placeholder="주민2" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa; vertical-align:middle;" rowspan="3" valign="middle"><button type="button" class="btn" style="width: 90%; height:80px;" onclick="StudentInsert(document.MenuForm);">지원자 입력</button></td>
									</tr>
									<tr class="TopInputTitle" style="display:none;">
									  <th style="text-align: center; background-color: #fafafa;">전화번호1</th>
									  <th style="text-align: center; background-color: #fafafa;">전화번호2</th>
									  <th style="text-align: center; background-color: #fafafa;">전화번호3</th>
									  <th style="text-align: center; background-color: #fafafa;">전화번호4</th>
									  <th style="text-align: center; background-color: #fafafa;">전화번호5</th>
									  <th style="text-align: center; background-color: #fafafa;">기타1</th>
									  <th style="text-align: center; background-color: #fafafa;">기타2</th>
									  <th style="text-align: center; background-color: #fafafa;">기타3</th>
									</tr>
									<tr>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertTel1" maxlength="20" placeholder="전화번호1" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertTel2" maxlength="20" placeholder="전화번호2" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertTel3" maxlength="20" placeholder="전화번호3" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertTel4" maxlength="20" placeholder="전화번호4" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertTel5" maxlength="20" placeholder="전화번호5" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertETC1" maxlength="50" placeholder="기타1" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertETC2" maxlength="50" placeholder="기타2" style="width: 80%; margin: 0;"></td>
									  <td style="text-align: center; background-color: #fafafa;"><input type="text" name="InsertETC3" maxlength="50" placeholder="기타3" style="width: 80%; margin: 0;"></td>
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
'#################################################################################
'##학과 구분 조건을 활용한 SubStrSql
'#################################################################################
'Dim SubStrSql
SubStrSql = ""
If Session("FormSubject") <> "" Then
    SubStrSql =					"and Subject = '" & Session("FormSubject") & "'"
End If
If Session("FormDivision0") <> "" Then
    SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & Session("FormDivision0") & "'"
End If
If Session("FormDivision1") <> "" Then
    SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & Session("FormDivision1") & "'"
End If
If Session("FormDivision2") <> "" Then
    SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & Session("FormDivision2") & "'"
End If
If Session("FormDivision3") <> "" Then
    SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormDivision3") & "'"
End If
Dim SearchTitle, SearchString
Dim Rs1
Dim PageSize, GotoPage
Dim TotalPage,RecordCount
SearchTitle  = getParameter(Request.Form("SearchTitle"),"")
SearchString = getParameter(Request.Form("SearchString"),"")
'기본적으로 모든 지원자를 보여주도록 개선
'If Session("FormSubjectCode")<>"" and Session("FormSubject")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 Then
' ##################################################################################
' 기본 page setting values
' ##################################################################################
    PageSize = 20
    GotoPage = getintParameter( Request.Form("GotoPage"), 1)
    TotalPage   = 1
    RecordCount = 0
	'##############################
	'##지원자 리스트
	'##############################
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
	StrSql =                   "select ET.*"
    StrSql = StrSql & vbCrLf & "from StudentTable ET"
    StrSql = StrSql & vbCrLf & "join SubjectTable CCT"
    StrSql = StrSql & vbCrLf & "on ET.SubjectCode = CCT.SubjectCode"
    StrSql = StrSql & vbCrLf & "where 1=1"
    StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
    If SearchString<>"" Then
    StrSql = StrSql & vbCrLf & "and STUDENTNUMBER like '%" & SearchString & "%' OR STUDENTNAME like '%" & SearchString & "%'"
    End If
    StrSql = StrSql & vbCrLf & "order by ET.SubjectCode asc, Ranking asc, StudentNumber asc"
	'PrintSql StrSql
	Rs1.CursorLocation = 3
	Rs1.CursorType = 3
	Rs1.LockType = 3
	Rs1.Open StrSql, Dbcon
	
	If (Rs1.BOF and Rs1.EOF) Then
		recordCount = 0 
		totalpage   = 0
	Else
		recordCount = Rs1.RecordCount
		Rs1.pagesize = PageSize
		totalpage   = Rs1.PageCount
	End If

	If cint(GotoPage)>cint(TotalPage) Then GotoPage=TotalPage
'기본적으로 모든 지원자를 보여주도록 개선
'Elseif  SearchString<>"" Then
'	'##############################
'	'##지원자 검색
'	'##############################
'    PageSize = 20
'    GotoPage = getintParameter( Request.Form("GotoPage"), 1)
'    TotalPage   = 1
'    RecordCount = 0
'	Set Rs1 = Server.CreateObject("ADODB.Recordset")
'	StrSql = "select *"
'    StrSql = StrSql & vbCrLf & "from StudentTable"
'    StrSql = StrSql & vbCrLf & "where " & SearchTitle & " like '%" & SearchString & "%'"
'    StrSql = StrSql & vbCrLf & "order by SubjectCode asc, Ranking asc, StudentNumber asc"
'	'Response.Write StrSql
'	Rs1.CursorLocation = 3
'	Rs1.CursorType = 3
'	Rs1.LockType = 3
'	Rs1.Open StrSql, Dbcon
'	
'	If (Rs1.BOF and Rs1.EOF) Then
'		recordCount = 0 
'		totalpage   = 0
'	Else
'		recordCount = Rs1.RecordCount
'		Rs1.pagesize = PageSize
'		totalpage   = Rs1.PageCount
'	End If
'
'	If cint(GotoPage)>cint(TotalPage) Then GotoPage=TotalPage
'End If
%>

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">지원자 리스트: <%=FormatNumber(RecordCount, 0)%></div>
                  <div class="widget-icons pull-right">
                    
                    <button type="button" class="btn" onclick="StudentEdit(document.MenuForm);">
                        <i class="icon-ok bigger-120"></i> 적용완료
                    </button>
                    <button type="button" class="btn" onclick='StudentDelete(document.MenuForm);'>
                        <i class="icon-minus-sign bigger-120"></i> 선택삭제
                    </button>
                    <button type="button" class="btn btn-danger" onclick='TruncateTable(this.form); return false;'>
                        <i class="icon-trash bigger-120"></i> 전체삭제
                    </button>
                    <button type="button" class="btn " onclick="window.open('./StudentUploadDataBase.asp','StudentUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
                        <i class="icon-hdd bigger-120"></i> 데이터 가져오기
                    </button>
					<%If Session("MemberID")="MetisSoft" Then%>
                    <button type="button" class="btn btn-primary" onclick="window.open('./StudentUpload.asp','StudentUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
                        <i class="icon-upload-alt bigger-120"></i> 파일로 업로드 
                    </button>
					<%End If%>
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
                            <colgroup><col width="2%"></col><col width="6%"></col><col width="6%"></col><col width="6%"></col><col width="4%"></col><col width="4%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="5%"></col><col width="5%"></col><col width="4%"></col><col width="4%"></col><col width="4%"></col></colgroup>
                            <thead>
                                <tr>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;"><img src="/images/Dummy.png" width="19" height="19" border="0" onclick="checkall(document.MenuForm);" style="cursor: pointer;" title="전체선택"></th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집코드</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">수험번호</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">이름</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">석차</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">점수</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">가상계좌</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화번호1</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화번호2</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화번호3</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화번호4</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화번호5</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">주민1</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">주민2</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">기타1</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">기타2</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">기타3</th>
                                </tr>
                            </thead>
                            <%'기본적으로 모든 지원자를 보여주도록 개선
                            'if ( Session("FormSubjectCode")="" and Session("FormSubject")="" Or Session("CountTemp")<>0 ) And SearchString="" Then%><!-- 
                                <tbody>
                                    <TR><TD colspan="17" class="content" style="height: 40; text-align: center;">모집단위를 선택하세요.<BR>
                                </tbody> -->
                            <%'Else%>
                                <%If Rs1.eof then%>
                                    <tbody>
                                        <TR><TD colspan="17" class="content" style="height: 40; text-align: center;">지원자 기록이 없습니다.<BR>
                                    </tbody>
                                <%Else%>
                                <tbody>
                                    <%Dim SubjectCode,StudentNumber,StudentName,Ranking,Score,AccountNumber,Tel1,Tel2,Tel3,Tel4,Tel5,Citizen1,Citizen2,ETC1,ETC2,ETC3,InsertTime
                                    
                                    Dim RCount
                                    Dim BGColor
                                    BGColor = "#f0f0f0"
                                    RCount = Rs1.pagesize
                                    Rs1.AbsolutePage = GotoPage
                                    'do Until Rs1.EOF
                                    i=0
                                    do Until Rs1.EOF or (RCount = 0 )
                                    
                                        SubjectCode= Rs1("SubjectCode")
                                        StudentNumber= Rs1("StudentNumber")
                                        StudentName= Rs1("StudentName")
                                        Ranking= Rs1("Ranking")
                                        Score= Rs1("Score")
                                        AccountNumber= Rs1("AccountNumber")
                                        Tel1= Rs1("Tel1")
                                        Tel2= Rs1("Tel2")
                                        Tel3= Rs1("Tel3")
                                        Tel4= Rs1("Tel4")
                                        Tel5= Rs1("Tel5")
                                        Citizen1= Rs1("Citizen1")
                                        Citizen2= Rs1("Citizen2")
                                        ETC1= Rs1("ETC1")
                                        ETC2= Rs1("ETC2")
                                        ETC3= Rs1("ETC3")
                                        InsertTime= Rs1("InsertTime")
                                        i = i + 1
                                        If BGColor = "#f0f0f0" Then
                                            BGColor = "#fafafa"
                                        Else BGColor = "#fafafa"
                                            BGColor = "#f0f0f0"
                                        End If%>
                                        <tr>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px; margin-left: 0px;"><INPUT TYPE="Checkbox" NAME="Checkbox" ID="Checkbox<%=i%>" style="width: 100%; height: 16; border-left: 0px; border-right:0px; border-bottom:0px; padding-left: 0px;" value="<%=i%>"><input type="hidden" name="StudentNumberHidden" value="<%=StudentNumber%>"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="SubjectCode"  style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=SubjectCode%>" readonly></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="StudentNumber"style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=StudentNumber%>" readonly></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="StudentName"  style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=StudentName%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Ranking"      style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Ranking%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Score"        style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Score%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="AccountNumber"style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=AccountNumber%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel1"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel1%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel2"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel2%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel3"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel3%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel4"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel4%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel5"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel5%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Citizen1"     style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Citizen1%>"onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px; background-color: <%=BGColor%>; background-image: none;"><!--<INPUT TYPE="text" NAME="Citizen2"     style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Citizen2%>"onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');">-->*******</TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="ETC1"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=ETC1%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="ETC2"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=ETC2%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="ETC3"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=ETC3%>" onkeyup="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD><!-- 
                                            <td colspan="1" nowrap style="padding: 8px 0px 5px 5px; text-align: center; " ><%=SubjectCode%></td> -->
                                        </tr>
                                        <%Rs1.MoveNext
                                        RCount = RCount -1
                                    Loop
                                    Rs1.Close
                                    Set Rs1 = Nothing%>
                                </tbody>
                                <%End If%>
                            <%'기본적으로 모든 지원자를 보여주도록 개선
                            'End If%>
                        </table>
                      </div>

                    </div>
                  </div>

                    <%If totalpage > 1 Then %>
                        <div class="widget-foot" style="padding: 0;">
                            <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                                <ul>
                                <%If GotoPage>1 Then%>
                                    <li><a href="javascript: ChangePage(document.MenuForm,<%=GotoPage-1%>)">Prev</a></li>
                                <%Else%>
                                    <li><a >Prev</a></li>
                                <%End If%>
                                <%pageViewRemainFrameSrc%>
                                <%If cint(GotoPage)<cint(totalpage) Then%>
                                    <li><a href="javascript: ChangePage(document.MenuForm,<%=GotoPage+1%>)">Next</a></li>
                                <%Else%>
                                    <li><a >Next</a></li>
                                <%End If%>
                                </ul>
                            </div>
                            <div class="clearfix"></div> 
                        </div><!-- widget-foot -->
                    <%End If%>

                </div>
              </div> 
		    </FORM>
              
        <%Sub pageViewRemainFrameSrc()
            Dim intMyChoice,TotalBlock,i,NowBlock,q
            intMyChoice=10
            If totalpage > 0 then
                TotalBlock = int((totalpage-1)/intMyChoice) '전체블럭수 (블럭은 0부터 시작)
                NowBlock = int((GotoPage-1)/intMyChoice) '현재블럭수
            end if
            If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'블럭에 페이지수가 10개 이상일때
                For i = 1 to intMyChoice
                    q=NowBlock*intMyChoice + i
                    If(GotoPage-(NowBlock*intMyChoice)) = i Then
                        Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
                    Else
                        response.write "<li><a href='javascript: ChangePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            Else'블럭에 페이지수가 10개 이상이 아닐때
                For i = 1 to (totalpage mod intMyChoice) '전체페이지에서 MyChoice로 나눈 나머지페이지
                    q=NowBlock*intMyChoice + i
                    If(GotoPage-(NowBlock*intMyChoice)) = i Then
                        Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
                    Else
                        response.write "<li><a href='javascript: ChangePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            End If
        End Sub%>


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
<script type="text/javascript">
    function ChangePage(f,GotoPage){
        f.GotoPage.value=GotoPage;
        f.submit();
    }
    var nSelectFlag = 0;
    function checkall(obj){
        //var form = document.frmContentDetail;
        //var form = obj;
        var myform = obj;
        var nCheckedCnt = 0;
        for (var nIdx=0; nIdx < myform.elements.length; nIdx++){
            var objElement = myform.elements[nIdx];
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
    function EnterKeyDown(f,c){
        var e;
        if(e==null) e=window.event;
        if(e.keyCode=='13'){
            StudentEdit(f);
            return false;
        }else{
            document.getElementById(c).checked=true;
            return false;
        }
    }
    function EnterKeyDown1(f){
        var e;
        if(e==null) e=window.event;
        if(e.keyCode=='13'){
            f.submit();
            return false;
        }
    }
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }

	function StudentInsert(obj1){
		if(obj1.InsertSubjectCode.value=="" || obj1.InsertSubjectCode.value=="단위코드") {
			myModalRootClick("지원자 수동입력","단위코드를 입력해 주세요.");
			//obj1.InsertSubjectCode.focus();
			return;
		}
		if(obj1.InsertStudentNumber.value=="" || obj1.InsertStudentNumber.value=="수험번호") {
			myModalRootClick("지원자 수동입력","수험번호를 입력해 주세요.");
			//obj1.InsertStudentNumber.focus();
			return;
		}
		if(obj1.InsertStudentName.value=="" || obj1.InsertStudentName.value=="이름") {
			myModalRootClick("지원자 수동입력","이름을 입력해 주세요.");
			//obj1.InsertStudentName.focus();
			return;
		}
		if(obj1.InsertRanking.value=="" || obj1.InsertRanking.value=="석차") {
			myModalRootClick("지원자 수동입력","석차를 입력해 주세요.");
			//obj1.InsertRanking.focus();
			return;
		}
		/*
		if(obj1.InsertScore.value=="" || obj1.InsertScore.value=="점수") {
			myModalRootClick("지원자 수동입력","점수를 입력해 주세요.");
			//obj1.InsertScore.focus();
			return;
		}
		if(obj1.InsertAccountNumber.value=="" || obj1.InsertAccountNumber.value=="가상계좌") {
			myModalRootClick("지원자 수동입력","가상계좌를 입력해 주세요.");
			//obj1.InsertAccountNumber.focus();
			return;
		}
		if(obj1.InsertCitizen1.value=="") {
			myModalRootClick("지원자 수동입력","주민번호를 입력해 주세요.");
			//obj1.InsertCitizen1.focus();
			return;
		}
		if(obj1.InsertCitizen2.value=="") {
			myModalRootClick("지원자 수동입력","주민번호를 입력해 주세요.");
			//obj1.InsertCitizen2.focus();
			return;
		}
		*/
		if(obj1.InsertTel1.value=="" || obj1.InsertTel1.value=="수험번호") {
			myModalRootClick("지원자 수동입력","전화번호1을 입력해 주세요.");
			//obj1.InsertTel1.focus();
			return;
		}
		/*
		if(obj1.InsertTel2.value=="" || obj1.InsertTel2.value=="수험번호") {
			myModalRootClick("지원자 수동입력","전화번호2을 입력해 주세요.");
			//obj1.InsertTel2.focus();
			return;
		}
		if(obj1.InsertTel3.value=="") {
			//myModalRootClick("지원자 수동입력","전화번호3을 입력해 주세요.");
			//obj1.InsertTel3.focus();
			//return;
		}
		if(obj1.InsertTel4.value=="") {
			//myModalRootClick("지원자 수동입력","전화번호4을 입력해 주세요.");
			//obj1.InsertTel4.focus();
			//return;
		}
		if(obj1.InsertTel5.value=="") {
			//myModalRootClick("지원자 수동입력","전화번호5을 입력해 주세요.");
			//obj1.InsertTel5.focus();
			//return;
		}
		*/
		if(confirm("지원자를 입력합니다. 계속하시겠습니까?")==true){
			//IE 10 이하일 경우 value값과 placeholder값이 같으면 공백처리
			if(jQuery.browser.msie && jQuery.browser.version < 10){
				$("input[placeholder]").each(function(){
					if ($(this).val() == $(this).attr("placeholder")) { $(this).val(""); }
				});
			}
			obj1.action="StudentInsert.asp";
			obj1.submit();
		}else{
		   return;
		}
    }

    function StudentEdit(obj1){
        var myform = obj1;
        for(var i = 0; i<myform.elements.length; i++) {
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    //if(confirm("선택한 지원자를 수정합니다. 계속하시겠습니까?")==true){
                        myform.action="StudentEdit.asp";
                        myform.SearchTitle.value = document.MenuForm.SearchTitle.value
                        myform.SearchString.value = document.MenuForm.SearchString.value
                        //alert(document.MenuForm.SearchTitle.value)
                        //alert(document.MenuForm.SearchString.value)
                        myform.submit();
                        return;
                    //}else{
                    //    return;
                    //}
                }
            }
        }
        //alert('수정할 지원자를 선택해 주세요.')
        myModalRootClick("지원자 수정","수정할 지원자를 선택해 주세요");
    }
    function StudentDelete(obj1){
        var myform = obj1;
        var mylength = myform.elements.length;
        for(var i = 0; i<mylength; i++){
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    //if(confirm("선택한 지원자를 삭제합니다. 계속하시겠습니까?")==true){
                        myform.action="StudentDelete.asp";
                        myform.SearchTitle.value = document.MenuForm.SearchTitle.value
                        myform.SearchString.value = document.MenuForm.SearchString.value
                        //alert(document.MenuForm.SearchTitle.value)
                        //alert(document.MenuForm.SearchString.value)
                        myform.submit();
                        return;
                    //}else{
                    //    return;
                    //}
                }
            }
        }
        //alert('삭제할 지원자를 선택해 주세요.')
        myModalRootClick("지원자 삭제","삭제할 지원자를 선택해 주세요");
    }
    function TruncateTable(f){
        var question = "";
        if (f.FormDivision0){
            if (f.FormDivision0.value!="*"){
                question = question + f.FormDivision0.value +" ";
            }
        }
        if (f.FormSubject){
            if (f.FormSubject.value!="*"){
                question = question + f.FormSubject.value +" ";
            }
        }
        if (f.FormDivision1){
            if (f.FormDivision1.value!="*"){
                question = question + f.FormDivision1.value +" ";
            }
        }
        if (f.FormDivision2){
            if (f.FormDivision2.value!="*"){
                question = question + f.FormDivision2.value +" ";
            }
        }
        if (question.trim()==""){
            question = "모든 지원자를 삭제 할까요?";
        }
        else{
            question = "선택한 " + question + " 지원자만 삭제할까요?";
        }
        if (confirm(question) ){
            var url = "./process/TruncateTable.asp?table=StudentTable"
            url = url + '&FormDivision0=<%=Session("FormDivision0")%>'
            url = url + '&FormSubject=<%=Session("FormSubject")%>'
            url = url + '&FormDivision1=<%=Session("FormDivision1")%>'
            url = url + '&FormDivision2=<%=Session("FormDivision2")%>'
            url = url + '&FormDivision3=<%=Session("FormDivision3")%>'
            
			if (question=="모든 지원자를 삭제 할까요?"){
				url = "./process/TruncateTable.asp?table=StudentTable"
			}
            TruncateFrame.document.location.href=url;
        }
    }
</script>
<script type="text/javascript">
	// IE10 이하 버전에서 placeholder 사용못함, 버전 체크 후 타이틀 보여줌
	if(jQuery.browser.msie && jQuery.browser.version < 10){
		//$(".TopInputTitle").show();
	};
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