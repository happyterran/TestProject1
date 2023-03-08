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
        <h2 class="pull-left"><i class="icon-wrench"></i> 환경 설정</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/DegreeSetting.asp" class="bread-current">환경 설정</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">



          <div class="row-fluid">
            <div class="span4">



                <form class="form-horizontal uni" METHOD="POST" ACTION="DegreeSettingOk.asp" name="FormDegreeSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">차수 설정</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>모집, 차수, 등록기한을 선택하고 "추가"버튼을 클릭하세요. 추가된 차수는 다음 결과 입력부터 적용됩니다.</h6>
                        <hr />
                        <label>모집시기 차수 선택</label>
                        <div class='file-checkbox'>
                            <%'##########  전형  ##########
                            Dim StrSql, Rs11
                            Set Rs11 = Server.CreateObject("ADODB.Recordset")
                            StrSql	=				"select Division0, count(*) as count "
                            StrSql = StrSql & vbCrLf & "from SubjectTable "
                            StrSql = StrSql & vbCrLf & "where Division0<>'' "
                            StrSql = StrSql & vbCrLf & "group by Division0 "
                            StrSql = StrSql & vbCrLf & "order by Division0"
                            'Response.Write StrSql & "<BR>"
                            Rs11.Open StrSql, Dbcon
                            Dim DivisionTemp
                            If Rs11.BOF = false Then%>
                                <SELECT NAME="Division0" style="width: 190px;">
                                    <option value="">모집시기 선택</option>
                                    <%do Until Rs11.EOF
                                        DivisionTemp = Rs11("Division0")%>
                                        <option value="<%=DivisionTemp%>"><%=DivisionTemp%></option>
                                        <%Rs11.MoveNext%>
                                    <%Loop%>
                                </SELECT>
                            <%End If%>
                            <%Rs11.Close%>
                            <%'##########  전형  ##########
                            Set Rs11 = Server.CreateObject("ADODB.Recordset")
                            StrSql	=				"select ISNULL(Max(Degree),0) DegreeTemp"
                            StrSql = StrSql & vbCrLf & "from RegistRecord "
                            'Response.Write StrSql & "<BR>"
                            Rs11.Open StrSql, Dbcon
                            Dim DegreeTemp, i
                            i=1
                            If Rs11.BOF = false Then%>
                                <SELECT NAME="Degree" style="width: 190px;">
                                    <option value="">차수 선택</option>
									<option value="0">0</option>
                                    <%do Until i = DegreeTemp + 5
                                        DegreeTemp = Rs11("DegreeTemp")%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <%i=i+1%>
                                    <%Loop%>
                                </SELECT>
                            <%End If%>
                            <%Rs11.Close
                            Set Rs11 = Nothing%>
                        </div>
                        <hr />
                        <label>등록기한 선택</label>
                        <div id="datetimepicker1" class="input-append">
                            <input data-format="yyyy-MM-dd" type="text" name="RefundDay1" style="width: 155px; height: 22px; border-radius: 4px 0 0 4px; " value="<%=Date()+1%>" readonly>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar" id="RefundDay1Icon" style="cursor: pointer"></i>
                            </span>
                        </div>
                        <div id="datetimepicker2" class="input-append">
                            <input data-format="hh:mm:ss" type="text" name="RefundDay2" style="width: 155px; height: 22px; border-radius: 4px 0 0 4px; " value="16:00:00" readonly>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar" style="cursor: pointer"></i>
                            </span>
                        </div>
                        <hr />
                        <button type="button" class="btn btn-primary" style="width: 190px;" onclick="BulkDegreeSetting(this.form);"> 차수설정 추가 </button>
                        <hr />
                        <%Dim Rs
                        Dim Division0cct
                        Set Rs = Server.CreateObject("ADODB.Recordset")
                        StrSql =       "select D.*, cct.Division0 Division0cct"
                        StrSql = StrSql & vbCrLf & "from Degree2 D"
                        StrSql = StrSql & vbCrLf & "left outer join ( select distinct Division0 from SubjectTable ) cct"
                        StrSql = StrSql & vbCrLf & "on D.Division0 = cct.Division0"
                        StrSql = StrSql & vbCrLf & "Order by D.IDX desc"
                        'PrintSql StrSql
                        'Response.End
                        Rs.Open StrSql, Dbcon%>
                        <%If Rs.EOF Then%>
                            <label>지정된 차수가 없습니다</label>
                        <%Else%>
                            <label>현재 운영중인 차수</label>
                            <%do Until Rs.eof%>
                                <ul class="task">
                                    <li>
                                        <%Division0cct = getParameter(Rs("Division0cct"), "")
                                        If Division0cct="" Then%>
                                            <%=Rs("Division0")%>모집&nbsp; 충원 <%=Rs("Degree")%>차&nbsp; 폐기대상입니다.
                                        <%Else%>
                                            <%=Rs("Division0")%>모집&nbsp; 충원 <%=Rs("Degree")%>차&nbsp; <!-- 등록기한 <%=Rs("RegistrationYear")%>년  --><%=Rs("RegistrationMonth")%>월 <%=Rs("RegistrationDay")%>일 <%=Rs("RegistrationHour")%>시 <%=Rs("RegistrationMinute")%>분
                                        <%End If%>
                                      <a href="javascript: if (confirm('<%=Rs("Division0")%>모집 차수정보를 삭제할까요?')){document.location.href='DegreeDeleteOk.asp?IDX=<%=Rs("IDX")%>'}" class="pull-right"><i class="icon-remove"></i></a>
                                    </li>                                                                                               
                                </ul>
                                <%Rs.MoveNext
                            loop%>
                        <%End If%>
                        <%Rs.Close
                        Set Rs = Nothing%>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>
                </form>

				

                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">샘플명단 다운로드</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>파일로 업로드 기능에 사용되는 샘플 파일입니다.</h6>
                        <h6>XLS, TXT 파일 모두 사용 가능합니다.</h6>
                        <hr />
                        <button type="button" class="btn btn-info" style="width: 190px;" onclick="FileUploadSample()"> 샘플명단 다운로드</button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  



                <form class="form-horizontal" METHOD="POST" ACTION="DegreeDatabaseBackupOk.asp" name="FormDatabaseBackup">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">데이터베이스 백업</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>Database를 서버에 이미지 형태로 백업 합니다.</h6>
                        <h6>백업 이미지는 14일간 보관 후 자동 폐기됩니다</h6>
                        <hr />
                        <button type="button" class="btn btn-warning" style="width: 190px;" onclick="DatabaseBackup(this.form)"> 데이터베이스 백업 </button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  
                </form>



                <form class="form-horizontal" METHOD="POST" ACTION="DegreeDatabaseResetOk.asp" name="FormDatabaseReset">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">데이터베이스 리셋</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>Database의 모든 자료와 녹음파일을 삭제합니다.</h6>
                        <h6>삭제된 데이터는 복구가 불가능합니다.</h6>
                        <hr />
                        <button type="button" class="btn btn-danger" style="width: 190px;" onclick="DatabaseReset(this.form)"> 데이터베이스 리셋 </button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  
                </form>


		    </div><!-- span4 -->





            <div class="span4">


                <%'Dim StrSql, Rs
                Set Rs = Server.CreateObject("ADODB.Recordset")
                StrSql = "select top 1 * From SettingTable order by IDX desc"
                Rs.Open StrSql, Dbcon, 1, 1
                Dim SMSConfirm,UniversityName,CallBack,SMSAutoConfirm,SMSBodyRegistrationFee,SMSBodyAccountNumber,SMSBodyRegistrationTime, AutoAbandon
                SMSConfirm = Rs("SMSConfirm")
                UniversityName = Rs("UniversityName")
                CallBack = Rs("CallBack")
                SMSAutoConfirm = Rs("SMSAutoConfirm")
                SMSBodyRegistrationFee = Rs("SMSBodyRegistrationFee")
                SMSBodyAccountNumber = Rs("SMSBodyAccountNumber")
                SMSBodyRegistrationTime = Rs("SMSBodyRegistrationTime")
				AutoAbandon = Rs("AutoAbandon")
                Rs.Close
                Set Rs = Nothing%>
                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                <form class="form-horizontal" METHOD="POST" ACTION="DegreeSMSSettingOk.asp" name="FormSMSSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">일반 SMS 설정</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>상담원이 발송하는 SMS의 발송여부 설정입니다.</h6>
                        <hr />
                        <h5>SMS 발송여부</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSConfirm" value="1" <%If SMSConfirm="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <h5>SMS 회신번호</h5>
                        <input type="text" name="CallBack" value="<%=CallBack%>" style="width: 175px;" placeholder="">
                        <hr />
                        <button type="button" class="btn btn-primary" style="width: 190px;" onclick="SMSSetting(this.form)"> 일반 SMS 설정 적용 </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>



                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                <FORM class="form-horizontal uni" METHOD="POST" ACTION="DegreeSMSSettingTestSend.asp" name="FormSMSSettingTestSend">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">테스트 SMS 발송</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>현재 입력되어 있는 학과정보, 지원자정보, 차수설정, SMS설정을 이용하여, 아래의 핸드폰 번호로 테스트발송 합니다. 상기 설정이 준비 되어 있어야 합니다</h6>
                        <hr />
                        <label>테스트 발송 핸드폰 번호 </label>
                        <input type="text" name="TestDestination" value="" style="width: 175px;" placeholder="">
                        <hr />
                        <label>테스트 발송 모집시기 선택</label>
                        <%'##########  전형  ##########
                        Set Rs11 = Server.CreateObject("ADODB.Recordset")
                        StrSql	=				"select Division0, count(*) as count "
                        StrSql = StrSql & vbCrLf & "from SubjectTable "
                        StrSql = StrSql & vbCrLf & "where Division0<>'' "
                        StrSql = StrSql & vbCrLf & "group by Division0 "
                        StrSql = StrSql & vbCrLf & "order by Division0"
                        'Response.Write StrSql & "<BR>"
                        Rs11.Open StrSql, Dbcon
                        If Rs11.BOF = false Then%>
                            <SELECT NAME="TestDivision0" style="width: 190px;" >
                                <option value="">모집시기 선택</option>
                                <%do Until Rs11.EOF
                                    DivisionTemp = Rs11("Division0")%>
                                    <option value="<%=DivisionTemp%>"><%=DivisionTemp%></option>
                                    <%Rs11.MoveNext%>
                                <%Loop%>
                            </SELECT>
                        <%End If%>
                        <%Rs11.Close
                        Set Rs11 = Nothing%>
                        <hr />
                        <label>테스트 통화결과 선택</label>
                        <label><input name='TestResult' type='radio' value='등록예정' />등록예정</label>
                        <label><input name='TestResult' type='radio' value='포기' />포기</label>
                        <hr />
                        <button type="button" class="btn btn-success" style="width: 190px;" onclick="SMSSettingTestSend(this.form)"> 테스트 발송 </button>

                      </div>
                      <div class="widget-foot">
                      </div>

                    </div>
                  </div>
                </form>
                <%'="FormSEndURL: " & Request("FormSEndURL") & "<br>"%>
                <Iframe src="<%=Request.QueryString("FormSEndURL")%>" name="StudentDetailSMSSEnd" width="0" height="0" border="0" style="border:0;"></Iframe>


		    </div><!-- span4 -->



            <div class="span4">
                



                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
				<!--
                <FORM class="form-horizontal" METHOD="POST" ACTION="DegreeSMSSettingOk.asp" name="FormSMSSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">자동발송 SMS 설정</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>전화통화 직후 자동으로 발송하는 SMS의 설정입니다.</h6>
                        <hr />
                        <h5>SMS 자동발송여부</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSAutoConfirm" value="1" <%If SMSAutoConfirm="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>SMS에 표시할 학교명</label>
                        <input type="text" name="UniversityName" value="<%=UniversityName%>" style="width: 175px;" placeholder="">
                        <hr />
                        <label>등록금 금액 안내문구 포함</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyRegistrationFee" value="1" <%If SMSBodyRegistrationFee="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>계좌번호 안내문구 포함</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyAccountNumber" value="1" <%If SMSBodyAccountNumber="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>등록기한 안내문구 포함</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyRegistrationTime" value="1" <%If SMSBodyRegistrationTime="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <button type="button" class="btn btn-danger" style="width: 190px;" onclick="SMSSetting2(this.form)"> 자동발송 SMS 설정 적용 </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>
				-->

                <form class="form-horizontal" METHOD="POST" ACTION="DegreeAutoAbandonSettingOk.asp" name="FormAutoAbandon">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">복수지원 자동포기 설정</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>복수지원의 자동포기 여부 설정입니다.</h6>
                        <hr />
                        <h5>자동포기 여부</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="AutoAbandon" value="1" <%If AutoAbandon="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
						<button type="button" class="btn btn-info" style="width: 190px;" onclick="AutoAbandonSetting(this.form)"> 자동포기 설정 적용 </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>
		    
			</div><!-- span4 -->

          </div><!-- row-fluid -->




          <div class="row-fluid">
            <div class="span4">
		    </div><!-- span4 -->
            <div class="span4">
		    </div><!-- span4 -->
            <div class="span4">
		    </div><!-- span4 -->
          </div><!-- row-fluid -->




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
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }
    function BulkDegreeSetting(obj1){
        var myform = obj1;
        if (myform.Division0.value==""){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("차수설정","모집시기를 선택하세요");
            return false;
        }
        if (myform.Degree.value==""){
            //alert("지정할 차수를 선탁하세요.");
            myModalRootClick("차수설정","지정할 차수를 선탁하세요");
            return false;
        }
        if (myform.RefundDay1.value==""){
            //alert("지정할 차수를 선탁하세요.");
            myModalRootClick("차수설정","등록기한을 선탁하세요");
            return false;
        }
        //if (confirm("현재 차수와 등록일자를 적용합니다. 작업자 모두에게 차수가 적용니다. 계속하시겠습니까?")==true){
            obj1.submit();
        //}
    }
    function DatabaseBackup(){
        //if (confirm("데이터베이스를 백업합니다.  계속하시겠습니까?")==true){
            document.FormDatabaseBackup.submit();
        //}
    }
    function DatabaseReset(){
        if (confirm("데이터베이스를 리셋합니다.  계속하시겠습니까?")==true){
            document.FormDatabaseReset.submit();
        }
    }
    function SMSSetting(f){
        if (f.CallBack.value==""){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("일반 SMS 설정","회신번호를 입력하세요");
            return false;
        }
        f.submit();
    }
    function SMSSetting2(f){
        if (f.UniversityName.value==""){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("자동발송 SMS 설정","학교명을 입력하세요");
            return false;
        }
        f.submit();
    }
    function SMSSettingTestSend(f){
        if (f.TestDestination.value==""){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("테스트 SMS 발송","핸드폰 번호를 입력하세요.");
            return false;
        }
        if (f.TestDivision0.value==""){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("테스트 SMS 발송","모집시기를 선택하세요.");
            return false;
        }
        if (!getRadioValue(f.TestResult)){
            //alert("차수 설정할 모집을 선택하세요.");
            myModalRootClick("테스트 SMS 발송","테스트 결과를 입력하세요.");
            return false;
        }
        f.submit();
    }
	function AutoAbandonSetting(f){
		f.submit();
    }
	function FileUploadSample() {
		document.location.href = "/Images/METIS 테이블 레이아웃 샘플.rar";
	}
    function getRadioValue(radioName){
        var obj = radioName;
        for(var i=0; i<obj.length;i++){
            //alert(obj[i].value + " : " +obj[i].checked);
            if (obj[i].checked){
                getName = obj[i].value;
                return getName;
            }
        }
        return null;
    }

</script>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<!-- 결과 적용 Notification -->
<%If Request.Querystring("Message")<>"" Then
    Dim MessageType, Message
    MessageType=getParameter(Request.Querystring("MessageType"),"success")
    Message    =getParameter(Request.Querystring("Message"),"")%>
    <script language='javascript'>
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:7000});
    </script>
<%End If%>
