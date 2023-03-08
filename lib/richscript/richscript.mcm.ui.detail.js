/*
 * $mcm.ui.detail 객체
 * 
 * 상품 상세페이지 UI를 제어한다.
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

if (!window.$mcm) {
	window.$mcm = {};
	if (!window.$mcm.ui) {
		window.$mcm.ui = {};
	}
}
var richscriptMcmUiDetail = $mcm.ui.detail = {
	instanceName: "richscriptMcmUiDetail",
	conf: {
		  photoPageSize: 6
		, photoListDataW: 70
		, infoMinH: 88
	},
	vars: {
		  photoCurIdx: 0
		, photoMaxPage: 0
		, photoCurPage: 0
		, menuBarCurY: 0
		, menuBarCurIdx: 0
	},
	
	/**
	* 상품 상세페이지 활성화
	* @return Void
	*/
	active: function() {
		this.activePhoto();
		this.activeMenuBar();
		this.activeInfoMore();
	},
	
	/**
	* 상단 좌측 상품 사진보기 활성화
	* @return Void
	*/
	activePhoto: function() {
		var o = this.instanceName;
		var size = $(this.all.photoData).length-1;
		this.vars.photoMaxPage = Math.toInt(size/this.conf.photoPageSize);
		if (size<=this.conf.photoPageSize) {
			$(this.id.photo.next).addClass("disabled");
		}
		$(this.id.photo.prev).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollPhotoList(window[o].vars.photoCurPage-1);
			}
			return false;
		});
		$(this.id.photo.next).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollPhotoList(window[o].vars.photoCurPage+1);
			}
			return false;
		});
		if ($(this.all.photoData).length>1) {
			$(this.all.photoButton).each(function(i) {
				var idx = i;
				$(this).click(function(e) {
					e.preventDefault();
					if (!$(this).hasClass("selected")) {
						window[o].viewPhoto(idx);
					}
					return false;
				});
			});
			$(this.all.photoData).each(function(i) {
				var idx = i;
				$(this).click(function(e) {
					e.preventDefault();
					window[o].viewNextPhoto(idx+1);
					return false;
				});
			});
		} else {
			$(this.all.photoButton+", "+this.all.photoData).css({cursor:"default"}).click(function(e) {
				e.preventDefault();
				return false;
			});
		}
		this.viewPhoto(0, true);
	},
	
	/**
	* 상단 좌측 상품 사진보기 해당 사진을 보여준다.
	* @param _idx : (Number) 사진 인덱스
	* @param _isFirst : (boolean) 최초 로딩 시 모션 없이 처리할지 여부
	* @return Void
	*/
	viewPhoto: function(_idx, _isFirst) {
		var o = this.instanceName;
		var idx = Math.toInt(_idx);
		var prevIdx = this.vars.photoCurIdx;
		$($(this.all.photoButton).removeClass("selected").get(idx)).addClass("selected");
		if (_isFirst!==true) {
			$($(this.all.photoData).get(prevIdx)).stop().css({zIndex:2,opacity:1,filter:"Alpha(opacity=100)"});
			$($(this.all.photoData).get(idx)).stop().css({zIndex:3,opacity:0,filter:"Alpha(opacity=0)",display:"block"}).fadeTo("fast", 1, function() {
				$($(window[o].all.photoData).get(prevIdx)).css({zIndex:1,opacity:0,filter:"Alpha(opacity=0)",display:"none"});
			});
		} else {
			$($(this.all.photoData).get(idx)).css({zIndex:3,opacity:1,filter:"Alpha(opacity=100)",display:"block"});
		}
		this.vars.photoCurIdx = idx;
	},
	
	/**
	* 상단 좌측 상품 사진보기 다음 사진을 보여준다.
	* @param _idx : (Number) 사진 인덱스
	* @return Void
	*/
	viewNextPhoto: function(_idx) {
		var idx = Math.toInt(_idx);
		if (idx>=$(this.all.photoData).length) {
			idx = 0;
		}
		var page = Math.toInt(idx/this.conf.photoPageSize);
		if (page!=this.vars.photoCurPage) {
			this.scrollPhotoList(page);
		}
		this.viewPhoto(idx);
	},
	
	/**
	* 상단 좌측 상품 사진보기 해당 페이지로 스크롤 한다.
	* @param _page : (Number) 이동할 페이지 번호
	* @return Void
	*/
	scrollPhotoList: function(_page) {
		var tarPage = (_page<0) ? 0 : _page;
		var tarX = this.conf.photoListDataW * this.conf.photoPageSize * tarPage * -1;
		$(this.id.photo.prev)[(tarPage==0)?"addClass":"removeClass"]("disabled");
		$(this.id.photo.next)[(tarPage>=this.vars.photoMaxPage)?"addClass":"removeClass"]("disabled");
		$(this.id.photo.list).stop().animate({left:tarX}, 1200, "easeInOutCubic");
		this.vars.photoCurPage = tarPage;
	},
	
	/**
	* 상품 메뉴바를 활성화 한다.
	* @return Void
	*/
	activeMenuBar: function() {
		var o = this.instanceName;
		$(window).scroll(function(e) {
			window[o].moveMenuBar();
		});
		$(this.all.menuBarButton).each(function(i) {
			var idx = i;
			$(this).click(function(e) {
				e.preventDefault();
				$mcm.scrollTo($(window[o].id.menuBar.menu[idx]).offset().top-80, 600);
				return false;
			});
		});
		this.moveMenuBar();
	},
	
	/**
	* 상품 메뉴바를 화면 스크롤시 상단에 위치하도록 유지시킨다.
	* @return Void
	*/
	moveMenuBar: function() {
		var scrollTop = $.browser.scrollTop();
		var curY = Math.max(scrollTop-$(this.id.menuBar.home).offset().top,0);
		var prevY = this.vars.menuBarCurY;
		if (!$.browser.isIE6&&!$.browser.isMobile) {
			if (prevY>0&&curY==0) {
				$(this.id.menuBar.bar).css({position:"absolute",top:0});
			} else if (prevY==0&&curY>0) {
				$(this.id.menuBar.bar).css({position:"fixed",top:0});
			}
		} else {
			if (prevY!=curY) {
				$(this.id.menuBar.bar).css({position:"absolute",top:curY});
			}
		}
		scrollTop += 100;
		var prevIdx = this.vars.menuBarCurIdx;
		var curIdx = 0;
		if (scrollTop>$(this.id.menuBar.menu[1]).offset().top) {
			curIdx = 1;
			if (scrollTop>$(this.id.menuBar.menu[2]).offset().top) {
				curIdx = 2;
				if (scrollTop>$(this.id.menuBar.menu[3]).offset().top) {
					curIdx = 3;
				}
			}
		}
		if (curIdx!=prevIdx) {
			$($(this.all.menuBarButton).removeClass("selected").get(curIdx)).addClass("selected");
		}
		this.vars.menuBarCurY = curY;
		this.vars.menuBarCurIdx = curIdx;
	},
	
	/**
	* 상품 정보부분의 긴 설명 show/hide기능을 활성화한다.
	* @return Void
	*/
	activeInfoMore: function() {
		var o = this.instanceName;
		$(this.all.infoMoreButton).each(function(i) {
			var idx = i;
			$(this).click(function(e) {
				e.preventDefault();
				var isOpened = $(this).hasClass("btn-opened");
				var data = $($(window[o].all.infoContents).get(idx));
				$(this)[(!isOpened)?"addClass":"removeClass"]("btn-opened");
				data.stop().animate({height:Math.max((!isOpened?data.find("div.info-contents-full").outerHeight():0), window[o].conf.infoMinH)});
				data = null;
				return false;
			});
		});
		$(window).load(function() {
			$(window[o].all.infoFullContents).each(function(i) {
				var idx = i;
				if ($(this).outerHeight()<=window[o].conf.infoMinH) {
					$($(window[o].all.infoMoreButton).get(idx)).css({display:"none"});
				}
			});
		});
	},
	
	/**
	* 상품 상세페이지 초기화
	* @return Void
	*/
	initialize: function() {
		this.id = {
			photo: {
				  list: "div.thumb-ui div.photo-button-list div.list table"
				, prev: "div.thumb-ui div.photo-button-list div.prev a"
				, next: "div.thumb-ui div.photo-button-list div.next a"
			},
			menuBar: {
				  home: "#ui-detail-menu-bar-home"
				, bar: "#ui-detail-menu-bar"
				, menu: [
					  "#ui-contents-root ul.product-photolist"
					, "#ui-contents-root div.product-information"
					, "#ui-contents-root div.product-review"
					, "#ui-contents-root div.product-relation"
				]
			}
		};
		this.all = {
			  photoData: "div.orginal-photo div.photo-list div.photo"
			, photoButton: "div.thumb-ui div.photo-button-list div.list a"
			, menuBarButton: "#ui-detail-menu-bar div.button a"
			, infoContents: "div.product-information dd.info-contents"
			, infoFullContents: "div.product-information dd.info-contents div.info-contents-full"
			, infoMoreButton: "div.product-information a.info-contents-btn"
		};
		this.active();
	}
};

$(function() {
	$mcm.ui.detail.initialize();
});
