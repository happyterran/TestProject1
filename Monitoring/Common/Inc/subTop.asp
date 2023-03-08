<%
	'if lcase(request.servervariables("SERVER_Name")) <> "junohair.bizmeka.com" and lcase(request.servervariables("SERVER_NAME")) <> "junowork.bizmeka.com" then
%>					
<script language = "javascript">
function quick_goods_info(oidCustomer)
{
	var url = "/sale/goods/goods_info.asp?isPop=1&oidCustomer="+oidCustomer +'&n1Sale=1';
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-400;
	window.open(url,"quick_goods_info_win","scrollbars=yes,width=800,height=600,top="+h+",left="+w+',resizable=1');
}
function quick_rv_info(oidCustomer)
{
	var url = "/sale/reservation/rv_info.asp?oidCustomer="+oidCustomer+"&isPop=1";
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-425;
	window.open(url,'quick_rv_info_win','width=850,height=600,top='+h+',left='+w+',scrollbars=1,resizable=1,status=yes');
}
function quick_SMS_info(oidCustomer)
{
	var url = "/sale/business/SMS_info.asp?oidCustomer="+oidCustomer+"&isPop=1";
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-400;
	window.open(url,'quick_SMS_info_win',"width=800,height=600,top="+h+",left="+w);
}
function quick_advance_input(oidCustomer)
{
	var url = "/sale/advance/advance_input.asp?oidCustomer="+oidCustomer;
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-400;
	window.open(url,'quick_SMS_info_win','width=800,height=600,top='+h+',left='+w);
}
function hairClinic_input(oidCustomer, pathCheck, oidStore){
	var url = "/sale/hairClinic/hair_capture_write.asp?oidStore="+oidStore+"&oidCustomer="+oidCustomer+"&pathCheck="+pathCheck;
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-400;
	window.open(url,'quick_SMS_info_win','width=800,height=650,top='+h+',left='+w+',scrollbars=1,resizable=1');
}
function quick_coupon_input(oidCustomer)
{
	var url = "/sale/coupon/coupon_reg.asp?oidCustomer="+oidCustomer;
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-400;
	window.open(url,'quick_SMS_info_win','width=800,height=600,status=yes,top='+h+',left='+w);
}
function Customer_ChartPrint()
{
	
	var url = "/sale/business/bu_Chart<%IF cmObj.getCookie("oidStoreGroup")=Xeo_oidStoreGroup or cmObj.getCookie("oidStoreGroup")=Franck_oidStoreGroup then response.write "_xeo"%>.asp?oidCustomer=<%=oidCustomer%>"
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-350;

	window.open(url,'POPChart','scrollbars=yes,width=700,height=600,top='+h+',left='+w+', status=yes')

}
function Chart_Print()
{
	var url = "/sale/business/bu_Chart.asp?oidCustomer=0"
	var h = (screen.height/2)-350;
	var w = (screen.width/2)-350;

	window.open(url,'POPChart','scrollbars=yes,width=700,height=600,top='+h+',left='+w+', status=yes')
}

</script>
												<table border="0" cellspacing="0" cellpadding="0" width="100%">
													<tr>
														
														<td class="bt" height="35" width="90"><img src="/images/common/dot_tit07.gif" align=absmiddle><font size="3" color="003366"><B>영업</B></font></td>
														<td align="right">

	<%	if cstr(oidCustomer) <> "" then %>														

	
		<%IF cmObj.getCookie("oidStoreGroup")<>Xeo_oidStoreGroup and cmObj.getCookie("oidStoreGroup")<>Franck_oidStoreGroup Then%>
	| <a href="javascript:hairClinic_input('<%=oidCustomer%>','sale',<%=cmObj.getCookie("oidStore")%>);"><font color="navy"><b>두피진단</b></font></a>
		<%End IF%>
	<% if cstr(oidCustomer) > "0" and GuestYN<>"1" then %>

	| <a href="javascript:quick_advance_input('<%=oidCustomer%>');"><font color="navy"><b>선불판매</b></font></a>
	| <a href="javascript:quick_coupon_input('<%=oidCustomer%>');"><font color="navy"><b>쿠폰판매</b></font></a>
	<% end if %>

| <a href="javascript:quick_goods_info('<%=oidCustomer%>');" class="left1"><FONT COLOR="navy"><b>제품판매</b></FONT></a>

	
	| <a href="javascript:quick_rv_info('<%=oidCustomer%>');" class="left1"><FONT COLOR="navy"><b>예약입력</b></font></a>
	<!--| <a href="#" onClick="window.open('/sale/business/bu_Reserve.asp?oidCustomer=<%=oidCustomer%>&isPop=1','POPReserver','width=800,height=600');" onfocus="blur()" class="left1"><FONT  COLOR="blue">예약내역</font></a>-->	
	<%if cstr(oidCustomer) > "0" and GuestYN<>"1" then %>
	| <a href="javascript:Customer_ChartPrint()" class="left1">고객차트출력</a>
	<% end if %>


					
	<% end if %>
														</td>
													</tr>
												</table>
												
												