<%
' ##################################################################################
' 공백일때 대체 문자 처리
' ##################################################################################
  function getParameter(m,s)
    if m = "" or isNull(m) then
      getParameter = Trim(s)
    else
      getParameter = Trim(m)
    end if  
  end function

  function getIntParameter(im,s)
    if im = "" or not IsNumeric(im) then
      getIntParameter = Clng(Trim(s))
    else
      getIntParameter = Clng(Trim(im))
    end if  
  end function


' ##################################################################################
' 전체 페이지 구하기
' ##################################################################################
  Function total(recordCount,pageSize)
  total = int((recordCount-1)/pageSize) +1  '페이지 갯수
  if total = 0 then
  total = 1
  end if
  End Function

' ##################################################################################
' 문자열 자릿수 조정
'	Str1 = 문자열
' Str2 = 대입할 문자
' Length = 원하는 자릿수
' ##################################################################################
  Function CipherEdit(Str1,Str2,Length)
		dim Length1, StrTemp
		Length1 = len(Str1)
		if cInt(length1) < cInt(Length) then
			StrTemp = cStr(Str1)
			dim i
			for i = 1 to length - Length1
				StrTemp = cStr(Str2) & StrTemp
			next
			CipherEdit = StrTemp
		else
			CipherEdit = Str1
		end if
  End Function

' ##################################################################################
' 문자열에서 문자 제거 (숫자만 남기기)
' ##################################################################################
  Function MyVal(Str1)
		dim i , tmp, Str2
		Str2 = ""
		for i = 1 to len(Str1)
			tmp = mid(Str1, i, 1)
			if 48 =< asc(tmp) and asc(tmp) =< 57 then 
				Str2 = Str2 & tmp
			end if
		next
		MyVal = Str2
  End Function

' ##################################################################################
' DB에서 불러온 시각을 보기 쉽게 변환
' ##################################################################################
  Function CastDateTime(Str1)
		if Str1 = "" then
			CastDateTime = Str1
		else
			CastDateTime = DatePart("m", Str1) & "월" & DatePart("d", Str1) & "일 " & CipherEdit(DatePart("h", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("n", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("s", Str1) , "0" , 2)
		end if
  End Function
  Function CastDateTime2(Str1)
		if Str1 = "" then
			CastDateTime2 = Str1
		else
			CastDateTime2 = CipherEdit(DatePart("h", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("n", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("s", Str1) , "0" , 2)
		end if
  End Function


' ##################################################################################
' 발송 전화번호 필터링
' ##################################################################################
  Function DestinationFiltering(SMSDestination)
      Dim SMSDestinationTemp, SMSDestinationLength, i
			SMSDestinationTemp = ""
			SMSDestinationLength = len(SMSDestination)
      For i = 1 To SMSDestinationLength
          If IsNumeric(mid(SMSDestination, i ,1)) Then
              SMSDestinationTemp = SMSDestinationTemp & mid(SMSDestination, i ,1)
          End If
      Next
      DestinationFiltering = SMSDestinationTemp
  End Function

' ##################################################################################
' 문자열 자릿수 조정
'	Str1 = 문자열
' Str2 = 대입할 문자
' Length = 원하는 자릿수
' ##################################################################################
  Function DigitEdit(Str1,Str2,Length)
		dim Length1, StrTemp
		Length1 = len(Str1)
		if cInt(length1) < cInt(Length) then
			StrTemp = cStr(Str1)
			dim i
			for i = 1 to length - Length1
				StrTemp = cStr(Str2) & StrTemp
			next
			DigitEdit = StrTemp
		else
			DigitEdit = Str1
		end if
  End Function

' ##################################################################################
' 문자열 바이트 자릿수 조정
' Str1 = 문자열
' Str2 = 대입할 문자
' Length = 원하는 바이트 자릿수
' ##################################################################################
  Function ByteDigitEdit(Str1,Str2,Length)
		dim Length1, StrTemp
		Length1 = ByteLen(Str1)
		if cInt(length1) < cInt(Length) then
			StrTemp = cStr(Str1)
			dim i
			for i = 1 to length - Length1
				StrTemp = cStr(Str2) & StrTemp
			next
			ByteDigitEdit = StrTemp
		else
			ByteDigitEdit = Str1
		end if
  End Function

' ##################################################################################
' 문자열 바이트 자릿수 조정 오른쪽으로
' Str1 = 문자열
' Str2 = 대입할 문자
' Length = 원하는 바이트 자릿수
' ##################################################################################
  Function ByteDigitEditForword(Str1,Str2,Length)
		dim Length1, StrTemp
		Length1 = ByteLen(Str1)
		if cInt(length1) < cInt(Length) then
			StrTemp = cStr(Str1)
			dim i
			for i = 1 to length - Length1
				StrTemp = StrTemp & cStr(Str2)
			next
			ByteDigitEditForword = StrTemp
		else
			ByteDigitEditForword = Str1
		end if
  End Function

' ##################################################################################
' 문자열 바이트 길이
' Str1 = 문자열
' ##################################################################################

Public Function ByteLen(ByVal as_Str)
 Dim ii_Pos, is_Chr
 Dim ii_AscB: ii_AscB = 1
 Dim ii_UTFB: ii_UTFB = 2
 ByteLen = 0
 If Not IsNull(as_Str) Then
  For ii_Pos = 1 To Len(CStr(as_Str)) Step 1
   is_Chr = Mid(as_Str, ii_Pos, 1)
   If (0 > Asc(is_Chr)) Or (127 < Asc(is_Chr)) Then
	ByteLen = ByteLen + ii_UTFB
   Else
	ByteLen = ByteLen + ii_AscB
   End If
  Next
 End If
End Function

' ##################################################################################
' 문자열 바이트로 Left
' Str1 = 대입할 문자, Size = 길이
' ##################################################################################
Public Function ByteLeft(ByVal Str1, ByVal Size) '문자열 값 받아오기
	Dim i
	Dim charat, wLen
	Dim Output
	wLen = 0
	i = 1
	Do until wLen >= Size or i > len(Str1)  '첫번째 문자부터 마지막 문자까지 검사하는 Loop문돌리기
		charat = Mid(Str1, i, 1) '문자열의 i번째 문자를 저장
		If Asc(charat) > 0 And Asc(charat) < 255 Then '한글이 아니라면 
			wLen = wLen + 1            '1byte처리
			Output = Output & charat
		Else                    '한글이라면
			if wLen >= Size - 1 then 
				exit do
			else
				wLen = wLen + 2            '2byte 처리
				Output = Output & charat
			end if
		End If
		'response.write wLen & " "
		i = i + 1
	Loop
	ByteLeft = Output
	'response.write wLen
End Function

' ##################################################################################
' 로그인 아이디로 기본 회원정보를 가져온다.
' ##################################################################################
function fn_cust_by_loginid(MemberID)
	dim m_sql, o_rs, o_comd
	dim o_cust
	set o_cust = new clsMember

	m_sql =         " select * "
	m_sql = m_sql & " from Member "
	m_sql = m_sql & " where MemberID = ? "
	
	set o_comd = server.createobject("adodb.command")
	set o_rs = server.createobject("adodb.recordset")

	o_comd.ActiveConnection = Dbcon
	o_comd.CommandText = m_sql
	o_comd.CommandType = adcmdtext

	o_comd.Parameters.Append o_comd.CreateParameter("MemberID", adVarChar, adParamInput, 20, MemberID)
	
	'PrintAdo(o_comd)
	'response.end
	
	o_rs.open o_comd
	set o_comd = nothing
	
	if not o_rs.eof then
		o_cust.MemberID    = trim(o_rs("MemberID"))
		o_cust.Password  = trim(o_rs("Password"))
		o_cust.MemberName  = trim(o_rs("MemberName"))
		o_cust.Position   = trim(o_rs("Position"))
		o_cust.Grade    = trim(o_rs("Grade"))
		o_cust.MemberDivision0     = trim(o_rs("MemberDivision0"))
		o_cust.MemberDivision1       = trim(o_rs("MemberDivision1"))
		o_cust.MemberSubjectA   = trim(o_rs("MemberSubjectA"))
		o_cust.MemberSubjectB   = trim(o_rs("MemberSubjectB"))
		o_cust.InsertTime    = trim(o_rs("InsertTime"))

	end if
	o_rs.close
	set o_rs = nothing
	
	set fn_cust_by_loginid = o_cust
	set o_cust = nothing
end Function

''@ ********************************************************************************
''@ 현재 시간[년월일시분초 형식] => 20121015122545 
''@ ********************************************************************************
Function Fn_nowDate()
	Dim nowDate
	nowDate = Right(replace(date, "-", ""), 6)
	nowDate = nowDate & CipherEdit(Hour(now), "0", 2) & CipherEdit(minute(now), "0", 2) & CipherEdit(Second(now), "0", 2)
	Fn_nowDate = nowDate
End Function 

' ##################################################################################
' TestArea에 response.write
' ##################################################################################
Function PrintSql(StrSql)
	Response.Write "<textarea style='width: 100%; height: 200px;'>" & StrSql & "</textarea>" & "<br>"
End Function

' ##################################################################################
'ADO의 Command객체를 이용할 경우 파라미터값을 출력하기가 힘들다. 이 함수를 이용하여 완성된 쿼리문을 얻을 수 있다.
' ##################################################################################
Sub PrintAdo(objComd)
	Dim sql, start, param, findpos
	sql = objComd.CommandText
	start = 1
	For Each param In objComd.Parameters
		findpos = InStr(start,"?",sql)
		start = findpos + 1
		sql = Replace(sql,"?","'"&param.Value&"'",start,1)
	Next
	Response.Write "<b>" & vbcrlf & sql & "</b>" & vbcrlf & "<br>"
End Sub
Function FunctionNowDate()
	Dim nowDate
	nowDate = Right(replace(date, "-", ""), 6)
	nowDate = nowDate & CipherEdit(Hour(now), "0", 2) & CipherEdit(minute(now), "0", 2) & CipherEdit(Second(now), "0", 2)
	FunctionNowDate = nowDate
End Function 

'결과 변환
Function CastResult(Result)
    Result = cInt(Result)
    '결과
    Select Case Result
        Case 1
            CastResult = "미작업"
        Case 2
            CastResult = "등록완료"
        Case 3
            CastResult = "포기"
        Case 4
            CastResult = "미결정"
        Case 5
            CastResult = "미연결"
        Case 6
            CastResult = "등록예정"
        Case 7
            CastResult = "미등록"
        Case 8
            CastResult = ""
        Case 9
            CastResult = ""
        Case 10
            CastResult = "환불"
    End Select
End Function

'받은사람 변환
Function CastReceiver(Receiver)
    Receiver = cInt(Receiver)
    '받은사람
    select case Receiver
        case 1
            CastReceiver = "없음"
        case 2
            CastReceiver = "지원자"
        case 3
            CastReceiver = "부모"
        case 4
            CastReceiver = "가족"
        case 5
            CastReceiver = "기타"
    end select
End Function

'결과 변환 반대
Function CastReverseResult(Result)
    Result = cStr(Result)
    '결과
    Select Case Result
        Case "미작업"
            CastReverseResult = 1
        Case "등록"
            CastReverseResult = 2
        Case "등록완료"
            CastReverseResult = 2
        Case "포기"
            CastReverseResult = 3
        Case "미결정"
            CastReverseResult = 4
        Case "미연결"
            CastReverseResult = 5
        Case "등록예정"
            CastReverseResult = 6
        Case "미등록"
            CastReverseResult = 7
        Case "환불"
            CastReverseResult = 10
    End Select
End Function

'받은사람 변환 반대
Function CastReverseReceiver(Receiver)
    Receiver = cStr(Receiver)
    '받은사람
    select case Receiver
        case "없음"
            CastReverseReceiver = 1
        case "지원자"
            CastReverseReceiver = 2
        case "부모"
            CastReverseReceiver = 3
        case "가족"
            CastReverseReceiver = 4
        case "기타"
            CastReverseReceiver = 5
    end select
End Function

 Public Function URLDecode(S)
  Dim  I, RET, M, C, C2
  I=1: RET = ""
  Do 
   If I> LEN(S) Then Exit Do 
    M = MID(S,I,1)
   If M = "%" Then 
    C = MID(S,I+1,2): I = I + 2
    If LEFT(C,1) = "E" Then 
     C2 = MID(S,I+1,6): I = I + 6: RET = RET & URLDecode_CHAR(C & C2)
    Else 
     RET = RET & CHRW("&H" & C)
    End If 
   Else 
    RET = RET & M
   End If 
   I=I+1
  Loop 
  URLDecode = RET
 End Function

 Private Function URLDecode_CHAR(S)
  Dim CODE, x, C1, C2, C3, C4, C5, C6
  CODE = REPLACE(S, "%", "")

  C1 = LEFT(CODE, 1) ' E
  C2 = MID(CODE, 2, 1) ' <- 1
  C3 = MID("00011011",(INSTR("89AB",MID(CODE, 3, 1))-1)*2+1,2)
  C4 = HTOB(MID(CODE, 4, 1))
  C5 = MID("00011011",(INSTR("89AB",MID(CODE, 5, 1))-1)*2+1,2)
  C6 = MID(CODE, 6, 1) ' <- 4

  X = C3 & C4 & C5
  X = CHRW(CINT("&H" & C2 & BTOH(LEFT(X, 4)) & BTOH(RIGHT(X, 4)) & C6))
  URLDecode_CHAR = X
 End Function

Private Function BTOH(X)
    BTOH = MID("0123456789ABCDEF",(INSTR("0000,0001,0010,0011,0100,0101,0110,0111,1000,1001,1010,1011,1100,1101,1110,1111,",X&",")-1)/5+1,1)
End Function 

Private Function HTOB(X)
    IF X <> "" Then HTOB = SPLIT("0000,0001,0010,0011,0100,0101,0110,0111,1000,1001,1010,1011,1100,1101,1110,1111", ",")(CINT("&H"&X))
End Function

' ##################################################################################
' 쿼리 검색어 제한
' ##################################################################################
Function getQueryFilter( text )
	text = getParameter( text, "" )
	text = Replace(text,"'","")
	text = Replace(text,"--","")
	text = Replace(text,"insert","")
	text = Replace(text,"select","")
	text = Replace(text,"delete","")
	text = Replace(text,"update","")
	text = Replace(text,"or ","")
	getQueryFilter = text
End Function
%>


