<!-- #include virtual = "/Include/refresh.asp" -->
<!-- include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<%

	MemberID=trim(Request.Form("MemberID"))	
	Password=trim(Request.Form("Password"))
	MemberName=trim(Request.Form("MemberName"))
	Position=trim(Request.Form("Position"))

	'// 입력항목 누락여부 확인
	if MemberID=""or Password="" then
		response.write "<script language='javascript'>alert('누락된 항목이 있습니다. 다시 확인해 주세요.');self.location.href='./Register.asp';</script>"
		dbcon.close
		set dbcon=nothing
		response.end
	end if
	'// 중복아이디 확인
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	StrStrSql="select * from Member where MemberID='" & MemberID & "'"
	Rs.open StrStrSql,dbcon,1
	if not Rs.EOF then
		response.write "<script language='javascript'>alert('이미 가입하신 아이디 입니다');self.location.href='./Register.asp';</script>"
		Rs.close
		set Rs=nothing
		dbcon.close
		set dbcon=nothing
		response.end
	else
		Rs.Close
		Set Rs = Nothing
	end if
	'// 쿠키 입력, 로그인 대행
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

    Response.Write "<Script Language='javascript'>document.location.href='/Login.asp?LoginCheck=관리자의 승인이 필요합니다.';</Script>"

	dbcon.close
	set dbcon=nothing
%>

