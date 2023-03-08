<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
Dim FormCheckbox, FormStatus, FormMemo
FormCheckbox = GetParameter( Request.Form("Checkbox") , "" )
FormStatus = GetParameter( Request.Form("FormStatus") , "" )
FormMemo = Replace( Replace( trim( GetParameter( Request.Form("FormMemo") , "" ) ) , vbCrLf , " " ) , "," , "." )

'Response.write Request.Form("Checkbox").count & "<BR>"
'Response.write Request.Form("Checkbox")(1) & "<BR>"
'Response.write FormStatus & "<BR>"
'Response.write FormMemo & "<BR>"

If FormStatus<>"" and Request.Form("Checkbox").count>0 Then
	Dim i, StrSql
	StrSql =          "declare @SubjectCode as varchar(30)"
	StrSql = StrSql & vbCrLf & "select @SubjectCode = SubjectCode from StudentTable where StudentNumber='" & Request.Form("Checkbox")(1) & "'"
	StrSql = StrSql & vbCrLf & "begin tran"
	for i= 1 to Request.Form("Checkbox").count
		StrSql = StrSql & vbCrLf & "	SET NOCOUNT ON"
		StrSql = StrSql & vbCrLf & "	insert into RegistRecord (StudentNumber, SubjectCode, Degree, UsedLine, MemberID, Result, Memo)"
		StrSql = StrSql & vbCrLf & "	values ('" & Request.Form("Checkbox")(i) & "', @SubjectCode, '" & Session("FormDegree") & "' ,0 ,'" & Session("MemberID") & "', '" & FormStatus & "', '" & FormMemo & "')"
	next
'	StrSql = StrSql & vbCrLf & "If"
'	StrSql = StrSql & vbCrLf & "("
'	StrSql = StrSql & vbCrLf & "	select count(*)"
'	StrSql = StrSql & vbCrLf & "	from"
'	StrSql = StrSql & vbCrLf & "	("
'	StrSql = StrSql & vbCrLf & "		select IDX, StudentNumber"
'	StrSql = StrSql & vbCrLf & "		from RegistRecord"
'	StrSql = StrSql & vbCrLf & "		where SubjectCode=@SubjectCode"
'	StrSql = StrSql & vbCrLf & "			and ( Result=6 or Result=2 or Result=4 or Result=5 )"
'	StrSql = StrSql & vbCrLf & "	) A"
'	StrSql = StrSql & vbCrLf & "	inner join"
'	StrSql = StrSql & vbCrLf & "	("
'	StrSql = StrSql & vbCrLf & "		select StudentNumber, max(IDX) as MaxIDX"
'	StrSql = StrSql & vbCrLf & "		from RegistRecord"
'	StrSql = StrSql & vbCrLf & "		where SubjectCode=@SubjectCode"
'	StrSql = StrSql & vbCrLf & "		group by StudentNumber"
'	StrSql = StrSql & vbCrLf & "	) B"
'	StrSql = StrSql & vbCrLf & "	on A.StudentNumber = B.StudentNumber"
'	StrSql = StrSql & vbCrLf & "		and A.IDX = B.MaxIDX"
'	StrSql = StrSql & vbCrLf & ")"
'	StrSql = StrSql & vbCrLf & ">"
'	StrSql = StrSql & vbCrLf & "(select Quorum from SubjectTable where SubjectCode=@SubjectCode)"
'	StrSql = StrSql & vbCrLf & "begin"
'	StrSql = StrSql & vbCrLf & "	rollback"
'	StrSql = StrSql & vbCrLf & "	select 'QuorumError'"
'	StrSql = StrSql & vbCrLf & "End"
'	StrSql = StrSql & vbCrLf & "Else"
'	StrSql = StrSql & vbCrLf & "begin"
	StrSql = StrSql & vbCrLf & "	If @@Error=0"
	StrSql = StrSql & vbCrLf & "	begin"
	StrSql = StrSql & vbCrLf & "		commit tran"
	StrSql = StrSql & vbCrLf & "		select 'InsertOkey'"
	StrSql = StrSql & vbCrLf & "	End"
	StrSql = StrSql & vbCrLf & "	Else"
	StrSql = StrSql & vbCrLf & "	begin"
	StrSql = StrSql & vbCrLf & "		rollback"
	StrSql = StrSql & vbCrLf & "		select 'ETCError'"
	StrSql = StrSql & vbCrLf & "	End"
'	StrSql = StrSql & vbCrLf & "End"
'	Response.Write StrSql
'	Response.End
	Dim Rs
	Set Rs = Server.CreateObject("ADODB.Recordset")
	Rs.CursorLocation = 3
	Rs.CursorType = 3
	Rs.LockType = 3
	Rs.Open StrSql, Dbcon
	Dim QuorumError
	QuorumError = GetParameter( Rs(0) , "" )
	'Response.write Result
	Rs.Close
	set Rs = Nothing
End If
%>
<!-- #include virtual = "/Include/DbClose.asp" -->
<%
If QuorumError="" Then
	Response.Redirect "Root.asp"
Else%>
	<FORM METHOD=POST ACTION="Root.asp" Name="ErrorForm">
		<INPUT TYPE="hidden" name="QuorumError" value="<%=QuorumError%>">
	</FORM>
	<script language='javascript'>
		document.ErrorForm.submit();
	</script>
<%End If%>