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
    'On Error Resume Next
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
        do until oRs.eof
            '쿼리작성
            i = i + 1
            '첫 주석 패스
            If oRS(0) <> "수험번호" Then
                Result = cInt(CastReverseResult(oRS(2)))
                StrSql =                   "Declare @SubjectCode as varchar(30)"
                StrSql = StrSql & vbCrLf & "select @SubjectCode = (select SubjectCode from StudentTable where StudentNumber = '" & oRS(0) & "')"
                'StrSql = StrSql & vbCrLf & "Declare @Degree as varchar(20)"
                'StrSql = StrSql & vbCrLf & "select @Degree = Degree from Degree2 where Division0 = (select Division0 from SubjectTable where SubjectCode = @SubjectCode)"
                'StrSql = StrSql & vbCrLf & "select @Degree = isnull(@Degree,0)"
                StrSql = StrSql & vbCrLf & "INSERT INTO [##RegistRecord](SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime) VALUES ( @SubjectCode, '" & oRS(0) & "', '" & oRS(1) & "', '" & Result & "', '" & Session("MemberID") & "', getdate())"
                oCmd.CommandText = StrSql
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
                response.write "</row>" & vbCrLf
                Exit Do
                Else
                response.write "<row id=''>"
                response.write "<cell>" & trim(oRS(0))  & "</cell>"
                response.write "<cell>" & trim(oRS(1))  & "</cell>"
                response.write "<cell>" & trim(oRS(2))  & "</cell>"
                response.write "<cell>" & Date() & " " & Time()  & "</cell>"
                response.write "</row>" & vbCrLf
                End If
            End If
            If i Mod 1000 = 999 Then Response.Flush
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
    On Error Resume Next
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
        'txt old
        'StrSql = "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, [SubjectCode] [varchar](20) NOT NULL, [StudentNumber] [varchar](20) NOT NULL, [StudentName] [varchar](20) NOT NULL, [Ranking] [int] NULL, [Score] [varchar](20) NULL, [BankName] [varchar](50) NULL, [AccountNumber] [varchar](50) NULL, [AccountName] [varchar](50) NULL, [Address] [varchar](100) NULL, [Tel1] [varchar](20) NOT NULL, [Tel2] [varchar](20) NULL, [Tel3] [varchar](20) NULL, [Tel4] [varchar](20) NULL, [Tel5] [varchar](20) NULL, [Citizen1] [char](6) NULL, [Citizen2] [char](7) NULL, [ETC1] [varchar](50) NULL, [ETC2] [varchar](50) NULL, [ETC3] [varchar](50) NULL, [Myear] [varchar](20) NULL, [ETC4] [varchar](20) NULL, [ETC5] [varchar](20) NULL, [ETC6] [varchar](20) NULL, [ETC7] [varchar](20) NULL, [ETC8] [varchar](20) NULL, [ETC9] [varchar](20) NULL, [ETC10] [varchar](50) NULL, [Memo] [text] NULL, [Updated] [varchar](1) NULL, [InsertTime] [datetime] NOT NULL ,     CONSTRAINT [PK_StudentTable] PRIMARY KEY NONCLUSTERED      ([StudentNumber] Asc     )WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY])  ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] " & vbCrLf
        'StudentUploadDatabaseGet.asp
        StrSql = "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(20) NOT NULL, StudentNumber varchar(20) NOT NULL, StudentName varchar(20) NOT NULL, Ranking int NOT NULL, Score varchar(20) NULL, Degree1 tinyint NULL, Result1 varchar(2) NULL, BankName varchar(50) NULL, AccountNumber varchar(50) NULL, AccountName varchar(50) NULL, Address varchar(100) NULL, Tel1 varchar(20) NULL, Tel2 varchar(20) NULL, Tel3 varchar(20) NULL, Tel4 varchar(20) NULL, Tel5 varchar(20) NULL, Citizen1 char(6) NULL, Citizen2 char(7) NULL, ETC1 varchar(50) NULL, ETC2 varchar(50) NULL, ETC3 varchar(50) NULL, Myear varchar(20) NULL, ETC4 varchar(20) NULL, ETC5 varchar(20) NULL, ETC6 varchar(20) NULL, ETC7 varchar(20) NULL, ETC8 varchar(20) NULL, ETC9 varchar(20) NULL, ETC10 varchar(50) NULL, Memo text NULL, Updated varchar(1) NULL, RF1 int NULL,RF2 int NULL,RF3 int NULL,RF4 int NULL,RF5 int NULL,RF6 int NULL,RF7 int NULL,RF8 int NULL,RF9 int NULL,RF10 int NULL,RF11 int NULL, JCode1 varchar(10) NULL, JCode2 varchar(10) NULL, JCode3 varchar(10) NULL, VAccountNumber varchar(15) NULL, InsertTime datetime NOT NULL) " & vbCrLf
        Dbcon.Execute(StrSql)
        'txt old
        'StrSql = "INSERT INTO [##StudentTable](SubjectCode, StudentNumber, StudentName, Ranking, Score, BankName, AccountNumber, AccountName, Address, Tel1, Tel2, Tel3, Tel4, Tel5, Citizen1, Citizen2, ETC1, ETC2, ETC3, InsertTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate())"
        'StudentUploadDatabaseGet.asp
        StrSql = "INSERT INTO [##StudentTable](SubjectCode, StudentNumber, StudentName, Ranking, Score, Degree1, Result1, BankName, AccountNumber, AccountName, Address, Tel1, Tel2, Tel3, Tel4, Tel5, Citizen1, Citizen2, ETC1, ETC2, ETC3, MYear, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, JCode1, JCode2, JCode3, VAccountNumber, InsertTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
'        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("StudentName", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Ranking", adInteger, adParamInput, 4 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Score", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("BankName", adVarChar, adParamInput, 50 )
'        oCmd.Parameters.Append oCmd.CreateParameter("AccountNumber", adVarChar, adParamInput, 50 )
'        oCmd.Parameters.Append oCmd.CreateParameter("AccountName", adVarChar, adParamInput, 50 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Address", adVarChar, adParamInput, 100 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Tel1", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Tel2", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Tel3", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Tel4", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Tel5", adVarChar, adParamInput, 20 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Citizen1", adVarChar, adParamInput, 6 )
'        oCmd.Parameters.Append oCmd.CreateParameter("Citizen2", adVarChar, adParamInput, 7 )
'        oCmd.Parameters.Append oCmd.CreateParameter("ETC1", adVarChar, adParamInput, 50 )
'        oCmd.Parameters.Append oCmd.CreateParameter("ETC2", adVarChar, adParamInput, 50 )
'        oCmd.Parameters.Append oCmd.CreateParameter("ETC3", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentName", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Ranking", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("Score", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Degree1", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("Result1", adVarChar, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("BankName", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("AccountNumber", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("AccountName", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("Address", adVarChar, adParamInput, 100 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel1", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel2", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel3", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel4", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel5", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen1", adVarChar, adParamInput, 6 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen2", adVarChar, adParamInput, 7 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC1", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC2", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC3", adVarChar, adParamInput, 50 )
        oCmd.Parameters.Append oCmd.CreateParameter("MYear", adVarChar, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF1", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF2", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF3", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF4", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF5", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF6", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF7", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF8", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF9", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF10", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("RF11", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("Jcode1", adVarChar, adParamInput, 10 )
        oCmd.Parameters.Append oCmd.CreateParameter("Jcode2", adVarChar, adParamInput, 10 )
        oCmd.Parameters.Append oCmd.CreateParameter("Jcode3", adVarChar, adParamInput, 10 )
        oCmd.Parameters.Append oCmd.CreateParameter("VAccountNumber", adVarChar, adParamInput, 15 )
        Set fso = CreateObject("Scripting.FileSystemObject")
        Set ts = fso.OpenTextFile( path, ForReading)
        Dim i, j
        do until ts.AtEndOfStream
            i = i + 1
            Line = ts.ReadLine
            Line = Replace(Line, "#", "")
            Line = Replace(Line, "&", "")
            aColumn = split(Line,"	")
            If trim(aColumn(0)) <> "SubjectCode" And trim(aColumn(0)) <> "모집코드" Then
'                oCmd.Parameters("SubjectCode") = trim(aColumn(0))
'                oCmd.Parameters("StudentNumber") = trim(aColumn(1))
'                oCmd.Parameters("StudentName") = trim(aColumn(2))
'                oCmd.Parameters("Ranking") = getparameter(trim(aColumn(3)),0)
'                oCmd.Parameters("Score") = trim(aColumn(4))
'                oCmd.Parameters("BankName") = trim(aColumn(5))
'                oCmd.Parameters("AccountNumber") = trim(aColumn(6))
'                oCmd.Parameters("AccountName") = trim(aColumn(7))
'                oCmd.Parameters("Address") = trim(aColumn(8))
'                oCmd.Parameters("Tel1") = trim(aColumn(9))
'                oCmd.Parameters("Tel2") = trim(aColumn(10))
'                oCmd.Parameters("Tel3") = trim(aColumn(11))
'                oCmd.Parameters("Tel4") = trim(aColumn(12))
'                oCmd.Parameters("Tel5") = trim(aColumn(13))
'                oCmd.Parameters("Citizen1") = trim(aColumn(14))
'                oCmd.Parameters("Citizen2") = trim(aColumn(15))
'                oCmd.Parameters("ETC1") = trim(aColumn(16))
'                oCmd.Parameters("ETC2") = trim(aColumn(17))
'                oCmd.Parameters("ETC3") = trim(aColumn(18))
                oCmd.Parameters("SubjectCode")     = trim(aColumn(0))
                oCmd.Parameters("StudentNumber")   = trim(aColumn(1))
                oCmd.Parameters("StudentName")     = trim(aColumn(2))
                oCmd.Parameters("Ranking")         = trim(aColumn(3))
                oCmd.Parameters("Score")           = trim(aColumn(4))
                oCmd.Parameters("Degree1")         = trim(aColumn(5))
                oCmd.Parameters("Result1")         = trim(aColumn(6))
                oCmd.Parameters("BankName")        = trim(aColumn(7))
                oCmd.Parameters("AccountNumber")   = trim(aColumn(8))
                oCmd.Parameters("AccountName")     = trim(aColumn(9))
                oCmd.Parameters("Address")         = trim(aColumn(10))
                oCmd.Parameters("Tel1")     = trim(aColumn(11))
                oCmd.Parameters("Tel2")     = trim(aColumn(12))
                oCmd.Parameters("Tel3")     = trim(aColumn(13))
                oCmd.Parameters("Tel4")     = trim(aColumn(14))
                oCmd.Parameters("Tel5")     = trim(aColumn(15))
                oCmd.Parameters("Citizen1")         = trim(aColumn(16))
                oCmd.Parameters("Citizen2")         = trim(aColumn(17))
                oCmd.Parameters("ETC1")             = trim(aColumn(18))
                oCmd.Parameters("ETC2")             = trim(aColumn(19))
                oCmd.Parameters("ETC3")             = trim(aColumn(20))
                oCmd.Parameters("MYear")         = trim(aColumn(21))
                oCmd.Parameters("RF1")         = trim(aColumn(22))
                oCmd.Parameters("RF2")         = trim(aColumn(23))
                oCmd.Parameters("RF3")         = trim(aColumn(24))
                oCmd.Parameters("RF4")         = trim(aColumn(25))
                oCmd.Parameters("RF5")         = trim(aColumn(26))
                oCmd.Parameters("RF6")     = trim(aColumn(27))
                oCmd.Parameters("RF7")     = trim(aColumn(28))
                oCmd.Parameters("RF8")     = trim(aColumn(29))
                oCmd.Parameters("RF9")     = trim(aColumn(30))
                oCmd.Parameters("RF10")         = trim(aColumn(31))
                oCmd.Parameters("RF11")         = trim(aColumn(32))
                oCmd.Parameters("JCode1")         = trim(aColumn(33))
                oCmd.Parameters("JCode2")         = trim(aColumn(34))
                oCmd.Parameters("JCode3")         = trim(aColumn(35))
                oCmd.Parameters("VAccountNumber")= trim(aColumn(36))
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
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "</row>" & vbCrLf
                Exit Do
                Else
'                response.write "<row id=''>"
'                response.write "<cell>" & trim(aColumn(0))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(1))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(2))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(3))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(4))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(5))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(6))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(7))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(9))  & "</cell>"
'                response.write "<cell>" & trim(aColumn(10)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(11)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(12)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(13)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(14)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(15)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(16)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(17)) & "</cell>"
'                response.write "<cell>" & trim(aColumn(18)) & "</cell>"
'                response.write "<cell>" & Date() & " " & Time() & "</cell>"
'                response.write "</row>" & vbCrLf
                response.write "<row id=''>"
                response.write "<cell>" & trim(aColumn(0))  & "</cell>"
                response.write "<cell>" & trim(aColumn(1))  & "</cell>"
                response.write "<cell>" & trim(aColumn(2))  & "</cell>"
                response.write "<cell>" & trim(aColumn(3))  & "</cell>"
                response.write "<cell>" & trim(aColumn(4))  & "</cell>"
                response.write "<cell>" & trim(aColumn(5))  & "</cell>"
                response.write "<cell>" & trim(aColumn(6))  & "</cell>"
                response.write "<cell>" & trim(aColumn(7))  & "</cell>"
                response.write "<cell>" & trim(aColumn(8))  & "</cell>"
                response.write "<cell>" & trim(aColumn(9))  & "</cell>"
                response.write "<cell>" & trim(aColumn(10)) & "</cell>"
                response.write "<cell>" & trim(aColumn(11)) & "</cell>"
                response.write "<cell>" & trim(aColumn(12)) & "</cell>"
                response.write "<cell>" & trim(aColumn(13)) & "</cell>"
                response.write "<cell>" & trim(aColumn(14)) & "</cell>"
                response.write "<cell>" & trim(aColumn(15)) & "</cell>"
                response.write "<cell>" & trim(aColumn(16)) & "</cell>"
                response.write "<cell>" & trim(aColumn(17)) & "</cell>"
                response.write "<cell>" & trim(aColumn(18)) & "</cell>"
                response.write "<cell>" & trim(aColumn(19)) & "</cell>"
                response.write "<cell>" & trim(aColumn(20)) & "</cell>"
                response.write "<cell>" & trim(aColumn(21)) & "</cell>"
                response.write "<cell>" & trim(aColumn(22)) & "</cell>"'1
                response.write "<cell>" & trim(aColumn(23)) & "</cell>"'2
                response.write "<cell>" & trim(aColumn(24)) & "</cell>"'3
                response.write "<cell>" & trim(aColumn(25)) & "</cell>"'4
                response.write "<cell>" & trim(aColumn(28)) & "</cell>"'5
                response.write "<cell>" & trim(aColumn(31)) & "</cell>"'6
                response.write "<cell>" & trim(aColumn(29)) & "</cell>"'7
                response.write "<cell>" & trim(aColumn(27)) & "</cell>"'8
                response.write "<cell>" & trim(aColumn(26)) & "</cell>"'9
                response.write "<cell>" & trim(aColumn(30)) & "</cell>"'10
                response.write "<cell>" & trim(aColumn(32)) & "</cell>"'11
                response.write "<cell>" & trim(aColumn(33)) & "</cell>"
                response.write "<cell>" & trim(aColumn(34)) & "</cell>"
                response.write "<cell>" & trim(aColumn(35)) & "</cell>"
                response.write "<cell>" & trim(aColumn(36)) & "</cell>"
                response.write "<cell>" & Date()  & "</cell>"
                response.write "</row>" & vbCrLf
                End If
            End If
            If i Mod 1000 = 999 Then Response.Flush
        loop
        ts.Close
        set ts = nothing
        set fso = Nothing
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