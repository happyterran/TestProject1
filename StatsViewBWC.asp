<%Option Explicit%>
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd"> -->
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
<style>
	td{font-size:9pt; text-align:center; color:#333;}
    h2{color:#444;}
	.fs15{font-size:15pt;}
	.b {text-align:right; padding-right: 5px;}
	.lb{text-align:right; padding-right: 5px; border-left-width:2px;}
	.rb{border-right-width:2px;}
	.bb{border-bottom-width:2px;}
	.tb{text-align:right; padding-right: 5px; border-top-width:2px;}
	.lbb{border-left-width:2px; border-bottom-width:2px;}
	.rbb{border-right-width:2px; border-bottom-width:2px;}
	.rtb{border-right-width:2px; border-top-width:2px;}
	.ltb{text-align:right; padding-right: 5px; border-left-width:2px; border-top-width:2px;}
	.DisWordSP{letter-spacing:-1pt;}
</style>
<style media="print">
.noprint     { display: none }
</style>
<body topmargin="0" leftmargin="0" style="padding-top:0;">
<%
server.scripttimeout=200
'on error resume next
Dim Timer1
Timer1=Timer()

Const ConstDegree = 10	'10개 전형구분으로 제작

Dim StrSql, Rs, Comment, Degree, Flag

StrSql = "UP_StatsBWCFrameSrc"

Set Rs = Server.CreateObject("ADODB.Recordset")

Dim StatsTitle, DegreeFlag
StatsTitle = Request.Form("StatsTitle")

If StatsTitle <> "" and StatsTitle <> "," Then
	DegreeFlag = split(StatsTitle,",")
	Degree = DegreeFlag(0)	'선택한게 없으면 마지막 차수를~
	Flag = DegreeFlag(1)	'선택한게 없으면 마지막 플레그를~
End If

'	Response.write "Degree:" & Degree & "<br>"
'	Response.write "Flag:" & Flag & "<br>"
'	Response.End

StrSql = "UP_StatsBWCFrameSrc"
'	Response.write StrSql & "<br>"

Rs.Open StrSql,DBCon
%>
	<div id="idControls" class="noprint">
	<title><%=Rs("Subject") & " " & Rs("Division2") & " 에 작성"%></title>

	<center>
	<input type=button value="엑셀다운로드" name="ExcelDownload" onClick="document.location.href='StatsViewBWCExcelDownload.asp?Degree=<%=Degree%>&Flag=<%=Flag%>'"> 
	<!-- <input type=button value="출력" name="print" onClick="Print()">  -->
	<input type=button value="출력" name="print" onClick="window.print()"> 
	<input type=button value="닫기" onClick="self.close();">
	</center>
	</div>

	<p>

	<H2><center><%=RS("MYear")%>학년 누적 등록인원 현황표</center></H2>
	<table border=2 cellspacing=0 cellpadding=0 bordercolor=black style="border-color:black; border-style:solid; border-collapse:collapse;" style="table-layout:fixed;" width="" align="center">
	<col width="110"></col><col width="40"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="40">
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col><col width="32"></col>
	<col width="35"><col width="40">

	<tr bgcolor="ffffcc">
		<td rowspan=2 class=bb style="word-break:break-all;" bgcolor="dbe5f1">모집단위</td>
		<td rowspan=2 class=lbb bgcolor="fde9d9">정원</td>
		<td colspan=5 class=lbb height="30">일반전형</td>
		<td colspan=5 class=lbb>일반계고교</td>
		<td colspan=5 class=lbb>전문계고교</td>
		<td colspan=5 class=lbb>독자</td>
		<td colspan=5 class=lbb>연계교육자</td>
		<td rowspan=2 class=lbb bgcolor="eaf1dd">정원내<BR>합계</td>
		<td colspan=5 class=lbb>농어촌</td>
		<td colspan=5 class=lbb>기초생활수급자 및 차상위</td>
		<td colspan=5 class=lbb>전문대졸이상</td>
		<td colspan=5 class=lbb>재외국민</td>
		<td colspan=5 class=lbb>기타외국인</td>
		<td rowspan=2 class=lbb bgcolor="eaf1dd">정원외<BR>합계</td>
		<td rowspan=2 class=lbb bgcolor="eaf1dd">전체<BR>합계</td>
	</tr>
	<tr bgcolor="ffffcc">
	<%Dim i, TempRemainCount, PrintRecord
	i=1
	Do Until i > ConstDegree%>
		<td class=lbb height="40">수시1<BR>등록</td>
		<td class=bb>수시2<BR>등록</td>
		<td class=bb>정시<BR>등록</td>
		<td class=bb>등록<BR>예정</td>
		<td class=bb>소계</td>
		<%i=i+1
	Loop%>
	</tr>
	<%
	Dim QuorumSum, QuorumSum2, RegistSum, RemainCountSum(8), RegistPlanCountSum(8), RegistCountSum(8), RefundCountSum(8), AbandonCountSum(8), NonRegistCountSum(8), Refund2CountSum(8), SameCountSum(8), CutLineSum(8)
	'공백으로 총합이 표시되는걸 막기 위해
	RegistPlanCountSum(1)=0
	RegistPlanCountSum(2)=0

	Dim CE11,  CE12,  CE20,  CE6,  CE6s	'일반전형		1
	Dim CF11,  CF12,  CF20,  CF6,  CF6s	'일반계고교		2
	Dim CG11,  CG12,  CG20,  CG6,  CG6s	'전문계고교		3
	Dim CI11,  CI12,  CI20,  CI6,  CI6s	'독자			4
	Dim CJ11,  CJ12,  CJ20,  CJ6,  CJ6s	'연계교육자		5
	Dim CQ11,  CQ12,  CQ20,  CQ6,  CQ6s	'농어촌학생		6
	Dim CR11,  CR12,  CR20,  CR6,  CR6s	'기초생활수급자	7
	Dim CS11,  CS12,  CS20,  CS6,  CS6s	'전문대졸이상	8
	Dim CT11,  CT12,  CT20,  CT6,  CT6s	'재외국민		9
	Dim CV11,  CV12,  CV20,  CV6,  CV6s	'기타외국인		10
	Dim C11(10),C12(10),C20(10),C6(10),Cs(10)
	
	Dim Cs1,Cs2,Cs3			'정원내합계, 정원외합계, 전체합계

	Dim CE11Sum,  CE12Sum,  CE20Sum,  CE6Sum,  CE6sSum	'일반전형		1
	Dim CF11Sum,  CF12Sum,  CF20Sum,  CF6Sum,  CF6sSum	'일반계고교		2
	Dim CG11Sum,  CG12Sum,  CG20Sum,  CG6Sum,  CG6sSum	'전문계고교		3
	Dim CI11Sum,  CI12Sum,  CI20Sum,  CI6Sum,  CI6sSum	'독자			4
	Dim CJ11Sum,  CJ12Sum,  CJ20Sum,  CJ6Sum,  CJ6sSum	'연계교육자		5
	Dim CQ11Sum,  CQ12Sum,  CQ20Sum,  CQ6Sum,  CQ6sSum	'농어촌학생		6
	Dim CR11Sum,  CR12Sum,  CR20Sum,  CR6Sum,  CR6sSum	'기초생활수급자	7
	Dim CS11Sum,  CS12Sum,  CS20Sum,  CS6Sum,  CS6sSum	'전문대졸이상	8
	Dim CT11Sum,  CT12Sum,  CT20Sum,  CT6Sum,  CT6sSum	'재외국민		9
	Dim CV11Sum,  CV12Sum,  CV20Sum,  CV6Sum,  CV6sSum	'기타외국인		10
	Dim C11Sum(10),C12Sum(10),C20Sum(10),C6Sum(10),CsSum(10)

	Dim A(10)
	A(1) = "E"
	A(2) = "F"
	A(3) = "G"
	A(4) = "I"
	A(5) = "J"
	A(6) = "Q"
	A(7) = "R"
	A(8) = "S"
	A(9) = "T"
	A(10)= "U"

	Dim Quorum, Cs1Sum, Cs2Sum, Cs3Sum
	Dim Subject, Division2
    Dim BackgroundColor, BackgroundColorBlue, BackgroundColorGreen, BackgroundColorPeach
    BackgroundColor = "background-color: #EEEEEE;"
    BackgroundColorPeach = "fde9d9;"
    BackgroundColorBlue = "dbe5f1;"
    BackgroundColorGreen = "eff4dc;"

	Do Until Rs.EOF
        If BackgroundColor = "background-color: #EEEEEE;" Then BackgroundColor = "background-color: #FFFFFF;" Else BackgroundColor="background-color: #EEEEEE;"
        If BackgroundColorPeach = "fff4eb" Then BackgroundColorPeach = "fde9d9" Else BackgroundColorPeach="fff4eb"'fde9d9
        If BackgroundColorBlue = "eef4fa" Then BackgroundColorBlue = "dbe5f1" Else BackgroundColorBlue="eef4fa"'dbe5f1
        If BackgroundColorGreen = "fcffee" Then BackgroundColorGreen = "eff4dc" Else BackgroundColorGreen="fcffee"'eff4dc
		Cs1=0
		Cs2=0
		i=1%>
		<%'="C"&A(1)&"11"%>
		<tr style="<%=BackgroundColor%>">
			<%
			Subject = getParameter(Rs("Subject"),"")
			Division2 = getParameter(Rs("Division2"),"")
			'Quorum = getIntParameter(Rs("Quorum"),0)
			If Subject = "스마트IT과"   and Division2 = "주간" Then Quorum = 64

			If Subject = "유아교육과"   and Division2 = "주간" Then Quorum = 64
			If Subject = "영어통번역과" and Division2 = "주간" Then Quorum = 120
			If Subject = "일어통번역과" and Division2 = "주간" Then Quorum = 80
			If Subject = "비서행정과"   and Division2 = "주간" Then Quorum = 120
			If Subject = "중국어통번역과"and Division2= "주간" Then Quorum = 120
			If Subject = "국제무역과"   and Division2 = "주간" Then Quorum = 80
			If Subject = "국제무역과"   and Division2 = "야간" Then Quorum = 40
			If Subject = "경영과"       and Division2 = "주간" Then Quorum = 120
			If Subject = "세무회계과"   and Division2 = "주간" Then Quorum = 80

			If Subject = "식품영양과"   and Division2 = "주간" Then Quorum = 62
			If Subject = "식품영양과"   and Division2 = "야간" Then Quorum = 34
			If Subject = "전통조리과"   and Division2 = "주간" Then Quorum = 80
			If Subject = "전통조리과"   and Division2 = "야간" Then Quorum = 40
			If Subject = "전통의상과"   and Division2 = "주간" Then Quorum = 40
			If Subject = "전통의상과"   and Division2 = "야간" Then Quorum = 40
            
			If Subject = "패션디자인과" and Division2 = "주간" Then Quorum = 80
			If Subject = "패션디자인과" and Division2 = "야간" Then Quorum = 40

			QuorumSum = QuorumSum + Quorum
			If Division2 = "주간" Then Division2 = ""
			If Division2 = "야간" Then Division2 = "(야)"%>
			<td height=35 style="text-align: left; padding-left: 10px;"><%=Subject%><%=Division2%></td><!-- 학과 -->
			<td class=lb bgcolor="<%=BackgroundColorPeach%>"><%=Quorum%></td><!-- 모집인원 -->
			<%Do Until i > ConstDegree
				C11(i) = getIntParameter(Rs("C"&A(i)&"11"),0)
				C12(i) = getIntParameter(Rs("C"&A(i)&"12"),0)
				C20(i) = getIntParameter(Rs("C"&A(i)&"20"),0)
				C6(i)  = getIntParameter(Rs("C"&A(i)&"6"),0)
				Cs(i) = C11(i) + C12(i) + C20(i) + C6(i)
				'정원내 합계
				If i <= 5 Then Cs1 = Cs1 + Cs(i)
				'정원외 합계
				If i >= 6 Then Cs2 = Cs2 + Cs(i)
				%>
				<%'=Cs1%>
				<%'Response.End%>
				<td class=lb><%If C11(i)>0 Then%><%=C11(i)%><%End If%></td>	<!-- 수시1 등록 -->
				<td class=b ><%If C12(i)>0 Then%><%=C12(i)%><%End If%></td>	<!-- 수시2 등록 -->
				<td class=b ><%If C20(i)>0 Then%><%=C20(i)%><%End If%></td>	<!-- 정시 등록 -->
				<td class=b bgcolor="<%=BackgroundColorBlue%>"><%If C6(i)>0 Then%><%=C6(i)%><%End If%></td>	<!-- 등록예정 -->
				<td class=b bgcolor="<%=BackgroundColorGreen%>"><%If Cs(i)>0 Then%><%=Cs(i)%><%End If%></td>	<!-- 합계 -->
				<%'Response.End
				C11Sum(i) = CInt(getParameter(C11Sum(i),0)) + CInt(getParameter(C11(i),0))
				C12Sum(i) = CInt(getParameter(C12Sum(i),0)) + CInt(getParameter(C12(i),0))
				C20Sum(i) = CInt(getParameter(C20Sum(i),0)) + CInt(getParameter(C20(i),0))
				C6Sum(i) = CInt(getParameter(C6Sum(i),0)) + CInt(getParameter(C6(i),0))
				CsSum(i) = CInt(getParameter(CsSum(i),0)) + CInt(getParameter(Cs(i),0))
				'Response.Write C11Sum(i) & C12Sum(i) & C20Sum(i) & C6Sum(i) & CsSum(i)
				If i = 5 Then%>
				<td class=lb bgcolor="<%=BackgroundColorGreen%>"><%=Cs1%></td>	<!-- 정원내 합계 -->
				<%End If
				If i = 10 Then
				Cs3 = Cs1 + Cs2
				Cs1Sum = Cs1Sum + Cs1
				Cs2Sum = Cs2Sum + Cs2
				Cs3Sum = Cs3Sum + Cs3
				%>
				<td class=lb bgcolor="<%=BackgroundColorGreen%>"><%=Cs2%></td>	<!-- 정원외 합계 -->
				<td class=lb bgcolor="<%=BackgroundColorGreen%>"><%=Cs3%></td>	<!-- 전체 합계 -->
				<%End If
				i = i + 1
			Loop%>
		</tr>
		<%Rs.MoveNext
		'Response.End

		PrintRecord = PrintRecord+1
	Loop
	%>

	<tr>
		<td class=tb height=35 style="text-align: center; padding: 0px;" bgcolor="dbe5f1">총계</td><!-- 학과 -->
		<td class=ltb bgcolor="fde9d9"><%=QuorumSum%></td><!-- 모집인원 -->
		<%
		i = 1
		Do Until i > ConstDegree%>
			<%'=Cs1%>
			<%'Response.End%>
			<td class=ltb><%=C11Sum(i)%></td>	<!-- 수시1 등록 -->
			<td class=tb ><%=C12Sum(i)%></td>	<!-- 수시2 등록 -->
			<td class=tb ><%=C20Sum(i)%></td>	<!-- 정시 등록 -->
			<td class=tb bgcolor="dbe5f1"><%=C6Sum(i)%></td>	<!-- 등록예정 -->
			<td class=tb bgcolor="eff4dc"><%=CsSum(i)%></td>	<!-- 합계 -->
			<%If i = 5 Then%>
			<td class=ltb bgcolor="eaf1dd"><%=Cs1Sum%></td>	<!-- 정원내 합계 -->
			<%End If
			If i = 10 Then%>
			<td class=ltb bgcolor="eaf1dd"><%=Cs2Sum%></td>	<!-- 정원외 합계 -->
			<td class=ltb bgcolor="eaf1dd"><%=Cs3Sum%></td>	<!-- 전체 합계 -->
			<%End If
			i = i + 1
		Loop%>
	</tr>
	</table>



<%
Rs.Close
Set Rs=Nothing
Set Dbcon=Nothing
%>

<%'="<p>" & timer()-timer1%>

