<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%Dim Width, asdf
Width = Request.QueryString("width")
asdf = Request.QueryString("asdf")
'Response.Write Width
'Response.Write asdf%>
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

<!-- Form area -->
<div id="ui-popup-contents" style="width: <%=Session("Width")%>px;height:auto;">
	<div class="matter">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<!-- Widget -->
					<div class="widget" style="">
						<div class="widget-head">
							<div class="pull-left"><!--지원자 전화기록--> </div>
							<div class="widget-icons pull-right">
								<a href="#" id="registRecord" onclick="PositionChange()" class="wminimize"><i <%If Session("Position") = "menu-min" Then%>class="icon-chevron-down"<%Else%>class="icon-chevron-up"<%End If%>></i></a>
								<a href="#" onclick="initialize();" class="wclose"><i class="icon-remove"></i></a>
							</div>
							<div class="clearfix"></div>
						</div><!-- widget-head -->
						<div class="widget-content" id="registRecordWidgetContent">
							<div class="padd invoice" style="padding: 0;">
								<div class="row-fluid">
									<div class="span12">
										<table class="table table-striped table-hover table-bordered" style="width:100%; table-layout: fixed;">
											<tbody>
												<tr>
													<td colspan="1" style="width:100%; padding: 8px 0px; text-align: center;font-size:14px;">
														<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
														데이터 처리중...
														<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
													</td>
												</tr>
											</tbody>
										</table>
									</div><!-- span12 -->
								</div><!-- row-fluid -->
							</div><!-- padd invoice -->
						</div><!-- widget-content -->
					</div><!-- Widget -->
					<!-- Widget End -->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Form area End -->
<%
Dim FormStudentNumber, FormCommand, FormDialedTel, FormTelTemp, FormReceiver, FormResult, FormMemo, FormSEndURL
FormStudentNumber = trim(Request.Form("FormStudentNumber"))
FormCommand = trim(GetParameter(Request.Form("FormCommand"), ""))
FormDialedTel = trim(Request.Form("FormDialedTel"))
If FormDialedTel="&nbsp;" Then FormDialedTel = ""
FormTelTemp = trim(GetParameter(Request.Form("FormTelTemp"), ""))
FormReceiver = trim(GetIntParameter(Request.Form("FormReceiver"), 1))
FormResult = trim(GetIntParameter(Request.Form("FormResult"), 1))
FormMemo = Replace( Replace( trim( GetParameter( Request.Form("FormMemo") , "" ) ) , vbCrLf , "" ) , "," , "." )
'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
Dim FormRecorded
FormRecorded = GetParameter(Request.Form("FormRecorded"), "")
'자동녹음을 유지할 장치
Dim DRECORDCheckBox
DRECORDCheckBox = GetParameter(Request.Form("DRECORDCheckBox"), "")
'여주대 상시 자동녹음
DRECORDCheckBox = "checked"
If FormCommand = "DIAL" or FormCommand = "DRECORD" Then Response.Cookies("METIS")("DRECORDCheckBox") = DRECORDCheckBox
'Response.write FormResult
'Response.End


'복수지원 정보추출
Dim  PluralStudentNumber, PluralRanking, PluralScore, PluralResult, PluralFormResult
PluralStudentNumber = GetParameter(Request.Form("PluralStudentNumber"), "")
'PluralRanking = GetParameter(Request.Form("PluralRanking"), "")
'PluralScore = GetParameter(Request.Form("PluralScore"), "")
PluralResult = GetParameter(Request.Form("PluralResult"), "")

'관리자는 선택적으로 자동반영 체크가능... 상담원은 설정값 강제반영.
Dim PluralAbandon
PluralAbandon = GetParameter(Request.Form("PluralAbandon"), "")
If Session("Grade") = "상담원" Then PluralAbandon = "3"
Response.Cookies("METIS")("PluralAbandon") = PluralAbandon

'Response.write PluralAbandon
'Response.End
Dim FormRemainCheck
'복수지원이 존재할때
If PluralStudentNumber<>"" Then
	'2차 입력이 등록예정일때
	If FormResult="6" Then
		'1차 입력이 등록예정 or 등록완료 일때
		If PluralResult="6" Or PluralResult="2" Then
			'복수지원 포기입력	(1등록,2포기 -> 1포기,2등록)
			PluralFormResult="3"
'정시만 잠시 가리기
'			FormRemainCheck = "복수지원자 이어서 복수전형이 자동포기 되었습니다.\n"
			'FormRemainCheck = FormRemainCheck & PluralSubject & ": 포기로, 모집인원 1명 축소 되었습니다.\n"
			'FormRemainCheck = FormRemainCheck & replace(PluralSubject,"수시1차","수시2차") & ": 모집인원 1명 증가 되었습니다.\n"
			'FormRemainCheck = FormRemainCheck & "반드시 관리자에게 이 사실을 통보해 주세요."
		End If
		'1차 입력이 포기 일때
		If PluralResult="3" Then
			'아무작업 안한다		(1포기,2등록 -> 1포기 2등록)
		End If
	'2차 입력이 포기일때
	ElseIf FormResult="3" Then
		'1차 입력이 등록예정 or 등록완료 일때
		If PluralResult="6" Or PluralResult="2" Then
			'아무작업 안한다		(1등록,2포기 -> 1등록,2포기)
		End If
		'1차 입력이 포기 일때
		If PluralResult="3" Then
			'복수지원 등록입력	(1포기,2포기 -> 1등록,2포기)
			'아무작업 안한다		(1포기,2포기 -> 1포기,2포기)
			'동서울대 입학과 임홍재님 의견: 1차는 이미 마감 되었으므로 더 이상 번복할 수 없다.
		End If
	End If
	'2차 입력이 등록예정일때
End If
'복수지원이 존재할때

'on Error Resume Next
%>
<!--
<TABLE border=1>
<TR>
	<TD>FormStudentNumber</TD>
	<TD><%=FormStudentNumber%></TD>
</TR>
<TR>
	<TD>FormCommand</TD>
	<TD><%=FormCommand%></TD>
</TR>
<TR>
	<TD>FormDialedTel</TD>
	<TD><%=FormDialedTel%></TD>
</TR>
<TR>
	<TD>FormTelTemp</TD>
	<TD><%=FormTelTemp%></TD>
</TR>
<TR>
	<TD>FormReceiver</TD>
	<TD><%=FormReceiver%></TD>
</TR>
<TR>
	<TD>FormResult</TD>
	<TD><%=FormResult%></TD>
</TR>
<TR>
	<TD>FormMemo</TD>
	<TD><%=FormMemo%></TD>
</TR>
<TR>
	<TD>FormRecorded</TD>
	<TD><%=FormRecorded%></TD>
</TR>
<TR>
	<TD>DRECORDCheckBox</TD>
	<TD><%=DRECORDCheckBox%></TD>
</TR>
</TABLE>
-->
<%
'Response.End

'정원 초과여부 확인

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
StrSql =          "select A.MemberID, D.Subject, D.RegistrationFee, D.Division0, D.Division1, D.Division2, D.Division3, C.StudentName, B.StudentNumber, B.Status, D.SubjectCode"
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

'지원자의 이름, 상태, 통화중상담원
Set Rs2 = Server.CreateObject("ADODB.Recordset")
StrSql =          "select A.StudentNumber, A.StudentName, A.AccountNumber, A.Tel1, A.Tel2, A.Tel3, A.Tel4, A.Tel5, C.Status, C.MemberID, Citizen1, Citizen2"
StrSql = StrSql & vbCrLf & "from StudentTable A"
StrSql = StrSql & vbCrLf & "left outer join"
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select top 1 StudentNumber, MemberID, Status"
StrSql = StrSql & vbCrLf & "	from StatusRecord"
StrSql = StrSql & vbCrLf & "	where StudentNumber='" & FormStudentNumber & "'"
StrSql = StrSql & vbCrLf & "	order by idx desc"
StrSql = StrSql & vbCrLf & ") C"
StrSql = StrSql & vbCrLf & "on A.StudentNumber = C.StudentNumber"
StrSql = StrSql & vbCrLf & "where A.StudentNumber='" & FormStudentNumber & "'"
'Response.Write StrSql & "<BR>asdf<br>"
'Response.End
Rs2.Open StrSql, Dbcon, 0, 1, 1

'현재 라인의 상태
Set Rs3 = Server.CreateObject("ADODB.Recordset")
StrSql =          "select * from LineStatus where [LineNo]='" & Session("FormUsedLine") & "'"
'Response.Write StrSql & "<BR>asdf<br>"
'Response.End
Rs3.Open StrSql, Dbcon, 0, 1, 1

StatusTemp1 = Rs1("Status")'나의 상태
StatusTemp2 = Rs2("Status")'지원자의 상태
StudentNumberTemp = Rs1("StudentNumber")
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
Citizen1 = getParameter(Rs2("Citizen1"), "")
Citizen2 = getParameter(Rs2("Citizen2"), "")

'Response.write "상담원 : " & StatusTemp1 & "<BR>"
'Response.write "지원자 : " & StatusTemp2 & "<BR>"
'Response.End

RegistrationFeeTemp = Rs1("RegistrationFee")
AccountNumberTemp = Rs2("AccountNumber")
If left(FormDialedTel , 3) = "010" or left(FormDialedTel , 3) = "011" or left(FormDialedTel , 3) = "016" or left(FormDialedTel , 3) = "017" or left(FormDialedTel , 3) = "018" or left(FormDialedTel , 3) = "019" Then
    Tel(1) = FormDialedTel
    Tel(2) = FormDialedTel
    Tel(3) = FormDialedTel
    Tel(4) = FormDialedTel
    Tel(5) = FormDialedTel
Else
    Tel(1) = Rs2("Tel1")
    Tel(2) = Rs2("Tel2")
    Tel(3) = Rs2("Tel3")
    Tel(4) = Rs2("Tel4")
    Tel(5) = Rs2("Tel5")
End If

If Rs3.eof = false Then LineStatus = Rs3("LineStatus")

'환경설정값 (DialStatus, AutoAbandon) 구하기
Rs2.Close
StrSql = "select top 1 * From SettingTable order by IDX desc"
'Response.Write StrSql & "<BR>"
'Response.End
Rs2.Open StrSql, Dbcon
Dim DialStatus, AutoAbandon
DialStatus = getParameter( Rs2("DialStatus") , "" )
AutoAbandon = getParameter( Rs2("AutoAbandon") , "" )

Rs1.Close
'포기자 구제 검산
StrSql = "select "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "	select count(*) RemainRecordCount"
StrSql = StrSql & vbCrLf & "	from"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber"
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
StrSql = StrSql & vbCrLf & "			and ( Result=6 or Result=2 or Result=4 or Result=5 )"
StrSql = StrSql & vbCrLf & "	) A"
StrSql = StrSql & vbCrLf & "	inner join"
StrSql = StrSql & vbCrLf & "	("
StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX"
StrSql = StrSql & vbCrLf & "		from RegistRecord"
StrSql = StrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
StrSql = StrSql & vbCrLf & "		group by StudentNumber"
StrSql = StrSql & vbCrLf & "	) B"
StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
StrSql = StrSql & vbCrLf & ") RemainRecordCount"
StrSql = StrSql & vbCrLf & ","
StrSql = StrSql & vbCrLf & "(select Quorum from SubjectTable where SubjectCode='" & Session("FormSubjectCode") & "') Quorum"
StrSql = StrSql & vbCrLf & " "
'Response.write StrSql
Rs1.Open StrSql, Dbcon
If Rs1.EOF=false Then
    Dim RemainRecordCount, Quorum
    RemainRecordCount = getIntParameter( Rs1("RemainRecordCount"), 0)
    Quorum = getIntParameter( Rs1("Quorum"), 0)
End If
'Response.write RemainRecordCount & ","
'Response.write Quorum & ","

Rs1.Close
'작업할 지원자가 포기자 인지 검산, 포기, 미등록, 환불 모두 구제가능
StrSql =          "select top 1 *"
StrSql = StrSql & vbCrLf & "from RegistRecord"
StrSql = StrSql & vbCrLf & "where SubjectCode='" & Session("FormSubjectCode") & "'"
StrSql = StrSql & vbCrLf & "and StudentNumber='" & FormStudentNumber & "'"
StrSql = StrSql & vbCrLf & "order by idx desc"
'Response.write StrSql
Rs1.Open StrSql, Dbcon
If Rs1.EOF=false Then
    Dim StudentResult
    StudentResult = getParameter( Rs1("Result"), "")
End If
'Response.write StudentResult & ","

Dim QuorumCheck
QuorumCheck = false
'포기자 구제 검산
'관리자가 아니고, 미작업이 정원보다 크거나 같고, 포기자 라면 DIAL 불가, END 중 등록예정 미결정 미연결 불가
If Session("Grade")<>"관리자" and RemainRecordCount => Quorum and ( StudentResult ="3" or StudentResult="7" or StudentResult="10" ) Then
    'DIAL 불가, END 중 등록예정 미결정 미연결 불가
    If ( FormCommand = "DIAL" or FormCommand = "DRECORD" or FormCommand = "END") or ( FormCommand = "END" and ( FormResult = "6" or FormResult = "2" or FormResult = "4" or FormResult = "5") ) Then
        QuorumCheck = true
        Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('충원이 불가능합니다. \n후보자들 모두가 전화통보를 받았습니다.\n추가로 포기자가 더 발생해야 충원이 가능합니다.');</SCRIPT>"
        StudentNumberTemp = FormStudentNumber
        CrossTaskError = true
        FormCommand = "Reload"
    End If
End If

Rs1.Close
set Rs1=Nothing
Rs2.Close
set Rs2=Nothing
Rs3.Close
set Rs3=Nothing
'모든 전화 발신 차단
'If DialStatus="stop" And ( FormCommand = "DIAL" or FormCommand = "DRECORD" )Then
If DialStatus="stop" Then%>
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


select Case FormCommand
	'############################################################ DIAL ############################################################
	Case "DIAL"
		'내가 전화중이 아니어야 한다
		'지원자가 전화중이 아니어야 한다

		'내가 전화중
		If StatusTemp1=2 or StatusTemp1=3 Then
			'내가 전화중 & '현지원자가 전화중
			If StatusTemp2=2 or StatusTemp2=3 Then
				'내가 전화중 & '현지원자가 전화중 & '내가 현지원자와 전화중
				If StudentNumberTemp = FormStudentNumber Then
						'당신은 이미 현지원자와 전화중 입니다
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 현재 지원자와 전화중 입니다. \n기존 전화를 먼저 중지 하세요. \ncode1');</SCRIPT>"
				'내가 전화중 & '현지원자가 전화중 & '내가 타지원자와 전화중
				Else
					'당신은 이미 전화 중인 지원자가 있습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 전화중 & '현지원자가 전화중이 아니면
			Else
				'당신은 이미 전화 중인 지원자가 있습니다.
				'Response.End
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 전화중이 아니면
		Else
			'내가 전화중이 아니면 & '현지원자가 전화중
			If isNull(StatusTemp2)=false  Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다. \ncode4');</SCRIPT>"
			'내가 전화중이 아니면 & '현지원자가 전화중이 아니면
			Else
				'정상적인 명령 수행
				'일반전화 중지
				'Session("GeneralCall") = "off"
				'다이얼 명령
				If Err.Description = "" Then
					'전화중 기록
					StrSql =		""
					StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
					StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status, Tel)"
					StrSql = StrSql & vbCrLf & "	values"
					StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "',2, '"& FormDialedTel &"')"

'					'Response.Write StrSql & "<BR>"
					Dbcon.Execute(StrSql)

					''@ **************************************************************************************************
					''@ VOS 콜 commond 테이블 업데이트
					'eStrSql = "	update LINEORDE"
					eStrSql = "	update DBASE...LINEORDE"
					eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
					eStrSql = eStrSql & vbCrLf & "	,	TELEPHONE = '"& FormDialedTel &"'"
					eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
					eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
					eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

					eDbcon.Execute(eStrSql)
					''@ **************************************************************************************************
				Else
					'명령전달 실패
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description &  "\n" & Err.Source &  "');</SCRIPT>"
					Err.Clear 
				End If
			End If
		End If

	'############################################################ DRECORD ############################################################
	Case "DRECORD"
		'내가 전화중이 아니어야 한다
		'지원자가 전화중이 아니어야 한다

		'내가 전화중
		If StatusTemp1=2 or StatusTemp1=3 Then
			'내가 전화중 & '현지원자가 전화중
			If StatusTemp2=2 or StatusTemp2=3 Then
				'내가 전화중 & '현지원자가 전화중 & '내가 현지원자와 전화중
				If StudentNumberTemp = FormStudentNumber Then
						'당신은 이미 현지원자와 전화중 입니다
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 현재 지원자와 전화중 입니다. \n기존 전화를 먼저 중지 하세요. \ncode1');</SCRIPT>"
				'내가 전화중 & '현지원자가 전화중 & '내가 타지원자와 전화중
				Else
					'당신은 이미 전화 중인 지원자가 있습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 전화중 & '현지원자가 전화중이 아니면
			Else
				'당신은 이미 전화 중인 지원자가 있습니다.
				'Response.End
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 전화중이 아니면
		Else
			'내가 전화중이 아니면 & '현지원자가 전화중
			If isNull(StatusTemp2)=false  Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다. \ncode4');</SCRIPT>"
			'내가 전화중이 아니면 & '현지원자가 전화중이 아니면
			Else
				'정상적인 명령 수행
				'일반전화 중지
				'Session("GeneralCall") = "off"
				'녹음 파일 이름 지정
				Set Rs2 = Server.CreateObject("ADODB.Recordset")
				StrSql =          "select max(SaveFile) as SaveFile "
				StrSql = StrSql & vbCrLf & "from SaveFileHistory "
				StrSql = StrSql & vbCrLf & "where StudentNumber = '" & FormStudentNumber & "' "
				'Response.Write StrSql & "<BR>"
				'Response.End
				Rs2.Open StrSql, Dbcon
				'If Rs2.EOF Then
					'SaveFile = "01"
					'Response.Write SaveFile & "<BR>"
					'Response.End
				'Else 
					SaveFile = getParameter( Rs2("SaveFile") , "00" )
					SaveFile = cStr(CipherEdit(cInt(SaveFile) + 1 , "0" , 2))
				'End If
				Rs2.Close
				Set Rs2=Nothing
				'Response.Write SaveFile & "<BR>"
				'Response.End

				'다이얼 명령
				If Err.Description = "" Then
					'전화중 기록
					'녹음 기록 & 녹음파일 이름기록
					StrSql =		""
					StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
					StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status, Tel)"
					StrSql = StrSql & vbCrLf & "	values"
					StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "', 3, '"& FormDialedTel &"')"
					StrSql = StrSql & vbCrLf & "	insert into SaveFileHistory"
					StrSql = StrSql & vbCrLf & "	(StudentNumber,MemberID,SaveFile)"
					StrSql = StrSql & vbCrLf & "	values"
					StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("MemberID") & "','" & SaveFile & "')"
'					'Response.Write StrSql & "<BR>"
'					'Response.End
					Dbcon.Execute(StrSql)

					''@ **************************************************************************************************
					''@ VOS 콜 commond 테이블 업데이트
					'eStrSql = "	update LINEORDE"
					eStrSql = "	update DBASE...LINEORDE"
					eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
					'eStrSql = eStrSql & vbCrLf & "	set LINEORDER = 'DRECORD2'"
					eStrSql = eStrSql & vbCrLf & "	,	TELEPHONE = '"& FormDialedTel &"'"
					eStrSql = eStrSql & vbCrLf & "	,	RECORDFILE = '"& FormStudentNumber & SaveFile & "'"
					eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
					eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
					eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"
					
					'Dbcon.Execute(eStrSql)
					Dbcon.Execute(eStrSql)
					''@ **************************************************************************************************	
					'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
					FormRecorded = "녹음수행"
				Else
					'명령전달 실패
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description &  "\n" & Err.Source &  "');</SCRIPT>"
					Err.Clear 
				End If
			End If
		End If

	'############################################################ RECORDVOX ############################################################
	Case "RECORDVOX"
		Dim SaveFile
		'내가 전화중이 이어야 한다
		'지원자가 전화중이 이어야 한다
		'내가 지원자와 전화중 이어야 한다
		'내가 녹음중 
		If StatusTemp1 = 3 Then
			'내가 녹음중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'내가 녹음중  & '현지원자가 녹음중 & '내가 현지원자와 녹음중
				If StudentNumberTemp = FormStudentNumber Then
					'당신은 이미 현지원자와 녹음중 입니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 현재 지원자와 녹음 중 입니다. \n기존 녹음을 먼저 중지 하세요. \ncode1');</SCRIPT>"
				'내가 녹음중  & '현지원자가 녹음중 & '내가 타지원자와 녹음중
				Else
					'당신은 이미 녹음중인 지원자가 있습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 녹음중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 녹음중  & '현지원자가 NULL
			Else
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 전화중 
		ElseIf StatusTemp1 = 2 Then
			'내가 전화중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'당신은 이미 전화 중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 전화중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'내가 전화중  & '현지원자가 전화중 & '내가 현지원자와 전화중
				If StudentNumberTemp = FormStudentNumber Then
					'명령 수행
					'녹음 파일 이름 지정
					Set Rs2 = Server.CreateObject("ADODB.Recordset")
					StrSql =          "select max(SaveFile) as SaveFile "
					StrSql = StrSql & vbCrLf & "from SaveFileHistory "
					StrSql = StrSql & vbCrLf & "where StudentNumber = '" & FormStudentNumber & "' "
					'Response.Write StrSql & "<BR>"
					'Response.End
					Rs2.Open StrSql, Dbcon, 0, 1, 1
					'If Rs2.EOF Then
						'SaveFile = "01"
						'Response.Write SaveFile & "<BR>"
						'Response.End
					'Else 
						SaveFile = getParameter( Rs2("SaveFile") , "00" )
						SaveFile = cStr(CipherEdit(cInt(SaveFile) + 1 , "0" , 2))
					'End If
					Rs2.Close
					Set Rs2=Nothing
					'Response.Write SaveFile & "<BR>"
					'Response.End

					If Err.Description = "" Then
						'녹음 기록 & 녹음파일 이름기록
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status,Tel)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "', 3, '"& FormDialedTel &"')"
						StrSql = StrSql & vbCrLf & "	insert into SaveFileHistory"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,MemberID,SaveFile)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("MemberID") & "','" & SaveFile & "')"
'						'Response.Write StrSql & "<BR>"
'						'Response.End
						Dbcon.Execute(StrSql)

						''@ **************************************************************************************************
						''@ VOS 콜 commond 테이블 업데이트
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	RECORDFILE = '"& FormStudentNumber & SaveFile & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************	
						'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
						FormRecorded = "녹음수행"
					Else
						'명령전달 실패
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'내가 전화중  & '현지원자가 전화중 & '내가 타지원자와 전화중
				Else
					'당신은 이미 전화 중인 지원자가 있습니다
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 전화중  & '현지원자가 NULL
			Else
				'당신은 이미 전화 중인 지원자가 있습니다
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 NULL 
		Else
			'내가 NULL  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 녹음 중인 지원자에게 접근할 수 없습니다. \ncode8');</SCRIPT>"
			'내가 NULL  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다. \ncode9');</SCRIPT>"
			'내가 NULL  & '현지원자가 NULL
			Else
				'내가 NULL  & '현지원자가 NULL & 현재라인 사용중이면  =  받은전화 처리중 으로 간주
				If LineStatus = "사용중" Then
					'명령 수행
					'녹음 파일 이름 지정
					Set Rs2 = Server.CreateObject("ADODB.Recordset")
					StrSql =          "select max(SaveFile) as SaveFile "
					StrSql = StrSql & vbCrLf & "from SaveFileHistory "
					StrSql = StrSql & vbCrLf & "where StudentNumber = '" & FormStudentNumber & "' "
					'StrSql = StrSql & vbCrLf & "order by IDX desc "
					'Response.Write StrSql & "<BR>"
					'Response.End
					Rs2.Open StrSql, Dbcon, 0, 1, 1
					If Rs2.RecordCount=0 Then
						SaveFile = "01"
					Else 
						SaveFile = Rs2("SaveFile")
						If IsNull(SaveFile) Then
							SaveFile = "01"
						Else
							SaveFile = cStr(CipherEdit(cInt(SaveFile) + 1 , "0" , 2))
						End If
					End If
					Rs2.Close
					Set Rs2=Nothing
					'Response.Write SaveFile & "<BR>"
					'Response.End

					If Err.Description = "" Then
						'녹음 기록 & 녹음파일 이름기록
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status, Tel)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "', 3, '"& FormDialedTel &"')"
						StrSql = StrSql & vbCrLf & "	insert into SaveFileHistory"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,MemberID,SaveFile)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("MemberID") & "','" & SaveFile & "')"
'						'Response.Write StrSql & "<BR>"
'						'Response.End
						Dbcon.Execute(StrSql)

						''@ **************************************************************************************************
						''@ VOS 콜 commond 테이블 업데이트
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	RECORDFILE = '"& FormStudentNumber & SaveFile & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
						FormRecorded = "녹음수행"
					Else
						'명령전달 실패
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				Else
					'현재 지원자와 전화중이 아니므로 녹음을 시작할 수 없습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('현재 지원자와 전화 중이 아니므로 녹음을 시작할 수 없습니다. \ncode10');</SCRIPT>"
				End If
			End If
		End If

	'############################################################ RECORDEND ############################################################
	Case "RECORDEND"

		'내가 녹음중 이어야 한다
		'지원자가 녹음중 이어야 한다
		'내가 지원자와 녹음중 이어야 한다

		'내가 녹음중 
		If StatusTemp1 = 3 Then
			'내가 녹음중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'내가 녹음중  & '현지원자가 녹음중 & '내가 현지원자와 녹음중
				If StudentNumberTemp = FormStudentNumber Then
					'명령수행
					If Err.Description = "" Then
						'녹음중지 기록
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status,Tel)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "', 2, '"& FormDialedTel &"')"
'						'Response.Write StrSql & "<BR>"
'						'Response.End
						Dbcon.Execute(StrSql)

						''@ **************************************************************************************************
						''@ VOS 콜 commond 테이블 업데이트
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
					Else
						'명령전달 실패
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'내가 녹음중  & '현지원자가 녹음중 & '내가 타지원자와 녹음중
				Else
					'당신은 이미 녹음중인 지원자가 있습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 녹음중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 녹음중  & '현지원자가 NULL
			Else
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 전화중 
		ElseIf StatusTemp1 = 2 Then
			'내가 전화중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'당신은 이미 전화 중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 전화중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'내가 전화중  & '현지원자가 전화중 & '내가 현지원자와 전화중
				If StudentNumberTemp = FormStudentNumber Then
					'당신은 현지원자와 전화중 이지만 녹음중이지 않습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 현재 지원자와 전화 중 이지만 녹음 중 이지 않습니다.. \n녹음을 중지할 수 없습니다. \ncode5');</SCRIPT>"
				'내가 전화중  & '현지원자가 전화중 & '내가 타지원자와 전화중
				Else
					'당신은 이미 전화 중인 지원자가 있습니다
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 전화중  & '현지원자가 NULL
			Else
				'당신은 이미 전화 중인 지원자가 있습니다
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 NULL 
		Else
			'내가 NULL  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 녹음 중인 지원자에게 접근할 수 없습니다. \ncode8');</SCRIPT>"
			'내가 NULL  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다. \ncode9');</SCRIPT>"
			'내가 NULL  & '현지원자가 NULL
			Else
				'현재 지원자와 전화중이 아니고 녹음중이 아니므로 녹음을 중지할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('현재 지원자와 전화중이 아니고 녹음중이 아니므로 녹음을 중지할 수 없습니다. \ncode10');</SCRIPT>"
			End If
		End If

	'############################################################ END ############################################################
	Case "END"


		'내가 녹음중 또는 통화중 이어야 한다
		'지원자가 녹음중 또는 통화중 이어야 한다
		'내가 지원자와 녹음중 또는 통화중 이어야 한다
		
		'내가 녹음중 
		If StatusTemp1 = 3 Then
			'내가 녹음중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'내가 녹음중  & '현지원자가 녹음중 & '내가 현지원자와 녹음중
				If StudentNumberTemp = FormStudentNumber Then
					'End명령, 콜기록입력, 녹음기록Null입력, 상태기록Null입력
					If Err.Description = "" Then
						'콜기록ReccordFIleName입력, 녹음기록NULL입력, 상태기록NULL입력
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	declare @SaveFile as varchar(2)"
						StrSql = StrSql & vbCrLf & "	select @SaveFile = (select max(SaveFile) as SaveFile from SaveFileHistory where StudentNumber='" & FormStudentNumber & "')"
						StrSql = StrSql & vbCrLf & "	declare @SubjectCode as varchar(30)"
						StrSql = StrSql & vbCrLf & "	select @SubjectCode = (select top 1 SubjectCode from StudentTable where StudentNumber='" & FormStudentNumber & "')"
						StrSql = StrSql & vbCrLf & "	"
						StrSql = StrSql & vbCrLf & "	insert into RegistRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber, SubjectCode, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo)"
						If FormReceiver>1 Then
							StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & FormResult & "', '" & FormReceiver & "', '" & FormMemo & "')"
						Else
							StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & FormResult & "', NULL, '" & FormMemo & "')"
						End If
						StrSql = StrSql & vbCrLf & "	"
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
						StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode,'" & Session("MemberID") & "')" & vbCrLf
						'Response.Write strsql
						
						'복수지원 적용 여부
						If Session("Grade")="관리자" Then
							'관리자일 경우 자동반영 선택에 따라
							PluralAbandon = PluralAbandon 'Request.Form("PluralAbandon")
						Else
							'상담원일 경우 환경설정 -> 복수지원 자동포기 설정에 따라
							'If AutoAbandon = 1 Then
							If AutoAbandon = "1" Then
								PluralAbandon = 3
							Else
								PluralAbandon = 0
							End if
						End if
						
						'복수지원 처리
						'If PluralFormResult = "3" Then
						PluralFormResult = "3"

						'등록예정 입력중이고, 복수지원 수험번호가 존재하고, 자동반영이 3 일 경우 복수전형 전체 포기쿼리 작성
						If FormResult = 6 And PluralStudentNumber <> "" And PluralAbandon = "3" Then
							Dim RsDup, StrSqlDup
							Set RsDup = Server.CreateObject("ADODB.Recordset")
							'이미 등록예정, 등록완료 기록이 있는 지원자만 자동포기 시킨다!!!!! 왜냐면, 건축과 녹취중 호텔조리과는 순위외 일때 호텔을 자동포기 시키면 나중에 충원할 때 보이지 않아서 지원의사를 물을 수 없다.
							StrSqlDup =		  "select ET.SubjectCode, ET.StudentNumber, CCT.Subject, CCT.Division0, CCT.Division1, CCT.Division2, CCT.Division3"
							StrSqlDup = StrSqlDup & vbCrLf & "from StudentTable ET"
							
							StrSqlDup = StrSqlDup & vbCrLf & "inner join SubjectTable CCT"
							StrSqlDup = StrSqlDup & vbCrLf & "on ET.SubjectCode = CCT.SubjectCode"

							StrSqlDup = StrSqlDup & vbCrLf & "inner join RegistRecord CR"
							StrSqlDup = StrSqlDup & vbCrLf & "on ET.StudentNumber = CR.StudentNumber"

							StrSqlDup = StrSqlDup & vbCrLf & "inner join"
							StrSqlDup = StrSqlDup & vbCrLf & "("
							StrSqlDup = StrSqlDup & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX "
							StrSqlDup = StrSqlDup & vbCrLf & "	from RegistRecord"
							StrSqlDup = StrSqlDup & vbCrLf & "	group by StudentNumber"
							StrSqlDup = StrSqlDup & vbCrLf & ") B"
							StrSqlDup = StrSqlDup & vbCrLf & "on CR.StudentNumber = B.StudentNumber"
							StrSqlDup = StrSqlDup & vbCrLf & "and CR.IDX = B.MaxIDX"

							StrSqlDup = StrSqlDup & vbCrLf & "where Citizen1='" & Citizen1 & "'"
							StrSqlDup = StrSqlDup & vbCrLf & "and Citizen2='" & Citizen2 & "'"
							StrSqlDup = StrSqlDup & vbCrLf & "and ET.StudentNumber<>'" & FormStudentNumber & "'"
							'StrSqlDup = StrSqlDup & vbCrLf & "and (Result = '2' or Result = '4' or Result = '6')"
							StrSqlDup = StrSqlDup & vbCrLf & "and (Result = '6' or Result = '6' or Result = '6')"

							'Response.write StrSqlDup
							'Response.End
							RsDup.Open StrSqlDup, Dbcon
							Dim PluralSubject, PluralSubjectCode
							'If Rs2.EOF = false Then
							Do Until RsDup.EOF
								PluralSubjectCode = GetParameter(RsDup("SubjectCode"), "")
								PluralStudentNumber = GetParameter(RsDup("StudentNumber"), "")
								'PluralSubject =  GetParameter(RsDup("Division0"), "") & " " & GetParameter(RsDup("Subject"), "") & " " & GetParameter(RsDup("Division1"), "") & " " & GetParameter(RsDup("Division2"), "") & " " & GetParameter(RsDup("Division3"), "")
								'복수지원 포기입력
								StrSql = StrSql & vbCrLf & "	insert into RegistRecord"
								StrSql = StrSql & vbCrLf & "	(StudentNumber, SubjectCode, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo, PluralStudentNumber)"
								If FormReceiver>1 Then
									StrSql = StrSql & vbCrLf & "	values ('" & PluralStudentNumber & "', '" & PluralSubjectCode & "', '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & PluralFormResult & "', '" & FormReceiver & "', '[자동포기] " & SubjectTemp & DivisionTemp & " 등록 " & FormMemo & "', '" & FormStudentNumber & "')"
								Else
									StrSql = StrSql & vbCrLf & "	values ('" & PluralStudentNumber & "', '" & PluralSubjectCode & "', '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & PluralFormResult & "',  NULL                 , '[자동포기] " & SubjectTemp & DivisionTemp & " 등록 " & FormMemo & "', '" & FormStudentNumber & "')"
								End If
								StrSql = StrSql & vbCrLf & "	Update StudentTable"
								StrSql = StrSql & vbCrLf & "	set ETC3='[자동포기]'"
								StrSql = StrSql & vbCrLf & "	where StudentNumber = '" & FormStudentNumber & "'"
								StrSql = StrSql & vbCrLf & "	or StudentNumber = '" & PluralStudentNumber & "'"
								RsDup.MoveNext
							Loop
							'End If
							'Response.write PluralStudentNumber
							RsDup.Close
							Set RsDup = Nothing
						End If

						StrSql = StrSql & vbCrLf & ""
						'StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback"
						'Response.write "test111 : "& FormResult &","& PluralStudentNumber &","& PluralAbandon
						'Response.Write StrSql & "<BR>"
						'Response.End
						Dbcon.Execute(StrSql)


						''@ **************************************************************************************************
						''@ VOS 콜 commond 테이블 업데이트
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
						FormRecorded = ""
						'#########################################
						'##문자발송
						'#########################################
						If Session("FormDivision0")<>"편입" Then
							SMSSEnd
						End If
					Else
						'명령전달 실패
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('서버로 명령전달이 실패했습니다. 서버 상태를 점검하세요.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'내가 녹음중  & '현지원자가 녹음중 & '내가 타지원자와 녹음중
				Else
					'당신은 이미 녹음중인 지원자가 있습니다.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 녹음중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 녹음중  & '현지원자가 NULL
			Else
				'당신은 이미 녹음중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 녹음 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 전화중 
		ElseIf StatusTemp1 = 2 Then
			'내가 전화중  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'당신은 이미 전화 중인 지원자가 있습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'내가 전화중  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'내가 전화중  & '현지원자가 전화중 & '내가 현지원자와 전화중
				If StudentNumberTemp = FormStudentNumber Then
					'END명령, 콜기록입력, 녹음기록Null입력, 상태기록Null입력
					If Err.Description = "" Then
						'콜기록ReccordFIleName입력, 녹음기록NULL입력, 상태기록NULL입력
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	declare @SaveFile as varchar(2)"
						StrSql = StrSql & vbCrLf & "	select @SaveFile = (select max(SaveFile) as SaveFile from SaveFileHistory where StudentNumber = '" & FormStudentNumber & "' )"
						StrSql = StrSql & vbCrLf & "	declare @SubjectCode as varchar(30)"
						StrSql = StrSql & vbCrLf & "	select @SubjectCode = (select top 1 SubjectCode from StudentTable where StudentNumber='" & FormStudentNumber & "')"
						StrSql = StrSql & vbCrLf & "	"
						StrSql = StrSql & vbCrLf & "	insert into RegistRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber, SubjectCode, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo)"
						If FormReceiver>1 Then
							If FormRecorded<>"" Then
								StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & FormResult & "', '" & FormReceiver & "', '" & FormMemo & "')"
							Else
								StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', NULL, '" & FormResult & "', '" & FormReceiver & "', '" & FormMemo & "')"
							End If
						Else
							If FormRecorded<>"" Then
								StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & FormResult & "', NULL, '" & FormMemo & "')"
							Else
								StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', NULL, '" & FormResult & "', NULL, '" & FormMemo & "')"
							End If
						End If
						StrSql = StrSql & vbCrLf & "	"
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
						StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"

						StrSql = StrSql & vbCrLf & ""
'						StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback"
'						'Response.Write StrSql & "<BR>"
'						'Response.End
						Dbcon.Execute(StrSql)

						''@ **************************************************************************************************
						''@ VOS 콜 commond 테이블 업데이트
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
						FormRecorded = ""
						'#########################################
						'##문자발송
						'#########################################
						If Session("FormDivision0")<>"편입" Then
							SMSSEnd
						End If
					End If
				'내가 전화중  & '현지원자가 전화중 & '내가 타지원자와 전화중
				Else
					'당신은 이미 전화 중인 지원자가 있습니다
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'내가 전화중  & '현지원자가 NULL
			Else
				'당신은 이미 전화 중인 지원자가 있습니다
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('당신은 이미 전화 중인 지원자가 있습니다. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " 입니다.\n이 지원자 에게로 이동하겠습니다.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'내가 NULL 
		Else
			'내가 NULL  & '현지원자가 녹음중
			If StatusTemp2 = 3 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 녹음 중인 지원자에게 접근할 수 없습니다. \ncode7');</SCRIPT>"
			'내가 NULL  & '현지원자가 전화중
			ElseIf StatusTemp2 = 2 Then
				'다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('다른 상담원이 전화 중인 지원자에게 접근할 수 없습니다. \ncode8');</SCRIPT>"
			'내가 NULL  & '현지원자가 NULL
			Else
				'현재 지원자와 전화중이 아니고 녹음중이 아니므로 녹음을 중지할 수 없습니다.
				'다만 현재 지원자의 RegistRecord를 상담원 권한으로 항목 추가할 수 있다 이때는 받은사람, 녹음파일명이 생략된다
				'If FormResult<>"" and FormDialedTel	= "" Then
					'콜기록ReccordFIleName입력, 녹음기록NULL입력, 상태기록NULL입력
					StrSql =          "begin tran"
					StrSql = StrSql & vbCrLf & "	declare @SubjectCode as varchar(30)"
					StrSql = StrSql & vbCrLf & "	select @SubjectCode = (select top 1 SubjectCode from StudentTable where StudentNumber='" & FormStudentNumber & "')"
					StrSql = StrSql & vbCrLf & "	insert into RegistRecord"
					StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode, Degree, UsedLine, MemberID, Result, Memo)"
					StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "', @SubjectCode, '" & Session("FormDegree") & "', '0', '" & Session("MemberID") & "', '" & FormResult & "'"
					StrSql = StrSql & vbCrLf & ", '" & FormMemo & "')"
					StrSql = StrSql & vbCrLf & "If @@Error=0 commit tran Else rollback"
					'Response.Write StrSql & "<BR>"
					'Response.End
					Dbcon.Execute(StrSql)
					'녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
					FormRecorded = ""
				'Else
				'	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('현재 지원자와 전화중이 아니고 녹음중이 아니므로 녹음을 중지할 수 없습니다. \ncode9');</SCRIPT>"
				'End If

			End If
		End If

	'############################################################ Reload ############################################################
	Case "Reload"
		
		'내가 녹음중  & '현지원자가 녹음중 & '내가 현지원자와 녹음중 
		'If ( StatusTemp1 = 3 and StatusTemp2 = 3 and StudentNumberTemp = FormStudentNumber ) or ( StatusTemp1 = 2 and StatusTemp2 = 2 and StudentNumberTemp = FormStudentNumber ) Then
		'무조건 전화 중지다 그래야만 기타 에러 발생시에 취소가 가능하다
        If Err.Description = "" Then
            '녹음기록NULL입력, 상태기록NULL입력
            StrSql =		""
            StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
            StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
            StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"
            StrSql = StrSql & vbCrLf & ""
'			'Response.Write StrSql & "<BR>"
'			'Response.End
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
            '녹음중지버튼을 누른 후에도 현재콜의 녹음수행 여부를 기록할 임시장치
            FormRecorded = ""
        End If


	'############################################################ Cancel ############################################################
	Case "Cancel"
		
		'내가 녹음중  & '현지원자가 녹음중 & '내가 현지원자와 녹음중 
		'또는 내가 전화중  & '현지원자가 전화중 & '내가 현지원자와 전화중 
		If ( StatusTemp1 = 3 and StatusTemp2 = 3 and StudentNumberTemp = FormStudentNumber ) or ( StatusTemp1 = 2 and StatusTemp2 = 2 and StudentNumberTemp = FormStudentNumber ) Then
                        
            If Err.Description = "" Then
                '콜기록ReccordFIleName입력, 녹음기록NULL입력, 상태기록NULL입력
                StrSql =		""
                StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
                StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
                StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"
                StrSql = StrSql & vbCrLf & ""
    '			'Response.Write StrSql & "<BR>"
    '			'Response.End
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


	'############################################################ ONHOOK ############################################################
	Case "ONHOOK"
	'받은전화 끊기 또는 타 용도 전화 중지


        ''@ **************************************************************************************************
        ''@ VOS 콜 commond 테이블 업데이트
        'eStrSql =		"	update LINEORDE"
		eStrSql = "	update DBASE...LINEORDE"
        eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
        eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
        eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
        eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

        eDbcon.Execute(eStrSql)
        ''@ **************************************************************************************************
	'############################################################ OFFHOOK ############################################################
	Case "OFFHOOK"
	'전화받기 또는 타 용도 전화 시작

        ''@ **************************************************************************************************
        ''@ VOS 콜 commond 테이블 업데이트
        'eStrSql =		"	update LINEORDE"
		eStrSql = "	update DBASE...LINEORDE"
        eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
        eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
        eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
        eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

        eDbcon.Execute(eStrSql)
        ''@ **************************************************************************************************
End Select

'명령전달 실패라면
If Err.Description <> "" Then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('결과 처리가 실패했습니다.\n" & Replace(Err.Description, "'", chr(34)) & "');</SCRIPT>"
	Err.Clear 
End If
'Response.End

'정원 초과여부 검사
Dim Rs4, qStrSql, RemainCheck
Set Rs4 = Server.CreateObject("ADODB.Recordset")
qStrSql =          "Declare @RemainCheck as varchar(3)"
qStrSql = qStrSql & vbCrLf & "If"
qStrSql = qStrSql & vbCrLf & "(select quorum from SubjectTable where SubjectCode='" & Session("FormSubjectCode") & "')"
qStrSql = qStrSql & vbCrLf & ">"
qStrSql = qStrSql & vbCrLf & "("
qStrSql = qStrSql & vbCrLf & "	select count(*) from"
qStrSql = qStrSql & vbCrLf & "	("
qStrSql = qStrSql & vbCrLf & "		select IDX, StudentNumber, Result"
qStrSql = qStrSql & vbCrLf & "		from RegistRecord"
qStrSql = qStrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
qStrSql = qStrSql & vbCrLf & "		and ( Result='6' or Result=2 )"
qStrSql = qStrSql & vbCrLf & "	) A"
qStrSql = qStrSql & vbCrLf & "	inner join"
qStrSql = qStrSql & vbCrLf & "	("
qStrSql = qStrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX"
qStrSql = qStrSql & vbCrLf & "		from RegistRecord"
qStrSql = qStrSql & vbCrLf & "		where SubjectCode='" & Session("FormSubjectCode") & "'"
qStrSql = qStrSql & vbCrLf & "		group by StudentNumber"
qStrSql = qStrSql & vbCrLf & "	) B"
qStrSql = qStrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
qStrSql = qStrSql & vbCrLf & "	and A.IDX = B.MaxIDX"
qStrSql = qStrSql & vbCrLf & ")"
qStrSql = qStrSql & vbCrLf & "select @RemainCheck = 'Go'"
qStrSql = qStrSql & vbCrLf & "Else"
qStrSql = qStrSql & vbCrLf & "select @RemainCheck = 'END'"
qStrSql = qStrSql & vbCrLf & "select @RemainCheck as RemainCheck"
'Response.Write qStrSql

Rs4.Open qStrSql, Dbcon, 0, 1, 1
RemainCheck = Rs4("RemainCheck")
Rs4.Close
set Rs4 = Nothing
'Response.Write RemainCheck
'Response.Write FormCommand
%>

<%'If FormCommand = "Cancel" or FormCommand = "END" Then %>
<%If FormCommand = "Cancel" Then %>
	<!-- <INPUT TYPE="BUTTON" value="메인으로 이동" onclick="document.location.href='Root.asp'">  -->
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		document.location.href="<%=Request.ServerVariables("HTTP_REFERER")%>"
	//-->
	</SCRIPT>
<%Else%>
	<%If CrossTaskError Then%>
		<FORM METHOD=POST ACTION="<%=Request.ServerVariables("HTTP_REFERER")%>" name="CommandForm">
			<input type="Hidden" name="FormStudentNumber" value="<%=StudentNumberTemp%>">
			<input type="Hidden" name="FormCommand" value="<%=FormCommand%>">
			<input type="Hidden" name="FormDialedTel" value="<%=FormDialedTel%>">
			<input type="Hidden" name="FormTelTemp" value="<%=FormTelTemp%>">
			<input type="Hidden" name="FormReceiver" value="<%=FormReceiver%>">
			<input type="Hidden" name="FormResult" value="<%=FormResult%>">
			<input type="Hidden" name="FormMemo" value="<%=FormMemo%>">
			<input type="Hidden" name="FormRecorded" value="<%=FormRecorded%>">
			<!--
			<INPUT TYPE="submit">
			-->
		</FORM>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			CommandForm.submit();
		//-->
		</SCRIPT>
	<%Else%><!-- 기본 전화 제어 -->
		<FORM METHOD=POST ACTION="<%=Request.ServerVariables("HTTP_REFERER")%>" name="CommandForm">
			<%If RemainCheck = "END" Then ' 정원 초과여부 검사%>
				<input type="Hidden" name="FormRemainCheck" value="현재 학과는 충원이 완료되었습니다.\n추가 작업은 신중히 결정하세요">
			<%End If%>
			<%'배화여대 결과입력 후 리스트로 잠시 생략
			'if FormCommand <> "END" then%>
			<input type="Hidden" name="FormStudentNumber" value="<%=FormStudentNumber%>">
			<%'End If%>
			<input type="Hidden" name="FormCommand" value="<%=FormCommand%>">
			<input type="Hidden" name="FormDialedTel" value="<%=FormDialedTel%>">
			<input type="Hidden" name="FormTelTemp" value="<%=FormTelTemp%>">
			<input type="Hidden" name="FormReceiver" value="<%=FormReceiver%>">
			<input type="Hidden" name="FormResult" value="<%=FormResult%>">
			<input type="Hidden" name="FormMemo" value="<%=FormMemo%>">
			<input type="Hidden" name="FormRecorded" value="<%=FormRecorded%>">
			<%if FormCommand = "END" then%>
			<input type="Hidden" name="FormSendURL" value="<%=FormSendURL%>">
			<%End If%>
			<!--
			<INPUT TYPE="submit">
			-->
		</FORM>
		<%'="FormSendURL: " & FormSendURL%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			//CommandForm.submit();
			setTimeout("CommandForm.submit();", 1000);
		//-->
		</SCRIPT>
	<%End If%>
<%End If%>
<%

'Response.write Session("SMSAutoConfirm")&" asdfasdf"
'#########################################
'##문자발송
'#########################################
Sub SMSSEnd
dim StrSql, FormCommand, FormSMSDestination
	If Session("SMSConfirm")="1" and Session("SMSAutoConfirm")="1" and (FormResult = 6 or FormResult = 3) Then '등록예정,포기로 결정날 경우 발송

		If left(FormDialedTel , 3) = "010" or left(FormDialedTel , 3) = "011" or left(FormDialedTel , 3) = "016" or left(FormDialedTel , 3) = "017" or left(FormDialedTel , 3) = "018" or left(FormDialedTel , 3) = "019" Then '지금 건 전화가 핸드폰이면
			SMSBody = "[" & Session("UniversityName") & "]"
			If FormResult = 3 Then
				SMSBody = SMSBody & StudentNameTemp & "님 " & SubjectTemp & " " & Division0Temp & " 포기 입니다. "
			ElseIf FormResult = 6 Then
				SMSBody = SMSBody & StudentNameTemp & "님 "
				If Session("SMSBodyRegistrationFee")="1" Then
					SMSBody = SMSBody & "등록금" & RegistrationFeeTemp & "원 "
				End If
				If Session("SMSBodyAccountNumber")="1" Then
					SMSBody = SMSBody & AccountNumberTemp & " "
				End If
				If Session("SMSBodyRegistrationTime")="1" Then
					If RegistrationFeeTemp >= 400000 then
						SMSBody = SMSBody & "등록 기간은 " & Session("RegistrationTime") & "까지"
					Else
						SMSBody = SMSBody & "예치등록 기간은 " & Session("RegistrationTime") & "까지"
					End If
				End If
				If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
					SMSBody = SMSBody & "최종 결정은 " & SubjectTemp & " 등록 입니다."
				End If
			End If
			FormSMSDestination = DestinationFiltering(FormDialedTel)
		Else	'지금 건 전화가 핸드폰이면
			for i = 1 to 5
				If left(Tel(i) , 3) = "010" or left(Tel(i) , 3) = "011" or left(Tel(i) , 3) = "016" or left(Tel(i) , 3) = "017" or left(Tel(i) , 3) = "018" or left(Tel(i) , 3) = "019" Then
					SMSBody = "[" & Session("UniversityName") & "]"
					If FormResult = 3 Then
						SMSBody = SMSBody & StudentNameTemp & "님 " & SubjectTemp & " " & Division0Temp & " 포기 입니다."
					ElseIf FormResult = 6 Then
						SMSBody = SMSBody & StudentNameTemp & "님 "
						If Session("SMSBodyRegistrationFee")="1" Then
							SMSBody = SMSBody & "등록금" & RegistrationFeeTemp & "원 "
						End If
						If Session("SMSBodyAccountNumber")="1" Then
							SMSBody = SMSBody & AccountNumberTemp & " "
						End If
						If Session("SMSBodyRegistrationTime")="1" Then
							If RegistrationFeeTemp >= 400000 then
								SMSBody = SMSBody & "등록 기간은 " & Session("RegistrationTime") & "까지"
							Else
								SMSBody = SMSBody & "예치등록 기간은 " & Session("RegistrationTime") & "까지"
							End If
						End If
						If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
							SMSBody = SMSBody & "최종 결정은 " & SubjectTemp & " 등록 입니다."
						End If
					End If
					FormSMSDestination = DestinationFiltering(Tel(i))
					exit for
				End If
			next
		End If	'지금 건 전화가 핸드폰이면

		'If StrSql<>"" Then	'발송 가능하면 발송 시작
			'Response.Write StrSql
			'Response.End '전화를 끊는 순간 입력되는 순간 기록해야 한다
			'Set DbconSMS = Server.CreateObject("ADODB.Connection") 
			'DbconSMS.Open "provider=SqlOLEDB.1;Password=ky6140;Persist Security Info=True;User ID=MetisSmsSender; Initial Catalog=SMS3;Data source=mobilekiss.metissoft.com;Connect Timeout=5;"
			'DbconSMS.Execute StrSql
			'DbconSMS.Close
			'set DbconSMS = Nothing
			'명령전달 실패라면

			FormSendURL = "http://s.metissoft.com/sms/MetisSmsSend.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & "&tran_phone=" & FormSMSDestination

			If Err.Description <> "" Then
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS 발송이 실패했습니다.\n" & Err.Description & "');</SCRIPT>"
				Err.Clear 
			End If
		'End If

	End If	'등록,포기로 결정날 경우 발송
End Sub
%>




<!--<input type="button" onclick="centerCount = 1; moveToCenter()" value="moveToCenter">-->


                </div>
            </div>
        </div>
    </div>
</div>
	
		

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
<script type="text/javascript">
    function moveToCenter(){
        if (centerCount<3){
            $popup.moveToCenter()
            setTimeout(moveToCenter,500);
            centerCount += 1
            //console.log(centerCount);
        }
    }
    window.onload = moveToCenter();

    function startBlink() {
        var objBlink = document.all.tags("BLINK")
        for (var i=0; i < objBlink.length; i++)
            objBlink[i].style.visibility = objBlink[i].style.visibility == "" ? "hidden" : ""
    }
    function init() {
        if (document.all)
            setInterval("startBlink()",300)
    }
    window.onload = init;
    
</script>
</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
<%eDbcon.Close
Set eDbcon = Nothing%>