<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<%
server.scripttimeout = 400
Dim SavedFileName, FileExtention
SavedFileName = getParameter(request.querystring("SavedFileName"),"")
FileExtention = Split(SavedFileName,".")
select case LCase(FileExtention(UBound(FileExtention,1)))
    Case "xls": 'Load Excel
        LoadXls()
    Case "txt": 'Load Text
        LoadTxt()
End Select
Function LoadXls()
    On Error Resume Next
    dim oCon, path
    path = server.MapPath("/upload/") & "\" + request.querystring("SavedFileName")
    Set oCon = Createobject("ADODB.connection")
    oCon.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=Excel 8.0;"
    dim oCmd, oRs
    Set oRs = Server.CreateObject("ADODB.Recordset")
    oRs.CursorLocation = 3
    oRs.CursorType = 3
    oRs.LockType = 3
    set oCmd = Server.CreateObject("ADODB.Command")
    oCmd.ActiveConnection = Dbcon
    oCmd.CommandType = 1
    oRs.Open "select * from [sheet1$]", oCon
    Response.ContentType = "text/xml"
    response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf
    If oRs.EOF=False Then
        Dim totalCount
        totalCount = oRs.RecordCount
        response.write "<rows id='0' totalCount='" & totalCount & "'>" & vbCrLf
        dim StrSql, i
        i = 0
        StrSql = "truncate table SubjectTableTemp " & vbCrLf
        oCmd.CommandText = StrSql
        oCmd.Execute()
        do until oRs.eof
            If oRS(0) <> "모집단위코드" Then
				StrSql = "INSERT INTO SubjectTableTemp(SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, Myear, InsertTime) VALUES (" & vbCrLf
                StrSql = StrSql & vbCrLf & "'" & oRS(0)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(1)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(2)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(3)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(4)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(5)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(6)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(7)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(8)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(9)  & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(10) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(11) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(12) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(13) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(14) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(15) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(16) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(17) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(18) & "', "
                StrSql = StrSql & vbCrLf & "'" & oRS(19) & "', "
                StrSql = StrSql & vbCrLf & "getdate() ) " & vbCrLf
				Response.Write StrSql
                if Err.Description = "" Then
                oCmd.CommandText = StrSql
                oCmd.Execute()
                End If
                if Err.Description <> "" Then
                response.write "<row id=''>"
                response.write Chr(9) & Chr(9) & "<cell>" & Replace(Err.Description, "'", " ") & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>명단오류</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell></cell>" & vbCrLf
                response.write "</row>" & vbCrLf
                Exit Do
                Else
                response.write "<row id=''>"
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(0)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(1)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(2)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(3)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(4)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(5)  & "</cell>" & vbCrLf
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(6)  & "</cell>" & vbCrLf
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(7)  & "</cell>" & vbCrLf'
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(8)  & "</cell>" & vbCrLf'1	입학금
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(9)  & "</cell>" & vbCrLf'2	수업료
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(10) & "</cell>" & vbCrLf'3	소계
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(11) & "</cell>" & vbCrLf'4	학생회
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(14) & "</cell>" & vbCrLf'7	오티비
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(17) & "</cell>" & vbCrLf'10	소계
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(15) & "</cell>" & vbCrLf'8	장학감면
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(13) & "</cell>" & vbCrLf'6	기납입액
				response.write Chr(9) & Chr(9) & "<cell>" & oRS(12) & "</cell>" & vbCrLf'5	실납입액
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(16) & "</cell>" & vbCrLf'9	예치금
                response.write Chr(9) & Chr(9) & "<cell>" & oRS(18) & "</cell>" & vbCrLf'11	총계
                response.write Chr(9) & Chr(9) & "<cell>" & Date()  & "</cell>" & vbCrLf
                response.write Chr(9) &  "</row>" & vbCrLf
                End If
            End If
            oRs.movenext
        Loop
    Else
        response.write "<rows id='0' totalCount='0'>" & vbCrLf
    End If
    response.write "</rows>" & vbCrLf
    set oCmd = Nothing
    oRs.close
    set oRs = nothing
    oCon.close
    set oCon = nothing
End Function
Function LoadTxt()
	On Error Resume Next
    dim path
    path = server.MapPath("/upload/") & "\" + request.querystring("SavedFileName")
    Response.ContentType = "text/xml"
    response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf
    Dim fso, ts, Line, aColumn
    Const ForReading = 1
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set ts = fso.OpenTextFile( path, ForReading)
    Dim StrSql, Rs, MaxLine
    do until ts.AtEndOfStream
        Line = ts.ReadLine
        MaxLine = ts.line
    loop
    ts.Close
    If MaxLine > 0 Then
        response.write "<rows id='0' totalCount='" & MaxLine & "'>" & vbCrLf
        StrSql = "truncate table SubjectTableTemp " & vbCrLf
        Dbcon.Execute(StrSql)
        Set fso = CreateObject("Scripting.FileSystemObject")
        Set ts = fso.OpenTextFile( path, ForReading)
        Dim i, j, Myear
        MYear  = Year(Date())
        If Month(Date()) > 9 Then MYear = MYear + 1
        MYear = cStr(MYear)
        do until ts.AtEndOfStream
            i = i + 1
            Line = ts.ReadLine
            aColumn = split(Line,"	")
            'If trim(aColumn(0)) <> "SubjectCode" And trim(aColumn(0)) <> "모집단위코드" Then
			If trim(aColumn(0)) <> "SubjectCode" And trim(aColumn(0)) <> "일련번호" And trim(aColumn(0)) <> "일련번호 모집구분 학과 전형구분 주야 전공명 인원 등록금" Then
				StrSql = "INSERT INTO SubjectTableTemp(SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, Myear, InsertTime) VALUES (" & vbCrLf
                'StrSql = "INSERT INTO SubjectTableTemp(SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF11, Myear, InsertTime) VALUES (" & vbCrLf

                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(0))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(1))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(2))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(3))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(4))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(5))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(6))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(6))  & "', "

                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "
                StrSql = StrSql & vbCrLf & "'', "



                StrSql = StrSql & vbCrLf & "'" & trim(aColumn(7)) & "', "
                StrSql = StrSql & vbCrLf & "'" & MYear & "', "
                StrSql = StrSql & vbCrLf & "getdate() ) " & vbCrLf

                Dbcon.Execute(StrSql)

                response.write "<row id=''>"
                response.write "<cell>" & trim(aColumn(0))  & "</cell>"
                response.write "<cell>" & trim(aColumn(1))  & "</cell>"
                response.write "<cell>" & trim(aColumn(2))  & "</cell>"
                response.write "<cell>" & trim(aColumn(3))  & "</cell>"
                response.write "<cell>" & trim(aColumn(4))  & "</cell>"
                response.write "<cell>" & trim(aColumn(5))  & "</cell>"
                response.write "<cell>" & trim(aColumn(6))  & "</cell>"
                response.write "<cell>" & trim(aColumn(6))  & "</cell>"
                response.write "<cell>" & trim(aColumn(7))  & "</cell>"
                response.write "<cell>" & MYear  & "</cell>"
                response.write "<cell>" & Date()  & "</cell>"
                response.write "</row>" & vbCrLf


            End If
        loop
        ts.Close
        set ts = nothing
        set fso = Nothing
    Else
        response.write "<rows id='0' totalCount='0'>" & vbCrLf
    End If
    response.write "</rows>" & vbCrLf
End Function
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->