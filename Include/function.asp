<%
' ##################################################################################
' �����϶� ��ü ���� ó��
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
' ��ü ������ ���ϱ�
' ##################################################################################
  Function total(recordCount,pageSize)
  total = int((recordCount-1)/pageSize) +1  '������ ����
  if total = 0 then
  total = 1
  end if
  End Function

' ##################################################################################
' ���ڿ� �ڸ��� ����
'	Str1 = ���ڿ�
' Str2 = ������ ����
' Length = ���ϴ� �ڸ���
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
' ���ڿ����� ���� ���� (���ڸ� �����)
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
' DB���� �ҷ��� �ð��� ���� ���� ��ȯ
' ##################################################################################
  Function CastDateTime(Str1)
		if Str1 = "" then
			CastDateTime = Str1
		else
			CastDateTime = DatePart("m", Str1) & "��" & DatePart("d", Str1) & "�� " & CipherEdit(DatePart("h", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("n", Str1) , "0" , 2) & ":" & CipherEdit(DatePart("s", Str1) , "0" , 2)
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
' �߼� ��ȭ��ȣ ���͸�
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
' ���ڿ� �ڸ��� ����
'	Str1 = ���ڿ�
' Str2 = ������ ����
' Length = ���ϴ� �ڸ���
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
' ���ڿ� ����Ʈ �ڸ��� ����
' Str1 = ���ڿ�
' Str2 = ������ ����
' Length = ���ϴ� ����Ʈ �ڸ���
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
' ���ڿ� ����Ʈ �ڸ��� ���� ����������
' Str1 = ���ڿ�
' Str2 = ������ ����
' Length = ���ϴ� ����Ʈ �ڸ���
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
' ���ڿ� ����Ʈ ����
' Str1 = ���ڿ�
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
' ���ڿ� ����Ʈ�� Left
' Str1 = ������ ����, Size = ����
' ##################################################################################
Public Function ByteLeft(ByVal Str1, ByVal Size) '���ڿ� �� �޾ƿ���
	Dim i
	Dim charat, wLen
	Dim Output
	wLen = 0
	i = 1
	Do until wLen >= Size or i > len(Str1)  'ù��° ���ں��� ������ ���ڱ��� �˻��ϴ� Loop��������
		charat = Mid(Str1, i, 1) '���ڿ��� i��° ���ڸ� ����
		If Asc(charat) > 0 And Asc(charat) < 255 Then '�ѱ��� �ƴ϶�� 
			wLen = wLen + 1            '1byteó��
			Output = Output & charat
		Else                    '�ѱ��̶��
			if wLen >= Size - 1 then 
				exit do
			else
				wLen = wLen + 2            '2byte ó��
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
' �α��� ���̵�� �⺻ ȸ�������� �����´�.
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
''@ ���� �ð�[����Ͻú��� ����] => 20121015122545 
''@ ********************************************************************************
Function Fn_nowDate()
	Dim nowDate
	nowDate = Right(replace(date, "-", ""), 6)
	nowDate = nowDate & CipherEdit(Hour(now), "0", 2) & CipherEdit(minute(now), "0", 2) & CipherEdit(Second(now), "0", 2)
	Fn_nowDate = nowDate
End Function 

' ##################################################################################
' TestArea�� response.write
' ##################################################################################
Function PrintSql(StrSql)
	Response.Write "<textarea style='width: 100%; height: 200px;'>" & StrSql & "</textarea>" & "<br>"
End Function

' ##################################################################################
'ADO�� Command��ü�� �̿��� ��� �Ķ���Ͱ��� ����ϱⰡ �����. �� �Լ��� �̿��Ͽ� �ϼ��� �������� ���� �� �ִ�.
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

'��� ��ȯ
Function CastResult(Result)
    Result = cInt(Result)
    '���
    Select Case Result
        Case 1
            CastResult = "���۾�"
        Case 2
            CastResult = "��ϿϷ�"
        Case 3
            CastResult = "����"
        Case 4
            CastResult = "�̰���"
        Case 5
            CastResult = "�̿���"
        Case 6
            CastResult = "��Ͽ���"
        Case 7
            CastResult = "�̵��"
        Case 8
            CastResult = ""
        Case 9
            CastResult = ""
        Case 10
            CastResult = "ȯ��"
    End Select
End Function

'������� ��ȯ
Function CastReceiver(Receiver)
    Receiver = cInt(Receiver)
    '�������
    select case Receiver
        case 1
            CastReceiver = "����"
        case 2
            CastReceiver = "������"
        case 3
            CastReceiver = "�θ�"
        case 4
            CastReceiver = "����"
        case 5
            CastReceiver = "��Ÿ"
    end select
End Function

'��� ��ȯ �ݴ�
Function CastReverseResult(Result)
    Result = cStr(Result)
    '���
    Select Case Result
        Case "���۾�"
            CastReverseResult = 1
        Case "���"
            CastReverseResult = 2
        Case "��ϿϷ�"
            CastReverseResult = 2
        Case "����"
            CastReverseResult = 3
        Case "�̰���"
            CastReverseResult = 4
        Case "�̿���"
            CastReverseResult = 5
        Case "��Ͽ���"
            CastReverseResult = 6
        Case "�̵��"
            CastReverseResult = 7
        Case "ȯ��"
            CastReverseResult = 10
    End Select
End Function

'������� ��ȯ �ݴ�
Function CastReverseReceiver(Receiver)
    Receiver = cStr(Receiver)
    '�������
    select case Receiver
        case "����"
            CastReverseReceiver = 1
        case "������"
            CastReverseReceiver = 2
        case "�θ�"
            CastReverseReceiver = 3
        case "����"
            CastReverseReceiver = 4
        case "��Ÿ"
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
' ���� �˻��� ����
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


