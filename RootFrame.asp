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
                GotoPage = Session("RemainGotoPage")
            else
                Session("RemainGotoPage") = GotoPage
            end if
            GotoPage = getintParameter( GotoPage , 1)
            Dim TotalPage,recordCount
            TotalPage   = 1
            recordCount = 0  
			
            '----------------------------------------------------------------------------------
            ' �ش簪 ��������
            '----------------------------------------------------------------------------------
            Dim Rs15
            Set Rs15 = Server.CreateObject("ADODB.Recordset")
            'response.write Session("FirstPassWork") & "<br>"
            'response.write Session("Quorum") & "<br>"
            StrSql =		""
'            StrSql = StrSql & vbCrLf & "if"
'            StrSql = StrSql & vbCrLf & "("
'            StrSql = StrSql & vbCrLf & "	("
'            StrSql = StrSql & vbCrLf & "		select Ranking + Count - 1"
'            StrSql = StrSql & vbCrLf & "		from"
'            StrSql = StrSql & vbCrLf & "		("
'            StrSql = StrSql & vbCrLf & "			select top 1 Ranking, count(*) count"
'            StrSql = StrSql & vbCrLf & "			from StudentTable"
'            StrSql = StrSql & vbCrLf & "			where SubjectCode = '" & Session("FormSubjectCode") & "'"
'            StrSql = StrSql & vbCrLf & "			group by Ranking"
'            StrSql = StrSql & vbCrLf & "			order by Ranking desc"
'            StrSql = StrSql & vbCrLf & "		) t"
'            StrSql = StrSql & vbCrLf & "	)"
'            StrSql = StrSql & vbCrLf & "	<>"
'            StrSql = StrSql & vbCrLf & "	("
'            StrSql = StrSql & vbCrLf & "		select count(*)"
'            StrSql = StrSql & vbCrLf & "		from StudentTable"
'            StrSql = StrSql & vbCrLf & "		where SubjectCode = '" & Session("FormSubjectCode") & "'"
'            StrSql = StrSql & vbCrLf & "	)"
'            StrSql = StrSql & vbCrLf & ")"
'            StrSql = StrSql & vbCrLf & "--if ��ŷ <> ��ŷ�����ο� then ��ŷ����"
'            StrSql = StrSql & vbCrLf & "begin"
'            StrSql = StrSql & vbCrLf & "	select 'RankingError'"
'            StrSql = StrSql & vbCrLf & "end"
'            StrSql = StrSql & vbCrLf & "--if ��ŷ <> ��ŷ�����ο� then ��ŷ����"
'            StrSql = StrSql & vbCrLf & "else"
'            StrSql = StrSql & vbCrLf & "--if ��ŷ <> ��ŷ�����ο� else ����"

            StrSql = StrSql & vbCrLf & "begin"
            StrSql = StrSql & vbCrLf & "	--if �а���� = 0"
            StrSql = StrSql & vbCrLf & "	IF((SELECT count(*) FROM StudentTable WHERE SubjectCode = '" & Session("FormSubjectCode") & "')=0)"
            StrSql = StrSql & vbCrLf & "	--if �а���� = 0 then ��ܾ���"
            StrSql = StrSql & vbCrLf & "	BEGIN"
            StrSql = StrSql & vbCrLf & "		select 'NoStudent'"
            StrSql = StrSql & vbCrLf & "	END"
            StrSql = StrSql & vbCrLf & "	--if �а���� = 0 then ��ܾ���"
            StrSql = StrSql & vbCrLf & "	else"
            StrSql = StrSql & vbCrLf & "	--if �а���� = 0 else ����"
            StrSql = StrSql & vbCrLf & "	begin"
        '	StrSql = StrSql & vbCrLf & "		--if ����-���=�ܿ� = 0"
        '	StrSql = StrSql & vbCrLf & "		if (" & Session("RemainRecordCount") & "	=	0	)"
        '	StrSql = StrSql & vbCrLf & "		--�ܿ� = 0 then �����"
        '	StrSql = StrSql & vbCrLf & "		begin"
        '	StrSql = StrSql & vbCrLf & "			select 'RemainComplet'"
        '	StrSql = StrSql & vbCrLf & "		end"
        '	StrSql = StrSql & vbCrLf & "		else"
            StrSql = StrSql & vbCrLf & "		--�ܿ� = 0 else �����˷� ��� ����۾� ����"
            StrSql = StrSql & vbCrLf & "		begin"
            StrSql = StrSql & vbCrLf & "			select 'OK'"
            StrSql = StrSql & vbCrLf & "		end"
            StrSql = StrSql & vbCrLf & "		--�ܿ� = 0 else ����"
            StrSql = StrSql & vbCrLf & "	end"
            StrSql = StrSql & vbCrLf & "	--if �а���� = 0 else ����"
            StrSql = StrSql & vbCrLf & "end"

            Rs15.Open StrSql, Dbcon
            Dim Rs15ErrorCode
            If Not Rs15.EOF Then
                Rs15ErrorCode = GetParaMeter(Rs15(0), "")
                if Rs15ErrorCode = "RankingError" then%>
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed">
                    <TR><TD class="content">������ ��ܿ� ������ �ֽ��ϴ�. ������ ������ �ֽ��ϴ�.</TD></TR>
                    </table>
                <%elseif Rs15ErrorCode = "RankingPlural" then%>
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed">
                    <TR><TD class="content">������ ��ܿ� ������ �ֽ��ϴ�. �ߺ��Ǵ� ������ �ֽ��ϴ�. <%=Rs15(1)%>�� ������ �Դϴ�. ������ �ּ���.</TD></TR>
                    </table>
                <%elseif Rs15ErrorCode = "NoStudent" then%>
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed">
                    <TR><TD class="content">������ ����� �Էµ��� �ʾҽ��ϴ�.</TD></TR>
                    </table>
                <%elseif Rs15ErrorCode = "RemainComplet" then%>
                    <table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout:fixed">
                    <TR><TD class="content">�ܿ� �����ڰ� �����ϴ�. ��� �۾��� �Ϸ� �Ǿ����ϴ�.</TD></TR>
                    </table>
                <%End If 
            End If 
            Rs15.Close

            If Rs15ErrorCode = "OK" Then
                StrSql =                   ""
                StrSql = StrSql & vbCrLf & "select C.*, A.IDX as IDXRegistRecord, Degree, Tel, UsedLine, A.MemberID as MemberIDRegistRecord"
                StrSql = StrSql & vbCrLf & "	, MemberName, SaveFile, Receiver, Memo, A.InsertTime as InsertTimeRegistRecord, CallCount"
                StrSql = StrSql & vbCrLf & "	, Status, F.MemberID as MemberIDStatusRecord, Result, MaxSaveFile"
                StrSql = StrSql & vbCrLf & "from "
                '// ����Է� ������ ����
				StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select IDX, StudentNumber, Result, Degree, Tel, UsedLine, MemberID, SaveFile, Receiver, Memo, InsertTime "
                StrSql = StrSql & vbCrLf & "	from RegistRecord"
                StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
                StrSql = StrSql & vbCrLf & ") A "
				'// �л��� ������ ����Է� ������ ����
                StrSql = StrSql & vbCrLf & "inner join "
				StrSql = StrSql & vbCrLf & "( "
                StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount , max(SaveFile) as MaxSaveFile"
                StrSql = StrSql & vbCrLf & "	from RegistRecord "
                StrSql = StrSql & vbCrLf & "	where SubjectCode='" & Session("FormSubjectCode") & "'"
                StrSql = StrSql & vbCrLf & "	group by StudentNumber "
                StrSql = StrSql & vbCrLf & ") B "
                StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber "
                StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX "
                '// �л� ���� ����
				StrSql = StrSql & vbCrLf & "--inner join"
                StrSql = StrSql & vbCrLf & "right outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select StudentNumber, SubjectCode, StudentName, Ranking, etc1, etc2"
                StrSql = StrSql & vbCrLf & "	from StudentTable"
                StrSql = StrSql & vbCrLf & "	where SubjectCode = '" & Session("FormSubjectCode") & "'"
                StrSql = StrSql & vbCrLf & ") C "
                StrSql = StrSql & vbCrLf & "on A.StudentNumber = C.StudentNumber "
                '// ���� ���� ����
				StrSql = StrSql & vbCrLf & "left outer join"
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select MemberID, MemberName from Member"
                StrSql = StrSql & vbCrLf & ") D"
                StrSql = StrSql & vbCrLf & "on A.MemberID = D.MemberID"
                '// ��ȭ(����) ��� ����
				StrSql = StrSql & vbCrLf & "left outer join  "
                StrSql = StrSql & vbCrLf & "( "
                StrSql = StrSql & vbCrLf & "	select AA.*  "
                StrSql = StrSql & vbCrLf & "	from"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber, MemberID, Status"
                StrSql = StrSql & vbCrLf & "		from StatusRecord"
                StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
                StrSql = StrSql & vbCrLf & "	) AA "
                StrSql = StrSql & vbCrLf & "	join  "
                StrSql = StrSql & vbCrLf & "	( "
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from StatusRecord"
                StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) BB"
                StrSql = StrSql & vbCrLf & "	on AA.StudentNumber = BB.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and AA.IDX = BB.MaxIDX"
                StrSql = StrSql & vbCrLf & ") F"
                StrSql = StrSql & vbCrLf & "on C.StudentNumber = F.StudentNumber"

                StrSql = StrSql & vbCrLf & "where 1=1"
				
				'Result = 1	 : ���۾�
				'Result = 2	 : ��ϿϷ�
				'Result = 3	 : ����
				'Result = 4	 : �̰���
				'Result = 5	 : �̿���
				'Result = 6	 : ��Ͽ���
				'Result = 7	 : �̵��
				'Result = 8	 : ����
				'Result = 9	 : ������
				'Result = 10 : ȯ��

        		'If session("FormSubjectStatsResult") = "0" Then
					StrSql = StrSql & vbCrLf & "and ( A.Result is null or A.Result=1 or A.Result=4 or A.Result=5 )"
        		'ElseIf session("FormSubjectStatsResult") = "1" Then
        		'	StrSql = StrSql & vbCrLf & "and ( A.Result is null or A.Result=1 )"
        		'ElseIf session("FormSubjectStatsResult") = "2" Or session("FormSubjectStatsResult") = "3" Or session("FormSubjectStatsResult") = "4" Or session("FormSubjectStatsResult") = "5" Or session("FormSubjectStatsResult") = "6" Then
        		'	StrSql = StrSql & vbCrLf & "and ( A.Result=" & session("FormSubjectStatsResult") & " )"
        		'ElseIf session("FormSubjectStatsResult") = "7" Or session("FormSubjectStatsResult") = "8" Or session("FormSubjectStatsResult") = "9" Or session("FormSubjectStatsResult") = "10" Then
        		'	StrSql = StrSql & vbCrLf & "and ( A.Result=" & session("FormSubjectStatsResult") & " )"
        		'End If


				'�����ȣ �˻� �߰�, �̸��˻��� �Բ�
				If SearchString<>"" Then
					StrSql = StrSql & vbCrLf & "and (C.StudentNumber like '%" & SearchString & "%' or C.StudentName like '%" & SearchString & "%')"
				Else
					StrSql = StrSql & vbCrLf & "and Ranking <= '" & Session("RankingCutLine") & "'"
				End If

                StrSql = StrSql & vbCrLf & "order by Ranking, C.StudentNumber"
				'PrintSql(strSql)

                Rs15.CursorLocation = 3
                Rs15.CursorType = 3	'������ Ŀ��
                Rs15.LockType = 3

                'Response.Write session("FormSubjectStatsResult")
                'Response.Write Rs15ErrorCode
                'Response.Write replace(StrSql,vbCrLf,"<br>")
                'response.end
                Rs15.Open StrSql, Dbcon
                
                '----------------------------------------------------------------------------------
                ' ��ü �������� ��ü ī���� ����
                '----------------------------------------------------------------------------------
                IF (Rs15.BOF and Rs15.EOF) Then
                    recordCount = 0 
                    totalpage   = 0
                Else
                    recordCount = Rs15.RecordCount
                    Rs15.pagesize = PageSize
                    totalpage   = Rs15.PageCount
                End if

                if cint(gotopage)>cint(totalpage) then gotopage=totalpage	
                %>
              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head" style="background-color: #E1F2FF;">
                  <div class="pull-left">
					��������: <%=Session("RemainRecordCount")%>
					<% If SearchString<>"" Then %>
					&nbsp;&nbsp;(�˻����: <%=recordCount%>)
					<% End If %>
                  </div>
                  <div class="widget-icons pull-right">
					<div class="input-prepend" style="display:inline; padding-right:5px;">
						<span class="add-on" style="font-size: 12px;">&nbsp;�����ȣ �̸�&nbsp;</span>
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
                                <TR><TD colspan="10" class="content" style="height: 40; text-align: center;">���� �̳��� �������ڰ� �����ϴ�.<BR>
                                </tbody>
                            <%else%>
                          <tbody>
                            <%
                            Dim StudentNumberTemp, StudentNameTemp, RankingTemp, MemberIDRegistRecordTemp, MemoTemp, InsertTimeRegistRecordTemp
                            Dim CallCountTemp, StatusTemp, MemberIDStatusRecordTemp, ResultTemp, StatusTempStr, ResultTempStr, ETC1Temp, ETC2Temp', DegreeTemp
                            Dim LineColor, LineColorOver
                            Dim RCount

                            'response.write "rs15.pagesize: " & rs15.pagesize & "<br>"
                            'response.write "GotoPage: " & GotoPage & "<br>"
                            'response.write "rs15.recordCount: " & rs15.recordCount & "<br>"
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
								'Response.Write StatusTemp
                                MemberIDStatusRecordTemp=GetParaMeter(Rs15("MemberIDStatusRecord"),"")
                                ResultTemp=GetIntParaMeter(Rs15("Result"),1)
                                'ETC1Temp=GetParaMeter(Rs15("ETC1"),"")
								ETC2Temp=GetParaMeter(Rs15("ETC2"),"")
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
                                        LineColor = "#FFFFFF"
                                        LineColorOver = "#FAFAFA"
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
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; ">&nbsp;</td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " nowrap><%=StudentNumberTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=StudentNameTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=RankingTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=StatusTempStr%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=CallCountTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=DegreeTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=ResultTempStr%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; "><%=MemberIDRegistRecordTemp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 5px; text-align: left;   cursor: pointer; "><%=MemoTemp%><%=ETC2Temp%></td>
                                        <td colspan="1" style="background-color: #FFF0F0; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " nowrap><%=InsertTimeRegistRecordTemp%></td>
                                    </tr>
                                <%else%>
                                    <tr>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " ><input type="Checkbox" name="Checkbox" value="<%=StudentNumberTemp%>"></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StudentNumberTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StudentNameTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=RankingTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=StatusTempStr%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=CallCountTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=DegreeTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=ResultTempStr%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=MemberIDRegistRecordTemp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 5px; text-align: left;   cursor: pointer; " onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=MemoTemp%><%=ETC2Temp%></td>
                                        <td colspan="1" style="background-color: <%=LineColor%>; padding: 8px 0px 5px 0px; text-align: center; cursor: pointer; " nowrap onClick="SelectStudentNumber(document.MenuForm,'<%=StudentNumberTemp%>')" ><%=InsertTimeRegistRecordTemp%></td>
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
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'6');">��Ͽ���</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'3');">����</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'4');">�̰���</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'5');">�̿���</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'2');">��ϿϷ�</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'7');">�̵��</button>
                                        <button type="button" class="btn" onclick="RootUpdate(document.MenuForm,document.MenuForm,'10');">ȯ��</button>
                                        </div>
                                        </div>
                                    </td>
                                </tr>
                            <%End If%>
                            <tr>
                                <td colspan="11" class="content" style="padding: 1px 0px 0px 10px;">
                                    <div class="span12">
                                        <button type="button" class="btn" onclick="return false">SMS�߼۹���</button>
                                        <INPUT TYPE="text" NAME="SMSBody" size="60" maxlength="45" style="margin: 1px 0px 0px 0px;">
                                        <button type="button" class="btn" onclick="SendSMS(document.MenuForm,document.MenuForm,'6');"> SMS�߼� </button>
                                    </div>
                                </td>
                            </tr>
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
                        <div class="widget-foot" style="padding: 0; background-color: #E1F2FF;">
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

	    <%End If 'If Rs15ErrorCode = "OK" Then%>
              
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
