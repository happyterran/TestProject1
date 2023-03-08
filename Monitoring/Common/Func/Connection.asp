<%
	'-------------------------------------------------------------------------------------
Const adCmdStoredProc = &H0004	' commandType으로 스토어드 프로시져를 지정할 때 쓰인다.
Const adParamReturnValue = &H0004	' paremeter의 값으로 return된 값을 지정할 때 쓰인다.
Const adParamInputOutput = &H0003	' parameter의 값으로 output된 값을 쓸때 쓰인다.
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1
Const adUseClient = 3
Const adUseServer = 2
Const adAsyncEsxecute = &H00000010
Const adExecuteNoRecords = &H00000080
Const adOpenStatic = 3


''@~ DB 접속 정보 
Dim strServer, strDB, saId, saPwd

ConDefault	= "Y" ''@~ DB_NON_Use Y, DB_Use N 
ConDefID	= "admin"
ConDefPW	= "adminpass"                                                                                                                                                                          
ConDefNM	= "관리자"

''@~ ConDefault N is Setting
ConDBtype	= "MYSQL"
ConServer	= "121.160.7.8" ''@~ 서버 ID
ConDB			= "ars_db" ''@~ DB 명
ConsaId			= "arsid" ''@~  ID
ConsaPwd		= "arspass123" ''@~ PASS

''@~ Dat, ini file path
DATfileRoot = "C:\"
IniFileRoot = "D:\ARS\NetARS\BIN"

''@~ errlog page size
pagesize = 10


Dim get_HTTP_Url, get_HTTP_Str
	get_HTTP_Url = lcase(request.servervariables("HTTP_HOST"))
	get_HTTP_Str = "IVR MONITRING"



Function getCommand(strServer, strDB, commandText)

	dim cmd,ConnectionString

	ConnectionString =  "Provider=SQLOLEDB.1;Password=rhkddnjs77;User ID=friendy77;Initial Catalog=" & strDB & ";Data Source=" & strServer
	set cmd = server.CreateObject("ADODB.Command")

	With cmd
	
	.activeConnection = ConnectionString
	.commandType = &H0004
	.commandText = commandText
	.parameters.refresh
	
	End with
	
	set getCommand = cmd
End Function




Function getConnection(DBtype, strServer, strDB, saId, saPwd)

	Dim Conn
	Set Conn = Server.CreateObject("ADODB.Connection")

	if DBtype = "MSSQL" then 
		Conn.open "Provider=SQLOLEDB.1;Password="&saPwd&";User ID="&saId&";Initial Catalog=" & strDB & ";Data Source=" & strServer
	elseif DBtype = "MYSQL" then 
		'Conn.open "DRIVER=MySQL ODBC 3.51 Driver;SERVER="&strServer&";DATABASE="&strDB&";UID="&saId&";PWD="&saPwd&";OPTION=35;STMT=SET NAMES EUCKR;"
		Conn.open "DRIVER=MySQL ODBC 3.51 Driver;SERVER="&strServer&";DATABASE="&strDB&";UID="&saId&";PWD="&saPwd&";STMT=SET NAMES EUCKR;"		
	end if 

	set getConnection = Conn
End Function



Sub Dev_Debug(SQL,DevIp)
	IPaddr = Request.ServerVariables("REMOTE_ADDR")
	IF  DevIp=IPaddr Then
		Response.write SQL
		response.end
	End IF
End Sub

Sub ServiceStop()
	
%>

<script language = "javascript">

	var h = (screen.height/2) - 270;
	var w = (screen.width/2) - 165;
	window.open('/notice/155notice.html','pop155notice_win','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=500,height=520,top='+h+',left='+w);
}
</script>
<%
	
End Sub

Function Phone_AddBar(str)
	
	Dim LenStr
	Dim Tmp_Phone 
	If isnull(str) Then str =""
	LenStr = len(str)
	
		IF LenStr <= 4 Then
			Tmp_Phone = str
		ElseIF LenStr > 4 and Len(str) < 9 Then
			Tmp_Phone = left(str,(LenStr-4)) &"-"& Right(str,4)
		ElseIF Len(str) = 9 Then
			If Left(str,2) = "02" Then
				Tmp_Phone = left(str,2)&"-"& Mid(str,3,3) &"-"& Right(str,4)
			Else
				Tmp_Phone = left(str,3)&"-"& Mid(str,4,2) &"-"& Right(str,4) 
			End IF
			
		Elseif Len(str)=10 Then
			If Left(str,2) = "02" Then
				Tmp_Phone = left(str,2)&"-"& Mid(str,3,4) &"-"& Right(str,4) 
			Else
				Tmp_Phone = left(str,3)&"-"& Mid(str,4,3) &"-"& Right(str,4) 
			End IF
		Elseif Len(str)=11 Then
				Tmp_Phone = left(str,3)&"-"& Mid(str,4,4) &"-"& Right(str,4)
		Else 
				Tmp_Phone = left(str,3)&"-"& Mid(str,4,4) &"-"& Mid(str,8,LenStr-7)
		End IF
		Phone_AddBar = Tmp_Phone
	

End Function


Function DelComma(str)
	str = replace(str,",","")
	DelComma = str
End Function


Function get_Split_DomainURL(oidStoreGroup,StrTable)

	get_Split_DomainURL = "http://"&get_HTTP_Url

End Function



Function Kor_WeekDay(str)
			select case str
				case 1 
					Kor_WeekDay = "일"
				case 2 
					Kor_WeekDay = "월"
				case 3 
					Kor_WeekDay = "화"
				case 4 
					Kor_WeekDay = "수"
				case 5 
					Kor_WeekDay = "목"
				case 6 
					Kor_WeekDay = "금"
				case 7 
					Kor_WeekDay = "토"
			end select	
	
End Function

'/account/sale 폴더 : 결산 메뉴
Function Kor_Font_WeekDay(str)
			select case str
				case 1 
					Kor_Font_WeekDay = "<font color=red>일</font>"
				case 2 
					Kor_Font_WeekDay = "월"
				case 3 
					Kor_Font_WeekDay = "화"
				case 4 
					Kor_Font_WeekDay = "수"
				case 5 
					Kor_Font_WeekDay = "목"
				case 6 
					Kor_Font_WeekDay = "금"
				case 7 
					Kor_Font_WeekDay = "<font color=blue>토</font>"
			end select	
	
End Function



'// 문자열에서 숫자를 빼는 함수. *************************************************
'*	위의 Convert_Kor_SMS_Send_part(etc1) 함수를 사용할때  
'*	트래킹에서 보낸 문자는 숫자값이 포함이되므로 아래 함수에서 먼저 정규화 시킨다.
'//*******************************************************************************
Function FnDelString(str)
        SET oRe = new RegExp
        oRe.pattern ="[0-9]|\(주\)|\([0-9](~[0-9])?\)"
        oRe.Global = True
        oRe.IgnoreCase = True
        oRe.MultiLine = True
        FnDelString = oRe.Replace(str, "")
  Set oRe = Nothing
End Function


Sub List_LinkSubmitTag()
	Dim n1ListSearchGrade ' 검색기간설정
	Dim n4ListSearchDate,searchOrgDate  ' 검색기간

	n1ListSearchGrade = cmObj.getCookie("n1Status14")
	n4ListSearchDate  = cmObj.getCookie("n1Status15")
	
	'n1ListSearchGrade="1"
	'n4ListSearchDate ="0"

	if n4ListSearchDate = "" then n4ListSearchDate = 0
	
	If n1ListSearchGrade="0" then
		searchOrgDate = dateAdd("d",(n4ListSearchDate*-1)+1,date)
	else
		searchOrgDate = "0"
	End if 
	Response.write "<a href=""javascript:frmSubmit('"&n1ListSearchGrade&"','"&n4ListSearchDate&"','"&searchOrgDate&"')"">"
	Response.write "<img src='/images/common/icon_confirm.gif'  border='0' align=absmiddle></a>"
End Sub

'//전체보기 클릭시
Sub List_LinkSubmitTag_All()
	Dim n1ListSearchGrade ' 검색기간설정
	Dim n4ListSearchDate,searchOrgDate  ' 검색기간

	n1ListSearchGrade = cmObj.getCookie("n1Status14")
	n4ListSearchDate  = cmObj.getCookie("n1Status15")
	
	'n1ListSearchGrade="1"
	'n4ListSearchDate ="0"

	if n4ListSearchDate = "" then n4ListSearchDate = 0
	
	If n1ListSearchGrade="0" then
		searchOrgDate = dateAdd("d",(n4ListSearchDate*-1)+1,date)
	else
		searchOrgDate = "0"
	End if 

	Response.write "<a href=""javascript:go_action('allview','"&n1ListSearchGrade&"','"&n4ListSearchDate&"','"&searchOrgDate&"')"">"
	Response.write "<img src='/images/common/icon_allview.gif'  border='0' align=absmiddle></a>"
End Sub

'*======================================================================================
Sub tooltip(boxObjID,content)
%>
	<div id="d<%=boxObjID%>" style="position:absolute;top:0left:0;z-index:20;width:200;filter:revealTrans(duration=0);visibility:hidden;">
		<table width=400 cellpadding=2 cellspacing=1 bgcolor=black>
			
			<tr bgcolor=#ffffff><td style='padding:10;'><%=content%></td></tr>	
		</table>													
	</div>
<%
End sub

'예약상태값 표시
Function reservation_n1RvStatus(str)
	if str="0" then 
		reservation_n1RvStatus="예약중"
	elseIf  str="1" then 
		reservation_n1RvStatus="영업완료"

	elseIf  str="2" then 
		reservation_n1RvStatus="예약취소"

	elseIf  str="3" then 
		reservation_n1RvStatus="예약변경"
	elseIf  str="4" then 
		reservation_n1RvStatus="연락안됨"
	elseIf  str="5" then 
		reservation_n1RvStatus="상담중"

	elseIf  str="6" then 
		reservation_n1RvStatus="시술중"
	elseIf  str="7" then 
		reservation_n1RvStatus="회복중"
	elseIf  str="8" then 
		reservation_n1RvStatus="치료중"
	elseIf  str="9" then 
		reservation_n1RvStatus="귀가"
	End if
End Function

Function reservation_n1RvStatus_Color(str)
	if str="0" then 
		reservation_n1RvStatus_Color="blue"
	elseIf  str="1" then 
		reservation_n1RvStatus_Color="green"

	elseIf  str="2" then 
		reservation_n1RvStatus_Color="red"

	elseIf  str="3" then 
		reservation_n1RvStatus_Color="#CC0066"
	elseIf  str="4" then 
		reservation_n1RvStatus_Color="#996600"
	elseIf  str="5" then 
		reservation_n1RvStatus_Color="orange"

	elseIf  str="6" then 
		reservation_n1RvStatus_Color="#FFCC00"
	elseIf  str="7" then 
		reservation_n1RvStatus_Color="#9933FF"
	elseIf  str="8" then 
		reservation_n1RvStatus_Color="#000000"
	elseIf  str="9" then 
		reservation_n1RvStatus_Color="#333399"
	End if
End Function



'**************************************
'*	데이타 압축하기 : 압축로그 있는지 끝
'**************************************

Function convert_gokiday_kor(str)

		
	if str="0" then
		convert_gokiday_kor="사용"
	elseif  str="2" then
		convert_gokiday_kor="전환"
	elseif str ="3" then
		convert_gokiday_kor ="<FONT COLOR=red>해지</FONT>"
	elseif Str ="4" then
		convert_gokiday_kor= "<FONT COLOR=blue>직권정지</font>"
	elseif str="5" then
		convert_gokiday_kor= "<FONT COLOR=blue>일시정지</font>"
	elseif Str="6" then
		convert_gokiday_kor= "<FONT COLOR=red>비청약</font>"
	else
		convert_gokiday_kor= str
	end if
End Function

Function Convert_perCent(child_Num,mother_Num,dotLen)
	if isnull(mother_Num) then mother_Num = 0
	if isnull(child_Num) then  child_Num =0
	If mother_Num=0 Then
		Convert_perCent = 0
	Elseif child_Num = 0 Then
		Convert_perCent = 0
	Else
		Convert_perCent = FormatperCent(child_Num/mother_Num,dotLen)
	End IF
End Function

Function Convert_NumRate(child_Num,mother_Num,dotLen)
	if isnull(mother_Num) then mother_Num = 0
	if isnull(child_Num) then  child_Num =0
	If mother_Num=0 Then
		Convert_NumRate = 0
	Elseif child_Num = 0 Then
		Convert_NumRate = 0
	Else
		Convert_NumRate = Formatnumber(child_Num/mother_Num,dotLen)
	End IF
End Function

Function Convert_Number(str)
	if isnull(str) then str="0"
	if str="0" Then
		Convert_Number =""
	else
		Convert_Number=Formatnumber(str,0)
	End if
End Function

Function cutStr(str, cutLen) 
	Dim strLen, strByte, strCut, strRes, char, i 
	strLen = 0 
	strByte = 0 
	strLen = Len(str) 
	for i = 1 to strLen 
		char = "" 

		strCut = Mid(str, i, 1) ' 일단 1만큼 잘라서 strRes에 저장한다. 
		char = Asc(strCut) ' 아스키 코드값 읽어오기 
		char = Left(char, 1) 
		
		if char = "-" then ' "-"이면 2바이트 문자임 
			strByte = strByte + 2 
		else 
			strByte = strByte + 1 
		end if 

		if cutLen < strByte then 
			strRes = strRes & ".." 
		exit for 
			else 
			strRes = strRes & strCut 
		end if 
	next 
	cutStr = strRes 
End Function 


Function Chain_Board_Type(str)

	IF Right(str,1)="1" Then
		Chain_Board_Type="전용게시판"
	Elseif Right(str,1)="2" Then
		Chain_Board_Type="교육게시판"
	Elseif Right(str,1)="3" Then
		Chain_Board_Type="제품주문"
	ElseIf Right(str,1)="4" Then
		Chain_Board_Type="쪽지게시판"
	ElseIf Right(str,1)="5" Then
		Chain_Board_Type="공지사항"
	ElseIf Right(str,1)="6" Then
		Chain_Board_Type="구인구직"
	Else
		Chain_Board_Type="Error"
	End IF

End Function

Function Chain_Board_TBLNAME(str)

	IF str="560" Then
		Chain_Board_TBLNAME="Chain_Board"
	Elseif str="575" Then
		Chain_Board_TBLNAME="Chain_Board"
	Else
		Chain_Board_TBLNAME="Chain_Board"
	End IF

End Function

function checkBadString(s)
	s = trim(s)
	s = replace(s, "'", "\'")
	s = replace(s,  Chr(34), "\"& Chr(34))
	checkBadString = s

end function

Function RemoveInjectionString(inputString)
	Dim OutputString

	OutputString = InputString
	OutputString = Replace(OutputString, """", "&quot;")
	OutputString = Replace(OutputString, "'", "&#39;")
	OutputString = Replace(OutputString, "/", "&#47;")
	OutputString = Replace(OutputString, "\", "&#92;")
	OutputString = Replace(OutputString, ",", "&#44;")
	OutputString = Replace(OutputString, Chr(10), "&#10;")
	OutputString = Replace(OutputString, Chr(13), "<br/>")
	OutputString = Replace(OutputString, "NULL", "")

	RemoveInjectionString = OutputString
End Function




Function Replace_SQLInjection(s)
  s = Trim(s) 
  
  s = Replace(s, "'", "`")

  s = Replace(s, ";", "") 
  s = Replace(s, "--", "") 
'  s = Replace(s, "@", "") 
  s = Replace(s, "@variable", "") 
  s = Replace(s, "@@variable", "") 
'  s = Replace(s, "+", "") 
'  s = Replace(LCase(s), "print", "") 
'  s = Replace(LCase(s), "set", "") 
'  s = Replace(s, "%", "") 
'  s = Replace(LCase(s), "or", "") 
'  s = Replace(LCase(s), "union", "") 
'  s = Replace(LCase(s), "and", "") 
'  s = Replace(LCase(s), "insert", "") 
'  s = Replace(LCase(s), "openrowset", "")
'  s = Replace(s, "<", "&lt;")
'  s = Replace(s, ">", "&gt;") 
'   s = Replace(s, "(", "&#40;") 
'  s = Replace(s, ")", "&#41;") 
 ' s = Replace(s, "#", "&#35;") '트래킹데서 구분자로 사용했음.
  s = Replace(s, "&", "&#38;") 
  
  s = Replace(s, "alert", "")
  s = Replace(s, "script", "")
  s = Replace(s , Chr(34), "＂")

  Replace_SQLInjection  = s 
End Function

''@~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
public function PageList(intNowPage , intTotalPage  , url  , addStr   ,intBlockPage  )

Dim intTemp 
Dim intLoop 
Dim PageStr 

intTemp = Int((intNowPage - 1) / intBlockPage) * intBlockPage + 1 



If intTemp = 1 Then 
	PageStr = PageStr & "<img src=/IVR/images/common/icon_arrPrev1.gif width=19 height=13 border=0>&nbsp;&nbsp;&nbsp;&nbsp;" 
Else 
	PageStr = PageStr & "<a href='" & url & "?n4page=" & intTemp - intBlockPage 
	If addStr <> "" Then 
		PageStr = PageStr & addStr 
	End If 
	PageStr = PageStr & "' onFocus=blur()><img src=/IVR/images/common/icon_arrPrev1.gif width=19 height=13 border=0></a>&nbsp;&nbsp;&nbsp;&nbsp;" 
End If 

intLoop = 1 

Do Until intLoop > intBlockPage Or intTemp > intTotalPage 
	If intTemp = CInt(intNowPage) Then 
		PageStr = PageStr & " | <font size= 3><b>" & intTemp & "</b></font>&nbsp;" 
	Else 
		PageStr = PageStr & " | <a href='" & url & "?n4page=" & intTemp 
		If addStr <> "" Then 
			PageStr = PageStr & addStr 
		End If 
		PageStr = PageStr & "'>" & intTemp & "</a>&nbsp;" 
	End If 
	intTemp = intTemp + 1 
	intLoop = intLoop + 1 
Loop 

if intLoop <> 1 then
PageStr = PageStr & "| " 
else
PageStr = PageStr & "| <font size= 3><b>0</b></font> |" 
end if

If intTemp > intTotalPage Then 
	PageStr = PageStr & "&nbsp;&nbsp;&nbsp;&nbsp;<img src=/IVR/images/common/icon_arrNext1.gif width=19 height=13 border=0>" 
Else 
	PageStr = PageStr & "&nbsp;&nbsp;&nbsp;&nbsp;<a href='" & url & "?n4page=" & intTemp 
	If addStr <> "" Then 
		PageStr = PageStr & addStr 
	End If 
	PageStr = PageStr & "' onFocus=blur()><img src=/IVR/images/common/icon_arrNext1.gif width=19 height=13 border=0></a>" 
End If 
PageList = PageStr

PageList=PageStr
end function
''@~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Function sale_PrintPage(n2Page, TotalPage)

	dim Prev10, Page1

	Prev10 = (int((n2Page+9)/10) * 10) + 1

	Page1 = Prev10 - 10

		if Prev10 <> "11" then
			strpageing = strpageing &  "<a href='javascript:pagegoto("&Page1-1&")'><img src=""/images/common/icon_arrPrev10.gif"" border=""0"" align=""absmiddle""></a>&nbsp;"
		end if 
		if n2Page > 1 then
			strpageing = strpageing &  "<a href='javascript:pagegoto("&n2Page - 1&")'><img src=""/images/common/icon_arrPrev1.gif"" border=""0"" align=""absmiddle""></a>"
		end if 

        if TotalPage = "" then 
			TotalPage = 1
        end if 		
	strpageing = strpageing &  "&nbsp;|&nbsp;"
	do until Page1 = Prev10 or Page1 > TotalPage
	if Cint(Page1) = Cint(n2Page) then
		strpageing = strpageing &  "<b>"&Page1&"</b>"
	else
		strpageing = strpageing &  "<a href='javascript:pagegoto("&Page1&");'>"&Page1&"</a>"
	end if
	
	Page1 = Page1 + 1
	strpageing = strpageing &  "&nbsp;|&nbsp;"
	loop

		if  int(TotalPage) > int(n2Page)  then
			strpageing = strpageing &  "<a href='javascript:pagegoto("&n2Page + 1&")'><img src=""/images/common/icon_arrNext1.gif"" border=""0"" align=""absmiddle""></a>&nbsp;"
		end if

		if Prev10 <> int((Cint(TotalPage) + 10) / 10) * 10 + 1 then
			strpageing = strpageing &  "<a href='javascript:pagegoto("&Page1&")'><img src=""/images/common/icon_arrNext10.gif"" border=""0"" align=""absmiddle""></a>"
		end if
	sale_PrintPage = strpageing
End Function


Function js_alert_back(str)
%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		alert("<%=str%>");
		history.back();
	//-->
	</SCRIPT>
<%
	response.end
End Function



sub Show_HElP(str)
%>
		 <table width=100% align=center valign=top border=0 cellpadding=0 cellspacing=0>
		     <tr>
			   <td height=1 bgcolor=b2b5e1></td>
			 </tr>
		     <tr>
			   <td height=1 ></td>
			 </tr>
		     <tr>
			   <td align=center valign=middle bgcolor=ebebf6>
			     <!---------도움말내용----------->
		           <table width=100% align=center valign=top border=0 cellpadding=0 cellspacing=0>
				     <tr>
					   <td height=5></td>
					 </tr>
				     <tr>
					   <td width=15% align=center valign=middle>
					     <img src="/images/manager/n_help.gif"></td>
					   <td width="*" align=left valign=middle><%=str%>
 					   </td>
					 </tr>
				     <tr>
					   <td height=5></td>
					 </tr>
				   </table>
				 <!--------도움말내용끝----------->
			   </td>
			 </tr>
		     <tr>
			   <td height=1 ></td>
			 </tr>
		     <tr>
			   <td height=1 bgcolor=b2b5e1></td>
			 </tr>
		   </table>
<%
End Sub
%>

<%
Function dispAlertAndBack(alertMsg)
	Dim strBody
	
	strBody = "<script language=javascript>" & VbCrLf	
	strBody = strBody & "	alert(""" & alertMsg & """);" & VbCrLf
	strBody = strBody & "	history.go(-1);" & VbCrLf	
	strBody = strBody & "</script>" & VbCrLf	
	
	response.write strBody
	response.end
End Function
%>