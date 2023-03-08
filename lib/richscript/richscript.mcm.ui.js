/*
 * $mcm.ui ��ü
 * 
 * ����Ʈ ��ü���� ���Ǵ� ���� ���� UI�� �����Ѵ�.
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

if (!window.$mcm) {
	window.$mcm = {};
}
var richscriptMcmUi = $mcm.ui = {
	instanceName: "richscriptMcmUi",
	conf: {
		  gnbMinH: 89
		, gnbMaxH: 239
		, gnbTitleMinH: 17
		, gnbTitleMaxH: 28
		, gnbIconFocusY: 0
		, gnbIconBlurY: -86
		, globalNewsH: 25
		, todayDataW: 100
		, todayPageSize: 9
		, contentsMinW: 1040
		, mobileViewportW: 1040
	},
	status: {
		  isGnbOpened: false
		, onGnbEffect: false
		, onUtilBoxCloseEffect: false
	},
	timer: {
		  openGnb: null
		, closeGnb: null
		, newsScroll: null
	},
	delay: {
		  openGnb: 300
		, closeGnb: 500
		, newsScroll: 7000
	},
	vars: {
		  curGnbIdx: -1
		, curNewsIdx: -1
		, curUtilBoxType: ""
		, nextUtilBoxType: ""
		, curTodayPage: 0
		, maxTodayPage: 0
	},
	
	/**
	* MCM UI Ȱ��ȭ
	* @return Void
	*/
	active: function() {
		this.activeGnb();
		this.activeUtilBox();
		this.activeUtilBoxContentsToday();
		this.activeGlobalSearch();
		this.activeGlobalNewsScroll();
		this.activeGlobalTopButton();
	},
	
	/**
	* ��� GNB���� Ȱ��ȭ
	* @return Void
	*/
	activeGnb: function() {
		var o = this.instanceName;
		$(this.id.gnb).mouseenter(function() {
			var ui = window[o];
			clearTimeout(ui.timer.closeGnb);
			ui.timer.openGnb = setTimeout(function() {
				window[o].openGnb();
			}, ui.delay.openGnb);
			ui = null;
		}).mouseleave(function() {
			var ui = window[o];
			clearTimeout(ui.timer.openGnb);
			ui.timer.closeGnb = setTimeout(function() {
				window[o].closeGnb();
			}, ui.delay.closeGnb);
			ui = null;
		});
		$(this.all.gnbGroup).mouseenter(function() {
			window[o].focusGnb($(this).attr("idx"));
		}).mouseleave(function() {
			window[o].blurGnb($(this).attr("idx"));
		});
		if ($.browser.isMobile) {
			$(this.all.gnbTitle).click(function(e) {
				e.preventDefault();
				var url = $(this).attr("href");
				if (window[o].status.isGnbOpened) {
					location.href = url;
				} else {
					window[o].openGnb();
				}
				return false;
			});
		}
	},
	
	/**
	* ��� GNB������ ��ģ��.
	* @return Void
	*/
	openGnb: function() {
		var o = this.instanceName;
		if (!this.status.isGnbOpened) {
			this.status.isGnbOpened = true;
			this.status.onGnbEffect = true;
			$(this.all.gnbTitle).css({height:this.conf.gnbTitleMinH});
			$(this.id.gnb).stop().animate({height:this.conf.gnbMaxH}, function() {
				$(window[o].all.gnbMenu).stop().fadeTo("slow", 1, function() {
					window[o].status.onGnbEffect = false;
					window[o].focusGnb(null, true);
				});
			});
		}
	},
	
	/**
	* ��� GNB������ ���´�.
	* @return Void
	*/
	closeGnb: function() {
		var o = this.instanceName;
		if (this.status.isGnbOpened) {
			this.blurGnb();
			this.status.isGnbOpened = false;
			this.status.onGnbEffect = true;
			$(this.all.gnbMenu).stop().fadeTo("fast", 0, function() {
				$(window[o].all.gnbTitle).css({height:window[o].conf.gnbTitleMaxH});
				$(window[o].id.gnb).stop().animate({height:window[o].conf.gnbMinH}, function() {
					window[o].status.onGnbEffect = false;
				});
			});
		}
	},
	
	/**
	* GNB 1Depth �޴��� Focus ȿ���� �ش�.
	* @param _idx : (Number) GNB�ε���
	* @param _isFirst : (boolean) GNB������ Ȱ��ȭ �� �Ŀ� ���� Focus���� ����
	* @return Void
	*/
	focusGnb: function(_idx, _isFirst) {
		var idx = (_idx!=undefined&&_idx!=null) ? _idx : this.vars.curGnbIdx;
		if (idx>-1) {
			var id = this.id.gnbGroup(idx);
			var cover = id.cover;
			var isFirst = (_isFirst===true) ? true : false;
			$(id.title).addClass("hover");
			if (this.status.isGnbOpened&&!this.status.onGnbEffect) {
				$(id.box).addClass("box-on");
				var func = function() {
					$(cover).stop().fadeTo("slow", .3);
					return null;
				};
				$(id.icon).stop().animate({bottom:this.conf.gnbIconFocusY}, "slow", "easeOutBack", (isFirst)?func:func());
			}
			id = null;
		}
		this.vars.curGnbIdx = idx;
	},
	
	/**
	* Focus������ GNB 1Depth �޴��� Bluró���Ѵ�.
	* @param _idx : (Number) GNB�ε���
	* @return Void
	*/
	blurGnb: function(_idx) {
		var idx = (_idx!=undefined) ? _idx : this.vars.curGnbIdx;
		if (idx>-1) {
			var id = this.id.gnbGroup(idx);
			$(id.title).removeClass("hover");
			if (this.status.isGnbOpened&&!this.status.onGnbEffect) {
				$(id.box).removeClass("box-on");
				$(id.cover).stop().fadeTo("slow", .0);
				$(id.icon).stop().animate({bottom:this.conf.gnbIconBlurY}, "slow");
			}
			id = null;
		}
		this.vars.curGnbIdx = -1;
	},
	
	/**
	* ��� ��ƿ�޴� Ȱ��ȭ
	* @return Void
	*/
	activeUtilBox: function() {
		var o = this.instanceName;
		$(this.id.utilBoxButton.smart+", "+this.id.utilBoxButton.event+", "+this.id.utilBoxButton.today).click(function(e) {
			e.preventDefault();
			var type = $(this).attr("class").replace(/btn/gi,"").replace(/selected/gi,"").trim();
			window[o].openUtilBox(type);
			return false;
		});
		$(this.id.utilBoxCloseButton).click(function(e) {
			e.preventDefault();
			window[o].closeUtilBox();
			return false;
		}).mouseenter(function() {
			$(this).addClass("hover");
		}).mouseleave(function() {
			$(this).removeClass("hover");
		});
	},
	
	/**
	* ��� ��ƿ�޴� �������� ����.
	* @param _type : (String) ������Ÿ��
	* @return Void
	*/
	openUtilBox: function(_type) {
		var o = this.instanceName;
		if (this.vars.curUtilBoxType=="") {
			this.vars.curUtilBoxType = _type;
			var contents = this.id.utilBoxContents[_type];
			$(this.id.utilBoxButton[_type]).addClass("selected");
			$(this.id.utilBox).css({display:"block"});
			$(contents).css({display:"block"});
			var tarH = $(contents).outerHeight();
			var delay = Math.max(Math.toInt(tarH/10) * 10, 500);
			$(this.id.utilBox).stop().animate({height:tarH}, delay, "easeInOutCubic", function() {
				var tarY = $(window[o].id.utilBoxButton.root).offset().top;
				$mcm.scrollTo(tarY, 500);
				window[o].showUtilBoxCloseButton();
			});
		} else if (this.vars.curUtilBoxType!=_type) {
			this.vars.nextUtilBoxType = _type;
			this.closeUtilBox();
		} else {
			this.closeUtilBox();
		}
	},
	
	/**
	* ��� ��ƿ�޴� �������� �ݴ´�.
	* @return Void
	*/
	closeUtilBox: function() {
		if (!this.status.onUtilBoxCloseEffect) {
			var o = this.instanceName;
			var curH = $(this.id.utilBox).height();
			var delay = Math.max(Math.toInt(curH/10) * 10, 500);
			this.status.onUtilBoxCloseEffect = true;
			this.hideUtilBoxCloseButton();
			$(this.id.utilBox).stop().animate({height:1}, delay, "easeInOutCubic", function() {
				$(window[o].all.utilBoxContents).css({display:"none"});
				$(this).css({display:"none"});
				$(window[o].all.utilBoxButton).removeClass("selected");
				window[o].vars.curUtilBoxType = "";
				/*
				var tarY = $(window[o].id.utilBoxButton.root).offset().top;
				if (tarY<$(window).scrollTop()) {
					$mcm.scrollTo(tarY);
				}
				*/
				$mcm.scrollTo(0);
				setTimeout(function() {
					window[o].openNextUtilBox();
				}, 100);
			});
		}
	},
	
	/**
	* �������� ������ ��ƿ�޴� ��û�� �ִ��� üũ�Ѵ�.
	* @return Void
	*/
	openNextUtilBox: function() {
		this.status.onUtilBoxCloseEffect = false;
		var tarType = this.vars.nextUtilBoxType;
		if (tarType!="") {
			this.vars.nextUtilBoxType = "";
			this.openUtilBox(tarType);
		}
	},
	
	/**
	* ��� ��ƿ�޴� �ݱ��ư ����
	* @return Void
	*/
	showUtilBoxCloseButton: function() {
		$(this.id.utilBoxCloseButtonRoot).css({display:"block"});
		$(this.id.utilBoxCloseButton).stop().animate({top:0}, "fast");
	},
	
	/**
	* ��� ��ƿ�޴� �ݱ��ư�� �����.
	* @return Void
	*/
	hideUtilBoxCloseButton: function() {
		var o = this.instanceName;
		$(this.id.utilBoxCloseButton).stop().animate({top:65}, "fast", function() {
			$(window[o].id.utilBoxCloseButtonRoot).css({display:"none"});
		});
	},
	
	/**
	* ��� ��ƿ�޴� ���� �� ��ǰ ��� Ȱ��ȭ
	* @return Void
	*/
	activeUtilBoxContentsToday: function() {
		var o = this.instanceName;
		var size = $(this.all.utilBoxContentsTodayData).length-1;
		this.vars.maxTodayPage = Math.toInt(size/this.conf.todayPageSize);
		if (size<=this.conf.todayPageSize) {
			$(this.id.utilBoxContentsToday.next).addClass("disabled");
		}
		$(this.id.utilBoxContentsToday.prev).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollUtilBoxContentsToday(window[o].vars.curTodayPage-1);
			}
			return false;
		});
		$(this.id.utilBoxContentsToday.next).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollUtilBoxContentsToday(window[o].vars.curTodayPage+1);
			}
			return false;
		});
	},
	
	/**
	* ��� ��ƿ�޴� ���� �� ��ǰ ����� �ش� �������� ��ũ�� �Ѵ�.
	* @param _page : (Number) �̵��� ������ ��ȣ
	* @return Void
	*/
	scrollUtilBoxContentsToday: function(_page) {
		var tarPage = (_page<0) ? 0 : _page;
		var tarX = this.conf.todayDataW * this.conf.todayPageSize * tarPage * -1;
		$(this.id.utilBoxContentsToday.prev)[(tarPage==0)?"addClass":"removeClass"]("disabled");
		$(this.id.utilBoxContentsToday.next)[(tarPage>=this.vars.maxTodayPage)?"addClass":"removeClass"]("disabled");
		$(this.id.utilBoxContentsToday.list).stop().animate({left:tarX}, 1200, "easeInOutCubic");
		this.vars.curTodayPage = tarPage;
	},
	
	/**
	* ��� ���հ˻� Ȱ��ȭ
	* @return Void
	*/
	activeGlobalSearch: function() {
		var o = this.instanceName;
		$(this.id.globalSearchButton).click(function(e) {
			e.preventDefault();
			var input = $(window[o].id.globalSearchInput);
			var val = input.val().trim();
			if (val=="") {
				alert("��ǰ���� �Է��ϼ���.");
				input.focus();
			} else {
				document.searchForm.submit();
			}
			return false;
		});
		$(this.id.globalSearchInput).focus(function() {
			$(this).val("");
		}).keydown(function(e) {
			if (e.keyCode==13) {
				$(window[o].id.globalSearchButton).click();
			}
		});
	},
	
	/**
	* ��� ���� ��ũ�� ���� Ȱ��ȭ
	* @return Void
	*/
	activeGlobalNewsScroll: function() {
		var o = this.instanceName;
		var data = $(this.all.globalNewsData);
		var size = data.length;
		if (size>0) {
			var curIdx = this.vars.curNewsIdx++;
			var nextIdx = this.vars.curNewsIdx = (this.vars.curNewsIdx>=size) ? 0 : this.vars.curNewsIdx;
			if (curIdx>-1) {
				$(data.get(curIdx)).stop().animate({top:this.conf.globalNewsH*-1}, "slow", function() {
					$(this).css({top:window[o].conf.globalNewsH});
				});
				$(data.get(nextIdx)).stop().animate({top:0}, "slow");
			} else {
				$(data.get(nextIdx)).css({top:0});
			}
			if (size>1) {
				this.timer.newsScroll = setTimeout(function() {
					window[o].activeGlobalNewsScroll();
				}, this.delay.newsScroll);
			}
		}
		data = null;
	},
	
	/**
	* �ϴ� Top��ư Ȱ��ȭ
	* @return Void
	*/
	activeGlobalTopButton: function() {
		$(this.id.globalTopButton).mouseenter(function(e) {
			$(this).find("span").stop().css({top:-40}).animate({top:-59}, "fast");
		}).mouseleave(function(e) {
			$(this).find("span").stop().animate({top:-40}, "fast", function() {
				$(this).css({top:0});
			});
		}).click(function(e) {
			e.preventDefault();
			$mcm.scrollTo(0);
			return false;
		});
	},
	
	/**
	* ������ �ּ����� �����Ѵ�.
	* @return Void
	*/
	checkContentsMinWidth: function() {
		var screenW = $.browser.screenWidth();
		$(this.all.contents).css({width:(screenW>this.conf.contentsMinW)?"100%":this.conf.contentsMinW});
	},
	
	/**
	* MCM UI �ʱ�ȭ
	* @return Void
	*/
	initialize: function() {
		this.id = {
			  gnb: "#ui-header-gnb"
			, gnbContents: "#ui-header-gnb div.ui-contents"
			, gnbGroup: function(_idx) {
				return {
					  box: "#ui-header-gnb div.ui-contents div.group-"+_idx+" div.box"
					, cover: "#ui-header-gnb div.ui-contents div.group-cover-"+_idx
					, icon: "#ui-header-gnb div.ui-contents div.group-"+_idx+" div.icon"
					, title: "#ui-header-gnb div.ui-contents div.group-"+_idx+" div.box h3 a"
				};
			}
			, utilBox: "#ui-header-util-box"
			, utilBoxButton: {
				  root: "#ui-header-util"
				, smart: "#ui-header-util a.smart"
				, event: "#ui-header-util a.event"
				, today: "#ui-header-util a.today"
			}
			, utilBoxContents: {
				  smart: "#ui-header-util-box div.ui-contents div.smart"
				, event: "#ui-header-util-box div.ui-contents div.event"
				, today: "#ui-header-util-box div.ui-contents div.today"
			}
			, utilBoxContentsToday: {
				  list: "#ui-header-util-box div.ui-contents div.today div.list table"
				, prev: "#ui-header-util-box div.ui-contents div.today div.prev a"
				, next: "#ui-header-util-box div.ui-contents div.today div.next a"
			}
			, utilBoxCloseButtonRoot: "#ui-header-util-box-close-btn"
			, utilBoxCloseButton: "#ui-header-util-box-close-btn div.ui-contents div.button a"
			
			
			, globalSearchButton: "#ui-header-search a.search"
			, globalSearchInput: "#ui-header-search input.search"
			, globalTopButton: "#ui-footer-menu div.btn-top a"
		};
		this.all = {
			  contents: "div.ui-body"
			, gnbGroup: "#ui-header-gnb div.ui-contents div.group"
			, gnbTitle: "#ui-header-gnb div.ui-contents div.group div.box h3 a"
			, gnbMenu: "#ui-header-gnb div.ui-contents div.group div.box ul"
			, utilBoxButton: "#ui-header-util a"
			, utilBoxContents: "#ui-header-util-box div.ui-contents div.contents"
			, utilBoxContentsTodayData: "#ui-header-util-box div.ui-contents div.today div.list table td a"
			, globalNewsData: "#ui-header-search div.notice ul li"
		};
		
		this.active();
		
		var o = this.instanceName;
		if (!$.browser.isMobile) {
			$(window).bind("resize", function() {
				window[o].checkContentsMinWidth();
			});
			this.checkContentsMinWidth();
		} else {
			$(this.all.contents).css({width:this.conf.mobileViewportW});
		}
	}
};


$(function() {
	$mcm.ui.initialize();
	
	/* Ʈ���͹�ư API �񵿱� �ε� */
	!function(d,s,id){
		var js,fjs=d.getElementsByTagName(s)[0];
		if(!d.getElementById(id)){
			js=d.createElement(s);
			js.id=id;
			js.src="//platform.twitter.com/widgets.js";
			fjs.parentNode.insertBefore(js,fjs);
		}
	}(document,"script","twitter-wjs");
});
$(window).load(function() {
	if ($.browser.isMobile) {
		try {
			scrollTo(0,0);
		} catch(e) {}
	}
});

