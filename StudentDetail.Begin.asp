<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%Dim Width, asdf
Width = Request.QueryString("width")
asdf = Request.QueryString("asdf")
'Response.Write Width
'Response.Write asdf%>
<%
Dim FormStudentNumber, FormCommand, FormDialedTel, FormTelTemp, FormReceiver, FormResult, FormMemo, FormRemainCheck, FormSendURL
FormStudentNumber = Request.Form("FormStudentNumber")
If FormStudentNumber = "" Then FormStudentNumber = Request.Querystring("FormStudentNumber")
FormCommand = GetParameter(Request.Form("FormCommand"), "")
FormDialedTel = Request.Form("FormDialedTel")
FormTelTemp = GetParameter(Request.Form("FormTelTemp"), "")
FormReceiver = GetintParameter(Request.Form("FormReceiver"), 1)
FormResult = GetintParameter(Request.Form("FormResult"), 1)
FormMemo = Request.Form("FormMemo")
FormRemainCheck = GetParameter(Request.Form("FormRemainCheck"), "")
'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
Dim FormRecorded
FormRecorded = GetParameter(Request.Form("FormRecorded"), "")
'자동녹음을 유지할 장치
Dim DRECORDCheckBox
DRECORDCheckBox = GetParameter(Request.Cookies("METIS")("DRECORDCheckBox"), "")
'여주대 상시 자동녹음
DRECORDCheckBox = "checked"

Dim Rs2%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>지원자 세부사항</title>
<!-- #include virtual = "/Include/Head.asp" -->

<script type="text/javascript" src="/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery.ui.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.popup.contents.js"></script>
<script type="text/javascript">
$(function() {
	$popup.altHtml('<div class="alt-data" style="left:-155px;"><img src="/images/richscript/ui/popup/alt.benefit.member.gif" width="990" height="377" /></div>');
	
	$("#btn-submit").bind("click", function(e) {
		var f = document.thisForm;
		f.method = f.methodType.value;
		f.action = "/popup.contents.form.asp";
		$popup.submit("thisForm");
	})

    $("#ui-popup-contents").width(<%=Width%>);
});
var centerCount=1;
</script>
</head>
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

<body style="padding-top: 0;">

<!-- Form area -->
<div id="ui-popup-contents" style="width: <%=Width%>px;height:auto;">
    <div class="matter">
        <div class="container-fluid">
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
                                <th colspan="1" style="text-align: center;">삭제</th>
                                <th colspan="1" style="text-align: center;">전화듣기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr onClick="SelectStudentNumber(document.RemainForm,'<%=asdf%>')">
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"><%=asdf%></td>
                            </tr>
                        </tbody>
                    </table><!-- table -->
                </div><!-- span12 -->
            </div><!-- row-fluid -->
        </div><!-- padd invoice -->

        <div class="widget-foot" style="padding: 0;">
          <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
            <ul>
              <li><a href="#">Prev</a></li>
              <li><a href="#">1</a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">3</a></li>
              <li><a href="#">4</a></li>
              <li><a href="#">Next</a></li>
            </ul>
          </div>
          <div class="clearfix"></div> 
        </div><!-- widget-foot -->

    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->





<input type="button" onclick="centerCount = 1; moveToCenter()" value="moveToCenter">

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

<!--inline scripts related to this page-->
<script type="text/javascript">
    function moveToCenter(){
        if (centerCount<3){
            $popup.moveToCenter()
            setTimeout(moveToCenter,500);
            centerCount += 1
            //console.log(centerCount);
        }
    }
    window.onload = moveToCenter();

    function startBlink() {
        var objBlink = document.all.tags("BLINK")
        for (var i=0; i < objBlink.length; i++)
            objBlink[i].style.visibility = objBlink[i].style.visibility == "" ? "hidden" : ""
    }
    function init() {
        if (document.all)
            setInterval("startBlink()",300)
    }
    window.onload = init;
    
</script>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->