<%'�α��� �˻� XML
Dim Login
IF Session("MemberID")="" or isnull(Session("MemberID"))Then

	Response.ContentType = "text/xml"
	Response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf%>
	<rows id='0' totalCount='1'>
	<row id='1'>
		<cell>Ÿ�Ӿƿ�</cell>
		<cell>�α��� �ʼ�</cell>
		<cell>Ÿ�Ӿƿ�</cell>
		<cell>�α��� �ʼ�</cell>
	</row>
	</rows>

	<%Response.End
End If%>