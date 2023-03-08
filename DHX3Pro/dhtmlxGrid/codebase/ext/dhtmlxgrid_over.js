//v.3.0 build 110707
dhtmlXGridObject.prototype.mouseOverHeader=function(c){var d=this;dhtmlxEvent(this.hdr,"mousemove",function(b){var b=b||window.event,a=b.target||b.srcElement;a.tagName!="TD"&&(a=d.getFirstParentOfType(a,"TD"));a&&typeof a._cellIndex!="undefined"&&c(a.parentNode.rowIndex,a._cellIndex)})};
dhtmlXGridObject.prototype.mouseOver=function(c){var d=this;dhtmlxEvent(this.obj,"mousemove",function(b){var b=b||window.event,a=b.target||b.srcElement;a.tagName!="TD"&&(a=d.getFirstParentOfType(a,"TD"));a&&typeof a._cellIndex!="undefined"&&c(a.parentNode.rowIndex,a._cellIndex)})};

//v.3.0 build 110707
