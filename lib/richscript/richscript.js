/*
 * Rich JavaScript Framework, 
 * On jQuery(version 1.5.2)
 * Copyright (c) Lee Won-Gyoon <richscript@gmail.com>, <@richscript>
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * For details, see the RichScript web site: http://www.richscript.com/
 * 
*******************************************************************************/

(function($){
	var __ua = navigator.userAgent.toUpperCase();
	$.extend($.browser, {
		isMobile: (__ua.indexOf("MOBILE")>-1),
		isIPhone: (__ua.indexOf("IPHONE")>-1),
		isIPad: (__ua.indexOf("IPAD")>-1),
		isGalaxyTab : (__ua.indexOf("SHW-M180")>-1),
		isIE: ($.browser.msie)?true:false,
		isIE9: (__ua.indexOf('MSIE 9')>-1),
		isIE8: (__ua.indexOf('MSIE 9')==-1&&__ua.indexOf('MSIE 8')>-1),
		isIE7: (__ua.indexOf('MSIE 9')==-1&&__ua.indexOf('MSIE 8')==-1&&__ua.indexOf('MSIE 7')>-1),
		isIE6: (__ua.indexOf('MSIE 9')==-1&&__ua.indexOf('MSIE 8')==-1&&__ua.indexOf('MSIE 7')==-1&&__ua.indexOf('MSIE 6')>-1),
		isFF: (__ua.indexOf('FIREFOX')>-1),
		isOP: (__ua.indexOf('OPERA')>-1),
		isCR: (__ua.indexOf('CHROME')>-1),
		isSF: (__ua.indexOf('SAFARI')>-1&&__ua.indexOf('CHROME')==-1),
		isStrict : function() {
			var docRoot = document.documentElement;
			return (docRoot!=undefined);
		},
		screenWidth : function() {
			var w = window.innerWidth ||
				(this.isStrict() && document.documentElement.clientWidth) ||
				document.body.clientWidth || 0;
			return w;
		},
		screenInnerWidth : function() {
			return this.screenW()-((!this.isIE&&!this.isMobile)?20:0);
		},
		screenHeight : function() {
			return window.innerHeight ||
				(this.isStrict() && document.documentElement.clientHeight) ||
				document.body.clientHeight || 0;
		},
		scrollWidth : function() {
			return (this.isStrict() && document.documentElement.scrollWidth) ||
				document.body.scrollWidth || 0;
		},
		scrollHeight : function() {
			return (this.isStrict() && document.documentElement.scrollHeight) ||
				document.body.scrollHeight || 0;
		},
		bodyWidth : function() {
			return document.body.scrollWidth || 0;
		},
		bodyHeight : function() {
			return document.body.scrollHeight || 0;
		},
		scrollLeft : function() {
			return window.pageXOffset ||
				(this.isStrict() && document.documentElement.scrollLeft) ||
				document.body.scrollLeft || 0;
		},
		scrollTop : function() {
			return window.pageYOffset ||
				(this.isStrict() && document.documentElement.scrollTop) ||
				document.body.scrollTop || 0;
		},
		maxWidth : function() {
			return Math.max(this.screenWidth(), this.scrollWidth());
		},
		maxHeight : function() {
			return Math.max(this.screenHeight(), this.scrollHeight());
		},
		language : function() {
			return navigator.language || navigator.userLanguage || "";
		},
		/* EventType For N Screen */
		nsEventType: {
			touchStart: (document.ontouchstart===undefined) ? "mousedown":"touchstart"
		}
	});
	
	
	/* String Methods (Public) */
	$.extend(String.prototype, {
		trim : function () {
			return $.trim(this);
		},
		escapeXml : function() {
			return this
			.replace(/&/g,"&amp;")
			.replace(/\'/g,"&#039;")
			.replace(/\"/g,"&#34;")
			.replace(/</g,"&lt;")
			.replace(/>/g,"&gt;")
			.replace(/\n/g,"&#10;")
			.replace(/\r/g,"&#13;")
			.replace(/\t/g,"&#9;");
		},
		escapeJS : function() {
			return this
			.replace(/\\/g,"\\\\")
			.replace(/\//g,"\\/")
			.replace(/\n/g,"\\n")
			.replace(/\r/g,"\\r")
			.replace(/\t/g,"\\t")
			.replace(/\"/g,"\\\"")
			.replace(/\'/g,"\\'");
		},
		escapeCss : function() {
			return this
			.replace(/\'/g,"\\\'")
			.replace(/\"/g,"\\\"")
			.replace(/\,/g,"\\,")
			.replace(/\(/g,"\\(")
			.replace(/\)/g,"\\)");
		},
		addParam : function(_param) {
			return this+((_param!=undefined&&_param!="")?
				((this.indexOf("?")>-1) ? "&":"?")+_param : "" );
		},
		toCamelize : function() {
			var s = this;
			if (s.indexOf("-")>-1) {
				var a = s.split("-");
				s = a[0];
				for (var i=1; i<a.length; i++) {
					if (a[i].length>0) {
						s += a[i].charAt(0).toUpperCase() + a[i].substring(1);
					}
				}
			}
			return s;
		},
		toBold : function() {
			return "<strong>"+this+"</strong>";
		},
		toDomNodes : function() {
			var s = this, nodes = [];
			var box = document.createElement("DIV");
			box.innerHTML = s;
			for (var i=0; i<box.childNodes.length; i++) {
				nodes.push(box.childNodes[i]);
			}
			box = null;
			return nodes;
		},
		toJson : function() {
			var s = this, o = {};
			try {
				o = eval("("+s+")");
			} catch(e) {}
			return o;
		},
		toLinked : function(_tar) {
			return this.replace(/([\s]|^)(http|https|ftp):\/\/([^\s]+)/gi, '$1<a href="$2://$3" target="'+((_tar==undefined)?'_blank':_tar)+'">$2://$3</a>')
			.replace(/([\s]|^)([_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+)*)@([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)/gi, '$1<a href="mailto:$2@$4" target="_blank">$2@$4</a>');
		},
		enterToBr : function() {
			return this.replace(/\n/g, "<br/>");
		}
	});
	
	
	/* Math Methods (Static) */
	$.extend(Math, {
		isInt : function(_n, _base) {
			var base = (_base==undefined) ? 10 : _base;
			return (""+parseInt(_n, base)!="NaN");
		},
		isFloat : function(_n) {
			return (""+parseFloat(_n)!="NaN");
		},
		toInt : function(_n, _def, _base) {
			var def = (_def==undefined) ? 0 : _def;
			var base = (_base==undefined) ? 10 : _base;
			return this.isInt(_n, base) ? parseInt(_n, base) : def;
		},
		toFloat : function(_n, _def) {
			var def = (_def==undefined) ? 0 : _def;
			return this.isFloat(_n) ? parseFloat(_n) : def;
		},
		randomInt : function(_end, _start) {
			var start = (_start==undefined) ? 0 : _start;
			var end = (_end==undefined) ? 2 : _end+1;
			return this.floor(this.random()*(end-start))+start;
		},
		toMoney : function(_n) {
			var s = (""+_n).trim();
			var n = s.split(".");
			var n1 = n[0], n2 = (n.length>1) ? "."+n[1] : "", a = [];
			for (var i=n1.length-1, j=0; i>=0; i--, j++) {
				if (j>0&&j%3==0) a.push(",");
				a.push(n1.charAt(i));
			}
			return a.reverse().join("")+n2;
		},
		toRanking : function(_n) {
			var s = (""+_n).trim();
			return (s=="1")?s+"st":(s=="2")?s+"nd":(s=="3")?s+"rd":s+"th";
		}
	});
	
	
	/* Array Methods (Public) */
	$.extend(Array.prototype, {
		remove : function(_obj) {
			for (var i=0; i<this.length; i++) {
				if (this[i]===_obj) {
					this[i] = null;
					delete this[i];
				}
			}
		},
		compact : function() {
			var temp = [];
			for (var i=0; i<this.length; i++) {
				if (this[i]!==null&&this[i]!==undefined) {
					temp.push(this[i]);
				}
			}
			return temp;
		}
	});
	
	
	/* Date Methods (Public) */
	$.extend(Date.prototype, {
		toFormatted : function(_s) {
			var s = (_s==undefined) ? "YYYYMMDD" : _s,
			YYYY = this.getYear(),
			MM = this.getMonth()+1,
			DD = this.getDate(),
			HH = this.getHours(),
			MI = this.getMinutes(),
			SS = this.getSeconds();
			if (YYYY<1000) YYYY += 1900;
			if (MM<10) MM = "0"+MM;
			if (DD<10) DD = "0"+DD;
			if (HH<10) HH = "0"+HH;
			if (MI<10) MI = "0"+MI;
			if (SS<10) SS = "0"+SS;
			return s.replace(/YYYY/gi,YYYY)
				.replace(/MM/gi,MM)
				.replace(/DD/gi,DD)
				.replace(/HH/gi,HH)
				.replace(/MI/gi,MI)
				.replace(/SS/gi,SS);
		},
		addYear : function(_n) {
			this.setYear(this.getYear()+_n);
			return this;
		},
		addMonth : function(_n) {
			this.setMonth(this.getMonth()+_n);
			return this;
		},
		addDate : function(_n) {
			this.setDate(this.getDate()+_n);
			return this;
		},
		addHours : function(_n) {
			this.setHours(this.getHours()+_n);
			return this;
		},
		addMinutes : function(_n) {
			this.setMinutes(this.getMinutes()+_n);
			return this;
		},
		addSeconds : function(_n) {
			this.setSeconds(this.getSeconds()+_n);
			return this;
		}
	});
	
	
	/* Define ObjectEvent Class */
	$.ObjectEvent = function() {
		this.actions;
		this.returnValue = true;
	};
	$.extend($.ObjectEvent.prototype, {
		push : function(_type, _group, _func, _count) {
			if (this.actions==undefined) {
				this.actions = [];
			}
			var type = (""+_type).trim().toLowerCase(),
				group = (""+_group).trim().toLowerCase()
			this.actions.push({
				  type	: type
				, group	: group
				, func	: _func
			});
		},
		bind : function(_type, _func, _count) {
			if (_type!=undefined&&_func!=undefined) {
				var group = "", type = (""+_type).toLowerCase();
				var dot = type.indexOf(".");
				if (dot>-1) {
					group = type.substring(dot+1);
					type = type.substring(0,dot);
				}
				this.push(type.trim(), group.trim(), _func, _count);
			}
			return this;
		},
		unbind : function(_type) {
			if (_type==undefined) {
				_type = "";
			}
			var group = "", type = (""+_type).toLowerCase();
			var dot = type.indexOf(".");
			if (dot>-1) {
				group = type.substring(dot+1);
				type = type.substring(0,dot);
			}
			group = group.trim();
			type = type.trim();
			if (this.actions) {
				for (var i=0; i<this.actions.length; i++) {
					if ((group==""||this.actions[i].group==group)&&(type==""||this.actions[i].type==type)) {
						this.actions[i].func = null;
						this.actions[i] = null;
					}
				}
				this.actions = this.actions.compact();
			}
			return this;
		},
		stopDefault : function() {
			this.returnValue = false;
		},
		stop : function() {
			this.stopDefault();
		},
		on : function() {
			var type = (""+arguments[1]).trim().toLowerCase();
			var removed = false;
			if (this.actions) {
				for (var i=0; i<this.actions.length; i++) {
					if (this.actions[i]&&this.actions[i].type==type) {
						if (typeof(this.actions[i].func)=="function") {
							this.actions[i].func.apply(arguments[0], Array.prototype.slice.apply(arguments, [2]));
						} else {
							eval(this.actions[i].func);
						}
						if (this.actions[i]&&Math.isInt(this.actions[i].count)) {
							this.actions[i].count--;
							if (this.actions[i].count<=0) {
								this.actions[i].func = null;
								this.actions[i] = null;
								removed = true;
							}
						}
					}
				}
				if (removed) {
					this.actions = this.actions.compact();
				}
			}
			var returnValue = this.returnValue;
			this.returnValue = true;
			return returnValue;
		}
	});
	
	
	/* Define Request Class */
	$.Request = function(_query) {
		var search = (_query!=undefined)?""+_query:"";
		this.search = "";
		this.key = {};
		this.keys = [];
		this.values = [];
		this.host = window.location.host;
		this.port = window.location.port;
		this.pathname = window.location.pathname;
		
		if (search.length>1&&search.indexOf("?")==0) search = search.substring(1,search.length);
		var param = search.split("&");
		var paramValue = "";
		for (var i=0; i<param.length; i++) {
			var index = param[i].indexOf("=");
			if (index>-1) {
				var name = param[i].split("=")[0];
				var value = param[i].substring(index+1, param[i].length).trim();
				if (this.key[name]==undefined) {
					this.set(name, value);
				}
			}
		}
	};
	$.extend($.Request.prototype, {
		size : function() {
			return this.values.length;
		},
		set : function(_name, _value) {
			if (this.key[_name]==undefined) {
				var index = this.values.length;
				this.key[_name] = index;
				this.keys.push(_name);
				this.values.push(_value);
			}
			this.search = this.search.addParam(_name+"="+_value);
		},
		get : function(_name) {
			var value = this.values[this.key[_name]];
			if (value==undefined) value = "";
			return value;
		},
		getKey : function(_index) {
			return this.keys[_index];
		}
	});
	
	/* Initialize Default Request */
	$.request = new $.Request(window.location.search);
	
	
	/* Define Cookies Util */
	$.cookie = {
		get : function(_name) {
			var list = document.cookie.split(";");
			var value = "";
			for (i = 0; i < list.length; i++) {
				if (list[i].indexOf(_name+"=") > -1) {
					if (list[i].split("=")[0].replace(/\s/g,"") == _name) {
						value = decodeURIComponent(list[i].split("=")[1]);
						break;
					}
				}
			}
			return value;
		},
		set : function(_name, _value, _days, _path, _domain) {
			if (_name!=undefined&&_name.trim()!="") {
				if (_value==undefined) _value = "";
				if (_days==undefined) _days = 365;
				if (_path==undefined) _path = "/";
				/* try { if (_domain==undefined) _domain = location.hostname; } catch(e) { } */
				var d = new Date();
				d.setDate(d.getDate()+_days);
				var s = "";
				s += _name+"="+encodeURIComponent(_value) + ";";
				s += "expires=" + d.toGMTString() + ";";
				s += "path=" + _path + ";";
				if (_domain!=undefined) {
					s += "domain=" + _domain + ";";
				}
				document.cookie = s;
			}
		}
	};
	
	
	/* Printer Object */
	$.out = {
		print : function(_s) {
			document.write(_s);
		},
		println : function(_s) {
			document.writeln(_s);
		},
		printBr : function(_s) {
			document.writeln(_s+"<br/>");
		}
	};
	
	
	/* Check Global var */
	if (window.ObjectEvent==undefined) window.ObjectEvent = $.ObjectEvent;
	if (window.Request==undefined) window.Request = $.Request;
	if (window.out==undefined) window.out = $.out;
	
	
	/* Use BackgroundImageCache For IE */
	if ($.browser.isIE) {
		try {
			document.execCommand('BackgroundImageCache', false, true);
		} catch(e) {}
	}
	
	
	$.fn.replaceClass = function(_tar, _new) {
		return this.each(function() {
			var $this = $(this);
			if ($this.hasClass(_tar)) {
				$this.removeClass(_tar).addClass(_new);
			}
		});
	};

})(jQuery);








