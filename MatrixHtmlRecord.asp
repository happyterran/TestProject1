<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
	Response.Buffer = False

	'Response.AddHeader "Content-Disposition","inline;filename=" & filename
	Dim FileName, FilePath
	Dim ResultTempStr, ReceiverTempStr
	'���
	select case Session("FormResult")
		case 0
			ResultTempStr = "��ü"
		case 1
			ResultTempStr = "���۾�"
		case 2
			ResultTempStr = "��ϿϷ�"
		case 3
			ResultTempStr = "����"
		case 4
			ResultTempStr = "�̰���"
		case 5
			ResultTempStr = "�̿���"
		case 6
			ResultTempStr = "��Ͽ���"
		case 7
			ResultTempStr = "�̵��"
		case 10
			ResultTempStr = "ȯ��"
		case 11
			ResultTempStr = "��ȯ��"
	end select

	if Session("FormDegree") <>"" then
		FileName = Session("FormDivision0")&Session("FormDivision1")&Session("FormDivision2")&Session("FormSubject")&Session("FormDivision3")&ResultTempStr&Session("FormMemberID")&Session("FormResultType")&"��"&Session("FormDegree")&"�����"
	else
		FileName = Session("FormDivision0")&Session("FormDivision1")&Session("FormDivision2")&Session("FormSubject")&Session("FormDivision3")&ResultTempStr&Session("FormMemberID")&Session("FormResultType")
	end if
	
'	if FileName="" then
		FileName="������������.htm"
'	else
'		FileName=FileName&"������������.htm"
'	end if
	FilePath	= Server.MapPath ("/Download/")&"\"&FileName	
	'response.write FilePath
	response.buffer=true
	'response.contenttype="application/unknown" 
	'Response.AddHeader "Content-Disposition","attachment;filename=" & filename

	'#################################################################################
	'##�к� ���� ������ Ȱ���� �ٽ��׸� ����
	'#################################################################################
	Dim Rs1, Sql, SubSql
	SubSql = ""
	if Session("FormSubject") <> "" then
		SubSql =					"and Subject = '" & Session("FormSubject") & "'" & vbCrLf
	end if
	if Session("FormDivision0") <> "" then
		SubSql = SubSql & "and Division0 = '" & Session("FormDivision0") & "'" & vbCrLf
	end if
	if Session("FormDivision1") <> "" then
		SubSql = SubSql & "and Division1 = '" & Session("FormDivision1") & "'" & vbCrLf
	end if
	if Session("FormDivision2") <> "" then
		SubSql = SubSql & "and Division2 = '" & Session("FormDivision2") & "'" & vbCrLf
	end if
	if Session("FormDivision3") <> "" then
		SubSql = SubSql & "and Division3 = '" & Session("FormDivision3") & "'" & vbCrLf
	end if
	if Session("FormDegree") <> "" then
		SubSql = SubSql & "and Degree = '" & Session("FormDegree") & "'" & vbCrLf
	end if
	if Session("FormResult") <> 0 then
		if Session("FormResult") = 1 then
			SubSql = SubSql & "and Result is Null" & vbCrLf
		else
			SubSql = SubSql & "and Result = " & Session("FormResult") & "" & vbCrLf
		end if
	end if
	if Session("FormMemberID") <> "" then
		SubSql = SubSql & "and MemberID = '" & Session("FormMemberID") & "'" & vbCrLf
	end if
	'if Session("FormResultType") <> "" then
	'	SubSql = SubSql & "and Division3 = '" & Session("FormResultType") & "'" & vbCrLf
	'end if
	'���������� �����ϴ� �ݷ��ڵ常 ����
	SubSql = SubSql & "and SaveFile <> ''" & vbCrLf
	'response.write SubSql
	'response.end

	
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
'	if Session("FormResultType")="" then
'		Sql =				"select" & vbCrLf
'		Sql = Sql & "		C.StudentNumber, C.StudentName, C.Ranking" & vbCrLf
'		Sql = Sql & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3" & vbCrLf
'		Sql = Sql & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime" & vbCrLf
'		Sql = Sql & "		, isnull(B.CallCount,0) as CallCountIsNull" & vbCrLf
'		Sql = Sql & "		, isnull(A.Result,1) as ResultIsNull" & vbCrLf
'		Sql = Sql & "		, A.InsertTime" & vbCrLf
'		Sql = Sql & "from RegistRecord A" & vbCrLf
'		Sql = Sql & "inner join" & vbCrLf
'		Sql = Sql & "(" & vbCrLf
'		Sql = Sql & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount" & vbCrLf
'		Sql = Sql & "	from RegistRecord" & vbCrLf
'		Sql = Sql & "	group by StudentNumber" & vbCrLf
'		Sql = Sql & ") B" & vbCrLf
'		Sql = Sql & "on A.StudentNumber = B.StudentNumber" & vbCrLf
'		Sql = Sql & "and A.IDX = B.MaxIDX" & vbCrLf
'		Sql = Sql & "right outer join StudentTable C" & vbCrLf
'		Sql = Sql & "on A.StudentNumber = C.StudentNumber" & vbCrLf
'		Sql = Sql & "inner join SubjectTable D" & vbCrLf
'		Sql = Sql & "on C.SubjectCode = D.SubjectCode" & vbCrLf
'		Sql = Sql & "where 1=1" & vbCrLf
'		Sql = Sql & "	" & SubSql & vbCrLf
'		Sql = Sql & "order by convert( int , C.StudentNumber )" & vbCrLf
'	else
		Sql =				"select" & vbCrLf
		Sql = Sql & "		C.StudentNumber, C.StudentName, C.Ranking" & vbCrLf
		Sql = Sql & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3" & vbCrLf
		Sql = Sql & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime" & vbCrLf
		Sql = Sql & "		, isnull(B.CallCount,0) as CallCountIsNull" & vbCrLf
		Sql = Sql & "		, isnull(A.Result,1) as ResultIsNull" & vbCrLf
		Sql = Sql & "from RegistRecord A" & vbCrLf
		Sql = Sql & "left outer join" & vbCrLf
		Sql = Sql & "(" & vbCrLf
		Sql = Sql & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount" & vbCrLf
		Sql = Sql & "	from RegistRecord" & vbCrLf
		Sql = Sql & "	group by StudentNumber" & vbCrLf
		Sql = Sql & ") B" & vbCrLf
		Sql = Sql & "on A.StudentNumber = B.StudentNumber" & vbCrLf
		'Sql = Sql & "and A.IDX = B.MaxIDX" & vbCrLf
		Sql = Sql & "right outer join StudentTable C" & vbCrLf
		Sql = Sql & "on A.StudentNumber = C.StudentNumber" & vbCrLf
		Sql = Sql & "inner join SubjectTable D" & vbCrLf
		Sql = Sql & "on C.SubjectCode = D.SubjectCode" & vbCrLf
		Sql = Sql & "where 1=1" & vbCrLf
		Sql = Sql & "	" & SubSql & vbCrLf

		'Sql = Sql & "	and D.Division0 not in ('����1��','����2��')"& vbCrLf


		Sql = Sql & "order by C.SubjectCode, C.Ranking" & vbCrLf 'Ž���� ���� ������ �����ϱ� ���� int�� convert
'	end if
	
	'Response.Write Sql
	'Response.end
	Rs1.Open Sql, Dbcon, 1, 1

	Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime, i
	Dim	DefaultPath , Body
	if Rs1.RecordCount>0 then
		DefaultPath = Server.MapPath ("/Download/") & "\"
		'response.write DefaultPath
		Dim FSO, F1, Ts, S
		Const ForReading = 1
		'FSO�� �����մϴ�.
		Set FSO = CreateObject("Scripting.FileSystemObject")
		' ������ ����ϴ�.
		'Response.Write "������ ���� �ֽ��ϴ� <br>"
		Set F1 = FSO.CreateTextFile( FilePath, True)

		F1.WriteLine "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>"
		F1.WriteLine "<html xmlns='http://www.w3.org/1999/xhtml'><HEAD><meta http-equiv='Content-type' content='text/html; charset=euc-kr'><style>body,td,select,input,div,form,textarea,center,option,pre,blockquote {font-size:12px;font-family:dotum, ����, Tahoma, Verdana ; color:333333; LINE-HEIGHT: 1.5; LETTER-SPACING: -1px; WORD-SPACING: 0px}</style></HEAD>"
		F1.WriteLine "<BODY topmargin='0' leftmargin='0'>"
		F1.WriteLine "<TABLE cellpadding=1 cellspacing=0 width='1900' style='table-layout:fixed; border-collapse:collapse;' border='1'>"
		F1.WriteLine "<col width='90'></col><col width='90'></col><col width='50'></col><col width='90'></col><col width='100'></col><col width='150'></col><col width='100'></col><col width='150'></col><col width='40'></col><col width='50'></col><col width='90'></col><col width='90'></col><col width='90'></col><col width='90'></col><col width='60'></col><col width='110'></col><col width=''></col><col width='150'></col>"
		F1.WriteLine "<TR><TD>�����ȣ</TD><TD>�̸�</TD><TD>����</TD><TD>�к��ڵ�</TD><TD>����0</TD><TD>����1</TD><TD>����2</TD><TD>�к�</TD><TD>����3</TD><TD>����</TD><TD>��ȭ��ȣ</TD><TD>����</TD><TD>������</TD><TD>���</TD><TD>��ȭȽ��</TD><TD>��������</TD><TD>�޸�</TD><TD>�۾��ð�</TD></TR>"
		do until Rs1.EOF
			StudentNumber= GetParameter( Rs1("StudentNumber") , "&nbsp;" )
			StudentName= GetParameter( Rs1("StudentName") , "&nbsp;" )
			Ranking= GetParameter( Rs1("Ranking") , "&nbsp;" )
			SubjectCode= GetParameter( Rs1("SubjectCode") , "&nbsp;" )
			Subject= GetParameter( Rs1("Subject") , "&nbsp;" )
			Division0= GetParameter( Rs1("Division0") , "&nbsp;" )
			Division1= GetParameter( Rs1("Division1") , "&nbsp;" )
			Division2= GetParameter( Rs1("Division2") , "&nbsp;" )
			Division3= GetParameter( Rs1("Division3") , "&nbsp;" )
			Degree= GetParameter( Rs1("Degree") , "&nbsp;" )
			Tel= GetParameter( Rs1("Tel") , "&nbsp;" )
			MemberID= GetParameter( Rs1("MemberID") , "&nbsp;" )
			Receiver= GetParameter( Rs1("Receiver") , "&nbsp;" )
			Result= GetParameter( Rs1("ResultIsNull") , "&nbsp;" )
			CallCount= GetParameter( Rs1("CallCountIsNull") , "&nbsp;" )
			SaveFile= GetParameter( Rs1("SaveFile") , "&nbsp;" )
			if SaveFile <>"&nbsp;" then SaveFile=StudentNumber&SaveFile&".wav"
			Memo= GetParameter( Rs1("Memo") , "&nbsp;" )
			InsertTime= GetParameter( Rs1("InsertTime") , "&nbsp;" )
			i = i + 1
			'���
			select case Result
				case 1
					ResultTempStr = "���۾�"
				case 2
					ResultTempStr = "��ϿϷ�"
				case 3
					ResultTempStr = "����"
				case 4
					ResultTempStr = "�̰���"
				case 5
					ResultTempStr = "�̿���"
				case 6
					ResultTempStr = "��Ͽ���"
				case 7
					ResultTempStr = "�̵��"
				case 10
					ResultTempStr = "ȯ��"
				case 11
					ResultTempStr = "��ȯ��"
				'�⺻���� ���۾� �̹Ƿ� else�� �ʿ����
				'case else
				'	ResultTempStr = ""
			end select
			'�������
			select case Receiver
				case "1"
					ReceiverTempStr = "����"
				case "2"
					ReceiverTempStr = "������"
				case "3"
					ReceiverTempStr = "�θ�"
				case "4"
					ReceiverTempStr = "����"
				case "5"
					ReceiverTempStr = "��Ÿ"
				case else
					ReceiverTempStr = "&nbsp;"
			end select
			'F1.WriteLine "11110036,000111XX,�ڽ���,������а�,����,0222262356,01190863693,,2"
			'F1.WriteLine Chr(34) & StudentNumber & Chr(34) & "," & Chr(34) & StudentName & Chr(34) & "," & Chr(34) & SubjectCode & Chr(34) & "," & Chr(34) & Subject & Chr(34) & "," & Chr(34) & Division0 & Chr(34) & "," & Chr(34) & Division1 & Chr(34) & "," & Chr(34) & Division2 & Chr(34) & "," & Chr(34) & Division3 & Chr(34) & "," & Chr(34) & Degree & Chr(34) & "," & Chr(34) & Tel & Chr(34) & "," & Chr(34) & MemberID & Chr(34) & "," & Chr(34) & ReceiverTempStr & Chr(34) & "," & Chr(34) & ResultTempStr & Chr(34) & "," & Chr(34) & CallCount & Chr(34) & "," & Chr(34) & SaveFile & Chr(34) & "," & Chr(34) & Memo & Chr(34) & "," & Chr(34) & InsertTime & Chr(34)
			Body = "<TR><TD>" & StudentNumber & "</TD><TD>" & StudentName & "</TD><TD>" & Ranking & "</TD><TD>" & SubjectCode & "</TD><TD>" & Division0 & "</TD><TD>" & Division1 & "</TD><TD>" & Division2 & "</TD><TD>" & Subject & "</TD><TD>" & Division3 & "</TD><TD>" & Degree & "</TD><TD>" & Tel & "</TD><TD>" & MemberID & "</TD><TD>" & ReceiverTempStr & "</TD><TD>" & ResultTempStr & "</TD><TD>" & CallCount & "</TD>"
			if SaveFile="&nbsp;" then
				Body = Body & "<TD>&nbsp;</TD>"
			else
				Body = Body & "<TD><A HREF='Record/" & SaveFile & "'>" & SaveFile & "</A></TD>"
			end if
			Body = Body & "<TD>" & Memo & "</TD><TD>" & InsertTime & "</TD></TR>"
			F1.WriteLine Body
			Rs1.MoveNext
		Loop
		F1.WriteLine "</TABLE>"
		F1.Close
		set F1 = Nothing
		set FSO = Nothing
		Rs1.close
		Set Rs1 = Nothing
	end if
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->


<%
if i>0 then
	Dim user_agent
	Dim content_disp
	Dim contenttype
	Dim objFS, objF, objDownload
	user_agent = Request.ServerVariables("HTTP_USER_AGENT")
	If InStr(user_agent, "MSIE") > 0 Then
			'IE 5.0�� ���.
			If InStr(user_agent, "MSIE 5.0") > 0 Then
					content_disp = "attachment;filename="
					contenttype = "application/x-msdownload"
			'IE 5.0�� �ƴ� ���.
			Else
					content_disp = "attachment;filename="
					contenttype = "application/unknown"
			End If
	Else
			'Netscape�� ��Ÿ �������� ���.
			content_disp = "attachment;filename="
			contenttype = "application/unknown"
	End If
	 
	Response.AddHeader "Content-Disposition", content_disp & filename
	set objFS = Server.CreateObject("Scripting.FileSystemObject")
	set objF = objFS.GetFile(filepath)
	Response.AddHeader "Content-Length", objF.Size
	set objF = nothing
	set objFS = nothing
	Response.ContentType = contenttype
	Response.CacheControl = "public"
	 
	Set objDownload = Server.CreateObject("DEXT.FileDownload")
	objDownload.Download filepath
	Set objDownload = Nothing
else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'> alert('���ǿ� �´� ����� �����ϴ�.'); document.location.href='StatisticsDropDownSelect.asp'</SCRIPT>"
end if
%>