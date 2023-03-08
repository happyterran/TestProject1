<%
'로그인 검사
IF Session("MemberID")="" or isnull(Session("MemberID"))Then
    Response.Redirect "/Login.asp?LoginCheck=" & Server.URLEncode("로그인이 필요합니다")
    Response.End
End If
%>