<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<!-- #include virtual = "/include/adovbs.inc.asp"-->
<%
server.scripttimeout = 400
Dim FormDivision0
FormDivision0   = getParameter(Request.Querystring("FormDivision0"), "")
FormDivision0 = Replace(FormDivision0, "수시모집2 2", "수시모집2+2" )
'response.write FormDivision0
'response.end
LoadTxt()
Function LoadTxt()
    Dim Dbcon
    Set Dbcon = createobject("ADODB.connection")
    Dbcon.open DBConnectionString
    'Dbcon.BeginTrans
    dim oCmd
    set oCmd = Server.CreateObject("ADODB.Command")
    oCmd.ActiveConnection = Dbcon
    oCmd.CommandType = 1
    Response.ContentType = "text/xml"
    response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf
    Dim StrSql, Rs, MaxLine, i
    Dim DbconO
    Set DbconO = Server.CreateObject("ADODB.Connection")
    DbconO.Open DBConnectionString
    StrSql =                   "IF OBJECT_ID('tempdb..##StudentTable') IS NOT NULL drop table ##StudentTable CREATE TABLE [##StudentTable]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(30) NOT NULL, StudentNumber varchar(20) NOT NULL, StudentName varchar(20) NOT NULL, Ranking int NOT NULL, Score varchar(20) NULL, Degree1 varchar(2) NULL, Result1 varchar(2) NULL, BankName varchar(50) NULL, AccountNumber varchar(50) NULL, AccountName varchar(50) NULL, Address varchar(255) NULL, Tel1 varchar(20) NULL, Tel2 varchar(20) NULL, Tel3 varchar(20) NULL, Tel4 varchar(20) NULL, Tel5 varchar(20) NULL, Citizen1 char(6) NULL, Citizen2 char(7) NULL, ETC1 varchar(50) NULL, ETC2 varchar(50) NULL, ETC3 varchar(50) NULL, Myear varchar(20) NULL, ETC4 varchar(20) NULL, ETC5 varchar(20) NULL, ETC6 varchar(20) NULL, ETC7 varchar(20) NULL, ETC8 varchar(20) NULL, ETC9 varchar(20) NULL, ETC10 varchar(50) NULL, Memo text NULL, Updated varchar(1) NULL, RF1 int NULL,RF2 int NULL,RF3 int NULL,RF4 int NULL,RF5 int NULL,RF6 int NULL,RF7 int NULL,RF8 int NULL,RF9 int NULL,RF10 int NULL,RF11 int NULL, JCode1 varchar(10) NULL, JCode2 varchar(10) NULL, JCode3 varchar(10) NULL, VAccountNumber varchar(50) NULL, InsertTime datetime NOT NULL) " & vbCrLf
	StrSql = StrSql & vbCrLf & "IF OBJECT_ID('tempdb..##LinkTable2') IS NOT NULL drop table ##LinkTable2 select * into ##LinkTable2 from openQuery(SCHOOLDB, 'SELECT * FROM METIS.LINKTABLE2') "
    Dbcon.Execute(StrSql)
    Set Rs = Server.CreateObject("ADODB.Recordset")
    StrSql =                   ""
    StrSql = StrSql & vbCrLf & "select et2.SubjectCode, et2.StudentNumber, et2.StudentName, isnull(et2.Ranking,0) Ranking, et2.Score, et2.Degree1, et2.Result1, et2.BankName, et2.AccountNumber, et2.AccountName, et2.Address, et2.Tel1, et2.Tel2, et2.Tel3, et2.Tel4, et2.Tel5, et2.Citizen1, et2.Citizen2, et2.ETC1, et2.ETC2, et2.ETC3, et2.Myear, et2.RF1, et2.RF2, et2.RF3, et2.RF4, et2.RF5, et2.RF6, et2.RF7, et2.RF8, et2.RF9, et2.RF10, et2.RF11, et2.JCode1, et2.JCode2, et2.JCode3, VIR_BANK_NUM"
    'StrSql = StrSql & vbCrLf & "from BWC.METIS.dbo.LinkTable2 et2"
    'StrSql = StrSql & vbCrLf & "join BWC.METIS.dbo.LinkTable1 cct2"
	StrSql = StrSql & vbCrLf & "from openquery(SCHOOLDB,'SELECT * FROM METIS.LINKTABLE2') et2"
	'StrSql = StrSql & vbCrLf & "from ##LinkTable2 et2"
    'StrSql = StrSql & vbCrLf & "join openquery(SCHOOLDB,'SELECT * FROM METIS.LINKTABLE1') cct2"
	StrSql = StrSql & vbCrLf & "join SubjectTable cct2"
    StrSql = StrSql & vbCrLf & "on et2.SubjectCode = cct2.SubjectCode"
    StrSql = StrSql & vbCrLf & "left outer join StudentTable et"
    StrSql = StrSql & vbCrLf & "on et.StudentNumber=et2.StudentNumber"
    StrSql = StrSql & vbCrLf & "where et.StudentNumber is null"
    StrSql = StrSql & vbCrLf & "and Division0 = '" & FormDivision0 & "'" & vbCrLf
    StrSql = StrSql & vbCrLf & "order by et2.idx" & vbCrLf



    Rs.Open StrSql, DbconO, 3, 1, 1
    If Not Rs.EOF Then
        MaxLine = Rs.RecordCount
        response.write "<rows id='0' totalCount='" & MaxLine & "'>" & vbCrLf
        StrSql = "INSERT INTO [##StudentTable](SubjectCode, StudentNumber, StudentName, Ranking, Score, Degree1, Result1, BankName, AccountNumber, AccountName, Address, Tel1, Tel2, Tel3, Tel4, Tel5, Citizen1, Citizen2, ETC1, ETC2, ETC3, MYear, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, JCode1, JCode2, JCode3, VAccountNumber, InsertTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 30 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentName", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Ranking", adInteger, adParamInput, 4 )
        oCmd.Parameters.Append oCmd.CreateParameter("Score", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Degree1", adVarchar, adParamInput, 2 )
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
        oCmd.Parameters.Append oCmd.CreateParameter("VAccountNumber", adVarChar, adParamInput, 50 )
        Dim Address
        do until Rs.EOF
            i = i + 1
            Address = Replace(getParameter(Rs(10), ""),"&","-")
                oCmd.Parameters("SubjectCode")     = trim(Rs(0))
                oCmd.Parameters("StudentNumber")= trim(Rs(1))
                oCmd.Parameters("StudentName")     = trim(Rs(2))
                oCmd.Parameters("Ranking")         = trim(Rs(3))
                oCmd.Parameters("Score")         = trim(Rs(4))
                oCmd.Parameters("Degree1")         = trim(Rs(5))
                oCmd.Parameters("Result1")         = trim(Rs(6))
                oCmd.Parameters("BankName")         = trim(Rs(7))
                oCmd.Parameters("AccountNumber") = trim(Rs(8))
                oCmd.Parameters("AccountName")     = trim(Rs(9))
                oCmd.Parameters("Address")         = Address
                oCmd.Parameters("Tel1")     = trim(Rs(11))
                oCmd.Parameters("Tel2")     = trim(Rs(12))
                oCmd.Parameters("Tel3")     = trim(Rs(13))
                oCmd.Parameters("Tel4")     = trim(Rs(14))
                oCmd.Parameters("Tel5")     = trim(Rs(15))
                oCmd.Parameters("Citizen1")         = trim(Rs(16))
                oCmd.Parameters("Citizen2")         = trim(Rs(17))
                oCmd.Parameters("ETC1")             = trim(Rs(18))
                oCmd.Parameters("ETC2")             = trim(Rs(19))
                oCmd.Parameters("ETC3")             = trim(Rs(20))
                oCmd.Parameters("MYear")         = trim(Rs(21))
                oCmd.Parameters("RF1")         = trim(Rs(22))
                oCmd.Parameters("RF2")         = trim(Rs(23))
                oCmd.Parameters("RF3")         = trim(Rs(24))
                oCmd.Parameters("RF4")         = trim(Rs(25))
                oCmd.Parameters("RF5")         = trim(Rs(26))
                oCmd.Parameters("RF6")     = trim(Rs(27))
                oCmd.Parameters("RF7")     = trim(Rs(28))
                oCmd.Parameters("RF8")     = trim(Rs(29))
                oCmd.Parameters("RF9")     = trim(Rs(30))
                oCmd.Parameters("RF10")         = trim(Rs(31))
                oCmd.Parameters("RF11")         = trim(Rs(32))
                oCmd.Parameters("JCode1")         = trim(Rs(33))
                oCmd.Parameters("JCode2")         = trim(Rs(34))
                oCmd.Parameters("JCode3")         = trim(Rs(35))
                oCmd.Parameters("VAccountNumber")= trim(Rs(36))
                'print_StrSql(oCmd)
                'response.end
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
                'response.write "<cell></cell>"
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
                response.write "<cell>" & trim(Rs(0))  & "</cell>"
                response.write "<cell>" & trim(Rs(1))  & "</cell>"
                response.write "<cell>" & trim(Rs(2))  & "</cell>"
                response.write "<cell>" & trim(Rs(3))  & "</cell>"
                response.write "<cell>" & trim(Rs(4))  & "</cell>"
                response.write "<cell>" & trim(Rs(5))  & "</cell>"
                response.write "<cell>" & trim(Rs(6))  & "</cell>"
                response.write "<cell>" & trim(Rs(7))  & "</cell>"
                response.write "<cell>" & trim(Rs(8))  & "</cell>"
                response.write "<cell>" & trim(Rs(9))  & "</cell>"
                response.write "<cell>" & Address & "</cell>"
                response.write "<cell>" & trim(Rs(11)) & "</cell>"
                response.write "<cell>" & trim(Rs(12)) & "</cell>"
                response.write "<cell>" & trim(Rs(13)) & "</cell>"
                response.write "<cell>" & trim(Rs(14)) & "</cell>"
                response.write "<cell>" & trim(Rs(15)) & "</cell>"
                response.write "<cell>" & trim(Rs(16)) & "</cell>"
                response.write "<cell>" & trim(Rs(17)) & "</cell>"
                response.write "<cell>" & trim(Rs(18)) & "</cell>"
                response.write "<cell>" & trim(Rs(19)) & "</cell>"
                response.write "<cell>" & trim(Rs(20)) & "</cell>"
                response.write "<cell>" & trim(Rs(21)) & "</cell>"
                response.write "<cell>" & trim(Rs(22)) & "</cell>"'1
                response.write "<cell>" & trim(Rs(23)) & "</cell>"'2
                response.write "<cell>" & trim(Rs(24)) & "</cell>"'3
                response.write "<cell>" & trim(Rs(25)) & "</cell>"'4
                response.write "<cell>" & trim(Rs(28)) & "</cell>"'b
                response.write "<cell>" & trim(Rs(31)) & "</cell>"'7
                response.write "<cell>" & trim(Rs(29)) & "</cell>"'c
                response.write "<cell>" & trim(Rs(27)) & "</cell>"'a
                response.write "<cell>" & trim(Rs(26)) & "</cell>"'5
                response.write "<cell>" & trim(Rs(30)) & "</cell>"'d
                response.write "<cell>" & trim(Rs(32)) & "</cell>"'8
                response.write "<cell>" & trim(Rs(33)) & "</cell>"
                response.write "<cell>" & trim(Rs(34)) & "</cell>"
                response.write "<cell>" & trim(Rs(35)) & "</cell>"
                response.write "<cell>" & trim(Rs(36)) & "</cell>"
                response.write "<cell>" & Date()  & "</cell>"
                response.write "</row>" & vbCrLf
                End If
            Rs.MoveNext
            If i Mod 1000 = 999 Then Response.Flush
        loop
    Else
        response.write "<rows id='0' totalCount='0'>" & vbCrLf
    End If
    response.write "</rows>" & vbCrLf
    Rs.Close
    Set Rs = Nothing
    DbconO.Close
    Set DbconO = Nothing
    set oCmd = Nothing
    Dbcon.close
    set Dbcon = nothing
End Function
'--------------------------------------------------------------------------------------------------
'주의: 커맨드 객체 파라미터값 필수
Sub print_ado_result(objcomd)
    Dim StrSql, objrs, start, param, findpos, cntField, objfield
    StrSql = objComd.CommandText
    start = 1
    For Each param In objComd.Parameters
        findpos = InStr(start,"?",StrSql)
        start = findpos + 1
        StrSql = Replace(StrSql,"?","'"&param.Value&"'",start,1)
    Next
    response.write StrSql
    Set objRs = objcomd.Execute
    Set objcomd = Nothing
    Dim cntRecord%>
    <table cellpadding="5" cellspacing="0" border="1">
        <tr bgcolor="#DEDEDE">
        <%cntField = 0
        For Each objField In objrs.Fields%>
        <td><%=objField.Name%></td>
            <%cntField = cntField + 1
        Next%>
        </tr>
        <%cntRecord = 0
        while Not objrs.EOF %>
            <tr>
                <%for i=0 to cntField-1%>
                    <td>&nbsp;<%=objrs(i).Value%></td>
                <%next
                cntRecord = cntRecord + 1
                objrs.MoveNext%>
            </tr>
        <%wend%>
    </table>
    총 <%=cntRecord%>개의 결과가 반환되었습니다.
    <%objrs.close
    Set objrs = Nothing
End Sub
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
