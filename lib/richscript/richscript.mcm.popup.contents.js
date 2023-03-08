/*
 * $mcm.popup.contents 객체
 * 
 * $popup의 컨텐츠와 $popup 모듈이 서로 소통할 수 있도록 하는 역할을 함.
 * $popup의 컨텐츠로 사용되는 모든 페이지에는 이 파일을 필수로 인클루드 해야함.
 * 
 * Lee Won-Gyoon <richscript@gmail.com>, <@richscript>, <www.richscript.com>
*******************************************************************************/

if (!window.$mcm) {
	window.$mcm = {};
}
if (!window.$mcm.popup) {
	window.$mcm.popup = {};
}
var richscriptMcmPopupContents = $mcm.popup.contents = {
	instanceName: "richscriptMcmPopupContents",
	frame: $mcm.popup,
	timer: {
		resize: null
	},
	interval: {
		resize: 800
	},
	vars: {
		  curW: 0
		, curH: 0
	},
	
	/**
	* 팝업의 사이즈를 현재 컨텐츠의 사이즈로 변경한다.
	* @return Void
	*/
	resize: function() {
		var width = $(this.id.contents).outerWidth();
		var height = $(this.id.contents).outerHeight();
		if (width!=this.vars.curW||height!=this.vars.curH) {
			this.vars.curW = width;
			this.vars.curH = height;
			this.frame.resize(width, height);
		}
	},
	
	/**
	* 현재 컨텐츠의 제목을 팝업 타이틀 영역에 적용한다.
	* @return Void
	*/
	title: function() {
		this.frame.title();
	},
	
	/**
	* 팝업의 로딩커버를 제거한다.
	* @return Void
	*/
	removeFrameCover: function() {
		this.frame.removeFrameCover();
	},
	
	/**
	* 팝업 컨텐츠 초기화
	* @return Void
	*/
	initialize: function() {
		this.id = {
			contents: "#ui-popup-contents"
		};
		var o = this.instanceName;
		this.title();
		$(window).load(function() {
			window[o].resize();
			setTimeout(function() {
				window[o].removeFrameCover();
			}, window[o].frame.delay.resize+10);
		});
		this.timer.timer = setTimeout(function() {
			window[o].resize();
		}, this.interval.resize);
	}
};
$(function() {
	$mcm.popup.contents.initialize();
});