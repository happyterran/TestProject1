<%'로그인 검사
Dim Login
IF Session("MemberID")="" or isnull(Session("MemberID"))Then%>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
    //opener.alert('로그인이 필요합니다')
    opener.document.location.href="/Login.asp?LoginCheck=Timeout";
    opener.focus();
    self.close();
    //-->
    </SCRIPT>
    <%Response.End
End If%>