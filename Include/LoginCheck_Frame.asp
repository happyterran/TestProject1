<%
'로그인 검사
IF Session("MemberID")="" or isnull(Session("MemberID"))Then%>
    <script type="text/javascript">
        parent.document.location.href="/Login.asp?LoginCheck=로그인이 필요합니다"
    </script>
    <%Response.End
End If%>