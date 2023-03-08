/*
 * $mcm.popup.contents ��ü
 * 
 * $popup�� �������� $popup ����� ���� ������ �� �ֵ��� �ϴ� ������ ��.
 * $popup�� �������� ���Ǵ� ��� ���������� �� ������ �ʼ��� ��Ŭ��� �ؾ���.
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
	* �˾��� ����� ���� �������� ������� �����Ѵ�.
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
	* ���� �������� ������ �˾� Ÿ��Ʋ ������ �����Ѵ�.
	* @return Void
	*/
	title: function() {
		this.frame.title();
	},
	
	/**
	* �˾��� �ε�Ŀ���� �����Ѵ�.
	* @return Void
	*/
	removeFrameCover: function() {
		this.frame.removeFrameCover();
	},
	
	/**
	* �˾� ������ �ʱ�ȭ
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