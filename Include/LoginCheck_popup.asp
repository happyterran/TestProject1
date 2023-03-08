<%'로그인 검사
Dim Login
IF Session("MemberID")="" or isnull(Session("MemberID"))Then%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
    <title>지원자 세부사항</title>
    <!-- #include virtual = "/Include/Head.asp" -->
    <script type="text/javascript" src="/lib/jquery/jquery.js"></script>
    <script type="text/javascript" src="/lib/jquery/jquery.ui.js"></script>
    <script type="text/javascript" src="/lib/richscript/richscript.js"></script>
    <script type="text/javascript" src="/lib/richscript/richscript.mcm.js"></script>
    <script type="text/javascript" src="/lib/richscript/richscript.mcm.popup.contents.js"></script>
    <SCRIPT LANGUAGE="JavaScript">
        $(function() {
            $popup.opener().document.location.href="/Login.asp?LoginCheck=Timeout";
        });
    </SCRIPT>
    </head>
    <body style="padding-top:0;">
    </body>
    </html>
    <%Response.End
End If%>