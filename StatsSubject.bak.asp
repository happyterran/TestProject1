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
        <h2 class="pull-left"><i class="icon-list"></i> 종합통계</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/StatsSubject.asp" class="bread-current">종합통계</a>
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
            '##라인 학과 전형 차수 선택
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
            <%'if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림%>
            <FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" onsubmit="SubjectEdit(this); return false;" testtarget="Root">
                <INPUT TYPE="hidden" name="FormStatsStatsResult" value="">
                <input type="Hidden" name="FormStudentNumber" value="">
                <input type="Hidden" name="FormStatus" value="">
                <input type="Hidden" name="gotoPage" value="">
			<SELECT NAME="FormSelectCount" onchange="MenuForm.submit();" style="width: 150px;">
                <option value=""<%If SelectCount=""Then%> selected<%End If%>>----학과 표시방법----</option>
                <option value="전체"<%If SelectCount="전체"Then%> selected<%End If%>>전체 학과</option>
                <option value="미작업"<%If SelectCount="미작업"Then%> selected<%End If%>>미작업 학과</option>
				<option value="자원부족"<%If SelectCount="자원부족"Then%> selected<%End If%>>자원부족 학과</option>
            </SELECT>
            <button type="button" class="btn" onclick="javascript: document.MenuForm.submit();" style="margin-bottom: 10px;">
                <i class="icon-refresh bigger-120"></i> 새로고침
            </button>	
			<%'##########  전형  ##########  
			StrSql	=				"select Division0, count(*) as count "
			StrSql = StrSql & vbCrLf & "from SubjectTable "
			StrSql = StrSql & vbCrLf & "where Division0<>'' "
			StrSql = StrSql & vbCrLf & "group by Division0 "
			StrSql = StrSql & vbCrLf & "order by Division0"
			'Response.Write StrSql & "<BR>"
			Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormStatsDivision0" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----모집시기----</option>
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
		<%'##########  모집단위 선택  ########## 
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
						<option value="">----학과명----</option>
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
			<%'##########  구분1  ##########  
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
						<option value="">----구분1----</option>
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
			<%'##########  구분2  ##########  
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
						<option value="">-----구분2----</option>
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

			<%'##########  구분3  ##########  
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
						<option value="">-----구분3----</option>
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

			<%'##########  작업차수  ##########%>
            <%
            StrSql =          "select degree , count(*) as count from RegistRecord"
            StrSql = StrSql & vbCrLf & "group by degree"
            StrSql = StrSql & vbCrLf & "order by degree"
            Rs11.Open StrSql, Dbcon
            %>
			<SELECT NAME="FormStatsDegree" onchange="MenuForm.submit();" style="width: 150px;">
				<option value="" <%If Session("FormStatsDegree")="" Then Response.write "selected"%>>----차수----</option>
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
                <i class="icon-ban-circle bigger-120"></i> 선택해제
            </button>
                <%
                Dim Timer1
                Timer1=Timer()
                    '#################################################################################
                    '##학과 구분 조건을 활용한 SubStrSql
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

                '경민대 안철명선생님의 요청으로 결과 조건 부분은 가림
                '세부내역에서 결과를 선택하고 전체통계로 넘어오면 결과 세션이 남아있어서 특정 결과값만 가져오다 보니
                '무조건 MoveNext하면서 가져오므로 한 학과당 필요 레코드 수가 충족되지 않아 에러남
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
                '## 종합통계 - 전체통계
                '##############################
                'Dim Rs1, StrSql
                Set Rs1 = Server.CreateObject("ADODB.Recordset")
                'Response.write Session("StatsDegree")
                StrSql =                   "--미작업(RemainCount) = 정원-등록예정-등록완료"
                StrSql = StrSql & vbCrLf & "--커트라인(RankingCutLine) = 정원+포기+미등록+환불+기환불"
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
				StrSql = StrSql & vbCrLf '// 해당 학과 지원자 COUNT
				StrSql = StrSql & vbCrLf & "left outer join "
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "    select SubjectCode, Count(*) as StudentCount from StudentTable group by SubjectCode"
                StrSql = StrSql & vbCrLf & ") SC"
                StrSql = StrSql & vbCrLf & "on SC.SubjectCode = A.SubjectCode"
				StrSql = StrSql & vbCrLf '// 해당 학과 등록예정 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '6'"   '등록예정
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RPC"
                StrSql = StrSql & vbCrLf & "on RPC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 미결정 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '4'"   '미결정
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") UC"
                StrSql = StrSql & vbCrLf & "on UC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 미연결 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '5'"   '미연결
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") NCC"
                StrSql = StrSql & vbCrLf & "on NCC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 등록완료 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '2'"   '등록완료
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RC"
                StrSql = StrSql & vbCrLf & "on RC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 포기 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '3'"   '포기
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") AC"
                StrSql = StrSql & vbCrLf & "on AC.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 미등록 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '7'"   '미등록
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") NR"
                StrSql = StrSql & vbCrLf & "on NR.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf '// 해당 학과 환불 COUNT
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
                StrSql = StrSql & vbCrLf & "	where A.Result = '10'"   '환불
                StrSql = StrSql & vbCrLf & "	group by C.SubjectCode, A.Result"
                StrSql = StrSql & vbCrLf & ") RF"
                StrSql = StrSql & vbCrLf & "on RF.SubjectCode = A.SubjectCode"
                StrSql = StrSql & vbCrLf & "where 1=1"
                StrSql = StrSql & vbCrLf & " " & SubStrSql & vbCrLf
                '20140826 이종환 : 모집시기, 학과명, 코드, 구분2
                StrSql = StrSql & vbCrLf & "order by a.subject, a.division0 asc, a.division2 desc, a.division1 "
                '모집단위, 구분2, 모집시기, 구분1
                'StrSql = StrSql & vbCrLf & "order by substring(A.SubjectCode,4,2), substring(A.SubjectCode,7,2), substring(A.SubjectCode,1,2), right(A.SubjectCode,1)" 
                'PrintSql StrSql
                'Response.End
                Rs1.CursorLocation = 3
                Rs1.CursorType = 3
                Rs1.LockType = 3
                Rs1.Open StrSql, Dbcon%>

                  <div class="widget" style="margin-top: 0; padding-top: 0;">
                    <div class="widget-head">
                      <div class="pull-left">모집단위 리스트 : <%=Rs1.RecordCount%></div>
                      <div class="widget-icons pull-right">
                      
                        <button type="button" class="btn btn-success" onclick="document.location.href='StatsSubjectFileDownloadExcel.asp';">
                            <i class="icon-save bigger-120"></i> 파일저장
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
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">모집코드</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">모집시기</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">학과명</td>
									<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분1</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분2</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분3</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">지원자</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">정원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">모집</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">변동</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">등록예정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미결정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미연결</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미작업</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">등록완료</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">자원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">포기</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미등록</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">환불</td>
                                </tr>
                              </thead>
                                <%if Rs1.eof then%>
                                    <tbody>
                                    <TR><TD colspan="19" style="height: 40; text-align: center;">모집단위 기록이 없습니다.<BR>
                                    </tbody>
                                <%else%>
                              <tbody>
								<%'161228 이종환 : 자원부족 검색시 상단 총합 감춤%>
								<%If Session("FormSelectCount") <> "자원부족" then%>
                                <TR>
                                    <TD colspan="6" style="background-color: #FFFFFF; text-align: left; padding-left: 165px;"><B>총합</B></TD>
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
                            '변수 초기화   이종환 150213
                            RemainCountSmallSum = 0
                            ShowSum = false
                            '대전보건대 요청 자원이 마이너스 일 때 붉은색으로 표시
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
                                
                                'SubjectBefore 는 MoveNext 직전의 Subject
                                SubjectBefore = Subject
                                Subject = getParameter(Rs1("Subject"), "")
                                'ODR = getParameter(Rs1("ODR"), "")

                                Dim Division2Before
                                'Division2Before 는 MoveNext 직전의 Division2
                                Division2Before = Division2
                                Division2= getParameter(  Rs1("Division2") , "")

                                '이전학과명과 현재학과명이 다르면 ShowSum = true
                                'If ( SubjectBefore <> Subject and SubjectBefore<>"" ) or ( Division2Before<> Division2 and Division2Before<>"") Then 
                                'If SubjectBefore<>"" And (SubjectBefore <> Subject or Division2Before <> Division2) Then
								If SubjectBefore<>"" And (SubjectBefore <> Subject) Then
                                    ShowSum = true
                                End If

                                'QuorumDIffrenceSum 폰트 컬러
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

								'소계는 전체학과 표시일 때만
                                If ShowSum And (SelectCount="" Or SelectCount="전체") Then%>
                                    <TR>
                                        <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">소계</TD>
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
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">모집코드</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">모집시기</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">학과명</td>
									<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분1</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분2</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">구분3</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">지원자</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">정원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">모집</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">변동</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">등록예정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미결정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미연결</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미작업</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">등록완료</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">자원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">포기</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미등록</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">환불</td>

                                    </tr>
                                    <%
                                    If QuorumDIffrenceSum <> 0 Then ShowError = true
                                    '그리고, 0 으로 리셋
                                    StudentCountSum = 0
                                    QuorumSum = 0
                                    QuorumFixSum = 0
                                    QuorumDIffrenceSum = 0
                                    ShowSum=FALSE
                                    '소계합산도 리셋
                                    RegistPlanCountSmallSum     = 0 '등록예정
                                    UndecidedCountSmallSum      = 0 '미결정
                                    NonConnectedCountSmallSum   = 0 '미연결
                                    RemainCountSmallSum         = 0 '미작업
                                    RegistCountSmallSum         = 0 '등록완료
                                    ResourceCountSmallSum       = 0 '자원
									ResourceCountSmallSumMinus	= 0 '자원부족
                                    AbandonCountSmallSum        = 0 '포기
                                    NonRegistCountSmallSum      = 0 '미등록
                                    RefundCountSmallSum         = 0 '환불
                                    '소계 표시했으면 bgcolor='FFFFFF'
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
                                '자원 = 지원자-정원-포기-미등록-환불
                                ResourceCount= StudentCount - Quorum - AbandonCount - NonRegistCount - RefundCount
                                If ResourceCount >=0 Then
                                    '(자원이 0 이상일 경우)
                                    '미작업 = 정원-등록예정-미결정-미연결-등록완료
                                    RemainCount= Quorum - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount
									'RemainCount= Quorum + RegistCount - RegistCount
                                Else
                                    '(자원이 0보다 작을경우)
                                    '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(제외)
                                    '미작업 = 지원자-(등록예정+미결정+미연결+등록완료)-(포기+미등록+환불)
                                    '미작업 = 지원자-등록예정-미결정-미연결-등록완료-포기-미등록-환불
                                    RemainCount= StudentCount - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount - AbandonCount - NonRegistCount - RefundCount
                                End If
                                
                                '소계합산
                                RegistPlanCountSmallSum = RegistPlanCountSmallSum + RegistPlanCount                   '등록예정
                                UndecidedCountSmallSum = UndecidedCountSmallSum + UndecidedCount                      '미결정
                                NonConnectedCountSmallSum = NonConnectedCountSmallSum +NonConnectedCount              '미연결
                                If RemainCount > 0 Then RemainCountSmallSum = RemainCountSmallSum + RemainCount       '미작업
                                RegistCountSmallSum = RegistCountSmallSum + RegistCount                               '등록완료
                                If ResourceCount >= 0 Then 
									ResourceCountSmallSum = ResourceCountSmallSum+ResourceCount '자원소계
								Else
									ResourceCountSmallSumMinus = ResourceCountSmallSumMinus+ResourceCount '자원소계 마이너스
								End If
                                AbandonCountSmallSum = AbandonCountSmallSum + AbandonCount                            '포기
                                NonRegistCountSmallSum = NonRegistCountSmallSum + NonRegistCount                      '미등록
                                RefundCountSmallSum = RefundCountSmallSum + RefundCount                               '환불
                                '총계합산
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
								RemainCountSum = RemainCountSum + RemainCount	'미작업총계
                                If ResourceCount >= 0 Then
                                    ResourceCountSum = ResourceCountSum + ResourceCount	'자원총계
								Else
                                    ResourceCountSumMinus = ResourceCountSumMinus + ResourceCount	'자원총계
                                End If

                                QuorumDIffrence=Quorum-QuorumFix
                                QuorumDIffrenceTemp=QuorumDIffrence
                                QuorumDIffrenceTemp=cStr(QuorumDIffrenceTemp)
                                
                                'QuorumDIffrence 폰트 컬러
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
                                'ResourceCount 폰트 컬러
                                If ResourceCount<0 Then
                                    ResourceCountColor="#FF0000"
                                End If

                                'Sum 누적
                                StudentCountSum = StudentCountSum + StudentCount
                                QuorumSum = QuorumSum + Quorum
                                QuorumFixSum = QuorumFixSum + QuorumFix
                                QuorumDIffrenceSum = QuorumDIffrenceSum + QuorumDIffrence
								
								'자원부족 학과 기록
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
								<%'전체표시 또는 미작업 학과만 표시 또는 자원이 마이너스인 학과만 표시
								If (SelectCount="" Or SelectCount="전체") Or ( SelectCount="미작업" And ( UndecidedCount>0 Or NonConnectedCount>0 Or RemainCount>0 ) ) Or ( SelectCount="자원부족" And ( ResourceCount < 0  ) ) Then
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

                            'QuorumDiffrenceSum 폰트 컬러
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
								<%'소계는 전체학과 표시일 때만
								If (SelectCount="" Or SelectCount="전체") then%>
                                <TR>
                                    <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">소계</TD>
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

                                <!-- ########## 총 합 ########## -->
                                <%'QuorumDiffrenceSum 총합 폰트 컬러
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
								
								'상단 총계는 전체학과 표시일 때만
                                If (SelectCount="" Or SelectCount="전체") Then%>
                                <tr>
                                    <td colspan="6" style="padding: 7px 0px 6px 0px; text-align: center;"></td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid; border-right: #AAA 2px solid;">지원자</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">정원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid">모집</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">변동</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: #AAA 2px solid">등록예정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미결정</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미연결</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미작업</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">등록완료</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: #AAA 2px solid;">자원</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">포기</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">미등록</td>
                                    <td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">환불</td>
                                </tr>
                                <TR>
                                    <TD colspan="6" style="background-color: #FFFFFF; text-align: left; padding-left: 165px;"><B>총합</B></TD>
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
                                                <button type="button" class="btn btn-primary" onclick="SubjectEdit(document.MenuForm);">모집단위 수정</button>
                                                <button type="button" class="btn btn-danger" onclick='SubjectDelete(document.MenuForm);'>모집단위 삭제</button> -->
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
<SCRIPT LANGUAGE="JavaScript">//window.onload = function(){alert('변동소계가 0 이 아닌 전형이 있습니다. 모집인원을 정확히 확인해 주세요.');}</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">//$(window).load(function(){$("#myModalRootLabel").text("모집단위 관리");$("#myModalRootMessage").html("변동소계가 0 이 아닌 전형이 있습니다. <br>모집인원을 정확히 확인해 주세요.");$("#myModalRootButton").click();})</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">$(window).load(function(){noty({text: '변동소계가 0 이 아닌 모집단위가 있습니다. <br>모집인원을 정확히 확인해 주세요.',layout:'top',type:'error',timeout:5000});})</SCRIPT>
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

<!-- 결과 적용 Notification -->
<%If Request.Form("Message")<>"" Then
    Dim MessageType, Message
    MessageType=getParameter(Request.Form("MessageType"),"success")
    Message    =getParameter(Request.Form("Message"),"")%>
    <script language='javascript'>
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:5000});
    </script>
<%End If%>
