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
'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
Dim FormRecorded
FormRecorded = GetParameter(Request.Form("FormRecorded"), "")
'�ڵ������� ������ ��ġ
Dim DRECORDCheckBox
DRECORDCheckBox = GetParameter(Request.Cookies("METIS")("DRECORDCheckBox"), "")
'���ִ� ��� �ڵ�����
DRECORDCheckBox = "checked"

Dim Rs2%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>������ ���λ���</title>
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
'## ������ ��ȭ���
'##############################%>
<!-- Widget -->
<div class="widget" style="">
    <div class="widget-head">
        <div class="pull-left">������ ��ȭ��� </div>
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
              <colgroup><col width="4%"></col><col width="5%"></col><col width="12%" class="hidden-phone"></col><col width="6%"></col><col width="6%"></col><col width="5%"></col><col width="8%" class="hidden-phone"></col><col width="" class="hidden-phone"></col><col width="12%"></col><col width="6%"></col><%If Session("Grade")="������" Then%><col width="5%"></col><%End If%><!-- <col width="5%"></col> --></colgroup>
              <thead>
                <tr>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">No.</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">�߽Ź�ȣ</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">�������</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">���</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">����</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">�޸�</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">�۾��ð�</th>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
	              <%if Session("Grade")="������" then%>
                  <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
                  <%End If%>
                  <!-- <th colspan="1" style="text-align: center;">��ȭ</th> -->
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
                '##������ ��ȭ���
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
                        '��ȭ����� DB�� ����
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
                    
                    '��ȭ��� ���� - ������ư���� ���޹��� IDX������ ���� ����
                    if Session("Grade")="������" and RegistRecordIDX <>"" then
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

					'��ȭ��� ��������
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
                    ' ��ü �������� ��ü ī���� ����
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
                            
                            '���
                            select case Result
                                case 1
                                    ResultTempStr = "���۾�"
                                case 2
                                    ResultTempStr = "��ϿϷ�"
                                case 3
                                    ResultTempStr = "����"
                                case 4
                                    ResultTempStr = "�̰���"
                                case 5
                                    ResultTempStr = "�̿���"
                                case 6
                                    ResultTempStr = "��Ͽ���"
                                case 7
                                    ResultTempStr = "�̵��"
                                case 8
                                    ResultTempStr = ""
                                case 9
                                    ResultTempStr = ""
                                case 10
                                    ResultTempStr = "ȯ��"
                            end select
                            '�������
                            select case Receiver
                                case 1
                                    ReceiverTempStr = "����"
                                case 2
                                    ReceiverTempStr = "������"
                                case 3
                                    ReceiverTempStr = "�θ�"
                                case 4
                                    ReceiverTempStr = "����"
                                case 5
                                    ReceiverTempStr = "��Ÿ"
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
                                        <a href="/Record/<%=SaveFile%>" target="StudentDetailSMSSend" title="���">��</a>
                                        <a href="/RegistRecordFrameSrcStop.asp" target="StudentDetailSMSSend" title="����">��</a>
                                        <!-- MP3�� �����ؼ� ���� -->
                                        <!-- 
                                        <a href="/RegistRecordFrameSrcPlay.asp?SaveFile=004038.mp3" target="StudentDetailSMSSend">��</a>
                                        <a href="/RegistRecordFrameSrcStop.asp?SaveFile=004038.mp3" target="StudentDetailSMSSend">��</a><br>
                                        -->
                                        <!-- MP3�� �����ؼ� ���� -->
                                        <a href="/Record/<%=SaveFile%>" target="_Blank" title="�� â">��</span>
                                    <%else%>
                                        ����
                                    <%end if%>
                                </td>
                                <%if Session("Grade")="������" then%>
                                <td colspan="1" style="text-align: center; cursor: pointer;"
                                    <%If Session("Grade")="������" Then%>
                                        onclick="if(confirm('������ ����� ������ �� �����ϴ�. ���� �����Ͻðڽ��ϱ�?')==true){RegistRecordDelete(<%=RegistRecordIDX%>)}"
                                    <%Elseif Session("FormUsedLine")="" then%>
                                        onClick="alert('��ȭ������ �������� �ʾ����Ƿ� ��ȭ�� ��⸦ �� �� �����ϴ�.');"
                                    <%Elseif SaveFile="" then%>
                                        onClick="alert('������ �����Ƿ� ��ȭ�� ��⸦ �� �� �����ϴ�.');"
                                    <%End If%>
                                    >����</td>
                                <%End If%>
                                <!-- <td colspan="1" style="text-align: center; cursor: pointer;" onclick="if(confirm('������ ��ȭ�� �����ðڽ��ϱ�?')==true){RegistRecordSaveFile('<%=FormStudentNumber%><%=Rs1("SaveFile")%>')}">���</td> -->
                            </tr>
                            <%Rs1.MoveNext
						    RCount = RCount -1
                        Loop%>
                    <%Else%>
                        <%If Session("Grade")="������" Then%>
                            <thead><TR><td colspan="11" style="text-align: center;">��ȭ ����� �����ϴ�.</td></TR></thead>
                        <%Else%>
                            <thead><TR><td colspan="10" style="text-align: center;">��ȭ ����� �����ϴ�.</td></TR></thead>
                        <%End If%>
                    <%End If
                    Rs1.close
                    Set Rs1=Nothing%>
                <%Else%>
                    <thead><TR><td colspan="11" style="text-align: center;">�����ڸ� �������� �ʾҽ��ϴ�.</td></TR><thead>
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
        TotalBlock = int((totalpage-1)/intMyChoice) '��ü���� (���� 0���� ����)
        NowBlock = int((GotoPage-1)/intMyChoice) '�������
    end if
    If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'���� ���������� 10�� �̻��϶�
        For i = 1 to intMyChoice
            q=NowBlock*intMyChoice + i
            If(GotoPage-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='javascript: ChangePage(document.RegistRecordForm.GotoPage," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
            End If
        Next
    Else'���� ���������� 10�� �̻��� �ƴҶ�
        For i = 1 to (totalpage mod intMyChoice) '��ü���������� MyChoice�� ���� ������������
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
'## ������ ��������
'##############################%>
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">������ ��������
            <!-- myModal -->
            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
                    <a href="#myModal" id="myModalButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
                    <h3 id="myModalLabel">���â �����Դϴ�.</h3>
                    <!-- myModalButton -->
                </div>
                <div class="modal-body">
                    <p id="myModalMessage">�̰��� ������ ǥ�õ˴ϴ�.</p>
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
                            '�⺻ ����
                            StrSql = StrSql & vbCrLf & "from StudentTable A"
                            StrSql = StrSql & vbCrLf & "join SubjectTable B"
                            StrSql = StrSql & vbCrLf & "	on A.SubjectCode = B.SubjectCode"   
							'���� ��ȭ ����
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
							'���� ��� ����
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
							
							'�л� �߰� ����ó �߰�
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
                                '�����ȣ �˻����� �����ڿ��� �������� ��� ���������ڵ� ����
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

								'// Ÿ�����հ��� ������ �Է�
								'// Ÿ���� �հ����̰� ������� ���� �л��� ������� Ÿ���� �հ� ���� ó��
								If ETC2 = "Ÿ�����հ�" And Result = 1 Then
								%>
								<script type="text/javascript">
									$( document ).ready(function() {
										//������� ���⿹���� �ڵ�����ó��
										$('input:radio[name=FormReceiver]:input[value='+5+']').attr("checked", true);
										$('input:radio[name=FormResult]:input[value='+3+']').attr("checked", true);
										$('input[name=FormCommand]').val("END");
										$("textarea[name=FormMemo]").attr("value", "Ÿ���� �հ� ����ó��");
										document.RegistRecordInsert.submit();
										alert('Ÿ���� �հ����̹Ƿ� ���� ó���Ǿ����ϴ�.');
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
                                '��ȭ����
                                select case Status
                                    case 1
                                        StatusTempStr = "��ȭ����"
                                    case 2
                                        StatusTempStr = "��ȭ��"
                                    case 3
                                        StatusTempStr = "������"
                                end select
                                '���
                                select case Result
                                    case 1
                                        ResultTempStr = "���۾�"
                                    case 2
                                        ResultTempStr = "��ϿϷ�"
                                    case 3
                                        ResultTempStr = "����"
                                    case 4
                                        ResultTempStr = "�̰���"
                                    case 5
                                        ResultTempStr = "�̿���"
                                    case 6
                                        ResultTempStr = "��Ͽ���"
                                    case 7
                                        ResultTempStr = "�̵��"
                                    case 8
                                        ResultTempStr = ""
                                    case 9
                                        ResultTempStr = ""
                                    case 10
                                        ResultTempStr = "ȯ��"
                                end select
                                Session("FormDegree") = getParameter(Rs2("DegreeSetting"),"")
								Rs2.Close
								Set Rs2=Nothing
								
								%>
                                <%'=Session("FormDegree")%>
                                
								<!--
								<thead>
                                <tr>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�����ȣ</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�̸�</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�ֹε�Ϲ�ȣ</th>
                                    <th colspan="2" style="padding: 8px 0px; text-align: center;" class="hidden-phone">������¹�ȣ</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">��ϱ�</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">��ϱ���</th>
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
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">����</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�����ȣ</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�̸�</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;">�ֹε�Ϲ�ȣ</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">������¹�ȣ</th>
									<th colspan="1" style="padding: 8px 0px; text-align: center;" class="hidden-phone">��ϱ���</th>
                                    <th colspan="2" style="padding: 8px 0px; text-align: center; max-width:280px;">�ּ�</th>
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
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;">�������</th>
                                    <th colspan="3" style="padding: 8px 0px; text-align: center; border-top: 0;;" class="hidden-phone">�����а�</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">������</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">��Ÿ����1</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">��Ÿ����2</th>
                                    <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">��Ÿ����3</th>
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
                                    <td colspan="6" style="padding: 8px 0px; text-align: center;">������ ���������� �����ϴ�</td>
                                </tr>
                                </tbody>
                            <%End If
                            'Rs2.Close
                            'Set Rs2=Nothing%>
                        <%Else%>
                            <tbody>
                            <tr>
                            <td colspan="6" style="padding: 8px 0px; text-align: center;">�����ڸ� �������� �ʾҽ��ϴ�</td>
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
'## �������� ����
'##############################
Dim DuplicateRecordCount
DuplicateRecordCount = 0%>
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">�������� ����</div>
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
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� ���</th>
                                <th colspan="3" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� �а�</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� ����</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� �����ȣ</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� ����</th>
                                <th colspan="1" style="padding: 8px 0px; text-align: center; border-top: 0;;">�������� ĿƮ����</th>
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
                        
						'// �л� ���� ��������
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
						
						'// ���� �а�(��������) ��������
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
                        '// ��ϿϷ� ī��Ʈ
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
						'// ���� ī��Ʈ
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
						'// ��Ͽ��� ī��Ʈ
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
						'// �̵�� ī��Ʈ
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
						'// ȯ�� ī��Ʈ
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
						'// result = 11(??) ī��Ʈ
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
						'// ranking�� 0�� �л� ī��Ʈ
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
                        
						'// ��� ���� ��������
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
                        '���� �� ������ ������ �ʴ� �ɼ�
                        'StrSql = StrSql & vbCrLf & "where Ranking <= RankingCutLine"
                        StrSql = StrSql & vbCrLf & "order by A.StudentNumber asc"
                        'PrintSql( StrSql)
                        'Response.end
                        Rs2.Open StrSql, Dbcon, 1, 1
                        '----------------------------------------------------------------------------------
                        ' ��ü �������� ��ü ī���� ����
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
                                '���
                                select case PluralResult
                                    case 1
                                        PluralResultTempStr = "�߰��հ�"
                                    case 2
                                        PluralResultTempStr = "��ϿϷ�"
                                    case 3
                                        PluralResultTempStr = "����"
                                    case 4
                                        PluralResultTempStr = "�̰���"
                                    case 5
                                        PluralResultTempStr = "�̿���"
                                    case 6
                                        PluralResultTempStr = "��Ͽ���"
                                    case 7
                                        PluralResultTempStr = "�̵��"
                                    case 8
                                        PluralResultTempStr = ""
                                    case 9
                                        PluralResultTempStr = ""
                                    case 10
                                        PluralResultTempStr = "ȯ��"
                                end Select
                                If PluralRanking > RankingCutLine Then
                                    'PluralResultTempStr = "���� ��"
									PluralResultTempStr = ""
                                End If
                                if PluralResult = 1 and PluralRanking <= Quorum - ZeroCount then
                                    PluralResultTempStr = "�����հ�"
                                End If%>
                                <tr>
                                    <td colspan="1" style="text-align: center;"><%=PluralResultTempStr%></td>
                                    <%If Session("Grade")="������" Then%>
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
                            <TR><TD colspan="12" style="text-align: center;">�������� ����</TD></TR>
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
        TotalBlock = int((totalpage-1)/intMyChoice) '��ü���� (���� 0���� ����)
        NowBlock = int((GotoPagePlural-1)/intMyChoice) '�������
    end if
    If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'���� ���������� 10�� �̻��϶�
        For i = 1 to intMyChoice
            q=NowBlock*intMyChoice + i
            If(GotoPagePlural-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='StudentDetail.asp?GotoPagePlural="&((NowBlock*intMyChoice)+i)&"&FormStudentNumber=" & FormStudentNumber & "'>"&q&"</A></li>"
            End If
        Next
    Else'���� ���������� 10�� �̻��� �ƴҶ�
        For i = 1 to (totalpage mod intMyChoice) '��ü���������� MyChoice�� ���� ������������
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
	<SCRIPT LANGUAGE="JavaScript">//$(window).load(setTimeout(function(){$("#myModalLabel").text("������ ��ȭ����");$("#myModalMessage").html("���������� �����ϴ� ������ �Դϴ�.<br>�۾��� ������ �ּ���");$("#myModalButton").click();}, 1000))</SCRIPT>
    <script language='javascript'>$(window).load(setTimeout(function(){noty({text: '���������� �����ϴ� ������ �Դϴ�. �۾��� ������ �ּ���&nbsp;',layout:'top',type:'error',timeout:3000})}, 1000));</script>
	<%'Session("PluralStudentNumber") = PluralStudentNumber
End If%>


<%'############################
'## ��ȭ���� & ����Է�
'##############################%>
<!-- Widget -->
<div class="widget" style="margin-top: 0; padding-top: 0;">
    <div class="widget-head">
        <div class="pull-left">������ ��ȭ����</div>
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
                                <th colspan="1" style="text-align: center;" class="hidden-phone">��ȭ����</th>
                                <th colspan="1" style="text-align: center;">��ȭ1</th>
                                <th colspan="1" style="text-align: center;">��ȭ2</th>
                                <th colspan="1" style="text-align: center;">��ȭ3</th>
                                <th colspan="1" style="text-align: center;">��ȭ4</th>
                                <th colspan="1" style="text-align: center;" class="hidden-phone ">��ȭ5</th>
                                <th colspan="1" style="text-align: center;" class="hidden-phone">�ӽ���ȭ</th>
                                <td colspan="1" style="text-align: center;">�������</th>
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
                                    <%If StatusTempStr="��ȭ��" Then%><blink><FONT COLOR="RED"><B><%=StatusTempStr%></blink></B></FONT>
                                    <%ElseIf StatusTempStr="������" Then%><blink><FONT COLOR="RED"><B><%=StatusTempStr%></blink></B></FONT>
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
                                    <button type="button" class="btn" style="width: 90%; padding:0,2,0,2px; " onclick="StudentDetailReload(DialForm);return false;">�������</button>
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

						'�ڵ����� ������ ���ϱ�
						StrSql = "select top 1 * From SettingTable order by IDX desc"
						Rs2.Open StrSql, Dbcon
						Dim AutoAbandon, PluralAbandon
						AutoAbandon = getParameter( Rs2("AutoAbandon") , "" )
						Rs2.Close

                        Set Rs2 = Nothing%>
                        <thead>
                            <tr>
                                <th colspan="1" style="text-align: center; border-top: 0;">�������</th>
                                <th colspan="1" style="text-align: center; border-top: 0;">���</th>
                                <th colspan="1" style="text-align: center; border-top: 0;">����</th>
								<%If Session("Grade") ="������" Or AutoAbandon = 1 Then%>
                                <th colspan="1" style="text-align: center; border-top: 0;" class="hidden-phone ">�ڵ��ݿ�</th>
                                <th colspan="2" style="text-align: center; border-top: 0;" class="hidden-phone">�޸�</th>
                                <%else%>
								<th colspan="3" style="text-align: center; border-top: 0;" class="hidden-phone">�޸�</th>
								<%End if%>
								<th colspan="2" style="text-align: center; border-top: 0;">SMS�߼�</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="1" style="text-align: center; ">
                                    <label><input type="radio" name="FormReceiver" value="2" <%If FormReceiver = 2 Then Response.Write "checked"%> />������</label>
                                    <label><input type="radio" name="FormReceiver" value="3" <%If FormReceiver = 3 Then Response.Write "checked"%> />�θ�&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormReceiver" value="4" <%If FormReceiver = 4 Then Response.Write "checked"%> />����&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormReceiver" value="5" <%If FormReceiver = 5 Then Response.Write "checked"%> />��Ÿ&nbsp;&nbsp;&nbsp;</label>
                                </td>
                                <td colspan="1" style="text-align: center; padding: 6px 1px 0px 1px; margin:0;">
                                    <label><input type="radio" name="FormResult" value="6" <%If FormResult = 6 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />��Ͽ���</label>
                                    <label><input type="radio" name="FormResult" value="3" <%If FormResult = 3 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="4" <%If FormResult = 4 Then Response.Write "checked"%> onclick="Enable('FormReceiver')" />�̰���&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="5" <%If FormResult = 5 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />�̿���&nbsp;&nbsp;&nbsp;</label>
                                    <%If Session("Grade")="������" Then%>
                                    <label><input type="radio" name="FormResult" value="2" <%If FormResult = 2 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />��ϿϷ�</label>
                                    <label><input type="radio" name="FormResult" value="7" <%If FormResult = 7 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />�̵��&nbsp;&nbsp;&nbsp;</label>
                                    <label><input type="radio" name="FormResult" value="10" <%If FormResult = 10 Then Response.Write "checked"%> onclick="Disable('FormReceiver')" />ȯ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <%End If%>
                                </td>
                                <td colspan="1" style="text-align: center; padding: 8px 1px 0px 1px; margin:0; <%If Session("Grade") ="������" Then%>padding-top: 30px;<%End If%>">
                                    <button type="button" class="btn" style="width: 75%; height: 95px; " onclick="StudentDetailRegistRecordInsert(document.RegistRecordInsert,'<%=Session("Grade")%>','<%=Session("RankingCutLine")%>','<%=Ranking%>');">����Է�</button>
                                </td>
                                <!-- �����ڴ� ���������� �ڵ��ݿ� üũ����... ������ ������ �����ݿ�. -->
								<%If Session("Grade") ="������" Then '�������� ��� ���� ����%>
									<td colspan="1" style="text-align: center; padding: 6px 0px 0px 0px; margin:0;" class="hidden-phone ">
										<FONT COLOR="red">�ڵ��ݿ��� üũ�ϰ�<BR>�����߿� ��Ͽ�����<BR>�Է��ϸ� ����������<BR>�������� ��Ͽ�����<BR>������ �ڵ����� ����<BR>ó���ǰ� �Էµ˴ϴ�.<BR></FONT>
										<LABEL FOR="�ڵ��ݿ�" style=""><input type="checkbox" name="PluralAbandon" value="3" <%if Request.Cookies("METIS")("PluralAbandon") = "3" then Response.write "checked"%> onchange="if(RegistRecordInsert.PluralAbandon.checked){DialForm.PluralAbandon.value='3'}else{DialForm.PluralAbandon.value=''}" id="�ڵ��ݿ�">�ڵ��ݿ�</LABEL>
									</td>
									<td colspan="2" style="text-align: center; padding: 7px 1px 0px 1px; padding-top: 32px; margin:0;" class="hidden-phone">
										<textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
									</td>
								<%Else '������ ��� ȯ�漳�� ���� ����%>
									<%If AutoAbandon = 1 Then '�ڵ����� ���� �� �ȳ������� �޸� ����%>
										<td colspan="1" style="text-align: center; padding: 6px 0px 0px 0px; margin:0;" class="hidden-phone ">
											<FONT COLOR="red">�����߿� ��Ͽ�����<BR>�Է��ϸ� ����������<BR>�������� ��Ͽ�����<BR>������ �ڵ����� ����<BR>ó���ǰ� �Էµ˴ϴ�.<BR></FONT>
											<input type="Hidden" name="PluralAbandon" value="3">
										</td>
										<td colspan="2" style="text-align: center; padding: 7px 1px 0px 1px; margin:0;" class="hidden-phone">
										 <textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
										</td>
									<%Else '�ڵ����� �̼��� �� �޸� ����%>
										<td colspan="3" style="text-align: center; padding: 7px 1px 0px 1px; margin:0;" class="hidden-phone">
										 <input type="Hidden" name="PluralAbandon" value="0">
										 <textarea class="uniform" name="FormMemo" style="width: 80%; height: 97px; background-image: none;"></textarea>
										</td>
									<%End If%>
								<%End If%>
								<td colspan="2" style="text-align: center; padding: 6px 1px 0px 1px; margin:0;">
                                    <input type="text" name="FormSMSTelTemp" size="11" maxlength="15" style="font-family:����; border:1 solid silver; width: 77%; margin: 0; background-image: none; height: 16px; line-height: 16px; font-size: 12px;">
                                    <textarea class="uniform" name="FormSMSBody" style="font-family:����; width: 80%; height: 45px;<%If Session("Grade")="������" Then%>height: 60px; <%End If%> border:1 solid silver; margin: 0; background-image: none; font-size: 12px;"></textarea>
                                    <button type="button" class="btn" style="width: 83%; height: 28px;" onclick="SendSMS2(document.RegistRecordInsert)">SMS �߼�</button>
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

    //iframe�� �ε�ɶ����� ������ ����
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
        if( DialStatus != "��ȭ��" && DialStatus != "������" ){
            if (confirm('���� �а��� �̵��ұ��?'+'\n'+FormDivision0+' '+FormSubject+' '+FormDivision1+' '+FormDivision2+' '+FormDivision3+'\n'))
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
            alert("���������������� �̵��Ϸ��� �۾���ҳ� ����Է��� ���� �ϼ���.");
        }

    }
    
//    function startBlink() {
//        var objBlink = document.all.tags("blink");
//        console.log(centerCount);
//        for (var i=0; i < objBlink.length; i++)
//            objBlink[i].style.visibility = objBlink[i].style.visibility == "" ? "hidden" : ""
//    }
//    window.onload = setInterval("startBlink()",1000);

//$("#myModalLabel").text("��������");$("#myModalMessage").html("��������");$("#myModalButton").click();
    //��ȭ���
    function StudentDetailDial(obj1,Command,Tel,FormUsedLine,RankingCutLine,Ranking){
        var myform = obj1;
        //alert(Tel)
        if (FormUsedLine==""){
            //alert("��ȭ������ �������� �ʾ����Ƿ� ��ȭ�� �� �� �����ϴ�.")
            $("#myModalLabel").text("������ ��ȭ����");$("#myModalMessage").html("��ȭ������ �������� �ʾ����Ƿ� ��ȭ�� �� �� �����ϴ�");$("#myModalButton").click();
            return false;
        }
//        if (parseInt(RankingCutLine)<parseInt(Ranking)){
//           //alert("ĿƮ������ ����� ������ �Դϴ�.\n����Է��� ���� ������.\n���� "+RankingCutLine+"�� ������ �����մϴ�.")
//            $("#myModalLabel").text("������ ��ȭ����");$("#myModalMessage").html("ĿƮ������ ����� ������ �Դϴ�.<br>����Է��� ���� ������.<br>���� "+RankingCutLine+"�� ������ �����մϴ�");$("#myModalButton").click();
//            return false;
//        }
        if (Tel==""){
            //alert("�ùٸ� ��ȭ��ȣ�� ����� �ּ���.")
            $("#myModalLabel").text("������ ��ȭ����");$("#myModalMessage").html("�ùٸ� ��ȭ��ȣ�� ����� �ּ���");$("#myModalButton").click();
            return false;
        }
        if (Command==''){
            //alert('����� �Է��� �ּ���');
            $("#myModalLabel").text("������ ��ȭ����");$("#myModalMessage").html("����� �Է��� �ּ���");$("#myModalButton").click();
            return;
        }else{
            if (Command=="DIAL"/* && myform.DRECORDCheckBox.checked==false*/){
                //��ȭ�ɱ� �϶�
                if (Tel=='.' || Tel==''){
                    //alert('�ùٸ� ��ȭ��ȣ�� ����� �ּ���');
                    $("#myModalLabel").text("������ ���λ���");$("#myModalMessage").html("�ùٸ� ��ȭ��ȣ�� ����� �ּ���");$("#myModalButton").click();
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
                //��������,��������,����Է�,�۾����,X�϶�
                if (DelayTime < 3){
                    //alert('2�� �� ���� �ּ���');
                    $("#myModalLabel").text("������ ���λ���");$("#myModalMessage").html("2�� �� ���� �ּ���");$("#myModalButton").click();
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
        //if(confirm('�۾���Ҵ� ������ ����ϰ� ��ȭ�� ���� ����Դϴ�.\n\n����Ͻðڽ��ϱ�?')){
            myform.FormCommand.value="Reload"
            myform.submit();
        //}
    }
    function enterKeyDown(obj1,Command,Tel,FormUsedLine,RankingCutLine,Ranking){
        var e;
        if(e==null) e=window.event;
        if(e.keyCode=='13'){
            if (Tel==""){
                alert("��ȭ��ȣ�� �Է��ϼ���.");
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

    //����Է�
    function StudentDetailRegistRecordInsert(obj1,Grade,RankingCutLine,Ranking){
        var myform = obj1;
        var Receiver
        var Status 
        if (parseInt(RankingCutLine)<parseInt(Ranking) && Grade!="������"){
            //alert('ĿƮ������ ����� ������ �̹Ƿ� ����Է��� �Ұ����մϴ�.');
            $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("ĿƮ������ ����� ������ �̹Ƿ� ����Է��� �Ұ����մϴ�");$("#myModalButton").click();
            return false;
        }
        //console.log(getRadioValue("FormResult"));
        if (Grade == "������"){
            if ( ( getRadioValue("FormResult")!=5 && getRadioValue("FormResult")!=2 && getRadioValue("FormResult")!=7 && getRadioValue("FormResult")!=10 ) && ( getRadioValue("FormReceiver")==null ) ){
                //alert("��ȭ ���� ����� ������ �ּ���")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("��ȭ ���� ����� ������ �ּ���");$("#myModalButton").click();
                return
            }
            if ( ( getRadioValue("FormResult")==5 || getRadioValue("FormResult")==2 || getRadioValue("FormResult")==7 || getRadioValue("FormResult")==10 ) && ( getRadioValue("FormReceiver")!=null ) ){
                //alert("�̿���, �̵��, ȯ���� ��ȭ�޴� ����� ����� �մϴ�.")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("�̿���, �̵��, ȯ���� ��ȭ�޴� ����� ����� �մϴ�");$("#myModalButton").click();
                return
            }
            if ( myform.FormResult[0].checked == false && myform.FormResult[1].checked == false && myform.FormResult[2].checked == false && myform.FormResult[3].checked == false && myform.FormResult[4].checked == false &&  myform.FormResult[5].checked == false &&  myform.FormResult[6].checked == false ){
                //alert("����� ������ �ּ���")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("����� ������ �ּ���");$("#myModalButton").click();
                return
            }
            Receiver = ReceiverCast(myform)
            Status = StatusCast(myform, Grade)
        }else if (Grade == "����"){
            if (myform.FormResult[3].checked == false && myform.FormReceiver[0].checked == false && myform.FormReceiver[1].checked == false && myform.FormReceiver[2].checked == false && myform.FormReceiver[3].checked == false){
                //alert("��ȭ ���� ����� ������ �ּ���")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("��ȭ ���� ����� ������ �ּ���");$("#myModalButton").click();
                return
            }
            if ( ( myform.FormResult[3].checked == true ) && ( myform.FormReceiver[0].checked == true || myform.FormReceiver[1].checked == true || myform.FormReceiver[2].checked == true || myform.FormReceiver[3].checked == true ) ){
                //alert("�̿���, �̵���� ��ȭ�޴� ����� ����� �մϴ�.")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("�̿���, �̵���� ��ȭ�޴� ����� ����� �մϴ�");$("#myModalButton").click();
                return
            }
            if (myform.FormResult[0].checked == false && myform.FormResult[1].checked == false && myform.FormResult[2].checked == false && myform.FormResult[3].checked == false ){
                //alert("����� ������ �ּ���")
                $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("����� ������ �ּ���");$("#myModalButton").click();
                return
            }
            Receiver = ReceiverCast(myform)
            Status = StatusCast2(myform, Grade)
        }
        if (myform.FormMemo.value.length>100){
            //alert("�޸�� 100�ڸ� ���� �� �����ϴ�.")
            $("#myModalLabel").text("������ ����Է�");$("#myModalMessage").html("�޸�� 100�ڸ� ���� �� �����ϴ�");$("#myModalButton").click();
            return
        }
        //if (myform.FormDialedTel.value==''){
        //    if(confirm("��ȭ ���� ����� �Է��մϴ�. ����Ͻðڽ��ϱ�?")==false) {
        //        return
        //    }
        //}
//        if (confirm("��������� " + Receiver + "\n����� " + Status + " �Դϴ�. �½��ϱ�?")){
            myform.FormCommand.value="END"
            myform.submit();
//        }
    }
    function SendSMS2(obj1){
        var myform = obj1;
        if (myform.FormSMSBody.value==""){
            //alert('SMS ������ �Է��� �ּ���.');
            $("#myModalLabel").text("������ ���ڹ߼�");$("#myModalMessage").html("SMS ������ �Է��� �ּ���");$("#myModalButton").click();
            return;
        }
        if (myform.FormSMSBody.value.length > 45){
            //alert('SMS ������ 80����Ʈ�� ���� �� �����ϴ�.');
            $("#myModalLabel").text("������ ���ڹ߼�");$("#myModalMessage").html("SMS ������ 80����Ʈ�� ���� �� �����ϴ�");$("#myModalButton").click();
            return;
        }
        if (myform.FormSMSTelTemp.value!=""){
            if(confirm(myform.FormSMSTelTemp.value + "�� SMS�� �߼��Ͻðڽ��ϱ�?")==true) {
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
            if(confirm("���� �����ڿ��� SMS�� �߼��Ͻðڽ��ϱ�?")==true) {
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
            return("������")
        }
        else if (myform.FormReceiver[1].checked){
            return("�θ�")
        }
        else if (myform.FormReceiver[2].checked){
            return("����")
        }
        else if (myform.FormReceiver[3].checked){
            return("��Ÿ")
        }
        else{
            return("����")
        }
    }
    function StatusCast(obj1, Grade){
        var myform=obj1
        if (myform.FormResult[0].checked){
            return("��Ͽ���")
        }
        else if (myform.FormResult[1].checked){
            return("����")
        }
        else if (myform.FormResult[2].checked){
            return("�̰���")
        }
        else if (myform.FormResult[3].checked){
            return("�̿���")
        }
        else if (myform.FormResult[4].checked){
            return("��ϿϷ�")
        }
        else if (myform.FormResult[5].checked){
            return("�̵��")
        }
        else if (myform.FormResult[6].checked){
            return("ȯ��")
        }
    }

    function StatusCast2(obj1, Grade){
        var myform=obj1
        if (myform.FormResult[0].checked){
            return("��Ͽ���")
        }
        else if (myform.FormResult[1].checked){
            return("����")
        }
        else if (myform.FormResult[2].checked){
            return("�̰���")
        }
        else if (myform.FormResult[3].checked){
            return("�̿���")
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

<%'��ȭ���� ����ó��, ����Է� ��� ����Ʈ�� ���ư���.
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
