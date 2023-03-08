<% session.CodePage = "949" %>
<% Response.CharSet = "euc-kr" %>
<%
	Dim nowTime, tmpUseChlInfo, tmpChlStateInfo
	Dim useCnt, lineCnt
	Dim eDbcon

	nowTime = Now()
	lineCnt = 0
	useCnt = 0

	Set eDbcon = Server.CreateObject("ADODB.Connection") 
	eDbcon.ConnectionTimeout = 30
	eDbcon.CommandTimeout = 30
	eDbcon.Open (DbaseConnectionString)

	Set ChlRs = Server.CreateObject("ADODB.Recordset")

	sql = ""
	sql = sql & " select LineNumber, LineOrder, Telephone, Recordfile, orderconfi " & vbcrlf 
	sql = sql & " from DBASE...LINERETU " & vbcrlf 

	ChlRs.Open Sql, eDbcon, 1, 1

	Do until ChlRs.EOF

		strChContent =""
		RsChnum = ChlRs("LineNumber")
		RsLineOrder = ChlRs("LineOrder")
		RsConfi = ChlRs("orderconfi")
		RsTel = ChlRs("Telephone")
		RsRecFile = ChlRs("Recordfile")

		If RsLineOrder <> "SERVICESTOP" Then useCnt = useCnt + 1

		If RsTel <> "" Then strChContent = strChContent & RsTel & "   "
		If RsRecFile <> "" Then strChContent = strChContent & RsRecFile & " "
		If Len(strChContent) > 0 Then strChContent = Left(strChContent, Len(strChContent)-1)

		tmpChlStateInfo = tmpChlStateInfo & RsChnum & "^" & RsConfi & "^" & RsLineOrder & "^" & strChContent & "@"

		lineCnt = lineCnt + 1
		ChlRs.MoveNext

	Loop
	
	ChlRs.Close
	Set ChlRs = Nothing
	
	eDbcon.Close
	Set eDbcon = nothing


	''@ ajax으로 넘길 문자열 만들어 주자 . 사용채널 , 총 채널
	tmpUseChlInfo = useCnt & "^" & lineCnt

	tmpChlStateInfo = Left(tmpChlStateInfo, Len(tmpChlStateInfo)-1)

	Response.Write nowTime & "@@" & tmpUseChlInfo & "@@" & tmpChlStateInfo
	
%>



