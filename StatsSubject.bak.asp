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
        <h2 class="pull-left"><i class="icon-list"></i> �������</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/StatsSubject.asp" class="bread-current">�������</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">
            <%'############################
            '##���� �а� ���� ���� ����
            '##############################
            Dim StrSql, i, Count
			Session("FormStatsDivision3")	= Request.Form("FormStatsDivision3")
            Session("FormStatsDivision2")	= Request.Form("FormStatsDivision2")
            Session("FormStatsDivision1")	= Request.Form("FormStatsDivision1")
            Session("FormStatsSubject")		= Request.Form("FormStatsSubject")
            Session("FormStatsDivision0")	= Request.Form("FormStatsDivision0")
            Session("FormStatsMemberID")	= Request.Form("FormStatsMemberID")
            Session("FormStatsDegree")		= trim(Request.Form("FormStatsDegree"))
			Session("FormSelectCount")		= Request.Form("FormSelectCount")
			Dim SelectCount : SelectCount	= Session("FormSelectCount")
            %>

            <%
            Dim SubjectCodeTemp, DegreeTemp, SubjectTemp, DivisionTemp
            Dim TotalLine, HostAddress
            Dim Rs11
            Set Rs11 = Server.CreateObject("ADODB.Recordset")
            %>
            <%'=Session("MemberSubjectA")%>
            <%'=Session("MemberSubjectb")%>
            <%'=Session("MemberSubjectc")%>
            <%'=Session("MemberSubjectd")%>
            <%'if Request.Form("FormStudentNumber")="" then ' �����ڵ����� ���� & �а� ���� �� ���� , ������ ���λ��� ȭ�鿡�� ����%>
            <FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" onsubmit="SubjectEdit(this); return false;" testtarget="Root">
                <INPUT TYPE="hidden" name="FormStatsStatsResult" value="">
                <input type="Hidden" name="FormStudentNumber" value="">
                <input type="Hidden" name="FormStatus" value="">
                <input type="Hidden" name="gotoPage" value="">
			<SELECT NAME="FormSelectCount" onchange="MenuForm.submit();" style="width: 150px;">
                <option value=""<%If SelectCount=""Then%> selected<%End If%>>----�а� ǥ�ù��----</option>
                <option value="��ü"<%If SelectCount="��ü"Then%> selected<%End If%>>��ü �а�</option>
                <option value="���۾�"<%If SelectCount="���۾�"Then%> selected<%End If%>>���۾� �а�</option>
				<option value="�ڿ�����"<%If SelectCount="�ڿ�����"Then%> selected<%End If%>>�ڿ����� �а�</option>
            </SELECT>
            <button type="button" class="btn" onclick="javascript: document.MenuForm.submit();" style="margin-bottom: 10px;">
                <i class="icon-refresh bigger-120"></i> ���ΰ�ħ
            </button>	
			<%'##########  ����  ##########  
			StrSql	=				"select Division0, count(*) as count "
			StrSql = StrSql & vbCrLf & "from SubjectTable "
			StrSql = StrSql & vbCrLf & "where Division0<>'' "
			StrSql = StrSql & vbCrLf & "group by Division0 "
			StrSql = StrSql & vbCrLf & "order by Division0"
			'Response.Write StrSql & "<BR>"
			Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsDivision0" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----�����ñ�----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division0")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormStatsDivision0")=DivisionTemp Then 
									Response.write "selected"
									Session("CountTemp") = Rs11("Count")
								End If
							%>><%=DivisionTemp%></option>
							<%Rs11.MoveNext%>
						<%Loop%>
					</SELECT>
				<%End If%>
				<%Rs11.Close%>
		<%'##########  �������� ����  ########## 
			'If Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1 Then
				StrSql	=				"select Subject, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormStatsDivision0") & "' "
				StrSql = StrSql & vbCrLf & "where Subject<>'' "
				StrSql = StrSql & vbCrLf & "group by Subject "
				'StrSql = StrSql & vbCrLf & "order by min(SubjectCode)"
				StrSql = StrSql & vbCrLf & "order by Subject"
				'Response.Write StrSql & "<BR>"
                'PrintSql StrSql
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsSubject" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----�а���----</option>
						<%do Until Rs11.EOF
							SubjectTemp = Rs11("Subject")%>
							<option value="<%=SubjectTemp%>" <%
								If Session("FormStatsSubject") = SubjectTemp Then 
									Response.write "selected"
									Session("CountTemp") = Rs11("Count")
								End If
							%>><%=SubjectTemp%></option>
							<%Rs11.MoveNext%>
						<%Loop%>
					</SELECT>
				<%Else
					Session("CountTemp") = 0
				End If
				Rs11.Close
			Else%>
				&nbsp;
			<%End If%>
			<%'##########  ����1  ##########  
			'If Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division1, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormStatsSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
				StrSql = StrSql & vbCrLf & "where Division1<>'' "
				StrSql = StrSql & vbCrLf & "group by Division1 "
				StrSql = StrSql & vbCrLf & "order by Division1 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsDivision1" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----����1----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division1")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormStatsDivision1")=DivisionTemp Then 
									Response.write "selected"
									Session("CountTemp") = Rs11("Count")
								End If
							%>><%=DivisionTemp%></option>
							<%Rs11.MoveNext%>
						<%Loop%>
					</SELECT>
				<%Else
					Session("CountTemp") = 0
				End If
				Rs11.Close
			Else%>
				&nbsp;
			<%End If%>
			<%'##########  ����2  ##########  
			'If Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division2, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormStatsSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
				'StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormStatsDivision1") & "' "
				StrSql = StrSql & vbCrLf & "where Division2<>'' "
				StrSql = StrSql & vbCrLf & "group by Division2 "
				StrSql = StrSql & vbCrLf & "order by Division2 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsDivision2" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">-----����2----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division2")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormStatsDivision2")=DivisionTemp Then 
									Response.write "selected"
									Session("CountTemp") = Rs11("Count")
								End If
							%>><%=DivisionTemp%></option>
							<%Rs11.MoveNext%>
						<%Loop%>
					</SELECT>
				<%Else
					Session("CountTemp") = 0
				End If
				Rs11.Close
			Else%>
				&nbsp;
			<%End If%>

			<%'##########  ����3  ##########  
			'If Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsDivision2")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormStatsSubject")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsDivision2")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division3, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormStatsSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
				'StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormStatsDivision1") & "' "
				'StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormStatsDivision2") & "' "
				StrSql = StrSql & vbCrLf & "where Division3<>'' "
				StrSql = StrSql & vbCrLf & "group by Division3 "
				StrSql = StrSql & vbCrLf & "order by Division3 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsDivision3" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">-----����3----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division3")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormStatsDivision3")=DivisionTemp Then 
									Response.write "selected"
									Session("CountTemp") = Rs11("Count")
								End If
							%>><%=DivisionTemp%></option>
							<%Rs11.MoveNext%>
						<%Loop%>
					</SELECT>
				<%Else
					Session("CountTemp") = 0
				End If
				Rs11.Close
			Else%>
				&nbsp;
			<%End If%>

			<%'##########  �۾�����  ##########%>
            <%
            StrSql =          "select degree , count(*) as count from RegistRecord"
            StrSql = StrSql & vbCrLf & "group by degree"
            StrSql = StrSql & vbCrLf & "order by degree"
            Rs11.Open StrSql, Dbcon
            %>
			<SELECT NAME="FormStatsDegree" onchange="MenuForm.submit();" style="width: 150px;">
				<option value="" <%If Session("FormStatsDegree")="" Then Response.write "selected"%>>----����----</option>
				<%If Rs11.BOF = false Then%>
					<%do Until Rs11.eof
						DegreeTemp = Rs11("Degree")%>
						<option value="<%=DegreeTemp%>" <%If cstr(Session("FormStatsDegree"))=cstr(DegreeTemp) Then Response.write "selected"%>><%=DegreeTemp%></option>
						<%Rs11.movenext%>
					<%loop%>
				<%End If%>
				<%Rs11.Close%>
			</SELECT>
            

            <button type="button" class="btn" onclick="javascript: document.location.href='StatsSubject.asp';" style="margin-bottom: 10px;">
                <i class="icon-ban-circle bigger-120"></i> ��������
            </button>
                <%
                Dim Timer1
                Timer1=Timer()
                    '#################################################################################
                    '##�а� ���� ������ Ȱ���� SubStrSql
                    '#################################################################################
                    Dim Rs1, SubStrSql
                    SubStrSql = ""
                    If Session("FormStatsSubject") <> "" Then
                        SubStrSql =					"and Subject = '" & Session("FormStatsSubject") & "'"
                    End If
                    If Session("FormStatsDivision0") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & Session("FormStatsDivision0") & "'"
                    End If
                    If Session("FormStatsDivision1") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & Session("FormStatsDivision1") & "'"
                    End If
                    If Session("FormStatsDivision2") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & Session("FormStatsDivision2") & "'"
                    End If
                    If Session("FormStatsDivision3") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormStatsDivision3") & "'"
                    End If
                '	If Session("FormStatsDegree") <> "" Then
                '		SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & Session("FormStatsDegree") & "'"
                '	End If

                '��δ� ��ö�������� ��û���� ��� ���� �κ��� ����
                '���γ������� ����� �����ϰ� ��ü���� �Ѿ���� ��� ������ �����־ Ư�� ������� �������� ����
                '������ MoveNext�ϸ鼭 �������Ƿ� �� �а��� �ʿ� ���ڵ� ���� �������� �ʾ� ������
                '	If Session("FormStatsResult") <> 0 Then
                '		If Session("FormStatsResult") = 1 Then
                            'SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
                '		Else
                            'SubStrSql = SubStrSql & vbCrLf & "and Result = '" & Session("FormStatsResult") & "'"
                '		End If
                '	End If
                '	If Session("FormStatsMemberID") <> "" Then
                '		SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & Session("FormStatsMemberID") & "'"
                '	End If
                    'Response.Write SubStrSql

                'Dim Timer1
                'Timer1=Timer()
                Dim FormStudentNumber
                FormStudentNumber = Request.Querystring("FormStudentNumber")
                '##############################
                '## ������� - ��ü���
                '##############################
                'Dim Rs1, StrSql
                Set Rs1 = Server.CreateObject("ADODB.Recordset")
                'Response.write Session("StatsDegree")
                StrSql =                   "--���۾�(RemainCount) = ����-��Ͽ���-��ϿϷ�"
                StrSql = StrSql & vbCrLf & "--ĿƮ����(RankingCutLine) = ����+����+�̵��+ȯ��+��ȯ��"
                StrSql = StrSql & vbCrLf & ""
                StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
                StrSql = StrSql & vbCrLf & "select @Degree = '255'"
                If Session("FormStatsDegree") <> "" Then
                StrSql = StrSql & vbCrLf & "select @Degree = '" & Session("FormStatsDegree") & "'"
                End If
                StrSql = StrSql & vbCrLf & "select A.SubjectCode,A.Division0,A.Division1,A.Subject,A.Division2,A.Division3,A.QuorumFix,A.Quorum"
                StrSql = StrSql & vbCrLf & ",isnull(SC.StudentCount,'0') as StudentCount"
                StrSql = StrSql & vbCrLf & ",isnull(RPC.ResultCount,'0') as RegistPlanCount"
                StrSql = StrSql & vbCrLf & ",isnull(UC.ResultCount,'0') as UndecidedCount"
                StrSql = StrSql & vbCrLf & ",isnull(NCC.ResultCount,'0') as NonConnectedCount"
                StrSql = StrSql & vbCrLf & ",isnull(RC.ResultCount,'0') as RegistCount"
                StrSql = StrSql & vbCrLf & ",isnull(AC.ResultCount,'0') as AbandonCount"
                StrSql = StrSql & vbCrLf & ",isnull(NR.ResultCount,'0') as NonRegistCount"
                StrSql = StrSql & vbCrLf & ",isnull(RF.ResultCount,'0') as RefundCount"
                StrSql = StrSql & vbCrLf & "from SubjectTable A"
				StrSql = StrSql & vbCrLf '// �ش� �а� ������ COUNT
				StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "    select SubjectCode, Count(*) as StudentCount from StudentTable group by SubjectCode"
                StrSql = StrSql & vbCrLf & ") SC"
                StrSql = StrSql & vbCrLf & "on SC.SubjectCode = A.SubjectCode"
				StrSql = StrSql & vbCrLf '// �ش� �а� ��Ͽ��� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '6'"   '��Ͽ���
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RPC"
                StrSql = StrSql & vbCrLf & "on RPC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� �̰��� COUNT
				StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '4'"   '�̰���
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") UC"
                StrSql = StrSql & vbCrLf & "on UC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� �̿��� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '5'"   '�̿���
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") NCC"
                StrSql = StrSql & vbCrLf & "on NCC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� ��ϿϷ� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '2'"   '��ϿϷ�
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RC"
                StrSql = StrSql & vbCrLf & "on RC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� ���� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '3'"   '����
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") AC"
                StrSql = StrSql & vbCrLf & "on AC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� �̵�� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '7'"   '�̵��
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") NR"
                StrSql = StrSql & vbCrLf & "on NR.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// �ش� �а� ȯ�� COUNT
                StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select C.SubjectCode, A.Result, count(*) as ResultCount"
                StrSql = StrSql & vbCrLf & "	from RegistRecord A"
                StrSql = StrSql & vbCrLf & "	inner join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "		from RegistRecord"
                StrSql = StrSql & vbCrLf & "		where Degree <= @Degree"
                StrSql = StrSql & vbCrLf & "		group by StudentNumber"
                StrSql = StrSql & vbCrLf & "	) B"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "	inner join "
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select StudentNumber, SubjectCode"
                StrSql = StrSql & vbCrLf & "		from StudentTable"
                StrSql = StrSql & vbCrLf & "	) C"
                StrSql = StrSql & vbCrLf & "	on A.StudentNumber = C.StudentNumber"
                StrSql = StrSql & vbCrLf & "	and A.SubjectCode = C.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where A.Result = '10'"   'ȯ��
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RF"
                StrSql = StrSql & vbCrLf & "on RF.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf & "where 1=1"
                StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
                '20140826 ����ȯ : �����ñ�, �а���, �ڵ�, ����2
                StrSql = StrSql & vbCrLf & "order by a.subject, a.division0 asc, a.division2 desc, a.division1 "
                '��������, ����2, �����ñ�, ����1
                'StrSql = StrSql & vbCrLf & "order by substring(A.SubjectCode,4,2), substring(A.SubjectCode,7,2), substring(A.SubjectCode,1,2), right(A.SubjectCode,1)" 
                'PrintSql StrSql
                'Response.End
                Rs1.CursorLocation = 3
                Rs1.CursorType = 3
                Rs1.LockType = 3
                Rs1.Open StrSql, Dbcon%>

                  <div class="widget" style="margin-top: 0; padding-top: 0;">
                    <div class="widget-head">
                      <div class="pull-left">�������� ����Ʈ : <%=Rs1.RecordCount%></div>
                      <div class="widget-icons pull-right">
                      
                        <button type="button" class="btn btn-success" onclick="document.location.href='StatsSubjectFileDownloadExcel.asp';">
                            <i class="icon-save bigger-120"></i> ��������
                        </button>
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
                                <colgroup>
									<col width="6%"></col>
									<col width="5%"></col>
									<col width="11%"></col>
									<col width="6%"></col>
									<col width="4%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
									<col width="5%"></col>
								</colgroup>
                              <thead>
                                <tr>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ڵ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ñ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�а���</td>
									<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����1</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����2</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����3</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">������</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">��Ͽ���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̰���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̿���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">���۾�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">��ϿϷ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">�ڿ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̵��</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">ȯ��</td>
                                </tr>
                              </thead>
                                <%if Rs1.eof then%>
                                    <tbody>
                                    <TR><TD colspan="19" style="height: 40; text-align: center;">�������� ����� �����ϴ�.<BR>
                                    </tbody>
                                <%else%>
                              <tbody>
								<%'161228 ����ȯ : �ڿ����� �˻��� ��� ���� ����%>
								<%If Session("FormSelectCount") <> "�ڿ�����" then%>
                                <TR>
                                    <TD colspan="6" style="background-color: #FFFFFF; text-align: left; padding-left: 165px;"><B>����</B></TD>
                                    <TD colspan="1" class="StudentCountTotalSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; border-right: #AAA 2px solid;"><B></B></TD>
                                    <TD colspan="1" class="QuorumFixTotalSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B></B></TD>
                                    <TD colspan="1" class="QuorumTotalSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid; color:<%=QuorumDIffrenceSumColor%>"><B></B></TD>
                                    <TD colspan="1" class="QuorumDIffrenceSumTemp" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; color: <%=QuorumDIffrenceSumColor%>; "><B></B></TD>
                                    <TD colspan="1" class="RegistPlanCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid"><B></B></TD>
                                    <TD colspan="1" class="UndecidedCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                    <TD colspan="1" class="NonConnectedCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                    <TD colspan="1" class="RemainCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                    <TD colspan="1" class="RegistCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B></B></TD>
                                    <TD colspan="1" class="ResourceCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B></B></TD>
                                    <TD colspan="1" class="AbandonCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                    <TD colspan="1" class="NonRegistCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                    <TD colspan="1" class="RefundCountSum" style="font-size:13px; font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B></B></TD>
                                </TR>
								<%End If%>
								<%
                            Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum
                            Dim RegistCount ,AbandonCount ,UndecidedCount ,NonConnectedCount ,WrongNumberCount ,NonRegistCount ,RefundCount, StudentCount, RegistPlanCount, RemainCount, ResourceCount
                            Dim BGColor
                            Dim QuorumFixTotalSum, QuorumTotalSum, RegistCountSum, AbandonCountSum, UndecidedCountSum, NonConnectedCountSum, WrongNumberCountSum, NonRegistCountSum, RefundCountSum, StudentCountTotalSum, RegistPlanCountSum, RemainCountSum, ResourceCountSum, ResourceCountSumMinus
                            RemainCountSum = 0
                            ResourceCountSum = 0
                            BGColor="#f0f0f0"
                            Dim QuorumFix, QuorumDIffrence, QuorumDIffrenceTemp
                            Dim QuorumSum, QuorumFixSum, QuorumDIffrenceSum, ODR, SubjectBefore, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp, StudentCountSum
                            Dim RegistPlanCountSmallSum, UndecidedCountSmallSum, NonConnectedCountSmallSum, RemainCountSmallSum, RegistCountSmallSum,         ResourceCountSmallSum, ResourceCountSmallSumMinus,         AbandonCountSmallSum, NonRegistCountSmallSum, RefundCountSmallSum
							Dim ResourceError, ResourceErrorString, ResourceErrorCnt
                            '���� �ʱ�ȭ   ����ȯ 150213
                            RemainCountSmallSum = 0
                            ShowSum = false
                            '�������Ǵ� ��û �ڿ��� ���̳ʽ� �� �� ���������� ǥ��
                            Dim ResourceCountColor
                            do Until Rs1.EOF
                                SubjectCode= getParameter(  Rs1("SubjectCode"),  "&nbsp;")
                                'Subject= getParameter(  Rs1("Subject") , "&nbsp;")
                                Division0= getParameter(  Rs1("Division0") , "&nbsp;")
                                Division1= getParameter(  Rs1("Division1") , "&nbsp;")
                                'Division2= getParameter(  Rs1("Division2") , "&nbsp;")
                                Division3= getParameter(  Rs1("Division3") , "&nbsp;")
                                Quorum= getIntParameter(  Rs1("Quorum") , 0)
                                QuorumFix= getIntParameter(  Rs1("QuorumFix") , 0)
                                
                                'SubjectBefore �� MoveNext ������ Subject
                                SubjectBefore = Subject
                                Subject = getParameter(Rs1("Subject"), "")
                                'ODR = getParameter(Rs1("ODR"), "")

                                Dim Division2Before
                                'Division2Before �� MoveNext ������ Division2
                                Division2Before = Division2
                                Division2= getParameter(  Rs1("Division2") , "")

                                '�����а���� �����а����� �ٸ��� ShowSum = true
                                'If ( SubjectBefore <> Subject and SubjectBefore<>"" ) or ( Division2Before<> Division2 and Division2Before<>"") Then 
                                'If SubjectBefore<>"" And (SubjectBefore <> Subject or Division2Before <> Division2) Then
								If SubjectBefore<>"" And (SubjectBefore <> Subject) Then
                                    ShowSum = true
                                End If

                                'QuorumDIffrenceSum ��Ʈ �÷�
                                QuorumDIffrenceSumTemp = QuorumDIffrenceSum
                                QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSumTemp)
                                If QuorumDIffrenceSum>0 Then 
                                    QuorumDIffrenceSumTemp = "+" & QuorumDIffrenceSumTemp
                                    QuorumDIffrenceSumColor="#0000FF"
                                ElseIf QuorumDIffrenceSum=0 Then
                                    QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
                                    QuorumDIffrenceSumColor="#000000"
                                ElseIf QuorumDIffrenceSum<0 Then
                                    QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
                                    QuorumDIffrenceSumColor="#FF0000"
                                End If

								'�Ұ�� ��ü�а� ǥ���� ����
                                If ShowSum And (SelectCount="" Or SelectCount="��ü") Then%>
                                    <TR>
                                        <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">�Ұ�</TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-left: #AAA 2px solid; border-right: #AAA 2px solid;" ><%=StudentCountSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=QuorumFixSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=QuorumSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; "><%=RegistPlanCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=UndecidedCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=NonConnectedCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; background-color: #72D1FF; "><%=RemainCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=RegistCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=ResourceCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=AbandonCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=NonRegistCountSmallSum%></TD>
                                        <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=RefundCountSmallSum%></TD>
                                    </TR>
                                    <tr>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ڵ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ñ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�а���</td>
									<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����1</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����2</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����3</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">������</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">��Ͽ���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̰���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̿���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">���۾�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">��ϿϷ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">�ڿ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̵��</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">ȯ��</td>

                                    </tr>
                                    <%
                                    If QuorumDIffrenceSum <> 0 Then ShowError = true
                                    '�׸���, 0 ���� ����
                                    StudentCountSum = 0
                                    QuorumSum = 0
                                    QuorumFixSum = 0
                                    QuorumDIffrenceSum = 0
                                    ShowSum=FALSE
                                    '�Ұ��ջ굵 ����
                                    RegistPlanCountSmallSum     = 0 '��Ͽ���
                                    UndecidedCountSmallSum      = 0 '�̰���
                                    NonConnectedCountSmallSum   = 0 '�̿���
                                    RemainCountSmallSum         = 0 '���۾�
                                    RegistCountSmallSum         = 0 '��ϿϷ�
                                    ResourceCountSmallSum       = 0 '�ڿ�
									ResourceCountSmallSumMinus	= 0 '�ڿ�����
                                    AbandonCountSmallSum        = 0 '����
                                    NonRegistCountSmallSum      = 0 '�̵��
                                    RefundCountSmallSum         = 0 'ȯ��
                                    '�Ұ� ǥ�������� bgcolor='FFFFFF'
                                    BGColor="#fafafa"
                                End if

                                RegistCount= getIntParameter( Rs1("RegistCount") , 0)
                                AbandonCount= getIntParameter(  Rs1("AbandonCount") , 0)
                                UndecidedCount= getIntParameter(  Rs1("UndecidedCount") , 0)
                                NonConnectedCount= getIntParameter(  Rs1("NonConnectedCount") , 0)
                                RegistPlanCount= getIntParameter(  Rs1("RegistPlanCount") , 0)
                                NonRegistCount= getIntParameter(  Rs1("NonRegistCount") , 0)
                                RefundCount= getIntParameter(  Rs1("RefundCount") , 0)
                                StudentCount= getIntParameter(  Rs1("StudentCount") , 0)
                                '�ڿ� = ������-����-����-�̵��-ȯ��
                                ResourceCount= StudentCount - Quorum - AbandonCount - NonRegistCount - RefundCount
                                If ResourceCount >=0 Then
                                    '(�ڿ��� 0 �̻��� ���)
                                    '���۾� = ����-��Ͽ���-�̰���-�̿���-��ϿϷ�
                                    RemainCount= Quorum - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount
									'RemainCount= Quorum + RegistCount - RegistCount
                                Else
                                    '(�ڿ��� 0���� �������)
                                    '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����)
                                    '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����+�̵��+ȯ��)
                                    '���۾� = ������-��Ͽ���-�̰���-�̿���-��ϿϷ�-����-�̵��-ȯ��
                                    RemainCount= StudentCount - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount - AbandonCount - NonRegistCount - RefundCount
                                End If
                                
                                '�Ұ��ջ�
                                RegistPlanCountSmallSum = RegistPlanCountSmallSum + RegistPlanCount                   '��Ͽ���
                                UndecidedCountSmallSum = UndecidedCountSmallSum + UndecidedCount                      '�̰���
                                NonConnectedCountSmallSum = NonConnectedCountSmallSum +NonConnectedCount              '�̿���
                                If RemainCount > 0 Then RemainCountSmallSum = RemainCountSmallSum + RemainCount       '���۾�
                                RegistCountSmallSum = RegistCountSmallSum + RegistCount                               '��ϿϷ�
                                If ResourceCount >= 0 Then 
									ResourceCountSmallSum = ResourceCountSmallSum+ResourceCount '�ڿ��Ұ�
								Else
									ResourceCountSmallSumMinus = ResourceCountSmallSumMinus+ResourceCount '�ڿ��Ұ� ���̳ʽ�
								End If
                                AbandonCountSmallSum = AbandonCountSmallSum + AbandonCount                            '����
                                NonRegistCountSmallSum = NonRegistCountSmallSum + NonRegistCount                      '�̵��
                                RefundCountSmallSum = RefundCountSmallSum + RefundCount                               'ȯ��
                                '�Ѱ��ջ�
                                QuorumFixTotalSum = QuorumFixTotalSum + QuorumFix
                                QuorumTotalSum = QuorumTotalSum + Quorum
                                RegistCountSum = RegistCountSum + RegistCount
                                AbandonCountSum = AbandonCountSum + AbandonCount
                                UndecidedCountSum = UndecidedCountSum + UndecidedCount
                                NonConnectedCountSum = NonConnectedCountSum +NonConnectedCount
                                WrongNumberCountSum = WrongNumberCountSum + WrongNumberCount
                                NonRegistCountSum = NonRegistCountSum + NonRegistCount
                                RefundCountSum = RefundCountSum + RefundCount
                                StudentCountTotalSum = StudentCountTotalSum + StudentCount
                                RegistPlanCountSum = RegistPlanCountSum + RegistPlanCount
								RemainCountSum = RemainCountSum + RemainCount	'���۾��Ѱ�
                                If ResourceCount >= 0 Then
                                    ResourceCountSum = ResourceCountSum + ResourceCount	'�ڿ��Ѱ�
								Else
                                    ResourceCountSumMinus = ResourceCountSumMinus + ResourceCount	'�ڿ��Ѱ�
                                End If

                                QuorumDIffrence=Quorum-QuorumFix
                                QuorumDIffrenceTemp=QuorumDIffrence
                                QuorumDIffrenceTemp=cStr(QuorumDIffrenceTemp)
                                
                                'QuorumDIffrence ��Ʈ �÷�
                                If QuorumDIffrence>0 Then 
                                    QuorumDIffrenceTemp = "+" & QuorumDIffrenceTemp
                                    FontColor="#0000FF"
                                ElseIf QuorumDIffrence=0 Then
                                    QuorumDIffrenceTemp = ""
                                    FontColor="#000000"
                                ElseIf QuorumDIffrence<0 Then
                                    QuorumDIffrenceTemp = QuorumDIffrenceTemp
                                    FontColor="#FF0000"
                                End If

                                ResourceCountColor="#000000"
                                'ResourceCount ��Ʈ �÷�
                                If ResourceCount<0 Then
                                    ResourceCountColor="#FF0000"
                                End If

                                'Sum ����
                                StudentCountSum = StudentCountSum + StudentCount
                                QuorumSum = QuorumSum + Quorum
                                QuorumFixSum = QuorumFixSum + QuorumFix
                                QuorumDIffrenceSum = QuorumDIffrenceSum + QuorumDIffrence
								
								'�ڿ����� �а� ���
								If ResourceCount < 0 Then
									ResourceError = TRUE
									If ResourceErrorCnt = 0 Then
										ResourceErrorString = Division0 & " " & Subject & " " & Division1 & " " & Division2 & " " & Division3 & " "									
									Else
										ResourceErrorString = ResourceErrorString & " || " & Division0 & " " & Subject & " " & Division1 & " " & Division2 & " " & Division3 & " "																		
									End If
									ResourceErrorCnt = ResourceErrorCnt + 1
								End If
								%>
                                    <!-- 
                                    <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center;"><%=Subject%><input type="hidden" name="Subject" value="<%=Subject%>"></td>
                                    <td colspan="1" style="padding: 8px 0px 5px 0px; text-align: center;"><%=Division2%><input type="hidden" name="Division2" value="<%=Division2%>"><input type="hidden" name="Division3" value="<%=Division3%>"></td>
                                    <td colspan="1" style="padding: 0px 0px 0px 0px; text-align: left;"  ><INPUT TYPE="text" NAME="Division1" style="width: 95%; height: 32px; border:0px; text-align: left; padding: 0px 0px 0px 5px; margin: 0px; backgroud-color: #fafafa; background-image: none;" maxlength="35" value="<%=Division1%>" onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></td>
                                    <td colspan="1" style="padding: 0px 0px 0px 0px; text-align: right;" ><INPUT TYPE="text" NAME="QuorumFix" style="width: 75%; height: 32px; border:0px; text-align: right; padding: 0px 10px 0px 0px; margin: 0px; backgroud-color: #fafafa; background-image: none;" maxlength="35" value="<%=QuorumFix%>" onkeyup="document.getElementById('Checkbox<%=i%>').checked=true;"></td>
                                     -->
								<%'��üǥ�� �Ǵ� ���۾� �а��� ǥ�� �Ǵ� �ڿ��� ���̳ʽ��� �а��� ǥ��
								If (SelectCount="" Or SelectCount="��ü") Or ( SelectCount="���۾�" And ( UndecidedCount>0 Or NonConnectedCount>0 Or RemainCount>0 ) ) Or ( SelectCount="�ڿ�����" And ( ResourceCount < 0  ) ) Then
									If BGColor = "#fafafa" Then 
										BGColor="#f0f0f0"
									ElseIf BGColor="#f0f0f0" Then
										BGColor="#fafafa"
									End If
									%>
                                <TR>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 0px; text-align: left;"><INPUT TYPE="text" NAME="SubjectCode" style="background-color: <%=BGColor%>; width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; <%=BGColor%>" value="<%=SubjectCode%>"></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Division0%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Subject%></TD>
									<TD colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 0px; text-align: left;"><INPUT TYPE="text" NAME="SubjectCode" style="width: 100%; height: 32px; border:0px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division1%>"></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 0px 0px 1px; text-align: left;" nowrap><%=Division2%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 0px 0px 0px 1px; text-align: left;" nowrap><%=Division3%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-left: #AAA 2px solid; border-right: #AAA 2px solid;" ><%=StudentCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=QuorumFix%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=Quorum%></TD>
                                    <td colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; font-weight:bold; color: <%=FontColor%>;"><%=QuorumDIffrenceTemp%></td>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-left: #AAA 2px solid;" ><%=RegistPlanCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=UndecidedCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=NonConnectedCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; background-color: #E1F2FF;" ><%=RemainCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid;" ><%=RegistCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right; border-right: #AAA 2px solid; border-right: #AAA 2px solid #000000; color: <%=ResourceCountColor%>"><%=ResourceCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=AbandonCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=NonRegistCount%></TD>
                                    <TD colspan="1" style="background-color: <%=BGColor%>; padding: 8px 10px 5px 0px; text-align: right;" ><%=RefundCount%></TD>
                                </TR>
								<%End If%>
                                <%Rs1.MoveNext
                            Loop
                            Rs1.Close
                            Set Rs1 = Nothing

                            'QuorumDiffrenceSum ��Ʈ �÷�
                            QuorumDIffrenceSumTemp = QuorumDIffrenceSum
                            QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSumTemp)
                            If QuorumDIffrenceSum>0 Then 
                                QuorumDIffrenceSumTemp = "+" & QuorumDIffrenceSumTemp
                                QuorumDIffrenceSumColor="#0000FF"
                            ElseIf QuorumDIffrenceSum=0 Then
                                QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
                                QuorumDIffrenceSumColor="#000000"
                            ElseIf QuorumDIffrenceSum<0 Then
                                QuorumDIffrenceSumTemp = QuorumDIffrenceSumTemp
                                QuorumDIffrenceSumColor="#FF0000"
                            End If%>
								<%'�Ұ�� ��ü�а� ǥ���� ����
								If (SelectCount="" Or SelectCount="��ü") then%>
                                <TR>
                                    <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">�Ұ�</TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-left: #AAA 2px solid; border-right: #AAA 2px solid;" ><%=StudentCountSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=QuorumFixSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; border-right: #AAA 2px solid;" ><%=QuorumSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; "><%=RegistPlanCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=UndecidedCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=NonConnectedCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; background-color: #72D1FF;"><%=RemainCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=RegistCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; border-right: #AAA 2px solid"><%=ResourceCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=AbandonCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=NonRegistCountSmallSum%></TD>
                                    <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 10px; "><%=RefundCountSmallSum%></TD>
                                </TR>
								<%End If%>

                                <!-- ########## �� �� ########## -->
                                <%'QuorumDiffrenceSum ���� ��Ʈ �÷�
                                QuorumDIffrenceSum = QuorumTotalSum - QuorumFixTotalSum
                                If QuorumDIffrenceSum>0 Then 
                                    QuorumDIffrenceSumTemp = "+" & cStr(QuorumDIffrenceSum)
                                    QuorumDIffrenceSumColor="#0000FF"
                                ElseIf QuorumDIffrenceSum=0 Then
                                    QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSum)
                                    QuorumDIffrenceSumColor="#000000"
                                ElseIf QuorumDIffrenceSum<0 Then
                                    QuorumDIffrenceSumTemp = cStr(QuorumDIffrenceSum)
                                    QuorumDIffrenceSumColor="#FF0000"
                                End If
								
								'��� �Ѱ�� ��ü�а� ǥ���� ����
                                If (SelectCount="" Or SelectCount="��ü") Then%>
                                <tr>
                                    <td colspan="6" style="padding: 7px 0px 6px 0px; text-align: center;"></td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">������</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">��Ͽ���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̰���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̿���</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">���۾�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">��ϿϷ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">�ڿ�</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̵��</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">ȯ��</td>
                                </tr>
                                <TR>
                                    <TD colspan="6" style="background-color: #FFFFFF; text-align: left; padding-left: 165px;"><B>����</B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid; border-right: #AAA 2px solid;"><B><%=StudentCountTotalSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=QuorumFixTotalSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid; color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumTotalSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumDIffrenceSumTemp%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-left: #AAA 2px solid"><B><%=RegistPlanCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=UndecidedCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=NonConnectedCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; background-color: #72D1FF;"><B><%=RemainCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=RegistCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px; border-right: #AAA 2px solid;"><B><%=ResourceCountSum%><br><font color="red"><%=ResourceCountSumMinus%></font></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=AbandonCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=NonRegistCountSum%></B></TD>
                                    <TD colspan="1" style="font-weight:bold; background-color: #FFFFFF; text-align: right; padding-right: 10px;"><B><%=RefundCountSum%></B></TD>
                                </TR>
								<%End If%>
                                <tr>
                                    <td colspan="19"  style="text-align: center; padding: 1px 0px 0px 10px;">
                                        <div class="span12">
                                            <!-- <div class="btn-group graphControls"> --><!-- 
                                                <button type="button" class="btn btn-primary" onclick="SubjectEdit(document.MenuForm);">�������� ����</button>
                                                <button type="button" class="btn btn-danger" onclick='SubjectDelete(document.MenuForm);'>�������� ����</button> -->
                                            <!-- </div> -->
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

<%If ShowError Then%>
<SCRIPT LANGUAGE="JavaScript">//window.onload = function(){alert('�����Ұ谡 0 �� �ƴ� ������ �ֽ��ϴ�. �����ο��� ��Ȯ�� Ȯ���� �ּ���.');}</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">//$(window).load(function(){$("#myModalRootLabel").text("�������� ����");$("#myModalRootMessage").html("�����Ұ谡 0 �� �ƴ� ������ �ֽ��ϴ�. <br>�����ο��� ��Ȯ�� Ȯ���� �ּ���.");$("#myModalRootButton").click();})</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">$(window).load(function(){noty({text: '�����Ұ谡 0 �� �ƴ� ���������� �ֽ��ϴ�. <br>�����ο��� ��Ȯ�� Ȯ���� �ּ���.',layout:'top',type:'error',timeout:5000});})</SCRIPT>
<%End If%>

<SCRIPT type="text/javascript">
	$("td.StudentCountTotalSum").append("<%=StudentCountTotalSum%>");
	$("td.QuorumFixTotalSum").append("<%=QuorumFixTotalSum%>");
	$("td.QuorumTotalSum").append("<%=QuorumTotalSum%>");
	$("td.QuorumTotalSum").css("color","<%=QuorumDIffrenceSumColor%>");
	$("td.QuorumDIffrenceSumTemp").append("<%=QuorumDIffrenceSumTemp%>");
	$("td.QuorumDIffrenceSumTemp").css("color","<%=QuorumDIffrenceSumColor%>");
	$("td.RegistPlanCountSum").append("<%=RegistPlanCountSum%>");
	$("td.UndecidedCountSum").append("<%=UndecidedCountSum%>");
	$("td.NonConnectedCountSum").append("<%=NonConnectedCountSum%>");
	$("td.RemainCountSum").append("<%=RemainCountSum%>");
	$("td.RegistCountSum").append("<%=RegistCountSum%>");
	$("td.ResourceCountSum").append("<%=ResourceCountSum%>");
	$("td.AbandonCountSum").append("<%=AbandonCountSum%>");
	$("td.NonRegistCountSum").append("<%=NonRegistCountSum%>");
	$("td.RefundCountSum").append("<%=RefundCountSum%>");
</SCRIPT>

<script type="text/javascript">
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }
    function StatsView(){
        var url = "/StatsViewBWC.asp"
        var h = (screen.height) ? (screen.height - 0) : 1;	
        var w = (screen.width) ? (screen.width - 0) : 1;
        var newwin = window.open(url, "View","fullscreen,toolbar=no,status=no,location=no,directories=no,scrollbars=YES,resizable=NO,width="+w+",height="+h+",left=0,top=0");
        newwin.moveTo(0,-21);
        if (navigator.appVersion.indexOf("MSIE 7.0") >= 0){
            //window.open(url + "blink.html", "_self").close();
        } else if (navigator.appVersion.indexOf("MSIE 8.0") >= 0){
            //window.open(url + "blink.html", "_self").close();
        } else if (navigator.appVersion.indexOf("MSIE 9.0") >= 0){
            //window.open(url + "blink.html", "_self").close();
        }else {
            self.opener = self;
            //self.close();
        }
    }

</script>

<script src="js/jquery.countdown.js"></script>
<script src="js/SessionTimeCountdown.js"></script>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<!-- ��� ���� Notification -->
<%If Request.Form("Message")<>"" Then
    Dim MessageType, Message
    MessageType=getParameter(Request.Form("MessageType"),"success")
    Message    =getParameter(Request.Form("Message"),"")%>
    <script language='javascript'>
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:5000});
    </script>
<%End If%>
