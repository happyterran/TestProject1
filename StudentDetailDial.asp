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
<title>������ ���λ���</title>
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
							<div class="pull-left"><!--������ ��ȭ���--> </div>
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
														������ ó����...
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
'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
Dim FormRecorded
FormRecorded = GetParameter(Request.Form("FormRecorded"), "")
'�ڵ������� ������ ��ġ
Dim DRECORDCheckBox
DRECORDCheckBox = GetParameter(Request.Form("DRECORDCheckBox"), "")
'���ִ� ��� �ڵ�����
DRECORDCheckBox = "checked"
If FormCommand = "DIAL" or FormCommand = "DRECORD" Then Response.Cookies("METIS")("DRECORDCheckBox") = DRECORDCheckBox
'Response.write FormResult
'Response.End


'�������� ��������
Dim  PluralStudentNumber, PluralRanking, PluralScore, PluralResult, PluralFormResult
PluralStudentNumber = GetParameter(Request.Form("PluralStudentNumber"), "")
'PluralRanking = GetParameter(Request.Form("PluralRanking"), "")
'PluralScore = GetParameter(Request.Form("PluralScore"), "")
PluralResult = GetParameter(Request.Form("PluralResult"), "")

'�����ڴ� ���������� �ڵ��ݿ� üũ����... ������ ������ �����ݿ�.
Dim PluralAbandon
PluralAbandon = GetParameter(Request.Form("PluralAbandon"), "")
If Session("Grade") = "����" Then PluralAbandon = "3"
Response.Cookies("METIS")("PluralAbandon") = PluralAbandon

'Response.write PluralAbandon
'Response.End
Dim FormRemainCheck
'���������� �����Ҷ�
If PluralStudentNumber<>"" Then
	'2�� �Է��� ��Ͽ����϶�
	If FormResult="6" Then
		'1�� �Է��� ��Ͽ��� or ��ϿϷ� �϶�
		If PluralResult="6" Or PluralResult="2" Then
			'�������� �����Է�	(1���,2���� -> 1����,2���)
			PluralFormResult="3"
'���ø� ��� ������
'			FormRemainCheck = "���������� �̾ ���������� �ڵ����� �Ǿ����ϴ�.\n"
			'FormRemainCheck = FormRemainCheck & PluralSubject & ": �����, �����ο� 1�� ��� �Ǿ����ϴ�.\n"
			'FormRemainCheck = FormRemainCheck & replace(PluralSubject,"����1��","����2��") & ": �����ο� 1�� ���� �Ǿ����ϴ�.\n"
			'FormRemainCheck = FormRemainCheck & "�ݵ�� �����ڿ��� �� ����� �뺸�� �ּ���."
		End If
		'1�� �Է��� ���� �϶�
		If PluralResult="3" Then
			'�ƹ��۾� ���Ѵ�		(1����,2��� -> 1���� 2���)
		End If
	'2�� �Է��� �����϶�
	ElseIf FormResult="3" Then
		'1�� �Է��� ��Ͽ��� or ��ϿϷ� �϶�
		If PluralResult="6" Or PluralResult="2" Then
			'�ƹ��۾� ���Ѵ�		(1���,2���� -> 1���,2����)
		End If
		'1�� �Է��� ���� �϶�
		If PluralResult="3" Then
			'�������� ����Է�	(1����,2���� -> 1���,2����)
			'�ƹ��۾� ���Ѵ�		(1����,2���� -> 1����,2����)
			'������� ���а� ��ȫ��� �ǰ�: 1���� �̹� ���� �Ǿ����Ƿ� �� �̻� ������ �� ����.
		End If
	End If
	'2�� �Է��� ��Ͽ����϶�
End If
'���������� �����Ҷ�

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

'���� �ʰ����� Ȯ��

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

'������ ��ȭ���� ������ �����ȣ, �̸�, ����, �а���, ������, ���������ڵ�
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

'�������� �̸�, ����, ��ȭ�߻���
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

'���� ������ ����
Set Rs3 = Server.CreateObject("ADODB.Recordset")
StrSql =          "select * from LineStatus where [LineNo]='" & Session("FormUsedLine") & "'"
'Response.Write StrSql & "<BR>asdf<br>"
'Response.End
Rs3.Open StrSql, Dbcon, 0, 1, 1

StatusTemp1 = Rs1("Status")'���� ����
StatusTemp2 = Rs2("Status")'�������� ����
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

'Response.write "���� : " & StatusTemp1 & "<BR>"
'Response.write "������ : " & StatusTemp2 & "<BR>"
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

'ȯ�漳���� (DialStatus, AutoAbandon) ���ϱ�
Rs2.Close
StrSql = "select top 1 * From SettingTable order by IDX desc"
'Response.Write StrSql & "<BR>"
'Response.End
Rs2.Open StrSql, Dbcon
Dim DialStatus, AutoAbandon
DialStatus = getParameter( Rs2("DialStatus") , "" )
AutoAbandon = getParameter( Rs2("AutoAbandon") , "" )

Rs1.Close
'������ ���� �˻�
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
'�۾��� �����ڰ� ������ ���� �˻�, ����, �̵��, ȯ�� ��� ��������
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
'������ ���� �˻�
'�����ڰ� �ƴϰ�, ���۾��� �������� ũ�ų� ����, ������ ��� DIAL �Ұ�, END �� ��Ͽ��� �̰��� �̿��� �Ұ�
If Session("Grade")<>"������" and RemainRecordCount => Quorum and ( StudentResult ="3" or StudentResult="7" or StudentResult="10" ) Then
    'DIAL �Ұ�, END �� ��Ͽ��� �̰��� �̿��� �Ұ�
    If ( FormCommand = "DIAL" or FormCommand = "DRECORD" or FormCommand = "END") or ( FormCommand = "END" and ( FormResult = "6" or FormResult = "2" or FormResult = "4" or FormResult = "5") ) Then
        QuorumCheck = true
        Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �Ұ����մϴ�. \n�ĺ��ڵ� ��ΰ� ��ȭ�뺸�� �޾ҽ��ϴ�.\n�߰��� �����ڰ� �� �߻��ؾ� ����� �����մϴ�.');</SCRIPT>"
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
'��� ��ȭ �߽� ����
'If DialStatus="stop" And ( FormCommand = "DIAL" or FormCommand = "DRECORD" )Then
If DialStatus="stop" Then%>
    <SCRIPT LANGUAGE="JavaScript">alert("���а��� ��û�Դϴ�. ��ȭ�� ��� �ߴ��� �ּ���. DB�۾��� �������Դϴ�.")
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
		'���� ��ȭ���� �ƴϾ�� �Ѵ�
		'�����ڰ� ��ȭ���� �ƴϾ�� �Ѵ�

		'���� ��ȭ��
		If StatusTemp1=2 or StatusTemp1=3 Then
			'���� ��ȭ�� & '�������ڰ� ��ȭ��
			If StatusTemp2=2 or StatusTemp2=3 Then
				'���� ��ȭ�� & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ��
				If StudentNumberTemp = FormStudentNumber Then
						'����� �̹� �������ڿ� ��ȭ�� �Դϴ�
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� �����ڿ� ��ȭ�� �Դϴ�. \n���� ��ȭ�� ���� ���� �ϼ���. \ncode1');</SCRIPT>"
				'���� ��ȭ�� & '�������ڰ� ��ȭ�� & '���� Ÿ�����ڿ� ��ȭ��
				Else
					'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ��ȭ�� & '�������ڰ� ��ȭ���� �ƴϸ�
			Else
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
				'Response.End
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� ��ȭ���� �ƴϸ�
		Else
			'���� ��ȭ���� �ƴϸ� & '�������ڰ� ��ȭ��
			If isNull(StatusTemp2)=false  Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�. \ncode4');</SCRIPT>"
			'���� ��ȭ���� �ƴϸ� & '�������ڰ� ��ȭ���� �ƴϸ�
			Else
				'�������� ��� ����
				'�Ϲ���ȭ ����
				'Session("GeneralCall") = "off"
				'���̾� ���
				If Err.Description = "" Then
					'��ȭ�� ���
					StrSql =		""
					StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
					StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status, Tel)"
					StrSql = StrSql & vbCrLf & "	values"
					StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "',2, '"& FormDialedTel &"')"

'					'Response.Write StrSql & "<BR>"
					Dbcon.Execute(StrSql)

					''@ **************************************************************************************************
					''@ VOS �� commond ���̺� ������Ʈ
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
					'������� ����
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description &  "\n" & Err.Source &  "');</SCRIPT>"
					Err.Clear 
				End If
			End If
		End If

	'############################################################ DRECORD ############################################################
	Case "DRECORD"
		'���� ��ȭ���� �ƴϾ�� �Ѵ�
		'�����ڰ� ��ȭ���� �ƴϾ�� �Ѵ�

		'���� ��ȭ��
		If StatusTemp1=2 or StatusTemp1=3 Then
			'���� ��ȭ�� & '�������ڰ� ��ȭ��
			If StatusTemp2=2 or StatusTemp2=3 Then
				'���� ��ȭ�� & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ��
				If StudentNumberTemp = FormStudentNumber Then
						'����� �̹� �������ڿ� ��ȭ�� �Դϴ�
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� �����ڿ� ��ȭ�� �Դϴ�. \n���� ��ȭ�� ���� ���� �ϼ���. \ncode1');</SCRIPT>"
				'���� ��ȭ�� & '�������ڰ� ��ȭ�� & '���� Ÿ�����ڿ� ��ȭ��
				Else
					'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ��ȭ�� & '�������ڰ� ��ȭ���� �ƴϸ�
			Else
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
				'Response.End
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� ��ȭ���� �ƴϸ�
		Else
			'���� ��ȭ���� �ƴϸ� & '�������ڰ� ��ȭ��
			If isNull(StatusTemp2)=false  Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�. \ncode4');</SCRIPT>"
			'���� ��ȭ���� �ƴϸ� & '�������ڰ� ��ȭ���� �ƴϸ�
			Else
				'�������� ��� ����
				'�Ϲ���ȭ ����
				'Session("GeneralCall") = "off"
				'���� ���� �̸� ����
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

				'���̾� ���
				If Err.Description = "" Then
					'��ȭ�� ���
					'���� ��� & �������� �̸����
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
					''@ VOS �� commond ���̺� ������Ʈ
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
					'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
					FormRecorded = "��������"
				Else
					'������� ����
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description &  "\n" & Err.Source &  "');</SCRIPT>"
					Err.Clear 
				End If
			End If
		End If

	'############################################################ RECORDVOX ############################################################
	Case "RECORDVOX"
		Dim SaveFile
		'���� ��ȭ���� �̾�� �Ѵ�
		'�����ڰ� ��ȭ���� �̾�� �Ѵ�
		'���� �����ڿ� ��ȭ�� �̾�� �Ѵ�
		'���� ������ 
		If StatusTemp1 = 3 Then
			'���� ������  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'���� ������  & '�������ڰ� ������ & '���� �������ڿ� ������
				If StudentNumberTemp = FormStudentNumber Then
					'����� �̹� �������ڿ� ������ �Դϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� �����ڿ� ���� �� �Դϴ�. \n���� ������ ���� ���� �ϼ���. \ncode1');</SCRIPT>"
				'���� ������  & '�������ڰ� ������ & '���� Ÿ�����ڿ� ������
				Else
					'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ������  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ������  & '�������ڰ� NULL
			Else
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� ��ȭ�� 
		ElseIf StatusTemp1 = 2 Then
			'���� ��ȭ��  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ��ȭ��  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ��
				If StudentNumberTemp = FormStudentNumber Then
					'��� ����
					'���� ���� �̸� ����
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
						'���� ��� & �������� �̸����
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
						''@ VOS �� commond ���̺� ������Ʈ
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	RECORDFILE = '"& FormStudentNumber & SaveFile & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************	
						'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
						FormRecorded = "��������"
					Else
						'������� ����
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� Ÿ�����ڿ� ��ȭ��
				Else
					'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ��ȭ��  & '�������ڰ� NULL
			Else
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� NULL 
		Else
			'���� NULL  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ���� ���� �����ڿ��� ������ �� �����ϴ�. \ncode8');</SCRIPT>"
			'���� NULL  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�. \ncode9');</SCRIPT>"
			'���� NULL  & '�������ڰ� NULL
			Else
				'���� NULL  & '�������ڰ� NULL & ������� ������̸�  =  ������ȭ ó���� ���� ����
				If LineStatus = "�����" Then
					'��� ����
					'���� ���� �̸� ����
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
						'���� ��� & �������� �̸����
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
						''@ VOS �� commond ���̺� ������Ʈ
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	RECORDFILE = '"& FormStudentNumber & SaveFile & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
						FormRecorded = "��������"
					Else
						'������� ����
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				Else
					'���� �����ڿ� ��ȭ���� �ƴϹǷ� ������ ������ �� �����ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('���� �����ڿ� ��ȭ ���� �ƴϹǷ� ������ ������ �� �����ϴ�. \ncode10');</SCRIPT>"
				End If
			End If
		End If

	'############################################################ RECORDEND ############################################################
	Case "RECORDEND"

		'���� ������ �̾�� �Ѵ�
		'�����ڰ� ������ �̾�� �Ѵ�
		'���� �����ڿ� ������ �̾�� �Ѵ�

		'���� ������ 
		If StatusTemp1 = 3 Then
			'���� ������  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'���� ������  & '�������ڰ� ������ & '���� �������ڿ� ������
				If StudentNumberTemp = FormStudentNumber Then
					'��ɼ���
					If Err.Description = "" Then
						'�������� ���
						StrSql =		""
						StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
						StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID,Status,Tel)"
						StrSql = StrSql & vbCrLf & "	values"
						StrSql = StrSql & vbCrLf & "	('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "', 2, '"& FormDialedTel &"')"
'						'Response.Write StrSql & "<BR>"
'						'Response.End
						Dbcon.Execute(StrSql)

						''@ **************************************************************************************************
						''@ VOS �� commond ���̺� ������Ʈ
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
					Else
						'������� ����
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'���� ������  & '�������ڰ� ������ & '���� Ÿ�����ڿ� ������
				Else
					'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ������  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ������  & '�������ڰ� NULL
			Else
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� ��ȭ�� 
		ElseIf StatusTemp1 = 2 Then
			'���� ��ȭ��  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ��ȭ��  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ��
				If StudentNumberTemp = FormStudentNumber Then
					'����� �������ڿ� ��ȭ�� ������ ���������� �ʽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� ���� �����ڿ� ��ȭ �� ������ ���� �� ���� �ʽ��ϴ�.. \n������ ������ �� �����ϴ�. \ncode5');</SCRIPT>"
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� Ÿ�����ڿ� ��ȭ��
				Else
					'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ��ȭ��  & '�������ڰ� NULL
			Else
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� NULL 
		Else
			'���� NULL  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ���� ���� �����ڿ��� ������ �� �����ϴ�. \ncode8');</SCRIPT>"
			'���� NULL  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�. \ncode9');</SCRIPT>"
			'���� NULL  & '�������ڰ� NULL
			Else
				'���� �����ڿ� ��ȭ���� �ƴϰ� �������� �ƴϹǷ� ������ ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('���� �����ڿ� ��ȭ���� �ƴϰ� �������� �ƴϹǷ� ������ ������ �� �����ϴ�. \ncode10');</SCRIPT>"
			End If
		End If

	'############################################################ END ############################################################
	Case "END"


		'���� ������ �Ǵ� ��ȭ�� �̾�� �Ѵ�
		'�����ڰ� ������ �Ǵ� ��ȭ�� �̾�� �Ѵ�
		'���� �����ڿ� ������ �Ǵ� ��ȭ�� �̾�� �Ѵ�
		
		'���� ������ 
		If StatusTemp1 = 3 Then
			'���� ������  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'���� ������  & '�������ڰ� ������ & '���� �������ڿ� ������
				If StudentNumberTemp = FormStudentNumber Then
					'End���, �ݱ���Է�, �������Null�Է�, ���±��Null�Է�
					If Err.Description = "" Then
						'�ݱ��ReccordFIleName�Է�, �������NULL�Է�, ���±��NULL�Է�
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
						
						'�������� ���� ����
						If Session("Grade")="������" Then
							'�������� ��� �ڵ��ݿ� ���ÿ� ����
							PluralAbandon = PluralAbandon 'Request.Form("PluralAbandon")
						Else
							'������ ��� ȯ�漳�� -> �������� �ڵ����� ������ ����
							'If AutoAbandon = 1 Then
							If AutoAbandon = "1" Then
								PluralAbandon = 3
							Else
								PluralAbandon = 0
							End if
						End if
						
						'�������� ó��
						'If PluralFormResult = "3" Then
						PluralFormResult = "3"

						'��Ͽ��� �Է����̰�, �������� �����ȣ�� �����ϰ�, �ڵ��ݿ��� 3 �� ��� �������� ��ü �������� �ۼ�
						If FormResult = 6 And PluralStudentNumber <> "" And PluralAbandon = "3" Then
							Dim RsDup, StrSqlDup
							Set RsDup = Server.CreateObject("ADODB.Recordset")
							'�̹� ��Ͽ���, ��ϿϷ� ����� �ִ� �����ڸ� �ڵ����� ��Ų��!!!!! �ֳĸ�, ����� ������ ȣ���������� ������ �϶� ȣ���� �ڵ����� ��Ű�� ���߿� ����� �� ������ �ʾƼ� �����ǻ縦 ���� �� ����.
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
								'�������� �����Է�
								StrSql = StrSql & vbCrLf & "	insert into RegistRecord"
								StrSql = StrSql & vbCrLf & "	(StudentNumber, SubjectCode, Degree, Tel, UsedLine, MemberID, SaveFile, Result, Receiver, Memo, PluralStudentNumber)"
								If FormReceiver>1 Then
									StrSql = StrSql & vbCrLf & "	values ('" & PluralStudentNumber & "', '" & PluralSubjectCode & "', '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & PluralFormResult & "', '" & FormReceiver & "', '[�ڵ�����] " & SubjectTemp & DivisionTemp & " ��� " & FormMemo & "', '" & FormStudentNumber & "')"
								Else
									StrSql = StrSql & vbCrLf & "	values ('" & PluralStudentNumber & "', '" & PluralSubjectCode & "', '" & Session("FormDegree") & "', '" & FormDialedTel & "', '" & Session("FormUsedLine") & "', '" & Session("MemberID") & "', @SaveFile, '" & PluralFormResult & "',  NULL                 , '[�ڵ�����] " & SubjectTemp & DivisionTemp & " ��� " & FormMemo & "', '" & FormStudentNumber & "')"
								End If
								StrSql = StrSql & vbCrLf & "	Update StudentTable"
								StrSql = StrSql & vbCrLf & "	set ETC3='[�ڵ�����]'"
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
						''@ VOS �� commond ���̺� ������Ʈ
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
						FormRecorded = ""
						'#########################################
						'##���ڹ߼�
						'#########################################
						If Session("FormDivision0")<>"����" Then
							SMSSEnd
						End If
					Else
						'������� ����
						Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('������ ��������� �����߽��ϴ�. ���� ���¸� �����ϼ���.\n" & Err.Description & "');</SCRIPT>"
						Err.Clear 
					End If
				'���� ������  & '�������ڰ� ������ & '���� Ÿ�����ڿ� ������
				Else
					'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ������  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ������  & '�������ڰ� NULL
			Else
				'����� �̹� �������� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ���� ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� ��ȭ�� 
		ElseIf StatusTemp1 = 2 Then
			'���� ��ȭ��  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			'���� ��ȭ��  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ��
				If StudentNumberTemp = FormStudentNumber Then
					'END���, �ݱ���Է�, �������Null�Է�, ���±��Null�Է�
					If Err.Description = "" Then
						'�ݱ��ReccordFIleName�Է�, �������NULL�Է�, ���±��NULL�Է�
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
						''@ VOS �� commond ���̺� ������Ʈ
						'eStrSql = "	update LINEORDE"
						eStrSql = "	update DBASE...LINEORDE"
						eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
						eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
						eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
						eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

						eDbcon.Execute(eStrSql)
						''@ **************************************************************************************************
						'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
						FormRecorded = ""
						'#########################################
						'##���ڹ߼�
						'#########################################
						If Session("FormDivision0")<>"����" Then
							SMSSEnd
						End If
					End If
				'���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� Ÿ�����ڿ� ��ȭ��
				Else
					'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
					Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
					Session("FormSubjectCode") = SubjectCodeTemp
					CrossTaskError = true
				End If
			'���� ��ȭ��  & '�������ڰ� NULL
			Else
				'����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('����� �̹� ��ȭ ���� �����ڰ� �ֽ��ϴ�. \n" & SubjectTemp & DivisionTemp & " " & StudentNumberTemp & " " & StudentNameTemp & " �Դϴ�.\n�� ������ ���Է� �̵��ϰڽ��ϴ�.\ncode3');</SCRIPT>"
				Session("FormSubjectCode") = SubjectCodeTemp
				CrossTaskError = true
			End If
		'���� NULL 
		Else
			'���� NULL  & '�������ڰ� ������
			If StatusTemp2 = 3 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ���� ���� �����ڿ��� ������ �� �����ϴ�. \ncode7');</SCRIPT>"
			'���� NULL  & '�������ڰ� ��ȭ��
			ElseIf StatusTemp2 = 2 Then
				'�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�.
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('�ٸ� ������ ��ȭ ���� �����ڿ��� ������ �� �����ϴ�. \ncode8');</SCRIPT>"
			'���� NULL  & '�������ڰ� NULL
			Else
				'���� �����ڿ� ��ȭ���� �ƴϰ� �������� �ƴϹǷ� ������ ������ �� �����ϴ�.
				'�ٸ� ���� �������� RegistRecord�� ���� �������� �׸� �߰��� �� �ִ� �̶��� �������, �������ϸ��� �����ȴ�
				'If FormResult<>"" and FormDialedTel	= "" Then
					'�ݱ��ReccordFIleName�Է�, �������NULL�Է�, ���±��NULL�Է�
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
					'����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
					FormRecorded = ""
				'Else
				'	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('���� �����ڿ� ��ȭ���� �ƴϰ� �������� �ƴϹǷ� ������ ������ �� �����ϴ�. \ncode9');</SCRIPT>"
				'End If

			End If
		End If

	'############################################################ Reload ############################################################
	Case "Reload"
		
		'���� ������  & '�������ڰ� ������ & '���� �������ڿ� ������ 
		'If ( StatusTemp1 = 3 and StatusTemp2 = 3 and StudentNumberTemp = FormStudentNumber ) or ( StatusTemp1 = 2 and StatusTemp2 = 2 and StudentNumberTemp = FormStudentNumber ) Then
		'������ ��ȭ ������ �׷��߸� ��Ÿ ���� �߻��ÿ� ��Ұ� �����ϴ�
        If Err.Description = "" Then
            '�������NULL�Է�, ���±��NULL�Է�
            StrSql =		""
            StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
            StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
            StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"
            StrSql = StrSql & vbCrLf & ""
'			'Response.Write StrSql & "<BR>"
'			'Response.End
            Dbcon.Execute(StrSql)

            ''@ **************************************************************************************************
            ''@ VOS �� commond ���̺� ������Ʈ
            'eStrSql = "	update LINEORDE"
			eStrSql = "	update DBASE...LINEORDE"
            eStrSql = eStrSql & vbCrLf & "	set LINEORDER = 'END'"
            eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
            eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
            eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

            eDbcon.Execute(eStrSql)
            ''@ **************************************************************************************************
            '����������ư�� ���� �Ŀ��� �������� �������� ���θ� ����� �ӽ���ġ
            FormRecorded = ""
        End If


	'############################################################ Cancel ############################################################
	Case "Cancel"
		
		'���� ������  & '�������ڰ� ������ & '���� �������ڿ� ������ 
		'�Ǵ� ���� ��ȭ��  & '�������ڰ� ��ȭ�� & '���� �������ڿ� ��ȭ�� 
		If ( StatusTemp1 = 3 and StatusTemp2 = 3 and StudentNumberTemp = FormStudentNumber ) or ( StatusTemp1 = 2 and StatusTemp2 = 2 and StudentNumberTemp = FormStudentNumber ) Then
                        
            If Err.Description = "" Then
                '�ݱ��ReccordFIleName�Է�, �������NULL�Է�, ���±��NULL�Է�
                StrSql =		""
                StrSql = StrSql & vbCrLf & "	insert into StatusRecord"
                StrSql = StrSql & vbCrLf & "	(StudentNumber,SubjectCode,MemberID)"
                StrSql = StrSql & vbCrLf & "	values ('" & FormStudentNumber & "','" & Session("FormSubjectCode") & "','" & Session("MemberID") & "')"
                StrSql = StrSql & vbCrLf & ""
    '			'Response.Write StrSql & "<BR>"
    '			'Response.End
                Dbcon.Execute(StrSql)

                ''@ **************************************************************************************************
                ''@ VOS �� commond ���̺� ������Ʈ
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
	'������ȭ ���� �Ǵ� Ÿ �뵵 ��ȭ ����


        ''@ **************************************************************************************************
        ''@ VOS �� commond ���̺� ������Ʈ
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
	'��ȭ�ޱ� �Ǵ� Ÿ �뵵 ��ȭ ����

        ''@ **************************************************************************************************
        ''@ VOS �� commond ���̺� ������Ʈ
        'eStrSql =		"	update LINEORDE"
		eStrSql = "	update DBASE...LINEORDE"
        eStrSql = eStrSql & vbCrLf & "	set LINEORDER = '" & FormCommand & "'"
        eStrSql = eStrSql & vbCrLf & "	,	ORDERCONFI = '1'"
        eStrSql = eStrSql & vbCrLf & "	,	INSERTTIME = '"& FunctionNowDate() &"'"
        eStrSql = eStrSql & vbCrLf & "	where LineNumber = '" & Session("FormUsedLine") & "'"

        eDbcon.Execute(eStrSql)
        ''@ **************************************************************************************************
End Select

'������� ���ж��
If Err.Description <> "" Then
	Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('��� ó���� �����߽��ϴ�.\n" & Replace(Err.Description, "'", chr(34)) & "');</SCRIPT>"
	Err.Clear 
End If
'Response.End

'���� �ʰ����� �˻�
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
	<!-- <INPUT TYPE="BUTTON" value="�������� �̵�" onclick="document.location.href='Root.asp'">  -->
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
	<%Else%><!-- �⺻ ��ȭ ���� -->
		<FORM METHOD=POST ACTION="<%=Request.ServerVariables("HTTP_REFERER")%>" name="CommandForm">
			<%If RemainCheck = "END" Then ' ���� �ʰ����� �˻�%>
				<input type="Hidden" name="FormRemainCheck" value="���� �а��� ����� �Ϸ�Ǿ����ϴ�.\n�߰� �۾��� ������ �����ϼ���">
			<%End If%>
			<%'��ȭ���� ����Է� �� ����Ʈ�� ��� ����
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
'##���ڹ߼�
'#########################################
Sub SMSSEnd
dim StrSql, FormCommand, FormSMSDestination
	If Session("SMSConfirm")="1" and Session("SMSAutoConfirm")="1" and (FormResult = 6 or FormResult = 3) Then '��Ͽ���,����� ������ ��� �߼�

		If left(FormDialedTel , 3) = "010" or left(FormDialedTel , 3) = "011" or left(FormDialedTel , 3) = "016" or left(FormDialedTel , 3) = "017" or left(FormDialedTel , 3) = "018" or left(FormDialedTel , 3) = "019" Then '���� �� ��ȭ�� �ڵ����̸�
			SMSBody = "[" & Session("UniversityName") & "]"
			If FormResult = 3 Then
				SMSBody = SMSBody & StudentNameTemp & "�� " & SubjectTemp & " " & Division0Temp & " ���� �Դϴ�. "
			ElseIf FormResult = 6 Then
				SMSBody = SMSBody & StudentNameTemp & "�� "
				If Session("SMSBodyRegistrationFee")="1" Then
					SMSBody = SMSBody & "��ϱ�" & RegistrationFeeTemp & "�� "
				End If
				If Session("SMSBodyAccountNumber")="1" Then
					SMSBody = SMSBody & AccountNumberTemp & " "
				End If
				If Session("SMSBodyRegistrationTime")="1" Then
					If RegistrationFeeTemp >= 400000 then
						SMSBody = SMSBody & "��� �Ⱓ�� " & Session("RegistrationTime") & "����"
					Else
						SMSBody = SMSBody & "��ġ��� �Ⱓ�� " & Session("RegistrationTime") & "����"
					End If
				End If
				If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
					SMSBody = SMSBody & "���� ������ " & SubjectTemp & " ��� �Դϴ�."
				End If
			End If
			FormSMSDestination = DestinationFiltering(FormDialedTel)
		Else	'���� �� ��ȭ�� �ڵ����̸�
			for i = 1 to 5
				If left(Tel(i) , 3) = "010" or left(Tel(i) , 3) = "011" or left(Tel(i) , 3) = "016" or left(Tel(i) , 3) = "017" or left(Tel(i) , 3) = "018" or left(Tel(i) , 3) = "019" Then
					SMSBody = "[" & Session("UniversityName") & "]"
					If FormResult = 3 Then
						SMSBody = SMSBody & StudentNameTemp & "�� " & SubjectTemp & " " & Division0Temp & " ���� �Դϴ�."
					ElseIf FormResult = 6 Then
						SMSBody = SMSBody & StudentNameTemp & "�� "
						If Session("SMSBodyRegistrationFee")="1" Then
							SMSBody = SMSBody & "��ϱ�" & RegistrationFeeTemp & "�� "
						End If
						If Session("SMSBodyAccountNumber")="1" Then
							SMSBody = SMSBody & AccountNumberTemp & " "
						End If
						If Session("SMSBodyRegistrationTime")="1" Then
							If RegistrationFeeTemp >= 400000 then
								SMSBody = SMSBody & "��� �Ⱓ�� " & Session("RegistrationTime") & "����"
							Else
								SMSBody = SMSBody & "��ġ��� �Ⱓ�� " & Session("RegistrationTime") & "����"
							End If
						End If
						If Session("SMSBodyRegistrationFee")="0" and Session("SMSBodyAccountNumber")="0" and Session("SMSBodyRegistrationTime")="0" Then
							SMSBody = SMSBody & "���� ������ " & SubjectTemp & " ��� �Դϴ�."
						End If
					End If
					FormSMSDestination = DestinationFiltering(Tel(i))
					exit for
				End If
			next
		End If	'���� �� ��ȭ�� �ڵ����̸�

		'If StrSql<>"" Then	'�߼� �����ϸ� �߼� ����
			'Response.Write StrSql
			'Response.End '��ȭ�� ���� ���� �ԷµǴ� ���� ����ؾ� �Ѵ�
			'Set DbconSMS = Server.CreateObject("ADODB.Connection") 
			'DbconSMS.Open "provider=SqlOLEDB.1;Password=ky6140;Persist Security Info=True;User ID=MetisSmsSender; Initial Catalog=SMS3;Data source=mobilekiss.metissoft.com;Connect Timeout=5;"
			'DbconSMS.Execute StrSql
			'DbconSMS.Close
			'set DbconSMS = Nothing
			'������� ���ж��

			FormSendURL = "http://s.metissoft.com/sms/MetisSmsSend.asp?tran_id=MetisSmsSender&tran_pwd=freyja00&tran_msg=" & SMSBody & "&tran_callback=" & Session("CallBack") & "&tran_phone=" & FormSMSDestination

			If Err.Description <> "" Then
				Response.Write "<SCRIPT LANGUAGE='JavaScript'>alert('SMS �߼��� �����߽��ϴ�.\n" & Err.Description & "');</SCRIPT>"
				Err.Clear 
			End If
		'End If

	End If	'���,����� ������ ��� �߼�
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