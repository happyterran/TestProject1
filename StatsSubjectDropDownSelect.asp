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
            Session("FormStatsDegree")		= getParameter(Request.Form("FormStatsDegree"),"255")
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
				StrSql = StrSql & vbCrLf & "from SubjectTable A"
				StrSql = StrSql & vbCrLf & "left outer join SubjectOrder B"
				StrSql = StrSql & vbCrLf & "on A.Subject = B.SubjectOrder"
				'StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormStatsDivision0") & "' "
				StrSql = StrSql & vbCrLf & "where Subject<>'' "
				StrSql = StrSql & vbCrLf & "group by Subject"
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
'				StrSql =          "select Division1, count(*) as count "
'				StrSql = StrSql & vbCrLf & "from SubjectTable "
'				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormStatsSubject") & "' "
'				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
'				StrSql = StrSql & vbCrLf & "where Division1<>'' "
'				StrSql = StrSql & vbCrLf & "group by Division1 "
'				StrSql = StrSql & vbCrLf & "order by Division1 "

				StrSql =          "select Division1, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable A"
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormSubjectSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormSubjectDivision0") & "' "
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