
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
<tr>
	<td width="*" align=left>
	<img src="/IVR/images/logoimg/LG-Electronics_RGB.jpg" width="180" height="40" border="0">	
	</td>



	<td>
		
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



		  <tr>
			<td align=left valign=top
<%
				Response.Write " bgcolor='dedede'"
%>			
			>



<%
TopImgNum_for_MP = "1"
%>

<table border="0" cellspacing="0" cellpadding="0"  style="margin-left:340px;">
<tr>
	<td><a href="/IVR/src/monitoring/monitoring.asp"><img src="/IVR/images/2009Top/red_top01.gif" border="0" onmouseover="this.src='/IVR/images/2009Top/red_top01.gif';" onmouseout="this.src='/IVR/images/2009Top/red_top01.gif';"></a></td>

	<td><a href="/IVR/src/Service/svManager.asp"><img src="/IVR/images/2009Top/red_top02.gif" border="0" onmouseover="this.src='/IVR/images/2009Top/red_top02.gif';" onmouseout="this.src='/IVR/images/2009Top/red_top02.gif';"></a></td>

	<TD><a href="/IVR/src/Static/ch_sv_static.asp"><img src="/IVR/images/2009Top/red_top03.gif" border="0"></a></td>

	<TD><a href="/IVR/src/Errhistory/err_history.asp"><img src="/IVR/images/2009Top/red_top04.gif" border="0"></a></td>

	<TD><a  href="/IVR/src/Admin/admin.asp"><img src="/IVR/images/2009Top/black_top.gif" border="0" ></a></td>


</tr>
</table>

			</td>
		  </tr>
		</table>

	</td>
</tr>
</table>





<div id="mpTopBanner" style="position:absolute; left:905px; top:2px; width:95px; height:70px; z-index:1; display:;">


