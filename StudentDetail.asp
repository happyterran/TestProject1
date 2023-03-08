<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck_popup.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
On Error Resume Next
Dim Width, asdf
Width = Request.QueryString("width")
If width = "" Then width = getParameter(Request.Form("width"), "1024")
asdf = Request.QueryString("asdf")
'Response.Write Width
Width = cint(Width)
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
</script>
</head>
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

<body style="padding-top: 0; padding-left: 0px; padding-right: 0px;" >

<!-- Form area -->
<div id="ui-popup-contents" style="width: <%=Width%>px;height:auto;">
    <div class="matter">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">






<%'############################
'## 지원자 전화기록
'##############################%>
<!-- Widget -->
<div class="widget" style="">
    <div class="widget-head">
        <div class="pull-left">지원자 전화기록 </div>
        <div class="widget-icons pull-right">
            <a href="#" id="registRecord" onclick="PositionChange()" class="wminimize"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
            <a href="#" onclick="initialize();" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div><!-- widget-head -->
    <div class="widget-content" id="registRecordWidgetContent" <%If Session("PositionRegistRecord") = "menu-min" Then%>style="display: none;"<%end if %>>
      <div class="padd invoice" style="padding: 0;">
        <div class="row-fluid">
          <div class="span12">
            <table class="table table-striped table-hover table-bordered" style="table-layout: fixed;">
              <colgroup><col width="4%"></col><col width="5%"></col><col width="12%" class="hidden-phone"></col><col width="6%"></col><col width="6%"></col><col width="5%"></col><col width="8%" class="hidden-phone"></col><col width="" class="hidden-phone"></col><col width="12%"></col><col width="6%"></col><%If Session("Grade")="관리자" Then%><col width="5%"></col><%End If%><!-- <col width="5%"></col> --></colgroup>
              <thead>
                <tr>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">No.</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">차수</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">발신번호</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">받은사람</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">결과</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">라인</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">상담원</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">메모</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">작업시각</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">녹음</th>
	              <%if Session("Grade")="관리자" then%>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">삭제</th>
                  <%End If%>
                  <!-- <th colspan="1" style="text-align: center;">전화</th> -->
                </tr>
              </thead>
              <tbody>
                <%
                Dim PageSize, GotoPage
                PageSize = 3
	            GotoPage = getIntParameter(Request.Form("GotoPage"), 1)
                'Response.Write GotoPage
                Dim TotalPage,RecordCount
                TotalPage   = 1
                RecordCount = 0  
                Dim SaveFile
                'FormStudentNumber = Request.Querystring("FormStudentNumber")
                SaveFile = Request.Form("SaveFile")
                Dim RegistRecordIDX
                RegistRecordIDX = Request.Form("RegistRecordIDX")
                '##############################
                '##지원자 전화기록
                '##############################
                Dim Rs1, StrSql
                if FormStudentNumber <>"" then
                    Set Rs1 = Server.CreateObject("ADODB.Recordset")

                    if SaveFile <>"" Then
                        Dim eDbcon, eStrSql
                        Set eDbcon = Server.CreateObject("ADODB.Connection") 
                        eDbcon.ConnectionTimeout = 30
                        eDbcon.CommandTimeout = 30
                        eDbcon.Open ("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\METIS;Extended Properties=DBASE IV;")
                        '전화명령을 DB로 수행
                        eStrSql =                    "update LINEORDE"
                        eStrSql = eStrSql & vbCrLf & "	set LINEORDER = 'PLAYVOX," & SaveFile & "'"
                        eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
                        eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
                        eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"
                        'Response.Write eStrSql & "<BR>"
                        'response.end
                        eDbcon.Execute(eStrSql)
                        'Dbcon.Execute(StrSql)
                    end if
                    
                    '전화기록 삭제 - 삭제버튼에서 전달받은 IDX값으로 파일 삭제
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

					'전화기록 가져오기
                    StrSql	=		"select a.*, b.*, A.InsertTIme as InsertTimeRegistRecord, a.IDX RegistRecordIDX"
                    StrSql = StrSql & vbCrLf & "from RegistRecord A"
                    StrSql = StrSql & vbCrLf & "join StudentTable B"
                    StrSql = StrSql & vbCrLf & "	on  A.StudentNumber = B.StudentNumber"
                    StrSql = StrSql & vbCrLf & "	and A.SubjectCode = B.SubjectCode"
                    StrSql = StrSql & vbCrLf & "	and A.StudentNumber = '" & FormStudentNumber & "'"
                    StrSql = StrSql & vbCrLf & "	and B.StudentNumber = '" & FormStudentNumber & "'"
                    StrSql = StrSql & vbCrLf & "order by A.IDX desc"

                    'Response.Write StrSql
                    Rs1.Open StrSql, Dbcon, 1, 1
                    '----------------------------------------------------------------------------------
                    ' 전체 페이지와 전체 카운터 설정
                    '----------------------------------------------------------------------------------
                    IF (Rs1.BOF and Rs1.EOF) Then
                        RecordCount = 0 
                        totalpage   = 0
                    Else
                        RecordCount = Rs1.RecordCount
                        Rs1.pagesize = PageSize
                        totalpage   = Rs1.PageCount
                    End if
                    %>
	                <%if Rs1.RecordCount>0 then%>
                        <%Dim Degree, Tel, UsedLine, MemberID, MemberName, Result, Receiver, Memo, InsertTimeRegistRecord, No
                        Dim ResultTempStr, ReceiverTempStr
                        Dim RCount
                        No = 0
                        RCount = Rs1.PageSize
                        Rs1.AbsolutePage = GotoPage
                        do until Rs1.EOF or (RCount = 0 )
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
                            Memo = GetParameter( Rs1("Memo"), "&nbsp;" )
                            If ByteLen(Memo)>80 Then Memo=ByteLeft(Memo,80) & "..."
                            InsertTimeRegistRecord = GetParameter( Rs1("InsertTimeRegistRecord") , "&nbsp;" )
                            if InsertTimeRegistRecord <> "&nbsp;" then InsertTimeRegistRecord = CastDateTime(InsertTimeRegistRecord)
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
                            end select
                            %>
                            <tr>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=No%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Degree%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=Tel%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ReceiverTempStr%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ResultTempStr%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=UsedLine%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=MemberID%></td>
                                <td colspan="1" style="padding: 8px 10px;text-align: left;"   class="hidden-phone"><%=Memo%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=InsertTimeRegistRecord%></td>
                                <td colspan="1" style="padding: 8px 0px; text-align: center;">
                                    <%if SaveFile <>"" Then%>
                                        <a href="/Record/<%=SaveFile%>" target="StudentDetailSMSSend" title="재생">▶</a>
                                        <a href="/RegistRecordFrameSrcStop.asp" target="StudentDetailSMSSend" title="정지">■</a>
                                        <!-- MP3만 가능해서 실패 -->
                                        <!-- 
                                        <a href="/RegistRecordFrameSrcPlay.asp?SaveFile=004038.mp3" target="StudentDetailSMSSend">▶</a>
                                        <a href="/RegistRecordFrameSrcStop.asp?SaveFile=004038.mp3" target="StudentDetailSMSSend">■</a><br>
                                        -->
                                        <!-- MP3만 가능해서 실패 -->
                                        <a href="/Record/<%=SaveFile%>" target="_Blank" title="새 창">◈</span>
                                    <%else%>
                                        없음
                                    <%end if%>
                                </td>
                                <%if Session("Grade")="관리자" then%>
                                <td colspan="1" style="text-align: center; cursor: pointer;"
                                    <%If Session("Grade")="관리자" Then%>
                                        onclick="if(confirm('삭제된 기록은 복구할 수 없습니다. 정말 삭제하시겠습니까?')==true){RegistRecordDelete(<%=RegistRecordIDX%>)}"
                                    <%Elseif Session("FormUsedLine")="" then%>
                                        onClick="alert('전화라인을 선택하지 않았으므로 전화로 듣기를 할 수 없습니다.');"
                                    <%Elseif SaveFile="" then%>
                                        onClick="alert('녹음이 없으므로 전화로 듣기를 할 수 없습니다.');"
                                    <%End If%>
                                    >삭제</td>
                                <%End If%>
                                <!-- <td colspan="1" style="text-align: center; cursor: pointer;" onclick="if(confirm('녹음을 전화로 들으시겠습니까?')==true){RegistRecordSaveFile('<%=FormStudentNumber%><%=Rs1("SaveFile")%>')}">듣기</td> -->
                            </tr>
                            <%Rs1.MoveNext
						    RCount = RCount -1
                        Loop%>
                    <%Else%>
                        <%If Session("Grade")="관리자" Then%>
                            <thead><TR><td colspan="11" style="text-align: center;">전화 기록이 없습니다.</td></TR></thead>
                        <%Else%>
                            <thead><TR><td colspan="10" style="text-align: center;">전화 기록이 없습니다.</td></TR></thead>
                        <%End If%>
                    <%End If
                    Rs1.close
                    Set Rs1=Nothing%>
                <%Else%>
                    <thead><TR><td colspan="11" style="text-align: center;">지원자를 선택하지 않았습니다.</td></TR><thead>
                <%End If%>
              </tbody>
            </table>
          </div><!-- span12 -->
        </div><!-- row-fluid -->
      </div><!-- padd invoice -->
        <FORM METHOD="POST" ACTION="StudentDetail.asp" Name="RegistRecordForm" onsubmit="return false">
        <input type="Hidden" name="FormStudentNumber" value="<%=FormStudentNumber%>">
        <input type="Hidden" name="RegistRecordIDX" value="">
        <input type="Hidden" name="SaveFile" value="">
        <input type="Hidden" name="Width" value="<%=Width%>">
        <input type="Hidden" name="GotoPage" value="<%=GotoPage%>">
        </FORM>
        <script type="text/javascript">
            function RegistRecordDelete(idx){
                var f = document.RegistRecordForm
                f.RegistRecordIDX.value=idx
                f.submit();
            }
            function RegistRecordSaveFile(SaveFile){
                var f = document.RegistRecordForm
                f.SaveFile.value=SaveFile
                f.submit();
            }
        </script>

        <%If totalpage > 0 Then %>
            <div class="widget-foot" style="padding: 0;">
                <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                    <ul>                    
                    <%If GotoPage>1 Then%>
                        <li><a href="javascript: ChangePage(document.RegistRecordForm.GotoPage,<%=GotoPage-1%>)">Prev</a></li>
                    <%Else%>
                        <li><a >Prev</a></li>
                    <%End If%>
                    <%pageViewRegistRecordFrameSrc%>
                    <%If cint(GotoPage)<cint(totalpage) Then%>
                        <li><a href="javascript: ChangePage(document.RegistRecordForm.GotoPage,<%=GotoPage+1%>)">Next</a></li>
                    <%Else%>
                        <li><a >Next</a></li>
                    <%End If%>
                    </ul>
                </div>
                <div class="clearfix"></div> 
            </div><!-- widget-foot -->
        <%End If%>
    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->
<%Sub pageViewRegistRecordFrameSrc()
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
                response.write "<li><a href='javascript: ChangePage(document.RegistRecordForm.GotoPage," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
            End If
        Next
    Else'블럭에 페이지수가 10개 이상이 아닐때
        For i = 1 to (totalpage mod intMyChoice) '전체페이지에서 MyChoice로 나눈 나머지페이지
            q=NowBlock*intMyChoice + i
            If(GotoPage-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='javascript: ChangePage(document.RegistRecordForm.GotoPage," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
            End If
        Next
    End If
End Sub%>
<!-- iFrame RegistRecordFrame -->
<!-- <iframe name="RegistRecordFrame" id="RegistRecordFrame" src="/RegistRecordFrameSrc.asp?FormStudentNumber=<%=FormStudentNumber%>" scrolling=yes frameborder=0 marginwidth=0 marginheight=0 style="width: 100%; height: 235px; border: 0px;"></iframe> -->



<%'############################
'## 지원자 세부정보
'##############################%>
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">지원자 세부정보
            <!-- myModal -->
            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <a href="#myModal" id="myModalButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
                    <h3 id="myModalLabel">경고창 예시입니다.</h3>
                    <!-- myModalButton -->
                </div>
                <div class="modal-body">
                    <p id="myModalMessage">이곳에 문구가 표시됩니다.</p>
                    <input type="Hidden" name="FormTelTemp" value="<%=FormTelTemp%>" >
                </div>
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                </div>
            </div>
        </div>
        <div class="widget-icons pull-right">
            <a href="#" id="StudentDetail" onclick="PositionChangeStudentDetail()"  class="wminimize"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
            <a href="#" onclick="initialize();" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content" id="studentDetailWidgetContent" <%If Session("PositionStudentDetail") = "menu-min" Then%>style="display: none;"<%end if %>>
        <div class="padd invoice" style="padding: 0;">
            <div class="row-fluid">
                <div class="span12">
                    <table class="table table-striped table-hover table-bordered">
                        <%if FormStudentNumber <>"" then
                            Set Rs2 = Server.CreateObject("ADODB.Recordset")
                            StrSql	=          "select A.*, B.*, C.Status, D.Result, E.Degree as DegreeSetting"
                            '기본 정보
                            StrSql = StrSql & vbCrLf & "from StudentTable A"
                            StrSql = StrSql & vbCrLf & "join SubjectTable B"
                            StrSql = StrSql & vbCrLf & "	on A.SubjectCode = B.SubjectCode"   
							'현재 전화 상태
                            StrSql = StrSql & vbCrLf & "left outer join"
                            StrSql = StrSql & vbCrLf & "("
                            StrSql = StrSql & vbCrLf & "	select A.*"
                            StrSql = StrSql & vbCrLf & "	from StatusRecord A"
                            StrSql = StrSql & vbCrLf & "	join"
                            StrSql = StrSql & vbCrLf & "	("
                            StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX"
                            StrSql = StrSql & vbCrLf & "		from StatusRecord"
                            StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                            StrSql = StrSql & vbCrLf & "	) B"
                            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                            StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
                            StrSql = StrSql & vbCrLf & "		and A.StudentNumber = '" & FormStudentNumber & "'"
                            StrSql = StrSql & vbCrLf & ") C"
							StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"							
							'최종 결과 상태
                            StrSql = StrSql & vbCrLf & "left outer join"
                            StrSql = StrSql & vbCrLf & "("
                            StrSql = StrSql & vbCrLf & "	select top 1 StudentNumber, Result"
                            StrSql = StrSql & vbCrLf & "	from RegistRecord"
                            StrSql = StrSql & vbCrLf & "	where StudentNumber='" & FormStudentNumber & "'"
                            StrSql = StrSql & vbCrLf & "	order by idx desc"
                            StrSql = StrSql & vbCrLf & ") D"
                            StrSql = StrSql & vbCrLf & "	on A.StudentNumber =  D.StudentNumber"
                            StrSql = StrSql & vbCrLf & "left outer join Degree2 E"
                            StrSql = StrSql & vbCrLf & "	on B.Division0 = E.Division0"
							
							'학생 추가 연락처 추가
                            'StrSql = StrSql & vbCrLf & "left outer join"
							'StrSql = StrSql & vbCrLf & "("
                            'StrSql = StrSql & vbCrLf & "	select"
							'StrSql = StrSql & vbCrLf & "		A.StudentNumber, A.HP AS Add_HP, A.Tel1 AS Add_Tel1, A.Tel2 AS Add_Tel2, A.Tel3 AS Add_Tel3, A.Tel4 AS Add_Tel4"
							'StrSql = StrSql & vbCrLf & "	from XTEB.XTEB_X11_MJC.dbo.StudentTableContact AS A"
                            'StrSql = StrSql & vbCrLf & "	inner join ("
                            'StrSql = StrSql & vbCrLf & "		select StudentNumber, max(idx) idx , count(*) cnt"
                            'StrSql = StrSql & vbCrLf & "		from XTEB.XTEB_X11_MJC.dbo.StudentTableContact"
                            'StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                            'StrSql = StrSql & vbCrLf & "	) B"
                            'StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                            'StrSql = StrSql & vbCrLf & "		and A.idx = B.idx"
                            'StrSql = StrSql & vbCrLf & ") AS STC"
							'StrSql = StrSql & vbCrLf & "	on A.StudentNumber = STC.StudentNumber"

                            StrSql = StrSql & vbCrLf & "where A.StudentNumber = '" & FormStudentNumber & "'"
                            'PrintSql( StrSql)
							'Response.end
                            Rs2.Open StrSql, Dbcon, 1, 1
                            if Rs2.RecordCount>0 then%>
                                <%'Dim IDX,DivisionCode,StudentName,Ranking,Score,Tel1,Tel2,Tel3,SubjectCode,InsertTime,DivisionCodeName
                                Dim StudentName, Ranking, Score, Tel1, Tel2, Tel3, SubjectCode, Division0, Division1, Division2, Division3, Division, RegistrationFee, InsertTime, Subject, Status, Citizen1, Citizen2, ETC1, ETC2, ETC3, AccountNumber, Address
                                Dim Tel4, Tel5
								'Dim Add_HP, Add_Tel1, Add_Tel2, Add_Tel3, Add_Tel4
                                StudentName = Rs2("StudentName")
                                Ranking = Rs2("Ranking")
                                Score = GetParameter(Rs2("Score"),"&nbsp;")
                                Tel1 = GetParameter(Rs2("Tel1"),"")
                                Tel2 = GetParameter(Rs2("Tel2"),"")
                                Tel3 = GetParameter(Rs2("Tel3"),"")
                                Tel4 = GetParameter(Rs2("Tel4"),"")
                                Tel5 = GetParameter(Rs2("Tel5"),"")
                                SubjectCode = Rs2("SubjectCode")
                                '수험번호 검색으로 지원자에게 접근했을 경우 모집단위코드 적용
                                Session("FormSubjectCode") = SubjectCode
                                'response.write Session("FormSubjectCode")
                                RegistrationFee = Rs2("RegistrationFee")
                                if RegistrationFee>0 then RegistrationFee=FormatCurrency(RegistrationFee)
                                RegistrationFee = GetParameter(RegistrationFee,"&nbsp;")
                                'Session("RegistrationFee") = RegistrationFee
                                InsertTime = Rs2("InsertTime")
                                InsertTime = GetParameter(CastDateTime(InsertTime),"&nbsp;")
                                Subject = GetParameter(Rs2("Subject"),"&nbsp;")
                                Status = GetIntParameter(Rs2("Status"),1)
                                Result = GetIntParameter(Rs2("Result"),1)
                                Citizen1 = GetParameter(Rs2("Citizen1"),"&nbsp;")
                                Citizen2 = GetParameter(Rs2("Citizen2"),"")
                                ETC1 = GetParameter(Rs2("ETC1"),"&nbsp;")
                                ETC2 = GetParameter(Rs2("ETC2"),"&nbsp;")
                                ETC3 = GetParameter(Rs2("ETC3"),"&nbsp;")
                                AccountNumber = GetParameter(Rs2("AccountNumber"),"&nbsp;")
								Address = GetParameter(Rs2("Address"),"")
                                'Session("AccountNumber") = AccountNumber

								'// 타대학합격자 포기결과 입력
								'// 타대학 합격자이고 결과값이 없는 학생을 대상으로 타대학 합격 포기 처리
								If ETC2 = "타대학합격" And Result = 1 Then
								%>
								<script type="text/javascript">
									$( document ).ready(function() {
										//최종결과 포기예정자 자동포기처리
										$('input:radio[name=FormReceiver]:input[value='+5+']').attr("checked", true);
										$('input:radio[name=FormResult]:input[value='+3+']').attr("checked", true);
										$('input[name=FormCommand]').val("END");
										$("textarea[name=FormMemo]").attr("value", "타대학 합격 포기처리");
										document.RegistRecordInsert.submit();
										alert('타대학 합격자이므로 포기 처리되었습니다.');
									});
								</script>
								<%
								End If

                                if Subject <>"" then Subject = " " & Subject
                                Division0 = Rs2("Division0")
                                if Division0 <>"" then Division0 = " " & Division0
                                Division1 = Rs2("Division1")
                                if Division1 <>"" then Division1 = " " & Division1
                                Division2 = Rs2("Division2")
                                if Division2 <>"" then Division2 = " " & Division2
                                Division3 = Rs2("Division3")
                                if Division3 <>"" then Division3 = " " & Division3
                                
                                Dim StatusTempStr
                                '전화상태
                                select case Status
                                    case 1
                                        StatusTempStr = "전화가능"
                                    case 2
                                        StatusTempStr = "전화중"
                                    case 3
                                        StatusTempStr = "녹음중"
                                end select
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
                                Session("FormDegree") = getParameter(Rs2("DegreeSetting"),"")
								Rs2.Close
								Set Rs2=Nothing
								
								%>
                                <%'=Session("FormDegree")%>
                                
								<!--
								<thead>
                                <tr>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">석차</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">수험번호</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">이름</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">주민등록번호</th>
                                    <th colspan="2" style="padding: 8px 0px; text-align: center;" class="hidden-phone">가상계좌번호</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">등록금</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">등록기한</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Ranking%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=FormStudentNumber%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=StudentName%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Citizen1 & " - " & left(Citizen2,1)%>*******</td>
                                    <td colspan="2" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=AccountNumber%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=RegistrationFee%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Session("RegistrationTime")%></td>
                                </tr>
                                </tbody>
								-->

								<thead>
                                <tr>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">석차</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">수험번호</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">이름</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">주민등록번호</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">가상계좌번호</th>
									<th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">등록기한</th>
                                    <th colspan="2" style="padding: 8px 0px; text-align: center; max-width:280px;">주소</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Ranking%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=FormStudentNumber%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=StudentName%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Citizen1 & " - " & left(Citizen2,1)%>*******</td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=AccountNumber%></td>
									<td colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=Session("RegistrationTime")%></td>
                                    <td colspan="2" style="padding: 8px 0px; text-align: center; max-width:280px;"><%=Address%></td>
                                </tr>
                                </tbody>

                                <thead>
                                <tr>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;">최종결과</th>
                                    <th colspan="3" style="padding: 8px 0px; text-align: center; border-top: 0;;" class="hidden-phone">지원학과</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">평가점수</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">기타정보1</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">기타정보2</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">기타정보3</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ResultTempStr%></td>
                                    <td colspan="3" style="padding: 8px 0px; text-align: center;" class="hidden-phone"><%=Division0 & Subject & Division1 & Division2 & Division3%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=Score%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ETC1%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ETC2%></td>
                                    <td colspan="1" style="padding: 8px 0px; text-align: center;"><%=ETC3%></td>
                                </tr>
                                </tbody>
                            <%Else%>
                                <tbody>
                                <tr>
                                    <td colspan="6" style="padding: 8px 0px; text-align: center;">지원자 세부정보가 없습니다</td>
                                </tr>
                                </tbody>
                            <%End If
                            'Rs2.Close
                            'Set Rs2=Nothing%>
                        <%Else%>
                            <tbody>
                            <tr>
                            <td colspan="6" style="padding: 8px 0px; text-align: center;">지원자를 선택하지 않았습니다</td>
                            </tr>
                            </tbody>
                        <%End If%>
                    </table>
                </div><!-- span12 -->
            </div><!-- row-fluid -->
        </div><!-- padd invoice -->
    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->










<%'############################
'## 복수지원 정보
'##############################
Dim DuplicateRecordCount
DuplicateRecordCount = 0%>
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">복수지원 정보</div>
        <div class="widget-icons pull-right">
            <a href="#" id="pluralRecord" onclick="PositionChangePluralRecord()"  class="wminimize"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
            <a href="#" onclick="initialize();" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content" id="pluralRecordWidgetContent" <%If Session("PositionPluralRecord") = "menu-min" Then%>style="display: none;"<%end if %>>
        <div class="padd invoice" style="padding: 0;">
            <div class="row-fluid">
                <div class="span12">
                    <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 결과</th>
                                <th colspan="3" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 학과</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 점수</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 수험번호</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 석차</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">복수지원 커트라인</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%Dim GotoPagePlural
                        PageSize = 3
                        GotoPagePlural = getIntParameter(Request.Querystring("GotoPagePlural"), 1)
                        TotalPage   = 1
                        'Dim Citizen1, Citizen2, SubjectCode, Status
                        'Citizen1	 = GetParameter(Request.Querystring("Citizen1"), "")
                        'Citizen2	 = GetParameter(Request.Querystring("Citizen2"), "")
                        'SubjectCode = GetParameter(Request.Querystring("SubjectCode"), "")
                        'Status       = GetParameter(Request.Querystring("Status"), "")
                        'Dim Rs2, StrSql
                        Set Rs2 = Server.CreateObject("ADODB.Recordset")

                        StrSql =                   "select *"
                        StrSql = StrSql & vbCrLf & "from"
                        
						'// 학생 정보 가져오기
						StrSql = StrSql & vbCrLf & "("
                        StrSql = StrSql & vbCrLf & "	select *"
                        StrSql = StrSql & vbCrLf & "	from StudentTable"
                        StrSql = StrSql & vbCrLf & "	where Citizen1='" & Citizen1 & "'"
                        StrSql = StrSql & vbCrLf & "	and Citizen2='" & Citizen2 & "'"
                        StrSql = StrSql & vbCrLf & "	and StudentName='" & StudentName & "'"
                        StrSql = StrSql & vbCrLf & "	and SubjectCode<>'" & SubjectCode & "'"
                        StrSql = StrSql & vbCrLf & ") a"
                        StrSql = StrSql & vbCrLf & "inner join"
                        StrSql = StrSql & vbCrLf & "("
						
						'// 지원 학과(모집단위) 가져오기
                        StrSql = StrSql & vbCrLf & "		select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
                        StrSql = StrSql & vbCrLf & "		, Quorum - isnull(r.RegistCount,0) - isnull(rp.RegistPlanCount,0) Remain"
                        StrSql = StrSql & vbCrLf & "		, Quorum + isnull(b.AbadonCount,0) + isnull(c.NonRegistCount,0) + isnull(d.RefundCount,0) - isnull(z.ZeroCount,0) RankingCutLine"
                        StrSql = StrSql & vbCrLf & "		, Quorum"
                        StrSql = StrSql & vbCrLf & "		, isnull(r.RegistCount,0) RegistCount"
                        StrSql = StrSql & vbCrLf & "		, isnull(rp.RegistPlanCount,0) RegistPlanCount"
                        StrSql = StrSql & vbCrLf & "		, isnull(b.AbadonCount,0) AbadonCount"
                        StrSql = StrSql & vbCrLf & "		, isnull(c.NonRegistCount,0) NonRegistCount"
                        StrSql = StrSql & vbCrLf & "		, isnull(d.RefundCount,0) RefundCount"
                        StrSql = StrSql & vbCrLf & "		, isnull(e.Refund2Count,0) Refund2Count"
                        StrSql = StrSql & vbCrLf & "		, isnull(z.ZeroCount,0) ZeroCount"
                        StrSql = StrSql & vbCrLf & "		from SubjectTable a"
                        '// 등록완료 카운트
						StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistCount"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 2"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) r"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = r.SubjectCode"
						'// 포기 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as AbadonCount"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								where Degree <=255"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 3"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) b"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = b.SubjectCode"
						'// 등록예정 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RegistPlanCount"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								where Degree <=255"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 6"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) rp"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = rp.SubjectCode"
						'// 미등록 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as NonRegistCount"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								where Degree <=255"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 7"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) c"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = c.SubjectCode"
						'// 환불 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as RefundCount"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								where Degree <=255"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 10"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) d"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = d.SubjectCode"
						'// result = 11(??) 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select C.SubjectCode, A.Result, isnull(count(*),0) as Refund2Count"
                        StrSql = StrSql & vbCrLf & "				   from RegistRecord A"
                        StrSql = StrSql & vbCrLf & "				   inner join"
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, max(IDX) as MaxIDX "
                        StrSql = StrSql & vbCrLf & "								from RegistRecord"
                        StrSql = StrSql & vbCrLf & "								where Degree <=255"
                        StrSql = StrSql & vbCrLf & "								group by StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   ) B"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = B.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.IDX = B.MaxIDX"
                        StrSql = StrSql & vbCrLf & "				   inner join "
                        StrSql = StrSql & vbCrLf & "				   ("
                        StrSql = StrSql & vbCrLf & "								select StudentNumber, SubjectCode"
                        StrSql = StrSql & vbCrLf & "								from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   ) C"
                        StrSql = StrSql & vbCrLf & "				   on A.StudentNumber = C.StudentNumber"
                        StrSql = StrSql & vbCrLf & "				   and A.SubjectCode = C.SubjectCode"
                        StrSql = StrSql & vbCrLf & "				   where result = 11"
                        StrSql = StrSql & vbCrLf & "				   group by C.SubjectCode, A.Result"
                        StrSql = StrSql & vbCrLf & "		) e"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = e.SubjectCode"
						'// ranking이 0인 학생 카운트
                        StrSql = StrSql & vbCrLf & "		left outer join"
                        StrSql = StrSql & vbCrLf & "		("
                        StrSql = StrSql & vbCrLf & "				   select SubjectCode, isnull(count(*),0) as ZeroCount"
                        StrSql = StrSql & vbCrLf & "				   from StudentTable"
                        StrSql = StrSql & vbCrLf & "				   where ranking=0"
                        StrSql = StrSql & vbCrLf & "				   group by SubjectCode"
                        StrSql = StrSql & vbCrLf & "		) z"
                        StrSql = StrSql & vbCrLf & "		on a.SubjectCode = z.SubjectCode"

                        StrSql = StrSql & vbCrLf & ") b"
                        StrSql = StrSql & vbCrLf & "on A.SubjectCode = b.SubjectCode"
                        
						'// 결과 내역 가져오기
						StrSql = StrSql & vbCrLf & "left outer join "
                        StrSql = StrSql & vbCrLf & "("
                        StrSql = StrSql & vbCrLf & "	select CR.StudentNumber StudentNumberRegistRecord, CR.Result"
                        StrSql = StrSql & vbCrLf & "	from RegistRecord CR "
                        StrSql = StrSql & vbCrLf & "	inner join "
                        StrSql = StrSql & vbCrLf & "	("
                        StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount , max(SaveFile) as MaxSaveFile"
                        StrSql = StrSql & vbCrLf & "		from RegistRecord "
                        StrSql = StrSql & vbCrLf & "		group by StudentNumber "
                        StrSql = StrSql & vbCrLf & "	) CRG"
                        StrSql = StrSql & vbCrLf & "	on CR.StudentNumber = CRG.StudentNumber "
                        StrSql = StrSql & vbCrLf & "	and CR.IDX = CRG.MaxIDX "
                        StrSql = StrSql & vbCrLf & ") c"
                        StrSql = StrSql & vbCrLf & "on A.StudentNumber = c.StudentNumberRegistRecord"
                        '순위 밖 지원자 보이지 않는 옵션
                        'StrSql = StrSql & vbCrLf & "where Ranking <= RankingCutLine"
                        StrSql = StrSql & vbCrLf & "order by A.StudentNumber asc"
                        'PrintSql( StrSql)
                        'Response.end
                        Rs2.Open StrSql, Dbcon, 1, 1
                        '----------------------------------------------------------------------------------
                        ' 전체 페이지와 전체 카운터 설정
                        '----------------------------------------------------------------------------------
                        IF (Rs2.BOF and Rs2.EOF) Then
                            DuplicateRecordCount = 0 
                            totalpage   = 0
                        Else
                            DuplicateRecordCount = Rs2.RecordCount
                            Rs2.pagesize = PageSize
                            totalpage   = Rs2.PageCount
                        End if
                        Dim PluralSubjects, PluralSubjectCode, PluralRanking, PluralScore, PluralResult, PluralResultTempStr
                        Dim PluralDivision0, PluralSubject, PluralDivision1, PluralDivision2, PluralDivision3
                        Dim RankingCutLine, Quorum, ZeroCount
                        PluralStudentNumber=""
                        If Rs2.EOF = FALSE Then
						'if FALSE Then
                            RCount = Rs2.PageSize
                            Rs2.AbsolutePage = GotoPagePlural
                            Do Until Rs2.EOF or (RCount = 0 )
                                PluralDivision0 = GetParameter(Rs2("Division0"), "")
                                PluralSubject		= GetParameter(Rs2("Subject"), "")
                                PluralDivision1 = GetParameter(Rs2("Division1"), "")
                                PluralDivision2 = GetParameter(Rs2("Division2"), "")
                                PluralDivision3 = GetParameter(Rs2("Division3"), "")
                                PluralSubjects	= PluralDivision0 & " " & PluralSubject & " " & PluralDivision1 & " " & PluralDivision2 & " " & PluralDivision3
                                PluralSubjectCode = GetParameter(Rs2("SubjectCode"), "")
                                PluralStudentNumber = GetParameter(Rs2("StudentNumber"), "")
                                PluralRanking = GetIntParameter(Rs2("Ranking"), 0)
                                PluralScore = GetParameter(Rs2("Score"), "")
                                PluralResult = GetIntParameter(Rs2("Result"), 1)
                                Quorum			= GetIntParameter(Rs2("Quorum"), 0)
                                RankingCutLine = GetIntParameter(Rs2("RankingCutLine"), 0)
                                ZeroCount = GetIntParameter(Rs2("ZeroCount"), 0)
                                '결과
                                select case PluralResult
                                    case 1
                                        PluralResultTempStr = "추가합격"
                                    case 2
                                        PluralResultTempStr = "등록완료"
                                    case 3
                                        PluralResultTempStr = "포기"
                                    case 4
                                        PluralResultTempStr = "미결정"
                                    case 5
                                        PluralResultTempStr = "미연결"
                                    case 6
                                        PluralResultTempStr = "등록예정"
                                    case 7
                                        PluralResultTempStr = "미등록"
                                    case 8
                                        PluralResultTempStr = ""
                                    case 9
                                        PluralResultTempStr = ""
                                    case 10
                                        PluralResultTempStr = "환불"
                                end Select
                                If PluralRanking > RankingCutLine Then
                                    'PluralResultTempStr = "순위 밖"
									PluralResultTempStr = ""
                                End If
                                if PluralResult = 1 and PluralRanking <= Quorum - ZeroCount then
                                    PluralResultTempStr = "최초합격"
                                End If%>
                                <tr>
                                    <td colspan="1" style="text-align: center;"><%=PluralResultTempStr%></td>
                                    <%If Session("Grade")="관리자" Then%>
                                    <td colspan="3" style="text-align: center; cursor: pointer;" onClick="StudentDetailChangeSubject(StudentDetailChangeSubjectForm, '<%=StatusTempStr%>', '<%=PluralStudentNumber%>', '<%=PluralDivision0%>', '<%=PluralSubject%>', '<%=PluralDivision1%>', '<%=PluralDivision2%>', '<%=PluralDivision3%>')" onMouseOver="style.cursor='hand';this.style.backgroundColor='#EEEEEE';" onMouseOut="this.style.backgroundColor='#f9f9f9';" ><%=PluralSubjects%></td>
                                    <%Else%>
                                    <td colspan="3" style="text-align: center;"><%=PluralSubjects%></td>
                                    <%End If%>
                                    <td colspan="1" style="text-align: center;"><%=PluralScore%></td>
                                    <td colspan="1" style="text-align: center;"><%=PluralStudentNumber%></td>
                                    <td colspan="1" style="text-align: center;"><%=PluralRanking%></td>
                                    <td colspan="1" style="text-align: center;"><%=RankingCutLine%></td>
                                </tr>
                                <%Rs2.MoveNext
                                RCount = RCount -1
                            Loop%>
                        <%Else%>
                            <TR><TD colspan="12" style="text-align: center;">복수지원 없음</TD></TR>
                        <%End If
                        Rs2.close
                        Set Rs2=Nothing%>
                        </tbody>


                    </table>
                </div><!-- span12 -->
            </div><!-- row-fluid -->
        </div><!-- padd invoice -->
        

        <%If totalpage > 1 Then %>
            <div class="widget-foot" style="padding: 0;">
                <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                    <ul>
                    <%If GotoPagePlural>1 Then
                        Response.Write "<li><a href='StudentDetail.asp?GotoPagePlural="&(GotoPagePlural-1)&"&FormStudentNumber=" & FormStudentNumber & "'>Prev</a></li>"
                        Else
                        Response.Write "<li><a >Prev</a></li>"
                    End If%>
                    <%pageViewPluralFrameSrc%>
                    <%If cint(GotoPagePlural)<cint(totalpage) Then
                        response.write "<li><a href='StudentDetail.asp?GotoPagePlural="&(GotoPagePlural+1)&"&FormStudentNumber=" & FormStudentNumber & "'>Next</a></li>"
                        Else
                        Response.Write "<li><a >Next</a></li>"
                    End If%>
                    </ul>
                </div>
                <div class="clearfix"></div> 
            </div><!-- widget-foot -->
        <%End If%>

    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->
<%Sub pageViewPluralFrameSrc()
    Dim intMyChoice,TotalBlock,i,NowBlock,q
    intMyChoice=10
    If totalpage > 0 then
        TotalBlock = int((totalpage-1)/intMyChoice) '전체블럭수 (블럭은 0부터 시작)
        NowBlock = int((GotoPagePlural-1)/intMyChoice) '현재블럭수
    end if
    If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'블럭에 페이지수가 10개 이상일때
        For i = 1 to intMyChoice
            q=NowBlock*intMyChoice + i
            If(GotoPagePlural-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='StudentDetail.asp?GotoPagePlural="&((NowBlock*intMyChoice)+i)&"&FormStudentNumber=" & FormStudentNumber & "'>"&q&"</A></li>"
            End If
        Next
    Else'블럭에 페이지수가 10개 이상이 아닐때
        For i = 1 to (totalpage mod intMyChoice) '전체페이지에서 MyChoice로 나눈 나머지페이지
            q=NowBlock*intMyChoice + i
            If(GotoPagePlural-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='StudentDetail.asp?GotoPagePlural="&((NowBlock*intMyChoice)+i)&"&FormStudentNumber=" & FormStudentNumber & "'>"&q&"</A></li>"
            End If
        Next
    End If
End Sub%>
<!-- iFrame PluralFrame -->
<!-- <iframe name="PluralFrame" id="PluralFrame" src="/StudentDetailPlural.asp?Citizen1=<%=Citizen1%>&Citizen2=<%=Citizen2%>&SubjectCode=<%=SubjectCode%>&Status=<%=Status%>" style="width: 100%; height: 250px; border: 0px;"></iframe> -->
<%If cint(DuplicateRecordCount)>0 Then%>
	<SCRIPT LANGUAGE="JavaScript">//$(window).load(setTimeout(function(){$("#myModalLabel").text("지원자 전화제어");$("#myModalMessage").html("복수지원이 존재하는 지원자 입니다.<br>작업에 주의해 주세요");$("#myModalButton").click();}, 1000))</SCRIPT>
    <script language='javascript'>$(window).load(setTimeout(function(){noty({text: '복수지원이 존재하는 지원자 입니다. 작업에 주의해 주세요&nbsp;',layout:'top',type:'error',timeout:3000})}, 1000));</script>
	<%'Session("PluralStudentNumber") = PluralStudentNumber
End If%>


<%'############################
'## 전화제어 & 결과입력
'##############################%>
<!-- Widget -->
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">지원자 전화제어</div>
            <div class="widget-icons pull-right">
                <a href="#" onclick="initialize();" class="wminimize"><i class="icon-chevron-up"></i></a> 
                <a href="#" onclick="initialize();" class="wclose"><i class="icon-remove"></i></a>
            </div>  
        <div class="clearfix"></div>
    </div>
    <div class="widget-content">

        <div class="padd invoice" style="padding: 0;">
            <div class="row-fluid">
                <div class="span12">
                    <table class="table table-striped table-hover table-bordered " style="table-layout: fixed;" >
                        <colgroup><col width="14%" class="hidden-phone"></col><col width="14%"></col><col width="14%"></col><col width="14%"></col><col width="13%"></col><col width="10%" class="hidden-phone "></col><col width="" class="hidden-phone"></col><col width="10%"></col></colgroup>
                        <thead>
                            <tr>
                                <th colspan="1" style="text-align: center;" class="hidden-phone">전화상태</th>
                                <th colspan="1" style="text-align: center;">전화1</th>
                                <th colspan="1" style="text-align: center;">전화2</th>
                                <th colspan="1" style="text-align: center;">전화3</th>
                                <th colspan="1" style="text-align: center;">전화4</th>
                                <th colspan="1" style="text-align: center;" class="hidden-phone ">전화5</th>
                                <th colspan="1" style="text-align: center;" class="hidden-phone">임시전화</th>
                                <td colspan="1" style="text-align: center;">녹음취소</th>
                            </tr>
                        </thead>
                        <FORM METHOD="POST" ACTION="StudentDetailDial.asp" Name="DialForm" onsubmit="return false">
                        <input type="Hidden" name="FormStudentNumber" value="<%=FormStudentNumber%>">
                        <input type="Hidden" name="FormCommand" value="<%=FormCommand%>">
                        <input type="Hidden" name="FormDialedTel" value="<%=FormDialedTel%>">
                        <input type="Hidden" name="FormReceiver" value="<%=FormReceiver%>">
                        <input type="Hidden" name="FormResult" value="<%=FormResult%>">
                        <input type="Hidden" name="FormMemo" value="<%=FormMemo%>">
                        <input type="Hidden" name="FormRecorded" value="<%=FormRecorded%>">
                        <input type="Hidden" name="PluralAbandon" value="<%=Request.Cookies("Metis")("PluralAbandon")%>">
                        <tbody>
                            <tr>
                                <td colspan="1" style="text-align: center; " class="hidden-phone">
                                    <%If StatusTempStr="전화중" Then%><blink><FONT COLOR="RED"><B><%=StatusTempStr%></blink></B></FONT>
                                    <%ElseIf StatusTempStr="녹음중" Then%><blink><FONT COLOR="RED"><B><%=StatusTempStr%></blink></B></FONT>
                                    <%Else%><b><%=StatusTempStr%></b>
                                    <%End If%>
                                </td>
                                <td colspan="1" style="text-align: center; cursor: pointer; padding: 1px 1px 1px 1px; margin:0;"><input type="button" class="btn" style="width:100%; height: 29px; font-size: 22px;" onclick="StudentDetailDial(DialForm,'DIAL','<%=Tel1%>','<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');" value="<%=Tel1%>"></td>
                                <td colspan="1" style="text-align: center; cursor: pointer; padding: 1px 1px 1px 1px; margin:0;"><input type="button" class="btn" style="width:100%; height: 29px; font-size: 22px;" onclick="StudentDetailDial(DialForm,'DIAL','<%=Tel2%>','<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');" value="<%=Tel2%>"></td>
                                <td colspan="1" style="text-align: center; cursor: pointer; padding: 1px 1px 1px 1px; margin:0;"><input type="button" class="btn" style="width:100%; height: 29px; font-size: 22px;" onclick="StudentDetailDial(DialForm,'DIAL','<%=Tel3%>','<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');" value="<%=Tel3%>"></td>
                                <td colspan="1" style="text-align: center; cursor: pointer; padding: 1px 1px 1px 1px; margin:0;"><input type="button" class="btn" style="width:100%; height: 29px; font-size: 22px;" onclick="StudentDetailDial(DialForm,'DIAL','<%=Tel4%>','<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');" value="<%=Tel4%>"></td>
                                <td colspan="1" style="text-align: center; cursor: pointer; padding: 1px 1px 1px 1px; margin:0;"><input type="button" class="btn" style="width:100%; height: 29px; font-size: 22px;" onclick="StudentDetailDial(DialForm,'DIAL','<%=Tel5%>','<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');" value="<%=Tel5%>"></td>
                                <td colspan="1" style="text-align: center; padding: 1px 0px 0px 0px; margin:0;" class="hidden-phone">
                                    <div id="" class="input-append" style="padding: 0; margin:0;">
                                        <input type="text" name="FormTelTemp" value="<%=FormTelTemp%>" maxlength="15" style="width: 60%; height: 19px;" onkeydown="enterKeyDown(DialForm,'DIAL',this.value,'<%=Session("FormUsedLine")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');">
                                        <span class="add-on" style="cursor: pointer;  height: 19px;" onclick="StudentDetailDial(DialForm,'DIAL',DialForm.FormTelTemp.value,'<%=Session("FormUsedLine")%>',<%=Session("RankingCutLine")%>,<%=Ranking%>);" >
                                            <i class="icon-phone"></i>
                                        </span>
                                    </div>
                                </td>
                                <td colspan="1" style="text-align: center; padding: 1px 0px 0px 0px; margin:0;">
                                    <button type="button" class="btn" style="width: 90%; padding:0,2,0,2px; " onclick="StudentDetailReload(DialForm);return false;">녹음취소</button>
                                </th>
                            </tr>





                        </tbody>
                        </FORM>
                        <FORM METHOD="POST" ACTION="StudentDetailDial.asp" Name="RegistRecordInsert" onsubmit="return false">
                        <input type="Hidden" name="FormStudentNumber" value="<%=FormStudentNumber%>">
                        <input type="Hidden" name="FormCommand" value="<%=FormCommand%>">
                        <input type="Hidden" name="FormDialedTel" value="<%=FormDialedTel%>">
                        <input type="Hidden" name="FormRecorded" value="<%=FormRecorded%>">
                        <input type="Hidden" name="PluralSubject" value="<%=PluralSubject%>">
                        <input type="Hidden" name="PluralSubjectCode" value="<%=PluralSubjectCode%>">
                        <input type="Hidden" name="PluralStudentNumber" value="<%=PluralStudentNumber%>">
                        <input type="Hidden" name="PluralRanking" value="<%=PluralRanking%>">
                        <input type="Hidden" name="PluralScore" value="<%=PluralScore%>">
                        <%
                        Set Rs2 = Server.CreateObject("ADODB.Recordset")
                        StrSql =		"select *"
                        StrSql = StrSql & vbCrLf & "from"
                        StrSql = StrSql & vbCrLf & "("
                        StrSql = StrSql & vbCrLf & "select *"
                        StrSql = StrSql & vbCrLf & "from StudentTable"
                        StrSql = StrSql & vbCrLf & "where Citizen1='" & Citizen1 & "'"
                        StrSql = StrSql & vbCrLf & "and Citizen2='" & Citizen2 & "'"
                        StrSql = StrSql & vbCrLf & "and StudentNumber<>'" & FormStudentNumber & "'"
                        StrSql = StrSql & vbCrLf & ") a"
                        StrSql = StrSql & vbCrLf & "join SubjectTable b"
                        StrSql = StrSql & vbCrLf & "on A.SubjectCode = b.SubjectCode"
                        'Response.write StrSql
                        'Response.End
                        Rs2.Open StrSql, Dbcon
                        If Rs2.EOF = false Then
                            PluralSubject = GetParameter(Rs2("Division0") & " " & Rs2("Subject") & " " & Rs2("Division1") & " " & Rs2("Division2") & " " & Rs2("Division3"), "&nbsp;")
                            PluralSubjectCode = GetParameter(Rs2("SubjectCode"), "")
                            PluralStudentNumber = GetParameter(Rs2("StudentNumber"), "")
                            PluralRanking = GetParameter(Rs2("Ranking"), "")
                            PluralScore = GetParameter(Rs2("Score"), "")
                        End If
                        'Response.write PluralStudentNumber
                        Rs2.Close

						'자동포기 설정값 구하기
						StrSql = "select top 1 * From SettingTable order by IDX desc"
						Rs2.Open StrSql, Dbcon
						Dim AutoAbandon, PluralAbandon
						AutoAbandon = getParameter( Rs2("AutoAbandon") , "" )
						Rs2.Close

                        Set Rs2 = Nothing%>
                        <thead>
                            <tr>
                                <th colspan="1" style="text-align: center; border-top: 0;">받은사람</th>
                                <th colspan="1" style="text-align: center; border-top: 0;">결과</th>
                                <th colspan="1" style="text-align: center; border-top: 0;">저장</th>
								<%If Session("Grade") ="관리자" Or AutoAbandon = 1 Then%>
                                <th colspan="1" style="text-align: center; border-top: 0;" class="hidden-phone ">자동반영</th>
                                <th colspan="2" style="text-align: center; border-top: 0;" class="hidden-phone">메모</th>
                                <%else%>
								<th colspan="3" style="text-align: center; border-top: 0;" class="hidden-phone">메모</th>
								<%End if%>
								<th colspan="2" style="text-align: center; border-top: 0;">SMS발송</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="1" style="text-align: center; ">
                                    <label><input type="radio" name="FormReceiver" value="2" <%If FormReceiver = 2 Then Response.Write "checked"%> />지원자</label>
                                    <label><input type="radio" name="FormReceiver" value="3" <%If FormReceiver = 3 Then Response.Write "checked"%> />부모&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormReceiver" value="4" <%If FormReceiver = 4 Then Response.Write "checked"%> />가족&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormReceiver" value="5" <%If FormReceiver = 5 Then Response.Write "checked"%> />기타&nbsp;&nbsp;&nbsp;</label>
                                </td>
                                <td colspan="1" style="text-align: center; padding: 6px 1px 0px 1px; margin:0;">
                                    <label><input type="radio" name="FormResult" value="6" <%If FormResult = 6 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />등록예정</label>
                                    <label><input type="radio" name="FormResult" value="3" <%If FormResult = 3 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />포기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="4" <%If FormResult = 4 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />미결정&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="5" <%If FormResult = 5 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />미연결&nbsp;&nbsp;&nbsp;</label>
                                    <%If Session("Grade")="관리자" Then%>
                                    <label><input type="radio" name="FormResult" value="2" <%If FormResult = 2 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />등록완료</label>
                                    <label><input type="radio" name="FormResult" value="7" <%If FormResult = 7 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />미등록&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="10" <%If FormResult = 10 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />환불&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <%End If%>
                                </td>
                                <td colspan="1" style="text-align: center; padding: 8px 1px 0px 1px; margin:0; <%If Session("Grade") ="관리자" Then%>padding-top: 30px;<%End If%>">
                                    <button type="button" class="btn" style="width: 75%; height: 95px; " onclick="StudentDetailRegistRecordInsert(document.RegistRecordInsert,'<%=Session("Grade")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');">결과입력</button>
                                </td>
                                <!-- 관리자는 선택적으로 자동반영 체크가능... 상담원은 설정값 강제반영. -->
								<%If Session("Grade") ="관리자" Then '관리자일 경우 선택 가능%>
									<td colspan="1" style="text-align: center; padding: 6px 0px 0px 0px; margin:0;" class="hidden-phone ">
										<FONT COLOR="red">자동반영을 체크하고<BR>녹음중에 등록예정을<BR>입력하면 복수전형중<BR>녹취결과가 등록예정인<BR>전형은 자동으로 포기<BR>처리되고 입력됩니다.<BR></FONT>
										<LABEL FOR="자동반영" style=""><input type="checkbox" name="PluralAbandon" value="3" <%if Request.Cookies("METIS")("PluralAbandon") = "3" then Response.write "checked"%> onchange="if(RegistRecordInsert.PluralAbandon.checked){DialForm.PluralAbandon.value='3'}else{DialForm.PluralAbandon.value=''}" id="자동반영">자동반영</LABEL>
									</td>
									<td colspan="2" style="text-align: center; padding: 7px 1px 0px 1px; padding-top: 32px; margin:0;" class="hidden-phone">
										<textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
									</td>
								<%Else '상담원일 경우 환경설정 값에 따름%>
									<%If AutoAbandon = 1 Then '자동포기 설정 시 안내문구와 메모 노출%>
										<td colspan="1" style="text-align: center; padding: 6px 0px 0px 0px; margin:0;" class="hidden-phone ">
											<FONT COLOR="red">녹음중에 등록예정을<BR>입력하면 복수전형중<BR>녹취결과가 등록예정인<BR>전형은 자동으로 포기<BR>처리되고 입력됩니다.<BR></FONT>
											<input type="Hidden" name="PluralAbandon" value="3">
										</td>
										<td colspan="2" style="text-align: center; padding: 7px 1px 0px 1px; margin:0;" class="hidden-phone">
										 <textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
										</td>
									<%Else '자동포기 미설정 시 메모만 노출%>
										<td colspan="3" style="text-align: center; padding: 7px 1px 0px 1px; margin:0;" class="hidden-phone">
										 <input type="Hidden" name="PluralAbandon" value="0">
										 <textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
										</td>
									<%End If%>
								<%End If%>
								<td colspan="2" style="text-align: center; padding: 6px 1px 0px 1px; margin:0;">
                                    <input type="text" name="FormSMSTelTemp" size="11" maxlength="15" style="font-family:돋움; border:1 solid silver; width: 77%; margin: 0; background-image: none; height: 16px; line-height: 16px; font-size: 12px;">
                                    <textarea class="uniform" name="FormSMSBody" style="font-family:돋움; width: 80%; height: 45px;<%If Session("Grade")="관리자" Then%>height: 60px; <%End If%> border:1 solid silver; margin: 0; background-image: none; font-size: 12px;"></textarea>
                                    <button type="button" class="btn" style="width: 83%; height: 28px;" onclick="SendSMS2(document.RegistRecordInsert)">SMS 발송</button>
                                </th>
                            </tr>
                        </tbody>
						</FORM>
                    </table><!-- table -->
					<div style="display:none;"><iFrame src="<%=Request.Form("FormSendURL")%>" name="StudentDetailSMSSend" width="0" height="0" border="10" style="width: 0; height: 0; border: 0;"></iFrame></div>

                </div><!-- span12 -->
            </div><!-- row-fluid -->
        </div><!-- padd invoice -->

    </div><!-- widget-content -->
</div><!-- Widget -->
<!-- Widget End -->




                </div>
            </div>
        </div>
    </div>
</div>

<FORM METHOD="GET" ACTION="StudentDetail.asp" name="StudentDetailChangeSubjectForm">
	<input type="Hidden" name="FormStudentNumber">
	<input type="Hidden" name="FormDivision0">
	<input type="Hidden" name="FormSubject">
	<input type="Hidden" name="FormDivision1">
	<input type="Hidden" name="FormDivision2">
	<input type="Hidden" name="FormDivision3">
	<input type="Hidden" name="ParentURL">
	<input type="Hidden" name="Width" value="<%=Width%>">
</FORM>

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
        //if (centerCount<=1){
            //$popup.moveToCenter();
            setTimeout(moveToCenter,500);
            //centerCount += 1;
            //console.log(centerCount);
        //}
    }
    var centerCount=0;
    window.onload = moveToCenter();

    //iframe이 로드될때마다 사이즈 조절
    function resizeFrame(id) {
        var ifrm = document.getElementById(id);
        function resize() {
            ifrm.style.height = "auto";	// set default height for Opera
            contentHeight = ifrm.contentWindow.document.documentElement.scrollHeight;
            ifrm.style.height = contentHeight + 0 + "px";	// 23px for IE7
        }
        if (ifrm.addEventListener) {
            ifrm.addEventListener('load', resize, false);
        } else {
            ifrm.attachEvent('onload', resize);
        }
    }
    //window.onload = resizeFrame('RegistRecordFrame');

    function ChangePage(f,GotoPage){
        f.value=GotoPage;
        f.form.submit();
    }

    function StudentDetailChangeSubject(obj1, DialStatus, FormStudentNumber, FormDivision0, FormSubject, FormDivision1, FormDivision2, FormDivision3){
        var myform = obj1;
        if( DialStatus != "전화중" && DialStatus != "녹음중" ){
            if (confirm('다음 학과로 이동할까요?'+'\n'+FormDivision0+' '+FormSubject+' '+FormDivision1+' '+FormDivision2+' '+FormDivision3+'\n'))
            {
            myform.FormStudentNumber.value = FormStudentNumber;
            myform.FormDivision0.value = FormDivision0;
            myform.FormSubject.value		= FormSubject;
            myform.FormDivision1.value = FormDivision1;
            myform.FormDivision2.value = FormDivision2;
            myform.FormDivision3.value = FormDivision3;
            myform.ParentURL.value		= parent.document.location.href;
            //alert(myform.ParentURL.value)
            myform.submit();
            }
        }else{
            alert("복수지원전형으로 이동하려면 작업취소나 결과입력을 먼저 하세요.");
        }

    }
    
//    function startBlink() {
//        var objBlink = document.all.tags("blink");
//        console.log(centerCount);
//        for (var i=0; i < objBlink.length; i++)
//            objBlink[i].style.visibility = objBlink[i].style.visibility == "" ? "hidden" : ""
//    }
//    window.onload = setInterval("startBlink()",1000);

//$("#myModalLabel").text("ㅂㅈㄷㄱ");$("#myModalMessage").html("ㅋㅌㅊㅍ");$("#myModalButton").click();
    //전화명령
    function StudentDetailDial(obj1,Command,Tel,FormUsedLine,RankingCutLine,Ranking){
        var myform = obj1;
        //alert(Tel)
        if (FormUsedLine==""){
            //alert("전화라인을 선택하지 않았으므로 전화를 걸 수 없습니다.")
            $("#myModalLabel").text("지원자 전화제어");$("#myModalMessage").html("전화라인을 선택하지 않았으므로 전화를 걸 수 없습니다");$("#myModalButton").click();
            return false;
        }
//        if (parseInt(RankingCutLine)<parseInt(Ranking)){
//           //alert("커트라인을 벗어나는 지원자 입니다.\n결과입력을 하지 마세요.\n현재 "+RankingCutLine+"등 까지만 가능합니다.")
//            $("#myModalLabel").text("지원자 전화제어");$("#myModalMessage").html("커트라인을 벗어나는 지원자 입니다.<br>결과입력을 하지 마세요.<br>현재 "+RankingCutLine+"등 까지만 가능합니다");$("#myModalButton").click();
//            return false;
//        }
        if (Tel==""){
            //alert("올바른 전화번호를 사용해 주세요.")
            $("#myModalLabel").text("지원자 전화제어");$("#myModalMessage").html("올바른 전화번호를 사용해 주세요");$("#myModalButton").click();
            return false;
        }
        if (Command==''){
            //alert('명령을 입력해 주세요');
            $("#myModalLabel").text("지원자 전화제어");$("#myModalMessage").html("명령을 입력해 주세요");$("#myModalButton").click();
            return;
        }else{
            if (Command=="DIAL"/* && myform.DRECORDCheckBox.checked==false*/){
                //전화걸기 일때
                if (Tel=='.' || Tel==''){
                    //alert('올바른 전화번호를 사용해 주세요');
                    $("#myModalLabel").text("지원자 세부사항");$("#myModalMessage").html("올바른 전화번호를 사용해 주세요");$("#myModalButton").click();
                    return;
                }else{
                    //alert('submit')
                    //myform.FormCommand.value=Command;
                    myform.FormCommand.value="DRECORD";
                    myform.FormDialedTel.value=Tel;
                    myform.submit();
					return;
                }
            }else{
                //녹음시작,녹음종료,결과입력,작업취소,X일때
                if (DelayTime < 3){
                    //alert('2초 후 눌러 주세요');
                    $("#myModalLabel").text("지원자 세부사항");$("#myModalMessage").html("2초 후 눌러 주세요");$("#myModalButton").click();
                    return;
                }else{
                    //alert('submit')
                    myform.FormCommand.value=Command;
                    myform.submit();
                    return;
                }
            }
        }
    }
    function StudentDetailReload(obj1){
        var myform = obj1
        //if(confirm('작업취소는 녹음을 취소하고 전화를 끊는 기능입니다.\n\n계속하시겠습니까?')){
            myform.FormCommand.value="Reload"
            myform.submit();
        //}
    }
    function enterKeyDown(obj1,Command,Tel,FormUsedLine,RankingCutLine,Ranking){
        var e;
        if(e==null) e=window.event;
        if(e.keyCode=='13'){
            if (Tel==""){
                alert("전화번호를 입력하세요.");
                return;
            }
            StudentDetailDial(obj1,Command,Tel)
        }
    }

    function getRadioValue(radioName){
        var obj = document.getElementsByName(radioName);
        for(var i=0; i<obj.length;i++){
            //alert(obj[i].value + " : " +obj[i].checked);
            if (obj[i].checked){
                getName = obj[i].value;
                return getName;
            }
        }
        return null;
    }

    //결과입력
    function StudentDetailRegistRecordInsert(obj1,Grade,RankingCutLine,Ranking){
        var myform = obj1;
        var Receiver
        var Status 
        if (parseInt(RankingCutLine)<parseInt(Ranking) && Grade!="관리자"){
            //alert('커트라인을 벗어나는 지원자 이므로 결과입력이 불가능합니다.');
            $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("커트라인을 벗어나는 지원자 이므로 결과입력이 불가능합니다");$("#myModalButton").click();
            return false;
        }
        //console.log(getRadioValue("FormResult"));
        if (Grade == "관리자"){
            if ( ( getRadioValue("FormResult")!=5 && getRadioValue("FormResult")!=2 && getRadioValue("FormResult")!=7 && getRadioValue("FormResult")!=10 ) && ( getRadioValue("FormReceiver")==null ) ){
                //alert("전화 받은 사람을 선택해 주세요")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("전화 받은 사람을 선택해 주세요");$("#myModalButton").click();
                return
            }
            if ( ( getRadioValue("FormResult")==5 || getRadioValue("FormResult")==2 || getRadioValue("FormResult")==7 || getRadioValue("FormResult")==10 ) && ( getRadioValue("FormReceiver")!=null ) ){
                //alert("미연결, 미등록, 환불은 전화받는 사람이 없어야 합니다.")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("미연결, 미등록, 환불은 전화받는 사람이 없어야 합니다");$("#myModalButton").click();
                return
            }
            if ( myform.FormResult[0].checked == false && myform.FormResult[1].checked == false && myform.FormResult[2].checked == false && myform.FormResult[3].checked == false && myform.FormResult[4].checked == false &&  myform.FormResult[5].checked == false &&  myform.FormResult[6].checked == false ){
                //alert("결과를 선택해 주세요")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("결과를 선택해 주세요");$("#myModalButton").click();
                return
            }
            Receiver = ReceiverCast(myform)
            Status = StatusCast(myform, Grade)
        }else if (Grade == "상담원"){
            if (myform.FormResult[3].checked == false && myform.FormReceiver[0].checked == false && myform.FormReceiver[1].checked == false && myform.FormReceiver[2].checked == false && myform.FormReceiver[3].checked == false){
                //alert("전화 받은 사람을 선택해 주세요")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("전화 받은 사람을 선택해 주세요");$("#myModalButton").click();
                return
            }
            if ( ( myform.FormResult[3].checked == true ) && ( myform.FormReceiver[0].checked == true || myform.FormReceiver[1].checked == true || myform.FormReceiver[2].checked == true || myform.FormReceiver[3].checked == true ) ){
                //alert("미연결, 미등록은 전화받는 사람이 없어야 합니다.")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("미연결, 미등록은 전화받는 사람이 없어야 합니다");$("#myModalButton").click();
                return
            }
            if (myform.FormResult[0].checked == false && myform.FormResult[1].checked == false && myform.FormResult[2].checked == false && myform.FormResult[3].checked == false ){
                //alert("결과를 선택해 주세요")
                $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("결과를 선택해 주세요");$("#myModalButton").click();
                return
            }
            Receiver = ReceiverCast(myform)
            Status = StatusCast2(myform, Grade)
        }
        if (myform.FormMemo.value.length>100){
            //alert("메모는 100자를 넘을 수 없습니다.")
            $("#myModalLabel").text("지원자 결과입력");$("#myModalMessage").html("메모는 100자를 넘을 수 없습니다");$("#myModalButton").click();
            return
        }
        //if (myform.FormDialedTel.value==''){
        //    if(confirm("전화 없이 결과를 입력합니다. 계속하시겠습니까?")==false) {
        //        return
        //    }
        //}
//        if (confirm("받은사람은 " + Receiver + "\n결과는 " + Status + " 입니다. 맞습니까?")){
            myform.FormCommand.value="END"
            myform.submit();
//        }
    }
    function SendSMS2(obj1){
        var myform = obj1;
        if (myform.FormSMSBody.value==""){
            //alert('SMS 문구를 입력해 주세요.');
            $("#myModalLabel").text("지원자 문자발송");$("#myModalMessage").html("SMS 문구를 입력해 주세요");$("#myModalButton").click();
            return;
        }
        if (myform.FormSMSBody.value.length > 45){
            //alert('SMS 문구는 80바이트를 넘을 수 없습니다.');
            $("#myModalLabel").text("지원자 문자발송");$("#myModalMessage").html("SMS 문구는 80바이트를 넘을 수 없습니다");$("#myModalButton").click();
            return;
        }
        if (myform.FormSMSTelTemp.value!=""){
            if(confirm(myform.FormSMSTelTemp.value + "로 SMS를 발송하시겠습니까?")==true) {
                myform.action="StudentDetailSMSSend.asp";
                myform.target="StudentDetailSMSSend";
                myform.submit();
                myform.action='StudentDetailDial.asp';
                myform.target="";
                return;
            }else{
                return;
            }
        }else{
            if(confirm("현재 지원자에게 SMS를 발송하시겠습니까?")==true) {
                myform.action="StudentDetailSMSSend.asp";
                myform.target="StudentDetailSMSSend";
                myform.submit();
                myform.action='StudentDetailDial.asp';
                myform.target="";
                return;
            }else{
                return;
            }
        }
    }
    function Disable(radioName) {
        var Element=document.getElementsByName(radioName)
        for (var nIdx=0; nIdx < Element.length; nIdx++)
        {
            var objElement = Element[nIdx];
            objElement.checked = false;
            objElement.disabled = true;
            //console.log(objElement.checked );
        }
    }
    function Enable(radioName){
        var Element=document.getElementsByName(radioName)
        for (var nIdx=0; nIdx < Element.length; nIdx++)
        {
            var objElement = Element[nIdx];
            objElement.disabled = false;
            //console.log(objElement.checked );
        }
    }
    function ReceiverCast(obj1){
        var myform=obj1
        if (myform.FormReceiver[0].checked){
            return("지원자")
        }
        else if (myform.FormReceiver[1].checked){
            return("부모")
        }
        else if (myform.FormReceiver[2].checked){
            return("가족")
        }
        else if (myform.FormReceiver[3].checked){
            return("기타")
        }
        else{
            return("없음")
        }
    }
    function StatusCast(obj1, Grade){
        var myform=obj1
        if (myform.FormResult[0].checked){
            return("등록예정")
        }
        else if (myform.FormResult[1].checked){
            return("포기")
        }
        else if (myform.FormResult[2].checked){
            return("미결정")
        }
        else if (myform.FormResult[3].checked){
            return("미연결")
        }
        else if (myform.FormResult[4].checked){
            return("등록완료")
        }
        else if (myform.FormResult[5].checked){
            return("미등록")
        }
        else if (myform.FormResult[6].checked){
            return("환불")
        }
    }

    function StatusCast2(obj1, Grade){
        var myform=obj1
        if (myform.FormResult[0].checked){
            return("등록예정")
        }
        else if (myform.FormResult[1].checked){
            return("포기")
        }
        else if (myform.FormResult[2].checked){
            return("미결정")
        }
        else if (myform.FormResult[3].checked){
            return("미연결")
        }
    }


    function UnCheckAll(obj){
        var myform = obj;
        for (var nIdx=0; nIdx < myform.elements.length; nIdx++){
            var objElement = myform.elements[nIdx];
            objElement.checked = false;
        }
    }
</script>

<script type="text/javascript">
    function PositionChange() {
        if ($("#registRecordWidgetContent").css("display").toString()=="none"){
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionRegistRecord=menu-max";
        }else{
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionRegistRecord=menu-min";
        }
        initialize();
    }
    function PositionChangeStudentDetail() {
        if ($("#studentDetailWidgetContent").css("display").toString()=="none"){
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionStudentDetail=menu-max";
        }else{
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionStudentDetail=menu-min";
        }
        initialize();
    }
    
    function PositionChangePluralRecord() {
        //alert($("#pluralRecordWidgetContent").css("display").toString());
        if ($("#pluralRecordWidgetContent").css("display").toString()=="none"){
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionPluralRecord=menu-max";
        }else{
            StudentDetailSMSSend.location.href = "/include/PositionChange.asp?PositionPluralRecord=menu-min";
        }
        initialize();
    }
    function initialize(){
        $mcm.popup.contents.initialize();
    }
</script>

<%'배화여대 예외처리, 결과입력 즉시 리스트로 돌아가기.
If FormStudentNumber="" Then%>
    <script type="text/javascript">
        $(function() {
            $popup.opener().document.location.href=$popup.opener().document.location.href
        });
    </script>
<%End If%>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
