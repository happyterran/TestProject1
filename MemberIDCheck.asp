<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/common.cls.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/adovbs.inc.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%
'--------------------------------------------------------------------------------------------------
' ��������		:	
' �ۼ���		:	
' ����������	:	
' ��������		:	
'	-
'--------------------------------------------------------------------------------------------------
dim StrSql
dim MemberID
dim o_cust, message,isvalid, MemberLoginID

MemberID = LCase(trim(Request.Form("MemberID")))

' �ߺ��Ǵ� �α��� ���̵� �ִ��� üũ�Ѵ�.
If MemberID <> "" Then
	set o_cust = fn_cust_by_loginid(MemberID)	'ȸ����ü�� Empty�̸� �ش� ȸ���� ����.
	
	MemberLoginID = o_cust.MemberID
	
	if MemberLoginID <> "" then
		MemberLoginID = LCase(MemberLoginID)
	end if
Else
	set o_cust = new clsMember
End If

' �Ѱ��� requestText (JSON ����) [{"a":"1","b":"1"},{"a":"2","b":"2"}]
If MemberID = "" then					'# ���̵� �Է� ���
'	response.write "["
	response.write "{"
	response.write """Code"":""0"","
	response.write """Message"":""ID�� �Է��ϼ���"""
	response.write "}"
'	response.write "]"

ElseIf MemberLoginID <> MemberID Then	'# ��밡��
'	response.write "["
	response.write "{"
	response.write """Code"":""1"","
	response.write """Message"":""��� ���� ID"""
	response.write "}"
'	response.write "]"

Else										'# �ߺ�-���Ұ�
'	response.write "["
	response.write "{"
	response.write """Code"":""0"","
	response.write """Message"":""�̹� �����"""
	response.write "}"
'	response.write "]"

End If

set o_cust = nothing

%>
<!-- #include virtual = "/Include/Dbclose.asp" -->