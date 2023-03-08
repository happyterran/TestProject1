<%
'관리자 로그인 검사
IF Session("Grade") <> "관리자" Then
    Response.Redirect "/Login.asp?LoginCheck=" & Server.URLEncode("관리자만 접근이 가능합니다")
    Response.End
End If
%>