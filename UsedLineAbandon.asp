<%Option Explicit%>
<!-- #include virtual = "/Include/refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- include virtual = "/Include/Dbopen.asp" -->
<%
Session("FormUsedLine") = ""
%>
<!-- include virtual = "/Include/Dbclose.asp" -->
<%
Response.Redirect "Root.asp"
%>