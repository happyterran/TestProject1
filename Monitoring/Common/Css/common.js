// JavaScript Document

// Flash

var EmbedStr = "";
function GetFlash(url,x,y) { 
	EmbedStr = "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='" + x + "' height='" + y + "'>";
	EmbedStr += "<param name='allowScriptAccess' value='always' />";
	EmbedStr += "<param name='movie' value='" + url + "' />";
	EmbedStr += "<param name='quality' value='high' />";
	EmbedStr += "<param name='bgcolor' value='#ffffff' />";
	EmbedStr += "<param name='menu' value='false' />";
	EmbedStr += "<param name='wmode' value='transparent' />";
	EmbedStr += "<embed src='" + url + "' id='flashObject' name='flashObject' quality='high' menu='false' wmode='transparent' bgcolor='#ffffff' width='" + x + "' height='" + y + "' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />";
	EmbedStr += "</object>";
	
	document.write(EmbedStr);
	return;
}
	

function layer_view (layer_name, layer_display){
	if (layer_display == "view"){
		document.getElementById(layer_name).style.display = "block" ;
	} else {
		document.getElementById(layer_name).style.display = "none" ;
	}
}

function layer_swap (view_name, hide_display){
		document.getElementById(view_name).style.display = "block" ;
		document.getElementById(hide_display).style.display = "none" ;
}


// RollOver
function imageOver(imgs) {
	imgs.src = imgs.src.replace("off.gif", "on.gif");
}
function imageOut(imgs) {
	imgs.src = imgs.src.replace("on.gif", "off.gif");
//  onmouseover="imageOver(this);" onmouseout="imageOut(this);"
} 



function topmenu(a){
	for (var i=1; i<=6; i++) 
	{	var t_name = "mMenu_"+i ;
		document.getElementById(t_name).style.visibility = "hidden" ;
	}
	var l_name = "mMenu_"+a ;
	document.getElementById(l_name).style.visibility = "visible" ;
}

function topmenu_x(a){
	var l_name = "mMenu_"+a ;
	document.getElementById(l_name).style.visibility = "hidden" ;
}
 

function main_noti(a){
	for (var i=1; i<=4; i++) 
	{	var t_name = "main_noti_"+i ;
		document.getElementById(t_name).style.display = "none" ;
	}
	var l_name = "main_noti_"+a ;
	document.getElementById(l_name).style.display = "block" ;
}  



function main_lec(a){
	for (var i=1; i<=3; i++) 
	{	var t_name = "main_lec_"+i ;
		document.getElementById(t_name).style.display = "none" ;
	}
	var l_name = "main_lec_"+a ;
	document.getElementById(l_name).style.display = "block" ;
}  



function mClass(a){
	for (var i=1; i<=6; i++) 
	{	var t_name = "Class_"+i ;
		document.getElementById(t_name).style.display = "none" ;
	}
	var l_name = "Class_"+a ;
	document.getElementById(l_name).style.display = "block" ;
}

function sClass(a){
	for (var i=1; i<=4; i++) 
	{	var t_name = "sClass_"+i ;
		document.getElementById(t_name).style.display = "none" ;
	}
	var l_name = "sClass_"+a ;
	document.getElementById(l_name).style.display = "block" ;
}

function eng(a){
	for (var i=1; i<=5; i++) 
	{	var t_name = "todayEng_"+i ;
		document.getElementById(t_name).style.display = "none" ;
	}
	var l_name = "todayEng_"+a ;
	document.getElementById(l_name).style.display = "block" ;
}