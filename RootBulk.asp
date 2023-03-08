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
        <h2 class="pull-left"><i class="icon-file-alt"></i> ����۾�</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/Root.asp" class="bread-current">����۾�</a>
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
                  <div class="pull-left">�������� �Է�</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>�������� ������ �Է��� �ּ���. ���� ������ �Ʒ��� �����ϴ�.</h6>
                    <h6>�����ڵ� , ���� , �а��� , ����1 , ����2 , ����3 , �������� , ��ϱ�</h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkSubjectInsertOk.asp" name="FormBulkSubjectInsert" enctype="multipart/form-data" onsubmit="BulkSubjectInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>���� ���ε�</label>
                        <input class='file' type='file' name="filename1"/>
                      </div>

                      <hr />
                      <button type="submit" class="btn"> ���ε� </button>
                      <button type="submit" class="btn btn-primary"> ���ε� </button>
                      <button type="submit" class="btn btn-info"> ���ε� </button>
                      <button type="submit" class="btn btn-success"> ���ε� </button>
                      <button type="submit" class="btn btn-warning"> ���ε� </button>
                      <button type="submit" class="btn btn-danger"> ���ε� </button>
                      <button type="submit" class="btn btn-inverse"> ���ε� </button>

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
                  <div class="pull-left">������ �Է�</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>������ ������ �Է��� �ּ���. ���� ������ �Ʒ��� �����ϴ�.</h6>
                    <h6>�����ڵ�, �����ȣ, �̸�, ����, ����, ���¹�ȣ, ��ȭ1, ��ȭ2, ��ȭ3, ��ȭ4, ��ȭ5, �ֹι�ȣ��, �ֹι�ȣ��, ��Ÿ����1, ��Ÿ����2, ��Ÿ����3</h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkStudentInsertOk.asp" name="BulkStudentInsert" enctype="multipart/form-data" onsubmit="BulkStudentInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>���� ���ε�</label>
                        <input class='file' type='file' />
                      </div>

                      <hr />
                      <button type="submit" class="btn"> ���ε� </button>
                      <button type="submit" class="btn btn-primary"> ���ε� </button>
                      <button type="submit" class="btn btn-info"> ���ε� </button>
                      <button type="submit" class="btn btn-success"> ���ε� </button>
                      <button type="submit" class="btn btn-warning"> ���ε� </button>
                      <button type="submit" class="btn btn-danger"> ���ε� </button>
                      <button type="submit" class="btn btn-inverse"> ���ε� </button>

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
                  <div class="pull-left">��� �Է�</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>��� ������ �Է��� �ּ���. ���� ������ �Ʒ��� �����ϴ�.</h6>
                    <h6>�����ȣ , (��ϿϷ�)(�̵��)(ȯ��) </h6>
                    <hr />
                    <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                     <form class="form-horizontal uni" METHOD="POST" ACTION="BulkRegistRecordInsertOk.asp" name="BulkRegistRecordInsert" enctype="multipart/form-data" onsubmit="BulkRegistRecordInsert(this); return false;">
                      <div class='file-checkbox'>
                        <label>���� ���ε�</label>
                        <input class='file' type='file' />
                      </div>

                      <hr />
                      <button type="submit" class="btn"> ���ε� </button>
                      <button type="submit" class="btn btn-primary"> ���ε� </button>
                      <button type="submit" class="btn btn-info"> ���ε� </button>
                      <button type="submit" class="btn btn-success"> ���ε� </button>
                      <button type="submit" class="btn btn-warning"> ���ε� </button>
                      <button type="submit" class="btn btn-danger"> ���ε� </button>
                      <button type="submit" class="btn btn-inverse"> ���ε� </button>

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
                  <div class="pull-left">�����ͺ��̽� ����</div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd">

                    <h6>����� ��������, ������, ��ȭ����� �����Ͽ� ���� �մϴ�.</h6>
                    <h6>���������� ���� �������� �����ϼ���.</h6>
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
                        <label><input name='rgroup' type='radio' value='radio2' />������</label>
                        <label><input name='rgroup' type='radio' value='radio1' />��������</label>
                        <label><input name='rgroup' type='radio' value='radio3' />���</label>

                      <hr />
                      <button type="submit" class="btn"> ���� </button>
                      <button type="submit" class="btn btn-primary"> ���� </button>
                      <button type="submit" class="btn btn-info"> ���� </button>
                      <button type="submit" class="btn btn-success"> ���� </button>
                      <button type="submit" class="btn btn-warning"> ���� </button>
                      <button type="submit" class="btn btn-danger"> ���� </button>
                      <button type="submit" class="btn btn-inverse"> ���� </button>

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
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
        <a href="#myModalRoot" id="myModalRootButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
        <h3 id="myModalRootLabel">���â �����Դϴ�.</h3>
        <!-- myModalRootButton -->
    </div>
    <div class="modal-body">
        <p id="myModalRootMessage">�̰��� ������ ǥ�õ˴ϴ�.</p>
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
            //alert("�������� ������ ������ �ּ���")
            myModalRootClick("�������� �Է�","�������� ������ ������ �ּ���");
            return;
        }
        ShowProgress(obj1); 
        //obj1.submit();
    }
function BulkStudentInsert(obj1){
	var myform = obj1;
	if (myform.filename1.value==""){
		alert("������ ������ ������ �ּ���")
        myModalRootClick("������ �Է�","������ ������ ������ �ּ���");
		return;
	}
    return false;
	ShowProgress(obj1);
	obj1.submit();
}
function BulkRegistRecordInsert(obj1){
	var myform = obj1;
	if (myform.filename1.value==""){
		//alert("��� ������ ������ �ּ���")
        myModalRootClick("��� �Է�","��� ������ ������ �ּ���");
		return;
	}/*
	if ( myform.BulkRegistRecordProperty[0].checked == false && myform.BulkRegistRecordProperty[1].checked == false )
	{
		//alert("��� ������ ������ ������ �ּ���")
        myModalRootClick("�������� �Է�","�������� ������ ������ �ּ���");
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
		//alert("������ ������ ������ �ּ���")
        myModalRootClick("�����ͺ��̽� ����","������ ������ ������ �ּ���");
		return;
	}
	if(obj1.Table[0].checked){
		TableName = "��������"
	}else if(obj1.Table[1].checked){
		TableName = "������"
	}else if(obj1.Table[2].checked){
		TableName = "���"
	}else{
		//alert("������ �׸��� ������ �ּ���")
        myModalRootClick("�����ͺ��̽� ����","������ �׸��� ������ �ּ���");
		return;
	}
	if (TableName=="���"){
		if (confirm(DivisionName + " ����۾����� ���� �߿��� �����(��ȭ���,��������,�̵��,ȯ��) ���� �Ϸ��� �մϴ�. ����Ͻðڽ��ϱ�?")==true){			
			if (confirm("�ٽ��ѹ� Ȯ���մϴ�. \n" + DivisionName + " ����� ���� �Ϸ��� �մϴ�. \n������ (��ȭ���,��������,�̵��,ȯ��)�� ������ �Ұ��� �մϴ�. \n����Ͻðڽ��ϱ�?")==true){
				obj1.submit();
			}else{
				return;
			}
		}else{
			return;
		}
	}else{
		if (confirm(DivisionName + " " + TableName + "�� ���� �մϴ�.  ������ ������ ������ �Ұ��� �մϴ�.  ����Ͻðڽ��ϱ�?")==true){
			obj1.submit();
		}
	}
}

</script>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
