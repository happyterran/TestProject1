/*
 * $mcm.ui.main 객체
 * 
 * 메인페이지 UI를 제어한다.
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

if (!window.$mcm) {
	window.$mcm = {};
	if (!window.$mcm.ui) {
		window.$mcm.ui = {};
	}
}
var richscriptMcmUiMain = $mcm.ui.main = {
	instanceName: "richscriptMcmUiMain",
	conf: {
		  promotionPageSize: 4
		, promotionDataW: 240
		, visualW: 940
		, categoryRelatedListH: 340
	},
	status: {
		  categoryRelatedListOpened: false
		, categoryAllOpened: false
	},
	timer: {
		  scrollVisual: null
		, blurCategoryProduct: []
		, cleanupWelcomeCover: null
		, removeWelcomeCover: null
	},
	delay: {
		  scrollVisual: 10000
		, cleanupWelcomeCover: 3000
		, removeWelcomeCover: 500
	},
	vars: {
		promotionMaxPage: 0
		, promotionCurPage: 0
		, promotionCurIdx: -1
		, promotionNextIdx: -1
		, visualSize: 0
		, visualCurIdx: -1
		, categoryCurIdx: -1
	},
	
	/**
	* MCM UI Main 활성화
	* @return Void
	*/
	active: function() {
		this.activePromotion();
		this.activeVisual();
		this.activeCategory();
		this.activeWelcomeCover();
	},
	
	/**
	* 상단 프로모션 활성화
	* @return Void
	*/
	activePromotion: function() {
		var o = this.instanceName;
		var size = $(this.all.promotionData).length-1;
		this.vars.promotionMaxPage = Math.toInt(size/this.conf.promotionPageSize);
		if (size<=this.conf.promotionPageSize) {
			$(this.id.promotion.next).addClass("disabled");
		}
		$(this.id.promotion.prev).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollPromotion(window[o].vars.promotionCurPage-1);
			}
			return false;
		});
		$(this.id.promotion.next).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scrollPromotion(window[o].vars.promotionCurPage+1);
			}
			return false;
		});
		$(this.all.promotionData).each(function(i) {
			var idx = i;
			$(this).click(function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].openPromotion(idx);
				} else {
					window[o].closePromotion();
				}
				return false;
			});
		});
		$(this.all.promotionBoxData).each(function(i) {
			var image = $(this).find("div.image a");
			if (image.get(0)) {
				var src = image.attr("imageSrc");
				var width = image.attr("width");
				var height = image.attr("height");
				var size = {width:width+"px", height:height+"px"};
				image.css(size).css(
					(!$.browser.isIE6)?
					{background:"url("+src+") no-repeat"}:
					{filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(src="+src+", sizingMethod=scale)"}
				).parent().css(size);
			}
			image = null;
			$(this).css({display:"none"});
		});
		
		if (!$.browser.isMobile) {
			$(this.all.promotionData).mouseenter(function() {
				if (!$(this).hasClass("selected")) {
					$(this).addClass("hover");
				}
			}).mouseleave(function() {
				$(this).removeClass("hover");
			});
		}
	},
	
	/**
	* 상단 프로모션의 상세보기를 펼친다.
	* @param _idx : (Number) 선택된 프로모션 번호
	* @return Void
	*/
	openPromotion: function(_idx) {
		var o = this.instanceName;
		var idx = _idx;
		if (this.vars.promotionCurIdx==-1) {
			var data = $(this.all.promotionBoxData).get(idx);
			if (data) {
				this.vars.promotionCurIdx = idx;
				$($(this.all.promotionData).get(idx)).addClass("selected");
				var tarH = $(data).css({display:"block"}).outerHeight();
				var delay = Math.max(Math.toInt(tarH/10) * 10, 500);
				$(this.id.promotionBoxCursor).css({paddingLeft:this.conf.promotionDataW*(idx%this.conf.promotionPageSize)});
				$(this.id.promotionBox).stop().animate({height:tarH}, delay, "easeInOutCubic", function() {
					var tarY = $(window[o].id.promotion.root).offset().top;
					$mcm.scrollTo(tarY, 500, function() {
						window[o].loadPromotionRelatedList(idx);
					});
				});
				var image = $(data).find("div.image a");
				if (image.get(0)) {
					image.stop().animate({top:0}, delay+500, "easeInOutCubic");
				}
				image = null;
			}
			data = null;
		} else {
			this.vars.promotionNextIdx = idx;
			this.closePromotion();
		}
	},
	
	/**
	* 상단 프로모션의 관련상품 목록을 로딩한다.
	* 각 프로모션 별로 최초 1회만 로딩한다.
	* @param _idx : (Number) 선택된 프로모션 번호
	* @return Void
	*/
	loadPromotionRelatedList: function(_idx) {
		var idx = _idx;
		var data = $(this.all.promotionBoxData).get(idx);
		var relatedList = $(data).find("div.related-list");
		if (relatedList.get(0)) {
			if (relatedList.html().trim()=="") {
				var frameName = this.instanceName+"_promotion_"+idx;
				var src = relatedList.attr("src");
				relatedList.get(0).innerHTML = '<div class="cover"></div><iframe name="'+frameName+'" id="'+frameName+'" src="'+src.escapeXml()+'" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>';
			}
		}
		data = relatedList = null;
	},
	
	/**
	* 상단 프로모션의 상세보기를 접는다.
	* @return Void
	*/
	closePromotion: function() {
		var o = this.instanceName;
		var idx = this.vars.promotionCurIdx;
		var data = $(this.all.promotionBoxData).get(idx);
		if (data) {
			var tarH = $(data).outerHeight();
			var delay = Math.max(Math.toInt(tarH/10) * 10, 500);
			$(this.id.promotionBox).stop().animate({height:1}, delay, "easeInOutCubic", function() {
				$($(window[o].all.promotionBoxData).get(idx)).css({display:"none"});
				window[o].vars.promotionCurIdx = -1;
				$($(window[o].all.promotionData).get(idx)).removeClass("selected");
				var nextIdx = window[o].vars.promotionNextIdx;
				if (nextIdx>-1) {
					window[o].vars.promotionNextIdx = -1;
					setTimeout(function() {
						window[o].openPromotion(nextIdx);
					}, 100);
				}
			});
			var image = $(data).find("div.image a");
			if (image.get(0)) {
				image.stop().animate({top:41}, delay, "easeInOutCubic");
			}
			image = null;
		}
		data = null;
	},
	
	/**
	* 상단 프로모션 목록을 해당 페이지로 스크롤 한다.
	* @param _page : (Number) 이동할 페이지 번호
	* @return Void
	*/
	scrollPromotion: function(_page) {
		var tarPage = (_page<0) ? 0 : _page;
		var tarX = this.conf.promotionDataW * this.conf.promotionPageSize * tarPage * -1;
		$(this.id.promotion.prev)[(tarPage==0)?"addClass":"removeClass"]("disabled");
		$(this.id.promotion.next)[(tarPage>=this.vars.promotionMaxPage)?"addClass":"removeClass"]("disabled");
		$(this.id.promotion.list).stop().animate({left:tarX}, 1200, "easeInOutCubic");
		this.vars.promotionCurPage = tarPage;
	},
	
	/**
	* 중앙 비주얼 배너 활성화
	* @return Void
	*/
	activeVisual: function() {
		var o = this.instanceName;
		this.vars.visualSize = $(this.all.visualButton).length;
		$(this.all.visualButton).each(function(i) {
			var idx = i;
			$(this).click(function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].showVisual(idx);
				}
				return false;
			});
		});
		this.showVisual(Math.randomInt(this.vars.visualSize-1), true);
	},
	
	/**
	* 중앙 비주얼 배너 영역에 해당 비주얼을 FadeIn한다.
	* @param _idx : (Number) 보여줄 비주얼 번호
	* @param _isFirst : (boolean) 최초 로딩시 랜덤선택된 비주얼을 FadeIn 모션 없이 보여주기위해 사용한다.
	* @return Void
	*/
	showVisual: function(_idx, _isFirst) {
		var o = this.instanceName;
		$($(this.all.visualButton).removeClass("selected").get(_idx)).addClass("selected");
		var prevIdx = this.vars.visualCurIdx;
		if (_isFirst!==true) {
			$($(this.all.visualImage).get(prevIdx)).stop().css({zIndex:2});
			$($(this.all.visualImage).get(_idx)).stop().css({zIndex:3,opacity:.0,filter:"Alpha(opacity=0)"}).fadeTo("slow", 1, function() {
				var curIdx = _idx;
				$(window[o].all.visualImage).each(function(i) {
					if (i!=curIdx) {
						$(this).stop().css({zIndex:1,opacity:.0,filter:"Alpha(opacity=0)"});
					}
				});
			});
		} else {
			$($(this.all.visualImage).get(_idx)).css({zIndex:3,opacity:1.0,filter:"Alpha(opacity=100)"});
		}
		this.vars.visualCurIdx = _idx;
		this.showNextVisual();
	},
	
	/**
	* 정해진 시간이 지나면 자동으로 다음 비주얼 배너를 보여준다.
	* @return Void
	*/
	showNextVisual: function() {
		if (this.vars.visualSize>1) {
			var o = this.instanceName;
			var nextIdx = this.vars.visualCurIdx+1;
			if (nextIdx>=this.vars.visualSize) {
				nextIdx = 0;
			}
			clearTimeout(this.timer.scrollVisual);
			this.timer.scrollVisual = setTimeout(function() {
				window[o].showVisual(nextIdx);
			}, this.delay.scrollVisual);
		}
	},
	
	/**
	* 하단 카테고리 활성화
	* @return Void
	*/
	activeCategory: function() {
		var o = this.instanceName;
		
		$(this.all.categoryMenu).each(function(i) {
			var idx = i;
			$(this).click(function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].showCategory(idx);
				}
				return false;
			});
		});
		
		$(this.all.categoryData).each(function(i) {
			var idx = i;
			$(this).find("div.related-btn a").click(function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].openCategoryRelatedList(idx);
				} else {
					window[o].closeCategoryRelatedList(idx);
				}
				return false;
			});
			$(this).find("div.related-list-close a").click(function(e) {
				e.preventDefault();
				window[o].closeCategoryRelatedList(idx);
				return false;
			});
		});
		
		$(this.id.categoryMenuAll).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("selected")) {
				window[o].showAllCategory();
			} else {
				window[o].showCategoryMenu();
			}
			return false;
		});
		
		$(this.all.categoryProduct).each(function(i) {
			var idx = i;
			$(this).mouseenter(function() {
				window[o].focusCategoryProduct(idx);
			}).mouseleave(function() {
				var _idx = idx;
				window[o].timer.blurCategoryProduct[idx] = setTimeout(function() {
					window[o].blurCategoryProduct(_idx);
				}, 100);
			});
		});
		$(this.all.categoryProductCartButton).each(function(i) {
			var idx = i;
			$(this).mouseenter(function() {
				window[o].focusCategoryProduct(idx);
			}).mouseleave(function() {
				var _idx = idx;
				window[o].timer.blurCategoryProduct[idx] = setTimeout(function() {
					window[o].blurCategoryProduct(_idx);
				}, 100);
			});
		});
		$(this.all.categoryProductBuyButton).each(function(i) {
			var idx = i;
			$(this).mouseenter(function() {
				window[o].focusCategoryProduct(idx);
			}).mouseleave(function() {
				var _idx = idx;
				window[o].timer.blurCategoryProduct[idx] = setTimeout(function() {
					window[o].blurCategoryProduct(_idx);
				}, 100);
			});
		});
		
		this.showCategory(Math.randomInt($(this.all.categoryData).length-1));
	},
	
	/**
	* 전체 카테고리를 보여준다.
	* @return Void
	*/
	showAllCategory: function() {
		var o = this.instanceName;
		if (this.status.categoryRelatedListOpened) {
			this.closeAllCategoryRelatedList();
		}
		$(this.all.categoryMenu).removeClass("selected");
		$(this.id.categoryNavi).stop().animate({height:21}, "fast", function() {
			$(window[o].id.categoryMenuAll).addClass("selected");
		});
		var tarH = $(this.id.categoryDataRoot).outerHeight();
		$(this.id.categoryViewport).stop().animate({height:tarH});
		$(this.id.categoryDataRoot).stop().animate({top:0});
		this.status.categoryAllOpened = true;
	},
	
	/**
	* 접혀있던 카테고리 메뉴를 펼친다.
	* @return Void
	*/
	showCategoryMenu: function() {
		$(this.id.categoryMenuAll).removeClass("selected");
		$(this.id.categoryNavi).stop().animate({height:200}, "fast");
		var prevIdx = this.vars.categoryCurIdx;
		this.vars.categoryCurIdx = -1;
		this.showCategory(prevIdx);
	},
	
	/**
	* 해당 카테고리를 보여준다.
	* @param _idx : (Number) 카테고리 번호
	* @param _isFirst : (boolean) 최초 로딩시 랜덤으로 선택된 카테고리를 모션 없이 보여주기위해 사용한다.
	* @return Void
	*/
	showCategory: function(_idx, _isFirst) {
		var o = this.instanceName, idx = _idx;
		if (this.status.categoryAllOpened) {
			this.closeAllCategoryRelatedList();
		}
		this.status.categoryAllOpened = false;
		$($(this.all.categoryMenu).removeClass("selected").get(idx)).addClass("selected");
		if (idx!=this.vars.categoryCurIdx) {
			var prevIdx = this.vars.categoryCurIdx;
			this.vars.categoryCurIdx = idx;
			if (prevIdx>-1&&this.status.categoryRelatedListOpened) {
				this.closeCategoryRelatedList(prevIdx, function() {
					window[o]._showCategory(idx);
				});
			} else {
				this._showCategory(idx, _isFirst);
			}
		}
	},
	
	/**
	* 해당 카테고리를 보여준다. (실제 모션 처리 부분)
	* @param _idx : (Number) 카테고리 번호
	* @param _isFirst : (boolean) 최초 로딩시 랜덤으로 선택된 카테고리를 모션 없이 보여주기위해 사용한다.
	* @return Void
	*/
	_showCategory: function(_idx, _isFirst) {
		var o = this.instanceName, idx = _idx;
		var data = $($(this.all.categoryData).get(idx)).find("div.data");
		var tarY = $($(this.all.categoryData).get(idx)).position().top*-1;
		var tarH = data.outerHeight()-1;
		if (_isFirst!==true) {
			$(this.id.categoryViewport).stop().animate({height:tarH});
			$(this.id.categoryDataRoot).stop().animate({top:tarY});
		} else {
			$(this.id.categoryViewport).css({height:tarH});
			$(this.id.categoryDataRoot).css({top:tarY});
		}
		data = null;
	},
	
	/**
	* 모든 카테고리의 관련상품목록을 접는다.
	* @return Void
	*/
	closeAllCategoryRelatedList: function() {
		var o = this.instanceName;
		$(this.all.categoryData).each(function(i) {
			var idx = i;
			$(this).find("div.related-list-close").css({display:"none"});
			$(this).find("div.related-btn a").removeClass("selected");
			$(this).find("div.related-list").stop().css({height:1,display:"none"});
			window[o].status.categoryRelatedListOpened = false;
		});
	},
	
	/**
	* 카테고리의 관련상품목록을 펼친다.
	* @param _idx : (Number) 카테고리 번호
	* @return Void
	*/
	openCategoryRelatedList: function(_idx) {
		var o = this.instanceName, idx = _idx;
		this.status.categoryRelatedListOpened = true;
		var data = $($(this.all.categoryData).get(idx));
		data.find("div.related-btn a").addClass("selected");
		var baseH = (!this.status.categoryAllOpened) ? data.find("div.data").outerHeight()-1 : $(this.id.categoryViewport).outerHeight();
		var tarH = baseH + this.conf.categoryRelatedListH;
		$(this.id.categoryViewport).stop().animate({height:tarH});
		data.find("div.related-list").stop().css({display:"block"}).animate({height:this.conf.categoryRelatedListH}, function() {
			$($(window[o].all.categoryData).get(idx)).find("div.related-list-close").css({display:"block"});
			var tarY = $($(window[o].all.categoryData).get(idx)).find("div.data").offset().top;
			$mcm.scrollTo(tarY, 500, function() {
				window[o].loadCategoryRelatedList(idx);
			});
		});
		data = null;
	},
	
	/**
	* 카테고리의 관련상품목록을 불러온다.
	* @param _idx : (Number) 카테고리 번호
	* @return Void
	*/
	loadCategoryRelatedList: function(_idx) {
		var idx = _idx;
		var data = $($(this.all.categoryData).get(idx));
		var relatedList = data.find("div.related-list div.iframe");
		if (relatedList.get(0)) {
			if (relatedList.html().trim()=="") {
				var frameName = this.instanceName+"_categoryRelatedList_"+idx;
				var src = relatedList.attr("src");
				relatedList.get(0).innerHTML = '<div class="cover"></div><iframe name="'+frameName+'" id="'+frameName+'" src="'+src.escapeXml()+'" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>';
			}
		}
		data = relatedList = null;
	},
	
	/**
	* 카테고리의 관련상품목록을 접는다.
	* @param _idx : (Number) 카테고리 번호
	* @param _func : (Function) 접기 모션을 완료한 다음 처리할 작업
	* @return Void
	*/
	closeCategoryRelatedList: function(_idx, _func) {
		var o = this.instanceName, idx = _idx;
		var func = (_func==undefined) ? null : _func;
		var data = $($(this.all.categoryData).get(idx));
		data.find("div.related-list-close").css({display:"none"});
		var baseH = (!this.status.categoryAllOpened) ? 
			data.find("div.data").outerHeight()-1 : 
			$(this.id.categoryViewport).outerHeight()-this.conf.categoryRelatedListH;
		var tarH = baseH;
		$(this.id.categoryViewport).stop().animate({height:tarH});
		data.find("div.related-list").stop().animate({height:1}, function() {
			$(this).css({display:"none"});
			$($(window[o].all.categoryData).get(idx)).find("div.related-btn a").removeClass("selected");
			window[o].status.categoryRelatedListOpened = false;
			if (func!=null) {
				func();
			}
		});
		data = null;
	},
	
	/**
	* 상품목록형 카테고리의 해당 상품에 FadeIn효과를 적용한다.
	* @param _idx : (Number) 상품 번호
	* @return Void
	*/
	focusCategoryProduct: function(_idx) {
		clearTimeout(this.timer.blurCategoryProduct[_idx]);
		$($(this.all.categoryProduct).get(_idx)).addClass("hover");
		$($(this.all.categoryProductCartButton).get(_idx)).stop().fadeTo("fast", .85);
		$($(this.all.categoryProductBuyButton).get(_idx)).stop().fadeTo("fast", .85);
	},
	
	/**
	* 상품목록형 카테고리의 해당 상품에 FadeOut효과를 적용한다.
	* @param _idx : (Number) 상품 번호
	* @return Void
	*/
	blurCategoryProduct: function(_idx) {
		$($(this.all.categoryProduct).get(_idx)).removeClass("hover");
		$($(this.all.categoryProductCartButton).get(_idx)).stop().fadeTo("fast", 0);
		$($(this.all.categoryProductBuyButton).get(_idx)).stop().fadeTo("fast", 0);
	},
	
	/**
	* 인트로 비주얼 활성화
	* @return Void
	*/
	activeWelcomeCover: function() {
		if (document.getElementById(this.id.welcomeCover.substring(1))) {
			var o = this.instanceName;
			this.resizeWelcomeCover();
			$(window).bind("scroll.welcomCover", function(e) {
				e.preventDefault();
				scrollTo(0,0);
				return false;
			});
			$(window).bind("load.welcomCover", function() {
				window[o].resizeWelcomeCover();
				window[o].timer.cleanupWelcomeCover = setTimeout(function() {
					window[o].cleanupWelcomeCover();
				}, window[o].delay.cleanupWelcomeCover);
			});
		}
		$.cookie.set("WC","N");
	},
	
	/**
	* 인트로 비주얼의 크기를 브라우저 사이와 동일하게 맞춘다.
	* @return Void
	*/
	resizeWelcomeCover: function() {
		$(this.id.welcomeCover).css({height:$.browser.maxHeight()});
	},
	
	/**
	* 인트로 비주얼을 걷어낸다.
	* @return Void
	*/
	cleanupWelcomeCover: function() {
		scrollTo(0,0);
		var o = this.instanceName;
		$(this.id.welcomeCoverLoading).remove();
		$(this.id.welcomeCoverVisual).stop().animate({top:-491}, 1500, "easeInOutCubic", function() {
			window[o].timer.removeWelcomeCover = setTimeout(function() {
				window[o].removeWelcomeCover();
			}, window[o].delay.removeWelcomeCover);
		});
	},
	
	/**
	* 인트로 비주얼 노드를 제거한다.
	* @return Void
	*/
	removeWelcomeCover: function() {
		scrollTo(0,0);
		$(window).unbind(".welcomCover");
		$(this.id.welcomeCover).stop().fadeTo("slow", 0, function() {
			$(this).remove();
		});
	},
	
	
	/**
	* MCM UI Main 초기화
	* @return Void
	*/
	initialize: function() {
		this.id = {
			promotion: {
				  root: "#ui-main-promotion div.list"
				, list: "#ui-main-promotion div.list table"
				, prev: "#ui-main-promotion div.prev a"
				, next: "#ui-main-promotion div.next a"
			}
			, promotionBox: "#ui-main-promotion-box div.contents"
			, promotionBoxCursor: "#ui-main-promotion-box div.contents div.cursor"
			, categoryViewport: "#ui-main-category div.viewport"
			, categoryDataRoot: "#ui-main-category div.list"
			, categoryNavi: "#ui-main-category div.navi ul"
			, categoryMenuAll: "#ui-main-category div.navi ul li.all a"
			, welcomeCover: "#ui-welcome-cover"
			, welcomeCoverVisual: "#ui-welcome-cover div.visual"
			, welcomeCoverLogo: "#ui-welcome-cover div.logo"
			, welcomeCoverLoading: "#ui-welcome-cover div.loading"
		};
		this.all = {
			  promotionData: "#ui-main-promotion div.list table td a"
			, promotionBoxData: "#ui-main-promotion-box div.contents div.data"
			, visualButton: "#ui-main-visual div.visual div.btn-bar a"
			, visualImage: "#ui-main-visual div.visual div.image a"
			, categoryData: "#ui-main-category div.category"
			, categoryMenu: "#ui-main-category div.navi ul li.menu a"
			, categoryProduct: "#ui-main-category div.category div.product-list div.product div.info a"
			, categoryProductCartButton: "#ui-main-category div.category div.product-list div.product a.cart"
			, categoryProductBuyButton: "#ui-main-category div.category div.product-list div.product a.buy"
			
		};
		this.active();
	}
};

$(function() {
	$mcm.ui.main.initialize();
});
