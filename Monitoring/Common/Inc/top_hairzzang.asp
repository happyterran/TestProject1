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
//*	���鰪 üũ �� �� �˻��׸� ���� ��üũ�� �ٸ���..
//*	by zinny
//********************************************

	// �� �Ǵ� ���鰪�� ���� ���..
	var val = g.strSearch.value ; 
	if (checkstr(val," ","") ==0){
		alert("�˻�� �ùٷ� �Է��ϼ���");
		g.strSearch.focus(); return false ; 
	}

	// ����ȣ�� �˻��ϴ� ���..
	if (g.n1Search.value == "4"){
		if (isNaN(g.strSearch.value)){
			alert("����ȣ�� ���ڸ� �Է��ϼ���");
			g.strSearch.focus(); return false ;
		}
	}
		
	// ��ȭ��ȣ�� �˻��ϴ� ���
	if (g.n1Search.value == "1" || g.n1Search.value == "3"){
		for (var i = 0 ; i < g.strSearch.value.length ; i++){
			if (val.charAt(i) >= 0 && val.charAt(i) <= 9)
				continue ; 
			else if (val.charAt(i) == "-")
				continue ; 
			else{
				alert("�˻�� �ùٷ� �Է��ϼ���");
				g.strSearch.focus(); return false ;
			}
		}
	}



//********************************************		
}

// �����׸� ���� �ڵ� �ѿ�Ű��ȯ�ϱ�
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
//## �������Ѽ��� �߰���� ##


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
	'//������ n1Search��Ű���� ��򼱰� ��� �ʱ�ȭ�� �ǰ� ����. n1Search_Top���� �ٲ�.
	Top_n1Search = Request.Cookies("n1Search_Top")
	if  Top_n1Search="" then
		Top_n1Search = "4"
	end if 


%>		

		<table width=100% align=left valign=top border=0 cellpadding=0 cellspacing=0>
		  <tr>
			<td align=left valign=top>
			  <!----------�����˻�------------->
				<table width=741 align=left valign=top border=0 cellpadding=0 cellspacing=0>
				  <tr>
					<td width=14 align=left valign=top>
					  <img src="/IVR/images/2009Top/top_back01.gif"></td>
					<td width=713 align=left background="/IVR/images/2009Top/top_back02.gif">
					  <!-----��------------->
<table width=100% align=left valign=top border=0 cellpadding=0 cellspacing=0>
<form name="frmMoveTop" method="post" action="/sale/common/bu_list.asp" onsubmit = "return searchsearch();">
<tr>
	<td width="*" align=left>
	
		<!-- <select name="n1Search" onChange="n1SearchChange(this.value);">
			<option value='4' <% if cstr(Top_n1Search) = "4" then %>Selected<% End if %>>����ȣ</option>
			<option value='1' <% if cstr(Top_n1Search) = "1" then %>Selected<% End if %>>��ȭ��ȣ</option>
			<option value='2' <% if cstr(Top_n1Search) = "2" then %>Selected<% End if %>>����</option>
			<option value='3' <% if cstr(Top_n1Search) = "3" then %>Selected<% End if %>>�޴���</option>
			<option value='6' <% if cstr(Top_n1Search) = "6" then %>Selected<% End if %>>��ȭ+�޴���</option>
			<option value='5' <% if cstr(Top_n1Search) = "5" then %>Selected<% End if %>>�������</option>
		</select> -->

		

		<!-- <input type="text" name="strSearch" size="10">
		<input type="image" src="/IVR/images/2009Top/top_icon01.gif" align="absmiddle">
		<A href="/sale/common/Guest_Check.asp?strURLType=top"><img src="/IVR/images/2009Top/top_icon02.gif" align="absmiddle"></a> -->
	</td>
</form>


	<td>
		<!-- <img src="/IVR/images/2009Top/top_text02.gif" align="absmiddle">
		<select name = "di_radio">
		<option value = "1" <%if hour(now) <= 14 Then response.write "selected"%>>���</option>
		<option value = "2" <%if hour(now) > 14 Then response.write "selected"%>>���</option>
		</select>
		<input type = "text" name = "strSearch1" size = "10">
		<input type="image" src="/IVR/images/2009Top/top_icon03.gif" align="absmiddle"> -->
	</td>
	


<td width=12% align=center>
	<!-- <a href="/board/remote_Control/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=����Ÿ&depth2=���ݻ���û','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/2009Top/top_icon04.gif"></a></td> -->
</tr>
</table>
					  <!-----�󼼳�------------->
					</td>
					<td width=14 align=left valign=top>
					  <img src="/IVR/images/2009Top/top_back03.gif"></td>
				</tr>
			  </table>

			  <!--------�����˻���------------->
			</td>
		  </tr>
		  <tr>
			<td height=13></td>
		  </tr>


<%
'*****************************************
'*	���¯������ ���α����� sso ������ ����
'*****************************************
Dim sso_userid, sso_strClass, sso_strClassCode

	sso_userid		= request.Cookies("userid")
	sso_strClass	= request.Cookies("strClass")
	
	select case sso_strClass
		case "����" : sso_strClassCode = 1
		case "����" : sso_strClassCode = 2
		case "����" : sso_strClassCode = 2
		case "�븮" : sso_strClassCode = 2
		case "��Ÿ" : sso_strClassCode = 3
		case "���" : sso_strClassCode = 3
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
	<td><a href="/sale/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=����','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n01.gif';"></a></td>

	

	<td><a href="/tracking/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=Ʈ��ŷ','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n06.gif';"></a></td>

	<td><a href="/setup/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=ȯ�漳��','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n07.gif';"></a></td>

	<td><a href="/inform/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=�ΰ�����','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n08.gif';"></a></td>

	<td><a href="/board/" onclick = "sendRequest(on_loadCRMLOG,'&depth1=����Ÿ','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09.gif" border="0" onmouseover="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09o.gif';" onmouseout="this.src='/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n09.gif';"></a></td>


	<TD><a href="javascript:go_mp('');" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=��Ƽ����','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n10.gif" border="0"></a></td>
	<TD><a href="javascript:go_management();" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=������','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n11.gif" border="0"></a></td>
	<TD><a href="javascript:Go_JOB();" onclick = "sendRequest(on_loadCRMLOG,'&depth1=SSO&depth2=���α���','get','/common/func/crmCount.asp',true,true)"><img src="/IVR/images/Pro/pro_top0<%=TopImgNum_for_MP%>_n12.gif" border="0"></a></td>


</tr>
</table>

			</td>
		  </tr>
		</table>

	</td>
</tr>
</table>





<div id="mpTopBanner" style="position:absolute; left:905px; top:2px; width:95px; height:70px; z-index:1; display:;">


