
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
<tr>
	<td width="*" align=left>
	<img src="/IVR/images/logoimg/LG-Electronics_RGB.jpg" width="180" height="40" border="0">	
	</td>



	<td>
		
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


