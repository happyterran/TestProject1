<%
'������ �α��� �˻�
IF Session("Grade") <> "������" Then
    Response.Redirect "/Login.asp?LoginCheck=" & Server.URLEncode("�����ڸ� ������ �����մϴ�")
    Response.End
End If
%>