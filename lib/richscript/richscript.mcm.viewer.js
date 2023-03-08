/*
 * $mcm.Viewer Class Function
 * 
 * �̹������ Class Function
 * @param (String) _instanceName var������ ��ü�̸�
 * @param (String) _photos �̹������� Array
 * @return Object $mcm.Viewer��ü
 * 
 * ��ü ���� ��)
	var viewer = new $mcm.Viewer("viewer", [
		  {src: "�̹���URL_1", width: �̹���1��, height: �̹���1����}
		, {src: "�̹���URL_2", width: �̹���2��, height: �̹���2����}
		, {src: "�̹���URL_3", width: �̹���3��, height: �̹���3����}
		, ...
		, {src: "�̹���URL_n", width: �̹���n��, height: �̹���n����}
	]);
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

if (!window.$mcm) {
	window.$mcm = {};
}

var richscriptMcmViewer = $mcm.Viewer = function(_instanceName, _photos) {
	this.instanceName = _instanceName;
	this.photos = _photos;
	this.srcElement = null;
	this.conf = {
		defaultW: 340
		, defaultH: 300
	};
	this.vars = {
		  maxZIndex: 200
		  , curIdx: 0
	};
	this.delay = {
		resize: 500
	};
	this.id = {
		  popup: "#"+_instanceName+"_popup"
		, popupSize: "#"+_instanceName+"_popupSize"
		, cover: "#"+_instanceName+"_cover"
		, coverFrame: "#"+_instanceName+"_coverFrame"
		, buttonBase: "#"+_instanceName+"_buttonBase"
		, closeButton: "#"+_instanceName+"_closeButton"
		, prevButton: "#"+_instanceName+"_prevButton"
		, nextButton: "#"+_instanceName+"_nextButton"
		, pagingButton: "#"+_instanceName+"_pagingButton"
		, loading: "#"+_instanceName+"_loading"
	};
};
$.extend(richscriptMcmViewer.prototype, {
	
	/**
	* �̹������ ���̾ ����.
	* @param _srcElement : (Object) ����� ���� ���� ����� ���۵Ǵ� ��ư �̹��� DOM ��ü
	* @param _idx : (Number) ������ �ٷ� ������ �̹����� �ε���, 0���� ���� (������ 0)
	* @return Void
	*/
	open: function(_srcElement, _idx) {
		var o = this.instanceName;
		var idx = (_idx==undefined) ? 0 : Math.toInt(_idx);
		if (idx>=this.photos.length) {
			idx = 0;
		}
		if (_srcElement!=undefined) {
			this.srcElement = _srcElement;
		}
		$("body").append(this.getHtml());
		this.active();
		
		/* ������� ũ�� ������ ����: ������ ������ �������ָ� �ν���. */
		if ($.browser.isCR) {
			setTimeout(function() {
				$(window[o].id.cover).css({backgroundColor:"#010101"});
			}, 1);
		}
		setTimeout(function() {
			window[o].view(idx);
		}, 200);
		setTimeout(function() {
			$(window[o].id.closeButton).css({display:"block"});
			if (window[o].photos.length>1) {
				$(window[o].id.buttonBase).css({display:"block"});
			} else {
				$(window[o].id.popupSize).find("div.photo").css({cursor:"default"});
			}
			window[o].loadPhotos();
		}, this.delay.resize+500);
	},
	
	/**
	* �̹������ ���̾ �ݴ´�.
	* @return Void
	*/
	close: function() {
		var o = this.instanceName;
		this.inactive();
		if (this.srcElement==null) {
			$(this.id.popup).remove();
			$(this.id.cover).stop().fadeTo(400, 0, function() {
				$(this).remove();
			});
		} else {
			var se = $(this.srcElement);
			var tarW = (se.outerWidth()) ? se.outerWidth() : tarW;
			var tarH = (se.outerHeight()) ? se.outerHeight() : tarH;
			var tarX = (se.offset().left) ? se.offset().left : tarX;
			var tarY = (se.offset().top) ? se.offset().top : tarY;
			$(this.id.popupSize).css({overflow:"hidden"});
			this.resize(Math.max(tarW, 40), Math.max(tarH, 60)).move(tarX, tarY);
			setTimeout(function() {
				window[o].close();
			}, this.delay.resize+10);
			se = null;
		}
		this.srcElement = null;
	},
	
	/**
	* ������ �̹������� �ε��Ѵ�.
	* @return Void
	*/
	loadPhotos: function() {
		var o = this.instanceName;
		$(this.id.popupSize).find("div.photo").each(function(i) {
			var idx = i;
			this.innerHTML = '<img src="'+window[o].photos[idx].src.escapeXml()+'" onLoad="'+o+'.loadPhotoCheck(this, '+idx+')" />';
		});
	},
	
	/**
	* �̹����ε��� �Ϸ�� �� ������ �����Ѵ�.
	* @param _photo : (Object) �̹��� DOM ��ü
	* @param _idx : (Number) �̹��� �ε���, 0���� ����
	* @return Void
	*/
	loadPhotoCheck: function(_photo, _idx) {
		if (_idx==this.vars.curIdx) {
			$(_photo).stop().fadeTo("fast", 1);
		} else {
			$(_photo).css({opacity:1,filter:"Alpha(opacity=100)"});
		}
	},
	
	/**
	* �ش� �̹����� �����ش�.
	* @param _idx : (Number) �̹��� �ε���, 0���� ����
	* @return Void
	*/
	view: function(_idx) {
		var o = this.instanceName;
		var idx = Math.toInt((_idx<this.photos.length) ? _idx : 0);
		var photo = this.photos[idx];
		$(this.id.closeButton).css({display:"none"});
		$(this.id.popupSize).find("div.photo").stop().css({display:"none",opacity:0,filter:"Alpha(opacity=0)"});
		$(this.id.popupSize).stop().animate({width:photo.width,height:photo.height}, this.delay.resize, "easeInOutCubic", function() {
			$($(this).find("div.photo").get(idx)).css({display:"block"}).stop().fadeTo("fast", 1);
			$(this).css({overflow:"visible"});
			$(window[o].id.closeButton).css({display:"block"});
		});
		$(this.id.prevButton).find("a")[(idx==0)?"addClass":"removeClass"]("disabled");
		$(this.id.nextButton).find("a")[(idx>=this.photos.length-1)?"addClass":"removeClass"]("disabled");
		$($(this.id.pagingButton).find("a").removeClass("selected").get(idx)).addClass("selected");
		this.moveToCenter(photo.width, photo.height).resizeCover();
		this.vars.curIdx = idx;
	},
	
	/**
	* �ٴ� Ŀ���� �ٴ� �������� �ִ� ����� �����.
	* @return Object ��ü
	*/
	resizeCover: function() {
		$(this.id.cover).css({width:$.browser.maxWidth(),height:$.browser.maxHeight()});
		if ($.browser.isIE6) {
			$(this.id.coverFrame).css({width:"100%",height:"100%"});
		}
		return this;
	},
	
	/**
	* �̹�������� ����� �ش� ������� �����Ѵ�.
	* @param _width : (Number) ��
	* @param _height : (Number) ����
	* @return Object ��ü
	*/
	resize: function(_width, _height) {
		$(this.id.popupSize).stop().animate({width:_width,height:_height}, this.delay.resize, "easeInOutCubic", function() {
			$(this).css({overflow:"visible"});
		});
		return this;
	},
	
	/**
	* �̹����� �ش� ��ǥ�� �̵��Ѵ�.
	* @param _left : (Number) X��ǥ
	* @param _top : (Number) Y��ǥ
	* @return Object ��ü
	*/
	move: function(_left, _top) {
		$(this.id.popup).stop().animate({left:_left, top:_top}, this.delay.resize, "easeInOutCubic");
		return this;
	},
	
	/**
	* �̹����� ȭ���� �߾����� �̵��Ѵ�.
	* @param _left : (Number) X��ǥ
	* @param _top : (Number) Y��ǥ
	* @return Object ��ü
	*/
	moveToCenter: function(_width, _height) {
		var tarW = (_width==undefined) ? $(this.id.popupSize).outerWidth() : _width;
		var tarH = (_height==undefined) ? $(this.id.popupSize).outerHeight() : _height;
		var tarX = Math.max($.browser.scrollLeft()+($.browser.screenWidth()-tarW)/2, 52);
		var tarY = Math.max($.browser.scrollTop()+($.browser.screenHeight()-tarH)/2, 15);
		return this.move(tarX, tarY);
	},
	
	/**
	* �̹����� Ȱ��ȭ�Ѵ�.
	* @return Object ��ü
	*/
	active: function() {
		var o = this.instanceName;
		$(window).bind("resize."+o, function() {
			window[o].moveToCenter().resizeCover();
		});
		$(this.id.popup).find("a").bind("click", function(e) {
			$(this).blur();
		});
		$(this.id.closeButton).find("a").bind("click", function(e) {
			e.preventDefault();
			window[o].close();
			$(window[o].id.closeButton).css({display:"none"});
			$(window[o].id.buttonBase).css({display:"none"});
			return false;
		});
		$(this.id.cover).click(function() {
			$(window[o].id.closeButton).find("a").click();
		});
		$(this.id.popupSize).find("a").bind("mouseenter", function(e) {
			if (!$(this).hasClass("selected")&&!$(this).hasClass("disabled")) {
				$(this).addClass("hover");
			}
		}).bind("mouseleave", function(e) {
			$(this).removeClass("hover");
		});
		$(this.id.prevButton).find("a").bind("click", function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].view(window[o].vars.curIdx-1);
			}
			return false;
		});
		$(this.id.nextButton).find("a").bind("click", function(e) {
			e.preventDefault();
			if (!$(this).hasClass("disabled")) {
				window[o].view(window[o].vars.curIdx+1);
			}
			return false;
		});
		$(this.id.pagingButton).find("a").each(function(i) {
			var idx = i;
			$(this).bind("click", function(e) {
				e.preventDefault();
				if (!$(this).hasClass("selected")) {
					window[o].view(idx);
				}
				return false;
			});
		});
		$(this.id.popupSize).find("div.photo").each(function(i) {
			var idx = i;
			$(this).bind("click", function(e) {
				if (window[o].photos.length>1) {
					window[o].view(window[o].vars.curIdx+1);
				}
			});
		});
		return this;
	},
	
	/**
	* �̹����� ��Ȱ��ȭ�Ѵ�.
	* @return Object ��ü
	*/
	inactive: function() {
		$(window).unbind("resize."+this.instanceName);
		$(this.id.popup).find("a").unbind("click");
		$(this.id.popupSize).find("a").unbind("mouseenter mouseleave");
		$(this.id.popupSize).find("div.photo").unbind("click");
		$(this.id.cover).unbind("click");
		return this;
	},
	
	/**
	* �̹������ ��ü HTML�� �����Ѵ�.
	* @return String
	*/
	getHtml: function() {
		var tarW = this.conf.defaultW;
		var tarH = this.conf.defaultH;
		var tarX = Math.max($.browser.scrollLeft()+($.browser.screenWidth()-tarW)/2, 0);
		var tarY = Math.max($.browser.scrollTop()+($.browser.screenHeight()-tarH)/2, 0);
		if (this.srcElement!=null) {
			var se = $(this.srcElement);
			tarW = (se.outerWidth()) ? se.outerWidth() : tarW;
			tarH = (se.outerHeight()) ? se.outerHeight() : tarH;
			tarX = (se.offset().left) ? se.offset().left : tarX;
			tarY = (se.offset().top) ? se.offset().top : tarY;
			se = null;
		}
		var s = '';
		s += '<div id="'+this.id.cover.substring(1)+'" class="ui-viewer-cover" style="z-index:'+(this.vars.maxZIndex++)+';width:'+$.browser.maxWidth()+'px;height:'+$.browser.maxHeight()+'px;">';
		if ($.browser.isIE6) {
			s += '<iframe id="'+this.id.coverFrame.substring(1)+'" src="about:blank" style="width:1px;height:1px;" frameborder="0" height="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>';
		}
		s += '</div>\n';
		s += '<div id="'+this.id.popup.substring(1)+'" class="ui-viewer" style="z-index:'+(this.vars.maxZIndex++)+';left:'+tarX+'px;top:'+tarY+'px;">\n';
		s += '	<div class="relative">\n';
		s += '		<div class="ui-viewer-shadow">\n';
		s += '			<table cellspacing="0" cellpadding="0" border="0">\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-top-left"></div></td>\n';
		s += '					<td class="shadow-top"></td>\n';
		s += '					<td><div class="shadow-top-right"></div></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td class="shadow-left"></td>\n';
		s += '					<td>';
		s += '						<div id="'+this.id.popupSize.substring(1)+'" class="contents" style="width:'+tarW+'px;height:'+tarH+'px;">\n';
		s += '							<div id="'+this.id.closeButton.substring(1)+'" class="btn-close"><a href="#close"><span></span></a></div>\n';
		s += '							<div id="'+this.id.buttonBase.substring(1)+'" class="btn-base">\n';
		s += '								<div class="relative">\n';
		s += '									<div id="'+this.id.prevButton.substring(1)+'" class="btn-prev"><a href="#prev"><span></span></a></div>\n';
		s += '									<div id="'+this.id.nextButton.substring(1)+'" class="btn-next"><a href="#next"><span></span></a></div>\n';
		s += '									<div id="'+this.id.pagingButton.substring(1)+'" class="btn-paging">';
		s += '<table cellspacing="0" cellpadding="0" border="0" class="paging">\n';
		s += '	<tr>\n';
		s += '		<td align="center">\n';
		s += '			<table cellspacing="0" cellpadding="0" border="0">\n';
		s += '				<tr>\n';
		for (var i=0; i<this.photos.length; i++) {
			s += '<td><a href="#"><span></span></a></td>\n';
		}
		s += '				</tr>\n';
		s += '			</table>\n';
		s += '		</td>\n';
		s += '	</tr>\n';
		s += '</table>\n';
		s += '									</div>\n';
		s += '								</div>\n';
		s += '							</div>\n';
		s += '							<table id="'+this.id.loading.substring(1)+'" class="cover"><tr><td align="center" valign="middle"><img src="/images/richscript/ui/main/loading.24x24.gif" width="24" height="24" /></td></tr></table>\n';
		for (var i=0; i<this.photos.length; i++) {
			s += '<div class="photo"></div>\n';
		}
		s += '						</div>\n';
		
		s += '					</td>\n';
		s += '					<td class="shadow-right"></td>\n';
		s += '				</tr>\n';
		s += '				<tr>\n';
		s += '					<td><div class="shadow-bottom-left"></div></td>\n';
		s += '					<td class="shadow-bottom"></td>\n';
		s += '					<td><div class="shadow-bottom-right"></div></td>\n';
		s += '				</tr>\n';
		s += '			</table>\n';
		s += '		</div>\n';
		s += '	</div>\n';
		s += '</div>\n';
		return s;
	}
	
});