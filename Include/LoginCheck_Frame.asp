<%
'�α��� �˻�
IF Session("MemberID")="" or isnull(Session("MemberID"))Then%>
    <script type="text/javascript">
        parent.document.location.href="/Login.asp?LoginCheck=�α����� �ʿ��մϴ�"
    </script>
    <%Response.End
End If%>