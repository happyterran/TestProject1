<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%'���2
'Session.CodePage = "949"'ansi
'Response.Charset = "euc-kr"
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"
%>
<%
Dim Timer1
Timer1=Timer()
	'#################################################################################
	'##�а� ���� ������ Ȱ���� SubStrSql
	'#################################################################################
	Dim SelectCount : SelectCount = Session("FormSelectCount")
	Dim Rs1, StrSql, SubStrSql
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
Dim FormStudentNumber : FormStudentNumber = Request.Querystring("FormStudentNumber")
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
StrSql = StrSql & vbCrLf & "left outer join "
StrSql = StrSql & vbCrLf & "("
StrSql = StrSql & vbCrLf & "    select SubjectCode, Count(*) as StudentCount from StudentTable group by SubjectCode"
StrSql = StrSql & vbCrLf & ") SC"
StrSql = StrSql & vbCrLf & "on SC.SubjectCode = A.SubjectCode"

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
'StrSql = StrSql & vbCrLf & "order by A.SubjectCode, B.StatsResult" 
'StrSql = StrSql & vbCrLf & "order by A.SubjectCode, B.StatsResult" 

'��������, ����2, �����ñ�, ����1
'StrSql = StrSql & vbCrLf & "order by substring(A.SubjectCode,4,2), substring(A.SubjectCode,7,2), substring(A.SubjectCode,1,2), right(A.SubjectCode,1)" 
'StrSql = StrSql & vbCrLf & "order by A.Subject" 
'StrSql = StrSql & vbCrLf & "order by Subject, Division2, Division0, Division1"
'StrSql = StrSql & vbCrLf & "order by Subject, Division2 desc, Division0, Division1"
StrSql = StrSql & vbCrLf & "order by Subject, A.SubjectCode"
'PrintSql StrSql
'Response.End
Rs1.CursorLocation = 3
Rs1.CursorType = 3
Rs1.LockType = 3
Rs1.Open StrSql, Dbcon


Dim FileName
If Session("FormStatsDegree") <>"" Then
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&Session("FormStatsMemberID")&Session("FormStatsResultType")&"��"&Session("FormStatsDegree")&"�����"
Else
	FileName=Session("FormStatsDivision0")&Session("FormStatsSubject")&Session("FormStatsDivision1")&Session("FormStatsDivision2")&Session("FormStatsDivision3")&Session("FormStatsMemberID")&Session("FormStatsResultType")
End If

If FileName="" Then
	FileName="��ü���"
Else
	FileName=FileName&" ��ü���"
End If

FileName=Server.UrlEncode(FileName)
'Response.Write FileName
'Response.end

'FileName=UrlDecode("asd+f123%EA%B0%80%EB%82%98%EB%8B%A4")
'Response.Write FileName
'Response.End

'FileName=UrlDecode(server.UrlEncode(FileName))
'Response.Write FileName
'Response.end



If Rs1.RecordCount>0 Then

    Response.ContentType = "application/vnd.ms-excel"
    Response.AddHeader "content-disposition", " filename=" & FileName &".xls"
    %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
	<META http-equiv="Content-Type" content="text/html;charset=utf-8">
  <TITLE> METIS </TITLE>
	<style>
		td{font-size:8pt; text-align:center;}
		.fs15{font-size:15pt;}
		.lb{border-left-width:2px;}
		.rb{border-right-width:2px;}
		.bb{border-bottom-width:2px;}
		.tb{border-top-width:2px;}
		.lbb{border-left-width:2px; border-bottom-width:2px;}
		.rbb{border-right-width:2px; border-bottom-width:2px;}
		.rtb{border-right-width:2px; border-top-width:2px;}
		.ltb{border-left-width:2px; border-top-width:2px;}
		.DisWordSP{letter-spacing:-1pt;}
	</style>
 </HEAD>

<table border="1" cellspacing="0" cellpadding="0" style="border: 1px solid #000000;">
    <tr>
        <td style="border-bottom: 1px solid #000000;">�ڵ�</td>
        <td style="border-bottom: 1px solid #000000;">�����ñ�</td>
		<td style="border-bottom: 1px solid #000000;">�а���</td>
        <td style="border-bottom: 1px solid #000000;">����1</td>
        <td style="border-bottom: 1px solid #000000;">����2</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">����3</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">������</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">����</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">����</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">����</td>
        <td style="border-bottom: 1px solid #000000;">��Ͽ���</td>
        <td style="border-bottom: 1px solid #000000;">�̰���</td>
        <td style="border-bottom: 1px solid #000000;">�̿���</td>
        <td style="border-bottom: 1px solid #000000;">���۾�</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">��ϿϷ�</td>
        <td style="border-bottom: 1px solid #000000; border-right: 1px solid #000000;">�ڿ�</td>
        <td style="border-bottom: 1px solid #000000;">����</td>
        <td style="border-bottom: 1px solid #000000;">�̵��</td>
        <td style="border-bottom: 1px solid #000000;">ȯ��</td>
    </tr>
	<%
	Dim SubjectCode, Subject, Division0, Division1, Division2, Division3, Quorum
	Dim RegistCount ,AbandonCount ,UndecidedCount ,NonConnectedCount ,WrongNumberCount ,NonRegistCount ,RefundCount, StudentCount, RegistPlanCount, RemainCount, ResourceCount
	Dim BGColor
    Dim QuorumFixTotalSum, QuorumTotalSum, RegistCountSum, AbandonCountSum, UndecidedCountSum, NonConnectedCountSum, WrongNumberCountSum, NonRegistCountSum, RefundCountSum, StudentCountTotalSum, RegistPlanCountSum, RemainCountSum, ResourceCountSum
    RemainCountSum = 0
    ResourceCountSum = 0
    BGColor="#f0f0f0"
    Dim QuorumFix, QuorumDIffrence, QuorumDIffrenceTemp
    Dim QuorumSum, QuorumFixSum, QuorumDIffrenceSum, ODR, SubjectBefore, ShowSum, ShowError, FontColor, QuorumDIffrenceSumColor, QuorumDIffrenceSumTemp, StudentCountSum
	Dim RegistPlanCountSmallSum, UndecidedCountSmallSum, NonConnectedCountSmallSum, RemainCountSmallSum, RegistCountSmallSum,         ResourceCountSmallSum,         AbandonCountSmallSum, NonRegistCountSmallSum, RefundCountSmallSum
	'���� �ʱ�ȭ   ����ȯ 150213
	RemainCountSmallSum = 0
    ShowSum = FALSE
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
        '    ShowSum = true
        'End If

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
		'If ShowSum Then
		If ShowSum And SelectCount="" Then
		%>
			<TR>
				<TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">�Ұ�</TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-left: 1px solid #000000; border-right: 1px solid #000000;" ><%=StudentCountSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid #000000;" ><%=QuorumFixSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid #000000;" ><%=QuorumSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-left: 1px solid #000000; "><%=RegistPlanCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=UndecidedCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=NonConnectedCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=RemainCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=RegistCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=ResourceCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=AbandonCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=NonRegistCountSmallSum%></TD>
				<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=RefundCountSmallSum%></TD>
			</TR>
			<tr>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ڵ�</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�����ñ�</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�а���</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����1</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����2</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����3</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: 1px solid #000000; border-right: 1px solid #000000;">������</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000;">����</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000;">����</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">����</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-left: 1px solid #000000;">��Ͽ���</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̰���</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">�̿���</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center;">���۾�</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000;">��ϿϷ�</td>
				<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000;">�ڿ�</td>
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
			AbandonCountSmallSum        = 0 '����
			NonRegistCountSmallSum      = 0 '�̵��
			RefundCountSmallSum         = 0 'ȯ��
			'�Ұ� ǥ�������� bgcolor='FFFFFF'
			BGColor="#fafafa"
        End If

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
        Else
            '(�ڿ��� 0���� �������)
            '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����)
            '���۾� = ������-(��Ͽ���+�̰���+�̿���+��ϿϷ�)-(����+�̵��+ȯ��)
            '���۾� = ������-��Ͽ���-�̰���-�̿���-��ϿϷ�-����-�̵��-ȯ��
            RemainCount= StudentCount - RegistPlanCount - UndecidedCount - NonConnectedCount - RegistCount - AbandonCount - NonRegistCount - RefundCount
        End If
        If BGColor = "#ffffff" Then 
            BGColor="#f0f0f0"
        ElseIf BGColor="#f0f0f0" Then
            BGColor="#ffffff"
        End If
        
		'�Ұ��ջ�
		RegistPlanCountSmallSum = RegistPlanCountSmallSum + RegistPlanCount                   '��Ͽ���
		UndecidedCountSmallSum = UndecidedCountSmallSum + UndecidedCount                      '�̰���
		NonConnectedCountSmallSum = NonConnectedCountSmallSum +NonConnectedCount              '�̿���
		If RemainCount > 0 Then RemainCountSmallSum = RemainCountSmallSum + RemainCount       '���۾�
		RegistCountSmallSum = RegistCountSmallSum + RegistCount                               '��ϿϷ�
		If ResourceCount > 0 Then ResourceCountSmallSum = ResourceCountSmallSum+ResourceCount '�ڿ�
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
        If RemainCount > 0 Then
            RemainCountSum = RemainCountSum + RemainCount
        End If
        If ResourceCount > 0 Then
            ResourceCountSum = ResourceCountSum + ResourceCount
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
        
		'�Ұ�� ��ü�а� ǥ���� ����
		'If ShowSum Then
		If ShowSum And SelectCount="" Then
		%>
            <TR>
                <TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">�Ұ�</TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-left: 1px solid; border-right: 1px solid;" ><%=StudentCountSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid;" ><%=QuorumFixSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid;" ><%=QuorumSum%></TD>
                <TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
                <TD colspan="5" style="background-color: #e7e7e7; border-left: 1px solid; border-right: 1px solid"></TD>
                <TD colspan="1" style="background-color: #e7e7e7; border-right: 1px solid"></TD>
                <TD colspan="3" style="background-color: #e7e7e7;"></TD>
            </TR>
            <%'ǥ�� ������ QuorumDiffrenceSum �� 0 �� �´��� �˻� 
            If QuorumDIffrenceSum <> 0 Then ShowError = true
            '�׸���, 0 ���� ����
            StudentCountSum = 0
            QuorumSum = 0
            QuorumFixSum = 0
            QuorumDIffrenceSum = 0
            ShowSum=false
            '�Ұ� ǥ�������� bgcolor='FFFFFF'
            BGColor="#ffffff"
        End If
        'Sum ����
        StudentCountSum = StudentCountSum + StudentCount
        QuorumSum = QuorumSum + Quorum
        QuorumFixSum = QuorumFixSum + QuorumFix
        QuorumDIffrenceSum = QuorumDIffrenceSum + QuorumDIffrence

		'��üǥ�� �Ǵ� ���۾� �а��� ǥ��
		If SelectCount="" Or ( SelectCount="���۾�" And ( UndecidedCount>0 Or NonConnectedCount>0 Or RemainCount>0 ) ) Then
		%>

		<TR <%=BGColor%>>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=SubjectCode%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Division0%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Subject%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@; text-align: left; padding-left: 20px"><%=Division1%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\@"><%=Division2%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; border-right: 1px solid #000000;"><%=Division3%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=StudentCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=QuorumFix%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=Quorum%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; color: <%=FontColor%>;"><%=QuorumDIffrenceTemp%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RegistPlanCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=UndecidedCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonConnectedCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RemainCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=RegistCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=ResourceCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=AbandonCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=NonRegistCount%></TD>
			<TD nowrap style="background-color: <%=BGColor%>; mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><%=RefundCount%></TD>
		</TR>
		<%
		End if
		Rs1.MoveNext
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
	If SelectCount="" then%>
		<TR>
			<TD colspan="6" style="background-color: #e7e7e7; text-align: left; padding-left: 165px;">�Ұ�</TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-left: 1px solid #000000; border-right: 1px solid #000000;" ><%=StudentCountSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid #000000;" ><%=QuorumFixSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; border-right: 1px solid #000000;" ><%=QuorumSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; font-weight:bold; color: <%=QuorumDiffrenceSumColor%>"><%=QuorumDiffrenceSumTemp%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-left: 1px solid #000000; "><%=RegistPlanCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=UndecidedCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=NonConnectedCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=RemainCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=RegistCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><%=ResourceCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=AbandonCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=NonRegistCountSmallSum%></TD>
			<TD colspan="1" style="background-color: #e7e7e7; text-align: right; padding-right: 20px; "><%=RefundCountSmallSum%></TD>
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
        End If%>
        <TR>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�����ڵ�</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�а���</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�����ñ�</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">����1</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">����2</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">����3</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000;">������</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;border-right: 1px solid #000000;">����</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;border-right: 1px solid #000000;">����</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">����</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000; border-left: 1px solid #000000;">��Ͽ���</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�̰���</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�̿���</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">���۾�</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000; border-top: 1px solid #000000;">��ϿϷ�</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-right: 1px solid #000000; border-top: 1px solid #000000;">�ڿ�</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">����</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">�̵��</td>
			<td colspan="1" style="padding: 7px 0px 6px 0px; text-align: center; border-top: 1px solid #000000;">ȯ��</td>

		</tr>
		<TR>
            <TD nowrap style="border-right: 1px solid #000000" colspan="6"><B>����</B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><B><%=StudentCountTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><B><%=QuorumFixTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumTotalSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000; color: <%=QuorumDIffrenceSumColor%>; "><B><%=QuorumDIffrenceSumTemp%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><B><%=RegistPlanCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><B><%=UndecidedCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><B><%=NonConnectedCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; "><B><%=RemainCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><B><%=RegistCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px; border-right: 1px solid #000000;"><B><%=ResourceCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px;"><B><%=AbandonCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px;"><B><%=NonRegistCountSum%></B></TD>
            <TD nowrap style="mso-number-format:\#\,\#\#0; text-align: right; padding-right: 20px;"><B><%=RefundCountSum%></B></TD>
        </TR>
</TABLE>
<a name="End">
<%Else%>
	<SCRIPT LANGUAGE='JavaScript'> alert('���ǿ� �´� ����� �����ϴ�.'); document.location.href='StatsDropDownSelect.asp'</SCRIPT>
<%End If%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<%'=Timer()-Timer1%>
