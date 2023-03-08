// ---------------- AssisDic.js ----------------
var isClose = true;
if (typeof nhn == 'undefined') nhn = {};
metis.iPhotoShowLayer = jindo.$Class({
	$init: function(config) {
		this.allBtns_i = config.allBtns_i;
		this.showLayer = config.showLayer;
		this.closeLayer = jindo.$('<a>');
		this.closeLayer.href = '#ly';
		this.closeLayer.innerHTML = '<img src="http://static.naver.com/www/m/im/bl.gif" alt="닫기" onClick="nclk(this,\'sdc.close\',\'\',1)" /><span class="nc">닫기</span>';
		this.closeLayer.className = 'bt4';
		this.el = null;
		this.from = 0;
		this.to = 0;
		this.dire = 'top';
		this.durTime = 1000;
		this.frame = 50;
		this.method = function(x) {
			return x
		};
		this.startTime = null;
		this.endTime = null;
		this._bindEvents()
	},
	_bindEvents: function() {
		var fnMouseOver = jindo.$Fn(this._handler.mouseOver, this);
		var fnMouseOut = jindo.$Fn(this._handler.mouseOut, this);	
		
		$Fn(function(){
			isClose = false;
		}).attach(this.showLayer, 'touchend').attach(this.showLayer, 'mousedown');
				
		jindo.$Fn(this._handler.outClickLayer, this).attach(document, 'touchend');
	},
	_handler: {
		btnAjax: function(e) {			
			var _this = this;
			var hidden = jindo.$$('input[type=hidden]', e.currentElement)[0];
			var hidden_val = "";
			var url = '/assistDic.metis?query=';
			if (hidden) {
				url = url + hidden.value;
				jindo.$Ajax(url, {
					type: 'xhr',
					method: 'get',
					onload: function(res) {
						if (res.text() != "") {
							_this.showLayer.innerHTML = res.text();
							_this.showLayer.appendChildk(_this.closeLayer);
							_this.showLayer.style.display = 'block';
							// _this._handler.position.call(_this);
							switchAllDiv("ly1")
						} else {
							_this.showLayer.style.display = 'none'
						}
					}
				}).request()
			}
		},
		outClickLayer: function(e) {
			if (this.showLayer.style.display == 'block'){
				if (isClose){
					this.showLayer.style.display = 'none'
				}
				setTimeout(function() {
					if (!isClose){
						isClose = true;
					}
				}, 100)
			}
		},
		closeLayer: function(e) {
			this.showLayer.style.display = 'none'
		},
		scrollLayer: function(e) {
			this.showLayer.style.display = 'none';
// this._handler.position.call(this);
		},
		mouseOver: function(e) {
			e.currentElement.style.cursor = 'pointer';
			jindo.$Element(e.currentElement).addClass('wdc')
		},
		mouseOut: function(e) {
			jindo.$Element(e.currentElement).removeClass('wdc')
		},
		position: function() {
// var _this = this;
// var doc = document.documentElement || document.body;
// var scrollTop = document.documentElement.scrollTop || window.pageYOffset;
// setTimeout(function() {
// _this.showLayer.style.position = 'absolute';
// _this.showLayer.style.zIndex = '1000';
// var win_width = window.innerWidth | doc.clientWidth;
// _this.showLayer.style.width = win_width + 'px';
// _this._handler.tween.call(_this, {
// el: _this.showLayer,
// from: _this.showLayer.offsetTop || 0,
// to: (window.innerHeight + scrollTop) - _this.showLayer.offsetHeight || 0
// })
// },
// 100)
		},
		tween: function(config) {
			this.el = config.el;
			this.from = config.from;
			this.to = config.to;
			this._handler.beginTween.call(this)
		},
		beginTween: function() {
			this.startTime = new Date().getTime();
			this._handler.mTween.call(this)
		},
		mTween: function() {
			var _this = this; (function() {
				_this.endTime = new Date().getTime();
				var offset = _this.method((_this.endTime - _this.startTime) / _this.durTime);
				if (offset < 1) {
					_this.from = _this.from + (_this.to - _this.from) * offset;
					_this.el.style[_this.dire] = _this.from + 'px';
					setTimeout(arguments.callee, _this.durTime / _this.frame)
				} else {
					_this.el.style[_this.dire] = _this.to + 'px'
				}
			})()
		}
	}
});
function autoLinkMouseOver(e) {
	e.style.cursor = 'pointer';
	jindo.$Element(e).addClass('wdc')
}
function autoLinkMouseOut(e) {
	jindo.$Element(e).removeClass('wdc')
}
function autoLinkClose(e) {
	jindo.$('ly1').style.display = 'none';
}
function autoLinkAjaxClick(e) {
	var showLayer = jindo.$('ly1');
	var closeLayer = jindo.$('<a>');
	var hidden = jindo.$$('input[type=hidden]', e)[0];
	var hidden_val = "";
	var url = '/assistDic.metis?query=';
	if (hidden) {
		url = url + hidden.value;
		jindo.$Ajax(url, {
			type: 'xhr',
			method: 'get',
			onload: function(res) {
				if (res.text() != "") {
					showLayer.innerHTML = res.text();
					showLayer.appendChild(closeLayer);
					autoLinkPosition(e);
					switchAllDiv("ly1")
					showLayer.style.display = 'block';
				} else {
					showLayer.style.display = 'none'
				}
			}
		}).request()
	}
}
function autoLinkPosition(e){
	var showLayer = jindo.$('ly1');
	var arrowLayer = jindo.$('alArrow');
	var doc = document.documentElement || document.body;
	var scrollTop = document.documentElement.scrollTop || window.pageYOffset;
	setTimeout(function() {
		showLayer.style.position = 'absolute';
		showLayer.style.zIndex = '1000';
		var win_width = window.innerWidth | doc.clientWidth;
		var win_height = window.innerHeight | doc.clientHeight;
		arrowLayer.style.left = e.offsetLeft + 5 + 'px';
		showLayer.style.width = win_width + 'px';

		if ((e.offsetTop - scrollTop) > 200){
			showLayer.style.top = (e.offsetTop - showLayer.offsetHeight - 10) + 'px';
			arrowLayer.style.display = 'block';
		}else{
			showLayer.style.top = (e.offsetTop + 25) + 'px';
			jindo.$Element('alArrow').addClass('top_arr');
			arrowLayer.style.display = 'block';
		}
	}, 10);
}

$Fn(function (e) {
	if(jindo.$('alArrow')!=null && jindo.$('alArrow').style.display === 'block'){
		autoLinkPosition(e);
	}
}).attach(window, "orientationchange");

function autoLinkTween(config) {
	var startTime = new Date().getTime();
	var from = config.from;
	var to = config.to;
	var el = config.el;
	var dire = 'top';
	var frame = 50;
	var durTime = 1000; (function() {
		var endTime = new Date().getTime();
		var offset = ((endTime - startTime) / durTime);
		if (offset < 1) {
			from = from + (to - from) * offset;
			el.style[dire] = from + 'px';
			setTimeout(arguments.callee, durTime / frame)
		} else {
			el.style[dire] = to + 'px'
		}
	})()
}

// ---------------- MoreResult.js ----------------
metis.MoreResult = jindo.$Class({
	$init: function(opt) {
		this.button_down = opt.button_down;
		this.container = opt.container;
		this.maxPage = 100;
		this.url = opt.url;
		this.pageSize = opt.pageSize || 15;
		this.button_down_span = $$.getSingle("span.btm1mw", this.button_down);
		this.button_down_text = $$.getSingle("span.btm1mn", this.button_down);
		this.button_down_btmlt = $$.getSingle("a.btm1t");
		this.button_down_lastnum = $$.getSingle("em", this.button_down);
		if (!this.button_down_text) {
			return
		}
		this.total = parseInt(this.button_down_text.innerHTML.split(/\/\s*/)[1].replace(/,/g, ""));
		this.total_text = this.button_down_text.innerHTML.split(/\/\s*/)[1];
		this.url = this.button_down.getAttribute("href");
		this.url = this.url.replace(/^\/s(?=earch\.metis)/, "/ajaxS");
		this.page = /pageNo=(\d+)/.test(this.url) ? RegExp.$1: 1;
		this.page = parseInt(this.page, 10) - 1;
		this.showMoreDiv = $("showMore");;
		this.url = this.url.replace(/pageNo=\d*/, "");
		var _defaultPage = $$("ul.li3", this.container);
		this.arrPages = [];
		for (var i = 0; i < _defaultPage.length; i++) {
			this.arrPages.push(_defaultPage[i])
		}
		if((this.page >= this.maxPage) && this.showMoreDiv){
			this.showMoreDiv.style.display = "block";
		}
		this._bindEvents()
	},
	_bindEvents: function() {
		$Fn(this._onClickDown, this).attach(this.button_down, "click")
	},
	showMore: function(dir) {
		this._fetchResult(dir)
	},
	_fetchResult: function(down) {
		if (this.page >= this.maxPage) {
			return
		}
		var owner = this;
		var page = this.page + 1;
		if (page < 1) return;
		$Ajax(this.url + "pageNo=" + (page), {
			onload: function(res) {
				var str = res.text();
				if (!str) return;
				if (down) {
					owner.page++
				}
				owner._insertResult(str, down)
			}
		}).request()
	},
	_insertResult: function(str, down) {
		str = str.replace(/^\s*|\s*$/, "");
		if (!str) return;
		jindo.$$('ul.li3')[0].innerHTML = jindo.$$('ul.li3')[0].innerHTML + str;
		this.updatePageInfo();
		this.initList(down);
		new metis.iPhotoShowLayer({
			allBtns_i: jindo.$$('i'),
			showLayer: jindo.$('ly1')
		});
		return
	},
	initList: function(down) {
		if (this.arrPages.length >= this.maxPage) {
			this.button_up.parentNode.style.display = "block";
			this.showMoreDiv.style.display = "block";
				
		}
		if (this.page >= this.maxPage) {
			this.button_down.href = "#";
			this.button_down_span.onclick = null;
			this.button_down_span.className = "btm1mwLast";
			this.button_down_span.innerHTML = "";
			this.button_down_span.appendChild(this.button_down_text);
			this.button_down_text.className = "btm1mnLast"
			this.showMoreDiv.style.display = "block";
		}
		if((this.page * this.pageSize)>=this.total){
			$("lastPageDiv_not").style.display = "none";
			$("lastPageDiv_yes").style.display = "block";
		}
		if (this.arrPages.length > this.maxPage) {
			this.remove(down)
		}
	},
	updatePageInfo: function() {
		if (this.total - this.page * this.pageSize < this.pageSize && this.total - this.page * this.pageSize > 0) {
			this.button_down_lastnum.innerHTML = this.total - this.page * this.pageSize
		}
		this.button_down_text.innerHTML = Math.min((this.page) * this.pageSize, this.total) + " / " + this.total_text
	},
	remove: function(fromTop) {
		var node = this.arrPages[fromTop ? "shift": "pop"]();
		node.parentNode.removeChild(node)
	},
	scroll: function(el) {},
	_onClickDown: function(e) {
		e.stop();
		this.showMore(true)
	}
}).extend(metis.Component);
if ($Agent().navigator().ie && window.top != window) {
	window.onload = function() {
		var button_down = jindo.$("btm1m_down");
		var containers = jindo.$$("div.dc2");
		window.oMoreResult = new metis.MoreResult({
			url: "",
			pageSize: 15,
			button_down: button_down,
			container: containers[0]
		})
	}
}
$Fn(function() {
	var button_down = jindo.$("btm1m_down");
	var containers = jindo.$$("div.dc2");
	window.oMoreResult = new metis.MoreResult({
		url: "",
		pageSize: 15,
		button_down: button_down,
		container: containers[0]
	})
}).attach(document, "domready");


// ---------------- metis.mobile_pron_listening_guide.js ----------------
/**
 * 모바일 어학사전 - 미국/영국 발음 듣기
 */
metis.MobilePronListening = {
	/**
	 * @param {Object}
	 *            oOption 초기화 값
	 * @description 모바일 발음듣기 초기화
	 */
	init: function() {
		this.canPlay = false;
		/* load & play 플래그 */

/* audio 생성 */
		var HTMLFragment = (document.createDocumentFragment) ? document.createDocumentFragment() : document.createElement("div");
		var HTMLStack = document.createElement("div");
		    HTMLStack.id = "nhn_html_stack";
		    HTMLFragment.appendChild(HTMLStack);
		    HTMLStack.innerHTML="<audio></audio>";
		
		this.audio = HTMLStack.firstChild;
		// 자동재생
		this._hTimeout = null;
		// setTimeOut의 값
		/* mp3 codec checking */
		this._attachEvents();

	},
	/**
	 * @param {Object}
	 *            sFile mp3파일
	 * @param {Object}
	 *            el play 대상
	 * @param {Object}
	 *            sType 미국/영어 type
	 * @description 발음듣기 play
	 */
	audioPlay: function(sFile, el, sType) {

		this.elTarget = el;
		this.sFile = sFile;

		/* 로딩중 message 영역 */
		this._setMessage();
		/* 이전 audio 체크 */
		this._checkAudio();
		/* target에 따른 audio 영역 저장 */
		this._setAudioElement();

	},
	/**
	 * @private
	 * @description 이전 audio가 재생중일경우 stop
	 */
	_checkAudio: function() {
		/* play 중인 오디오 체크 */
		if (this.canPlay) {
			this.audio.pause();
			this._playStart();
			this._playEnd();

		}

	},
	/**
	 * @private
	 * @description 마크업의 loading bar를 저장한다.
	 * @param {Object}
	 *            oOption 로딩바
	 */
	_setMessage: function() {
		this._elLodingArea = $("loading");
		// 로딩중 영역

	},
	/**
	 * @private
	 * @description 오디오 영역 저장
	 */
	_setAudioElement: function() {
		this._pArea = this.elTarget.parentNode.parentNode;
		// 발음듣기 및 예문보기 다른뜻 영역
		this._elPronListeningArea = $$.getSingle("span._dicsp", this._pArea);
		// 발음듣기만 영역
		this._playIconArea = $$.getSingle("span.dicl", this._pArea);
		// 발음듣기 아이콘 영역
		this._loadAudio();

	},
	/**
	 * @private
	 * @description audio 준비 작업
	 */
	_loadAudio: function() {
		this.audio.src = this.sFile;
		this.audio.load();
		/* load 플래그 활성화 */
		this.canPlay = true;

	},
	/**
	 * @private
	 * @description audio 이벤트
	 */
	_attachEvents: function() {
		$Fn(this._canplay, this).attach(this.audio, "canplay");
		$Fn(this._load, this).attach(this.audio, "loadstart");
		$Fn(this._playError, this).attach(this.audio, "error");
		$Fn(this._playStart, this).attach(this.audio, "play");
		$Fn(this._playEnd, this).attach(this.audio, "ended");
		$Fn(this._waiting, this).attach(this.audio, "waiting"); 
		if (!this._btnStatusTimeout) {
			this._btnStatusTimeout = setInterval($Fn(function() {
				if (this.audio.ended === true && !this.loading && this.canPlay) {
					this._playStart();
					this._playEnd();

				}

			},
			this).bind(), 300);

		}

	},
	_canplay: function(){
		if (0.1 > this.audio.volume) {
       	 this.audio.volume = 1
        }
        this.audio.play();
	},
	_playError: function (e) {
		this.audio.pause();
		this._playEnd();
	},
	/**
	 * @private
	 * @description 로딩 시작 이벤트 핸들러
	 */
	_load: function() {
		this.loading = true;
		if (this.canPlay) {
			this._loadingHide();
			// hide 영역
			this._loadingShow();
			// show 영역

			this._delayLoding();

		}

	},
	/**
	 * @private
	 * @description 로딩시 이미지 노출
	 */
	_loadingShow: function() {
		$Element(this._pArea).prepend(this._elLodingArea);
		// 로딩중,재생중 영역 삽입
		$Element(this._elLodingArea).css("display", "inline-block");

	},
	/**
	 * @private
	 * @description 재생 시작시 발음기호 노출
	 */
	_playStart: function() {
		if (this.canPlay) {
			this.startPlay = true;
			$Element(this._elLodingArea).css("display", "none");

			// 20121019 $Element(this._playIconArea).addClass("dicl_v1");
			$Element(this._playIconArea).addClass("on");
			$Element(this._elPronListeningArea).css("display", "inline-block");

		}
		this.loading = false;

	},
	_waiting: function() {
		// 20121019  $Element(this._playIconArea).removeClass("dicl_v1");
		$Element(this._playIconArea).removeClass("on");
		this.audio.src = null;
		/* load & play 플래그 비활성화 */
		this.canPlay = false;

	},


/**
 * @private
 * @description 재생완료
 */
	_playEnd: function() {
		/* 재생완료 후 경로 null */
		// 20121019 $Element(this._playIconArea).removeClass("dicl_v1");
		$Element(this._playIconArea).removeClass("on");
		this.audio.src = null;
		/* load & play 플래그 비활성화 */
		this.canPlay = false;
		this.startPlay = false;
		this.loading = false;
		// console.debug($Element(this._playIconArea).className());

	},
	/**
	 * @private
	 * @description 로딩시 이미지 미노출
	 */
	_loadingHide: function() {
		$Element(this._elPronListeningArea).css("display", "none");

	},
	/**
	 * @private
	 * @description setTimeOut 을 clear시킨다.
	 */
	_clearTimeout: function() {
		if (this._hTimeout !== null) {
			clearTimeout(this._hTimeout);
			this._hTimeout = null;

		}

	},
	/**
	 * @private
	 * @description 로딩 30초 delay시 발음기호 셋팅
	 */
	_delayLoding: function() {
		this._clearTimeout();
		/* this._hTimeout : setTimeOut의 return값을 가짐 */
		this._hTimeout = setTimeout($Fn(function() {
			if (this.canPlay && this.loading && !this.startPlay) {
				// 경고 Msg
				alert("로딩이 지연되었습니다.\n다시 시도해 주시기 바랍니다.");
				this._playStart();
				this._playEnd();

			}

		},
		this).bind(), 10000);

	}

};



// ---------------- ListSwitcher.js ----------------
metis.ListSwitcher = jindo.$Class(
{
	$init: function(opt) {
		this.name_list = opt.list;
		this.button = jindo.$(opt.button);
		this.list = jindo.$$("." + opt.list, document.body);
		this.inner_button = jindo.$$.getSingle("> span", this.button);
		this._bindEvents()

	},
	_bindEvents: function() {
		$Fn(this._onClick, this).attach(this.button, "click")

	},
	open: function(e) {
		var oCookie = new $Cookie();
		oCookie.set("LIST_SWITCHER", "o", 30);
		nclk(this, 'pos.eunfold', '', 1);
		this._setOlStyle(false);
		this.inner_button.className = "up"

	},
	close: function(e) {
		var oCookie = new $Cookie();
		oCookie.set("LIST_SWITCHER", "c", 30);
		nclk(this, 'pos.efold', '', 1);
		this._setOlStyle(true);
		this.inner_button.className = "dw"

	},
	_setOlStyle: function(isDown) {
		for (var i = 0, l = this.list.length; i < l; i++) {
			this.list[i].className = this.name_list + " "
			+ (isDown ? "li2": "li1")

		}

	},
	toggle: function(e) {		
		if (this.inner_button.className == "up") {
			this.close(e)

		} else {
			this.open(e)

		}

	},
	_onClick: function(e) {
		e.stop();
		this.list = jindo.$$(".ol_tag" , document.body);
		this.toggle(e)

	}

}).extend(metis.Component);

metis.LearnInfoSwitcher = jindo.$Class({
	$init: function(opt) {
		this.id_name = opt.name;
		this.div_dom = jindo.$(opt.name);
		this.button = jindo.$(opt.button);
		this.inner_button = jindo.$$.getSingle("> span", this.button);
		this.btnIcon = jindo.$$.getSingle("> span.hc", this.inner_button);
		this._bindEvents()

	},
	_bindEvents: function() {
		$Fn(this._onClick, this).attach(this.button, "click")

	},
	open: function(e) {
		var oCookie = new $Cookie();
		oCookie.set("LEARNINFO_SWITCHER", "o", 30);
		nclk(this, 'pos.iunfold', '', 1);
		if(this.btnIcon==null){
			this.inner_button.className = "up";
		}
		if (this.div_dom == null)
		return;
		this._setOlStyle(false);
		
		

	},
	close: function(e) {
		var oCookie = new $Cookie();
		oCookie.set("LEARNINFO_SWITCHER", "c", 30);
		nclk(this, 'pos.ifold', '', 1);
		this.inner_button.className = "dw";
		if (this.div_dom == null)
		return;
		this._setOlStyle(true)
		window.location.hash = "";
	},
	_setOlStyle: function(isDown) {
		if (isDown)
		this.div_dom.style.display = "none";
		else
		this.div_dom.style.display = "block"

	},
	toggle: function(e) {
		if (this.div_dom.style.display = "none") {
			this.open(e)
		} 
		var url = window.location.href;
		if(window.location.hash=="#STUDY"){
			window.location.hash =  "#";
		}else if(url.indexOf("#")>-1){
			url = url.substring(1,url.indexOf("#"));
		}
		
		window.location.hash =  "#STUDY"; 
	},
	_onClick: function(e) {
		e.stop();
		this.toggle(e)

	}

}).extend(metis.Component);

metis.FontSizeSwitch = jindo.$Class({
	$init: function(opt) {		
		this.div_dom = $Element(jindo.$(opt.name));
		this.btnFtnSmall = $Element(jindo.$(opt.btnFtnSmall));
		if (jindo.$(opt.btnFtnMid)) {
			this.btnFtnMid = $Element(jindo.$(opt.btnFtnMid));
		}
		this.btnFtnBig = $Element(jindo.$(opt.btnFtnBig));
		this.oCookie = new $Cookie();
		this._bindEvents();
	},
	_bindEvents: function() {
		$Fn(this._onClick, this).attach(this.btnFtnSmall.$value(), "click");
		if (this.btnFtnMid) {
			$Fn(this._onClick, this).attach(this.btnFtnMid.$value(), "click");
		}
		$Fn(this._onClick, this).attach(this.btnFtnBig.$value(), "click");

	},
	_onClick: function(e) {		
		var item = $Element(e.currentElement);		
		this.oCookie.set("M_ENDIC_FT_SIZE", item.className(), 30);		
		if (item.hasClass("ft_small") ){
			this.div_dom.removeClass("ft_mod").removeClass("ft_modMid");
			this.btnFtnSmall.addClass("on");
			if (this.btnFtnMid) {
				this.btnFtnMid.removeClass("on");	
			}
			this.btnFtnBig.removeClass("on");	
			nclk(this, 'pos.fsmall', '', 1);
		} else if (item.hasClass("ft_mid") ){
			this.div_dom.addClass("ft_modMid").removeClass("ft_mod");
			this.btnFtnSmall.removeClass("on");
			if (this.btnFtnMid) {
				this.btnFtnMid.addClass("on");	
			}
			this.btnFtnBig.removeClass("on");	
			nclk(this, 'pos.fmid', '', 1);
		}else{
			this.div_dom.addClass("ft_mod").removeClass("ft_modMid");
			this.btnFtnSmall.removeClass("on");
			if (this.btnFtnMid) {
				this.btnFtnMid.removeClass("on");
			}
			this.btnFtnBig.addClass("on");
			nclk(this, 'pos.fbig', '', 1);
		}			
	}		
});

metis.EntryDerivSwitch = jindo.$Class({
	$init: function(opt) {
		this.divDeriv = $Element(jindo.$(opt.divDeriv));
		this.ulDeriv = $Element(jindo.$(opt.ulDeriv));
		this.btnMore = $Element(jindo.$(opt.btnMore));
		this._bindEvents();
		this.firstDeriv = $Element(jindo.$$(".entry_tbl > li .entry_r .entry_lip")[0]);
		if(this.firstDeriv !=null){
			$Element(jindo.$$(".entry_tbl > li")[0]).addClass("frst_lst");
			this.firstDeriv.addClass("entry_lip_v2");
		}
	},
	_bindEvents: function() {
		$Fn(this._onClick, this).attach(this.btnMore.$value(), "click");
	},
	_onClick: function(e) {				
		if (this.ulDeriv.hasClass("off") ){
			this.ulDeriv.removeClass("off");
			this.firstDeriv.removeClass("entry_lip_v2");		
			nclk(this, 'etr.aunfold', '', 1);
		}else{
			this.ulDeriv.addClass("off");
			this.firstDeriv.addClass("entry_lip_v2");
			nclk(this, 'etr.afold', '', 1);
		}			
		this.btnMore.toggleClass("more_open","more_clse"); 
	}		
});

metis.EntryDicTypeSwitch = jindo.$Class({
	$init: function(opt) {		
		this.ulDicType = jindo.$(opt.ulDicType);
		this.divDicContent = jindo.$(opt.divDicContent);
		this.curDicType = $$("div#ct .nv1.sub_tab li.on").length>0 ? $Element($$("div#ct .nv1.sub_tab li.on")[0]).attr("dicType") : "";
		this.curShowDicType = this.curDicType;
		this.multNameDic = $Element(jindo.$$.getSingle("#dicMultName"));
		this._bindEvents();
	},
	_bindEvents: function() {
		$Fn(this._onClick, this).attach(this.ulDicType, "mousedown");
	},
	_onClick:function(e){
		var _this = this;
		var curClkObj = $Element(e.element);
		if (!curClkObj.attr("entryId")) {
			curClkObj = curClkObj.parent(function(o) {return $Element(o).attr("entryId")});
			curClkObj = curClkObj.length > 0 ? curClkObj[0] : null;  
		}
		if(!curClkObj || curClkObj.hasClass("on")) return true;
		var curSelDic = $Element(jindo.$$.getSingle("li.on",this.ulDicType));
		curSelDic.removeClass("on");
		curClkObj.addClass("on");
		var entryId = curClkObj.attr("entryId");
		var dicType = curClkObj.attr("dicType")
		_this.curDicType = dicType;
		_this.showContent(entryId,dicType, _this);
		var multNameSourceDic = $Element(jindo.$$.getSingle(".multName_"+dicType));
		if (multNameSourceDic!=null) this.multNameDic.html(multNameSourceDic.html());
	},
	addContent: function(content, _this) {		
		var content = content.substring(content.indexOf("###OOXX###")+10);
		var target = $$("div#dicContent div.makeAjaxContent")[0];		
		dicTools.insertHtml("AfterEnd", target, content);
	},
	showContent: function(entryId, dicType, _this) {
		if ($$(".dicType_"+dicType).length > 0) {
			_this.hideCurType(_this);			
			_this.curShowDicType = dicType;
			_this.showCurType(_this);
			_this.setMultName(_this,dicType);
			return;
		}
		var url = location.href;
		var params = {entryId:entryId};		
		url = "/ajaxEnkrEntry.metis";
		var ajax = $Ajax(url, {
			onload : function(res) {
				var content = res.text();
				if(_this.curDicType == dicType) {
					_this.hideCurType(_this);					
					_this.curShowDicType = dicType;
					_this.addContent(content, _this);
					_this.setMultName(_this,dicType);
				}
			}
		}).request(params);
	},
	hideCurType : function(_this) {
		if (_this.curShowDicType != "") {
			$A($$(".dicType_" + _this.curShowDicType)).forEach( function(item) {
				item.style.display = "none";
			});
		}
	},
	showCurType : function(_this) {
		if (_this.curShowDicType != "") {
			$A($$(".dicType_" + _this.curDicType)).forEach( function(item) {
				item.style.display = "block";
			});
		}
	},
	setMultName : function(_this,dicType){
		var multNameSourceDic = $Element(jindo.$$.getSingle(".multName_"+dicType));
		if (multNameSourceDic!=null) _this.multNameDic.html(multNameSourceDic.html());
	}
});
$Fn(function() {
	if($("vi_entry_div")!=null){
		var btnViEntry = $("btn_vi_entry");
		$Fn(function (){
			var url = window.location.href;	
			if(window.location.hash=="#vi_entry_div"){
				window.location.hash =  "#";
			} else if(url.indexOf("#")>-1){
				url = url.substring(1,url.indexOf("#"));
			}
			
			window.location.hash =  "#vi_entry_div"; 
		}).attach(btnViEntry,"click");
	}
}).attach(document, "domready");
