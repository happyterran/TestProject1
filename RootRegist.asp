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
        <h2 class="pull-left"><i class="icon-file-alt"></i> 결과 관리</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/RootRegist.asp" class="bread-current">결과 관리</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">



                <!-- #include virtual = "/RegistDropDownSelect.asp" -->





<%
Dim Timer1
Timer1=Timer()
Dim SearchTitle, SearchString
Dim Rs1
Dim PageSize, GotoPage
Dim TotalPage,RecordCount
'SearchTitle  = getParameter(Request.Form("SearchTitle"),"")
SearchString = getParameter(Request.Form("SearchString"),"")
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
If SearchString="" then
' ##################################################################################
' 기본 page setting values
' ##################################################################################
    PageSize = 20
    GotoPage = getintParameter( Request.Form("GotoPage"), 1)
    TotalPage   = 1
    RecordCount = 0
	'##############################
	'##등록결과 리스트
	'##############################
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
	StrSql =                   "select RR.*"
    StrSql = StrSql & vbCrLf & "from RegistRecord RR"
    StrSql = StrSql & vbCrLf & "join SubjectTable ST"
    StrSql = StrSql & vbCrLf & "on RR.SubjectCode=ST.SubjectCode"
    StrSql = StrSql & vbCrLf & "where 1=1"
    StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
    If SearchString<>"" Then
    StrSql = StrSql & vbCrLf & "and StudentNumber like '%" & SearchString & "%'"
    End If
    StrSql = StrSql & vbCrLf & "order by RR.IDX desc"
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
Elseif  SearchString<>"" Then
	'##############################
	'##등록결과 검색
	'##############################
    PageSize = 20
    GotoPage = getintParameter( Request.Form("GotoPage"), 1)
    TotalPage   = 1
    RecordCount = 0
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
	StrSql =                   "select RR.*"
    StrSql = StrSql & vbCrLf & "from RegistRecord RR"
    StrSql = StrSql & vbCrLf & "join SubjectTable ST"
    StrSql = StrSql & vbCrLf & "on RR.SubjectCode=ST.SubjectCode"
    StrSql = StrSql & vbCrLf & "where 1=1"
    StrSql = StrSql & vbCrLf & "and STUDENTNUMBER IN (SELECT STUDENTNUMBER FROM STUDENTTABLE WHERE StudentNumber like '%" & SearchString & "%' OR StudentName like '%" & SearchString & "%')"
    StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
    StrSql = StrSql & vbCrLf & "order by RR.IDX desc"
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
End If
%>

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">등록결과 리스트: <%=FormatNumber(RecordCount, 0)%></div>
                  <div class="widget-icons pull-right">
                    
                    <button type="button" class="btn" onclick="RegistEdit(this.form);">
                        <i class="icon-ok bigger-120"></i> 적용완료
                    </button>
                    <button type="button" class="btn" onclick='RegistDelete(this.form);'>
                        <i class="icon-minus-sign bigger-120"></i> 선택삭제
                    </button>
                    <button type="button" class="btn btn-danger" onclick='TruncateTable(this.form); return false;'>
                        <i class="icon-trash bigger-120"></i> 전체삭제
                    </button><!-- 
                    <button type="button" class="btn " onclick="window.open('./RegistUploadDataBase.asp','RegistUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
                    <i class="icon-hdd bigger-120"></i> 데이터 가져오기
                    </button> -->
					<!--
                    <button type="button" class="btn btn-warning" onclick="window.open('./RegistBWCUploadDatabase.asp','RegistUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=635'); return false;">
                    <i class="icon-share bigger-120"></i> 데이터 내보내기
                    </button>
					-->
                    
					<button type="button" class="btn btn-primary" onclick="window.open('./RegistUpload.asp','RegistUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=665'); return false;">
                    <i class="icon-upload-alt bigger-120"></i> 파일로 업로드 </button>
					
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
                            <colgroup><col width="2%"></col><col width="9%"></col><col width="10%"></col><col width="4%"></col><col width="11%"></col><col width="4%"></col><col width="7%"></col><col width="7%"></col><col width="7%"></col><col width="6%"></col><col width="10%"></col><col width="7%"></col><col width=""></col></colgroup>
                            <thead>
                                <tr>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;"><img src="/images/Dummy.png" width="19" height="19" border="0" onclick="checkall(document.MenuForm);" style="cursor: pointer;" title="전체선택"></th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집코드</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">수험번호</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">차수</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">라인</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">상담원</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">녹음</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">결과</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">수신</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">메모</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">복수지원</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">입력시각</th>
                                </tr>
                            </thead>
                            <%'if ( Session("FormSubjectCode")="" and Session("FormSubject")="" Or Session("CountTemp")<>0 ) And SearchString="" Then%><!-- 
                                <tbody>
                                    <TR><TD colspan="17" class="content" style="height: 40; text-align: center;">모집단위를 선택하세요.<BR>
                                </tbody> -->
                            <%'Else%>
                                <%If Rs1.eof then%>
                                    <tbody>
                                        <TR><TD colspan="13" class="content" style="height: 40; text-align: center;">등록결과 기록이 없습니다.<BR>
                                    </tbody>
                                <%Else%>
                                <tbody>
                                    <%Dim IDX, StudentNumber, SubjectCode, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo, PluralStudentNumber, InsertTime
                                    
                                    Dim RCount
                                    Dim BGColor
                                    BGColor = "#f0f0f0"
                                    RCount = Rs1.pagesize
                                    Rs1.AbsolutePage = GotoPage
                                    'do Until Rs1.EOF
                                    i=0
                                    do Until Rs1.EOF or (RCount = 0 )
                                    
                                        IDX                 = getParameter(Rs1("IDX"),"")
                                        SubjectCode         = getParameter(Rs1("SubjectCode"),"")
										StudentNumber       = getParameter(Rs1("StudentNumber"),"")
                                        Degree              = GetIntParameter( Rs1("Degree"),0)
                                        Tel                 = getParameter(Rs1("Tel"),"")
                                        UsedLine            = GetIntParameter( Rs1("UsedLine"),0)
                                        MemberID            = getParameter(Rs1("MemberID"),"")
                                        SaveFile            = getParameter(Rs1("SaveFile"),"")
                                        If SaveFile<>"" Then SaveFile = SaveFile & ".wav"
                                        Result              = getIntParameter(Rs1("Result"),1)
                                        Result              = CastResult(Result)
                                        Receiver            = GetIntParameter( Rs1("Receiver"),1)
                                        Receiver            = CastReceiver(Receiver)
                                        Memo                = getParameter(Rs1("Memo"),"")
                                        PluralStudentNumber = getParameter(Rs1("PluralStudentNumber"),"")
                                        InsertTime          = getParameter(Rs1("InsertTime"),"")
                                        'InsertTime          = CastDateTime(InsertTime)
                                        i = i + 1
                                        If BGColor = "#f0f0f0" Then
                                            BGColor = "#fafafa"
                                        Else BGColor = "#fafafa"
                                            BGColor = "#f0f0f0"
                                        End If%>
                                        <tr>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="Checkbox" NAME="Checkbox" ID="Checkbox<%=i%>" style="width: 100%; height: 16; border-left: 0px; border-right:0px; border-bottom:0px; padding-left: 0px;" value="<%=i%>"><input type="hidden" name="IDXHidden" value="<%=IDX%>"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="SubjectCode"  style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=SubjectCode%>" readonly></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="StudentNumber"style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=StudentNumber%>" readonly></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Degree"       style="width: 100%; height: 28px; border:0px; text-align: center; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Degree%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Tel"          style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Tel%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="UsedLine"     style="width: 100%; height: 28px; border:0px; text-align: center; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=UsedLine%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="MemberID"     style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=MemberID%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
											<td colspan="1" style="padding: 0px; text-align: center; line-height: 26px; background-color: <%=BGColor%>; background-image: none;"><a href="/Record/<%=StudentNumber%><%=SaveFile%>" target="StudentDetailSMSSend" title="재생"><%=SaveFile%></a></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Result"       style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Result%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Receiver"     style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Receiver%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="Memo"         style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=Memo%>" onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="PluralStudentNumber"style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=PluralStudentNumber%>"onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');"></TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;"><INPUT TYPE="text" NAME="InsertTime"     style="width: 100%; height: 28px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>; background-image: none;" maxlength="35" value="<%=InsertTime%>"onkeydown="EnterKeyDown(this.form,'Checkbox<%=i%>');" readonly></TD>
                                        </tr>
                                        <%Rs1.MoveNext
                                        RCount = RCount -1
                                    Loop
                                    Rs1.Close
                                    Set Rs1 = Nothing%>
                                </tbody>
                                <%End If%>
                            <%'End If%>
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
            RegistEdit(f);
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
    function RegistEdit(obj1){
        var myform = obj1;
        for(var i = 0; i<myform.elements.length; i++) {
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    //if(confirm("선택한 등록결과를 수정합니다. 계속하시겠습니까?")==true){
                        myform.action="RegistEdit.asp";
                        //myform.SearchTitle.value = document.MenuForm.SearchTitle.value
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
        //alert('수정할 등록결과를 선택해 주세요.')
        myModalRootClick("등록결과 수정","수정할 등록결과를 선택해 주세요");
    }
    function RegistDelete(obj1){
        var myform = obj1;
        var mylength = myform.elements.length;
        for(var i = 0; i<mylength; i++){
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    //if(confirm("선택한 등록결과를 삭제합니다. 계속하시겠습니까?")==true){
                        myform.action="RegistDelete.asp";
                        //myform.SearchTitle.value = document.MenuForm.SearchString.value
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
        //alert('삭제할 등록결과를 선택해 주세요.')
        myModalRootClick("등록결과 삭제","삭제할 등록결과를 선택해 주세요");
    }
    function TruncateTable(f){
        var question = "";
		if (f.FormSubjectDivision0)
		{
			if (f.FormSubjectDivision0.value!=""){
				question = question + f.FormSubjectDivision0.value +" ";
			}
		}
        if (f.FormSubjectSubject)
		{
			if (f.FormSubjectSubject.value!=""){
				question = question + f.FormSubjectSubject.value +" ";
			}
		}
		if (f.FormSubjectDivision1)
		{
			if (f.FormSubjectDivision1.value!=""){
				question = question + f.FormSubjectDivision1.value +" ";
			}
		}
		if (f.FormSubjectDivision2)
		{
			if (f.FormSubjectDivision2.value!=""){
				question = question + f.FormSubjectDivision2.value +" ";
			}
		}
        if (question==""){
            question = "모든 등록결과와 전화기록을 삭제 하려고 합니다. 계속하시겠습니까?";
        }else{
            question = "선택한 " + question + " 등록결과와 전화기록을 삭제 하려고 합니다. 계속하시겠습니까?";
        }
        if (confirm(question) ){
            if (confirm("다시한번 확인합니다. \n삭제된 등록기록, 전화기록은 복구가 불가능 합니다. \n계속하시겠습니까?")){
                var url = "./process/TruncateTable.asp?table=RegistRecord"
                url = url + '&FormDivision0=<%=Session("FormSubjectDivision0")%>'
                url = url + '&FormSubject=<%=Session("FormSubjectSubject")%>'
                url = url + '&FormDivision1=<%=Session("FormSubjectDivision1")%>'
                url = url + '&FormDivision2=<%=Session("FormSubjectDivision2")%>'
                url = url + '&FormDivision3=<%=Session("FormSubjectDivision3")%>'
                TruncateFrame.document.location.href=url;
            }
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