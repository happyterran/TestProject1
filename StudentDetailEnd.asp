<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
<title>지원자 세부사항</title>
<!-- #include virtual = "/Include/Head.asp" -->

<script type="text/javascript" src="/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery.ui.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.js"></script>
<script type="text/javascript" src="/lib/richscript/richscript.mcm.popup.contents.js"></script>
</head>

<!-- HTML5 Support for IE -->
<!--[if lt IE 9]>
<script src="js/html5shim.js"></script>
<![endif]-->

<body style="padding-top: 0; background: #eee url('../img/main-back.png') repeat;" >

<%
Dim FormStudentNumber, FormCommand, FormDialedTel, FormTelTemp, FormReceiver, FormResult, FormMemo, FormSEndURL
Dim StrSql, Rs1, Rs2, Rs3, winsock1
Dim StatusTemp1, StatusTemp2, SubjectTemp, SubjectCodeTemp, Division0Temp, Division1Temp, Division2Temp, Division3Temp, StudentNumberTemp, StudentNameTemp, MemberIDTemp, SendLine, RegistrationFeeTemp, AccountNumberTemp, LineStatus
Dim DbconSMS
Dim CrossTaskError
Dim i, Tel(5), SMSBody
Dim eDbcon, eStrSql

Set eDbcon = Server.CreateObject("ADODB.Connection") 
eDbcon.ConnectionTimeout = 30
eDbcon.CommandTimeout = 30
eDbcon.Open (DbaseConnectionString)

'상담원의 통화중인 지원자 수험번호, 이름, 상태, 학과명, 전형명, 모집단위코드
Set Rs1 = Server.CreateObject("ADODB.Recordset")
StrSql =                   "select A.MemberID, D.Subject, D.RegistrationFee, D.Division0, D.Division1, D.Division2, D.Division3, C.StudentName, B.StudentNumber, B.Status, D.SubjectCode"
StrSql = StrSql & vbCrLf & "from Member A"
StrSql = StrSql & vbCrLf & "left outer join"
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select top 1 StudentNumber, MemberID, Status"
StrSql = StrSql & vbCrLf & "	from StatusRecord"
StrSql = StrSql & vbCrLf & "	where MemberID ='" & Session("MemberID") & "'"
StrSql = StrSql & vbCrLf & "	order by IDX desc"
StrSql = StrSql & vbCrLf & ") B"
StrSql = StrSql & vbCrLf & "on A.MemberID=B.MemberID"
StrSql = StrSql & vbCrLf & "left outer join StudentTable C"
StrSql = StrSql & vbCrLf & "on B.StudentNumber=C.StudentNumber"
StrSql = StrSql & vbCrLf & "left outer join SubjectTable D"
StrSql = StrSql & vbCrLf & "on C.SubjectCode = D.SubjectCode"
StrSql = StrSql & vbCrLf & "where A.MemberID ='" & Session("MemberID") & "'"
'Response.Write StrSql & "<BR>"
'Response.End
Rs1.Open StrSql, Dbcon, 0, 1, 1

StatusTemp1 = Rs1("Status")'나의 상태
StudentNumberTemp = Rs1("StudentNumber")
FormStudentNumber = StudentNumberTemp
StudentNameTemp = getParameter(Rs1("StudentName"),"")
SubjectCodeTemp = Rs1("SubjectCode")
SubjectTemp = Rs1("Subject")
Division0Temp = Rs1("Division0")
If Division0Temp <>"" Then Division0Temp = " " & Division0Temp
Division1Temp = Rs1("Division1")
If Division1Temp <>"" Then Division1Temp = " " & Division1Temp
Division2Temp = Rs1("Division2")
If Division2Temp <>"" Then Division2Temp = " " & Division2Temp
Division3Temp = Rs1("Division3")
If Division3Temp <>"" Then Division3Temp = " " & Division3Temp
Dim DivisionTemp
DivisionTemp = Division0Temp & Division1Temp & Division2Temp & Division3Temp
Dim Citizen1, Citizen2
'Response.write "상담원 : " & StatusTemp1 & "<BR>"
'Response.write "지원자 : " & StatusTemp2 & "<BR>"
'Response.End

'DialStatus 구하기
Set Rs2 = Server.CreateObject("ADODB.Recordset")
StrSql = "select top 1 * From SettingTable order by IDX desc"
'Response.Write StrSql & "<BR>"
'Response.End
Rs2.Open StrSql, Dbcon
Dim DialStatus
DialStatus = getParameter( Rs2("DialStatus") , "" )

Rs1.Close
set Rs1=Nothing
Rs2.Close
set Rs2=Nothing
'모든 전화 발신 차단
If DialStatus="stop" And ( FormCommand = "DIAL" or FormCommand = "DRECORD" )Then%>
    <SCRIPT LANGUAGE="JavaScript">alert("입학과의 요청입니다. 전화를 잠시 중단해 주세요. DB작업이 진행중입니다.")
    $popup.opener().document.location.href='/Logout.asp'</SCRIPT>
    <%Dbcon.Close
    Set Dbcon = Nothing
    Response.End
End If

'Response.write "FormCommand " & FormCommand & "<br>"
'Response.write "StatusTemp1: " & StatusTemp1 & "<br>"
'Response.write "StatusTemp2: " & StatusTemp2 & "<br>"
'Response.write "FormStudentNumber " & FormStudentNumber & "<br>"
'Response.write "StudentNumberTemp " & StudentNumberTemp & "<br>"
'Response.End

'내가 녹음중
'또는 내가 전화중
If ( StatusTemp1 = 3 ) or ( StatusTemp1 = 2 ) Then
    If Err.Description = "" Then
        '콜기록ReccordFIleName입력, 녹음기록NULL입력, 상태기록NULL입력
        StrSql =		""
        StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
        StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
        StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"
        StrSql = StrSql & vbCrLf & ""
		'Response.Write StrSql & "<BR>"
		'Response.End
        Dbcon.Execute(StrSql)

        ''@ **************************************************************************************************
        ''@ VOS 콜 commond 테이블 업데이트
        'eStrSql = "	update LINEORDE"
		eStrSql = "	update DBASE...LINEORDE"
        eStrSql = eStrSql & vbCrLf & "	set LINEORDER = 'END'"
        eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
        eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
        eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

        eDbcon.Execute(eStrSql)
        ''@ **************************************************************************************************
    End If
End If


'명령전달 실패라면
If Err.Description <> "" Then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('결과 처리가 실패했습니다.\n" & Replace(Err.Description, "'", chr(34)) & "');</SCRIPT>"
	Err.Clear 
End If
'Response.End
%>

<!-- <INPUT TYPE="BUTTON" value="메인으로 이동" onclick="document.location.href='Root.asp'">  -->
<SCRIPT LANGUAGE="JavaScript">
    //document.location.href="<%=Request.ServerVariables("HTTP_REFERER")%>?SearchString=<%=Session("SearchString")%>"
	$(window).load(function () {
		document.StudentDetailEndFrom.submit();
	});
</SCRIPT>

<FORM METHOD="POST" Name="StudentDetailEndFrom" ACTION="<%=Request.QueryString("ref")%>">
	<INPUT TYPE="hidden" name="SearchString" value="<%=Session("SearchString")%>">
</FORM>

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

<!--inline scripts related to this page-->
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
<%eDbcon.Close
Set eDbcon = Nothing%>