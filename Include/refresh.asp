<%
Response.Buffer = True
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma", "no-cache"
Response.AddHeader "Cache-Control", "private"
Response.CacheControl = "no-cache"

'If Request.ServerVariables("HTTPS") = "off" Then
'    Dim SecureURL
'    SecureURL = "https://"
'    SecureURL = SecureURL & Request.ServerVariables("SERVER_NAME")
'    SecureURL = SecureURL & Request.ServerVariables("URL")
'    Response.Redirect SecureURL
'End If
%>