var giStartYear = 1930;
var giEndYear = 2050;


var clsCal = new init_Calandar();
var formField = "";


function init_Calandar() {
	this.Date = new Date;
}
	
clsCal.setDate = function (nYear, nMonth, nDay) {
	this.Date.setYear(nYear);
	this.Date.setMonth(nMonth - 1);
	this.Date.setDate(nDay);

	return false;
}

clsCal.setDay = function(nDay) {
	this.Date.setDate(nDay);

	return false;
}

clsCal.getYear = function () {
	if (this.Date.getYear() < 2000) {
		return 1900 + this.Date.getYear();
	} else {
		return this.Date.getYear();
	}
}

clsCal.getMonth = function () {
	return this.Date.getMonth() + 1;
}

clsCal.getDay = function () {
	return this.Date.getDate();
}

clsCal.getWeek = function() {
	return this.Date.getDay();
}

clsCal.getStartWeek = function() {
	var tempDate = new Date(this.Date.getYear(), this.Date.getMonth(), 1);

	return tempDate.getDay();
}

clsCal.getEndDay = function() {
	var thisMonth = this.Date.getMonth();
	var tempDate = new Date(this.Date.getYear(), this.Date.getMonth(), 1);
	for (var i=1; i<32; i++) {
		tempDate.setDate(tempDate.getDate() + 1)
		if (thisMonth != tempDate.getMonth()) {
			return i;
		}
	}
}

clsCal.getEndWeek = function() {
	var thisDate = new Date(this.Date.getYear(), this.Date.getMonth(), clsCal.getEndDay());

	return thisDate.getDay();
}


function setTarget(fieldName) {
	formField = fieldName;	
}

function setTableWrite(tableName) {
	var strDate, strInpDate
	var sDay = clsCal.getMonth();
	var sYear = clsCal.getYear();
	var sMonth = clsCal.getMonth();
	
	for(i=0; i<tableName.length; i++) {
		tableName[i].innerHTML = "&nbsp;";
	}
	clsCal.setDate(clsCal.getYear(), clsCal.getMonth(), 1)
	clsCal.setDate(clsCal.getYear(), clsCal.getMonth(), 1 - clsCal.getWeek() - 1)
	for (i=0; i<tableName.length; i++) {
		clsCal.setDay(clsCal.getDay() + 1)
		if (clsCal.getMonth() == sDay) {
			strDate	= clsCal.getDay()
			if (clsCal.getMonth() < 10) {
				strInpDate = clsCal.getYear() + "-0" + clsCal.getMonth() + "-"
			} else {
				strInpDate = clsCal.getYear() + "-" + clsCal.getMonth() + "-"
			}

			if (clsCal.getDay() < 10) {
				 strInpDate = strInpDate + "0" + clsCal.getDay()
			} else {
				 strInpDate = strInpDate + clsCal.getDay()
			}
			if (clsCal.getWeek() == 0) {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); " + formField + ".value=\"" + strInpDate + "\"; onCalClick(); return false;' class=\"body_01\"><font color=\"#cc0000\">" + strDate + "</font></a>";
			} else if (clsCal.getWeek() == 6) {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); " + formField + ".value=\"" + strInpDate + "\"; onCalClick(); return false;' class=\"body_01\"><font color=\"#0000cc\">" + strDate + "</font></a>";
			} else {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); " + formField + ".value=\"" + strInpDate + "\"; onCalClick(); return false;' class=\"body_01\">" + strDate + "</a>";
			}
		} else {
/*			strDate = clsCal.getMonth() + "-" + clsCal.getDay()
			strInpDate = clsCal.getYear() + "-" + clsCal.getMonth() + "-" + clsCal.getDay()*/
		}
	}
	clsCal.setDate(sYear, sMonth, sDay)
	return false;
}

function setTableWrite_noneReturn(tableName) {
	var strDate, strInpDate
	var sDay = clsCal.getMonth();
	var sYear = clsCal.getYear();
	var sMonth = clsCal.getMonth();
	
	for(i=0; i<tableName.length; i++) {
		tableName[i].innerHTML = "&nbsp;";
	}
	clsCal.setDate(clsCal.getYear(), clsCal.getMonth(), 1)
	clsCal.setDate(clsCal.getYear(), clsCal.getMonth(), 1 - clsCal.getWeek() - 1)
	for (i=0; i<tableName.length; i++) {
		clsCal.setDay(clsCal.getDay() + 1)
		if (clsCal.getMonth() == sDay) {
			strDate	= clsCal.getDay()
			strInpDate = clsCal.getYear() + "-" + clsCal.getMonth() + "-" + clsCal.getDay()
			if (clsCal.getWeek() == 0) {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); onCalClick(); return false;' class=\"body_01\"><font color=\"#cc0000\">" + strDate + "</font></a>";
			} else if (clsCal.getWeek() == 6) {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); onCalClick(); return false;' class=\"body_01\"><font color=\"#0000cc\">" + strDate + "</font></a>";
			} else {
				tableName[i].innerHTML = "<a href='#' onClick='onMouseClick(); onCalClick(); return false;' class=\"body_01\">" + strDate + "</a>";
			}
		} else {
/*			strDate = clsCal.getMonth() + "-" + clsCal.getDay()
			strInpDate = clsCal.getYear() + "-" + clsCal.getMonth() + "-" + clsCal.getDay()*/
		}
	}
	clsCal.setDate(sYear, sMonth, sDay)
	return false;
}

function onCalClick()
  	{
	}

   	function onMouseClick(targetForm, left, top) {
	var f=document.all;

	if (f.divCalandar.style.display == "none") {
		f.divCalandar.style.display = "";
		setTarget(targetForm);
		f.divCalandar.style.left = left;
		f.divCalandar.style.top = top - 30 + document.body.scrollTop;
		setTableWrite(f.tdDay);
		f.calenfrm.strYear.focus();
	} else {
		document.all.divCalandar.style.display = "none";
	}
	}

	function monthCalc(nValue) {
	var f = document.all;
	if (nValue == 0)
	{
		clsCal.setDate(f.calenfrm.strYear.value, f.calenfrm.strMonth.value, 1);
	}
	else
	{
		clsCal.setDate(f.calenfrm.strYear.value, parseInt(f.calenfrm.strMonth.value) + nValue, 1);
		for(i=0;i<f.calenfrm.strYear.length;i++)
		{
			if (parseInt(f.strYear[i].value) == clsCal.getYear())
			{
				f.strYear[i].selected = true;
			}
		}
		for(i=0;i<f.calenfrm.strMonth.length;i++)
		{
			if (parseInt(f.strMonth[i].value) == clsCal.getMonth())
			{
				f.strMonth[i].selected = true;
			}
		}
	}
	setTableWrite(f.tdDay);

	}

// 기간선택 함수
function changeDate(interval, type, obj1, obj2)
{
	var obj1 = eval(obj1);
	var obj2 = eval(obj2);
	var strDayS = obj1.value;
	var strDayE = obj2.value;
	var day = new Date();
	if(type == "day" || type == "preday")
	{
		day.setDate(day.getDate() - interval);
	}
	if(type == "mon")
	{
		day.setMonth(day.getMonth() - interval);
	}
	var year = day.getYear();
	var month = day.getMonth() + 1;
	if(month < 10)
	{
		month = "0" + month;
	}
	var date = day.getDate();
	if(date < 10)
	{
		date = "0" + date;
	}
	var before = year + "-" + month + "-" + date;
	
	obj1.value = before;

	var today = new Date();
	var year = today.getYear();
	var month = today.getMonth() + 1;
	if(month < 10)
	{
		month = "0" + month;
	}
	var date = today.getDate();
	if(date < 10)
	{
		date = "0" + date;
	}
	var todayto = year + "-" + month + "-" + date;
	if (type == "preday")
	{
		obj2.value = before;
	} else
	{
		obj2.value = todayto;
	}
}