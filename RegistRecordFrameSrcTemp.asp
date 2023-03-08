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
<%
Dim FormStudentNumber
FormStudentNumber = Request.Querystring("FormStudentNumber")
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
	setTimeout("document.location.href='/RegistRecordFrameSrc.asp?FormStudentNumber=<%=FormStudentNumber%>'", 1400);	
//-->
</SCRIPT>
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
    <div class="widget-head">
        <div class="pull-left">지원자 전화기록 <%=Session("RemainRecordCount")%></div>
        <div class="widget-icons pull-right">
            <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
            <a href="#" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content">
      <div class="padd invoice" style="padding: 0;">
        <div class="row-fluid">

          <div class="span12">
            <table class="table table-striped table-hover table-bordered">
              <thead>
                <tr>
                  <th colspan="1" style="text-align: center;">No.</th>
                  <th colspan="1" style="text-align: center;">차수</th>
                  <th colspan="1" style="text-align: center;">발신번호</th>
                  <th colspan="1" style="text-align: center;">받은사람</th>
                  <th colspan="1" style="text-align: center;">결과</th>
                  <th colspan="1" style="text-align: center;">라인</th>
                  <th colspan="1" style="text-align: center;">상담원</th>
                  <th colspan="1" style="text-align: center;">메모</th>
                  <th colspan="1" style="text-align: center;">작업시각</th>
                  <th colspan="1" style="text-align: center;">녹음</th>
	              <%if Session("Grade")="관리자" then%>
                  <th colspan="1" style="text-align: center;">삭제</th>
                  <%End If%>
                  <th colspan="1" style="text-align: center;">전화듣기</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td colspan="12" style="text-align: center; cursor: pointer;">기록 조회중...</td>
                </tr>
              </tbody>
            </table>
          </div>

        </div>
      </div>
    </div>
</div>  
<!-- Widget End -->




                </div>
            </div>
        </div>
    </div>
</div>
	
		

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

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->