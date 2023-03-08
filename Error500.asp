<%@LANGUAGE="VBSCRIPT" CODEPAGE="0"%>
<%Option Explicit%>
<%'멘트의 정확한 전달을 위해 0, euc-kr
Session.CodePage = "0"'ANSI
'Session.CodePage = "949"'euc-kr
'Session.CodePage = "65001"'UTF-8
Response.Charset = "euc-kr"
'Response.Charset = "UTF-8"

	Response.ContentType = "text/xml"
'	response.write "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "euc-kr" & Chr(34) & "?>" & vbCrLf

Dim objError
Set objError = Server.GetLastError%>

<rows id="0" totalCount="1">
<row id="1">
	<cell>Cate:<%= objError.Category %></cell>
	<cell>File:<%= objError.File %></cell>
	<cell><%= objError.Description %></cell>
	<cell><%= objError.Line %></cell>
	<cell>Column:<%= objError.Column %></cell>
	<cell>Number: 0x<%= Hex(objError.Number) %></cell>
	<cell>Source: <%= Server.HTMLEncode(objError.File) %></cell>
</row>
</rows>

<%'에러로그 파일에 기록..
Dim Fso, LogPath, Sfile
Set Fso=CreateObject("Scripting.FileSystemObject")

LogPath = Server.MapPath ("/ErrorLog/Error") & replace(date,"-","") & ".log"

Set Sfile = Fso.OpenTextFile(LogPath,8,true)

Sfile.WriteLine "Date : " & now()
Sfile.WriteLine "Domain : " & Request.ServerVariables("HTTP_HOST")
Sfile.WriteLine "Browser : " & Request.ServerVariables("HTTP_USER_AGENT")

If Len(CStr(objError.ASPCode)) > 0 Then
	Sfile.WriteLine "IIS Error Number : " & objError.ASPCode
End If

If Len(CStr(objError.Number)) > 0 Then
	Sfile.WriteLine "COM Error Number : " & objError.Number & " (0x" & Hex(objError.Number) & ")"
End If 

If Len(CStr(objError.Source)) > 0 Then
	Sfile.WriteLine "Error Source : " & objError.Source
End If

If Len(CStr(objError.File)) > 0 Then
	Sfile.WriteLine "File Name : " & objError.File
End If

If Len(CStr(objError.Line)) > 0 Then
	Sfile.WriteLine "Line Number : " & objError.Line
End If 

If Len(CStr(objError.Description)) > 0 Then
	Sfile.WriteLine "Brief Description : " & objError.Description
End If

If Len(CStr(objError.ASPDescription)) > 0 Then
	Sfile.WriteLine "Full Description : " & objError.ASPDescription
End If

Sfile.WriteLine chr(13)

Sfile.Close
Set Fso=Nothing
Set objError=Nothing%>