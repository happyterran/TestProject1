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
        <h2 class="pull-left"><i class="icon-key"></i> 사용자 권한설정</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/Permission.asp" class="bread-current">사용자 권한설정</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">










<%Dim Rs1, StrSql, DivisionTemp, i
Set Rs1 = Server.CreateObject("ADODB.Recordset")
StrSql	=				"select top 1 * from SettingTable order by idx desc"
'Response.Write StrSql
Rs1.Open StrSql, Dbcon, 1, 1

Dim DialStatus
If Rs1.eof=false Then
    DialStatus= Rs1("DialStatus")
End If
Rs1.Close
'Set Rs1 = Nothing

Dim OrderStatus
If getParameter( Request.Form("OrderStatus"), "" ) <> "" Then
    Session("OrderStatus")= getParameter( Request.Form("OrderStatus"), "" )
    Session("OrderAsc")   = getParameter( Request.Form("OrderAsc"), "" )
    'Response.write Session("OrderStatus")
ElseIf Session("OrderStatus") = "" Then
    Session("OrderStatus") = "m.idx"
    Session("OrderAsc")    = "desc"
End If%>

<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="FormPermissionSettingDail" testtarget="Root">
    <%'##########  리스트수  ##########%>
    <SELECT NAME="SelectCount" onchange="ListCountChange(this.form);" style="width: 130px; margin-bottom: 6px;">
        <option value="50" <%If Request.Form("SelectCount")="50" Then%>selected<%End If%>>50 개씩 보기</option>
        <option value="100"<%If Request.Form("SelectCount")="100"Then%>selected<%End If%>>100 개씩 보기</option>
        <option value="200"<%If Request.Form("SelectCount")="200"Then%>selected<%End If%>>200 개씩 보기</option>
        <option value="500"<%If Request.Form("SelectCount")="500"Then%>selected<%End If%>>500 개씩 보기</option>
    </SELECT>
    <font size="4">상담원 전화상태 조정:</font>
    <SELECT NAME="DialStatus" onchange="StopAllDial(this.form);" style="width: 130px; margin-bottom: 6px;">
        <OPTION VALUE="stop" <%If DialStatus="stop" Then Response.write "SELECTED"%>>발신 중지</option>
        <OPTION VALUE="dial" <%If DialStatus="dial" Then Response.write "SELECTED"%>>전화 가능</option>
    </SELECT> &nbsp;
    <font size="4">정렬기준:</font>
    <SELECT NAME="OrderStatus" onchange="OrderChange(this.form);" style="width: 130px; margin-bottom: 6px;">
        <OPTION VALUE="m.idx"       <%If Session("OrderStatus")="m.idx" Then Response.write "SELECTED"%>>가입시각</option>
        <OPTION VALUE="m.memberid"  <%If Session("OrderStatus")="m.memberid" Then Response.write "SELECTED"%>>아이디</option>
        <OPTION VALUE="m.MemberName"<%If Session("OrderStatus")="m.MemberName" Then Response.write "SELECTED"%>>이름</option>
    </SELECT>
    <SELECT NAME="OrderAsc" onchange="OrderChange(this.form);" style="width: 130px; margin-bottom: 6px;">
        <OPTION VALUE="asc"  <%If Session("OrderAsc")="asc" Then Response.write "SELECTED"%>>오름차순</option>
        <OPTION VALUE="desc" <%If Session("OrderAsc")="desc" Then Response.write "SELECTED"%>>내림차순</option>
    </SELECT> &nbsp;
</form>










<%
'##############################
'## 학과 기록
'##############################
Dim SubjectSelect, SubjectRecordCount
StrSql = "select Subject from SubjectTable where Subject<>'' Group by Subject"
'	Response.Write StrSql
'	Response.End
Set Rs1 = Server.CreateObject("ADODB.Recordset")
Rs1.Open StrSql, Dbcon, 3, 1, 1
SubjectRecordCount = Rs1.RecordCount
Redim SubjectSelect(SubjectRecordCount)
i = 0
Do Until Rs1.EOF
    i = i +1
    SubjectSelect(i) = Rs1("Subject")
    Rs1.MoveNext
Loop
Rs1.Close
'Set Rs1 = Nothing
'Response.End

'##############################
'## 모집구분 기록
'##############################
Dim Division0Select, Division0RecordCount
StrSql = "select Division0 from SubjectTable where Division0<>'' Group by Division0"
'Response.Write StrSql
'Response.End
Set Rs1 = Server.CreateObject("ADODB.Recordset")
Rs1.Open StrSql, Dbcon, 3, 1, 1
Division0RecordCount = Rs1.RecordCount
Redim Division0Select(Division0RecordCount)
i = 0
Do Until Rs1.EOF
    i = i +1
    Division0Select(i) = Rs1("Division0")
    Rs1.MoveNext
Loop
Rs1.Close
'Set Rs1 = Nothing
'Response.End

'##############################
'## 구분1 기록
'##############################
Dim Division1Select, Division1RecordCount
StrSql = "select Division1 from SubjectTable where Division1<>'' Group by Division1"
'Response.Write StrSql
'Response.End
Set Rs1 = Server.CreateObject("ADODB.Recordset")
Rs1.Open StrSql, Dbcon, 3, 1, 1
Division1RecordCount = Rs1.RecordCount
Redim Division1Select(Division1RecordCount)
i = 0
Do Until Rs1.EOF
    i = i +1
    Division1Select(i) = Rs1("Division1")
    Rs1.MoveNext
Loop
Rs1.Close
'Set Rs1 = Nothing
'Response.End


'##############################
'## 상담원 가입기록
'##############################
'Dim Rs1', StrSql
'Set Rs1 = Server.CreateObject("ADODB.Recordset")
StrSql	=				"select m.*, sr.SubjectCode, sr.StatusName, cct.Division0, cct.Subject, cct.Division1"
StrSql = StrSql & vbCrLf & "from Member m"
StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select A.*, sc.StatusName"
StrSql = StrSql & vbCrLf & "	from StatusRecord A "
StrSql = StrSql & vbCrLf & "	join  "
StrSql = StrSql & vbCrLf & "	( "
StrSql = StrSql & vbCrLf & "		select MemberID, max(IDX) as MaxIDX "
StrSql = StrSql & vbCrLf & "		from StatusRecord"
StrSql = StrSql & vbCrLf & "		group by MemberID"
StrSql = StrSql & vbCrLf & "	) B"
StrSql = StrSql & vbCrLf & "	on A.MemberID = B.MemberID"
StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
StrSql = StrSql & vbCrLf & "	left outer join StatusCode sc"
StrSql = StrSql & vbCrLf & "	on a.Status = sc.Status"
StrSql = StrSql & vbCrLf & ") sr"
StrSql = StrSql & vbCrLf & "on M.MemberID=sr.MemberID"
StrSql = StrSql & vbCrLf & "left outer join SubjectTable cct"
StrSql = StrSql & vbCrLf & "on sr.SubjectCode = cct.SubjectCode"
StrSql = StrSql & vbCrLf & "order by " & Session("OrderStatus") & " " & Session("OrderAsc") & ""
'Response.Write StrSql
Rs1.Open StrSql, Dbcon, 1, 1%>
<FORM METHOD="POST" ACTION="PermissionEdit.asp" Name="FormPermissionSetting" testtarget="Root">
  <div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
      <div class="pull-left">사용자 리스트 : <%=Rs1.RecordCount%></div>
      <div class="widget-icons pull-right">
      
        <button type="submit" class="btn" onclick="PermissionEdit(this.form);">
            <i class="icon-ok bigger-120"></i> 적용완료
        </button>
        <button type="button" class="btn" onclick='PermissionDelete(this.form);'>
            <i class="icon-minus-sign bigger-120"></i> 선택삭제
        </button>
        <button type="button" class="btn btn-danger" onclick='TruncateTable(this.form); return false;'>
            <i class="icon-trash bigger-120"></i> 전체삭제
        </button><!-- 
        <button type="button" class="btn btn-primary" onclick="alert('준비중입니다...');//window.open('./PermissionUpload.asp','PermissionUpload','toolbar=no,menubar=no,scrollbars=no,resizable=no,width=650 height=615'); return false;">
            <i class="icon-upload-alt bigger-120"></i> 파일로 업로드
        </button> -->
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
            <table class="table table-striped table-bordered" style="atable-layout: fixed;">
                <colgroup><col width="4%"></col><col width="6%"></col><col width="6%"></col><col width="6%"></col><col width="18%"></col><col width=""></col><col width="10%"></col><col width="17%"></col><col width="11%"></col><col width="11%"></col></colgroup>
              <thead>
                <tr>
                  <th colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;"><img src="/images/Dummy.png" width="19" height="19" border="0" onclick="checkall(document.FormPermissionSetting);" style="cursor: pointer;" title="전체선택"></th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">아이디</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">이름</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화중</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">최근작업</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">권한</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">모집제한</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전형제한</th>
                  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">학과제한1</th>
				  <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">학과제한2</th>
                </tr>
              </thead>
                <%if Rs1.eof then%>
                    <tbody>
                    <TR><TD colspan="9" style="height: 40; text-align: center;">사용자 기록이 없습니다.<BR>
                    </tbody>
                <%else%>
                    <tbody>
                    <%Dim MemberID,MemberName,Grade,InsertTime',i
                    Dim BGColor
                    BGColor = "#f0f0f0"
                    'Dim SubjectCode, StatusName, Division0, Subject, Division1
                    Dim SubjectCode, StatusName, Division0, Subject, Division1, j, MemberSubjectA, MemberSubjectB, MemberDivision0, MemberDivision1
                    i=0
                    do Until Rs1.EOF
                        MemberID= Rs1("MemberID")
                        MemberName= Rs1("MemberName")
                        Grade= Rs1("Grade")
                        InsertTime= Rs1("InsertTime")
                        SubjectCode= Rs1("SubjectCode")
                        StatusName= Rs1("StatusName")
                        If StatusName="녹음중" Then StatusName="<FONT COLOR='red'>녹음중</FONT>"
                        If StatusName="전화중" Then StatusName="<FONT COLOR='Blue'>전화중</FONT>"
                        Division0= Rs1("Division0")
                        Subject= Rs1("Subject")
                        Division1= Rs1("Division1")
                        MemberDivision0= Rs1("MemberDivision0")
                        MemberSubjectA= Rs1("MemberSubjectA")
						MemberSubjectB= Rs1("MemberSubjectB")
                        MemberDivision1= Rs1("MemberDivision1")
                        i = i + 1
                        If BGColor = "#f0f0f0" Then
                            BGColor = "#fafafa"
                        Else BGColor = "#fafafa"
                            BGColor = "#f0f0f0"
                        End If
                        %>
                        <tr>
                            <TD colspan="1" style="padding: 8px 0px 5px 0px; background-color: <%=BGColor%>; text-align: center;" nowrap><INPUT TYPE="Checkbox" NAME="Checkbox" ID="Checkbox<%=i%>" style="width: 100%; height: 16; padding-left: 0px;" value="<%=i%>" id="<%=i%>"><input type="hidden" name="MemberIDHidden" value="<%=MemberID%>"></TD>
                            <TD colspan="1" style="padding: 0px 0px 0px 0px; background-color: <%=BGColor%>; text-align: left;"  ><INPUT TYPE="text" NAME="MemberID"  style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=MemberID%>" onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></TD>
                            <TD colspan="1" style="padding: 0px 0px 0px 0px; background-color: <%=BGColor%>; text-align: left;"  ><INPUT TYPE="text" NAME="MemberName"style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=MemberName%>" onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></TD>
                            <TD colspan="1" style="padding: 8px 0px 5px 0px; background-color: <%=BGColor%>; text-align: center;" nowrap><%=StatusName%></TD>
                            <TD colspan="1" style="padding: 0px 0px 0px 0px; background-color: <%=BGColor%>; text-align: left;"  ><INPUT TYPE="text" NAME="Subject"  style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Subject%>&nbsp;<%=Division1%>"></TD></TD>
                            <TD colspan="1" style="padding: 8px 0px 5px 5px; background-color: <%=BGColor%>; text-align: center;" nowrap>
                            <INPUT type="radio" name="Grade<%=i%>" id="게스트<%=i%>" value="게스트" onclick="document.getElementById('Checkbox<%=i%>').checked=true;" <%If Grade="게스트" Then Response.Write "checked"%>>게스트
                            <INPUT type="radio" name="Grade<%=i%>" id="상담원<%=i%>" value="상담원" onclick="document.getElementById('Checkbox<%=i%>').checked=true;" <%If Grade="상담원" Then Response.Write "checked"%>>상담원
                            <INPUT type="radio" name="Grade<%=i%>" id="관리자<%=i%>" value="관리자" onclick="document.getElementById('Checkbox<%=i%>').checked=true;" <%If Grade="관리자" Then Response.Write "checked"%>>관리자
                            </TD>
                            <TD colspan="1" style="padding: 0px; background-color: <%=BGColor%>; text-align: left;">
                            <SELECT NAME="MemberDivision0<%=i%>" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" onchange="document.getElementById('Checkbox<%=i%>').checked=true;"><!-- 
                                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option> -->
                                <option value=""></option>
                                <%For j = 1 to Division0RecordCount%><option value="<%=Division0Select(j)%>" <%If MemberDivision0 = Division0Select(j) Then Response.write "selected"%>><%=Division0Select(j)%></option>
                                <%Next%>
                            </SELECT>
                            </TD>
                            <TD colspan="1" style="padding: 0px; background-color: <%=BGColor%>; text-align: left;">
                            <SELECT NAME="MemberDivision1<%=i%>" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" onchange="document.getElementById('Checkbox<%=i%>').checked=true;"><!-- 
                                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option> -->
                                <option value=""></option>
                                <%For j = 1 to Division1RecordCount%><option value="<%=Division1Select(j)%>" <%If MemberDivision1 = Division1Select(j) Then Response.write "selected"%>><%=Division1Select(j)%></option>
                                <%Next%>
                            </SELECT>
                            </TD>
                            <TD colspan="1" style="padding: 0px; background-color: <%=BGColor%>; text-align: left;">
                            <SELECT NAME="MemberSubjectA<%=i%>" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" onchange="document.getElementById('Checkbox<%=i%>').checked=true;"><!-- 
                                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option> -->
                                <option value=""></option>
                                <%For j = 1 to SubjectRecordCount%><option value="<%=SubjectSelect(j)%>" <%If MemberSubjectA = SubjectSelect(j) Then Response.write "selected"%>><%=SubjectSelect(j)%></option>
                                <%Next%>
                            </SELECT>
                            </TD>
                            <TD colspan="1" style="padding: 0px; background-color: <%=BGColor%>; text-align: left;">
                            <SELECT NAME="MemberSubjectB<%=i%>" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" onchange="document.getElementById('Checkbox<%=i%>').checked=true;"><!-- 
                                <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </option> -->
                                <option value=""></option>
                                <%For j = 1 to SubjectRecordCount%><option value="<%=SubjectSelect(j)%>" <%If MemberSubjectB = SubjectSelect(j) Then Response.write "selected"%>><%=SubjectSelect(j)%></option>
                                <%Next%>
                            </SELECT>
                            </TD>
                        </tr>
                        <%Rs1.MoveNext
                    Loop
                    Rs1.Close
                    Set Rs1 = Nothing%>
                    <tr>
                        <td colspan="9"  style="text-align: center; padding: 1px 0px 0px 10px;">
                            <div class="span12">
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
<FORM METHOD="GET" ACTION="<%=Request.ServerVariables("URL")%>" Name="MessageForm" testtarget="Root">
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
    function PermissionEdit(f){
        var mylength = f.elements.length;
        for(var i = 0; i<mylength; i++){
            var objElement = f.elements[i];
            if (objElement.name == "Checkbox"){
                if(f.elements[i].checked){
                    //if(confirm("선택한 학부를 수정합니다. 계속하시겠습니까?")==true){
                        f.action="PermissionEdit.asp";
                        f.submit();
                        return;
                    //}else{
                    //   return;
                    //}
                }
            }
        }
        //alert('수정할 사용자를 선택해 주세요.')
        myModalRootClick("사용자 수정","수정할 사용자를 선택해 주세요");
    }
    function PermissionDelete(f){
        for(var i = 0; i<f.elements.length; i++){
            var objElement = f.elements[i];
            if (objElement.name == "Checkbox"){
                if(f.elements[i].checked){
                    //if(confirm("선택한 학부를 삭제합니다. 계속하시겠습니까?")==true){
                        f.action="PermissionDelete.asp";
                        f.submit();
                        return;
                    //}else{
                    //    return;
                    //}
                }
            }
        }
        //alert('삭제할 사용자를 선택해 주세요.')
        myModalRootClick("사용자 삭제","삭제할 사용자를 선택해 주세요");
    }
    function TruncateTable(f){
        if (confirm("모든 사용자를 삭제 할까요?")){
            var url = "./process/TruncateTable.asp?table=Member"
            TruncateFrame.document.location.href=url;
        }
    }
	function StopAllDial(f){		
		if(f.DialStatus.value=="stop"){
			if(confirm("모든 상담원의 발신이 중지되도록 변경합니다. 계속하시겠습니까?")==true){
				f.action="PermissionSettingOk2.asp";
				f.submit();
				return;
			}else{
				return;
			}
		}else{
			if(confirm("모든 상담원의 발신이 가능하도록 변경합니다. 계속하시겠습니까?")==true){
				f.action="PermissionSettingOk2.asp";
				f.submit();
				return;
			}else{
				return;
			}
		}
		
	}
	function OrderChange(f){		
		f.action="Permission.asp";
		f.submit();
	}
	function ListCountChange(f){		
		f.action="Permission.asp";
		f.submit();
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
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:5000});
    </script>
<%End If%>