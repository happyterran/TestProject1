<%'############################
'##���� �а� ���� ���� ����
'##############################
Dim StrSql, i, Count
'���ǿ� ������, ���������ڵ�, �����ڵ�, �����ڵ�, ���� ��ϵ� �ѹ� �а��� ����Ʈ �ϸ� ���� ������ ���� �ְ� �ѱ�鼭 ������ �ʿ� ���� ���ǿ� �����ؼ� ��� ����
'	If Request.Form("FormSubjectDivision3") <> Session("FormSubjectDivision3") Then 
		Session("FormSubjectDivision3") = Request.Form("FormSubjectDivision3")
'	End If
'	If Request.Form("FormSubjectDivision2") <> Session("FormSubjectDivision2") Then 
		Session("FormSubjectDivision2") = Request.Form("FormSubjectDivision2")
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectDivision1") <> Session("FormSubjectDivision1") Then 
		Session("FormSubjectDivision1") = Request.Form("FormSubjectDivision1")
'		Session("FormSubjectDivision2") = ""
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectSubject") <> Session("FormSubjectSubject") Then
		Session("FormSubjectSubject") = Request.Form("FormSubjectSubject")
'		Session("FormSubjectDivision1") = ""
'		Session("FormSubjectDivision2") = ""
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
'	If Request.Form("FormSubjectDivision0") <> Session("FormSubjectDivision0") Then 
		Session("FormSubjectDivision0") = Request.Form("FormSubjectDivision0")
'		Session("FormSubjectSubject") = ""
'		Session("FormSubjectDivision1") = ""
'		Session("FormSubjectDivision2") = ""
'		Session("FormSubjectDivision3") = ""
'		Session("FormSubjectCode") = ""
'	End If
Session("FormResult") = GetIntParameter( Request.Form("FormResult") ,0)
Session("FormMemberID") = Request.Form("FormMemberID")
Session("FormResultType") = Request.Form("FormResultType")
Session("FormDegree") = trim(Request.Form("FormDegree"))

'If Session("FormSubjectDivision3")="" Then Session("FormSubjectDivision3") = ""
'If Session("FormSubjectDivision2")="" Then Session("FormSubjectDivision2") = ""
'If Session("FormSubjectDivision1")="" Then Session("FormSubjectDivision1") = ""
'If Session("FormSubjectDivision0")="" Then Session("FormSubjectDivision0") = ""
'If Session("FormSubjectSubject")="" Then Session("FormSubjectSubject") = ""
'If Session("FormResult")="" Then Session("FormResult") = ""
'If Session("FormMemberID")="" Then Session("FormMemberID") = ""
'If Session("FormResultType")="" Then Session("FormResultType") = ""
'If Session("FormDegree")="" Then Session("FormDegree") = ""

%>
<!-- 
<TABLE border=1>
<TR>
	<TD>FormUsedLine</TD>
	<TD><%=Request.Form("FormUsedLine")%></TD>
	<TD><%=Session("FormUsedLine")%></TD>
	<TD>FormSubject</TD>
	<TD><%=Request.Form("FormSubject")%></TD>
	<TD><%=Session("FormSubject")%></TD>
</TR>
<TR>
	<TD>FormDivision0</TD>
	<TD><%=Request.Form("FormDivision0")%></TD>
	<TD><%=Session("FormDivision0")%></TD>
	<TD>FormDivision1</TD>
	<TD><%=Request.Form("FormDivision1")%></TD>
	<TD><%=Session("FormDivision1")%></TD>
</TR>
<TR>
	<TD>FormDivision2</TD>
	<TD><%=Request.Form("FormDivision2")%></TD>
	<TD><%=Session("FormDivision2")%></TD>
	<TD>FormDivision3</TD>
	<TD><%=Request.Form("FormDivision3")%></TD>
	<TD><%=Session("FormDivision3")%></TD>
</TR>
<TR>
	<TD>FormDegree</TD>
	<TD><%=Request.Form("FormDegree")%></TD>
	<TD><%=Session("FormDegree")%></TD>
	<TD>FormSubjectCode</TD>
	<TD><%=Request.Form("FormSubjectCode")%></TD>
	<TD><%=Session("FormSubjectCode")%></TD>
</TR>
</TABLE>
 -->
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
<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" onsubmit="RegistEdit(this); return false;" testtarget="Root">
	<INPUT TYPE="hidden" name="FormSubjectStatsResult" value="">
    <input type="Hidden" name="FormStudentNumber" value="">
    <input type="Hidden" name="FormStatus" value="">
    <input type="Hidden" name="GotoPage" value="<%=Request.Form("GotoPage")%>">
	<input type="text" name="SearchString" value="<%=Request.Form("SearchString")%>" style="width: 127px; border-right: 0;" onkeydown="EnterKeyDown1(this.form);" placeholder="�����ȣ or �̸�">
	<button type="button" class="btn" style="margin-bottom: 11px;" onclick="this.form.submit();">�˻�</button>

			<%'##########  ����  ##########  
			StrSql	=				"select Division0, count(*) as count "
			StrSql = StrSql & vbCrLf & "from SubjectTable "
			StrSql = StrSql & vbCrLf & "where Division0<>'' "
			StrSql = StrSql & vbCrLf & "group by Division0 "
			StrSql = StrSql & vbCrLf & "order by Division0"
			'Response.Write StrSql & "<BR>"
			Rs11.Open StrSql, Dbcon
            If Rs11.BOF = false Then%>
                <SELECT NAME="FormSubjectDivision0" onchange="MenuForm.submit();" style="width: 150px;">
                    <option value="">----�����ñ�----</option>
                    <%do Until Rs11.EOF
                        DivisionTemp = Rs11("Division0")%>
                        <option value="<%=DivisionTemp%>" <%
                            If Session("FormSubjectDivision0")=DivisionTemp Then 
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
			'If Session("FormSubjectDivision0")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormSubjectDivision0")<>"" and Session("CountTemp") >= 1 Then
				StrSql	=				"select Subject, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormSubjectDivision0") & "' "
				StrSql = StrSql & vbCrLf & "where Subject<>'' "
				StrSql = StrSql & vbCrLf & "group by Subject "
				'StrSql = StrSql & vbCrLf & "order by min(SubjectCode)"
				StrSql = StrSql & vbCrLf & "order by Subject"
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormSubjectSubject" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----�а���----</option>
						<%do Until Rs11.EOF
							SubjectTemp = Rs11("Subject")%>
							<option value="<%=SubjectTemp%>" <%
								If Session("FormSubjectSubject") = SubjectTemp Then 
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
			'If Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division1, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormSubjectSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormSubjectDivision0") & "' "
				StrSql = StrSql & vbCrLf & "where Division1<>'' "
				StrSql = StrSql & vbCrLf & "group by Division1 "
				StrSql = StrSql & vbCrLf & "order by Division1 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormSubjectDivision1" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">----����1----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division1")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormSubjectDivision1")=DivisionTemp Then 
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
			'If Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("FormSubjectDivision1")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("FormSubjectDivision1")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division2, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormSubjectSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormSubjectDivision0") & "' "
				'StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormSubjectDivision1") & "' "
				StrSql = StrSql & vbCrLf & "where Division2<>'' "
				StrSql = StrSql & vbCrLf & "group by Division2 "
				StrSql = StrSql & vbCrLf & "order by Division2 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormSubjectDivision2" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">-----����2----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division2")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormSubjectDivision2")=DivisionTemp Then 
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
			'If Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("FormSubjectDivision1")<>"" and Session("FormSubjectDivision2")<>"" and Session("CountTemp") >= 1 Then
			If true or Session("FormSubjectSubject")<>"" and Session("FormSubjectDivision0")<>"" and Session("FormSubjectDivision1")<>"" and Session("FormSubjectDivision2")<>"" and Session("CountTemp") >= 1 Then
				StrSql =          "select Division3, count(*) as count "
				StrSql = StrSql & vbCrLf & "from SubjectTable "
				'StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormSubjectSubject") & "' "
				'StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormSubjectDivision0") & "' "
				'StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormSubjectDivision1") & "' "
				'StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormSubjectDivision2") & "' "
				StrSql = StrSql & vbCrLf & "where Division3<>'' "
				StrSql = StrSql & vbCrLf & "group by Division3 "
				StrSql = StrSql & vbCrLf & "order by Division3 "
				'Response.Write StrSql & "<BR>"
				Rs11.Open StrSql, Dbcon
				If Rs11.BOF = false Then%>
					<SELECT NAME="FormSubjectDivision3" onchange="MenuForm.submit();" style="width: 150px;">
						<option value="">-----����3----</option>
						<%do Until Rs11.EOF
							DivisionTemp = Rs11("Division3")%>
							<option value="<%=DivisionTemp%>" <%
								If Session("FormSubjectDivision3")=DivisionTemp Then 
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

	<%
	StrSql =          "select degree , count(*) as count from RegistRecord"
	StrSql = StrSql & vbCrLf & "group by degree"
	StrSql = StrSql & vbCrLf & "order by degree"
	Rs11.Open StrSql, Dbcon
	%>
            <!-- 
			<%'##########  �۾�����  ##########%>
			<SELECT NAME="FormDegree" onchange="MenuForm.submit();" style="width: 70;">
				<option value="" <%If Session("FormDegree")="" Then Response.write "selected"%>>--�۾�����--</option>
				<%If Rs11.BOF = false Then%>
					<%do Until Rs11.eof
						DegreeTemp = Rs11("Degree")%>
						<option value="<%=DegreeTemp%>" <%If cstr(Session("FormDegree"))=cstr(DegreeTemp) Then Response.write "selected"%>><%=DegreeTemp%></option>
						<%Rs11.movenext%>
					<%loop%>
				<%End If%>
				<%Rs11.Close%>
			</SELECT> -->

<%
Set Rs11 = Nothing
%>