<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!-- #include virtual = "/Include/LoginCheckXML.asp" -->
<!-- #include virtual = "/include/adovbs.inc.asp"-->
<%
On Error Resume Next
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
    Response.ContentType = "text/xml"
    response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf
    Dim StrSql, Rs, MaxLine, i
    Dim DbconO
    Set DbconO = Server.CreateObject("ADODB.Connection")
    DbconO.Open DBConnectionString
    Set Rs = Server.CreateObject("ADODB.Recordset")
    StrSql =                   "IF OBJECT_ID('tempdb..##LinkTable4') IS NOT NULL drop table ##LinkTable4 select * into ##LinkTable4 from openQuery(SCHOOLDB, 'SELECT * FROM METIS.LINKTABLE4') "
	DbconO.Execute StrSql
    StrSql =                   ""
    StrSql = StrSql & vbCrLf & "select cct.MYear, cr.SubjectCode, cr.StudentNumber, et.StudentName, cr.Degree, cr.Result, cr.MemberID, cr.InsertTime"
    StrSql = StrSql & vbCrLf & "from RegistRecord cr"

    StrSql = StrSql & vbCrLf & "join ("
    StrSql = StrSql & vbCrLf & "select StudentNumber, max(idx) idx , count(*) c"
    StrSql = StrSql & vbCrLf & "from RegistRecord"
    StrSql = StrSql & vbCrLf & "group by StudentNumber"
    StrSql = StrSql & vbCrLf & ") r"
    StrSql = StrSql & vbCrLf & "on cr.StudentNumber = r.StudentNumber"
    StrSql = StrSql & vbCrLf & "and cr.idx = r.idx"

    StrSql = StrSql & vbCrLf & "join StudentTable et"
    StrSql = StrSql & vbCrLf & "on cr.StudentNumber = et.StudentNumber"
    StrSql = StrSql & vbCrLf & "join SubjectTable cct"
    StrSql = StrSql & vbCrLf & "on cr.SubjectCode = cct.SubjectCode"
    StrSql = StrSql & vbCrLf & "and ( cr.Result = '6' or cr.Result = '3')"
    StrSql = StrSql & vbCrLf & "left outer join ##LinkTable4 T4 "
    StrSql = StrSql & vbCrLf & "on et.StudentNumber = T4.StudentNumber "

	StrSql = StrSql & vbCrLf & "where cct.Division0 = '" & FormDivision0 & "'"
    StrSql = StrSql & vbCrLf & "and cr.Degree = '" & FormDegree & "'"
    'StrSql = StrSql & vbCrLf & "and T4.StudentNumber is null" & vbCrLf
    'Response.Write StrSql
    Rs.Open StrSql, DbconO
    If Not Rs.EOF Then
        MaxLine = Rs.RecordCount
        response.write "<rows id='0' totalCount='" & MaxLine & "'>" & vbCrLf
        Dim Result
        do until Rs.EOF
            i = i + 1
            if Err.Description <> "" Then
                response.write "<row id=''>"
                response.write "<cell>" & Replace(Err.Description, "'", " ") & "</cell>" & vbCrLf
                response.write "<cell></cell>" & vbCrLf
                response.write "<cell>명단오류</cell>" & vbCrLf
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "<cell></cell>"
                response.write "</row>" & vbCrLf
                Exit Do
            Else
                'CourseCode, ExamineeNumber, ExamineeName, Degree, Result, MemberID, InsertTime
                Result = CastResult(Rs(5))
                response.write "<row id=''>"
                response.write "<cell>" & trim(Rs(1))  & "</cell>"
                response.write "<cell>" & trim(Rs(2))  & "</cell>"
                response.write "<cell>" & trim(Rs(3))  & "</cell>"
                response.write "<cell>" & trim(Rs(4))  & "</cell>"
                response.write "<cell>" & trim(Result)  & "</cell>"
                response.write "<cell>" & trim(Rs(6))  & "</cell>"
                response.write "<cell>" & trim(Rs(7))  & "</cell>"
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
    Dbcon.close
    set Dbcon = nothing
End Function
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->
