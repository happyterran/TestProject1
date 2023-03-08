/*
 * $mcm 객체
 * 
 * MCM 사이트 전체에서 사용하는 공통모듈
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

var richscriptMcm = $mcm = {
	instanceName: "richscriptMcm",
	
	/**
	* 모션을 적용하여 해당 좌표로 스크롤한다.
	* @param _top : (Number) Y좌표
	* @param _delay : (Number) 모션시간
	* @param _func : (Function) 스크롤 완료 후 진행할 작업
	* @return Void
	*/
	scrollTo: function(_top, _delay, _func) {
		var top = Math.toInt(_top),
			delay = (_delay==undefined) ? 200 : Math.toInt(_delay),
			func = (_func==undefined) ? null : _func;
		$("html, body").stop().animate({scrollTop: top}, delay, func);
	},
	
	/**
	* MCM 초기화
	* @return Void
	*/
	initialize: function() {
		
	}
};
$(function() {
	$mcm.initialize();
});


/**
* $mcm.popup 객체
* 멀티 레이어 팝업
*/
var richscriptMcmPopup = $mcm.popup = $popup = {
	instanceName: "richscriptMcmPopup",
	conf: {
		defaultW: 340
		, defaultH: 300
		, titleBarH: 60
	},
	vars: {
		maxZIndex: 200
		, dummyCount: 0
		, seq: 0
	},
	delay: {
		resize: 300
	},
	frames: {},
	
	/**
	* 팝업 일련번호를 체크후 정의가 안되어있으면 생성하여 반환한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return String
	*/
	seq: function(_seq) {
		var seq = _seq;
		if (seq==undefined||!Math.isInt(seq)) {
			var frameName = window.name;
			if (frameName.indexOf(this.instanceName)==0) {
				var s = frameName.split("_");
				if (s.length>1) {
					seq = s[s.length-1];
				}
			}
		}
		return Math.toInt(seq);
	},
	
	/**
	* 최상위 프레임 인지 여부
	* @return boolean
	*/
	isRoot: function() {
		return (parent==self);
	},
	
	/**
	* 부모 프레임의 $popup 객체를 리턴한다.
	* @return Object
	*/
	parent: function() {
		try {
			return parent[this.instanceName];
		} catch(e) {
			return null;
		}
	},
	
	/**
	* Opener 프레임을 반환한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Frame DOM
	*/
	opener: function(_seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var frames = this.frames[seq];
			if (frames==undefined||frames=="") {
				return window;
			} else {
				var f = window;
				for (var i=0; i<frames.length; i++) {
					f = f.window.frames[frames[i]];
				}
				return f;
			}
		} else {
			return this.parent().opener(seq);
		}
	},
	
	/**
	* Opener 정보를 탐색하여 반환한다.
	* @return Array
	*/
	_getOpener: function() {
		var frames = [], f = window;
		for (var i=0; i<5; i++) {
			if (parent==f) {
				break;
			}
			var name = f.name;
			if (name=="") {
				name = "frame_"+(new Date()).getTime()+this.vars.dummyCount++;
				f.name = name;
			}
			frames.push(name);
			f = f.parent;
		}
		f = null;
		return frames.reverse();
	},
	
	/**
	* 팝업을 연다.
	* @param _url : (String) 컨텐츠URL
	* @param _opt : (Object) 옵션설정정보
	* @return Void
	*/
	open: function(_url, _opt) {
		var opt = (_opt==undefined) ? {} : _opt;
		if (opt.opener==undefined) {
			opt.opener = this._getOpener();
		}
		if (this.isRoot()) {
			var o = this.instanceName;
			var seq = this.vars.seq++;
			this.frames[seq] = opt.opener;
			$("body").append(this.getHtml(seq, _url, opt));
			$(window).bind("resize."+o+seq, function() {
				window[o].moveToCenter(seq);
				window[o].resizeCover(seq);
			});
			this.active(seq);
			
			if (opt.isSubmit===true) {
				var f = opt.form;
				f.target = this.id(seq).frame.substring(1);
				f.submit();
				f = null;
			}
			
			/* 윈도우용 크롬 렌더링 버그: 색상을 강제로 변경해주면 인식함. */
			var idCover = this.id(seq).cover;
			if ($.browser.isCR) {
				setTimeout(function() {
					$(idCover).css({backgroundColor:"#010101"});
				}, 1);
			}
		} else {
			this.parent().open(_url, opt);
		}
	},
	
	/**
	* 팝업을 연다.
	* @param _url : (String) 컨텐츠URL
	* @param _opt : (Object) 옵션설정정보
	* @return Void
	*/
	openEmpty: function(_url, _opt) {
		var opt = (_opt==undefined) ? {} : _opt;
		if (opt.opener==undefined) {
			opt.opener = this._getOpener();
		}
		if (this.isRoot()) {
			var o = this.instanceName;
			var seq = this.vars.seq++;
			this.frames[seq] = opt.opener;
			$("body").append(this.getHtmlEmpty(seq, _url, opt));
			$(window).bind("resize."+o+seq, function() {
				window[o].moveToCenter(seq);
				window[o].resizeCover(seq);
			});
			this.active(seq);
			
			if (opt.isSubmit===true) {
				var f = opt.form;
				f.target = this.id(seq).frame.substring(1);
				f.submit();
				f = null;
			}
			
			/* 윈도우용 크롬 렌더링 버그: 색상을 강제로 변경해주면 인식함. */
			var idCover = this.id(seq).cover;
			if ($.browser.isCR) {
				setTimeout(function() {
					$(idCover).css({backgroundColor:"#010101"});
				}, 1);
			}
		} else {
			this.parent().open(_url, opt);
		}
	},
	
	/**
	* From Submit을 사용하여 팝업을 연다.
	* @param _formName : (String) Form이름
	* @return Void
	*/
	submit: function(_formName) {
		this.open("about:blank", {
			form: document[_formName]
			, isSubmit: true
		});
	},
	
	/**
	* 팝업 활성화
	* @param _seq : (Number) 팝업 일련번호
	* @return Void
	*/
	active: function(_seq) {
		var o = this.instanceName;
		var seq = _seq;
		var id = this.id(seq);
		$(id.closeButton).bind("click", function(e) {
			e.preventDefault();
			window[o].close(seq);
			return false;
		});
	},
	
	/**
	* 팝업 비활성화
	* @param _seq : (Number) 팝업 일련번호
	* @return Void
	*/
	inactive: function(_seq) {
		var seq = _seq;
		var id = this.id(seq);
		$(id.closeButton).unbind("click");
	},
	
	/**
	* 팝업을 닫는다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Void
	*/
	close: function(_seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var o = this.instanceName;
			var id = this.id(seq);
			$(window).unbind("resize."+o+seq);
			this.inactive(seq);
			$(id.popup).remove();
			$(id.cover).stop().fadeTo(400, 0, function() {
				$(this).remove();
			});
			this.frames[seq] = null;
		} else {
			this.parent().close(seq);
		}
	},
	
	/**
	* 팝업을 지정한 사이즈로 변경 후 중앙으로 다시 정렬한다.
	* @param _width : (Number) 컨텐츠 폭
	* @param _height : (Number) 컨텐츠 높이
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	resize: function(_width, _height, _seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.popupSize).stop().animate({width:_width,height:_height}, this.delay.resize, "easeInOutCubic");
			this.moveToCenter(seq, _width, _height);
			this.resizeCover(seq);
		} else {
			this.parent().resize(_width, _height, seq);
		}
		return this;
	},
	
	/**
	* 팝업커버를 최대사이즈로 유지한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	resizeCover: function(_seq) {
		var seq = this.seq(_seq);
		var id = this.id(seq);
		$(id.cover).css({width:$.browser.maxWidth(),height:$.browser.maxHeight()});
		if ($.browser.isIE6) {
			$(id.coverFrame).css({width:"100%",height:"100%"});
		}
		return this;
	},
	
	/**
	* 팝업을 지정한 위치로 이동한다.
	* @param _left : (Number) X좌표
	* @param _top : (Number) Y좌표
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	move: function(_left, _top, _seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.popup).stop().animate({left:_left, top:_top}, this.delay.resize, "easeInOutCubic");
		} else {
			this.parent().move(_left, _top, seq);
		}
		return this;
	},
	
	/**
	* 팝업을 중앙으로 정렬한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	moveToCenter: function(_seq, _width, _height) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			var tarW = (_width==undefined) ? $(id.popupSize).outerWidth() : _width;
			var tarH = (_height==undefined) ? $(id.popupSize).outerHeight() : _height;
			if ($(id.alt).attr("showAlt")=="Y") {
				tarH += $(id.alt).find("div.alt-data").outerHeight();
			}
			var tarX = Math.max($.browser.scrollLeft()+($.browser.screenWidth()-tarW)/2, 0);
			var tarY = Math.max($.browser.scrollTop()+($.browser.screenHeight()-tarH-this.conf.titleBarH)/2, 15);
			this.move(tarX, tarY, seq);
		} else {
			this.parent().moveToCenter(seq, _width, _height);
		}
		return this;
	},
	
	/**
	* 팝업 제목을 출력한다.
	* @param _title : (String) 팝업 제목
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	title: function(_title, _seq) {
		var title = (_title==undefined) ? document.title : _title;
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			var pattern = /[가-힝]/;
			if (pattern.test(title)) {
				$(id.titleBar).removeClass("lan-en").addClass("lan-kr");
			} else {
				$(id.titleBar).removeClass("lan-kr").addClass("lan-en");
			}
			$(id.titleBar).html(title.escapeXml());
		} else {
			this.parent().title(title, seq);
		}
		return this;
	},
	
	/**
	* 컨텐츠 로딩 커버를 제거한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	removeFrameCover: function(_seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.frameCover).stop().fadeTo("fast", 0, function() {
				try {
					$(this).remove();
				} catch(e) {}
			});
		} else {
			this.parent().removeFrameCover(seq);
		}
		return this;
	},
	
	/**
	* 팝업 하단에 도움말레이어 HTML을 설정한다.
	* @param _html : (String) 도움말레이어 HTML
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	altHtml: function(_html, _seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.alt).find("div.alt").html(_html);
		} else {
			this.parent().altHtml(_html, seq);
		}
		return this;
	},
	
	/**
	* 도움말레이어를 보여준다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	showAlt: function(_seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.alt).attr("showAlt","Y").css({display:"block"});
		} else {
			this.parent().showAlt(seq);
		}
		this.moveToCenter();
		return this;
	},
	
	/**
	* 도움말레이어를 숨긴다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object 팝업객체
	*/
	hideAlt: function(_seq) {
		var seq = this.seq(_seq);
		if (this.isRoot()) {
			var id = this.id(seq);
			$(id.alt).attr("showAlt","N").css({display:"none"});
		} else {
			this.parent().hideAlt(seq);
		}
		this.moveToCenter();
		return this;
	},
	
	/**
	* 팝업의 전체 HTML을 리턴한다.
	* @param _seq : (Number) 팝업 일련번호
	* @param _url : (String) 컨텐츠URL
	* @param _opt : (Object) 옵션설정정보
	* @return String
	*/
	getHtml: function(_seq, _url, _opt) {
		var endUrl = "'/StudentDetailEnd.asp?ref='";
		var id = this.id(_seq);
		var tarW = this.conf.defaultW;
		var tarH = this.conf.defaultH;
		var tarX = Math.max($.browser.scrollLeft()+($.browser.screenWidth()-tarW)/2, 0);
		var tarY = Math.max($.browser.scrollTop()+($.browser.screenHeight()-tarH-this.conf.titleBarH)/2, 0);
		var coverClass = ($("div.ui-popup-cover").get(0)==undefined) ? "ui-popup-cover" : "ui-popup-cover-transparent";
		var s = '';
		s += '<div id="'+id.cover.substring(1)+'" class="'+coverClass+'" style="z-index:'+(this.vars.maxZIndex++)+';width:'+$.browser.maxWidth()+'px;height:'+$.browser.maxHeight()+'px;">';
		if ($.browser.isIE6) {
			s += '<iframe id="'+id.coverFrame.substring(1)+'" src="about:blank" style="width:1px;height:1px;" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>';
		}
		s += '</div>\n';
		s += '<div id="'+id.popup.substring(1)+'" class="ui-popup" style="z-index:'+(this.vars.maxZIndex++)+';left:'+tarX+'px;top:'+tarY+'px;">\n';
		s += '	<div class="relative">\n';
		s += '		<div class="ui-popup-shadow">\n';
		s += '			<table cellspacing="0" cellpadding="0" border="0">\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-top-left"></div></td>\n';
		s += '					<td class="shadow-top"></td>\n';
		s += '					<td><div class="shadow-top-right"></div></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td class="shadow-left"></td>\n';
		s += '					<td>';
		s += '						<div id="'+id.popupSize.substring(1)+'" class="contents" style="width:'+tarW+'px;height:'+tarH+'px;">\n';
		s += '							<a xid="'+id.closeButton.substring(1)+'" xhref="#close" class="btn-close" onclick="$popup.opener().document.location.href='+endUrl+'+$popup.opener().document.location.href" style="cursor: pointer;"></a>\n';
		s += '							<div id="'+id.titleBar.substring(1)+'" class="title-bar"></div>\n';
		s += '							<div class="frame">';
		s += '<table id="'+id.frameCover.substring(1)+'" class="cover"><tr><td align="center" valign="middle"><img src="/images/richscript/ui/main/loading.24x24.gif" width="24" height="24" /></td></tr></table>';
		s += '<iframe name="'+id.frame.substring(1)+'" id="'+id.frame.substring(1)+'" src="'+_url.escapeXml()+'" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>\n';
		s += '						</div>\n';
		
		s += '					</td>\n';
		s += '					<td class="shadow-right"></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-bottom-left"></div></td>\n';
		s += '					<td class="shadow-bottom"></td>\n';
		s += '					<td><div class="shadow-bottom-right"></div></td>\n';
		s += '				</tr>\n';
		s += '				<tr id="'+id.alt.substring(1)+'" class="alt-tr">\n';
		s += '					<td colspan="3"><div class="alt"></div></td>\n';
		s += '				</tr>\n';
		s += '			</table>\n';
		s += '		</div>\n';
		s += '	</div>\n';
		s += '</div>\n';
		return s;
	},
	
	/**
	* 닫기 버튼 없는 팝업의 전체 HTML을 리턴한다.
	* @param _seq : (Number) 팝업 일련번호
	* @param _url : (String) 컨텐츠URL
	* @param _opt : (Object) 옵션설정정보
	* @return String
	*/
	getHtmlEmpty: function(_seq, _url, _opt) {
		var id = this.id(_seq);
		var tarW = this.conf.defaultW;
		var tarH = this.conf.defaultH;
		var tarX = Math.max($.browser.scrollLeft()+($.browser.screenWidth()-tarW)/2, 0);
		var tarY = Math.max($.browser.scrollTop()+($.browser.screenHeight()-tarH-this.conf.titleBarH)/2, 0);
		var coverClass = ($("div.ui-popup-cover").get(0)==undefined) ? "ui-popup-cover" : "ui-popup-cover-transparent";
		var s = '';
		s += '<div id="'+id.cover.substring(1)+'" class="'+coverClass+'" style="z-index:'+(this.vars.maxZIndex++)+';width:'+$.browser.maxWidth()+'px;height:'+$.browser.maxHeight()+'px;">';
		if ($.browser.isIE6) {
			s += '<iframe id="'+id.coverFrame.substring(1)+'" src="about:blank" style="width:1px;height:1px;" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>';
		}
		s += '</div>\n';
		s += '<div id="'+id.popup.substring(1)+'" class="ui-popup" style="z-index:'+(this.vars.maxZIndex++)+';left:'+tarX+'px;top:'+tarY+'px;">\n';
		s += '	<div class="relative">\n';
		s += '		<div class="ui-popup-shadow">\n';
		s += '			<table cellspacing="0" cellpadding="0" border="0">\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-top-left"></div></td>\n';
		s += '					<td class="shadow-top"></td>\n';
		s += '					<td><div class="shadow-top-right"></div></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td class="shadow-left"></td>\n';
		s += '					<td>';
		s += '						<div id="'+id.popupSize.substring(1)+'" class="contents" style="width:'+tarW+'px;height:'+tarH+'px;">\n';
//		s += '							<a id="'+id.closeButton.substring(1)+'" href="#close" class="btn-close"></a>\n';
		s += '							<div id="'+id.titleBar.substring(1)+'" class="title-bar"></div>\n';
		s += '							<div class="frame">';
		s += '<table id="'+id.frameCover.substring(1)+'" class="cover"><tr><td align="center" valign="middle"><img src="/images/richscript/ui/main/loading.24x24.gif" width="24" height="24" /></td></tr></table>';
		s += '<iframe name="'+id.frame.substring(1)+'" id="'+id.frame.substring(1)+'" src="'+_url.escapeXml()+'" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>\n';
		s += '						</div>\n';
		
		s += '					</td>\n';
		s += '					<td class="shadow-right"></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-bottom-left"></div></td>\n';
		s += '					<td class="shadow-bottom"></td>\n';
		s += '					<td><div class="shadow-bottom-right"></div></td>\n';
		s += '				</tr>\n';
		s += '				<tr id="'+id.alt.substring(1)+'" class="alt-tr">\n';
		s += '					<td colspan="3"><div class="alt"></div></td>\n';
		s += '				</tr>\n';
		s += '			</table>\n';
		s += '		</div>\n';
		s += '	</div>\n';
		s += '</div>\n';
		return s;
	},
	
	/**
	* 해당 팝업의 아이디 정보를 리턴한다.
	* @param _seq : (Number) 팝업 일련번호
	* @return Object
	*/
	id: function(_seq) {
		var preFix = "#"+this.instanceName;
		return {
			  popup: preFix+"_popup_"+_seq
			, popupSize: preFix+"_popupSize_"+_seq
			, cover: preFix+"_cover_"+_seq
			, coverFrame: preFix+"_coverFrame_"+_seq
			, titleBar: preFix+"_titleBar_"+_seq
			, closeButton: preFix+"_closeButton_"+_seq
			, frame: preFix+"_frame_"+_seq
			, frameCover: preFix+"_frameCover_"+_seq
			, alt: preFix+"_alt_"+_seq
		};
	}
};