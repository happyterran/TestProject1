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

        <!--ace -->
		<meta name="description" content="Static &amp; Dynamic Tables" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!--basic styles-->

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link href="assets/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!--page specific plugin styles-->

		<!--fonts-->

		<link rel="stylesheet" href="assets/css/ace-fonts.css" />

		<!--ace styles-->

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
        <!--ace End-->

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
</script>
</head>
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

<body style="padding-top: 0;" onload="moveToCenter();">

<!-- Form area -->
<div id="ui-popup-contents" style="width: <%=Width%>px;height:auto;">
    <div class="matter">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">



<%
Dim SaveFile
'FormStudentNumber = Request.Querystring("FormStudentNumber")
SaveFile = Request.Querystring("SaveFile")
Dim RegistRecordIDX
RegistRecordIDX = Request.Querystring("RegistRecordIDX")
'##############################
'##지원자 전화기록
'##############################
Dim Rs1, StrSql
if FormStudentNumber <>"" then
	Set Rs1 = Server.CreateObject("ADODB.Recordset")

	if SaveFile <>"" then
		StrSql =          "begin tran"
		'전화명령을 DB로 수행
		StrSql = StrSql & vbCrLf & "	Update LineOrder"
		StrSql = StrSql & vbCrLf & "	set LineOrder = 'PLAYVOX," & SaveFile & "'"
		StrSql = StrSql & vbCrLf & "	, OrderConfirm = '1'"
		StrSql = StrSql & vbCrLf & "	, InsertTime = getdate()"
		StrSql = StrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"
		StrSql = StrSql & vbCrLf & "if @@Error=0 commit tran else rollback"
		'Response.Write StrSql & "<BR>"
		'response.end
		Dbcon.Execute(StrSql)
	end if
	
	if Session("Grade")="관리자" and RegistRecordIDX <>"" then
		StrSql =		"begin tran"
		StrSql = StrSql & vbCrLf & "insert into RegistRecordDeleted"
		StrSql = StrSql & vbCrLf & "select *,getdate()"
		StrSql = StrSql & vbCrLf & "from RegistRecord"
		StrSql = StrSql & vbCrLf & "where IDX = '" & RegistRecordIDX & "'"
		StrSql = StrSql & vbCrLf & "Delete RegistRecord"
		StrSql = StrSql & vbCrLf & "where IDX = '" & RegistRecordIDX & "'"
		StrSql = StrSql & vbCrLf & "if @@Error=0 commit tran else rollback"
		'Response.Write StrSql & "<BR>"
		'response.end
		'Response.Write RegistRecordIDX
		Dbcon.Execute(StrSql)
	end if

	StrSql	=		"select a.*, b.*, A.InsertTIme as InsertTimeRegistRecord, a.IDX RegistRecordIDX"
	StrSql = StrSql & vbCrLf & "from RegistRecord A"
	StrSql = StrSql & vbCrLf & "join StudentTable B"
	StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
	StrSql = StrSql & vbCrLf & "and A.SubjectCode = B.SubjectCode"
	StrSql = StrSql & vbCrLf & "	and A.StudentNumber = '" & FormStudentNumber & "'"
	StrSql = StrSql & vbCrLf & "	and B.StudentNumber = '" & FormStudentNumber & "'"
	StrSql = StrSql & vbCrLf & "order by A.IDX"

'	Response.Write StrSql
	Rs1.Open StrSql, Dbcon, 1, 1
	%>
    <!-- Widget -->
    <div class="widget">
        <div class="widget-content">
            <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                <col width="40"></col><col width="60"></col><col width="80"></col><col width="80"></col><col width="80"></col><col width="60"></col><col width="80"></col><col width=""></col><col width="80"></col><col width="100"></col><col width="40"></col><col width="80"></col>
                <thead>
                    <tr>
                        <th class="center">No.<!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></th>
                        <th class="center">차수</th>
                        <th class="center">발신번호</th>
                        <th class="center hidden-480">받은사람</th>
                        <th class="center">결과</th>
                        <th class="center hidden-480">라인</th>
                        <th class="center hidden-phone" style="color: #666">상담원</th>
                        <th class="center hidden-phone">메모</th>
                        <th class="center hidden-phone">작업시각</th>
                        <th class="center hidden-phone">녹음</th>
                        <%if Session("Grade")="관리자" then%>
                        <th class="center hidden-phone">삭제</th>
                        <%end if%>
                        <th class="center hidden-480">전화로듣기</th>
                    </tr>
                </thead>

                <tbody>
                    <%if Rs1.RecordCount>0 then%>
                        <%Dim Degree, Tel, UsedLine, MemberID, MemberName, Result, Receiver, Memo, InsertTimeRegistRecord, No
                            Dim ResultTempStr, ReceiverTempStr
                        No = 0
                        do until Rs1.EOF
                            No=No+1
                            RegistRecordIDX = GetParameter( Rs1("RegistRecordIDX") , "" )
                            Degree = GetIntParameter( Rs1("Degree") , 0 )
                            Tel = GetParameter( Rs1("Tel") , "&nbsp;" )
                            UsedLine = GetIntParameter( Rs1("UsedLine") , 0 )
                            MemberID = GetParameter( Rs1("MemberID") , "&nbsp;" )
                            SaveFile = GetParameter( Rs1("SaveFile") , "" )
                            'if SaveFile<>"" then SaveFile = FormStudentNumber & SaveFile & ".wav"
                            Result = GetIntParameter( Rs1("Result") , 1 )
                            Receiver = GetIntParameter( Rs1("Receiver") , 1 )
                            Memo = GetParameter( Rs1("Memo") , "&nbsp;" )
                            InsertTimeRegistRecord = GetParameter( Rs1("InsertTimeRegistRecord") , "&nbsp;" )
                            if InsertTimeRegistRecord <> "&nbsp;" then InsertTimeRegistRecord = CastDateTime2(InsertTimeRegistRecord)
                            Dim PluralStudentNumber
                            PluralStudentNumber = GetParameter( Rs1("PluralStudentNumber") , "" )
                            if SaveFile<>"" then 
                                If PluralStudentNumber<>"" Then
                                    SaveFile = PluralStudentNumber & SaveFile & ".wav"
                                Else 
                                    SaveFile = FormStudentNumber & SaveFile & ".wav"
                                End If 
                            End If
                            'response.write SaveFile
                            
                            '결과
                            select case Result
                                case 1
                                    ResultTempStr = "미작업"
                                case 2
                                    ResultTempStr = "등록완료"
                                case 3
                                    ResultTempStr = "포기"
                                case 4
                                    ResultTempStr = "미결정"
                                case 5
                                    ResultTempStr = "미연결"
                                case 6
                                    ResultTempStr = "등록예정"
                                case 7
                                    ResultTempStr = "미등록"
                                case 8
                                    ResultTempStr = ""
                                case 9
                                    ResultTempStr = ""
                                case 10
                                    ResultTempStr = "환불"
                            end select
                            '받은사람
                            select case Receiver
                                case 1
                                    ReceiverTempStr = "없음"
                                case 2
                                    ReceiverTempStr = "지원자"
                                case 3
                                    ReceiverTempStr = "부모"
                                case 4
                                    ReceiverTempStr = "가족"
                                case 5
                                    ReceiverTempStr = "기타"
                            end select%>
                            <tr>
                                <td class="center"><%=No%><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></td>
                                <td class="center"><%=Degree%></td>
                                <td class="center"><%=Tel%></td>
                                <td class="center hidden-480"><%=ReceiverTempStr%></td>
                                <td class="center"><%=ResultTempStr%></td>
                                <td class="center hidden-480"><%=UsedLine%></td>
                                <td class="center hidden-phone"><%=MemberID%></td>
                                <td class="center hidden-phone"><%=Memo%></td>
                                <td class="center hidden-phone"><%=InsertTimeRegistRecord%></td>
                                <td class="center hidden-phone"><a href="/Record/<%=SaveFile%>"><%=SaveFile%></a></td>
                                <td class="center hidden-phone">
                                    <div class="hidden-phone visible-desktop action-buttons">
                                        <a class="red" href="#"><i class="icon-trash bigger-130"></i></a>
                                    </div>
                                </td>
                                <td class="center hidden-480">
                                    <div class="hidden-phone visible-desktop action-buttons">
                                        <a class="blue" href="#"><i class="icon-zoom-in bigger-130"></i></a>
                                    </div>
                                </td>
                            </tr>
                            <%Rs1.MoveNext
                        Loop%>
                    <%else%>
                        <TR><TD class="center">전화 기록이 없습니다.</TD></TR>
                    <%end if
                    Rs1.close
                    Set Rs1=Nothing%>
                </tbody>
            </table>
        </div>
        <!-- <input type="button" onclick="centerCount = 1; moveToCenter()" value="moveToCenter"> -->
    </div>
<%else%>
    <div class="widget">
        <div class="widget-content">
            <table id="" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr><th class="">지원자를 선택하지 않았습니다.</th></TR>
                </thead>
            </table>
        </div>
        <!-- <input type="button" onclick="centerCount = 1; moveToCenter()" value="moveToCenter"> -->
    </div>
<%end if%>

<!-- Widget -->
<div class="widget">
    <div class="widget-head">
        <div class="pull-left">지원자 세부정보</div>
        <div class="widget-icons pull-right"></div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content">
        <table id="" class="table table-striped table-bordered table-hover">
            <col width="10"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width=""></col>
            <thead>
                <tr>
                    <th class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></th>
                    <th class="center">Domain</th>
                    <th class="center">Price</th>
                    <th class="center hidden-480">Clicks</th>
                    <th class="hidden-phone"><i class="icon-time bigger-110 hidden-phone"></i>Update</th>
                    <th class="center hidden-480">Status</th>
                    <th class="center"></th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></td>
                    <td class="center"><a href="#">app.com</a></td>
                    <td class="center">$45</td>
                    <td class="center hidden-480">3,330</td>
                    <td class="center hidden-phone">Feb 12</td>
                    <td class="center hidden-480"><span class="label label-warning">Expiring</span></td>
                    <td class="center td-actions">
                        <div class="hidden-phone visible-desktop action-buttons">
                            <a class="blue" href="#"><i class="icon-zoom-in bigger-130"></i></a>
                            <a class="green" href="#"><i class="icon-pencil bigger-130"></i></a>
                            <a class="red" href="#"><i class="icon-trash bigger-130"></i></a>
                        </div>

                        <div class="hidden-desktop visible-phone">
                            <div class="inline position-relative">
                                <button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-caret-down icon-only bigger-120"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-yellow pull-right dropdown-caret dropdown-close">
                                    <li><a href="#" class="tooltip-info" data-rel="tooltip" title="View"><span class="blue"><i class="icon-zoom-in bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-success" data-rel="tooltip" title="Edit"><span class="green"><i class="icon-edit bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-error" data-rel="tooltip" title="Delete"><span class="red"><i class="icon-trash bigger-120"></i></span></a></li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></td>
                    <td class="center"><a href="#">base.com</a></td>
                    <td class="center">$35</td>
                    <td class="center hidden-480">2,595</td>
                    <td class="center hidden-phone">Feb 18</td>
                    <td class="center hidden-480"><span class="label label-warning">Registered</span></td>
                    <td class="center td-actions">
                        <div class="hidden-phone visible-desktop action-buttons">
                            <a class="blue" href="#"><i class="icon-zoom-in bigger-130"></i></a>
                            <a class="green" href="#"><i class="icon-pencil bigger-130"></i></a>
                            <a class="red" href="#"><i class="icon-trash bigger-130"></i></a>
                        </div>

                        <div class="hidden-desktop visible-phone">
                            <div class="inline position-relative">
                                <button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-caret-down icon-only bigger-120"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-yellow pull-right dropdown-caret dropdown-close">
                                    <li><a href="#" class="tooltip-info" data-rel="tooltip" title="View"><span class="blue"><i class="icon-zoom-in bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-success" data-rel="tooltip" title="Edit"><span class="green"><i class="icon-edit bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-error" data-rel="tooltip" title="Delete"><span class="red"><i class="icon-trash bigger-120"></i></span></a></li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- Widget -->
<div class="widget">
    <div class="widget-content">
        <table id="sample-table-3" class="table table-striped table-bordered table-hover">
            <col width="10"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width="100"></col><col width=""></col>
            <thead>
                <tr>
                    <th class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></th>
                    <th class="center">Domain</th>
                    <th class="center">Price</th>
                    <th class="center hidden-480">Clicks</th>
                    <th class="hidden-phone"><i class="icon-time bigger-110 hidden-phone"></i>Update</th>
                    <th class="center hidden-480">Status</th>
                    <th class="center"></th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></td>
                    <td class="center"><a href="#">app.com</a></td>
                    <td class="center">$45</td>
                    <td class="center hidden-480">3,330</td>
                    <td class="center hidden-phone">Feb 12</td>
                    <td class="center hidden-480"><span class="label label-warning">Expiring</span></td>
                    <td class="center td-actions">
                        <div class="hidden-phone visible-desktop action-buttons">
                            <a class="blue" href="#"><i class="icon-zoom-in bigger-130"></i></a>
                            <a class="green" href="#"><i class="icon-pencil bigger-130"></i></a>
                            <a class="red" href="#"><i class="icon-trash bigger-130"></i></a>
                        </div>

                        <div class="hidden-desktop visible-phone">
                            <div class="inline position-relative">
                                <button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-caret-down icon-only bigger-120"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-yellow pull-right dropdown-caret dropdown-close">
                                    <li><a href="#" class="tooltip-info" data-rel="tooltip" title="View"><span class="blue"><i class="icon-zoom-in bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-success" data-rel="tooltip" title="Edit"><span class="green"><i class="icon-edit bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-error" data-rel="tooltip" title="Delete"><span class="red"><i class="icon-trash bigger-120"></i></span></a></li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="center"><!-- <label><input type="checkbox" /><span class="lbl"></span></label> --></td>
                    <td class="center"><a href="#">base.com</a></td>
                    <td class="center">$35</td>
                    <td class="center hidden-480">2,595</td>
                    <td class="center hidden-phone">Feb 18</td>
                    <td class="center hidden-480"><span class="label label-warning">Registered</span></td>
                    <td class="center td-actions">
                        <div class="hidden-phone visible-desktop action-buttons">
                            <a class="blue" href="#"><i class="icon-zoom-in bigger-130"></i></a>
                            <a class="green" href="#"><i class="icon-pencil bigger-130"></i></a>
                            <a class="red" href="#"><i class="icon-trash bigger-130"></i></a>
                        </div>

                        <div class="hidden-desktop visible-phone">
                            <div class="inline position-relative">
                                <button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon-caret-down icon-only bigger-120"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-yellow pull-right dropdown-caret dropdown-close">
                                    <li><a href="#" class="tooltip-info" data-rel="tooltip" title="View"><span class="blue"><i class="icon-zoom-in bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-success" data-rel="tooltip" title="Edit"><span class="green"><i class="icon-edit bigger-120"></i></span></a></li>
                                    <li><a href="#" class="tooltip-error" data-rel="tooltip" title="Delete"><span class="red"><i class="icon-trash bigger-120"></i></span></a></li>
                                </ul>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="widget">
    <div class="widget-head">
        <div class="pull-left">전화제어</div>
        <div class="widget-icons pull-right"></div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content">
        <table id="sample-table-1" class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th class="center">#</th>
                    <th class="center">Name</th>
                    <th class="center">Location</th>
                    <th class="center">Age</th>
                    <th class="center">Education</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="center">1</td>
                    <td class="center">Ashok</td>
                    <td class="center">India</td>
                    <td class="center">23</td>
                    <td class="center">B.Tech</td>
                </tr>
                <tr>
                    <td class="center">5</td>
                    <td class="center">Santhosh</td>
                    <td class="center">Japan</td>
                    <td class="center">43</td>
                    <td class="center">M.Tech</td>
                </tr>                                                                        
            </tbody>
        </table>
    </div>
</div>
<!-- Widget End-->

                </div>
            </div>
        </div>
    </div>
</div>
	
		

<!-- JS -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>

    <!--basic scripts-->

    <!--[if !IE]>-->

    <script type="text/javascript">
        window.jQuery || document.write("<%=chr(60)%>script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
    </script>

    <!--<![endif]-->

    <!--[if IE]>
    <script type="text/javascript">
     window.jQuery || document.write("<%=chr(60)%>script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
    </script>
    <![endif]-->

    <script type="text/javascript">
        if("ontouchend" in document) document.write("<%=chr(60)%>script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
    </script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!--page specific plugin scripts-->

    <script src="assets/js/jquery.dataTables.js"></script>
    <script src="assets/js/jquery.dataTables.bootstrap.js"></script>

    <!--ace scripts-->

    <script src="assets/js/ace-elements.min.js"></script>
    <script src="assets/js/ace.min.js"></script>

    <!--inline scripts related to this page-->
    <script type="text/javascript">
        $(function() {
            var oTable1 = $('#sample-table-2').dataTable( {
            "aoColumns": [
              { "bSortable": false },
              null, null,null, null, null,
              { "bSortable": false }
            ] } );

            var oTable2 = $('#sample-table-3').dataTable( {
            "aoColumns": [
              { "bSortable": false },
              null, null,null, null, null,
              { "bSortable": false }
            ] } );
            
            
            $('table th input:checkbox').on('click' , function(){
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });
                    
            });
        
        
            $('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
            function tooltip_placement(context, source) {
                var $source = $(source);
                var $parent = $source.closest('table')
                var off1 = $parent.offset();
                var w1 = $parent.width();
        
                var off2 = $source.offset();
                var w2 = $source.width();
        
                if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
                return 'left';
            }
        })
        var centerCount = 1
        function moveToCenter(){
            if (centerCount<3){
                $popup.moveToCenter()
                setTimeout(moveToCenter,1000);
                centerCount += 1
            }
        }

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