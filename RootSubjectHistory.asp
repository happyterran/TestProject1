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
        <h2 class="pull-left"><i class="icon-table"></i> 모집단위 관리 히스토리</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/RootSubjectHistory.asp" class="bread-current">모집단위 관리 히스토리</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">






<%
Dim Timer1
Timer1=Timer()
'##################################################################################
'기본 page setting values
'##################################################################################
Dim PageSize, GotoPage
PageSize = 20
GotoPage = getintParameter( Request.Form("GotoPage"), 1)
Dim TotalPage,RecordCount
TotalPage   = 1
RecordCount = 0   

'##############################
'학과 기록
'##############################
Dim Rs1, StrSql
Set Rs1 = Server.CreateObject("ADODB.Recordset")

StrSql = "select * from SubjectTableHistory"
StrSql = StrSql & vbCrLf & "order by IDX Desc"

Rs1.Open StrSql, Dbcon, 3

'----------------------------------------------------------------------------------
' 전체 페이지와 전체 카운터 설정
'----------------------------------------------------------------------------------
If (Rs1.BOF and Rs1.EOF) Then
	recordCount = 0 
	totalpage   = 0
Else
	recordCount = Rs1.RecordCount
	Rs1.pagesize = PageSize
	totalpage   = Rs1.PageCount
End If

If cint(GotoPage)>cint(totalpage) Then GotoPage=totalpage	
%>
<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" testtarget="Root">
    <input type="Hidden" name="GotoPage" value="">


              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">히스토리 리스트: <%=RecordCount%></div>
                  <div class="widget-icons pull-right">
                    <button type="button" class="btn btn-danger" onclick='TruncateTable(this.form); return false;'><i class="icon-trash bigger-120"></i> 전체삭제</button>
                    &nbsp; &nbsp; 
                    <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content">
                  <div class="padd invoice" style="background-color: <%=BGColor%>; padding: 0;">
                    <div class="row-fluid">

                      <div class="span12">
                        <table class="table table-striped table-hover table-bordered" style="atable-layout: fixed;">
                            <colgroup><col width=""></col></colgroup>
                            <thead>
                                <tr>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">모집코드</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">모집</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">구분1</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">학과명</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">구분2</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">구분3</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">원본</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">수정</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">변동</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">작업자</th>
                                    <th colspan="1" style="background-color: <%=BGColor%>; padding: 5px 0px 8px 0px; text-align: center;">수정시각</th>
                                </tr>
                            </thead>
                            <%if Rs1.eof then%>
                                <tbody>
                                    <TR><TD colspan="11" class="content" style="height: 40; text-align: center;">수정 히스토리가 없습니다.<BR>
                                </tbody>
                            <%else%>
                                <tbody>
                                    <%Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, QuorumFix, Quorum, Quorum2, QuorumDIffrence, QuorumDIffrenceTemp, InsertTime, i
                                    Dim RCount
                                    Dim BGColor
                                    BGColor = "#f0f0f0"
                                    RCount = Rs1.pagesize
                                    Rs1.AbsolutePage = GotoPage
                                    Dim QuorumSum, QuorumFixSum, QuorumDIffrenceSum, GWA, ODR, GWABefore, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp, MemberID
                                    ShowSum = false
                                    do Until Rs1.EOF or (RCount = 0 )
                                        RCount = RCount -1
                                        i = i + 1
                                        SubjectCode= Rs1("SubjectCode")
                                        Subject= Rs1("Subject")
                                        Division0= Rs1("Division0")
                                        Division1= Rs1("Division1")
                                        Division2= Rs1("Division2")
                                        Division3= Rs1("Division3")
                                        QuorumFix= getIntParameter(Rs1("QuorumFix"), 0)
                                        Quorum= getIntParameter(Rs1("Quorum"), 0)
                                        Quorum2= getIntParameter(Rs1("Quorum2"), 0)
                                        MemberID= getParameter(Rs1("MemberID"), "")
                                        InsertTime = getParameter(Rs1("InsertTime"), "")
                                        
                                        QuorumDiffrenceTemp=Quorum2
                                        'QuorumDiffrence 폰트 컬러
                                        If Quorum2>0 Then 
                                            QuorumDIffrenceTemp = "+" & QuorumDIffrenceTemp
                                            FontColor="#FF0000"
                                        ElseIf Quorum2=0 Then
                                            QuorumDIffrenceTemp = ""
                                            FontColor="#000000"
                                        ElseIf Quorum2<0 Then
                                            QuorumDIffrenceTemp = QuorumDIffrenceTemp
                                            FontColor="#0000FF"
                                        End If
                                        If BGColor = "#f0f0f0" Then
                                            BGColor = "#fafafa"
                                        Else BGColor = "#fafafa"
                                            BGColor = "#f0f0f0"
                                        End If%>
                                        <tr>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=SubjectCode%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=Division0%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=Division1%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=Subject%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=Division2%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: left; " ><%=Division3%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 5px 5px 5px; text-align: right;" ><%=QuorumFix%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 5px 5px 5px; text-align: right; " ><%=Quorum%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 5px 5px 5px; text-align: right; font-weight:bold; font-color: <%=FontColor%>;" ><font color="<%=FontColor%>"><%=QuorumDIffrenceTemp%></font></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: center; " ><%=MemberID%></td>
                                            <td colspan="1" nowrap style="background-color: <%=BGColor%>; padding: 8px 0px 5px 5px; text-align: center; " ><%=InsertTime%></td>
                                        </tr>
                                        <%Rs1.MoveNext
                                    Loop
                                    Rs1.Close
                                    Set Rs1 = Nothing%>
                                </tbody>
                            <%End If%>
                        </table>
                      </div>

                    </div>
                  </div>

                    <%If totalpage > 1 Then %>
                        <div class="widget-foot" style="background-color: <%=BGColor%>; padding: 0;">
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
              

        <iFrame src="<%=Request.Form("FormSendURL")%>" name="StudentDetailSMSSend" width="0" height="0" border="0" style="width:0; height:0; border: 0;"></iFrame>
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
    function TruncateTable(f){
        if (confirm("모든 히스토리를 삭제 할까요?") ){
            var url = "./process/TruncateTable.asp?table=SubjectTableHistory"
            TruncateFrame.document.location.href=url;
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