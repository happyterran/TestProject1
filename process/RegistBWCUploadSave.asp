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
    Dim StrSql, Rs, MaxLine, i
    Dim DbconO
    Set DbconO = Server.CreateObject("ADODB.Connection")
    DbconO.Open DBConnectionString
    Set Rs = Server.CreateObject("ADODB.Recordset")
    StrSql =                   "IF OBJECT_ID('tempdb..##LinkTable4') IS NOT NULL drop table ##LinkTable4 select * into ##LinkTable4 from openQuery(SCHOOLDB, 'SELECT * FROM METIS.LINKTABLE4') "
	DbconO.Execute StrSql
	StrSql =                   ""
	StrSql =                   "INSERT INTO OPENQUERY(SCHOOLDB, ' "
	StrSql = StrSql & vbCrLf & "	Select "
	StrSql = StrSql & vbCrLf & "		IDX, MYear, SubjectCode, StudentNumber, StudentName, Degree, Result, MemberID, InsertTime "
	StrSql = StrSql & vbCrLf & "	FROM METIS.LINKTABLE4 "
	StrSql = StrSql & vbCrLf & "') "& vbCrLf
	
	
	StrSql = StrSql & vbCrLf & "select cr.idx, cct.MYear, cr.SubjectCode, cr.StudentNumber, et.StudentName, cr.Degree, cr.Result, cr.MemberID, cr.InsertTime"
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
	StrSql = StrSql & vbCrLf & "left outer join ##LinkTable4 T4"
    StrSql = StrSql & vbCrLf & "on et.StudentNumber = T4.StudentNumber "
    StrSql = StrSql & vbCrLf & "where cct.Division0 = '" & FormDivision0 & "'"
    StrSql = StrSql & vbCrLf & "and cr.Degree = '" & FormDegree & "'"
	StrSql = StrSql & vbCrLf & "and T4.StudentNumber is null" & vbCrLf
    'PrintSql StrSql
    'Response.End
    DbconO.Execute(StrSql)
    DbconO.Close
    Set DbconO = Nothing
End Function
%>
<!-- #include virtual = "/Include/Dbclose.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Project METIS 2.0 - MetisSoft, Inc.</title>
    <script type="text/javascript">
        <%if Err.Description <> "" then%>
            alert('전송에 실패했습니다.\n<%=Replace(Err.Description, "'", " ")%>');
        <%Else%>
            alert("전송이 정상적으로 완료 되었습니다");
        <%End If%>
        parent.searchGetInfo();
    </script>
</head>

<body style="padding-top:0;">
&nbsp;


</body>
</html>

