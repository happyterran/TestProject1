<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim StrSql
StrSql = "update Member set InsertTime = getdate()"

If Request.QueryString("Position")<>"" Then 
    Session("Position")=Request.QueryString("Position")
    StrSql = StrSql & vbCrLf & ", Position = '" & Session("Position") & "'"
End If

If Request.QueryString("PositionRegistRecord")<>"" Then 
    Session("PositionRegistRecord")=Request.QueryString("PositionRegistRecord")
    StrSql = StrSql & vbCrLf & ", PositionRegistRecord = '" & Session("PositionRegistRecord") & "'"
End If

If Request.QueryString("PositionStudentDetail")<>"" Then 
    Session("PositionStudentDetail")=Request.QueryString("PositionStudentDetail")
    StrSql = StrSql & vbCrLf & ", PositionStudentDetail = '" & Session("PositionStudentDetail") & "'"
End If

If Request.QueryString("PositionPluralRecord")<>"" Then
    Session("PositionPluralRecord")=Request.QueryString("PositionPluralRecord")
    StrSql = StrSql & vbCrLf & ", PositionPluralRecord = '" & Session("PositionPluralRecord") & "'"
End If

StrSql = StrSql & vbCrLf & "where MemberID = '" & Session("MemberID") & "'"
'Response.Write StrSql
Dbcon.Execute(StrSql)
Dbcon.Close
Set Dbcon=nothing
%>
