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
    <%If Session("Grade")="������" Then'�����ڸ� ���̵��%>
  	<div class="mainbar">
    <%Else%>
    <div class="mainbar" style="margin-left:0;">
    <%End If%>
    

      <!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left" style="color: #666;">
            <%If Session("Grade")="������" Then%>
                <i class="icon-phone"></i> ����۾�
            <%Else%>
                <i class="icon-phone"></i> <b>����۾�</b> &nbsp; 
                <a href="/RootResult.asp" style="color: #AAA;"><i class="icon-bar-chart"></i> �۾����</a>
            <%End If%>
        </h2>
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
            <div class="span12">


                <!-- #include virtual = "/RootDropDownSelect.asp" -->



                <!-- #include virtual = "/SubjectStats.asp" -->



                <!-- #include virtual = "/RootFrame.asp" -->
                <iframe name="PositionFrame" src="" width="100%" height="0" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" border="1"></iframe>



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
<!-- <script src="js/jquery.flot.resize.js"></script> -->
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

<!-- richscript -->
<script type="text/javascript" src="lib/jquery/jquery.ui.js"></script>
<script type="text/javascript" src="lib/richscript/richscript.js"></script>
<script type="text/javascript" src="lib/richscript/richscript.mcm.js"></script>

<script type="text/javascript">
    function PositionChange() {
        //alert($("#courseStatsWidgetContent").css("display").toString());
        if ($("#courseStatsWidgetContent").css("display").toString()=="none"){
            PositionFrame.location.href = "/include/PositionChange.asp?Position=menu-max";
        }else{
            PositionFrame.location.href = "/include/PositionChange.asp?Position=menu-min";
        }
    }
    function SelectStudentNumber(obj1,StudentNumber)
    {
        obj1.FormStudentNumber.value=StudentNumber;
        obj1.method = "POST"
		obj1.action = "/StudentDetail.asp?width="+$.browser.screenWidth()/6*5+"&asdf=asdf";
        //alert(document.MenuForm.FormStudentNumber.value);
		$popup.submit("MenuForm");
    }
    function changePage(f,gotoPage){
        f.gotoPage.value=gotoPage;
        f.submit();
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
    function RootUpdate(obj1,obj2,Status){
        var myform = obj1;
        for(var i = 0; i<myform.elements.length; i++) {
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    if(confirm("��ȭ ���� ������ �����ڵ��� ����� �Է��մϴ�. ����Ͻðڽ��ϱ�?")==true) {
                        var StatusStr;
                        switch (Status){
                            case "1":
                                StatusStr = "���۾�"
                                break;
                            case "2":
                                StatusStr = "��ϿϷ�"
                                break;
                            case "3":
                                StatusStr = "����"
                                break;
                            case "4":
                                StatusStr = "�̰���"
                                break;
                            case "5":
                                StatusStr = "�̿���"
                                break;
                            case "6":
                                StatusStr = "��Ͽ���"
                                break;
                            case "7":
                                StatusStr = "�̵��"
                                break;
                            case "8":
                                StatusStr = ""
                                break;
                            case "9":
                                StatusStr = ""
                                break;
                            case "10":
                                StatusStr = "ȯ��"	
                                break;					
                        }
                        if (confirm(StatusStr+" �½��ϱ�?")==true){
                            myform.FormStatus.value=Status;
                            myform.FormMemo.value=obj2.FormMemo.value;
                            myform.action="RootInsertRegistRecord.asp";
                            myform.submit();
                        }
                        return;
                    }else{
                        return;
                    }
                }
            }
        }
        //alert('�����ڸ� ������ �ּ���. �Է��� ���� �˴ϴ�.')
        myModalRootClick("����۾� �ϰ��Է�","�ϰ��Է��� �����ڸ� ���� �����ϼ���");
    }
    function SendSMS(obj1,obj2){
        var myform = obj1;
        for(var i = 0; i<myform.elements.length; i++) {
            var objElement = myform.elements[i];
            if (objElement.name == "Checkbox"){
                if(myform.elements[i].checked){
                    if (obj2.SMSBody.value==""){
                        //alert('SMS ������ �Է��� �ּ���.');
                        myModalRootClick("����۾� SMS�߼�","SMS ������ �Է��� �ּ���");
                        return;
                    }
                    if(confirm("������ �����ڵ鿡�� SMS�� �߼��մϴ�. ����Ͻðڽ��ϱ�?")==true) {
                        myform.SMSBody.value=obj2.SMSBody.value;
                        myform.action="RootSMSSend.asp";
                        myform.submit();
                        return;
                    }else{
                        return;
                    }
                }
            }
        }
        //alert('�����ڸ� ������ �ּ���.')
        myModalRootClick("����۾� SMS�߼�","SMS�߼��� �����ڸ� ���� �����ϼ���");
    }

    $(window).load(function(){$("#FormDivision0").click()});

</script>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->