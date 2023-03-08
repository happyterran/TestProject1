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
        i = 0
        'xls old
        'StrSql = "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, [SubjectCode] [varchar](20) NOT NULL, [StudentNumber] [varchar](20) NOT NULL, [StudentName] [varchar](20) NOT NULL, [Ranking] [int] NULL, [Score] [varchar](20) NULL, [Degree1] [tinyint] NULL, [Result1] [varchar](2) NULL, [BankName] [varchar](50) NULL, [AccountNumber] [varchar](50) NULL, [AccountName] [varchar](50) NULL, [Address] [varchar](100) NULL, [Tel1] [varchar](20) NULL, [Tel2] [varchar](20) NULL, [Tel3] [varchar](20) NULL, [Tel4] [varchar](20) NULL, [Tel5] [varchar](20) NULL, [Citizen1] [char](6) NULL, [Citizen2] [char](7) NULL, [ETC1] [varchar](50) NULL, [ETC2] [varchar](50) NULL, [ETC3] [varchar](50) NULL, [Myear] [varchar](20) NULL, [ETC4] [varchar](20) NULL, [ETC5] [varchar](20) NULL, [ETC6] [varchar](20) NULL, [ETC7] [varchar](20) NULL, [ETC8] [varchar](20) NULL, [ETC9] [varchar](20) NULL, [ETC10] [varchar](50) NULL, [Memo] [text] NULL, [Updated] [varchar](1) NULL, [request_date] [varchar](8) NULL, [tr_code] [varchar](8) NULL, [tr_key] [varchar](5) NULL, [seq] [varchar](5) NULL, [Operation] [tinyint] NULL, [Status2] [varchar](2) NULL, [Status1] [varchar](2) NULL, [status_desc] [varchar](200) NULL, [bank_res_code] [varchar](8) NULL, [bank_res_desc] [varchar](200) NULL, [RF1] [int] NULL, [RF2] [int] NULL, [RF3] [int] NULL, [RF4] [int] NULL, [RF5] [int] NULL, [RF6] [int] NULL, [RF7] [int] NULL, [RF8] [int] NULL, [RF9] [int] NULL, [RF10] [int] NULL, [RF11] [int] NULL, [JCode1] [varchar](10) NULL, [JCode2] [varchar](10) NULL, [JCode3] [varchar](10) NULL, [VAccountNumber] [varchar](50) NULL, [request_date_WBT02] [varchar](8) NULL, [tr_code_WBT02] [varchar](8) NULL, [tr_key_WBT02] [varchar](5) NULL, [seq_WBT02] [varchar](5) NULL, [InsertTime] [datetime] NULL ) " & vbCrLf
        'StudentUploadDatabaseGet.asp
        StrSql = "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(20) NOT NULL, StudentNumber varchar(20) NOT NULL, StudentName varchar(20) NOT NULL, Ranking int NOT NULL, Score varchar(20) NULL, Degree1 tinyint NULL, Result1 varchar(2) NULL, BankName varchar(50) NULL, AccountNumber varchar(50) NULL, AccountName varchar(50) NULL, Address varchar(255) NULL, Tel1 varchar(20) NULL, Tel2 varchar(20) NULL, Tel3 varchar(20) NULL, Tel4 varchar(20) NULL, Tel5 varchar(20) NULL, Citizen1 char(6) NULL, Citizen2 char(7) NULL, ETC1 varchar(100) NULL, ETC2 varchar(100) NULL, ETC3 varchar(100) NULL, Myear varchar(20) NULL, ETC4 varchar(20) NULL, ETC5 varchar(20) NULL, ETC6 varchar(20) NULL, ETC7 varchar(20) NULL, ETC8 varchar(20) NULL, ETC9 varchar(20) NULL, ETC10 varchar(50) NULL, Memo text NULL, Updated varchar(1) NULL, RF1 int NULL,RF2 int NULL,RF3 int NULL,RF4 int NULL,RF5 int NULL,RF6 int NULL,RF7 int NULL,RF8 int NULL,RF9 int NULL,RF10 int NULL,RF11 int NULL, JCode1 varchar(10) NULL, JCode2 varchar(10) NULL, JCode3 varchar(10) NULL, VAccountNumber varchar(15) NULL, InsertTime datetime NOT NULL) " & vbCrLf
        dbcon.Execute StrSql
        'StrSql = "INSERT INTO [##StudentTable](SubjectCode, StudentNumber, StudentName, Ranking, Score, BankName, AccountNumber, AccountName, Address, Tel1, Tel2, Tel3, Tel4, Tel5, Citizen1, Citizen2, ETC1, ETC2, ETC3, InsertTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate())"
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
'        oCmd.Parameters.Append oCmd.CreateParameter("Address", adVarChar, adParamInput, 255 )
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
        oCmd.Parameters.Append oCmd.CreateParameter("Address", adVarChar, adParamInput, 255 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel1", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel2", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel3", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel4", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel5", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen1", adVarChar, adParamInput, 6 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen2", adVarChar, adParamInput, 7 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC1", adVarChar, adParamInput, 100 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC2", adVarChar, adParamInput, 100 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC3", adVarChar, adParamInput, 100 )
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
        do until oRs.eof
            '쿼리작성
            i = i + 1
            '첫 주석 패스
            If oRS(0) <> "모집단위코드" Then
'                OCmd.Parameters("SubjectCode") = oRS(0)
'                oCmd.Parameters("StudentNumber") = oRS(1)
'                oCmd.Parameters("StudentName") = oRS(2)
'                oCmd.Parameters("Ranking") = oRS(3)
'                oCmd.Parameters("Score") = oRS(4)
'                oCmd.Parameters("BankName") = oRS(5)
'                oCmd.Parameters("AccountNumber") = oRS(6)
'                oCmd.Parameters("AccountName") = oRS(7)
'                oCmd.Parameters("Address") = oRS(8)
'                oCmd.Parameters("Tel1") = oRS(9)
'                oCmd.Parameters("Tel2") = oRS(10)
'                oCmd.Parameters("Tel3") = oRS(11)
'                oCmd.Parameters("Tel4") = oRS(12)
'                oCmd.Parameters("Tel5") = oRS(13)
'                oCmd.Parameters("Citizen1") = oRS(14)
'                oCmd.Parameters("Citizen2") = oRS(15)
'                oCmd.Parameters("ETC1") = oRS(16)
'                oCmd.Parameters("ETC2") = oRS(17)
'                oCmd.Parameters("ETC3") = oRS(18)
                oCmd.Parameters("SubjectCode")     = trim(oRS(0))
                oCmd.Parameters("StudentNumber")   = trim(oRS(1))
                oCmd.Parameters("StudentName")     = trim(oRS(2))
                oCmd.Parameters("Ranking")         = trim(oRS(3))
                oCmd.Parameters("Score")           = trim(oRS(4))
                oCmd.Parameters("Degree1")         = trim(oRS(5))
                oCmd.Parameters("Result1")         = trim(oRS(6))
                oCmd.Parameters("BankName")        = trim(oRS(7))
                oCmd.Parameters("AccountNumber")   = trim(oRS(8))
                oCmd.Parameters("AccountName")     = trim(oRS(9))
                oCmd.Parameters("Address")         = trim(oRS(10))
                oCmd.Parameters("Tel1")     = trim(oRS(11))
                oCmd.Parameters("Tel2")     = trim(oRS(12))
                oCmd.Parameters("Tel3")     = trim(oRS(13))
                oCmd.Parameters("Tel4")     = trim(oRS(14))
                oCmd.Parameters("Tel5")     = trim(oRS(15))
                oCmd.Parameters("Citizen1")         = trim(oRS(16))
                oCmd.Parameters("Citizen2")         = trim(oRS(17))
                oCmd.Parameters("ETC1")             = trim(oRS(18))
                oCmd.Parameters("ETC2")             = trim(oRS(19))
                oCmd.Parameters("ETC3")             = trim(oRS(20))
                oCmd.Parameters("MYear")         = trim(oRS(21))
                oCmd.Parameters("RF1")         = trim(oRS(22))
                oCmd.Parameters("RF2")         = trim(oRS(23))
                oCmd.Parameters("RF3")         = trim(oRS(24))
                oCmd.Parameters("RF4")         = trim(oRS(25))
                oCmd.Parameters("RF5")         = trim(oRS(26))
                oCmd.Parameters("RF6")     = trim(oRS(27))
                oCmd.Parameters("RF7")     = trim(oRS(28))
                oCmd.Parameters("RF8")     = trim(oRS(29))
                oCmd.Parameters("RF9")     = trim(oRS(30))
                oCmd.Parameters("RF10")         = trim(oRS(31))
                oCmd.Parameters("RF11")         = trim(oRS(32))
                oCmd.Parameters("JCode1")         = trim(oRS(33))
                oCmd.Parameters("JCode2")         = trim(oRS(34))
                oCmd.Parameters("JCode3")         = trim(oRS(35))
                oCmd.Parameters("VAccountNumber")= trim(oRS(36))
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
                response.write "<cell></cell>"
                response.write "</row>" & vbCrLf
                Exit Do
                Else
'                response.write "<row id=''>"
'                response.write "<cell>" & oRS(0)  & "</cell>"
'                response.write "<cell>" & oRS(1)  & "</cell>"
'                response.write "<cell>" & oRS(2)  & "</cell>"
'                response.write "<cell>" & oRS(3)  & "</cell>"
'                response.write "<cell>" & oRS(4)  & "</cell>"
'                response.write "<cell>" & oRS(5)  & "</cell>"
'                response.write "<cell>" & oRS(6)  & "</cell>"
'                response.write "<cell>" & oRS(7)  & "</cell>"
'                response.write "<cell>" & oRS(9)  & "</cell>"
'                response.write "<cell>" & oRS(10) & "</cell>"
'                response.write "<cell>" & oRS(11) & "</cell>"
'                response.write "<cell>" & oRS(12) & "</cell>"
'                response.write "<cell>" & oRS(13) & "</cell>"
'                response.write "<cell>" & oRS(14) & "</cell>"
'                response.write "<cell>" & oRS(15) & "</cell>"
'                response.write "<cell>" & oRS(16) & "</cell>"
'                response.write "<cell>" & oRS(17) & "</cell>"
'                response.write "<cell>" & oRS(18) & "</cell>"
'                response.write "<cell>" & Date() & " " & Time() & "</cell>"
'                response.write "</row>" & vbCrLf
                response.write "<row id=''>"
                response.write "<cell>" & trim(oRS(0))  & "</cell>"
                response.write "<cell>" & trim(oRS(1))  & "</cell>"
                response.write "<cell>" & trim(oRS(2))  & "</cell>"
                response.write "<cell>" & trim(oRS(3))  & "</cell>"
                response.write "<cell>" & trim(oRS(4))  & "</cell>"
                response.write "<cell>" & trim(oRS(5))  & "</cell>"
                response.write "<cell>" & trim(oRS(6))  & "</cell>"
                response.write "<cell>" & trim(oRS(7))  & "</cell>"
                response.write "<cell>" & trim(oRS(8))  & "</cell>"
                response.write "<cell>" & trim(oRS(9))  & "</cell>"
                response.write "<cell>" & trim(oRS(10)) & "</cell>"
                response.write "<cell>" & trim(oRS(11)) & "</cell>"
                response.write "<cell>" & trim(oRS(12)) & "</cell>"
                response.write "<cell>" & trim(oRS(13)) & "</cell>"
                response.write "<cell>" & trim(oRS(14)) & "</cell>"
                response.write "<cell>" & trim(oRS(15)) & "</cell>"
                response.write "<cell>" & trim(oRS(16)) & "</cell>"
                response.write "<cell>" & trim(oRS(17)) & "</cell>"
                response.write "<cell>" & trim(oRS(18)) & "</cell>"
                response.write "<cell>" & trim(oRS(19)) & "</cell>"
                response.write "<cell>" & trim(oRS(20)) & "</cell>"
                response.write "<cell>" & trim(oRS(21)) & "</cell>"
                response.write "<cell>" & trim(oRS(22)) & "</cell>"'1	입학금
                response.write "<cell>" & trim(oRS(23)) & "</cell>"'2	수업료
                response.write "<cell>" & trim(oRS(24)) & "</cell>"'3	소계
                response.write "<cell>" & trim(oRS(25)) & "</cell>"'4	학생회
				response.write "<cell>" & trim(oRS(28)) & "</cell>"'7	오티비
				response.write "<cell>" & trim(oRS(31)) & "</cell>"'10	소계
				response.write "<cell>" & trim(oRS(29)) & "</cell>"'8	장학감면
				response.write "<cell>" & trim(oRS(27)) & "</cell>"'6	기납입액
                response.write "<cell>" & trim(oRS(26)) & "</cell>"'5	실납입액
                response.write "<cell>" & trim(oRS(30)) & "</cell>"'9	예치금
                response.write "<cell>" & trim(oRS(32)) & "</cell>"'11	총계
                response.write "<cell>" & trim(oRS(33)) & "</cell>"
                response.write "<cell>" & trim(oRS(34)) & "</cell>"
                response.write "<cell>" & trim(oRS(35)) & "</cell>"
                response.write "<cell>" & trim(oRS(36)) & "</cell>"
                response.write "<cell>" & Date()  & "</cell>"
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
        StrSql = "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(20) NOT NULL, StudentNumber varchar(20) NOT NULL, StudentName varchar(20) NOT NULL, Ranking int NOT NULL, Score varchar(20) NULL, Degree1 tinyint NULL, Result1 varchar(2) NULL, BankName varchar(50) NULL, AccountNumber varchar(50) NULL, AccountName varchar(50) NULL, Address varchar(255) NULL, Tel1 varchar(20) NULL, Tel2 varchar(20) NULL, Tel3 varchar(20) NULL, Tel4 varchar(20) NULL, Tel5 varchar(20) NULL, Citizen1 char(6) NULL, Citizen2 char(7) NULL, ETC1 varchar(100) NULL, ETC2 varchar(100) NULL, ETC3 varchar(100) NULL, Myear varchar(20) NULL, ETC4 varchar(20) NULL, ETC5 varchar(20) NULL, ETC6 varchar(20) NULL, ETC7 varchar(20) NULL, ETC8 varchar(20) NULL, ETC9 varchar(20) NULL, ETC10 varchar(50) NULL, Memo text NULL, Updated varchar(1) NULL, RF1 int NULL,RF2 int NULL,RF3 int NULL,RF4 int NULL,RF5 int NULL,RF6 int NULL,RF7 int NULL,RF8 int NULL,RF9 int NULL,RF10 int NULL,RF11 int NULL, JCode1 varchar(10) NULL, JCode2 varchar(10) NULL, JCode3 varchar(10) NULL, VAccountNumber varchar(15) NULL, InsertTime datetime NOT NULL) " & vbCrLf
        Dbcon.Execute(StrSql)
        StrSql = "INSERT INTO [##StudentTable](SubjectCode, StudentNumber, StudentName, Ranking, Score, Degree1, Result1, BankName, AccountNumber, AccountName, Address, Tel1, Tel2, Tel3, Tel4, Tel5, Citizen1, Citizen2, ETC1, ETC2, ETC3, MYear, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, JCode1, JCode2, JCode3, VAccountNumber, InsertTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
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
        oCmd.Parameters.Append oCmd.CreateParameter("Address", adVarChar, adParamInput, 255 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel1", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel2", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel3", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel4", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Tel5", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen1", adVarChar, adParamInput, 6 )
        oCmd.Parameters.Append oCmd.CreateParameter("Citizen2", adVarChar, adParamInput, 7 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC1", adVarChar, adParamInput, 100 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC2", adVarChar, adParamInput, 100 )
        oCmd.Parameters.Append oCmd.CreateParameter("ETC3", adVarChar, adParamInput, 100 )
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
            If trim(aColumn(0)) <> "SubjectCode" And trim(aColumn(0)) <> "모집단위코드"  And trim(aColumn(0)) <> "일련번호" And trim(aColumn(0)) <> "일련번호 수험번호 이름 순위 점수 입학금 지원자 지원자집 연락처1 연락처2 연락처3 주민번호6자리 주민번호뒷자리 합격전형코드" Then

				If Ubound(aColumn, 1) = 14 Then

					'oCmd.Parameters("SubjectCode")     = trim(aColumn(0))
					'oCmd.Parameters("StudentNumber")   = trim(aColumn(1))
					'oCmd.Parameters("StudentName")     = trim(aColumn(2))
					'oCmd.Parameters("Ranking")         = trim(aColumn(3))
					'oCmd.Parameters("Score")           = trim(aColumn(4))
					'oCmd.Parameters("VAccountNumber")         = trim(aColumn(5))
					'oCmd.Parameters("Tel1")         = trim(aColumn(6))
					'oCmd.Parameters("Tel2")        = trim(aColumn(7))
					'oCmd.Parameters("Tel3")   = trim(aColumn(8))
					'oCmd.Parameters("Tel4")     = trim(aColumn(9))
					'oCmd.Parameters("Tel5")         = trim(aColumn(10))
					'oCmd.Parameters("Citizen1")     = trim(aColumn(11))
					'oCmd.Parameters("Citizen2")     = trim(aColumn(12))
					'oCmd.Parameters("ETC1")     = trim(aColumn(13))
					'oCmd.Parameters("ETC2")     = trim(aColumn(14))
					'oCmd.Parameters("ETC3")     = trim(aColumn(15))

					oCmd.Parameters("SubjectCode")     = trim(aColumn(0))
					oCmd.Parameters("StudentNumber")   = trim(aColumn(1))
					oCmd.Parameters("StudentName")     = trim(aColumn(2))
					oCmd.Parameters("Ranking")         = trim(aColumn(3))
					oCmd.Parameters("Score")           = trim(aColumn(4))
					oCmd.Parameters("VAccountNumber")         = ""
					oCmd.Parameters("Tel1")         = trim(aColumn(6))
					oCmd.Parameters("Tel2")        = trim(aColumn(7))
					oCmd.Parameters("Tel3")   = trim(aColumn(8))
					oCmd.Parameters("Tel4")     = trim(aColumn(9))
					oCmd.Parameters("Tel5")         = trim(aColumn(10))
					oCmd.Parameters("Citizen1")     = trim(aColumn(11))
					oCmd.Parameters("Citizen2")     = trim(aColumn(12))
					oCmd.Parameters("ETC1")     = trim(aColumn(13))
					oCmd.Parameters("ETC2")     = trim(aColumn(5))
					'oCmd.Parameters("ETC3")     = trim(aColumn(15))
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
					response.write "</row>" & vbCrLf
					Exit Do
					Else
					response.write "<row id=''>"
					response.write "<cell>" & trim(aColumn(0))  & "</cell>"
					response.write "<cell>" & trim(aColumn(1))  & "</cell>"
					response.write "<cell>" & trim(aColumn(2))  & "</cell>"
					response.write "<cell>" & trim(aColumn(3))  & "</cell>"
					response.write "<cell>" & trim(aColumn(4))  & "</cell>"
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
					response.write "<cell>" & trim(aColumn(5))  & "</cell>"
					response.write "<cell>" & Date()  & "</cell>"
					response.write "</row>" & vbCrLf
					End If

				Else
					oCmd.Parameters("SubjectCode")     = trim(aColumn(0))
					oCmd.Parameters("StudentNumber")   = trim(aColumn(1))
					oCmd.Parameters("StudentName")     = trim(aColumn(2))
					oCmd.Parameters("Ranking")         = trim(aColumn(3))
					oCmd.Parameters("Score")           = trim(aColumn(4))
					oCmd.Parameters("Degree1")         = 0
					oCmd.Parameters("Result1")         = ""
					oCmd.Parameters("BankName")        = ""
					oCmd.Parameters("AccountNumber")   = ""
					oCmd.Parameters("AccountName")     = ""
					oCmd.Parameters("Address")         = ""
					oCmd.Parameters("Tel1")     = trim(aColumn(6))
					oCmd.Parameters("Tel2")     = trim(aColumn(7))
					oCmd.Parameters("Tel3")     = trim(aColumn(8))
					oCmd.Parameters("Tel4")     = trim(aColumn(9))
					oCmd.Parameters("Tel5")     = trim(aColumn(10))
					oCmd.Parameters("Citizen1")         = trim(aColumn(11))
					oCmd.Parameters("Citizen2")         = trim(aColumn(12))
					oCmd.Parameters("ETC1")             = trim(aColumn(13))
					oCmd.Parameters("ETC2")             = ""
					oCmd.Parameters("ETC3")             = ""
					oCmd.Parameters("MYear")         = ""
					oCmd.Parameters("RF1")         = 0
					oCmd.Parameters("RF2")         = 0
					oCmd.Parameters("RF3")         = 0
					oCmd.Parameters("RF4")         = 0
					oCmd.Parameters("RF5")         = 0
					oCmd.Parameters("RF6")     = 0
					oCmd.Parameters("RF7")     = 0
					oCmd.Parameters("RF8")     = 0
					oCmd.Parameters("RF9")     = 0
					oCmd.Parameters("RF10")         = 0
					oCmd.Parameters("RF11")         = trim(aColumn(5))
					oCmd.Parameters("JCode1")         = ""
					oCmd.Parameters("JCode2")         = ""
					oCmd.Parameters("JCode3")         = ""
					oCmd.Parameters("VAccountNumber")= ""
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
					response.write "</row>" & vbCrLf
					Exit Do
					Else
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
					response.write "<cell>" & Date()  & "</cell>"
					response.write "</row>" & vbCrLf
					End If

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