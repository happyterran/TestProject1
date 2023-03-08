<%


%>
<script language = "javascript" src = "/common/js/checkstr.js"></script>
<script language="javascript">
function focusPoint()
{
	document.all.frmMoveTop.strSearch.focus();
}

function searchsearch()
{
	var g = document.all.frmMoveTop;
//********************************************
//*	공백값 체크 및 각 검색항목에 따른 폼체크를 다르게..
//*	by zinny
//********************************************

	// 빈값 또는 공백값이 들어온 경우..
	var val = g.strSearch.value ; 
	if (checkstr(val," ","") ==0){
		alert("검색어를 올바로 입력하세요");
		g.strSearch.focus(); return false ; 
	}

	// 고객번호로 검색하는 경우..
	if (g.n1Search.value == "4"){
		if (isNaN(g.strSearch.value)){
			alert("고객번호는 숫자만 입력하세요");
			g.strSearch.focus(); return false ;
		}
	}
		
	// 전화번호로 검색하는 경우
	if (g.n1Search.value == "1" || g.n1Search.value == "3"){
		for (var i = 0 ; i < g.strSearch.value.length ; i++){
			if (val.charAt(i) >= 0 && val.charAt(i) <= 9)
				continue ; 
			else if (val.charAt(i) == "-")
				continue ; 
			else{
				alert("검색어를 올바로 입력하세요");
				g.strSearch.focus(); return false ;
			}
		}
	}



//********************************************		
}

// 선택항목에 따라 자동 한영키전환하기
function n1SearchChange(sval)
{
	if (sval == "2" || sval == "5"){
		document.all.frmMoveTop.strSearch.style.imeMode = "active";
	}
	else {
		document.all.frmMoveTop.strSearch.style.imeMode = "inactive";
	}
	document.all.frmMoveTop.strSearch.focus();
}
//## 직원권한설정 추가기능 ##


</script>

<style>
IMG {border: none;}
</style>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td rowspan="2" width="10" valign="bottom">


	</td>
	<td height="47">

<%
	Dim Top_n1Search
	'//기존의 n1Search쿠키값이 어딘선가 계속 초기화가 되고 있음. n1Search_Top으로 바꿈.
	Top_n1Search = Request.Cookies("n1Search_Top")
	if  Top_n1Search="" then
		Top_n1Search = "4"
	end if 


%>		

		<table width=100% align=left valign=top border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td align=left valign=top>
			  <!----------빠른검색------------->
				<table width=741 align=left valign=top border=0 cellpadding=0 cellspacing=0>
				  <tr>
					<td width=14 align=left valign=top>
					  <img src="/IVR/images/2009Top/top_back01.gif"></td>
					<td width=713 align=left background="/IVR/images/2009Top/top_back02.gif">
					  <!-----상세------------->
<table width=100% align=left valign=top border=0 cellpadding=0 cellspacing=0>
<form name="frmMoveTop" method="post" action="/sale/common/bu_list.asp" onsubmit = "return searchsearch();">
<tr>
	<td width="*" align=left>
	
		<!-- <select name="n1Search" onChange="n1SearchChange(this.value);">
			<option value='4' <% if cstr(Top_n1Search) = "4" then %>Selected<% End if %>>고객번호</option>
			<option value='1' <% if cstr(Top_n1Search) = "1" then %>Selected<% End if %>>전화번호</option>
			<option value='2' <% if cstr(Top_n1Search) = "2" then %>Selected<% End if %>>성명</option>
			<option value='3' <% if cstr(Top_n1Search) = "3" then %>Selected<% End if %>>휴대폰</option>
			<option value='6' <% if cstr(Top_n1Search) = "6" then %>Selected<% End if %>>전화+휴대폰</option>
			<option value='5' <% if cstr(Top_n1Search) = "5" then %>Selected<% End if %>>참고사항</option>
		</select> -->

		

		<!-- <input type="text" name="strSearch" size="10">
		<input type="image" src="/IVR/images/2009Top/top_icon01.gif" align="absmiddle">
		<A href="/sale/common/Guest_Check.asp?strURLType=top"><img src="/IVR/images/2009Top/top_icon02.gif" align="absmiddle"></a> -->
	</td>
</form>


	<td>
		<!-- <img src="/IVR/images/2009Top/top_text02.gif" align="absmiddle">
		<select name = "di_radio">
		<option value = "1" <%if hour(now) <= 14 Then response.write "selected"%>>출근</option>
		<option value = "2" <%if hour(now) > 14 Then response.write "selected"%>>퇴근</option>
		</select>
		<input type = "text" name = "strSearch1" size = "10">
		<input type="image" src="/IVR/images/2009Top/top_icon03.gif" align="absmiddle"> -->
	</td>
	


<td width=12% align=center>
	<!-- <a href="/board/remote_Control/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=고객센타&depth2=원격상담요청','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/2009Top/top_icon04.gif"></a></td> -->
</tr>
</table>
					  <!-----상세끝------------->
					</td>
					<td width=14 align=left valign=top>
					  <img src="/IVR/images/2009Top/top_back03.gif"></td>
				</tr>
			  </table>

			  <!--------빠른검색끝------------->
			</td>
		  </tr>
		  <tr>
			<td height=13></td>
		  </tr>


<%
'*****************************************
'*	헤어짱닷컴의 구인구직과 sso 연동을 위해
'*****************************************
Dim sso_userid, sso_strClass, sso_strClassCode

	sso_userid		= request.Cookies("userid")
	sso_strClass	= request.Cookies("strClass")
	
	select case sso_strClass
		case "사장" : sso_strClassCode = 1
		case "부장" : sso_strClassCode = 2
		case "과장" : sso_strClassCode = 2
		case "대리" : sso_strClassCode = 2
		case "기타" : sso_strClassCode = 3
		case "사원" : sso_strClassCode = 3
	End select
	
%>


<%	
	Dim TopImgNum_for_MP

	if realMenu__ = "main" then
		TopImgNum_for_MP			= "1"
	elseif realMenu__ = "sale" then
		TopImgNum_for_MP			= "1"
	elseif realMenu__ ="regist" then
		TopImgNum_for_MP			= "2"
	elseif realMenu__ ="manager" then
		TopImgNum_for_MP			= "3"
	elseif realMenu__ ="list" then
		TopImgNum_for_MP			= "4"
	elseif realMenu__ ="account_beta" then
		TopImgNum_for_MP			= "5"
	elseif realMenu__ ="tracking" then
		TopImgNum_for_MP			= "5"
	elseif realMenu__ ="setup" then
		TopImgNum_for_MP			= "6"
	elseif realMenu__ ="inform" then
		TopImgNum_for_MP			= "7"
	elseif realMenu__ ="board" then
		TopImgNum_for_MP			= "8"
	else 
		TopImgNum_for_MP			= "0"
	end if
%>

		  <tr>
			<td align=left valign=top
<%
				Response.Write " bgcolor='dedede'"
%>			
			>





<%
TopImgNum_for_MP = "1"
%>

<table border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td><a href="/sale/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=영업','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01.gif';"></a></td>

	

	<td><a href="/tracking/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=트래킹','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06.gif';"></a></td>

	<td><a href="/setup/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=환경설정','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07.gif';"></a></td>

	<td><a href="/inform/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=부가서비스','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08.gif';"></a></td>

	<td><a href="/board/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=고객센타','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09.gif';"></a></td>


	<TD><a href="javascript:go_mp('');" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=뷰티마켓','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n10.gif" border="0"></a></td>
	<TD><a href="javascript:go_management();" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=마케팅','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n11.gif" border="0"></a></td>
	<TD><a href="javascript:Go_JOB();" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=구인구직','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n12.gif" border="0"></a></td>


</tr>
</table>

			</td>
		  </tr>
		</table>

	</td>
</tr>
</table>





<div id="mpTopBanner" style="position:absolute; left:905px; top:2px; width:95px; height:70px; z-index:1; display:;">


