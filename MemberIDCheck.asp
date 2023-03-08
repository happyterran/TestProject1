<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/common.cls.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/adovbs.inc.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'--------------------------------------------------------------------------------------------------
' 페이지명		:	
' 작성자		:	
' 페이지설명	:	
' 수정사항		:	
'	-
'--------------------------------------------------------------------------------------------------
dim StrSql
dim MemberID
dim o_cust, message,isvalid, MemberLoginID

MemberID = LCase(trim(Request.Form("MemberID")))

' 중복되는 로그인 아이디가 있는지 체크한다.
If MemberID <> "" Then
	set o_cust = fn_cust_by_loginid(MemberID)	'회원객체가 Empty이면 해당 회원이 없다.
	
	MemberLoginID = o_cust.MemberID
	
	if MemberLoginID <> "" then
		MemberLoginID = LCase(MemberLoginID)
	end if
Else
	set o_cust = new clsMember
End If

' 넘겨줄 requestText (JSON 형식) [{"a":"1","b":"1"},{"a":"2","b":"2"}]
If MemberID = "" then					'# 아이디 입력 요망
'	response.write "["
	response.write "{"
	response.write """Code"":""0"","
	response.write """Message"":""ID를 입력하세요"""
	response.write "}"
'	response.write "]"

ElseIf MemberLoginID <> MemberID Then	'# 사용가능
'	response.write "["
	response.write "{"
	response.write """Code"":""1"","
	response.write """Message"":""사용 가능 ID"""
	response.write "}"
'	response.write "]"

Else										'# 중복-사용불가
'	response.write "["
	response.write "{"
	response.write """Code"":""0"","
	response.write """Message"":""이미 사용중"""
	response.write "}"
'	response.write "]"

End If

set o_cust = nothing

%>
<!-- #include virtual = "/Include/Dbclose.asp" -->