<%
'�α��� �˻�
IF Session("MemberID")="" or isnull(Session("MemberID"))Then
    Response.Redirect "/Login.asp?LoginCheck=" & Server.URLEncode("�α����� �ʿ��մϴ�")
    Response.End
End If
%>