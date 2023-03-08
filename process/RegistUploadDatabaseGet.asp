<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<!-- #include virtual = "/include/adovbs.inc.asp"-->
<%
server.scripttimeout = 400
Dim FormDivision0, FormDegree
FormDivision0   = getParameter(Request.Querystring("FormDivision0"), "")
FormDivision0   = Replace(FormDivision0, "수시모집2 2", "수시모집2+2" )
FormDegree      = getParameter(Request.Querystring("FormDegree"), "")
'response.write FormDivision0
'response.write FormDegree
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
    StrSql = "IF OBJECT_ID('tempdb..##RegistRecord') IS NOT NULL drop table ##RegistRecord CREATE TABLE [##RegistRecord]( [IDX] [int] IDENTITY(1,1) NOT NULL, SubjectCode varchar(20) NOT NULL, StudentNumber varchar(20) NOT NULL, Degree tinyint NULL, Result tinyint NULL, MemberID varchar(20) NOT NULL, InsertTime datetime NOT NULL) " & vbCrLf
    Dbcon.Execute(StrSql)
    Set Rs = Server.CreateObject("ADODB.Recordset")
    StrSql =                   ""
    StrSql = StrSql & vbCrLf & "select t3.SubjectCode, t3.StudentNumber, t3.Degree1, t3.Result1"
	StrSql = StrSql & vbCrLf & "from openquery(SCHOOLDB,'SELECT * FROM METIS.LINKTABLE3') t3"
    StrSql = StrSql & vbCrLf & "join openquery(SCHOOLDB,'SELECT * FROM METIS.LINKTABLE1') cct2"
    StrSql = StrSql & vbCrLf & "on t3.SubjectCode = cct2.SubjectCode"
    StrSql = StrSql & vbCrLf & "where cct2.Division0 = '" & FormDivision0 & "'"
    StrSql = StrSql & vbCrLf & "and t3.Degree1 = '" & FormDegree & "'"
    'Response.Write StrSql
    Rs.Open StrSql, DbconO
    If Not Rs.EOF Then
        MaxLine = Rs.RecordCount
        response.write "<rows id='0' totalCount='" & MaxLine & "'>" & vbCrLf
        StrSql = "INSERT INTO [##RegistRecord](SubjectCode, StudentNumber, Degree, Result, MemberID, InsertTime) VALUES ( ?, ?, ?, ?, ?, getdate())"
        oCmd.CommandText = StrSql
        oCmd.Parameters.Append oCmd.CreateParameter("SubjectCode", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("StudentNumber", adVarChar, adParamInput, 20 )
        oCmd.Parameters.Append oCmd.CreateParameter("Degree", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("Result", adTinyInt, adParamInput, 2 )
        oCmd.Parameters.Append oCmd.CreateParameter("MemberID", adVarChar, adParamInput, 20 )
        Dim Result
        do until Rs.EOF
            i = i + 1
            'Result = cInt(CastReverseResult(Rs(3)))
            'Result = 2
			Result = Rs(3)
            oCmd.Parameters("SubjectCode")  = trim(Rs(0))
            oCmd.Parameters("StudentNumber")= trim(Rs(1))
            oCmd.Parameters("Degree")       = trim(Rs(2))
            oCmd.Parameters("Result")       = trim(Result)
            oCmd.Parameters("MemberID")     = Session("MemberID")
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
                response.write "</row>" & vbCrLf
                Exit Do
            Else
                response.write "<row id=''>"
                response.write "<cell>" & trim(Rs(0))  & "</cell>"
                response.write "<cell>" & trim(Rs(1))  & "</cell>"
                response.write "<cell>" & trim(Rs(2))  & "</cell>"
                response.write "<cell>" & trim(Rs(3))  & "</cell>"
                response.write "<cell>" & Date() & " " & Time()  & "</cell>"
                response.write "</row>" & vbCrLf
            End If
            Rs.MoveNext
            'If i Mod 1000 = 999 Then Response.Flush
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
