<!--#include virtual="/include/Dbopen.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<% session.CodePage = "949" %>
<% Response.CharSet = "euc-kr" %>
<%
''@ **************************************************************************************************
	''@ VOS 콜 연동 테이블 open
	Dim DBBasecon
	Set DBBasecon = Server.CreateObject("ADODB.Connection") 
	DBBasecon.ConnectionTimeout = 30
	DBBasecon.CommandTimeout = 30
	DBBasecon.Open (DbaseConnectionString)
''@ **************************************************************************************************
	Dim LINENUMBER, LINEORDER, TELEPHONE, RECORDFILE, ORDERCONFI
		
	Dim Sql

	LINENUMBER	= getParameter(request.form("LINENUMBER"), "1")
	LINEORDER	= getParameter(request.form("LINEORDER"), "")
	TELEPHONE	= getParameter(request.form("TELEPHONE"), "")
	RECORDFILE	= getParameter(request.form("RECORDFILE"), "")
	ORDERCONFI	= getParameter(request.form("ORDERCONFI"), "")

	''@ VOS 테이블 업데이트 .
	Sql =		"update DBASE...LINEORDE" & vbCrLf
	Sql = Sql & "	set LINEORDER = '" & LINEORDER & "'" & vbCrLf
	Sql = Sql & "	,	TELEPHONE = '"& TELEPHONE &"'" & vbCrLf
	Sql = Sql & "	,	RECORDFILE = '"& RECORDFILE &"'" & vbCrLf
	Sql = Sql & "	,	ORDERCONFI = '"& ORDERCONFI &"'" & vbCrLf
	Sql = Sql & "	,	INSERTTIME = '"& Fn_nowDate() &"'" & vbCrLf

	If LINEORDER = "LINEFOUND" Then
		'Sql = Sql & "	where LineNumber <= '" & TotalLine & "'" & vbCrLf
	Else
		Sql = Sql & "	where LineNumber = '" & LINENUMBER & "'" & vbCrLf
	End If

	If LINEORDER = "SERVICESTOP" Then 
		Sql = Sql &	"update DBASE...LINERETU" & vbCrLf
		Sql = Sql & "	set LINEORDER = 'SERVICESTOP'" & vbCrLf
		Sql = Sql & "	,	TELEPHONE = ''" & vbCrLf
		Sql = Sql & "	,	RECORDFILE = ''" & vbCrLf
		Sql = Sql & "	,	ORDERCONFI = '1'" & vbCrLf
		Sql = Sql & "	,	INSERTTIME = '"& Fn_nowDate() &"'" & vbCrLf
	End If 

	DBBasecon.Execute(sql)
	
	DBBasecon.close
	set DBBasecon=Nothing

'	Response.Write "전송완료!"
%>