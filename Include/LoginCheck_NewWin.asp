<%'�α��� �˻�
Dim Login
IF Session("MemberID")="" or isnull(Session("MemberID"))Then%>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
    //opener.alert('�α����� �ʿ��մϴ�')
    opener.document.location.href="/Login.asp?LoginCheck=Timeout";
    opener.focus();
    self.close();
    //-->
    </SCRIPT>
    <%Response.End
End If%>