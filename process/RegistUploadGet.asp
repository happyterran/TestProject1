<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<!-- #include virtual = "/include/adovbs.inc.asp"-->
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
    Dim Dbcon
    Set Dbcon = createobject("ADODB.connection")
    Dbcon.open DBConnectionString
    'Dbcon.BeginTrans
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
        Dim Result
        i = 0
        StrSql = "IF OBJECT_ID('tempdb..##RegistRecord') IS NOT NULL drop table ##RegistRecord CREATE TABLE [##RegistRecord]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(20) NOT NULL, StudentNumber varchar(20) NOT NULL, Degree tinyint NULL, Result tinyint NULL, MemberID varchar(20) NOT NULL, InsertTime datetime NOT NULL) " & vbCrLf
        oCmd.CommandText = StrSql
        dbcon.Execute StrSql
        oCmd.Execute()
        StrSql =                   ""
        'StrSql =                   "Declare @SubjectCode as varchar(30)"
        'StrSql = StrSql & vbCrLf & "select @SubjectCode = (select SubjectCode from StudentTable where StudentNumber = ?)"
        'StrSql = StrSql & vbCrLf & "Declare @Degree as varchar(20)"
        'StrSql = StrSql & vbCrLf & "select @Degree = Degree from Degree2 where Division0 = (select Division0 from SubjectTable where SubjectCode = @SubjectCode)"
        'StrSql = StrSql & vbCrLf & "select @Degree = isnull(@Degree,0)"
        StrSql = "INSERT INTO [##RegistRecord](SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime) VALUES ( ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Degree", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("Result", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("MemberID", adVarChar, adParamInput, 20 )
        do until oRs.eof
            '쿼리작성
            i = i + 1
            '첫 주석 패스
            If Trim(oRS(0)) <> "모집단위코드" Then
                Result = cInt(CastReverseResult(oRS(3)))
                oCmd.Parameters("SubjectCode")  = trim(oRS(0))
                oCmd.Parameters("StudentNumber")= trim(oRS(1))
                oCmd.Parameters("Degree")       = trim(oRS(2))
                oCmd.Parameters("Result")       = trim(Result)
                oCmd.Parameters("MemberID")     = Session("MemberID")
                'PrintAdo oCmd
                if Err.Description = "" Then
                oCmd.Execute()
                End If
                if Err.Description <> "" Then
                response.write "<row id=''>"
                response.write "<cell>" & Replace(Err.Description, "'", " ") & "</cell>" & vbCrLf
                response.write "<cell></cell>" & vbCrLf
                response.write "<cell>명단오류</cell>" & vbCrLf
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "</row>" & vbCrLf
                Exit Do
                Else
                response.write "<row id=''>"
                response.write "<cell>" & trim(oRS(0))  & "</cell>"
                response.write "<cell>" & trim(oRS(1))  & "</cell>"
                response.write "<cell>" & trim(oRS(2))  & "</cell>"
                response.write "<cell>" & trim(oRS(3))  & "</cell>"
                response.write "<cell>" & Date() & " " & Time()  & "</cell>"
                response.write "</row>" & vbCrLf
                End If
            End If
            'If i Mod 1000 = 999 Then Response.Flush
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
    'Dbcon.CommitTrans
    Dbcon.close
    set Dbcon = nothing
End Function
Function LoadTxt()
    'On Error Resume Next
    Dim Dbcon
    Set Dbcon = createobject("ADODB.connection")
    Dbcon.open DBConnectionString
    'Dbcon.BeginTrans
    dim oCmd
    set oCmd = Server.CreateObject("ADODB.Command")
    oCmd.ActiveConnection = Dbcon
    oCmd.CommandType = 1
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
        StrSql = "IF OBJECT_ID('tempdb..##RegistRecord') IS NOT NULL drop table ##RegistRecord CREATE TABLE [##RegistRecord]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(30) NOT NULL, StudentNumber varchar(20) NOT NULL, Degree tinyint NULL, Result tinyint NULL, MemberID varchar(20) NOT NULL, InsertTime datetime NOT NULL) " & vbCrLf
        Dbcon.Execute(StrSql)
        StrSql = "INSERT INTO [##RegistRecord](SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime) VALUES ( ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Degree", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("Result", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("MemberID", adVarChar, adParamInput, 20 )
        Set fso = CreateObject("Scripting.FileSystemObject")
        Set ts = fso.OpenTextFile( path, ForReading)
        Dim i, j, Myear
        MYear  = Year(Date())
        If Month(Date()) > 9 Then MYear = MYear + 1
        MYear = cStr(MYear)
        Dim Result
        do until ts.AtEndOfStream
		
		'// 텍스트 업로드 시 아래 양식으로 입력 함
		'// 수험번호	등록결과	차수
		'G1220000030	등록완료	1
		'G1220000019	환불	1

            i = i + 1
            Line = ts.ReadLine
            Line = Replace(Line, "#", "")
            Line = Replace(Line, "&", "")
			aColumn = split(Line,"	")
            If trim(aColumn(0)) <> "SubjectCode" And (trim(aColumn(0)) <> "모집단위코드" Or trim(aColumn(0)) <> "학부코드") Then
                If Ubound(aColumn,1) <= 2 Then
                    Result = cInt(CastReverseResult(aColumn(1)))
                    oCmd.Parameters("SubjectCode")  = ""
                    oCmd.Parameters("StudentNumber")= trim(aColumn(0))
                    oCmd.Parameters("Result")       = trim(Result)
                    oCmd.Parameters("Degree")       = trim(aColumn(2))
					'oCmd.Parameters("Degree")       = Session("RegistDegree")
                    oCmd.Parameters("MemberID")     = Session("MemberID")
                    if Err.Description = "" Then
                    oCmd.Execute()
                    End If
                    if Err.Description <> "" Then
                    response.write "<row id=''>"
                    response.write "<cell>" & Replace(Err.Description, "'", " ") & "</cell>" & vbCrLf
                    response.write "<cell></cell>" & vbCrLf
                    response.write "<cell>명단오류</cell>" & vbCrLf
                    response.write "<cell></cell>"
                    response.write "<cell></cell>"
                    response.write "</row>" & vbCrLf
                    Exit Do
                    Else
                    response.write "<row id=''>"
                    response.write "<cell>" & "-"                & "</cell>"
                    response.write "<cell>" & trim(aColumn(0))  & "</cell>"
                    response.write "<cell>" & trim(aColumn(1))  & "</cell>"
                    response.write "<cell>" & trim(aColumn(2))  & "</cell>"
                    response.write "<cell>" & Date() & " " & Time()  & "</cell>"
                    response.write "</row>" & vbCrLf
                    End If
                Else
                    Result = cInt(CastReverseResult(aColumn(3)))
                    oCmd.Parameters("SubjectCode")  = trim(aColumn(0))
                    oCmd.Parameters("StudentNumber")= trim(aColumn(1))
                    oCmd.Parameters("Degree")       = trim(aColumn(2))
					'oCmd.Parameters("Degree")       = Session("RegistDegree")
                    oCmd.Parameters("Result")       = trim(Result)
                    oCmd.Parameters("MemberID")     = Session("MemberID")
                    if Err.Description = "" Then
                    oCmd.Execute()
                    End If
                    if Err.Description <> "" Then
                    response.write "<row id=''>"
                    response.write "<cell>" & Replace(Err.Description, "'", " ") & "</cell>" & vbCrLf
                    response.write "<cell></cell>" & vbCrLf
                    response.write "<cell>명단오류</cell>" & vbCrLf
                    response.write "<cell></cell>"
                    response.write "<cell></cell>"
                    response.write "</row>" & vbCrLf
                    Exit Do
                    Else
                    response.write "<row id=''>"
                    response.write "<cell>" & trim(aColumn(0))  & "</cell>"
                    response.write "<cell>" & trim(aColumn(1))  & "</cell>"
                    response.write "<cell>" & trim(aColumn(2))  & "</cell>"
                    response.write "<cell>" & trim(aColumn(3))  & "</cell>"
                    response.write "<cell>" & Date() & " " & Time()  & "</cell>"
                    response.write "</row>" & vbCrLf
                    End If
                End If
            End If
            If i Mod 1000 = 999 Then Response.Flush
        loop
        ts.Close
        set ts = nothing
        set fso = Nothing

        '모집단위코드 일괄수정
        If Ubound(aColumn,1) <= 2 Then
            StrSql =                   "update a"
            StrSql = StrSql & vbCrLf & "set a.SubjectCode = b.SubjectCode"
            StrSql = StrSql & vbCrLf & "from ##RegistRecord a"
            StrSql = StrSql & vbCrLf & "join StudentTable b"
            StrSql = StrSql & vbCrLf & "on a.StudentNumber = b.StudentNumber"
            Dbcon.Execute(StrSql)
        End If

    Else
        response.write "<rows id='0' totalCount='0'>" & vbCrLf
    End If
    response.write "</rows>" & vbCrLf
    set oCmd = Nothing
    Dbcon.close
    set Dbcon = nothing
End Function
'ADO의 Command객체를 이용할 경우 파라미터값을 출력하기가 힘들다. 이 함수를 이용하여 완성된 쿼리문을 얻을 수 있다.
Sub print_StrSql(objComd)
    Dim StrSql, start, param, findpos
    StrSql = objComd.CommandText
    start = 1
    For Each param In objComd.Parameters
        findpos = InStr(start,"?",StrSql)
        start = findpos + 1
        StrSql = Replace(StrSql,"?","'"&param.Value&"'",start,1)
    Next
    Response.Write "<b>" & vbcrlf & StrSql & "</b>" & vbcrlf & "<br>"
End Sub
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->