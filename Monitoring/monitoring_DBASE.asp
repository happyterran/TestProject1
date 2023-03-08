<!--#include virtual ="/Monitoring/common/inc/aspinit.asp" -->
<!--#include virtual ="/Monitoring/common/inc/header.asp" -->
<!--#include virtual="/include/Dbopen.asp" -->
<% session.CodePage = "949" %>
<% Response.CharSet = "euc-kr" %>
<%
	Set eDbcon = Server.CreateObject("ADODB.Connection") 
	eDbcon.ConnectionTimeout = 30
	eDbcon.CommandTimeout = 30
	eDbcon.Open (DbaseConnectionString)

	''@ 보드당 보여줄 채널 갯수 정보 어디선가 가져와야 할듯.
	timeInterval = 1000  ''@ 1초 -> 1000
	boardChCnt = 20

	Dim useCnt, lineCnt
	''@~ 채널 레코드 줄 수 
	Set lineCntRs = Server.CreateObject("ADODB.Recordset")

	sql = " select count(*) from DBASE...LINERETU  "
	lineCntRs.Open Sql, eDbcon, 1, 1
'	useCnt = Rs(0)
	lineCnt = lineCntRs(0)
'
	lineCntRs.Close
	Set lineCntRs = nothing

	Set useCntRs = Server.CreateObject("ADODB.Recordset")

	'sql = " select count(*) from DBASE...LINERETU where  orderconfi = '0' and LineOrder ='END' "
	sql = " select count(*) from DBASE...LINERETU where LineOrder <>'SERVICESTOP' "
	useCntRs.Open Sql, eDbcon, 1, 1
	useCnt = useCntRs(0)
	
	useCntRs.Close
	Set useCntRs = nothing



	If lineCnt <= 0 Then 
		boardCnt = 0
	Else
		''@ 보드 갯수 계산  보드당 boardChCnt 채널로 계산
		Dim BVal, modVal

		BVal	= lineCnt / boardChCnt

		modVal	= (lineCnt mod boardChCnt)

		''@ 
		boardCnt = BVal

		''@ boardChCnt 채널 만큼 나누어 남는 채널이 있다면 보드 하나를 더해줌.
		If modVal > 0 Then 
			boardCnt = boardCnt + 1
		End If 

	End If 

%>
<title>  Project METIS MONITORING V.2 </title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="/Monitoring/common/css/style.css">
<link rel="stylesheet" href="/Monitoring/Common/Css/common.css" type="text/css">
<script src="/Monitoring/Common/js/jquery-1.7.1.min.js"></script>
<style>
IMG {border: none;}
</style>

<SCRIPT LANGUAGE="JavaScript">

 //if( Keycode(event) ==13) formCheck(this.form);
 function Keycode(e){
    var result;
    if(window.event)
    result = window.event.keyCode;
    else if(e)
    result = e.which;
    return result;
 }

function Channel_view() {

	$.ajax({

		type: 'post'
		//, async: true
		, url: 'Channel_view_DBASE.asp'
		//, data: $("#frm").serialize() 
		, data: 'boardChCnt=' + $("#boardChCnt").val()
		, success: function(msg){

			var arrRes = msg.split("@@");
			var NowTime = arrRes[0];
			//''@ 현재 시간 뿌려 주자.
			$("#uTime").text(NowTime);


			var tmpUseChlInfo = arrRes[1];
			//''@ 사용채널, 총채널 정보 뿌려 주자.
			var arrUseChlInfo = tmpUseChlInfo.split("^");
			//arrUseChlInfo.length
			$("#useChl").text(arrUseChlInfo[0]);
			$("#totChl").text(arrUseChlInfo[1]);


			//''@ 각채널의 정보를 뿌려 주자.
			var tmpChlStateInfo = arrRes[2];
			//''@ 한채널씩 배열에 담기
			var arrChlDetailInfo = tmpChlStateInfo.split("@");			
			var chlDetailCnt = arrChlDetailInfo.length;
			var arrChlData;

			for(x = 0 ; x < chlDetailCnt ; x++) { 
				arrChlData = arrChlDetailInfo[x].split("^");	
				/*
					채널번호 : arrChlData[0]
					orderconfi : arrChlData[1]
					data1 : arrChlData[2]
					data2 : arrChlData[3]
				*/
				var strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>";

				//if (arrChlData[1] == "1") {
					if (arrChlData[2] == "OFFHOOK") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>";
					} else if (arrChlData[2] == "ONHOOK") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>";
					} else if (arrChlData[2] == "PLAYVOX") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor01.gif'>";
					} else if (arrChlData[2] == "DIAL") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor01.gif'>";
					} else if (arrChlData[2] == "DRECORD") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor03.gif'>";
					} else if (arrChlData[2] == "RECORDVOX") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor03.gif'>";
					} else if (arrChlData[2] == "RECORDVOX2") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor03.gif'>";
					} else if (arrChlData[2] == "SERVICESTOP") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor05.gif'>";
					} else if (arrChlData[2] == "END") {
						strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>";
					}
				//} else {
				//	strImg = "<img src='/Monitoring/new_images/icon_Monitor05.gif'>";
				//}
				
				$("#chNum_"+arrChlData[0]).text(arrChlData[0]);
				$("#chState_"+arrChlData[0]).html(strImg);
				$("#chInfo_"+arrChlData[0]).text(arrChlData[2]);
				$("#chContent_"+arrChlData[0]).text(arrChlData[3]);
			}
		}
		// 에러 메시지일때 처리 .	
		, error: function(data, status, err) {
		// 로그 파일은 줄여 놓자.
		//	Log_send("data : " + data + "Status : " + status + ", Err : " + err);
		}
	});

	// 시간 인터벌 간격 설정을 할수 있게 
	setTimeout("Channel_view()", $("#timeInterval").val()); 
}

//'' w
function Command_view() {
	var ischecked = $('#commandInfo').attr('checked');

	if (ischecked == "checked") {
		$("#divCommand").show()
	} else {
		$("#divCommand").hide()
	}

}

function Command_send() {

	$.ajax({

		type: 'post'
		//, async: true
		, url: 'Channel_command_DBASE.asp'
		, data: $("#chlfrm").serialize() 
		, success: function(msg){
		}
		// 에러 메시지일때 처리 .	
		, error: function(data, status, err) {
		// 로그 파일은 줄여 놓자.
		//	Log_send("data : " + data + "Status : " + status + ", Err : " + err);
		}
	});	
}

function Log_send(strLog) {

	$.ajax({

		type: 'post'
		//, async: true
		, url: 'log.asp'
		, data: 'strLog='+strLog
		, success: function(msg){

		}
		// 에러 메시지일때 처리 .	
		, error: function(data, status, err) {
		}
	});	
}


</SCRIPT>
</HEAD>

<body onload="Channel_view();">
<!---- body 시작------->

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <!-- Left Start -->
      
      <td  id="content" align="center">
        <!-- Start -->
      	<table cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td id="title"><img src="/Monitoring/new_images/tit_Monitoring.gif" align="absmiddle" alt="" /></td>
			<td width="10"></td>
			<td>
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td style="margin-top:0px;"><img src="/Monitoring/new_images/icon_Person.gif" align="absmiddle" /></td>
					<td width="10"></td>
					<td><input type="checkbox" id="commandInfo" name="commandInfo" value="1" onclick="Command_view();"> Command </td>

					<td width="10"></td>
					<td>
					<select id="timeInterval">
						<option value="1000">1초 </option>
						<option value="2000">2초 </option>
						<option value="3000">3초 </option>
						<option value="4000">4초 </option>
						<option value="5000">5초 </option>
						<option value="10000">10초 </option>
						<option value="20000" selected>20초 </option>
					</select>
					 Replay </td>
					
					<td width="55"></td>
					<td><a href="javascript:self.close();"><img src="/Monitoring/new_images/btn_Logout.gif" align="absmiddle"/></a></td>

				</tr>
				</table>
			</td>

		</tr>
        </table>
        
        <!-- 채널 모니터링 Start -->

   		<table  cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td><img src="/Monitoring/new_images/box_T_L.gif" /></td>
			<!-- <td class="box_T"></td> -->
			<td width="450" style="height:6px;background:url(/Monitoring/new_images/box_T.gif) repeat-x;"></td>
			<td><img src="/Monitoring/new_images/box_T_R.gif" /></td>
		</tr>
		<tr>
		  <td class="box_L"></td>
		  <td class="box">
			
				<!-- Start -->

				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="" align="left">
					<img src="/Monitoring/new_images/icon_Monitor05.gif" align="absmiddle"> : 비사용 &nbsp;&nbsp;
					<img src="/Monitoring/new_images/icon_Monitor04.gif" align="absmiddle"> : 대기 &nbsp;&nbsp;
					<img src="/Monitoring/new_images/icon_Monitor01.gif" align="absmiddle"> : 사용 &nbsp;&nbsp;
					<img src="/Monitoring/new_images/icon_Monitor03.gif" align="absmiddle"> : 녹취 &nbsp;&nbsp;
					</td>
				</tr>
					<tr>
						<td class="" align="left">

						현재시간 : <span id="uTime" class="text10B"><%=Now()%></span> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						사용채널 : <span id="useChl" class="text10B"><%=useCnt%></span> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						총채널 : <span id="totChl" class="text10B"><%=lineCnt%></span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
				</table>
				<!-- End -->
				<!-- Start -->
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
<!-------------------------------------------------------------------------------------------------->
<%
for j = 0 to boardCnt - 1
%>
<!-------------------------------------------------------------------------------------------------->
						<td class="pdT5 L T">
							<!--Start -->

							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><img src="/Monitoring/new_images/box2_T_L.gif" /></td>
									<td class="box2_T"></td>
									<td><img src="/Monitoring/new_images/box2_T_R.gif" /></td>
								</tr>
								<tr>
								  <td class="box2_L"></td>
								  <td class="box2">
									
										<!--Start -->
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
										 <tr bgcolor="#708090">
											<td width="10%" align="center"><font color="white">채널</font></td>
											<td width="10%" align="center"><font color="white">상태</font></td>
											<td width="30%" align="center"><font color="white">회선상세</font></td>
											<td width="50%" align="center"><font color="white">회선내용</font></td>
										 </tr>
										  <tr bgcolor="#c6c6c6" height="2">
											<td colspan="4"></td>
										 </tr>
<%
		Dim chlStart, chlEnd

		Select Case j
			Case 0 :	chlStart = 1							: chlEnd = cint(boardChCnt)
			Case 1 :	chlStart = cint(boardChCnt) + 1			: chlEnd = cint(boardChCnt) * 2
			Case 2 :	chlStart = (cint(boardChCnt) * 2) + 1	: chlEnd = cint(boardChCnt) * 3
			Case 3 :	chlStart = (cint(boardChCnt) * 3) + 1	: chlEnd = cint(boardChCnt) * 4
			Case Else : chlStart = (cint(boardChCnt) * 4) + 1	: chlEnd = cint(boardChCnt) * 5
		End Select 

		Set ChlRs = Server.CreateObject("ADODB.Recordset")

		sql = ""
		sql = sql & " select LineNumber, LineOrder, Telephone, Recordfile, orderconfi  " & vbcrlf 
		sql = sql & " from DBASE...LINERETU " & vbcrlf 
		sql = sql & " where lineNumber between "& chlStart &" and "& chlEnd &" " & vbcrlf 
		
		ChlRs.Open Sql, eDbcon, 1, 1
	
		Do until ChlRs.EOF
			strChContent = ""
			
			RsChnum = ChlRs("LineNumber")
			RsLineOrder = ChlRs("LineOrder")
			RsConfi = ChlRs("orderconfi")
			RsTel = ChlRs("Telephone")
			RsRecFile = ChlRs("Recordfile")
			

'			If RsConfi = "1" Then 
'				strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>"

				Select Case RsLineOrder
					Case "OFFHOOK"	: strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>"
					Case "ONHOOK"	: strImg = "<img src='/Monitoring/new_images/icon_Monitor04.gif'>"
					Case "DIAL"		: strImg = "<img src='/Monitoring/new_images/icon_Monitor01.gif'>"
					Case "PLAYVOX"	: strImg = "<img src='/Monitoring/new_images/icon_Monitor01.gif'>"
					Case "DRECORD"	: strImg = "<img src='/Monitoring/new_images/icon_Monitor03.gif'>"
					Case "RECORDVOX": strImg = "<img src='/Monitoring/new_images/icon_Monitor03.gif'>"
					Case "END"		: strImg = "<img src='/Monitoring/new_images/icon_Monitor05.gif'>"
				End Select 

'			Else 
'				strImg = "<img src='/Monitoring/new_images/icon_Monitor05.gif'>"
'			End If 

			If RsTel <> "" Then strChContent = strChContent & RsTel & ","
			If RsRecFile <> "" Then strChContent = strChContent & RsRecFile & ","

			If Len(strChContent) > 0 Then strChContent = Left(strChContent, Len(strChContent)-1)

			
%>
										<tr>
										<td width="10%" align="center"><span id="chNum_<%=RsChnum%>" class="text10B"><%=RsChnum%></span></td>
										<td width="10%" align="center"><span id="chState_<%=RsChnum%>"><%=strImg%></span></td>
										<td width="30%" align="center"><span id="chInfo_<%=RsChnum%>"><%=RsLineOrder%></span></td>
										<td width="50%" align="center"><span id="chContent_<%=RsChnum%>"><%=strChContent%></span><td>
										</tr>											
										<tr bgcolor="#c6c6c6" height="1"><td colspan="4"></td></tr>
<%
			ChlRs.MoveNext
		Loop
		
		ChlRs.Close
		Set ChlRs = nothing
%>
										</table>
										<!-- End -->
									
								  </td>
								  <td class="box2_R"></td>
							  </tr>
								<tr>
								  <td><img src="/Monitoring/new_images/box2_B_L.gif" /></td>
								  <td class="box2_B"></td>
								  <td><img src="/Monitoring/new_images/box2_B_R.gif" /></td>
							  </tr>
							</table>
							<!--end // -->
						</td>
<!-------------------------------------------------------------------------------------------------->
<%
Next
%>
					</tr>
				</table>
		  </td>
		  <td class="box_R"></td>
		</tr>
		<tr>
			<td><img src="/Monitoring/new_images/box_B_L.gif" /></td>
			<!-- <td class="box_B"></td> -->
			<td style="height:6px;background:url(/Monitoring/new_images/box_B.gif) repeat-x;"></td>
			<td><img src="/Monitoring/new_images/box_B_R.gif" /></td>
		</tr>
        </table>
        <!--End // -->

		
		
		<!-- command 시작 -->
		<div id="divCommand" style="display:none;">
			<table  cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><img src="/Monitoring/new_images/box_T_L.gif" /></td>
				<!-- <td class="box_T"></td> -->
				<td width="450" style="height:6px;background:url(/Monitoring/new_images/box_T.gif) repeat-x;"></td>
				<td><img src="/Monitoring/new_images/box_T_R.gif" /></td>
			</tr>
			<tr>
			  <td class="box_L"></td>
			  <td class="box">
					<!-- Start -->
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="" align="left">
<%
	set Rs = Server.CreateObject("ADODB.Recordset")

	''@ 설정된 라인 갯수 가져오기.
	Sql = "select count(*) from DBASE...LINERETU "
	Rs.Open Sql, eDbcon
	TotalLine = Rs(0)
	Rs.Close
	set Rs = Nothing
%>
						<form id="chlfrm" method="post">
							<font color="#48d1cc"><b>라인, 라인명령, Tel정보, 녹취파일정보</b></font> 자료를 입력하세요. <br>
							<!-- 입력한 자료는 지정한 서버측 IP 로 전달됩니다 --><BR>
								<table width=400 align=left valign=top border=0 cellpadding=0 cellspacing=0 >
								<colgroup>
									<!-- <col style="background-color:red"> -->
									<col width="30" >
									<col width="50" >
									<col width="80" >
									<col width="80" >
									<col width="60" >
									<col width="50" >
								</colgroup>
								
								<tr bgcolor="#708090" align="center" height="25">
									<td><font color="white">라인</font></td>
									<td><font color="white">라인명령</font></td>
									<td><font color="white">Tel정보</font></td>
									<td><font color="white">녹취파일정보</font></td>
									<td><font color="white">CONFI</font></td>
									<td>&nbsp;</td>
								<tr>
								<tr>
									<td>
										<select name="LINENUMBER" id="LINENUMBER">
										<%Dim i
										for i = 1 to TotalLine%>
											<option value="<%=i%>" <%if LINENUMBER = cStr(i) then response.write "selected"%>><%=i%></option>
										<%next%>
										</select>
									</td>
									<td>
										<select name="LINEORDER" id="LINEORDER" onkeypress="if( Keycode(event) ==13) Command_send();">
											<option value="OFFHOOK">OFFHOOK</option>
											<option value="ONHOOK">ONHOOK</option>
											<option value="END">END</option>
											<option value="DIAL">DIAL</option>
											<option value="PLAYVOX">PLAYVOX</option>
											<option value="DRECORD">DRECORD</option>
											<option value="DRECORD2">DRECORD2</option>
											<option value="RECORDEND">RECORDEND</option>
											<option value="RECORDVOX">RECORDVOX</option>
											<option value="RECORDVOX2">RECORDVOX2</option>
											<option value="LINEFOUND">LINEFOUND</option>
											<option value="SERVICESTOP">SERVICESTOP</option>
											<option value="GENERALCALL">GENERALCALL</option>
											
										</select>
									</td>
									<td><input type="text" maxlength="30" name="TELEPHONE" id="TELEPHONE" size="15" onkeypress="if( Keycode(event) ==13) Command_send();"></td>
									<td><input type="text" maxlength="30" name="RECORDFILE" id="RECORDFILE" size="15" onkeypress="if( Keycode(event) ==13) Command_send();"></td>
									<td>
										<select name="ORDERCONFI" id="ORDERCONFI">
											<option value="1">1</option>
											<option value="0">0</option>
										</select>
									</td>
									<td><a href="javascript:Command_send();"><img src="/Monitoring/new_images/icon_confirm.gif" align="absmiddle"/></a></td>
								<tr>
								</table>
						</form>

						</td>
					</tr>
					</table>
					<!-- End -->
			  </td>
			  <td class="box_R"></td>
			</tr>
			<tr>
				<td><img src="/Monitoring/new_images/box_B_L.gif" /></td>
				<!-- <td class="box_B"></td> -->
				<td style="height:6px;background:url(/Monitoring/new_images/box_B.gif) repeat-x;"></td>
				<td><img src="/Monitoring/new_images/box_B_R.gif" /></td>
			</tr>
			</table>
		</div>
		<!-- command 끝 -->

      </td>
    </tr>
    

</table>
<!---- body 끝------------>
</body>
</html>

<!-- #include virtual = "/Include/Dbclose.asp" -->
<%eDbcon.Close
Set eDbcon = Nothing%>

