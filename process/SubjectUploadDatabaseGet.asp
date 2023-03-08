<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<%
server.scripttimeout = 400
Dim FormDivision0
FormDivision0   = getParameter(Request.Querystring("FormDivision0"), "")
FormDivision0 = Replace(FormDivision0, "수시모집2 2", "수시모집2+2" )
'response.write FormDivision0
'response.end
LoadTxt()
Function LoadTxt()
    Response.ContentType = "text/xml"
    response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf
    Dim StrSql, Rs, MaxLine, i
    StrSql = "truncate table SubjectTableTemp " & vbCrLf
    Dbcon.Execute(StrSql)
    Set Rs = Server.CreateObject("ADODB.Recordset")
	StrSql =                   "IF OBJECT_ID('tempdb..##LinkTable1') IS NOT NULL drop table ##LinkTable1 select * into ##LinkTable1 from openQuery(SCHOOLDB, 'SELECT * FROM METIS.LINKTABLE1') "
	Dbcon.Execute StrSql
	StrSql =                   ""
    StrSql = StrSql & vbCrLf & "select T1.SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, Myear "
	StrSql = StrSql & vbCrLf & "from ##LinkTable1 T1" '// 모집단위
    StrSql = StrSql & vbCrLf & "left outer join ("
    StrSql = StrSql & vbCrLf & "    select distinct SubjectCode"
    StrSql = StrSql & vbCrLf & "    from SubjectTable"
    StrSql = StrSql & vbCrLf & ") CCT"
    StrSql = StrSql & vbCrLf & "on CCT.SubjectCode = T1.SubjectCode "
    StrSql = StrSql & vbCrLf & "where Division0 = '" & FormDivision0 & "'"
    StrSql = StrSql & vbCrLf & "and CCT.SubjectCode is null" & vbCrLf
    StrSql = StrSql & vbCrLf & "order by idx" & vbCrLf
    Rs.Open StrSql, Dbcon, 1, 1
    If Not Rs.EOF Then
        MaxLine = Rs.RecordCount
        response.write "<rows id='0' totalCount='" & MaxLine & "'>" & vbCrLf
        Dim SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11
        do until Rs.EOF
            i = i + 1
                StrSql = "INSERT INTO SubjectTableTemp(SubjectCode, Division0, Subject, Division1, Division2, Division3, Quorum, Quorum2, RF1, RF2, RF3, RF4, RF5, RF6, RF7, RF8, RF9, RF10, RF11, Myear, InsertTime) VALUES (" & vbCrLf
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(0))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(1))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(2))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(3))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(4))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(5))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(6))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(7))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(8))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(9))  & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(10)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(11)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(12)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(13)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(14)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(15)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(16)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(17)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(18)) & "', "
                StrSql = StrSql & vbCrLf & "'" & trim(Rs(19)) & "', "
                StrSql = StrSql & vbCrLf & "getdate() ) " & vbCrLf
                'response.write StrSql
                'response.end
                if Err.Description = "" Then
                Dbcon.Execute(StrSql)
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
                response.write "<cell>" & trim(Rs(10)) & "</cell>"
                response.write "<cell>" & trim(Rs(11)) & "</cell>"
                response.write "<cell>" & trim(Rs(14)) & "</cell>"
                response.write "<cell>" & trim(Rs(17)) & "</cell>"
                response.write "<cell>" & trim(Rs(15)) & "</cell>"
                response.write "<cell>" & trim(Rs(13)) & "</cell>"
                response.write "<cell>" & trim(Rs(12)) & "</cell>"
                response.write "<cell>" & trim(Rs(16)) & "</cell>"
                response.write "<cell>" & trim(Rs(18)) & "</cell>"
                response.write "<cell>" & Date()  & "</cell>"
                response.write "</row>" & vbCrLf
                End If
            Rs.MoveNext
        loop
    Else
        response.write "<rows id='0' totalCount='0'>" & vbCrLf
    End If
    response.write "</rows>" & vbCrLf
End Function
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->
