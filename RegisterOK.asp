<!-- #include virtual = "/Include/refresh.asp" -->
<!-- include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%

	MemberID=trim(Request.Form("MemberID"))	
	Password=trim(Request.Form("Password"))
	MemberName=trim(Request.Form("MemberName"))
	Position=trim(Request.Form("Position"))

	'// �Է��׸� �������� Ȯ��
	if MemberID=""or Password="" then
		response.write "<script language='javascript'>alert('������ �׸��� �ֽ��ϴ�. �ٽ� Ȯ���� �ּ���.');self.location.href='./Register.asp';</script>"
		dbcon.close
		set dbcon=nothing
		response.end
	end if
	'// �ߺ����̵� Ȯ��
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	StrStrSql="select * from Member where MemberID='" & MemberID & "'"
	Rs.open StrStrSql,dbcon,1
	if not Rs.EOF then
		response.write "<script language='javascript'>alert('�̹� �����Ͻ� ���̵� �Դϴ�');self.location.href='./Register.asp';</script>"
		Rs.close
		set Rs=nothing
		dbcon.close
		set dbcon=nothing
		response.end
	else
		Rs.Close
		Set Rs = Nothing
	end if
	'// ��Ű �Է�, �α��� ����
	'Session("MemberID") = MemberID
	'Session("MemberName") = MemberName
	'Session("Position") = Position
'	response.end

	StrStrSql="begin tran "
	StrStrSql=StrStrSql & "insert into Member (MemberID,Password,MemberName,Position) values('" 
	StrStrSql=StrStrSql & MemberID & "','" 
	StrStrSql=StrStrSql & Password & "','" 
	StrStrSql=StrStrSql & MemberName & "','" 
	StrStrSql=StrStrSql & Position & "') "
	StrStrSql=StrStrSql & "commit tran"
	'response.write StrStrSql
	dbcon.Execute (StrStrSql)

    Response.Write "<Script Language='javascript'>document.location.href='/Login.asp?LoginCheck=�������� ������ �ʿ��մϴ�.';</Script>"

	dbcon.close
	set dbcon=nothing
%>

