
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
<TR>
	<TD>&nbsp;FormSubjectStatsResult</TD>
	<TD>&nbsp;<%=Request.Form("FormSubjectStatsResult")%></TD>
	<TD>&nbsp;<%=session("FormSubjectStatsResult")%></TD>
</TR>
</TABLE>
 -->
<%
'response.end
'##############################
'## 라인 정보 유지를 위한 방법 (종료 후에도 상담원만)
'##############################
Response.Cookies("METIS").Expires = Date + 1000
if Request.Cookies("METIS")("FormUsedLine") <> "" and Session("Grade")<>"관리자" then Session("FormUsedLine") = Request.Cookies("METIS")("FormUsedLine")

'On Error Resume Next
'##############################
'##페이징 정보 유지를 위한 방법 (녹취 후에도)
'##############################
if Request.Form("FormDivision0")<>"" or Request.Form("FormSubject")<>"" or Request.Form("FormDivision1")<>"" or Request.Form("FormDivision2")<>"" or Request.Form("FormDivision3")<>"" then
	Session("RemainGotoPage") = ""
end if
'##############################
'##일반전화(GENERALCALL) 선택
'##############################
Dim winsock1
if Request.Form("GeneralCall") = "on" then
    StrSql = StrSql & vbCrLf & "	Update LineOrder"
    StrSql = StrSql & vbCrLf & "	set LineOrder = 'GENERALCALL'"
    StrSql = StrSql & vbCrLf & "	, OrderConfirm = '1'"
    StrSql = StrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"
	Dbcon.Execute StrSql
end if
if Request.Form("GeneralCall") = "off" then
    StrSql = StrSql & vbCrLf & "	Update LineOrder"
    StrSql = StrSql & vbCrLf & "	set LineOrder = 'ONHOOK'"
    StrSql = StrSql & vbCrLf & "	, OrderConfirm = '1'"
    StrSql = StrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"
	Dbcon.Execute StrSql
end if
'명령 전달 검사 후 전달에 성공하면
if Err.Description = "" then
	if Request.Form("GeneralCall") = "on" then Session("GeneralCall") = "on"
	if Request.Form("GeneralCall") = "off" then Session("GeneralCall") = "off"
else
	'명령전달 실패
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description & "');</SCRIPT>"
	Err.Clear 
end if
'##############################
'##특정결과 지원자만 보기 위한 방법
'##############################
'If Request.Form("FormSubjectStatsResult") <> "" then
session("FormSubjectStatsResult") = Request.Form("FormSubjectStatsResult")
'End If
If session("FormSubjectStatsResult") = "" Then session("FormSubjectStatsResult") = 0

'##############################
'##라인 학과 전형 차수 선택
'##############################
Dim StrSql, i, Count
'세션에 사용라인, 모집단위코드, 전형코드, 상태코드, 차수 기록됨 한번 학과를 셀렉트 하면 이후 값들을 폼에 넣고 넘기면서 보관할 필요 없이 세션에 저장해서 계속 유지
if Session("Grade")<>"관리자" then
	if Request.Form("FormDivision3")<>"" then
		Session("FormDivision3") = Request.Form("FormDivision3")
	end if
	if Request.Form("FormDivision2")<>"" and Request.Form("FormDivision2") <> Session("FormDivision2") then 
		Session("FormDivision2") = Request.Form("FormDivision2")
		Session("FormDivision3") = ""
		Session("FormSubjectCode") = ""
	end if
	if Request.Form("FormDivision1")<>"" and Request.Form("FormDivision1") <> Session("FormDivision1") then 
		Session("FormDivision1") = Request.Form("FormDivision1")
		Session("FormDivision2") = ""
		Session("FormDivision3") = ""
		Session("FormSubjectCode") = ""
	end If
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
	end if
	if Request.Form("FormUsedLine")<>"" and Request.Form("FormUsedLine") <> Session("FormUsedLine") then 
		Session("FormUsedLine") = Request.Form("FormUsedLine")
		Response.Cookies("METIS")("FormUsedLine") = Session("FormUsedLine")
		Session("FormDivision0") = ""
		Session("FormDivision1") = ""
		Session("FormSubject") = ""
		Session("FormDivision2") = ""
		Session("FormDivision3") = ""
		Session("FormSubjectCode") = ""
	end if
else
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
	end if
	'*표시 제거
	Session("FormDivision0")  = Replace(Session("FormDivision0"),"*","")
	Session("FormDivision1")  = Replace(Session("FormDivision1"),"*","")
	Session("FormSubject")    = Replace(Session("FormSubject"),"*","")
	Session("FormDivision2")  = Replace(Session("FormDivision2"),"*","")
	Session("FormDivision3")  = Replace(Session("FormDivision3"),"*","")
	Session("FormSubjectCode")= Replace(Session("FormSubjectCode"),"*","")
	if Request.Form("FormUsedLine")<>"" and Request.Form("FormUsedLine") <> Session("FormUsedLine") then 
		Session("FormUsedLine") = Request.Form("FormUsedLine")
		Response.Cookies("METIS")("FormUsedLine") = Session("FormUsedLine")
	end If
	if Request.Form("SearchString")<>"" and Request.Form("FormUsedLine") <> Session("FormUsedLine") then 
		Session("SearchString") = Request.Form("SearchString")
	end if
end If
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
StrSql = "select * from Member where MemberID='" & Session("MemberID") & "'"
Rs11.Open StrSql, Dbcon
if Rs11.EOF=false then
	Session("MemberSubjectA") = Rs11("MemberSubjectA")
	Session("MemberSubjectB") = Rs11("MemberSubjectB")
'	Session("MemberSubjectC") = Rs11("MemberSubjectC")
	Session("MemberDivision0") = Rs11("MemberDivision0")
	Session("MemberDivision1") = Rs11("MemberDivision1")
    Session("Position")        = Rs11("Position")
end if
Rs11.Close
if Session("MemberSubject")<>"" and Session("FormSubject")<>"" and Session("MemberSubject") <> Session("FormSubject")  then
	Session("FormSubject") = ""
	Session("FormDivision0") = ""
	Session("FormDivision1") = ""
	Session("FormDivision2") = ""
	Session("FormDivision3") = ""
	Session("FormSubjectCode") = ""
end if
%>
<%'=Session("MemberSubjectA")%>
<%'=Session("MemberSubjectb")%>
<%'=Session("MemberSubjectc")%>
<%'=Session("MemberSubjectd")%>
<%'if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림%>
<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" testtarget="Root">
	<INPUT TYPE="hidden" name="FormSubjectStatsResult" value="">
    <input type="Hidden" name="FormStudentNumber" value="">
    <input type="Hidden" name="FormStatus" value="">
    <input type="Hidden" name="gotoPage" value="">
	
	<%if Session("Grade")="관리자" then%>
		<!--
		<input type="Hidden" name="SearchTitle1" value="StudentNumber">
		<input type="text" name="SearchString1" value="<%=Request.Form("SearchString")%>" style="width: 127px; border-right: 0;" onkeydown="EnterKeyDown1(this.form);" placeholder="수험번호">
		<button type="button" class="btn" style="margin-bottom: 10px;" onclick="this.form.submit();">검색</button>
		-->
	<%End If%>

    <%'##########  라인선택, 서버주소, 서버포트, 학교명  ##########  
    if Session("Grade")<>"관리자" then
        StrSql	= "select top 1 * from SettingTable order by IDX Desc"
        Rs11.Open StrSql, Dbcon, 1, 1%>

            <SELECT NAME="FormUsedLine" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then
                    TotalLine = Rs11("TotalLine")
                    Session("HostAddress") = Rs11("HostAddress")
                    Session("HostPort") = Rs11("HostPort")
                    Session("SMSConfirm") = Rs11("SMSConfirm")
                    Session("SMSAutoConfirm") = Rs11("SMSAutoConfirm")
                    Session("UniversityName") = Rs11("UniversityName")
                    Session("CallBack") = Rs11("CallBack")
                    Session("SMSBodyRegistrationFee") = Rs11("SMSBodyRegistrationFee")
                    Session("SMSBodyAccountNumber") = Rs11("SMSBodyAccountNumber")
                    Session("SMSBodyRegistrationTime") = Rs11("SMSBodyRegistrationTime")%>
                    <option value="">----라인----</option>
                    <%for i = 1 to TotalLine%>
                        <option value="<%=i%>" <%if Session("FormUsedLine")=cStr(i) then response.write "selected"%>><%=cStr(i) & "번 라인"%></option>
                    <%Next%>
                <%else%>
                    <option value="">라인 미입력</option>
                <%end if%>
            </SELECT>

        <%Rs11.close
    end if
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

            <SELECT NAME="FormDivision0" id="FormDivision0" onchange="MenuForm.submit();" style="width: 150px;">
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
    '##########  전형  ##########  
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
    '##########  기타  ##########  
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

    <%'##########  라인선택, 서버주소, 서버포트, 학교명  ##########  
    if Session("Grade")="관리자" then
        StrSql	= "select top 1 * from SettingTable order by IDX Desc"
        Rs11.Open StrSql, Dbcon, 1, 1%>

            <SELECT NAME="FormUsedLine" onchange="MenuForm.submit();" style="width: 150px;">
                <%if Rs11.RecordCount > 0 then
                    TotalLine = Rs11("TotalLine")
                    Session("HostAddress") = Rs11("HostAddress")
                    Session("HostPort") = Rs11("HostPort")
                    Session("SMSConfirm") = Rs11("SMSConfirm")
                    Session("SMSAutoConfirm") = Rs11("SMSAutoConfirm")
                    Session("UniversityName") = Rs11("UniversityName")
                    Session("CallBack") = Rs11("CallBack")
                    Session("SMSBodyRegistrationFee") = Rs11("SMSBodyRegistrationFee")
                    Session("SMSBodyAccountNumber") = Rs11("SMSBodyAccountNumber")
                    Session("SMSBodyRegistrationTime") = Rs11("SMSBodyRegistrationTime")%>
                    <option value="">----라인----</option>
                    <%for i = 1 to TotalLine%>
                        <option value="<%=i%>" <%if Session("FormUsedLine")=cStr(i) then response.write "selected"%>><%=cStr(i) & "번 라인"%></option>
                    <%Next%>
                <%else%>
                    <option value="">라인 미입력</option>
                <%end if%>
            </SELECT>
            <button type="button" class="btn" onclick="javascript: document.location.href='UsedLineAbandon.asp';" style="margin-bottom: 10px;">
                <i class="icon-ban-circle bigger-120"></i> 라인해제
            </button>


            <!-- <A HREF="UsedLineAbandon.asp"><IMG SRC="../Images/Stop.gif" WIDTH="19" HEIGHT="22" BORDER=0 ALT="라인해제"></A> -->

        <%Rs11.close
    end if%>

<!-- </FORM> -->

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
					if Session("FormDegree")="" then 
						Response.Write " 차수 미설정 "
					else
						Response.Write " 제 " & Session("FormDegree") & " 차 충원 작업중..."
					end if

			Response.Write "</font>"
		else
			Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('새로고침 할 수 없습니다. 학과 선택 오류 입니다. 다시 로그인 해 주세요.')</SCRIPT>"
		end if
		Rs11.Close
else
'##############################
'##학과 미선택시 로그인 상태 표시
'##############################
	Response.Write "<TABLE border=0><TR><TD><Font Size=3><b>"
    Response.Write " " & Session("MemberID") & "님 "
	Response.Write "</b></font> &nbsp; - &nbsp; (작업대상을 선택하세요) </TD></TR></TABLE>"
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
 -->
