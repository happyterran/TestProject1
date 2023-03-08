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
        <h2 class="pull-left"><i class="icon-file-alt"></i> 충원작업</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/Root.asp" class="bread-current">충원작업</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">











          <div class="row-fluid">
            <div class="span6">


              <div class="widget">
                <div class="widget-head">
                  <div class="pull-left">모집단위 입력</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>모집단위 파일을 입력해 주세요. 파일 구조는 아래와 같습니다.</h6>
                    <h6>모집코드 , 전형 , 학과명 , 구분1 , 구분2 , 구분3 , 입학정원 , 등록금</h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkSubjectInsertOk.asp" name="FormBulkSubjectInsert" enctype="multipart/form-data" onsubmit="BulkSubjectInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>파일 업로드</label>
                        <input class='file' type='file' name="filename1"/>
                      </div>

                      <hr />
                      <button type="submit" class="btn"> 업로드 </button>
                      <button type="submit" class="btn btn-primary"> 업로드 </button>
                      <button type="submit" class="btn btn-info"> 업로드 </button>
                      <button type="submit" class="btn btn-success"> 업로드 </button>
                      <button type="submit" class="btn btn-warning"> 업로드 </button>
                      <button type="submit" class="btn btn-danger"> 업로드 </button>
                      <button type="submit" class="btn btn-inverse"> 업로드 </button>

                    </form>

                  </div>
                  <div class="widget-foot">
                    <!-- Footer goes here -->
                  </div>
                </div>
              </div>  


		    </div><!-- span6 -->




            <div class="span6">


              <div class="widget">
                <div class="widget-head">
                  <div class="pull-left">지원자 입력</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>지원자 파일을 입력해 주세요. 파일 구조는 아래와 같습니다.</h6>
                    <h6>모집코드, 수험번호, 이름, 석차, 점수, 계좌번호, 전화1, 전화2, 전화3, 전화4, 전화5, 주민번호앞, 주민번호뒤, 기타정보1, 기타정보2, 기타정보3</h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkStudentInsertOk.asp" name="BulkStudentInsert" enctype="multipart/form-data" onsubmit="BulkStudentInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>파일 업로드</label>
                        <input class='file' type='file' />
                      </div>

                      <hr />
                      <button type="submit" class="btn"> 업로드 </button>
                      <button type="submit" class="btn btn-primary"> 업로드 </button>
                      <button type="submit" class="btn btn-info"> 업로드 </button>
                      <button type="submit" class="btn btn-success"> 업로드 </button>
                      <button type="submit" class="btn btn-warning"> 업로드 </button>
                      <button type="submit" class="btn btn-danger"> 업로드 </button>
                      <button type="submit" class="btn btn-inverse"> 업로드 </button>

                    </form>

                  </div>
                  <div class="widget-foot">
                    <!-- Footer goes here -->
                  </div>
                </div>
              </div>  


		    </div><!-- span6 -->
          </div><!-- row-fluid -->




          <div class="row-fluid">
            <div class="span6">


              <div class="widget">
                <div class="widget-head">
                  <div class="pull-left">결과 입력</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>결과 파일을 입력해 주세요. 파일 구조는 아래와 같습니다.</h6>
                    <h6>수험번호 , (등록완료)(미등록)(환불) </h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkRegistRecordInsertOk.asp" name="BulkRegistRecordInsert" enctype="multipart/form-data" onsubmit="BulkRegistRecordInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>파일 업로드</label>
                        <input class='file' type='file' />
                      </div>

                      <hr />
                      <button type="submit" class="btn"> 업로드 </button>
                      <button type="submit" class="btn btn-primary"> 업로드 </button>
                      <button type="submit" class="btn btn-info"> 업로드 </button>
                      <button type="submit" class="btn btn-success"> 업로드 </button>
                      <button type="submit" class="btn btn-warning"> 업로드 </button>
                      <button type="submit" class="btn btn-danger"> 업로드 </button>
                      <button type="submit" class="btn btn-inverse"> 업로드 </button>

                    </form>

                  </div>
                  <div class="widget-foot">
                    <!-- Footer goes here -->
                  </div>
                </div>
              </div>  


		    </div><!-- span6 -->




            <div class="span6">


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

                    <h6>저장된 모집단위, 지원자, 통화결과를 선택하여 삭제 합니다.</h6>
                    <h6>모집단위는 제일 마지막에 삭제하세요.</h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni">
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkTruncateTableOk.asp" name="BulkTruncateTable" enctype="multipart/form-data" onsubmit="BulkTruncateTable(this); return false;">

                        <select>
                          <option value='option1'>Option 1</option>
                          <option value='option2'>Option 2</option>
                          <option value='option3'>Option 3</option>
                        </select>
                        <hr />
                        <label><input name='rgroup' type='radio' value='radio2' />지원자</label>
                        <label><input name='rgroup' type='radio' value='radio1' />모집단위</label>
                        <label><input name='rgroup' type='radio' value='radio3' />결과</label>

                      <hr />
                      <button type="submit" class="btn"> 삭제 </button>
                      <button type="submit" class="btn btn-primary"> 삭제 </button>
                      <button type="submit" class="btn btn-info"> 삭제 </button>
                      <button type="submit" class="btn btn-success"> 삭제 </button>
                      <button type="submit" class="btn btn-warning"> 삭제 </button>
                      <button type="submit" class="btn btn-danger"> 삭제 </button>
                      <button type="submit" class="btn btn-inverse"> 삭제 </button>

                    </form>

                  </div>
                  <div class="widget-foot">
                    <!-- Footer goes here -->
                  </div>
                </div>
              </div>  


		    </div><!-- span6 -->
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
    function BulkSubjectInsert(obj1){
        var myform = obj1;
        if (myform.filename1.value==""){
            //alert("모집단위 파일을 선택해 주세요")
            myModalRootClick("모집단위 입력","모집단위 파일을 선택해 주세요");
            return;
        }
        ShowProgress(obj1); 
        //obj1.submit();
    }
function BulkStudentInsert(obj1){
	var myform = obj1;
	if (myform.filename1.value==""){
		alert("지원자 파일을 선택해 주세요")
        myModalRootClick("지원자 입력","지원자 파일을 선택해 주세요");
		return;
	}
    return false;
	ShowProgress(obj1);
	obj1.submit();
}
function BulkRegistRecordInsert(obj1){
	var myform = obj1;
	if (myform.filename1.value==""){
		//alert("결과 파일을 선택해 주세요")
        myModalRootClick("결과 입력","결과 파일을 선택해 주세요");
		return;
	}/*
	if ( myform.BulkRegistRecordProperty[0].checked == false && myform.BulkRegistRecordProperty[1].checked == false )
	{
		//alert("결과 파일의 성격을 선택해 주세요")
        myModalRootClick("모집단위 입력","모집단위 파일을 선택해 주세요");
		return;
	}*/
	ShowProgress(obj1);
	obj1.submit();
}
function BulkTruncateTable(obj1){
	var myform = obj1;
	var DivisionName
	var TableName
	if(obj1.Division0.value!=""){
		DivisionName = obj1.Division0.value
	}else{
		//alert("삭제할 전형을 선택해 주세요")
        myModalRootClick("데이터베이스 리셋","삭제할 전형을 선택해 주세요");
		return;
	}
	if(obj1.Table[0].checked){
		TableName = "모집단위"
	}else if(obj1.Table[1].checked){
		TableName = "지원자"
	}else if(obj1.Table[2].checked){
		TableName = "결과"
	}else{
		//alert("삭제할 항목을 선택해 주세요")
        myModalRootClick("데이터베이스 리셋","삭제할 항목을 선택해 주세요");
		return;
	}
	if (TableName=="결과"){
		if (confirm(DivisionName + " 충원작업에서 가장 중요한 결과를(전화기록,녹음파일,미등록,환불) 삭제 하려고 합니다. 계속하시겠습니까?")==true){			
			if (confirm("다시한번 확인합니다. \n" + DivisionName + " 결과를 삭제 하려고 합니다. \n삭제된 (전화기록,녹음파일,미등록,환불)는 복구가 불가능 합니다. \n계속하시겠습니까?")==true){
				obj1.submit();
			}else{
				return;
			}
		}else{
			return;
		}
	}else{
		if (confirm(DivisionName + " " + TableName + "를 삭제 합니다.  삭제된 정보는 복구가 불가능 합니다.  계속하시겠습니까?")==true){
			obj1.submit();
		}
	}
}

</script>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
