<%@ Language=VBScript %>
<%Option Explicit%>

<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<%
	''@ 필드 정보	LINENUMBER[라인순번]	
	''@				LINEORDER[라인명령]	
	''@				TELEPHONE[라인정보]	
	''@				RECORDFILE[녹취파일이름]	
	''@				ORDERCONFI[명령설정값]	
	''@				INSERTTIME[등록시간]

	Dim LINENUMBER, LINEORDER, TELEPHONE, RECORDFILE
	Dim Sql, Rs, TotalLine

	''@ **************************************************************************************************
	''@ VOS 콜 연동 테이블 open
	Dim DBBasecon
	Set DBBasecon = Server.CreateObject("ADODB.Connection") 
	DBBasecon.ConnectionTimeout = 30
	DBBasecon.CommandTimeout = 30
	DBBasecon.Open (DbaseConnectionString)
	''@ **************************************************************************************************

	set Rs = Server.CreateObject("ADODB.Recordset")

	LINENUMBER	= getParameter(request.form("LINENUMBER"), "1")
	LINEORDER	= getParameter(request.form("LINEORDER"), "")
	TELEPHONE	= getParameter(request.form("TELEPHONE"), "")
	RECORDFILE	= getParameter(request.form("RECORDFILE"), "")

	'TotalLine 읽어와서 업데이트
	Dim fso, fullpath, obj_txt, TempLineData, TempLineLocation, TempLineLength
	Set fso = Server.CreateObject("Scripting.FileSystemObject")  
	fullpath = "C:\METIS\Setting.ini"  
	set obj_txt = fso.OpenTextFile(fullpath, 1)  
	  
	TotalLine = 0
	Do While Not obj_txt.AtEndOfStream
		TempLineData = obj_txt.ReadLine
		TempLineLocation = InStr(TempLineData, "=")
		TempLineLength = Len(TempLineData) - TempLineLocation
		If TempLineLocation > 0 Then
			'response.write  Mid(TempLineData, 1, TempLineLocation - 1) & "=" & Mid(TempLineData, TempLineLocation + 1, TempLineLength) & "<BR>"
			If Mid(TempLineData, 1, TempLineLocation - 1) = "TOTALLINE" Then TotalLine = Mid(TempLineData, TempLineLocation + 1, TempLineLength)
		End If
	Loop
	obj_txt.Close
	set fso = nothing
	set obj_txt = nothing

	If TotalLine <> 0 Then
		Sql = " update SettingTable set TotalLine = '" & TotalLine & "'  "
		'Response.Write Sql
		Dbcon.Execute Sql
	End If

	Dbcon.close
	set Dbcon=Nothing

	''@ VOS 테이블 업데이트 .

	If LINEORDER = "LINEFOUNDALL" Then 
		For i = 1 To TotalLine
			Sql =		" update DBASE...LINEORDE" & vbCrLf
			Sql = Sql & "	set LINEORDER = 'LINEFOUND'" & vbCrLf
			Sql = Sql & "	,	TELEPHONE = ''" & vbCrLf
			Sql = Sql & "	,	RECORDFILE = ''" & vbCrLf
			Sql = Sql & "	,	ORDERCONFI = '1'" & vbCrLf
			Sql = Sql & "	,	INSERTTIME = '"& Fn_nowDate() &"'" & vbCrLf
			Sql = Sql & "	where LineNumber = '" & i & "'" & vbCrLf
			DBBasecon.Execute(sql)
		Next 
	ElseIf LINEORDER = "SERVICESTOP" Or LINEORDER = "ONHOOKALL" Then 
		Sql =		" update DBASE...LINEORDE" & vbCrLf
		If LINEORDER = "ONHOOKALL" Then 
			Sql = Sql & "	set LINEORDER = 'ONHOOK'" & vbCrLf
		Else 
			Sql = Sql & "	set LINEORDER = 'SERVICESTOP'" & vbCrLf
		End If 
		Sql = Sql & "	,	TELEPHONE = ''" & vbCrLf
		Sql = Sql & "	,	RECORDFILE = ''" & vbCrLf
		Sql = Sql & "	,	ORDERCONFI = '1'" & vbCrLf
		Sql = Sql & "	,	INSERTTIME = '"& Fn_nowDate() &"'" & vbCrLf
		DBBasecon.Execute(sql)
	elseIf LINEORDER <> "" Then
		Sql =		" update DBASE...LINEORDE" & vbCrLf
		Sql = Sql & "	set LINEORDER = '" & LINEORDER & "'" & vbCrLf
		Sql = Sql & "	,	TELEPHONE = '"& TELEPHONE &"'" & vbCrLf
		Sql = Sql & "	,	RECORDFILE = '"& RECORDFILE &"'" & vbCrLf
		Sql = Sql & "	,	ORDERCONFI = '1'" & vbCrLf
		Sql = Sql & "	,	INSERTTIME = '"& Fn_nowDate() &"'" & vbCrLf
		Sql = Sql & "	where LineNumber = '" & LINENUMBER & "'" & vbCrLf
		DBBasecon.Execute(sql)
	End If

	Response.Write "LINEORDER ->" & LINEORDER & "<br>"
	response.Write sql & "<br>"
	
	DBBasecon.close
	set DBBasecon=Nothing
%>

<HTML>
<HEAD>
<title>윈도우 소켓 테스트 사이트</title>
<link rel="stylesheet" href="/images/gray/style.css" type="text/css">
</HEAD>
<script type="text/javascript">
function SendInfo(LINEORDER, TELEPHONE, RECORDFILE) {
	var aFrm = document.myform;

	aFrm.LINEORDER.value = LINEORDER;
	aFrm.TELEPHONE.value = TELEPHONE;
	aFrm.RECORDFILE.value = RECORDFILE;

	if (aFrm.LINEORDER.value == "") { 
		alert("라인명령이 빈값입니다. 입력해주세요.");
		return;
	}

	aFrm.submit();
	return;
}

</script>
<BODY onload="document.myform.LINENUMBER.focus();">

<CENTER>
<TABLE width=400 border=1>
<TR>
	<TD>
	<CENTER>
	<form name="myform" action="LineOrder.asp" method="post">
	<font color="#48d1cc"><b>라인, 라인명령, Tel정보, 녹취파일정보</b></font> 자료를 입력하세요. <br>
	<!-- 입력한 자료는 지정한 서버측 IP 로 전달됩니다 --><BR>
		<table width=350 align=center valign=top border=1 cellpadding=0 cellspacing=0 >
		<colgroup>
			<!-- <col style="background-color:red"> -->
			<col width="30" >
			<col width="50" >
			<col width="80" >
			<col width="80" >
			<col width="60" >
		</colgroup>
		<tr bgcolor="ffe4b5" align="center" height="25">
			<td>라인</td>
			<td>라인명령</td>
			<td>Tel정보</td>
			<td>녹취파일정보</td>
			<td>&nbsp;</td>
		<tr>
		<tr>
			<td>
				<select name="LINENUMBER">
				<%Dim i
				for i = 1 to TotalLine%>
					<option value="<%=i%>" <%if LINENUMBER = cStr(i) then response.write "selected"%>><%=i%></option>
				<%next%>
				</select>
			</td>
			<td><input type="text" value="<%=LINEORDER%>" maxlength="30" name="LINEORDER" size="10"></td>
			<td><input type="text" value="<%=TELEPHONE%>" maxlength="30" name="TELEPHONE" size="15"></td>
			<td><input type="text" value="<%=RECORDFILE%>" maxlength="30" name="RECORDFILE" size="15"></td>
			<td><input type="submit" value="전송" name="btnSubmit"></td>
		<tr>
		</table>

	<% 
		Dim btnSize
		btnSize ="width:180px;" 
	%>
		<BR>
	<!-- 
		''@	 첫번째 인자: LINEORDER[라인명령]	
		''@	 두번째 인자: TELEPHONE[전번정보]	
		''@	 세번째 인자: RECORDFILE[녹취파일이름]	
	-->
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="ONHOOK" value="ONHOOK" ONCLICK="SendInfo('ONHOOK', '', '');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="OFFHOOK" value="OFFHOOK" ONCLICK="SendInfo('OFFHOOK', '', '');">

	<!--<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DIAL,8618760" value="DIAL,8618760" ONCLICK="SendInfo('DIAL', '8618760', '');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DIAL,01098999449" value="DIAL,01098999449" ONCLICK="SendInfo('DIAL', '01098999449', '');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DIAL,8761" value="DIAL,8761" ONCLICK="SendInfo('DIAL', '8761', '');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DIAL,9" value="DIAL,9" ONCLICK="SendInfo('DIAL', '9', '');">
	-->
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="RECORDVOX,zzzz" value="RECORDVOX,zzzz" ONCLICK="SendInfo('RECORDVOX', '', 'zzzz');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="RECORDVOX2,zzzz" value="RECORDVOX2,zzzz" ONCLICK="SendInfo('RECORDVOX2', '', 'zzzz');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="RECORDEND" value="RECORDEND" ONCLICK="SendInfo('RECORDEND', '', '');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="PLAYVOX.zzzz" value="PLAYVOX.zzzz" ONCLICK="SendInfo('PLAYVOX', '', 'zzzz');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="END" value="END" ONCLICK="SendInfo('END', '', '');">		
	<!--<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="GENERALCALL" value="GENERALCALL" ONCLICK="SendInfo('GENERALCALL', '', '');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD,01089085275,test3" value="DRECORD,01089085275,test3" ONCLICK="SendInfo('DRECORD', '01089085275', 'test3');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD,028618759,test4" value="DRECORD,028618759,test4" ONCLICK="SendInfo('DRECORD', '028618759', 'test4');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD2,01089085275,zzzz" value="DRECORD2,01089085275,zzzz" ONCLICK="SendInfo('DRECORD2', '01089085275', 'zzzz');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD2,028618758,zzzz" value="DRECORD2,028618758,zzzz" ONCLICK="SendInfo('DRECORD2', '028618758', 'zzzz');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD2,028618690,zzzz" value="DRECORD2,028618690,zzzz" ONCLICK="SendInfo('DRECORD2', '028618690', 'zzzz');">
	-->	<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="DRECORD2,0221359761,zzzz" value="DRECORD2,0221359761,zzzz" ONCLICK="SendInfo('DRECORD2', '0221359761', 'zzzz');">
	
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="LINEFOUND" value="LINEFOUND" ONCLICK="SendInfo('LINEFOUND', '', '');">
		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="LINEFOUNDALL" value="LINEFOUNDALL" ONCLICK="SendInfo('LINEFOUNDALL', '', '');">

		<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="ONHOOKALL" value="ONHOOKALL" ONCLICK="SendInfo('ONHOOKALL', '', '');">
	<!--<INPUT TYPE="BUTTON" style="<%=btnSize%>" NAME="SERVICESTOP" value="SERVICESTOP" ONCLICK="SendInfo('SERVICESTOP', '', '');">
	-->
	</form>
	<A HREF="/Record/zzzz.wav">zzzz.wav</A>
	<A HREF="/Record/Test1.wav">Test1.wav</A>
	<A HREF="/Record/Test2.wav">Test2.wav</A>
	</CENTER>

	</TD>
</TR>
</TABLE>
</CENTER>

</BODY>
</HTML>

