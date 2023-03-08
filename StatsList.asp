<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
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
        <h2 class="pull-left"><i class="icon-zoom-in"></i> 통계 세부내역</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/StatsList.asp" class="bread-current">통계 세부내역</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="span12">




















<FORM METHOD="POST" ACTION="<%=Request.ServerVariables("URL")%>" Name="MenuForm" testtarget="Root">



<%
Session("FormStatsResult") = GetIntParameter( Request.Form("FormResult") ,0)
Session("FormStatsMemberID") = Request.Form("FormMemberID")
Session("FormStatsResultType") = Request.Form("FormResultType")
Session("FormStatsDegree") = trim(Request.Form("FormDegree"))
Session("InsertTime1") = Request.Form("InsertTime1")
Session("InsertTime2") = Request.Form("InsertTime2")
Session("FormStatsOrderType") = GetParameter( Request.Form("FormOrderType") ,"")

Dim SubjectCodeTemp, SubjectTemp, DivisionTemp
Dim TotalLine, HostAddress
Dim Rs11
Set Rs11 = Server.CreateObject("ADODB.Recordset")
'서버주소, 서버포트, 학교명 
StrSql	= "select top 1 * from SettingTable order by IDX Desc"
Rs11.Open StrSql, Dbcon, 1, 1
If Not Rs11.EOF Then
	Session("HostAddress") = Rs11("HostAddress")
	Session("HostPort") = Rs11("HostPort")
	Session("SMSConfirm") = Rs11("SMSConfirm")
	Session("SMSAutoConfirm") = Rs11("SMSAutoConfirm")
	Session("UniversityName") = Rs11("UniversityName")
	Session("CallBack") = Rs11("CallBack")
	Session("SMSBodyRegistrationFee") = Rs11("SMSBodyRegistrationFee")
	Session("SMSBodyAccountNumber") = Rs11("SMSBodyAccountNumber")
	Session("SMSBodyRegistrationTime") = Rs11("SMSBodyRegistrationTime")
End If
Rs11.Close

Dim FormSMSBody
FormSMSBody = Request.Form("FormSMSBody")
If FormSMSBody="" Then FormSMSBody="[" & Session("UniversityName") & "]"&vbLf&"@이름@님"&vbLf&"@학과명@"&vbLf&"추가합격"&vbLf&"전화예정"&vbLf&"대기해주세요"%>
<%'=Session("CallBack")%>






          <div class="row-fluid">
            <div class="span12">

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left"></div>
                  <div class="widget-icons pull-right">
                    <a href="#" class="wminimize" id="subjectStats" onclick="PositionChange()"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
                    <a href="#" class="wclose"><i class="icon-remove"></i></a>
                  </div>  
                  <div class="clearfix"></div>
                </div>
                <div class="widget-content" id="courseStatsWidgetContent" <%If Session("Position") = "menu-min" Then%>xstyle="display: none;"<%end if %>>
                <!-- <div class="widget-content" <%If Session("Position") = "menu-min" Then%>style="display: none;"<%End If%>> -->
                  <div class="padd invoice" style="padding:0;">
                    <div class="row-fluid">

                      <div class="span12">
                        <table class="table table-striped table-hover table-bordered" style="table-layout: fixed;">
                            <colgroup><col width="140"></col><col width=""></col><col width="80"></col><col width="170"></col><col width="70"></col></colgroup>
                            <tbody>
                                <tr>
                                  </td>
                                  <td style="text-align: center; padding-top: 10px;">

                                    <div id="datetimepicker1" class="input-append">
                                        <input data-format="yyyy-MM-dd" type="text" name="InsertTime1" style="margin-bottom: 5px; width: 69px; height: 20px; border-radius: 4px 0 0 4px; " value="<%=Session("InsertTime1")%>" readonly>
                                        <span class="add-on">
                                            <i data-time-icon="icon-time" style="cursor: pointer"></i>
                                        </span>
                                    </div>
                                    <div id="datetimepicker3" class="input-append">
                                        <input data-format="yyyy-MM-dd" type="text" name="InsertTime2" style="margin-bottom: 5px; width: 69px; height: 20px; border-radius: 4px 0 0 4px; " value="<%=Session("InsertTime2")%>" readonly>
                                        <span class="add-on">
                                            <i data-date-icon="icon-calendar" style="cursor: pointer"></i>
                                        </span>
                                    </div>
                                    <button type="button" class="btn " style="margin-bottom: 5px; width: 110px;" onclick="this.form.submit();">
                                        <i class="icon-calendar bigger-200"></i> 날짜 지정
                                    </button>

                                  </td>
                                  <td style="text-align: left; padding-top: 10px;">










<%
Dim DegreeTemp
StrSql =		"select isnull(degree,0) degree, count(*) as count from RegistRecord"
StrSql = StrSql & vbCrLf & "group by degree"
StrSql = StrSql & vbCrLf & "order by degree"
Rs11.Open StrSql, Dbcon, 1, 1
%>

<%'##########  기준차수  ##########%>
<SELECT NAME="FormDegree" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
    <option value="" <%If Session("FormStatsDegree")="" Then Response.write "selected"%>>---기준차수 선택---</option>
    <%If Rs11.RecordCount > 0 Then%>
        <%do Until Rs11.eof
            DegreeTemp = Rs11("Degree")%>
            <option value="<%=DegreeTemp%>" <%If cstr(Session("FormStatsDegree"))=cstr(DegreeTemp) Then Response.write "selected"%>><%=DegreeTemp%></option>
            <%Rs11.movenext%>
        <%loop%>
    <%End If%>
    <%Rs11.Close%>
</SELECT>

<%'##########  최종결과  ##########%>
<SELECT NAME="FormResult" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
    <option value="0" <%If Session("FormStatsResult") = 0 Then Response.write "selected"%>>---결과 선택----</option>
    <option value="6" <%If Session("FormStatsResult") = 6 Then Response.write "selected"%>>등록예정</option>
    <option value="3" <%If Session("FormStatsResult") = 3 Then Response.write "selected"%>>포기</option>
    <option value="4" <%If Session("FormStatsResult") = 4 Then Response.write "selected"%>>미결정</option>
    <option value="5" <%If Session("FormStatsResult") = 5 Then Response.write "selected"%>>미연결</option>
    <option value="2" <%If Session("FormStatsResult") = 2 Then Response.write "selected"%>>등록완료</option>
    <option value="7" <%If Session("FormStatsResult") = 7 Then Response.write "selected"%>>미등록</option>
    <option value="10" <%If Session("FormStatsResult") = 10 Then Response.write "selected"%>>환불</option>
    <option value="1" <%If Session("FormStatsResult") = 1 Then Response.write "selected"%>>충원예정</option>
</SELECT>

<%'##########  상담원  ##########%>
    <%StrSql =          "select MemberID from Member order by MemberID"
    'Response.Write StrSql
    Rs11.Open StrSql, Dbcon, 1, 1%>
    <SELECT NAME="FormMemberID" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
        <%If Rs11.RecordCount > 0 Then%>
            <option value="">---상담원 선택---</option>
            <%for i = 1 to Rs11.RecordCount
                DivisionTemp = Rs11("MemberID")%>
                <option value="<%=DivisionTemp%>" <%
                    If Session("FormStatsMemberID")=DivisionTemp Then 
                        Response.write "selected"
                    End If
                %>><%=DivisionTemp%></option>
                <%Rs11.MoveNext%>
            <%Next%>
        <%Else%>
            <option value="">---상담원 선택---</option>
        <%End If%>
    </SELECT>
<%Rs11.Close%>

<%'##########  정렬방식  ##########%>
<SELECT NAME="FormOrderType" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
	<option value="subject, Division0, Division2, ET.Ranking" <%If Session("FormStatsOrderType")="subject, Division0, Division2, ET.Ranking" Then Response.write "selected"%>>학과명순 정렬</option>
    <option value="ET.SubjectCode, ET.Ranking" <%If Session("FormStatsOrderType")="ET.SubjectCode, ET.Ranking" Then Response.write "selected"%>>코드,석차순 정렬</option>
    <option value="ET.StudentNumber" <%If Session("FormStatsOrderType")="ET.StudentNumber" Then Response.write "selected"%>>수험번호순 정렬</option>
    <option value="ET.StudentName" <%If Session("FormStatsOrderType")="ET.StudentName" Then Response.write "selected"%>>이름순 정렬</option>
    <option value="A.InsertTime" <%If Session("FormStatsOrderType")="A.InsertTime" Then Response.write "selected"%>>작업시각순 정렬</option>
</SELECT>
<br>

<%
'##############################
'##라인 학과 전형 차수 선택
'##############################
Dim StrSql, i, Count
'세션에 사용라인, 모집단위코드, 전형코드, 상태코드, 차수 기록됨 한번 학과를 셀렉트 하면 이후 값들을 폼에 넣고 넘기면서 보관할 필요 없이 세션에 저장해서 계속 유지
if Request.Form("FormDivision3")<>"" then
    Session("FormStatsDivision3") = Request.Form("FormDivision3")
end if
if Request.Form("FormDivision2")<>"" and Request.Form("FormDivision2") <> Session("FormStatsDivision2") then 
    Session("FormStatsDivision2") = Request.Form("FormDivision2")
    Session("FormStatsDivision3") = ""
    Session("FormStatsSubjectCode") = ""
end If
if Request.Form("FormDivision1")<>"" and Request.Form("FormDivision1") <> Session("FormStatsDivision1") then 
    Session("FormStatsDivision1") = Request.Form("FormDivision1")
    Session("FormStatsDivision2") = ""
    Session("FormStatsDivision3") = ""
    Session("FormStatsSubjectCode") = ""
end If
if Request.Form("FormSubject")<>"" and Request.Form("FormSubject") <> Session("FormStatsSubject") then
    Session("FormStatsSubject") = Request.Form("FormSubject")
    Session("FormStatsDivision1") = ""
    Session("FormStatsDivision2") = ""
    Session("FormStatsDivision3") = ""
    Session("FormStatsSubjectCode") = ""
end If
if Request.Form("FormDivision0")<>"" and Request.Form("FormDivision0") <> Session("FormStatsDivision0") then 
    Session("FormStatsDivision0") = Request.Form("FormDivision0")
    Session("FormStatsDivision1") = ""
    Session("FormStatsSubject") = ""
    Session("FormStatsDivision2") = ""
    Session("FormStatsDivision3") = ""
    Session("FormStatsSubjectCode") = ""
end If

'*표시 제거
Session("FormStatsDivision0")  = Replace(Session("FormStatsDivision0"),"*","")
Session("FormStatsDivision1")  = Replace(Session("FormStatsDivision1"),"*","")
Session("FormStatsSubject")    = Replace(Session("FormStatsSubject"),"*","")
Session("FormStatsDivision2")  = Replace(Session("FormStatsDivision2"),"*","")
Session("FormStatsDivision3")  = Replace(Session("FormStatsDivision3"),"*","")
Session("FormStatsSubjectCode")= Replace(Session("FormStatsSubjectCode"),"*","")
%>

<%'=Session("MemberSubjectA")%>
<%'=Session("MemberSubjectb")%>
<%'=Session("MemberSubjectc")%>
<%'=Session("MemberSubjectd")%>
<%'if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림%>
	<INPUT TYPE="hidden" name="FormSubjectStatsResult" value="">
    <input type="Hidden" name="FormStudentNumber" value="">
    <input type="Hidden" name="FormStatus" value="">
    <input type="Hidden" name="GotoPage" value="<%=Request.Form("GotoPage")%>">

    <%
    '##########  모집시기  ##########  
    if Session("FormStatsUsedLine") <>"" or Session("Grade")="관리자" then
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

            <SELECT NAME="FormDivision0" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="*">---모집시기 선택---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division0")%>
                        <%'if Session("Grade")<>"관리자" and DivisionTemp="정시1차" then%>
                        <%'else%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormStatsDivision0")=DivisionTemp then 
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
    end if
    '##########  모집단위 선택  ##########  
    if Session("FormStatsUsedLine")<>"" and Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormStatsDivision0")<>"" and Session("CountTemp") >= 1) then
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
        StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormStatsDivision0") & "' "
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

            <SELECT NAME="FormSubject" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="">---학과명 선택---</option>
                    <%for i = 1 to Rs11.RecordCount
                        'SubjectCodeTemp = Rs11("SubjectCode")
                        SubjectTemp = Rs11("Subject")%>
                        <option value="<%=SubjectTemp%>" <%
                            if Session("FormStatsSubject") = SubjectTemp then 
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
    end If
    '##########  구분1  ##########  
    if Session("FormStatsUsedLine")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsSubject")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormStatsDivision0")<>"" and Session("FormStatsSubject")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division1, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where 1=1 "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormStatsSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division1<>'' "
        if Session("MemberDivision1") <> "" then
            StrSql = StrSql & vbCrLf & "and Division1='" & Session("MemberDivision1") & "' "
        end if
        StrSql = StrSql & vbCrLf & "group by Division1 "
        StrSql = StrSql & vbCrLf & "order by Division1 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision1" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="">---구분1 선택---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division1")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormStatsDivision1")=DivisionTemp then 
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
    if Session("FormStatsUsedLine")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsSubject")<>"" and Session("CountTemp") >= 1 or ( Session("Grade")="관리자" and Session("FormStatsDivision0")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsSubject")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division2, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where 1=1 "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormStatsDivision1") & "' "
        StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormStatsSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division2<>'' "
        StrSql = StrSql & vbCrLf & "group by Division2 "
        StrSql = StrSql & vbCrLf & "order by Division2 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision2" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="">---구분2 선택---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division2")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormStatsDivision2")=DivisionTemp then 
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
    if Session("FormStatsUsedLine")<>"" and Session("FormStatsDivision0")<>"" and Session("FormStatsSubject")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsDivision2")<>"" and Session("CountTemp") >= 1  or ( Session("Grade")="관리자" and Session("FormStatsDivision0")<>"" and Session("FormStatsSubject")<>"" and Session("FormStatsDivision1")<>"" and Session("FormStatsDivision2")<>"" and Session("CountTemp") >= 1) then
        StrSql =          "select Division3, count(*) as count "
        StrSql = StrSql & vbCrLf & "from SubjectTable "
        StrSql = StrSql & vbCrLf & "where Subject='" & Session("FormStatsSubject") & "' "
        StrSql = StrSql & vbCrLf & "and Division0='" & Session("FormStatsDivision0") & "' "
        StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormStatsDivision1") & "' "
        StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormStatsDivision2") & "' "
        StrSql = StrSql & vbCrLf & "and Division3<>'' "
        StrSql = StrSql & vbCrLf & "group by Division3 "
        StrSql = StrSql & vbCrLf & "order by Division3 "
        'Response.Write StrSql & "<BR>"
        Rs11.Open StrSql, Dbcon, 1, 1
        if Rs11.RecordCount>0 Then%>

            <SELECT NAME="FormDivision3" onchange="this.form.submit();" style="margin-bottom: 10px; width: 150px;">
                <%if Rs11.RecordCount > 0 then%>
                    <option value="">---구분3 선택---</option>
                    <%for i = 1 to Rs11.RecordCount
                        DivisionTemp = Rs11("Division3")%>
                        <option value="<%=DivisionTemp%>" <%
                            if Session("FormStatsDivision3")=DivisionTemp then 
                                response.write "selected"
                                Session("CountTemp") = 0
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
    end if%>



<%

'##############################
'##모집단위코드 추출 Session("FormStatsSubjectCode")에 입력
'##############################
if Session("FormStatsUsedLine")<>"" and Session("FormStatsSubject")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0 or ( Session("Grade")="관리자" and Session("FormStatsSubject")<>"" and Session("HostAddress")<>"" and Session("CountTemp") = 0) then
		StrSql =		"select SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum "
		StrSql = StrSql & vbCrLf & "from SubjectTable "
		StrSql = StrSql & vbCrLf & "where Division0='" & Session("FormStatsDivision0") & "' "
		if Session("FormStatsSubject")<>"" then
			StrSql = StrSql & vbCrLf & "and Subject='" & Session("FormStatsSubject") & "' "
			if Session("FormStatsDivision1")<>"" then
				StrSql = StrSql & vbCrLf & "and Division1='" & Session("FormStatsDivision1") & "' "
				if Session("FormStatsDivision2")<>"" then
					StrSql = StrSql & vbCrLf & "and Division2='" & Session("FormStatsDivision2") & "' "
					if Session("FormStatsDivision3")<>"" then
						StrSql = StrSql & vbCrLf & "and Division3='" & Session("FormStatsDivision3") & "' "
					end if
				end if
			end if
		end if
		'Response.Write StrSql
		Rs11.Open StrSql, Dbcon, 1, 1
		if Rs11.RecordCount = 1 then
			if Request.Form("FormStudentNumber")="" then ' 지원자들목록을 볼때 & 학과 고를때 만 노출 , 지원자 세부사항 화면에선 가림
				Session("FormStatsSubjectCode") = Rs11("SubjectCode")	'지원자 세부사항에선 SubjectCode를 한번 더 추출하기 때문에 이 작업은 필요없다
			end if
			Response.Write "<font size='3'>"
			Session("FormStatsDivision0") = Rs11("Division0")
'			Response.Write " " & Session("FormStatsDivision0")
			if Session("FormStatsSubject")<>"" then
				Session("FormStatsSubject") = Rs11("Subject")
'					Response.Write " " & Session("FormStatsSubject")
				if Session("FormStatsDivision1")<>"" then
					Session("FormStatsDivision1") = Rs11("Division1")
	'				Response.Write " " & Session("FormStatsDivision1")
					if Session("FormStatsDivision2")<>"" then
						Session("FormStatsDivision2") = Rs11("Division2")
'						Response.Write " " & Session("FormStatsDivision2")
						if Session("FormStatsDivision3")<>"" then
							Session("FormStatsDivision3") = Rs11("Division3")
'							Response.Write " " & Session("FormStatsDivision3")
						end if
					end if
				end if
			end if

'			Response.Write "  " & Session("MemberID") & "님 "

			'차수설정 체크
'				if Session("FormStatsDegree")="" then 
'						Response.Write " 차수 미설정 "
'				else
'						Response.Write " 제 " & Session("FormStatsDegree") & " 차 충원 작업중..."
'				end if

			Response.Write "</font>"
		else
			'Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('새로고침 할 수 없습니다. 학과 선택 오류 입니다. 다시 로그인 해 주세요.')</SCRIPT>"
            'Response.Write "<SCRIPT LANGUAGE='JavaScript'>myModalRootClick('지원자 관리','학과 선택 오류 입니다. 다시 선택해 주세요');</SCRIPT>"
		end if
		Rs11.Close
end if
set Rs11 = Nothing
%>
<%'=Session("FormStatsSubjectCode")%>


									<%'160105 이종환 : 문자발송 역역 주석처리%>
									<!--
                                  <td style="text-align: center; padding-top: 8px; font-size: 10px;">

                                    <label><input type='checkbox' name='chkTel1' value='Tel1' <%If Request.Form("chkTel1")<>"" Then%>checked<%End If%>/> 전화1</label>
                                    <label><input type='checkbox' name='chkTel2' value='Tel2' <%If Request.Form("chkTel2")<>"" Then%>checked<%End If%>/> 전화2</label>
                                    <label><input type='checkbox' name='chkTel3' value='Tel3' <%If Request.Form("chkTel3")<>"" Then%>checked<%End If%>/> 전화3</label>
                                    <label><input type='checkbox' name='chkTel4' value='Tel4' <%If Request.Form("chkTel4")<>"" Then%>checked<%End If%>/> 전화4</label>
                                    <label><input type='checkbox' name='chkTel5' value='Tel5' <%If Request.Form("chkTel5")<>"" Then%>checked<%End If%>/> 전화5</label>

                                  </td>
                                  <td style="text-align: center; margin: 0px;" rowspan="2">
                                    <textarea name="FormSMSBody" wrap="hard" style="font-size: 11px;font-family:돋움; width: 130px; height: 101px; border:1 solid silver; margin: 0px;"><%=FormSMSBody%></textarea>
                                  </td>
                                  <td style="text-align: center; margin: 0px;" rowspan="2">
                                    <button type="button" class="btn " style="width: 50px; height: 107px; margin-top: 2px;" onclick="StatsListSMSSend(this.form); return false;">
                                        SMS발송
                                    </button>
                                  </td>
								  -->
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






            <%
            Dim Timer1
            Timer1=Timer()
                '#################################################################################
                '##학과 구분 조건을 활용한 SubStrSql
                '#################################################################################
                Dim Rs1
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
                '미작업 추출시는 Degree를 쿼리 중간에 둬야한다.
                'Result, MemberID, Inserttime 검색 제외
                If Session("FormStatsResult")<>1 Then
                    If Session("FormStatsDegree") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & Session("FormStatsDegree") & "'"
                    End If
                    If Session("FormStatsResult") <> 0 Then
                        If Session("FormStatsResult") = 1 Then
                            SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
                        Else
                            SubStrSql = SubStrSql & vbCrLf & "and Result = '" & Session("FormStatsResult") & "'"
                        End If
                    End If
                    If Session("FormStatsMemberID") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & Session("FormStatsMemberID") & "'"
                    End If
                    If Session("InsertTime1") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime >= '" & Session("InsertTime1") & " 00:00:00'"
                    End If
                    If Session("InsertTime2") <> "" Then
                        SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime <= '" & Session("InsertTime2") & " 23:59:59.999'"
                    End If
                End If
                'If Session("FormStatsResultType") <> "" Then
                '	SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & Session("FormStatsResultType") & "'"
                'End If
                'Response.write SubStrSql & "<BR>"
                'Response.End
                
                Dim OrderStrSql
                If Session("FormStatsOrderType") = "" Then
                    'OrderStrSql = "order by ET.SubjectCode, ET.Ranking"
					OrderStrSql = "order by subject, Division0, Division1, ET.Ranking"
                Else
                    OrderStrSql = "order by " & Session("FormStatsOrderType")
                End If
                'Response.write OrderStrSql
                'Response.End

            ' ##################################################################################
            ' 기본 page setting values
            ' ##################################################################################
              Dim pageSize, gotoPage
              pageSize = 20
                gotoPage = getintParameter( Request.Form("gotoPage"), 1)
              Dim totalpage,recordCount
              totalpage   = 1
              recordCount = 0   

                Set Rs1 = Server.CreateObject("ADODB.Recordset")

                '----------------------------------------------------------------------------------
                ' 해당값 가져오기
                '----------------------------------------------------------------------------------
            '미작업 추출 전용 쿼리, 한성대 소스 쿼리, 충원대상자
            If Session("FormStatsResult")=1 Then
                StrSql = ""
                StrSql = StrSql & vbCrLf & "--미작업(RemainCount) = 정원-등록예정-등록완료"
                StrSql = StrSql & vbCrLf & "--커트라인(RankingCutLine) = 정원+포기+미등록+환불+기환불"
                StrSql = StrSql & vbCrLf & ""
                StrSql = StrSql & vbCrLf & "declare @Degree as Tinyint"
                StrSql = StrSql & vbCrLf & "select @Degree = '" & Session("FormStatsDegree") &"'"
                StrSql = StrSql & vbCrLf & "-- select @Degree = '4' 부분의 숫자를 조회하실 차수로 변경 하신 후 실행하세요."
                StrSql = StrSql & vbCrLf & "-- 현재는 4차의 등록, 미등록 데이터 까지  입력완료된 상태이고, 5차의 통보예정자와 그 목록을 추출하는 쿼리 입니다."
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "select a.*, et.SubjectCode, et.StudentNumber, et.StudentName, et.Ranking, cr.idx"
                StrSql = StrSql & vbCrLf & ", null Degree, null Tel, null MemberID, null Receiver, null Result, null SaveFile, null Memo, null InsertTime, 0 CallCountIsNull, 1 ResultIsNull"
                StrSql = StrSql & vbCrLf & "from"
                StrSql = StrSql & vbCrLf & "("
                StrSql = StrSql & vbCrLf & "	select a.SubjectCode, Division0, Subject, Division1, Division2, Division3"
                StrSql = StrSql & vbCrLf & "	--등록완료+등록예정을 한번에 구해"
                StrSql = StrSql & vbCrLf & "	, Quorum - isnull(r.RegistCount,0) Remain"
                StrSql = StrSql & vbCrLf & "	--포기+미등록+환불+기환불을 한번에 구해"
                StrSql = StrSql & vbCrLf & "	, Quorum + isnull(b.AbadonCount,0) RankingCutLine"
                StrSql = StrSql & vbCrLf & "	, Quorum"
                StrSql = StrSql & vbCrLf & "	, isnull(r.RegistCount,0) RegistCount"
                StrSql = StrSql & vbCrLf & "	, isnull(b.AbadonCount,0) AbadonCount"
                StrSql = StrSql & vbCrLf & "	from SubjectTable a"
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "	--등록완료+등록예정을 한번에 구해"
                StrSql = StrSql & vbCrLf & "	left outer join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select A.SubjectCode, '2' Result, isnull(count(*),0) as RegistCount"
                StrSql = StrSql & vbCrLf & "		from RegistRecord A"
                StrSql = StrSql & vbCrLf & "		inner join"
                StrSql = StrSql & vbCrLf & "		("
                StrSql = StrSql & vbCrLf & "			select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "			from RegistRecord"
                StrSql = StrSql & vbCrLf & "			where Degree <=@Degree"
                StrSql = StrSql & vbCrLf & "			group by StudentNumber"
                StrSql = StrSql & vbCrLf & "		) B"
                StrSql = StrSql & vbCrLf & "		on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "		where result = 2 or result = 6"
                StrSql = StrSql & vbCrLf & "		group by A.SubjectCode"
                StrSql = StrSql & vbCrLf & "	) r"
                StrSql = StrSql & vbCrLf & "	on a.SubjectCode = r.SubjectCode"
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "	--포기+미등록+환불+기환불을 한번에 구해"
                StrSql = StrSql & vbCrLf & "	left outer join"
                StrSql = StrSql & vbCrLf & "	("
                StrSql = StrSql & vbCrLf & "		select A.SubjectCode, '3' Result, isnull(count(*),0) as AbadonCount"
                StrSql = StrSql & vbCrLf & "		--select *"
                StrSql = StrSql & vbCrLf & "		from RegistRecord A"
                StrSql = StrSql & vbCrLf & "		inner join"
                StrSql = StrSql & vbCrLf & "		("
                StrSql = StrSql & vbCrLf & "			select StudentNumber, max(IDX) as MaxIDX "
                StrSql = StrSql & vbCrLf & "			from RegistRecord"
                StrSql = StrSql & vbCrLf & "			where Degree <=@Degree"
                StrSql = StrSql & vbCrLf & "			group by StudentNumber"
                StrSql = StrSql & vbCrLf & "		) B"
                StrSql = StrSql & vbCrLf & "		on A.StudentNumber = B.StudentNumber"
                StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
                StrSql = StrSql & vbCrLf & "		where result = 3 or result = 7 or result = 10 or result = 11"
                StrSql = StrSql & vbCrLf & "		group by A.SubjectCode"
                StrSql = StrSql & vbCrLf & "	) b"
                StrSql = StrSql & vbCrLf & "	on a.SubjectCode = b.SubjectCode"
                StrSql = StrSql & vbCrLf & "	where Quorum - isnull(r.RegistCount,0) > 0"
                StrSql = StrSql & vbCrLf & ") a"
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "left outer join StudentTable et"
                StrSql = StrSql & vbCrLf & "on a.SubjectCode = et.SubjectCode"
                StrSql = StrSql & vbCrLf & "and a.RankingCutLine >= et.Ranking"
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "left outer join RegistRecord cr"
                StrSql = StrSql & vbCrLf & "on et.StudentNumber = cr.StudentNumber"
                StrSql = StrSql & vbCrLf & ""

                StrSql = StrSql & vbCrLf & "where 1=1 "
                If Session("FormStatsDegree")="" Then
                    StrSql = StrSql & vbCrLf & "and 1=2 "               '충원예정자는 차수지정이 필수다. 차수가 없으면 의도적으로 리스트업 제한
                End If
                StrSql = StrSql & vbCrLf & "and cr.IDX is Null"         '충원예정자는 전화기록이 없는 지원자만
                StrSql = StrSql & vbCrLf & "and et.IDX is Not Null"     '충원예정자는 지원자가 존재하는 모집단위만

                StrSql = StrSql & vbCrLf & SubStrSql
                StrSql = StrSql & vbCrLf & OrderStrSql
            Else
                If Session("FormStatsResultType")="" Then
                    StrSql =		"select ET.StudentNumber, ET.StudentName, ET.Ranking"
                    StrSql = StrSql & vbCrLf & ", D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
                    StrSql = StrSql & vbCrLf & ", A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
                    StrSql = StrSql & vbCrLf & ", isnull(B.CallCount,'0') as CallCountIsNull"
                    StrSql = StrSql & vbCrLf & ", isnull(A.Result,1) as ResultIsNull"
                    StrSql = StrSql & vbCrLf & "from RegistRecord A"
                    StrSql = StrSql & vbCrLf & "inner join"
                    StrSql = StrSql & vbCrLf & "("
                    StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
                    StrSql = StrSql & vbCrLf & "	from RegistRecord"

                    '세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
                    If Session("FormStatsDegree") <> "" Then
                    StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
                    End If

                    StrSql = StrSql & vbCrLf & "	group by StudentNumber"
                    StrSql = StrSql & vbCrLf & ") B"
                    StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
                    StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
                    StrSql = StrSql & vbCrLf & "right outer join StudentTable ET"
                    StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
                    StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
                    StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
                    StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
                    StrSql = StrSql & vbCrLf & SubStrSql
                    StrSql = StrSql & vbCrLf & OrderStrSql
                ElseIf Session("FormStatsResultType")="전체" Then
                    StrSql =		"select ET.StudentNumber, ET.StudentName, ET.Ranking"
                    StrSql = StrSql & vbCrLf & ", D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
                    StrSql = StrSql & vbCrLf & ", A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
                    StrSql = StrSql & vbCrLf & ", isnull(B.CallCount,'0') as CallCountIsNull"
                    StrSql = StrSql & vbCrLf & ", isnull(A.Result,1) as ResultIsNull"
                    StrSql = StrSql & vbCrLf & "from RegistRecord A"
                    StrSql = StrSql & vbCrLf & "left outer join"
                    StrSql = StrSql & vbCrLf & "("
                    StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
                    StrSql = StrSql & vbCrLf & "	from RegistRecord"

                    '세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
                    If Session("FormStatsDegree") <> "" Then
                    StrSql = StrSql & vbCrLf & "where Degree = '" & Session("FormStatsDegree") & "'"
                    End If

                    StrSql = StrSql & vbCrLf & "	group by StudentNumber"
                    StrSql = StrSql & vbCrLf & ") B"
                    StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
                    'StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
                    StrSql = StrSql & vbCrLf & "right outer join StudentTable C"
                    StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
                    StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
                    StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
                    StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
                    StrSql = StrSql & vbCrLf & SubStrSql
                    StrSql = StrSql & vbCrLf & OrderStrSql
                End If
            End If
            'PrintSql StrSql
            'Response.End
            Rs1.CursorLocation = 3
            Rs1.CursorType = 3
            Rs1.LockType = 3
            Rs1.Open StrSql, Dbcon

            '----------------------------------------------------------------------------------
            ' 전체 페이지와 전체 카운터 설정
            '----------------------------------------------------------------------------------
            If (Rs1.BOF and Rs1.EOF) Then
                recordCount = 0 
                totalpage   = 0
            Else
                recordCount = Rs1.RecordCount
                Rs1.pagesize = PageSize
                totalpage   = Rs1.PageCount
            End If

            If cint(gotopage)>cint(totalpage) Then gotopage=totalpage	
            %>

              <div class="widget" style="margin-top: 0; padding-top: 0;">
                <div class="widget-head">
                  <div class="pull-left">지원자 리스트: <%=FormatNumber(RecordCount, 0)%></div>
                  <div class="widget-icons pull-right">
					<% If Request.ServerVariables("REMOTE_ADDR") = "220.90.136.236" Then %>
						<button type="button" class="btn " onclick="location.href='/MatrixHtmlRecord.asp'">
							<i class="icon-save bigger-120"></i> 녹음한지원자 htm
						</button>
					<% End If %>
                    <button type="button" class="btn " onclick="StatsFrameFunction(this.form); return false;">
                        <i class="icon-desktop bigger-120"></i> 화면 출력
                    </button>
                    <button type="button" class="btn " onclick="StatsListTxtDownload(this.form); return false;">
                        <i class="icon-file-alt bigger-120"></i> TXT 저장
                    </button>
                    <button type="button" class="btn " onclick="StatsListExcelDownload(this.form); return false;">
                        <i class="icon-save bigger-120"></i> XLS 저장
                    </button>
                    <button type="button" class="btn" onclick="StatsListRemainExcelDownload(this.form); return false;">
                        <i class="icon-phone bigger-120"></i> 전화충원 예정자
                    </button>
                    <button type="button" class="btn" onclick='StatsListPluralBeforehandExcelDownload(this.form); return false;'>
                        <i class="icon-tags bigger-120"></i> 복수지원 사전점검
                    </button>
                    <button type="button" class="btn " onclick='StatsListPluralResultExcelDownload(this.form); return false;'>
                        <i class="icon-sitemap bigger-120"></i> 자동포기된 복수지원자
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
                                <col width="5%"></col>
                                <col width="5%"></col>
                                <col width="3%"></col>
                                <col width="5%"></col>
                                <col width="4%"></col>
                                <col width="8%"></col>
                                <col width="5%"></col>
                                <col width="3%"></col>
                                <col width="5%"></col>
                                <col width="3%"></col>
                                <col width="5%"></col>
                                <col width="5%"></col>
                                <col width="5%"></col>
                                <col width="4%"></col>
                                <col width="5%"></col>
                                <col width="5%"></col>
                                <col width="5%"></col>
                                <col width="7%"></col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">수험번호</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">이름</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">석차</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">코드</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">시기</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분1</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">학과</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분2</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">구분3</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">차수</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">발신번호</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">발신자</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">수신자</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">결과</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">전화횟수</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">녹음파일</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">메모</th>
                                    <th colspan="1" style="padding: 5px 0px 8px 0px; text-align: center;">작업시각</th>
                                </tr>
                            </thead>
                            <%'기본적으로 모든 지원자를 보여주도록 개선
                            'if ( Session("FormStatsSubjectCode")="" and Session("FormStatsSubject")="" Or Session("CountTemp")<>0 ) And SearchString="" Then%><!-- 
                                <tbody>
                                    <TR><TD colspan="17" class="content" style="height: 40; text-align: center;">모집단위를 선택하세요.<BR>
                                </tbody> -->
                            <%'Else%>
                                <%If Rs1.eof then%>
                                    <tbody>
                                        <TR><TD colspan="17" class="content" style="height: 40; text-align: center;">검색된 기록이 없습니다.<BR>
                                    </tbody>
                                <%Else%>
                                <tbody>
                                    <%Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime
                                    Dim ResultTempStr, ReceiverTempStr
                                    Dim RCount
                                    Dim BGColor
                                    BGColor = "#f0f0f0"

                                    RCount = Rs1.pagesize
                                    Rs1.AbsolutePage = GotoPage
                                    do Until Rs1.EOF or (RCount = 0 )
                                        StudentNumber= Rs1("StudentNumber")
                                        StudentName= Rs1("StudentName")
                                        Ranking= Rs1("Ranking")
                                        SubjectCode= Rs1("SubjectCode")
                                        Subject= Rs1("Subject")
                                        Division0= Rs1("Division0")
                                        Division1= Rs1("Division1")
                                        Division2= Rs1("Division2")
                                        Division3= Rs1("Division3")
                                        Degree= Rs1("Degree")
                                        Tel= Rs1("Tel")
                                        MemberID= Rs1("MemberID")
                                        Receiver= Rs1("Receiver")
                                        Result= Rs1("ResultIsNull")
                                        CallCount= Rs1("CallCountIsNull")
                                        SaveFile= Rs1("SaveFile")
                                        If SaveFile <>"" Then SaveFile=StudentNumber&SaveFile&".wav"
                                        Memo= Rs1("Memo")
                                        InsertTime= Rs1("InsertTime")
                                        i = i + 1
                                        '결과
                                        select case Result
                                            case 1
                                                ResultTempStr = "미작업"
                                            case 2
                                                ResultTempStr = "등록완료"
                                            case 3
                                                ResultTempStr = "포기"
                                            case 4
                                                ResultTempStr = "미결정"
                                            case 5
                                                ResultTempStr = "미연결"
                                            case 6
                                                ResultTempStr = "등록예정"
                                            case 7
                                                ResultTempStr = "미등록"
                                            case 10
                                                ResultTempStr = "환불"
                                            case Else
                                                ResultTempStr = ""
                                        End select
                                        '받은사람
                                        select case Receiver
                                            case 1
                                                ReceiverTempStr = "없음"
                                            case 2
                                                ReceiverTempStr = "지원자"
                                            case 3
                                                ReceiverTempStr = "부모"
                                            case 4
                                                ReceiverTempStr = "가족"
                                            case 5
                                                ReceiverTempStr = "기타"
                                            case Else
                                                ReceiverTempStr = ""
                                        End Select
                                        If BGColor = "#f0f0f0" Then
                                            BGColor = "#fafafa"
                                        Else BGColor = "#fafafa"
                                            BGColor = "#f0f0f0"
                                        End If
                                        %>
                                        <tr>

                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="StudentNumber" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=StudentNumber%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="StudentName" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=StudentName%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Ranking" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Ranking%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="SubjectCode" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=SubjectCode%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Division0" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division0%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Division1" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division1%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Subject" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Subject%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Division2" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division2%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Division3" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Division3%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Degree" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Degree%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Tel" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Tel%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="MemberID" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=MemberID%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="ReceiverTempStr" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=ReceiverTempStr%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Result" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=ResultTempStr%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="CallCount" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=CallCount%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px; background-color: <%=BGColor%>;">
                                                <%If SaveFile <> "" Then%><a href="/Record/<%=SaveFile%>">녹음파일</a><%End If%>
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="Memo" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=Memo%>">
                                            </TD>
                                            <td colspan="1" style="padding: 0px; text-align: center; line-height: 26px;">
                                                <INPUT TYPE="text" NAME="InsertTime" style="width: 100%; height: 28px; border:1px; text-align: left; padding: 0px; margin: 0px; background-color: <%=BGColor%>;" value="<%=InsertTime%>">
                                            </TD>

                                        </tr>
                                        <%Rs1.MoveNext
                                        RCount = RCount -1
                                    Loop
                                    Rs1.Close
                                    Set Rs1 = Nothing%>
                                </tbody>
                                <%End If%>
                            <%'기본적으로 모든 지원자를 보여주도록 개선
                            'End If%>
                        </table>
                      </div>

                    </div>
                  </div>

                    <%If totalpage > 1 Then %>
                        <div class="widget-foot" style="padding: 0;">
                            <div class="pagination pull-right" style="margin: 5px 0px 3px 0px; line-height: 15px;">
                                <ul>
                                <%If GotoPage>1 Then%>
                                    <li><a href="javascript: ChangePage(document.MenuForm,<%=GotoPage-1%>)">Prev</a></li>
                                <%Else%>
                                    <li><a >Prev</a></li>
                                <%End If%>
                                <%pageViewRemainFrameSrc%>
                                <%If cint(GotoPage)<cint(totalpage) Then%>
                                    <li><a href="javascript: ChangePage(document.MenuForm,<%=GotoPage+1%>)">Next</a></li>
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
		    </FORM>
              
        <%Sub pageViewRemainFrameSrc()
            Dim intMyChoice,TotalBlock,i,NowBlock,q
            intMyChoice=10
            If totalpage > 0 then
                TotalBlock = int((totalpage-1)/intMyChoice) '전체블럭수 (블럭은 0부터 시작)
                NowBlock = int((GotoPage-1)/intMyChoice) '현재블럭수
            end if
            If TotalBlock <> NowBlock or (totalpage/intMyChoice)=int(totalpage/intMyChoice) Then'블럭에 페이지수가 10개 이상일때
                For i = 1 to intMyChoice
                    q=NowBlock*intMyChoice + i
                    If(GotoPage-(NowBlock*intMyChoice)) = i Then
                        Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
                    Else
                        response.write "<li><a href='javascript: ChangePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            Else'블럭에 페이지수가 10개 이상이 아닐때
                For i = 1 to (totalpage mod intMyChoice) '전체페이지에서 MyChoice로 나눈 나머지페이지
                    q=NowBlock*intMyChoice + i
                    If(GotoPage-(NowBlock*intMyChoice)) = i Then
                        Response.Write "<li><a style='border-color: red;'> " & q & " </a></li>"
                    Else
                        response.write "<li><a href='javascript: ChangePage(document.MenuForm," & ((NowBlock*intMyChoice)+i) & ")'>" & q & "</A></li>"
                    End If
                Next
            End If
        End Sub%>


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
        <iframe name="TruncateFrame" src="" width="100%" height="20" scrolling="no" frameborder="0" marginwidth="0" marginheight="0"></iframe>
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
<script type="text/javascript">
    function ChangePage(f,GotoPage){
        f.GotoPage.value=GotoPage;
        f.submit();
    }
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }
    function StatsListSMSSend(f){
        if (f.FormDivision0.value=="*" && f.FormResult.value=="0" && f.FormDegree.value=="" ){
            //alert('최소 한 개 이상의 조건을 선택해 주세요..');
            myModalRootClick("통계 세부내역","최소 한 개 이상의 조건을 선택해 주세요.");
            return;
        }
//        if (RecordChecked==false){
//            //alert('화면 출력 버튼으로 발송대상 확인을 먼저 하세요.');
//            myModalRootClick("SMS 발송","화면 출력 버튼으로 발송대상 확인을 먼저 하세요.");
//            return;
//        }
        if (f.FormSMSBody.value==""){
            //alert('SMS 문구를 입력해 주세요.');
            myModalRootClick("SMS 발송","SMS 문구를 입력해 주세요.");
            return;
        }
        if (f.chkTel1.checked==false && f.chkTel2.checked==false && f.chkTel3.checked==false && f.chkTel4.checked==false && f.chkTel5.checked==false){
            //alert('발송할 전화번호 다섯개 중 하나 이상을 선택해 주세요.');
            myModalRootClick("SMS 발송","발송할 전화번호 다섯개 중 하나 이상을 선택해 주세요.");
            return;
        }
        if(confirm("검색된 지원자에게 선택한 전화번호로 SMS를 발송합니다.\n\n일단 발송된 SMS는 취소가 불가능합니다.\n\n발송을 마치려면 약 3분이 소요됩니다.\n\n전화 작업 도중에는 삼가해 주세요\n\n계속하시겠습니까?")==true){
            f.action="StatsListSMSSend.asp";
            f.target="TruncateFrame";
            f.submit();
            f.action="StatsList.asp";
            f.testtarget="Root";
            return;
        }else{
            return;
        }
    }
    function StatsListRemainExcelDownload(f){
        if(f.FormDivision0.value==''||f.FormDegree.value==''){
            //alert('모집시기와 기준차수를 선택해 주세요.');
            myModalRootClick("전화충원 예정자","모집시기와 기준차수를 선택해 주세요.");
            return;
        }
        if(f.FormResult.value!='1'){
            //alert('결과를 충원예정으로 선택해 주세요.');
            myModalRootClick("전화충원 예정자","결과를 충원예정으로 선택해 주세요.");
            return;
        }
        //if( confirm('엑셀파일이 약 10초 후 준비됩니다.\n전화 작업 도중에는 삼가해 주세요.\n계속하시겠습니까?')==true ) {
            TruncateFrame.document.location.href='StatsListRemainExcelDownload.asp?FormDivision3=<%=Session("FormStatsDivision3")%>&FormDivision2=<%=Session("FormStatsDivision2")%>&FormDivision1=<%=Session("FormStatsDivision1")%>&FormDivision0=<%=Session("FormStatsDivision0")%>&FormSubject=<%=Session("FormStatsSubject")%>&FormResult=<%=Session("FormStatsResult")%>&FormMemberID=<%=Session("FormStatsMemberID")%>&FormResultType=<%=Session("FormStatsResultType")%>&FormOrderType=<%=Session("FormStatsOrderType")%>&FormDegree=<%=Session("FormStatsDegree")%>'
        //}
    }
    function StatsFrameFunction(f){
        if (f.FormResult.value=='1' && ( f.FormDegree.value=='' || f.FormDivision0.value=='') ){
            //alert("전화충원 예정자 출력은 모집시기와 기준차수 지정이 필요합니다.");
            myModalRootClick("통계 세부내역","전화충원 예정자 출력은 모집시기와 기준차수 지정이 필요합니다.");
            return
        }
        f.submit();
        //TruncateFrame.document.location.href='StatsFrame.asp'
    }
    function StatsListPluralBeforehandExcelDownload(f){
        if( confirm('\n엑셀파일이 약 10초 후 준비됩니다.\n전화 작업 도중에는 삼가해 주세요.\n계속하시겠습니까?\n')==true ){
            TruncateFrame.document.location.href='StatsListPluralBeforehandExcelDownload.asp';
        }
    }
    function StatsListTxtDownload(f){
        if (f.FormResult.value=='1' && ( f.FormDegree.value=='' || f.FormDivision0.value=='') ){
            //alert("전화충원 예정자 저장은 모집구분과 기준차수 지정이 필요합니다.");
            myModalRootClick("통계 세부내역","전화충원 예정자 출력은 모집시기와 기준차수 지정이 필요합니다.");
            return
        }
        //if( confirm('txt파일이 약 10초 후 준비됩니다.\n전화 작업 도중에는 삼가해 주세요.\n계속하시겠습니까?')==true ) {
            TruncateFrame.document.location.href='StatsListTxtDownload.asp';
        //}
    }
    function StatsListExcelDownload(f){
        if (f.FormResult.value=='1' && ( f.FormDegree.value=='' || f.FormDivision0.value=='') ){
            //alert("전화충원 예정자 저장은 모집구분과 기준차수 지정이 필요합니다.");
//            myModalRootClick("통계 세부내역","전화충원 예정자 출력은 모집시기와 기준차수 지정이 필요합니다.");
//            return
        }else{
			if(f.FormDegree.value=='' && f.FormResult.value=='0'){
//				myModalRootClick("통계 세부내역","기준차수 또는, 결과를 선택해 주세요.");
//				return
			}
		}
        //if( confirm('txt파일이 약 10초 후 준비됩니다.\n전화 작업 도중에는 삼가해 주세요.\n계속하시겠습니까?')==true ) {
            TruncateFrame.document.location.href='StatsListExcelDownload.asp';
        //}
    }
    function StatsListPluralResultExcelDownload(f){
        TruncateFrame.document.location.href='StatsListPluralResultExcelDownload.asp';
    }
    function StatsListSMSSendNotify(m,t){
        noty({text: '<br>'+m+'<br>&nbsp;',layout:'top',type:t,timeout:5000});
    }
</script>
<script type="text/javascript">
/*
function addzero(n){                        // 한자리가 되는 숫자에 "0"을 넣어주는 함수
    return n < 10 ? "0" + n: n;
}
 
function dateInput(n,m){
     $("#StartDate").val("");               // 우선 이미 들어가있는 값 초기화
     $("#EndDate").val("");
     
     var date = new Date();
     var start = new Date(Date.parse(date)-n* 1000 * 60 * 60 * 24);
     var today = new Date(Date.parse(date)-m* 1000 * 60 * 60 * 24);
     
     if(n < 10){
        start.setMonth(start.getMonth()-n);
     }
     var yyyy = start.getFullYear();
     var mm = start.getMonth()+1;
     var dd = start.getDate();
     
     var t_yyyy = today.getFullYear();
     var t_mm = today.getMonth()+1;
     var t_dd = today.getDate();
     
     $("#StartDate").val(yyyy+'-'+addzero(mm)+'-'+addzero(dd));
     $("#EndDate").val(t_yyyy+'-'+addzero(t_mm)+'-'+addzero(t_dd));
   
}

$(document).ready(function(){
 
    $("#1m").click(function(){              // 1개월 전
        dateInput(1,0);      
        });
    $("#3m").click(function(){              // 3개월 전
        dateInput(3,0);      
        });
    $("#6m").click(function(){              // 6개월 전
        dateInput(6,0);      
        });
    $("#1y").click(function(){              // 1년 전
        dateInput(365,0);        
        });
    $("#2y").click(function(){              // 2년 전
        dateInput(730,0);        
        });
    $("#3y").click(function(){              // 3년 전
        dateInput(1095,0);       
        });  
});
*/
</script>
<!-- 
<input type="text" id="StartDate" class="input" style="width:80px;"> ~
<input type="text" id="EndDate" class="input" style="width:80px;">
<span><a href="#" id="1m">1M</a></span>
<span><a href="#" id="3m">3M</a></span>
<span><a href="#" id="6m">6M</a></span>
<span><a href="#" id="1y">1Y</a></span>
<span><a href="#" id="2y">2Y</a></span>
<span><a href="#" id="3y">3Y</a></span> -->
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