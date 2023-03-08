<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
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
<div class="widget" style="margin: 0; padding: 0;">
    <div class="widget-head">
        <div class="pull-left">������ ��ȭ��� </div>
        <div class="widget-icons pull-right">
            <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
            <a href="#" class="wclose"><i class="icon-remove"></i></a>
        </div>  
        <div class="clearfix"></div>
    </div><!-- widget-head -->
    <div class="widget-content">
      <div class="padd invoice" style="padding: 0;">
        <div class="row-fluid">
          <div class="span12">
            <table class="table table-striped table-hover table-bordered">
              <thead>
                <tr>
                  <th colspan="1" style="text-align: center;">No.</th>
                  <th colspan="1" style="text-align: center;">����</th>
                  <th colspan="1" style="text-align: center;">�߽Ź�ȣ</th>
                  <th colspan="1" style="text-align: center;">�������</th>
                  <th colspan="1" style="text-align: center;">���</th>
                  <th colspan="1" style="text-align: center;">����</th>
                  <th colspan="1" style="text-align: center;">����</th>
                  <th colspan="1" style="text-align: center;">�޸�</th>
                  <th colspan="1" style="text-align: center;">�۾��ð�</th>
                  <th colspan="1" style="text-align: center;">����</th>
	              <%if Session("Grade")="������" then%>
                  <th colspan="1" style="text-align: center;">����</th>
                  <%End If%>
                  <th colspan="1" style="text-align: center;">��ȭ�ε��</th>
                </tr>
              </thead>
              <tbody>
                <%
                Dim PageSize, GotoPage
                PageSize = 3
	            GotoPage = getIntParameter(Request.Querystring("GotoPage"), 1)
                Dim TotalPage,recordCount
                TotalPage   = 1
                RecordCount = 0  
                Dim FormStudentNumber, SaveFile
                FormStudentNumber = Request.Querystring("FormStudentNumber")
                SaveFile = Request.Querystring("SaveFile")
                Dim RegistRecordIDX
                RegistRecordIDX = Request.Querystring("RegistRecordIDX")
                '##############################
                '##������ ��ȭ���
                '##############################
                Dim Rs1, StrSql
                if FormStudentNumber <>"" then
                    Set Rs1 = Server.CreateObject("ADODB.Recordset")

                    if SaveFile <>"" then
                        StrSql =          "begin tran"
                        '��ȭ����� DB�� ����
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

                    StrSql	=		"select a.*, b.*, A.InsertTIme as InsertTimeRegistRecord, a.IDX RegistRecordIDX"
                    StrSql = StrSql & vbCrLf & "from RegistRecord A"
                    StrSql = StrSql & vbCrLf & "join StudentTable B"
                    StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
                    StrSql = StrSql & vbCrLf & "and A.SubjectCode = B.SubjectCode"
                    StrSql = StrSql & vbCrLf & "	and A.StudentNumber = '" & FormStudentNumber & "'"
                    StrSql = StrSql & vbCrLf & "	and B.StudentNumber = '" & FormStudentNumber & "'"
                    StrSql = StrSql & vbCrLf & "order by A.IDX desc"

                    'Response.Write StrSql
                    Rs1.Open StrSql, Dbcon, 1, 1
                    '----------------------------------------------------------------------------------
                    ' ��ü �������� ��ü ī���� ����
                    '----------------------------------------------------------------------------------
                    IF (Rs1.BOF and Rs1.EOF) Then
                        recordCount = 0 
                        totalpage   = 0
                    Else
                        recordCount = Rs1.RecordCount
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
                            Memo = GetParameter( Rs1("Memo") , "&nbsp;" )
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
                                <td colspan="1" style="text-align: center;"><%=No%></td>
                                <td colspan="1" style="text-align: center;"><%=Degree%></td>
                                <td colspan="1" style="text-align: center;"><%=Tel%></td>
                                <td colspan="1" style="text-align: center;"><%=ReceiverTempStr%></td>
                                <td colspan="1" style="text-align: center;"><%=ResultTempStr%></td>
                                <td colspan="1" style="text-align: center;"><%=UsedLine%></td>
                                <td colspan="1" style="text-align: center;"><%=MemberID%></td>
                                <td colspan="1" style="text-align: center;"><%=Memo%></td>
                                <td colspan="1" style="text-align: center;"><%=InsertTimeRegistRecord%></td>
                                <td colspan="1" style="text-align: center;">
                                    <%if SaveFile <>"" Then%>
                                        <a href="/Record/<%=SaveFile%>">���</a>
                                    <%else%>
                                        ���� ����
                                    <%end if%>
                                </td>
                                <td colspan="1" style="text-align: center; cursor: pointer;"
                                    <%If Session("Grade")="������" Then%>
                                        onclick="if(confirm('������ ����� ������ �� �����ϴ�. ���� �����Ͻðڽ��ϱ�?')==true){document.location.href='RegistRecordFrameSrc.asp?FormStudentNumber=<%=FormStudentNumber%>&RegistRecordIDX=<%=RegistRecordIDX%>'}"
                                    <%Elseif Session("FormUsedLine")="" then%>
                                        onClick="alert('��ȭ������ �������� �ʾ����Ƿ� ��ȭ�� ��⸦ �� �� �����ϴ�.');"
                                    <%Elseif SaveFile="" then%>
                                        onClick="alert('������ �����Ƿ� ��ȭ�� ��⸦ �� �� �����ϴ�.');"
                                    <%End If%>
                                    >����</td>
                                <td colspan="1" style="text-align: center; cursor: pointer;" onclick="if(confirm('������ ��ȭ�� �����ðڽ��ϱ�?')==true){document.location.href='RegistRecordFrameSrc.asp?FormStudentNumber=<%=FormStudentNumber%>&SaveFile=<%=FormStudentNumber%><%=Rs1("SaveFile")%>.vox'}">��ȭ�ε��</td>
                            </tr>
                            <%Rs1.MoveNext
						    RCount = RCount -1
                        Loop%>
                    <%Else%>
                        <thead><TR><td colspan="12" style="text-align: center;">��ȭ ����� �����ϴ�.</td></TR></thead>
                    <%End If
                    Rs1.close
                    Set Rs1=Nothing%>
                <%Else%>
                    <thead><TR><td colspan="12" style="text-align: center;">�����ڸ� �������� �ʾҽ��ϴ�.</td></TR><thead>
                <%End If%>
              </tbody>
            </table>
          </div><!-- span12 -->
        </div><!-- row-fluid -->
      </div><!-- padd invoice -->

        <%If totalpage > 0 Then %>
            <div class="widget-foot" style="padding: 0;">
                <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                    <ul>
                    <%If GotoPage>1 Then
                        Response.Write "<li><a href='RegistRecordFrameSrc.asp?GotoPage="&(GotoPage-1)&"&FormStudentNumber=" & FormStudentNumber & "'>Prev</a></li>"
                        Else
                        Response.Write "<li><a >Prev</a></li>"
                    End If%>
                    <%pageViewRegistRecordFrameSrc%>
                    <%If cint(GotoPage)<cint(totalpage) Then
                        response.write "<li><a href='RegistRecordFrameSrc.asp?GotoPage="&(GotoPage+1)&"&FormStudentNumber=" & FormStudentNumber & "'>Next</a></li>"
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






                </div>
            </div>
        </div>
    </div>
</div>
	
		


<%
' ##################################################################################
' ����¡
' ##################################################################################
Sub pageViewRegistRecordFrameSrc()
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
                response.write "<li><a href='RegistRecordFrameSrc.asp?GotoPage="&((NowBlock*intMyChoice)+i)&"&FormStudentNumber=" & FormStudentNumber & "'>"&q&"</A></li>"
            End If
        Next
    Else'���� ���������� 10�� �̻��� �ƴҶ�
        For i = 1 to (totalpage mod intMyChoice) '��ü���������� MyChoice�� ���� ������������
            q=NowBlock*intMyChoice + i
            If(GotoPage-(NowBlock*intMyChoice)) = i Then
                Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
            Else
                response.write "<li><a href='RegistRecordFrameSrc.asp?GotoPage="&((NowBlock*intMyChoice)+i)&"&FormStudentNumber=" & FormStudentNumber & "'>"&q&"</A></li>"
            End If
        Next
    End If
End Sub  
%>

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
    window.onload = function(){
        //setTimeout(parent.resizeFrame('RegistRecordFrame'),1000);
    }
</script>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->