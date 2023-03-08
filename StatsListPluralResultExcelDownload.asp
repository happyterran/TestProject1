<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Option Explicit%>

<%Response.Buffer = False
Session.CodePage = "65001"'utf-8
Response.Charset = "utf-8"%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'Response.Buffer = False

'Response.AddHeader "Content-Disposition","inline;filename=" & filename

Dim FormDivision3, FormDivision2, FormDivision1, FormDivision0, FormSubject, FormResult, FormMemberID, FormResultType, FormDegree

FormDivision3 = Session("FormStatsDivision3")
FormDivision2 = Session("FormStatsDivision2")
FormDivision1 = Session("FormStatsDivision1")
FormDivision0 = Session("FormStatsDivision0")
FormSubject =   Session("FormStatsSubject")
FormResult =   Session("FormStatsResult")
FormMemberID = Session("FormStatsMemberID")
FormResultType=Session("FormStatsResultType")
FormDegree =   Session("FormStatsDegree")

Dim FileName, FilePath
Dim ResultTempStr, ReceiverTempStr

'결과를 선택하지 않으면 자동포기된 복수지원자만 추출
If FormResult = "0" Then
	'FormResult = "3"
End If
'결과
select case FormResult
	case 0
		ResultTempStr = ""
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
	case 11
		ResultTempStr = "기환불"
End select

	If FormDegree <>"" Then
		FileName=FormDivision0&FormSubject&FormDivision1&FormDivision2&FormDivision3&ResultTempStr&FormMemberID&FormResultType&"제"&FormDegree&"차충원"
	Else
		FileName=FormDivision0&FormSubject&FormDivision1&FormDivision2&FormDivision3&ResultTempStr&FormMemberID&FormResultType
	End If
	
	If FileName="" Then
		FileName="자동포기된 복수지원자"
	Else
		FileName="자동포기된 복수지원자 "&FileName
	End If
'	FilePath	= Server.MapPath ("/Download/")&"\"&FileName	
'	'Response.write FilePath
'	Response.buffer=true
'	'Response.contenttype="application/unknown" 
'	'Response.AddHeader "Content-Disposition","attachment;filename=" & filename

	'#################################################################################
	'##학과 구분 조건을 활용한 핵심항목 추출
	'#################################################################################
	Dim Rs1, StrSql, SubStrSql
	SubStrSql = ""
	If FormSubject <> "" Then
		SubStrSql =					"and Subject = '" & FormSubject & "'"
	End If
	If FormDivision0 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division0 = '" & FormDivision0 & "'"
	End If
	If FormDivision1 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division1 = '" & FormDivision1 & "'"
	End If
	If FormDivision2 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division2 = '" & FormDivision2 & "'"
	End If
	If FormDivision3 <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & FormDivision3 & "'"
	End If
	If FormDegree <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and Degree = '" & FormDegree & "'"
	End If
	If FormResult <> 0 Then
		If FormResult = 1 Then
			SubStrSql = SubStrSql & vbCrLf & "and Result is Null"
		Else
			SubStrSql = SubStrSql & vbCrLf & "and Result = " & FormResult & ""
		End If
	End If
	If FormMemberID <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and MemberID = '" & FormMemberID & "'"
	End If
	
	If Session("InsertTime1") <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime >= '" & Session("InsertTime1") & " 00:00:00'"
	End If
	If Session("InsertTime2") <> "" Then
		SubStrSql = SubStrSql & vbCrLf & "and A.InsertTime <= '" & Session("InsertTime2") & " 23:59:59.999'"
	End If
	'If FormResultType <> "" Then
	'	SubStrSql = SubStrSql & vbCrLf & "and Division3 = '" & FormResultType & "'"
	'End If
	'Response.write SubStrSql
	'Response.End
	
	Dim OrderStrSql
	If Session("FormStatsOrderType") = "" Then
		'OrderStrSql = "order by ET.StudentName, ET.StudentNumber"
		OrderStrSql = "order by subject, Division0, Division1, ET.Ranking"
	Else
		OrderStrSql = "order by " & Session("FormStatsOrderType")
	End If

	
	Set Rs1 = Server.CreateObject("ADODB.Recordset")
	If FormResultType="" Then
		StrSql =          "select"
		StrSql = StrSql & vbCrLf & "		ET.StudentNumber, ET.StudentName, ET.Ranking, ET.Citizen1, ET.Citizen2"
		StrSql = StrSql & vbCrLf & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & "		, isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & "		, isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "inner join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
		If FormDegree <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & FormDegree & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable ET"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where etc3='[자동포기]'"
		StrSql = StrSql & vbCrLf & "	" & SubStrSql & vbCrLf
		StrSql = StrSql & vbCrLf & OrderStrSql
	Else
		StrSql =          "select"
		StrSql = StrSql & vbCrLf & "		ET.StudentNumber, ET.StudentName, ET.Ranking, ET.Citizen1, ET.Citizen2"
		StrSql = StrSql & vbCrLf & "		, D.SubjectCode, D.Subject, D.Division0, D.Division1, D.Division2, D.Division3"
		StrSql = StrSql & vbCrLf & "		, A.Degree, A.Tel, A.MemberID, A.Receiver, A.Result, A.SaveFile, A.Memo, A.InsertTime"
		StrSql = StrSql & vbCrLf & "		, isnull(B.CallCount,0) as CallCountIsNull"
		StrSql = StrSql & vbCrLf & "		, isnull(A.Result,1) as ResultIsNull"
		StrSql = StrSql & vbCrLf & "from RegistRecord A"
		StrSql = StrSql & vbCrLf & "left outer join"
		StrSql = StrSql & vbCrLf & "("
		StrSql = StrSql & vbCrLf & "	select StudentNumber, max(IDX) as MaxIDX , count(*) as CallCount"
		StrSql = StrSql & vbCrLf & "	from RegistRecord"

		'세부내역은 항상 Group By 를 이용해 최종 결과만 조회하지만 일단 차수가 지정되면 해당 차수에서 입력된 결과만을 조회해야한다
		If FormDegree <> "" Then
		StrSql = StrSql & vbCrLf & "where Degree = '" & FormDegree & "'"
		End If

		StrSql = StrSql & vbCrLf & "	group by StudentNumber"
		StrSql = StrSql & vbCrLf & ") B"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = B.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.IDX = B.MaxIDX"
		StrSql = StrSql & vbCrLf & "right outer join StudentTable ET"
		StrSql = StrSql & vbCrLf & "on A.StudentNumber = ET.StudentNumber"
		'StrSql = StrSql & vbCrLf & "and A.SubjectCode = ET.SubjectCode"
		StrSql = StrSql & vbCrLf & "inner join SubjectTable D"
		StrSql = StrSql & vbCrLf & "on ET.SubjectCode = D.SubjectCode"
		StrSql = StrSql & vbCrLf & "where etc3='[자동포기]'"
		StrSql = StrSql & vbCrLf & "	" & SubStrSql & vbCrLf
		StrSql = StrSql & vbCrLf & OrderStrSql
	End If
	
	'PrintSql StrSql
	'Response.End
	Rs1.Open StrSql, Dbcon, 1, 1

	Dim StudentNumber, StudentName, Ranking, SubjectCode, Subject, Division0, Division1, Division2, Division3, Degree, Tel, MemberID, Receiver, Result, CallCount, SaveFile, Memo, InsertTime, i
	Dim	DefaultPath
	Dim Citizen1, Citizen2, fileName2
	If Rs1.RecordCount>0 Then

    fileName2 = fileName
    fileName = Server.URLEncode(FileName)

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","attachment; filename=" & fileName & ".xls"
	%>
	<HTML><HEAD><TITLE>Project METIS 2.0</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<style>
	body, table, tr, td, select, textarea, input{ 
		font-family:돋움, seoul, arial, helvetica;
		font-size: 10px;
		color: #000000;
		scrollbar-3dlight-color:595959;
					scrollbar-arrow-color:FFFFFF;
					scrollbar-base-color:CFCFCF;
					scrollbar-darkshadow-color:FFFFFF;
					scrollbar-face-color:CFCFCF;
					scrollbar-highlight-color:FFFFF;
					scrollbar-shadow-color:595959
	}V,form,TEXTAREA,center,option,pre,blockquote {font-family:Verdana;font-size:8pt;color:#333333;}
	</style>
	</HEAD>
	<BODY topmargin=0 leftmargin=0 align="center" >

		<TABLE align="center">
		<TR>
			<TD style="font-size: 22 px;" align="center" colspan="11">&nbsp; </TD>
		</TR>
		<TR><!-- 
			<TD style="font-size: 22 px;" align="center" colspan="11"><%=fileName%></TD> -->
			<TD style="font-size: 22 px;" align="center" colspan="11" style="font-size: 24; font-weight: bold;"><%=fileName2%></TD>
		</TR>
		<TR>
			<TD colspan=8>&nbsp;</TD>
		</TR>
		</TABLE>
		<TABLE align="center" border="1" bgcolor="#000000" cellpadding="2" cellspacing="1" width="" style="table-layout:fixed">
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col>
		<TR bgcolor="#FFFFFF" align="center"><TD>연번</TD><TD>석차</TD><TD>전형</TD><TD>모집단위</TD>
		<TD>수험번호</TD><TD>차수</TD><TD>등록의사</TD><TD>성 명</TD>
		<TD>주민번호</TD><TD>상담원</TD><TD>입력시각</TD></TR>
		<%
		Dim z
		z = 0
		do Until Rs1.EOF
			z = z + 1
			StudentNumber= Rs1("StudentNumber")
			StudentName= Rs1("StudentName")
			Citizen1= Rs1("Citizen1")
			Citizen2= Rs1("Citizen2")
			Citizen2= left(Rs1("Citizen2"), 1) & "******"
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
				case 11
					ResultTempStr = "기환불"
				'기본값이 미작업 이므로 Else가 필요없다
				'case Else
				'	ResultTempStr = ""
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
			End select
			'F1.WriteLine "11110036,000111XX,박승현,국어국문학과,정시,0222262356,01190863693,,2"
			'F1.WriteLine Chr(34) & StudentNumber & Chr(34) & "," & Chr(34) & StudentName & Chr(34) & "," & Chr(34) & SubjectCode & Chr(34) & "," & Chr(34) & Subject & Chr(34) & "," & Chr(34) & Division0 & Chr(34) & "," & Chr(34) & Division1 & Chr(34) & "," & Chr(34) & Division2 & Chr(34) & "," & Chr(34) & Division3 & Chr(34) & "," & Chr(34) & Degree & Chr(34) & "," & Chr(34) & Tel & Chr(34) & "," & Chr(34) & MemberID & Chr(34) & "," & Chr(34) & Receiver & Chr(34) & "," & Chr(34) & ResultTempStr & Chr(34) & "," & Chr(34) & CallCount & Chr(34) & "," & Chr(34) & SaveFile & Chr(34) & "," & Chr(34) & Memo & Chr(34) & "," & Chr(34) & InsertTime & Chr(34)
			'F1.WriteLine StudentNumber & "	" & StudentName & "	" & Ranking & "	" & SubjectCode & "	" & Division0 & "	" & Subject & "	" & Division1 & "	" & Division2 & "	" & Division3 & "	" & Degree & "	" & Tel & "	" & MemberID & "	" & ReceiverTempStr & "	" & ResultTempStr & "	" & CallCount & "	" & SaveFile & "	" & Memo & "	" & InsertTime
			
			'Response.write "<TR><TD>" & StudentNumber & "</TD><TD>" & StudentName & "</TD><TD>" & Ranking & "</TD><TD>" & SubjectCode & "</TD><TD>" & Division0 & "</TD><TD>" & Subject & "</TD><TD>" & Division1 & "</TD><TD>" & Division2 & "</TD><TD>" & Division3 & "</TD><TD>" & Degree & "</TD><TD>" & Tel & "</TD><TD>" & MemberID & "</TD><TD>" & ReceiverTempStr & "</TD><TD>" & ResultTempStr & "</TD><TD>" & CallCount & "</TD><TD>" & SaveFile & "</TD><TD>" & Memo & "</TD><TD>" & InsertTime &"</TD></TR>"

			'편입이면 가려라 (공간확보)
			If Division1 = "편입학" Then
				If Division2 = "농어촌학생 특별편입학" Then Division2="농어촌 특별편입"
				Response.write "<TR bgcolor='#FFFFFF' align='center' height='23'><TD nowrap align='center' style='padding-right:5px;'>" & i & "</TD><TD nowrap align='center' style='padding-right:5px;'>" & Ranking & "</TD><TD width='120'>" & Division2 & "</TD><TD align='left' style='word-break:break-all;' style='padding-left:10px;'>" & Subject & " " & Division3 & "</TD><TD nowrap>" & StudentNumber & "</TD>"
			Else
				If Division2 = "일반학생전형" Then Division2="일반전형"
				If Subject="미디어디자인컨텐츠학과_시각·영상디자인" Then Subject="미디어컨텐츠_시각영상디자인"
				Response.write "<TR bgcolor='#FFFFFF' align='center' height='23'><TD nowrap align='center' style='padding-right:5px;'>" & i & "</TD><TD nowrap align='center' style='padding-right:5px;'>" & Ranking & "</TD><TD width='120'>" & Division0 & " " & Division1 & " " & Division2 & "</TD><TD align='left' style='word-break:break-all;' style='padding-left:10px;'>" & Subject & " " & Division3 & "</TD><TD nowrap>" & StudentNumber & "</TD>"
			End If
			Response.write "<TD nowrap>" & Degree & "</TD><TD nowrap>" & ResultTempStr & "</TD><TD nowrap>" & StudentName & "</TD><TD nowrap>" & Citizen1 & "-" & Citizen2 &"</TD><TD nowrap>" & MemberID &"</TD><TD nowrap>" & InsertTime &"</TD></TR>"

			Rs1.MoveNext
			If z = 37 Then
				z = 0%><!-- 
		</TABLE>

		<p>

		<TABLE align="center">
		<TR>
			<TD style="font-size: 22 px;" align="center" colspan="11">&nbsp; </TD>
		</TR>
		<TR>
			<TD style="font-size: 22 px;" align="center" colspan="11"><%=fileName%></TD>
		</TR>
		<TR>
			<TD colspan=8>&nbsp;</TD>
		</TR>
		</TABLE>
		<TABLE align="center" border="1" bgcolor="#000000" cellpadding="2" cellspacing="1" width="" style="table-layout:fixed">
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col><col width=""></col>
		<col width=""></col><col width=""></col><col width=""></col>
		<TR bgcolor="#FFFFFF" align="center"><TD>연번</TD><TD>석차</TD><TD>전형</TD><TD>모집단위</TD>
		<TD>수험번호</TD><TD>차수</TD><TD>등록의사</TD><TD>성 명</TD>
		<TD>주민번호</TD><TD>상담원</TD><TD>입력시각</TD></TR> -->
			<%End If
		Loop
		Response.write "</TABLE>"
'		F1.Close
'		set F1 = Nothing
'		set FSO = Nothing
'		Rs1.Close
'		Set Rs1 = Nothing
	End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->


<%
If i>0 Then
'	Dim user_agent
'	Dim content_disp
'	Dim contenttype
'	Dim objFS, objF, objDownload
'	user_agent = Request.ServerVariables("HTTP_USER_AGENT")
'	If InStr(user_agent, "MSIE") > 0 Then
'			'IE 5.0인 경우.
'			If InStr(user_agent, "MSIE 5.0") > 0 Then
'					content_disp = "attachment;filename="
'					contenttype = "application/x-msdownload"
'			'IE 5.0이 아닌 경우.
'			Else
'					content_disp = "attachment;filename="
'					contenttype = "application/unknown"
'			End If
'	Else
'			'Netscape등 기타 브라우저인 경우.
'			content_disp = "attachment;filename="
'			contenttype = "application/unknown"
'	End If
'	 
'	Response.AddHeader "Content-Disposition", content_disp & filename
'	set objFS = Server.CreateObject("Scripting.FileSystemObject")
'	set objF = objFS.GetFile(filepath)
'	Response.AddHeader "Content-Length", objF.Size
'	set objF = Nothing
'	set objFS = Nothing
'	Response.ContentType = contenttype
'	Response.CacheControl = "public"
'	 
'	Set objDownload = Server.CreateObject("DEXT.FileDownload")
'	objDownload.Download filepath
'	Set objDownload = Nothing
Else
	Response.Write "<SCRIPT LANGUAGE='JavaScript'> parent.myModalRootClick('복수지원 사전점검','조건에 맞는 결과가 없습니다.');</SCRIPT>"
End If
%>