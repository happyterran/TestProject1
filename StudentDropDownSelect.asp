<%
'##############################
'##라인 학과 전형 차수 선택
'##############################
Dim StrSql, i, Count
'세션에 사용라인, 모집단위코드, 전형코드, 상태코드, 차수 기록됨 한번 학과를 셀렉트 하면 이후 값들을 폼에 넣고 넘기면서 보관할 필요 없이 세션에 저장해서 계속 유지
if Request.Form("FormDivision3")<>"" then
    Session("FormDivision3") = Request.Form("FormDivision3")
end if
if Request.Form("FormDivision2")<>"" and Request.Form("FormDivision2") <> Session("FormDivision2") then 
    Session("FormDivision2") = Request.Form("FormDivision2")
    Session("FormDivision3") = ""
    Session("FormSubjectCode") = ""
end If
if Request.Form("FormDivision1")<>"" and Request.Form("FormDivision1") <> Session("FormDivision1") then 
    Session("FormDivision1") = Request.Form("FormDivision1")
    Session("FormDivision2") = ""
    Session("FormDivision3") = ""
    Session("FormSubjectCode") = ""
end if
if Request.Form("FormSubject")<>"" and Request.Form("FormSubject") <> Session("FormSubject") then
    Session("FormSubject") = Request.Form("FormSubject")
    Session("FormDivision1") = ""
    Session("FormDivision2") = ""
    Session("FormDivision3") = ""
    Session("FormSubjectCode") = ""
end if
if Request.Form("FormDivision0")<>"" and Request.Form("FormDivision0") <> Session("FormDivision0") then 
    Session("FormDivision0") = Request.Form("FormDivision0")
    Session("FormDivision1") = ""
    Session("FormSubject") = ""
    Session("FormDivision2") = ""
    Session("FormDivision3") = ""
    Session("FormSubjectCode") = ""

end If
'*표시 제거
Session("FormDivision0")  = Replace(Session("FormDivision0"),"*","")
Session("FormDivision1")  = Replace(Session("FormDivision1"),"*","")
Session("FormSubject")    = Replace(Session("FormSubject"),"*","")
Session("FormDivision2")  = Replace(Session("FormDivision2"),"*","")
Session("FormDivision3")  = Replace(Session("FormDivision3"),"*","")
Session("FormSubjectCode")= Replace(Session("FormSubjectCode"),"*","")
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
<%'if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림%>
<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" onsubmit="StudentEdit(this); return false;" testtarget="Root">
	<INPUT TYPE="hidden" name="FormSubjectStatsResult" value="">
    <input type="Hidden" name="FormStudentNumber" value="">
    <input type="Hidden" name="FormStatus" value="">
    <input type="Hidden" name="GotoPage" value="<%=Request.Form("GotoPage")%>">
    <input type="text" name="SearchString" value="<%=Request.Form("SearchString")%>" style="width: 127px; border-right: 0;" onkeydown="EnterKeyDown1(this.form);" placeholder="수험번호 or 이름">
    <input type="Hidden" name="SearchTitle" value="StudentNumber">
    <input type="Hidden" name="Abandon" value="">
    <!-- 
    <SELECT NAME="SearchTitle" style="width: 150px;">
        <option value="StudentNumber" <%If Request.Form("SearchTitle")="StudentNumber" Then%>selected<%End If%>>수험번호</option>
        <option value="StudentName" <%If Request.Form("SearchTitle")="StudentName" Then%>selected<%End If%>>이름</option>
        <option value="Citizen1" <%If Request.Form("SearchTitle")="Citizen1" Then%>selected<%End If%>>주민번호</option>
    </SELECT> -->
    <button type="button" class="btn" style="margin-bottom: 10px;" onclick="this.form.submit();">검색</button>

    <%
    '##########  모집시기  ##########  
    if Session("FormUsedLine") <>"" or Session("Grade")="관리자" then
        StrSql	=				"select Division0, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where Division0<>'' "
        if Session("MemberDivision0") <> "" then
            StrSql = StrSql & vbCrLf & "and Division0='" & Session("MemberDivision0") & "' "
        end if
        StrSql = StrSql & vbCrLf & "group by Division0 "
        StrSql = StrSql & vbCrLf & "order by Division0"
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1%>

            <SELECT NAME="FormDivision0" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---모집시기---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division0")%>
                        <%'if Session("Grade")<>"관리자" and DivisionTemp="정시1차" then%>
                        <%'else%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormDivision0")=DivisionTemp then 
                                response.write "selected"
                                Session("CountTemp") = Rs11("Count")
                            end if
                        %>><%=DivisionTemp%></option>
                        <%'end if%>
                        <%Rs11.MoveNext%>
                    <%Next%>
                <%else%>
                    <option value="">모집시기 미입력</option>
                <%end if%>
            </SELECT>

    <%Rs11.close
    end If
    '##########  모집단위 선택  ##########  
    if Session("FormUsedLine")<>"" and Session("FormDivision0")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormDivision0")<>"" and Session("CountTemp") >= 1) then
    
    
        Dim SubStrSql
        SubStrSql = ""
        if Session("MemberSubjectA") <> "" then
            SubStrSql = SubStrSql & "Subject='" & Session("MemberSubjectA") & "' "
        end if
        if Session("MemberSubjectB") <> "" then
            if SubStrSql <> "" then
                SubStrSql = SubStrSql & "or "
            end if
            SubStrSql = SubStrSql & "Subject='" & Session("MemberSubjectB") & "' "
        end if
'			if Session("MemberSubjectC") <> "" then
'				if SubStrSql <> "" then
'					SubStrSql = SubStrSql & "or "
'				end if
'				SubStrSql = SubStrSql & "Subject='" & Session("MemberSubjectC") & "' "
'			end if
'			if Session("MemberSubjectD") <> "" then
'				if SubStrSql <> "" then
'					SubStrSql = SubStrSql & "or "
'				end if
'				SubStrSql = SubStrSql & "Subject='" & Session("MemberSubjectD") & "' "
'			end if
        StrSql	=		"select Subject, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormDivision0") & "' "
        if SubStrSql <> "" then
        StrSql = StrSql & vbCrLf & "and ( "& SubStrSql & ") "
        end if
        StrSql = StrSql & vbCrLf & "and Subject<>'' "
        StrSql = StrSql & vbCrLf & "group by Subject "
        'StrSql = StrSql & vbCrLf & "order by min(SubjectCode)"
		StrSql = StrSql & vbCrLf & "order by Subject"
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormSubject" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---학과명---</option>
                    <%for i = 1 to Rs11.RecordCount
                        'SubjectCodeTemp = Rs11("SubjectCode")
                        SubjectTemp = Rs11("Subject")%>
                        <option value="<%=SubjectTemp%>" <%
                            if Session("FormSubject") = SubjectTemp then 
                                response.write "selected"
                                Session("CountTemp") = Rs11("Count")
                            end if
                        %>><%=SubjectTemp%></option>
                        <%Rs11.MoveNext%>
                    <%Next%>
                <%else%>
                    <option value="">학과 미입력</option>
                <%end if%>
            </SELECT>

        <%Else
            Session("CountTemp") = 0
        End if
        Rs11.close
    end if    
    '##########  구분1  ##########  
    if Session("FormUsedLine")<>"" and Session("FormDivision0")<>"" and Session("FormSubject")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormDivision0")<>"" and Session("FormSubject")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division1, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where 1=1 "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division1<>'' "
        if Session("MemberDivision1") <> "" then
            StrSql = StrSql & vbCrLf & "and Division1='" & Session("MemberDivision1") & "' "
        end if
        StrSql = StrSql & vbCrLf & "group by Division1 "
        StrSql = StrSql & vbCrLf & "order by Division1 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision1" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---구분1---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division1")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormDivision1")=DivisionTemp then 
                                response.write "selected"
                                Session("CountTemp") = Rs11("Count")
                            end if
                        %>><%=DivisionTemp%></option>
                        <%Rs11.MoveNext%>
                    <%Next%>
                <%else%>
                    <option value="">구분1 미입력</option>
                <%end if%>
            </SELECT>

        <%Else
            Session("CountTemp") = 0
        End if
        Rs11.close
    end if

    '##########  구분2  ##########  
    if Session("FormUsedLine")<>"" and Session("FormDivision0")<>"" and Session("FormDivision1")<>"" and Session("FormSubject")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormDivision0")<>"" and Session("FormDivision1")<>"" and Session("FormSubject")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division2, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where 1=1 "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormDivision1") & "' "
        StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division2<>'' "
        StrSql = StrSql & vbCrLf & "group by Division2 "
        StrSql = StrSql & vbCrLf & "order by Division2 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision2" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---구분2---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division2")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormDivision2")=DivisionTemp then 
                                response.write "selected"
                                Session("CountTemp") = Rs11("Count")
                            end if
                        %>><%=DivisionTemp%></option>
                        <%Rs11.MoveNext%>
                    <%Next%>
                <%else%>
                    <option value="">구분2 미입력</option>
                <%end if%>
            </SELECT>

        <%Else
            Session("CountTemp") = 0
        End if
        Rs11.close
    end if
    '##########  구분3  ##########  
    if Session("FormUsedLine")<>"" and Session("FormDivision0")<>"" and Session("FormSubject")<>"" and Session("FormDivision1")<>"" and Session("FormDivision2")<>"" and Session("CountTemp") >= 1  or ( Session("Grade")="관리자" and Session("FormDivision0")<>"" and Session("FormSubject")<>"" and Session("FormDivision1")<>"" and Session("FormDivision2")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division3, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormDivision1") & "' "
        StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormDivision2") & "' "
        StrSql = StrSql & vbCrLf & "and Division3<>'' "
        StrSql = StrSql & vbCrLf & "group by Division3 "
        StrSql = StrSql & vbCrLf & "order by Division3 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision3" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---구분3---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division3")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormDivision3")=DivisionTemp then 
                                response.write "selected"
                                Session("CountTemp") = 0
                            end if
                        %>><%=DivisionTemp%></option>
                        <%Rs11.MoveNext%>
                    <%Next%>
                <%else%>
                    <option value="">구분3 미입력</option>
                <%end if%>
            </SELECT>

        <%Else
            Session("CountTemp") = 0
        End if
        Rs11.close
    end if%>



<%
'Response.Write Session("CountTemp")
'##############################
'##차수 추출 Session("FormDegree")에 입력
'##############################
StrSql	= "select * from Degree2 order by IDX desc"
Rs11.Open StrSql, Dbcon, 1, 1
Dim DegreeSetting
Do Until Rs11.EOF
	If Session("FormDivision0") = Rs11("Division0") Then
		DegreeSetting = 1
		Session("FormDegree") = Rs11("Degree")
		Session("RegistrationTime") = Rs11("RegistrationMonth") & "월"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs11("RegistrationDay") & "일"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs11("RegistrationHour") & "시"
		Session("RegistrationTime") = Session("RegistrationTime") & Rs11("RegistrationMinute") & "분"
		Exit Do
	End If
	Rs11.MoveNext
Loop
'차수설정이 없는것으로 간주하고 Session("FormDegree") = ""
If DegreeSetting = 0 Then
	Session("FormDegree") = ""
	Session("RegistrationTime") = ""
End If
Rs11.Close

'##############################
'##모집단위코드 추출 Session("FormSubjectCode")에 입력
'##############################
if Session("FormUsedLine")<>"" and Session("FormSubject")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 or ( Session("Grade")="관리자" and Session("FormSubject")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0) then
		StrSql =		"select SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum "
		StrSql = StrSql & vbCrLf & "from SubjectTable "
		StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormDivision0") & "' "
		if Session("FormSubject")<>"" then
			StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormSubject") & "' "
			if Session("FormDivision1")<>"" then
				StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormDivision1") & "' "
				if Session("FormDivision2")<>"" then
					StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormDivision2") & "' "
					if Session("FormDivision3")<>"" then
						StrSql = StrSql & vbCrLf & "and Division3='" & Session("FormDivision3") & "' "
					end if
				end if
			end if
		end if
		'Response.Write StrSql
		Rs11.Open StrSql, Dbcon, 1, 1
		if Rs11.RecordCount = 1 then
			if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림
				Session("FormSubjectCode") = Rs11("SubjectCode")	'지원자 세부사항에선 SubjectCode를 한번 더 추출하기 때문에 이 작업은 필요없다
			end if
			Response.Write "<font size='3'>"
			Session("FormDivision0") = Rs11("Division0")
'			Response.Write " " & Session("FormDivision0")
			if Session("FormSubject")<>"" then
				Session("FormSubject") = Rs11("Subject")
'					Response.Write " " & Session("FormSubject")
				if Session("FormDivision1")<>"" then
					Session("FormDivision1") = Rs11("Division1")
	'				Response.Write " " & Session("FormDivision1")
					if Session("FormDivision2")<>"" then
						Session("FormDivision2") = Rs11("Division2")
'						Response.Write " " & Session("FormDivision2")
						if Session("FormDivision3")<>"" then
							Session("FormDivision3") = Rs11("Division3")
'							Response.Write " " & Session("FormDivision3")
						end if
					end if
				end if
			end if

'			Response.Write "  " & Session("MemberID") & "님 "

			'차수설정 체크
'				if Session("FormDegree")="" then 
'						Response.Write " 차수 미설정 "
'				else
'						Response.Write " 제 " & Session("FormDegree") & " 차 충원 작업중..."
'				end if

			Response.Write "</font>"
		else
			'Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('새로고침 할 수 없습니다. 학과 선택 오류 입니다. 다시 로그인 해 주세요.')</SCRIPT>"
            Response.Write "<SCRIPT LANGUAGE='JavaScript'>myModalRootClick('지원자 관리','학과 선택 오류 입니다. 다시 선택해 주세요');</SCRIPT>"
		end if
		Rs11.Close
end if
set Rs11 = Nothing
%>
<%'=Session("FormSubjectCode")%>
<!-- 
<TABLE border=1>
<TR>
	<TD>&nbsp;Parameter</TD>
	<TD>&nbsp;Form</TD>
	<TD>&nbsp;Session</TD>
</TR>
<TR>
	<TD>&nbsp;FormUsedLine</TD>
	<TD>&nbsp;<%=Request.Form("FormUsedLine")%></TD>
	<TD>&nbsp;<%=Session("FormUsedLine")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormDivision0</TD>
	<TD>&nbsp;<%=Request.Form("FormDivision0")%></TD>
	<TD>&nbsp;<%=Session("FormDivision0")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormSubject</TD>
	<TD>&nbsp;<%=Request.Form("FormSubject")%></TD>
	<TD>&nbsp;<%=Session("FormSubject")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormDivision1</TD>
	<TD>&nbsp;<%=Request.Form("FormDivision1")%></TD>
	<TD>&nbsp;<%=Session("FormDivision1")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormDivision2</TD>
	<TD>&nbsp;<%=Request.Form("FormDivision2")%></TD>
	<TD>&nbsp;<%=Session("FormDivision2")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormDivision3</TD>
	<TD>&nbsp;<%=Request.Form("FormDivision3")%></TD>
	<TD>&nbsp;<%=Session("FormDivision3")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormDegree</TD>
	<TD>&nbsp;<%=Request.Form("FormDegree")%></TD>
	<TD>&nbsp;<%=Session("FormDegree")%></TD>
</TR>
<TR>
	<TD>&nbsp;FormSubjectCode</TD>
	<TD>&nbsp;<%=Request.Form("FormSubjectCode")%></TD>
	<TD>&nbsp;<%=Session("FormSubjectCode")%></TD>
</TR>
</TABLE>
<%=Session("CountTemp")%>
 -->