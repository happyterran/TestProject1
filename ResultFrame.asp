
        <%if (Session("FormUsedLine")<>"" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 ) or ( Session("Grade")="������" and Session("FormSubject")<>"" and Session("FormSubjectCode")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0) then%>
          <div class="row-fluid">
            <div class="span12">

            <%
            '################################################################################
            '## �⺻ page setting values
            '##################################################################################
			Dim SearchTitle, SearchString
			'SearchTitle  = getParameter(Request.Form("SearchTitle"),"")
			SearchString = getParameter(Request.Form("SearchString"),"")
			Session("SearchString") = SearchString
			Dim PageSize, GotoPage
            PageSize = 10
            GotoPage = Request.Form("GotoPage")
            '����¡ ���� ������ ���� ���, ���� �Ŀ���
            if GotoPage = "" then
                GotoPage = Session("ResultGotoPage")
            else
                Session("ResultGotoPage") = GotoPage
            end if
            GotoPage = getintParameter( GotoPage , 1)
            Dim TotalPage,RecordCount
            TotalPage   = 1
            RecordCount = 0  

            '----------------------------------------------------------------------------------
            ' �ش簪 ��������
            '----------------------------------------------------------------------------------
            Dim Rs15
            Set Rs15 = Server.CreateObject("ADODB.Recordset")

            StrSql =		"select C.* ,A.IDX as IDXRegistRecord, Degree,Tel,UsedLine,A.MemberID as MemberIDRegistRecord,MemberName,SaveFile,Receiver,Memo,A.InsertTime as InsertTimeRegistRecord, ETC1 "
            StrSql = StrSql & vbCrLf & "		, CallCount"
            StrSql = StrSql & vbCrLf & "		, Status"
            StrSql = StrSql & vbCrLf & "		, F.MemberID as MemberIDStatusRecord "
            StrSql = StrSql & vbCrLf & "		, Result"
            StrSql = StrSql & vbCrLf & "		, MaxSaveFile"
            StrSql = StrSql & vbCrLf & "from "
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select IDX, StudentNumber, Result, Degree, Tel, UsedLine, MemberID, SaveFile, Receiver, Memo, InsertTime "
            StrSql = StrSql & vbCrLf & "	from RegistRecord"
            StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & ") A "
            StrSql = StrSql & vbCrLf & "inner join "
            StrSql = StrSql & vbCrLf & "( "
            StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount , max(SaveFile) as MaxSaveFile"
            StrSql = StrSql & vbCrLf & "	from RegistRecord "
            StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	group by StudentNumber "
            StrSql = StrSql & vbCrLf & ") B "
            StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber "
            StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX "
            StrSql = StrSql & vbCrLf & ""
            StrSql = StrSql & vbCrLf & ""
            StrSql = StrSql & vbCrLf & "inner join "
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select StudentNumber, SubjectCode, StudentName, Ranking, ETC1, ETC2, ETC3"
            StrSql = StrSql & vbCrLf & "	from StudentTable"
            StrSql = StrSql & vbCrLf & "	where SubjectCode = '" & Session("FormSubjectCode") & "' "
            StrSql = StrSql & vbCrLf & ") C "
            StrSql = StrSql & vbCrLf & "on A.StudentNumber = C.StudentNumber "
            StrSql = StrSql & vbCrLf & ""
            StrSql = StrSql & vbCrLf & "left outer join"
            StrSql = StrSql & vbCrLf & "("
            StrSql = StrSql & vbCrLf & "	select MemberID, MemberName from Member"
            StrSql = StrSql & vbCrLf & ") D"
            StrSql = StrSql & vbCrLf & "on A.MemberID = D.MemberID"
            StrSql = StrSql & vbCrLf & "left outer join  "
            StrSql = StrSql & vbCrLf & "( "
            StrSql = StrSql & vbCrLf & "	select A.*  "
            StrSql = StrSql & vbCrLf & "	from"
            StrSql = StrSql & vbCrLf & "	("
            StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber, MemberID, Status"
            StrSql = StrSql & vbCrLf & "		from StatusRecord"
            StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "	) A "
            StrSql = StrSql & vbCrLf & "	join  "
            StrSql = StrSql & vbCrLf & "	( "
            StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
            StrSql = StrSql & vbCrLf & "		from StatusRecord"
            StrSql = StrSql & vbCrLf & "			where SubjectCode='" & Session("FormSubjectCode") & "'"
            StrSql = StrSql & vbCrLf & "		group by StudentNumber"
            StrSql = StrSql & vbCrLf & "	) B"
            StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
            StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
            StrSql = StrSql & vbCrLf & ") F"
            StrSql = StrSql & vbCrLf & "on C.StudentNumber = F.StudentNumber"
            'StrSql = StrSql & vbCrLf & "where (A.Result=6 or A.Result=2 or A.Result=3 or A.Result=7 or A.Result=10 or A.Result=11)"

            StrSql = StrSql & vbCrLf & "where 1=1"
            If session("FormSubjectStatsResult") = "0" Then
                StrSql = StrSql & vbCrLf & "and ( A.Result=6 or A.Result=2 or A.Result=3 or A.Result=7 or A.Result=10 or A.Result=11 )"
            ElseIf session("FormSubjectStatsResult") = "1" Then
                StrSql = StrSql & vbCrLf & "and ( A.Result is null or A.Result=1 )"
            ElseIf session("FormSubjectStatsResult") = "2" Or session("FormSubjectStatsResult") = "3" Or session("FormSubjectStatsResult") = "4" Or session("FormSubjectStatsResult") = "5" Or session("FormSubjectStatsResult") = "6" Then
                StrSql = StrSql & vbCrLf & "and ( A.Result=" & session("FormSubjectStatsResult") & " )"
            ElseIf session("FormSubjectStatsResult") = "7" Or session("FormSubjectStatsResult") = "8" Or session("FormSubjectStatsResult") = "9" Or session("FormSubjectStatsResult") = "10" Then
                StrSql = StrSql & vbCrLf & "and ( A.Result=" & session("FormSubjectStatsResult") & " )"
            End If

			'�����ȣ �˻� �߰�, �̸��˻��� �Բ�
			If SearchString<>"" Then
				StrSql = StrSql & vbCrLf & "and (C.StudentNumber like '%" & SearchString & "%' or C.StudentName like '%" & SearchString & "%')"
			End If

            StrSql = StrSql & vbCrLf & "order by Ranking, c.ETC1"

            'Response.Write StrSql
            Rs15.Open StrSql, Dbcon, 3
            'Rs15.Open StrSql, Dbcon, 1, 1
            
            '----------------------------------------------------------------------------------
            ' ��ü �������� ��ü ī���� ����
            '----------------------------------------------------------------------------------
            IF (Rs15.BOF and Rs15.EOF) Then
                RecordCount = 0 
                totalpage   = 0
            Else
                RecordCount = Rs15.RecordCount
                Rs15.pagesize = PageSize
                totalpage   = Rs15.PageCount
            End if
            
            if cint(gotopage)>cint(totalpage) then gotopage=totalpage	
            %>
              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">
					�۾����: <%=RecordCount%>
					<% If SearchString<>"" Then %>
					<!--&nbsp;&nbsp;(�˻����: <%=recordCount%>)-->
					<% End If %>
                  </div>
                  <div class="widget-icons pull-right">
					<div class="input-prepend" style="display:inline; padding-right:5px;">
						<span class="add-on" style="font-size: 12px;">&nbsp;�����ȣ&nbsp;</span>
						<input type="text" name="SearchString" value="<%=SearchString%>" style="width: 127px; border-right: 1;" onkeydown="EnterKeyDown1(this.form);">
					</div>
					<button type="button" class="btn" onclick="this.form.submit();">�˻�</button>
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
                        <table class="table table-striped table-hover table-bordered" style="atable-layout: fixed;">
                            <colgroup><col width="4%"><col width="10%"></col><col width="7%"></col><col width="5%"></col><col width="8%"></col><col width="5%"></col><col width="5%"></col><col width="8%"></col><col width="8%"></col><col width=""></col><col width="14%"></col></colgroup>
                          <thead>
                            <tr>
                              <th colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;"><img src="/images/Dummy.png" width="19" height="19" border="0" onclick="checkall(document.MenuForm);" style="cursor: pointer;" title="��ü����"></th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">�����ȣ</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">�̸�</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">����</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;"><div class="hidden-phone hidden-tablet" style="width: 100%">��ȭ����</div><span class="hidden-desktop" style="width: 100px;">��ȭ</ul></th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">�Ǽ�</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">����</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">���</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">����</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">�޸�</th>
                              <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">�����۾�</th>
                            </tr>
                          </thead>
                            <%if Rs15.eof then%>
                                <tbody>
                                <TR><TD colspan="10" class="content" style="height: 40; text-align: center;">�۾��� ��ģ �����ڰ� �����ϴ�.<BR>
                                </tbody>
                            <%else%>
                          <tbody>
                            <%
                            Dim StudentNumberTemp, StudentNameTemp, RankingTemp, MemberIDRegistRecordTemp, MemoTemp, InsertTimeRegistRecordTemp
                            Dim CallCountTemp, StatusTemp, MemberIDStatusRecordTemp, ResultTemp, StatusTempStr, ResultTempStr, ETC1Temp', DegreeTemp
                            Dim LineColor, LineColorOver
                            Dim RCount

                            'response.write "rs15.pagesize: " & rs15.pagesize & "<br>"
                            'response.write "GotoPage: " & GotoPage & "<br>"
                            'response.write "rs15.RecordCount: " & rs15.RecordCount & "<br>"
                            'response.write "totalpage " & totalpage & "<br>"

                            RCount = Rs15.pagesize
                            Rs15.AbsolutePage = GotoPage
                            do until Rs15.EOF or (RCount = 0 )
                                StudentNumberTemp = Rs15("StudentNumber")
                                StudentNameTemp = Rs15("StudentName")
                                RankingTemp=GetParaMeter(Rs15("Ranking"), "")
                                MemberIDRegistRecordTemp=GetParaMeter(Rs15("MemberIDRegistRecord"),"&nbsp;")
                                MemoTemp=GetParaMeter(Rs15("Memo"),"&nbsp;")
                                If ByteLen(MemoTemp)>40 Then MemoTemp=ByteLeft(MemoTemp,40) & "..."
                                InsertTimeRegistRecordTemp=GetParaMeter(Rs15("InsertTimeRegistRecord"),"")
                                InsertTimeRegistRecordTemp = GetParaMeter(CastDateTime(InsertTimeRegistRecordTemp),"&nbsp;")
                                
                                CallCountTemp=GetIntParaMeter(Rs15("CallCount"),0)
                                StatusTemp=GetIntParaMeter(Rs15("Status"),1)
                                MemberIDStatusRecordTemp=GetParaMeter(Rs15("MemberIDStatusRecord"),"")
                                ResultTemp=GetIntParaMeter(Rs15("Result"),1)
                                'ETC1Temp=GetParaMeter(Rs15("ETC1"),"")
                                DegreeTemp=GetParaMeter(Rs15("Degree"),"&nbsp;")

                                '��ȭ����
                                select case StatusTemp
                                    case 1
                                        StatusTempStr = "<span class='hidden-phone hidden-tablet' style='width: 100%'>��ȭ����</span><span class='hidden-desktop' style='width: 100px;'>����</span>"
                                    case 2
                                        StatusTempStr = "��ȭ��"
                                    case 3
                                        StatusTempStr = "������"
                                end select

                                '���
                                select case ResultTemp
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
                                'LineColor
                                select case ResultTemp
                                    case 1			'���۾�
                                        LineColor = "#FFFFFF"
                                        LineColorOver = "#FAFAFA"
                                    case 2			'��ϿϷ�
                                        LineColor = "#E1F2FF"
                                        LineColorOver = "#C7E6FE"
                                    case 3			'����
                                        LineColor = "#FFE1E1"
                                        LineColorOver = "#FFC8C8"
                                    case 4			'�̰���
                                        LineColor = "#F7FCFF"
                                        LineColorOver = "#EDF8FF"
                                    case 5			'�̿���
                                        LineColor = "#FFFFFF"
                                        LineColorOver = "#FAFAFA"
                                    case 6			'��Ͽ���
                                        LineColor = "#F7FCFF"
                                        LineColorOver = "#EDF8FF"
                                    case 7			'�̵��
                                        LineColor = "#FDECEC"
                                        LineColorOver = "#FFD5D5"
                                    case 8			'
                                        LineColor = "#FFFFFF"
                                        LineColorOver = "#FAFAFA"
                                    case 9			'
                                        LineColor = "#FFFFFF"
                                        LineColorOver = "#FAFAFA"
                                    case 10			'ȯ��
                                        LineColor = "#FDF2F2"
                                        LineColorOver = "#FCD8D8"
                                End select
                                '�����÷�
                                select case StatusTemp
                                    case 2          '��ȭ��
                                        LineColor = "##E1F2FF"
                                    case 3          '������
                                        LineColor = "#FFF0F0"
                                end select
                                '�����ڰ� ��ȭ�� �Ǵ� �������̰� �������ڰ� �ƴҶ�
                                if (StatusTemp = 2 or StatusTemp =3) and MemberIDStatusRecordTemp<>Session("MemberID") then%>
                                    <tr onClick="myModalRootClick('����۾�','�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.<br>���� ������ <%=MemberIDStatusRecordTemp%>�� �Դϴ�.');"">
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;">&nbsp;</td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;" nowrap><%=StudentNumberTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=StudentNameTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=RankingTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=StatusTempStr%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=CallCountTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=DegreeTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=ResultTempStr%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: #FFF0F0;"><%=MemberIDRegistRecordTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 5px; text-align: left;   cursor: pointer; background-color: #FFF0F0;"><%=MemoTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 5px; text-align: left;   cursor: pointer; background-color: #FFF0F0;"><%=InsertTimeRegistRecordTemp%></td>
                                    </tr>
                                <%else%>
                                    <tr>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" ><input type="Checkbox" name="Checkbox" value="<%=StudentNumberTemp%>"></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StudentNumberTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StudentNameTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=RankingTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StatusTempStr%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=CallCountTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=DegreeTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=ResultTempStr%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=MemberIDRegistRecordTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 5px; text-align: left;   cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" nowrap ><%=MemoTemp%></td>
                                        <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; background-color: <%=LineColor%>;" onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" nowrap ><%=InsertTimeRegistRecordTemp%></td>
                                    </tr>
                                <%end if%>
                                <%Rs15.MoveNext
                                RCount = RCount -1
                            Loop%>
                            <%If Session("Grade")="������" Then%>
                                <tr>
                                    <td colspan="11" class="content" style="padding: 1px 0px 0px 10px;">
                                        <div class="span12">
                                        <button type="button" class="btn" onclick="return false">�ϰ��Է� �޸�</button>
                                        <INPUT TYPE="text" NAME="FormMemo" size="15" maxlength="75" style="margin: 1px 0px 0px 0px;">
                                        <div class="btn-group graphControls">
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'6');">��Ͽ���</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'3');">����</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'4');">�̰���</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'5');">�̿���</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'2');">��ϿϷ�</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'7');">�̵��</button>
                                        <button type="button" class="btn" onclick="RootResultUpdate(document.MenuForm,document.MenuForm,'10');">ȯ��</button>
                                        </div>
                                        </div>
                                    </td>
                                </tr>
                            <%End If%>
                          </tbody>
                            <%End If%>
                        </table>
                      </div>

                    </div>
                  </div>

                    <!-- myModalRoot -->
                    <div id="myModalRoot" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalRootLabel" aria-hidden="true">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
                            <a href="#myModalRoot" id="myModalRootButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
                            <h3 id="myModalRootLabel">���â �����Դϴ�.</h3>
                            <!-- myModalRootButton -->
                        </div>
                        <div class="modal-body">
                            <p id="myModalRootMessage">�̰��� ������ ǥ�õ˴ϴ�.</p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>

                    <%If totalpage > 1 Then %>
                        <div class="widget-foot" style="padding: 0;">
                            <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                                <ul>
                                <%If GotoPage>1 Then%>
                                    <li><a href="javascript:changePage(document.MenuForm,<%=GotoPage-1%>)">Prev</a></li>
                                <%Else%>
                                    <li><a >Prev</a></li>
                                <%End If%>
                                <%pageViewRemainFrameSrc%>
                                <%If cint(GotoPage)<cint(totalpage) Then%>
                                    <li><a href="javascript:changePage(document.MenuForm,<%=GotoPage+1%>)">Next</a></li>
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
            <%
            Rs15.close
            Set Rs15=Nothing
            %>
              
            </div>
          </div>
        <%end if%>
	    </FORM>
        <iFrame src="<%=Request.Form("FormSendURL")%>" name="StudentDetailSMSSend" width="0" height="0" border="0" style="width:0; height:0; border: 0;"></iFrame>
        <%Sub pageViewRemainFrameSrc()
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
                        response.write "<li><a href='javascript:changePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            Else'���� ���������� 10�� �̻��� �ƴҶ�
                For i = 1 to (totalpage mod intMyChoice) '��ü���������� MyChoice�� ���� ������������
                    q=NowBlock*intMyChoice + i
                    If(GotoPage-(NowBlock*intMyChoice)) = i Then
                        Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
                    Else
                        response.write "<li><a href='javascript:changePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            End If
        End Sub%>

