/*
 * $scrolllist 객체
 * 
 * 공통으로 사용되는 흐르는 모션 형태의 상품 리스트를 구현한다.
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

var richscriptScrolllist = $scrolllist = {
	instanceName: "richscriptScrolllist",
	conf: {
		  pageSize: 6
		, dataW: 160
		, useButton: true
	},
	timer: {
		blur: []
	},
	vars: {
		  maxPage: 0
		, curPage: 0
		, curIdx: -1
		, usePaging: false
	},
	pageSize: function(_val) {
		this.conf.pageSize = _val;
		return this;
	},
	dataWidth: function(_val) {
		this.conf.dataW = _val;
		return this;
	},
	useButton: function(_val) {
		this.conf.useButton = _val;
		return this;
	},
	
	/**
	* 활성화
	* @return Void
	*/
	active: function() {
		var o = this.instanceName;
		var size = $(this.all.data).length-1;
		this.vars.maxPage = Math.toInt(size/this.conf.pageSize);
		if (size<=this.conf.pageSize) {
			$(this.id.next).addClass("disabled");
		}
		$(this.id.prev).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scroll(window[o].vars.curPage-1);
			}
			return false;
		});
		$(this.id.next).click(function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].scroll(window[o].vars.curPage+1);
			}
			return false;
		});
		if ($(this.id.paging).get(0)&&this.vars.maxPage>0) {
			this.vars.usePaging = true;
			this.printPaging();
		}
		
		$(this.all.data).each(function(i) {
			var idx = i;
			$(this).mouseenter(function() {
				window[o].focus(idx);
			}).mouseleave(function() {
				var _idx = idx;
				window[o].timer.blur[idx] = setTimeout(function() {
					window[o].blur(_idx);
				}, 100);
			});
		});
		
		if (this.conf.useButton) {
			$(this.all.cartButton).each(function(i) {
				var idx = i;
				$(this).mouseenter(function() {
					window[o].focus(idx);
				}).mouseleave(function() {
					var _idx = idx;
					window[o].timer.blur[idx] = setTimeout(function() {
						window[o].blur(_idx);
					}, 100);
				});
			});
			$(this.all.buyButton).each(function(i) {
				var idx = i;
				$(this).mouseenter(function() {
					window[o].focus(idx);
				}).mouseleave(function() {
					var _idx = idx;
					window[o].timer.blur[idx] = setTimeout(function() {
						window[o].blur(_idx);
					}, 100);
				});
			});
		}
	},
	
	/**
	* 마우스오버시 해당 상품을 포커스한다.
	* @param _idx : (Number) 상품 인덱스
	* @return Void
	*/
	focus: function(_idx) {
		var idx = _idx;
		clearTimeout(this.timer.blur[idx]);
		$($(this.all.data).get(idx)).addClass("hover");
		if (this.conf.useButton) {
			$($(this.all.cartButton).get(idx)).stop().fadeTo("fast", .85);
			$($(this.all.buyButton).get(idx)).stop().fadeTo("fast", .85);
		}
	},
	
	/**
	* 마우스아웃시 해당 상품을 포커스를 제거한다.
	* @param _idx : (Number) 상품 인덱스
	* @return Void
	*/
	blur: function(_idx) {
		var idx = _idx;
		$($(this.all.data).get(idx)).removeClass("hover");
		if (this.conf.useButton) {
			$($(this.all.cartButton).get(idx)).stop().fadeTo("fast", 0);
			$($(this.all.buyButton).get(idx)).stop().fadeTo("fast", 0);
		}
	},
	
	/**
	* 해당 페이지로 스크롤 한다.
	* @param _page : (Number) 이동할 페이지 번호
	* @return Void
	*/
	scroll: function(_page) {
		var tarPage = (_page<0) ? 0 : _page;
		var tarX = this.conf.dataW * this.conf.pageSize * tarPage * -1;
		$(this.id.prev)[(tarPage==0)?"addClass":"removeClass"]("disabled");
		$(this.id.next)[(tarPage>=this.vars.maxPage)?"addClass":"removeClass"]("disabled");
		$(this.id.list).stop().animate({left:tarX}, 1200, "easeInOutCubic");
		if (this.vars.usePaging) {
			$($(this.all.pagingButton).removeClass("selected").get(tarPage)).addClass("selected");
		}
		this.vars.curPage = tarPage;
	},
	
	/**
	* 페이징이 있을 경우 페이징을 출력한다.
	* @return Void
	*/
	printPaging: function() {
		var o = this.instanceName;
		var s = '';
		s += '<table cellpadding="0" cellspacing="0" border="0" width="940">\n';
		s += '	<tr>\n';
		s += '		<td align="center">\n';
		s += '		<table cellpadding="0" cellspacing="0" border="0">\n';
		s += '			<tr>\n';
		for (var i=0; i<=this.vars.maxPage; i++) {
			s += '<td><a href="#page" '+((i==0)?'class="selected"':'')+'></a></td>\n';
		}
		s += '			</tr>\n';
		s += '		</table>\n';
		s += '		</td>\n';
		s += '	</tr>\n';
		s += '</table>\n';
		$(this.id.paging).html(s);
		$(this.all.pagingButton).each(function(i) {
			var page = i;
			$(this).click(function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].scroll(page);
				}
				return false;
			});
		});
	},
	
	/**
	* 초기화
	* @return Void
	*/
	initialize: function() {
		this.id = {
			  list: "div.ui-scrolllist div.list table"
			, prev: "div.ui-scrolllist div.prev a"
			, next: "div.ui-scrolllist div.next a"
			, paging: "div.ui-scrolllist div.paging"
		};
		this.all = {
			  data: "div.ui-scrolllist div.list div.data div.info a"
			, cartButton: "div.ui-scrolllist div.list a.cart"
			, buyButton: "div.ui-scrolllist div.list a.buy"
			, pagingButton: "div.ui-scrolllist div.paging table td a"
		};
		
		this.active();
	}
};
$(function() {
	$scrolllist.initialize();
});
$(window).load(function() {
	var frameName = window.name;
	if (frameName!="") {
		try {
			parent.$("#"+frameName).parent().find("div.cover").stop().fadeTo("slow", 0, function() {
				$(this).css({display:"none"});
			});
		} catch(e) {}
	}
});