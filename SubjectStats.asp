

        <%Dim Timer1
        Timer1=Timer()
        'if Request.Form("FormStudentNumber")="" then ' �����ڵ����� ���� & �а� ���� �� ���� , ������ ���λ��� ȭ�鿡�� ����

        '##############################
        '##�а� ���� ���
        '##############################
        if Session("FormUsedLine")<>"" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 or ( Session("Grade")="������" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0) then

            'StrSql =		"exec up_SubjectStats '" & Session("FormSubjectCode") & "'"

            StrSql =		"select ResultCode, Result, ResultCount"
            StrSql = StrSql & vbCrLf & "From ResultCode D"
            StrSql = StrSql & vbCrLf & "left outer join"
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select IsNull(Result,1) as ResultIsNull, count(*) as ResultCount"
            StrSql = StrSql & vbCrLf & "	from"
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber, Result"
            StrSql = StrSql & vbCrLf & "		from RegistRecord"
            StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	) A"
            StrSql = StrSql & vbCrLf & "	inner join"
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
            StrSql = StrSql & vbCrLf & "		from RegistRecord"
            StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "		group by StudentNumber"
            StrSql = StrSql & vbCrLf & "	) B"
            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
            StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
            StrSql = StrSql & vbCrLf & "	"
            StrSql = StrSql & vbCrLf & "	right outer join "
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select StudentNumber"
            StrSql = StrSql & vbCrLf & "		from StudentTable"
            StrSql = StrSql & vbCrLf & "		where SubjectCode = '" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	) C"
            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
            'StrSql = StrSql & vbCrLf & "	where result = @FormResult"
            StrSql = StrSql & vbCrLf & "	group by Result"
            StrSql = StrSql & vbCrLf & ") E"
            StrSql = StrSql & vbCrLf & "on D.Result = E.ResultIsNull"
            StrSql = StrSql & vbCrLf & "union all "
            StrSql = StrSql & vbCrLf & "select 8, 8 as Result, Quorum as ResultCount"
            StrSql = StrSql & vbCrLf & "from SubjectTable G"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "union all"
            StrSql = StrSql & vbCrLf & "select 9, 9 as Result, Count(*) as ResultCount"
            StrSql = StrSql & vbCrLf & "from  StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "order by ResultCode"

        '	Response.Write StrSql
        '	response.end
            Dim Rs12
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            Rs12.CursorLocation = 3
            Rs12.CursorType = 3
            Rs12.LockType = 3
            Rs12.Open StrSql, Dbcon
            
        '	Dim Register, Remainder, Resource, Calling, Resign, UnDecided, NonConnect, WrongNumber, NonRegister
            Dim ResultArr(10)
            if Rs12.Recordcount > 0 then
                For I = 1 to Rs12.RecordCount
                    ResultArr(i) = GetIntParameter(Rs12("ResultCount"), 0)
                    Rs12.MoveNext		
                Next
            end if
            Rs12.close
            set Rs12 = Nothing

        '##########################################################################################
        '## ���۾�(RemainCount) ����, Session("RemainRecordCount") ����
        '## 
        '## ���۾��� ����� �ܿ�(RaRoot)�� �ٸ���.
        '## ���۾�(RemainCount)						= SubjectStats.asp ���� ������ ���۾� 
        '## Session("RemainRecordCount")	= RemainFrameSrc.asp ���� ������ �ο���
        '##########################################################################################

            Dim RemainCount

            '�ڿ��� 0���� ũ�ٸ� ( if ������-����-����-�̵��-ȯ�� > 0 then )
            if ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10) >= 0 then
                '(�ڿ��� 0 �̻��� ���)
                '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(�ڿ�)-(����)
                '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(������-����-����-�̵��-ȯ��)-(����+�̵��+ȯ��)
                '���۾� = ����-��Ͽ���-�̰���-�̿���-��ϿϷ�
                RemainCount = ResultArr(8)-ResultArr(6)-ResultArr(4)-ResultArr(5)-ResultArr(2)
                'Session("RemainRecordCount") = ���۾�+�̰���+�̿���
                'Session("RemainRecordCount") = (����-��Ͽ���-�̰���-�̿���-��ϿϷ�)+�̰���+�̿���
                'Session("RemainRecordCount") = ����-��Ͽ���-��ϿϷ�
                Session("RemainRecordCount") = ResultArr(8)-ResultArr(6)-ResultArr(2)
                'SP_Remain ������ ����ó��
            else
                '(�ڿ��� 0���� �������)
                '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����)
                '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����+�̵��+ȯ��)
                '���۾� = ������-��Ͽ���-�̰���-�̿���-��ϿϷ�-����-�̵��-ȯ��
                'Response.Write ResultArr(9)-ResultArr(6)-ResultArr(4)-ResultArr(5)-ResultArr(2)-ResultArr(3)-ResultArr(7)-ResultArr(10)
                '�׷��� �ᱹ RegistRecord = Null �� �ο��� ���۾� �̴� �׷��Ƿ�
                '���۾� = DB���۾�
                RemainCount = ResultArr(1)
                'Remain = ���۾�+�̰���+�̿���
                'Remain = (DB���۾�)+�̰���+�̿���
                Session("RemainRecordCount") = ResultArr(1)+ResultArr(4)+ResultArr(5)
                'SP_Remain ������ ����ó��
            end if
            'Response.Write RemainCount
            'Response.Write Session("RemainRecordCount") & ","

            '����
            Session("Quorum") = ResultArr(8)
            'ĿƮ����(RankingCutLine) = ����+����+�̵��+ȯ��
            Session("RankingCutLine") = ResultArr(8)+ResultArr(3)+ResultArr(7)+ResultArr(10)
        '	'�۾����(ResultRecordCount) = ��Ͽ���+��ϿϷ�+����+�̵��+ȯ��
        '	Session("ResultRecordCount")=ResultArr(6)+ResultArr(2)+ResultArr(3)+ResultArr(7)+ResultArr(10)
            'SP_Remain ������ ����ó��

        '##############################
        '## �켱���ߴ���� ���� ranking�� 0 �Ǵ� ���̳ʽ��� �ο� ����&����
        '##############################
            '����<=0�� �л���ŭ RankingCutLine�� ���δ�
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            StrSql =       "select Count(*) Count from StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "and Ranking <= 0"
            'Response.Write StrSql
            Rs12.Open StrSql, Dbcon
            if Rs12.eof = false then
                Session("RankingCutLine") = Session("RankingCutLine") - Rs12("Count")
            end if
            Rs12.Close
            set Rs12 = nothing
            'Response.Write Session("RankingCutLine") & ","

        '##############################
        '## ���������� 2���� ���� ���
        '##############################
            '1. 2���� �հ��ڴ� 1������ ����Է� ���� ����. 1���� �����ڼ������� ETC3�� 2���� ���������� �Է��� �ΰ�, ��� ������ �Ǿ��� �� Remain.asp �޸���� ǥ��, StudentDetail.asp ���� ��� ǥ���ؼ� ���ñ� �ο��� �ڿ��� �ذ�
            '2. ĿƮ������ ����� �л��� ����� ������ ���ؼ� Session("RankingCutLine") ���� ó���ϰ� ��ܿ� ���� ������ ��� �޼��� �� �� ����� 1�� ������ ������ �Է¿��� ��ó
            '3. SP_Remain ������ select top Session("RemainRecordCount") �ؼ��ؼ� �ش� �Ǽ��� ����Ʈ��.
            Dim Rs13, OverCount
            Set Rs13 = Server.CreateObject("ADODB.Recordset")
            StrSql =		"select *"
            StrSql = StrSql & vbCrLf & "from RegistRecord CR"
            StrSql = StrSql & vbCrLf & "inner join"
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
            StrSql = StrSql & vbCrLf & "	from RegistRecord"
            StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	group by StudentNumber"
            StrSql = StrSql & vbCrLf & ") B"
            StrSql = StrSql & vbCrLf & "on CR.StudentNumber = B.StudentNumber"
            StrSql = StrSql & vbCrLf & "and CR.IDX = B.MaxIDX"
            StrSql = StrSql & vbCrLf & "join StudentTable ET"
            StrSql = StrSql & vbCrLf & "on CR.StudentNumber = ET.StudentNumber"
            StrSql = StrSql & vbCrLf & "and ET.Ranking > '" & Session("RankingCutLine") & "'"
            StrSql = StrSql & vbCrLf & "where Result<>4 and Result<>5"
            'Response.Write StrSql
            'Response.End
            Rs13.Open StrSql, Dbcon, 1, 1
            If Not Rs13.EOF Then
                OverCount = cInt(Rs13.RecordCount)
                Session("RankingCutLine") = Session("RankingCutLine") - OverCount
            End If
            Rs13.Close
            Set Rs13 = Nothing
            'Response.Write OverCount
            'Response.Write Session("RankingCutLine") & ","
            'Response.End

        '##############################
        '## RankingCutLinePlural ����
        '##############################
            '���������ϰ��հ� ��������
            '��ŷ��Ʈ���ο� �������� �ִٸ� (�������� �߻� �̶��)
            'Session("RankingCutLine") = Session("RankingCutLine") + �������� ��
            Set Rs12 = Server.CreateObject("ADODB.Recordset")
            StrSql =       "select top 1 Ranking, Count(*) Count from StudentTable"
            StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "and Ranking <= '" & Session("RankingCutLine") & "'"
            StrSql = StrSql & vbCrLf & "group by Ranking"
            StrSql = StrSql & vbCrLf & "order by Ranking desc"
            'Response.Write StrSql
            Rs12.Open StrSql, Dbcon

            Dim RankingCutLinePlural, TempRankingCutLine 
            if Rs12.eof then
                RankingCutLinePlural = 0
                TempRankingCutLine = Session("RankingCutLine")
            else
                RankingCutLinePlural = getIntParameter(Rs12("Count"),0)
                TempRankingCutLine = Rs12("Ranking")
            end if
            'Response.Write TempRankingCutLine & "<BR>"

            Rs12.Close
            set Rs12 = nothing
            'Response.Write RankingCutLinePlural
            '�������ڰ� ������ RemainRecordCount ��� �ٽ��ؾ� �Ѵ�, ĿƮ���� �Ʒ��� �������� + �������ڼ� - 1
            if RankingCutLinePlural > 1 then
                'Session("RemainRecordCount") = TempRankingCutLine + RankingCutLinePlural - Session("RankingCutLine") -1
                Session("RemainRecordCount") = Session("RemainRecordCount") + TempRankingCutLine + RankingCutLinePlural - Session("RankingCutLine") -1
                'SP_Remain ������ ����ó��
                '-1�� �ϴ� ������ RankingCutLinePlural�� ���������� �ο��� �̹Ƿ� ������ �Ѹ��� ���� �����̴�
                Response.Write "<h4><FONT COLOR='#FF5555'>��ĿƮ���ο� �������ڵ��� �����մϴ�. ��踦 ö���� Ȯ���ϸ鼭 �����ϼ���.</FONT></h4>"
            end if
            'Response.Write RemainCount
            'Response.Write Session("RemainRecordCount") & ", "
            'Response.Write Session("RankingCutLine")
            %>





          <div class="row-fluid">
            <div class="span12">

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">��ü������: <%=ResultArr(9)%></div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize" id="subjectStats" onclick="PositionChange()"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content" id="courseStatsWidgetContent" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%end if %>>
                <!-- <div class="widget-content" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%End If%>> -->
                  <div class="padd invoice" style="padding:0;">
                    <div class="row-fluid">

                      <div class="span12">
                        <table class="table table-striped table-hover table-bordered">
                            <colgroup><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col><col width="11%"></col></colgroup>
                            <thead>
                                <tr>
                                  <th colspan="5" style="text-align: center; background-color: #d9edf7;">�����ο�: <%=ResultArr(8)%></th>
                                  <th colspan="1" style="text-align: center; background-color: #FFFBC8;">�ڿ�: <%=ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10)%></th>
                                  <th colspan="3" style="text-align: center; background-color: #FFE1E1;">����: <%=ResultArr(3)+ResultArr(7)+ResultArr(10)%></th>
                                </tr>
                                <tr>
                                  <th style="text-align: center; cursor: pointer;" >��Ͽ���</th>
                                  <th style="text-align: center; cursor: pointer;" >�̰���</th>
                                  <th style="text-align: center; cursor: pointer;">�̿���</th>
                                  <th style="text-align: center; cursor: pointer;">���۾�</th>
                                  <th style="text-align: center; cursor: pointer;">��ϿϷ�</th>
                                  <th colspan="1" style="text-align: center;">�ڿ�</th>
                                  <th style="text-align: center; cursor: pointer;">����</th>
                                  <th style="text-align: center; cursor: pointer;">�̵��</th>
                                  <th style="text-align: center; cursor: pointer;">ȯ��</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(6)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(4)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(5)%></td>
                                  <td colspan="1" style="text-align: center;"><%=RemainCount%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(2)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(9)-ResultArr(8)-ResultArr(3)-ResultArr(7)-ResultArr(10)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(3)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(7)%></td>
                                  <td colspan="1" style="text-align: center;"><%=ResultArr(10)%></td>
                                </tr>
                            </tbody>
                        </table>
                      </div>

                    </div>
                  </div><!-- 
                  <div class="widget-foot">
                    <button class="btn pull-right">Send Invoice</button>
                    <div class="clearfix"></div>
                  </div> -->
                </div>
              </div>  
              
            </div>
          </div>


        <%End if%>
        <%'End if ' �����ڵ����� ���� & �а� ���� �� ���� , ������ ���λ��� ȭ�鿡�� ����%>