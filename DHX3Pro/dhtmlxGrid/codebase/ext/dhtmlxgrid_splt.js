//v.3.0 build 110707
dhtmlXGridObject.prototype._init_point_bspl=dhtmlXGridObject.prototype._init_point;dhtmlXGridObject.prototype._init_point=function(){this._split_later&&this.splitAt(this._split_later);(this._init_point=this._init_point_bspl)&&this._init_point()};
dhtmlXGridObject.prototype.splitAt=function(e){function q(a,b){b.style.whiteSpace="";var d=b.nextSibling,c=b.parentNode;a.parentNode.insertBefore(b,a);d?c.insertBefore(a,d):c.appendChild(a);var e=a.style.display;a.style.display=b.style.display;b.style.display=e}function n(a,b,d,c){var i=Array(e).join(this.delim),f=[];if(a==2)for(var g=0;g<e;g++){var h=b[a-1].cells[b[a-1]._childIndexes?b[a-1]._childIndexes[g]:g];if(h.rowSpan&&h.rowSpan>1)f[h._cellIndex]=h.rowSpan-1,c[a-1].cells[c[a-1]._childIndexes?
c[a-1]._childIndexes[g]:g].rowSpan=h.rowSpan,h.rowSpan=1}for(;a<b.length;a++){this._fake.attachHeader(i,null,d);for(var c=c||this._fake.ftr.childNodes[0].rows,j=e,k=0,l=0;l<j;l++)if(f[l]){f[l]-=1;if(_isIE||_isFF&&_FFrv>=1.9||_isOpera){var m=document.createElement("TD");if(_isFF)m.style.display="none";b[a].insertBefore(m,b[a].cells[0])}k++}else{var p=c[a].cells[l-k],n=b[a].cells[l-(_isIE?0:k)],o=n.rowSpan;q(p,n);if(o>1)f[l]=o-1,n.rowSpan=o;if(c[a].cells[l].colSpan>1){b[a].cells[l].colSpan=c[a].cells[l].colSpan;
j-=c[a].cells[l].colSpan-1;for(g=1;g<c[a].cells[l].colSpan;g++)c[a].removeChild(c[a].cells[l+1])}}}}if(!this.obj.rows[0])return this._split_later=e;var e=parseInt(e),j=document.createElement("DIV");this.entBox.appendChild(j);var k=document.createElement("DIV");this.entBox.appendChild(k);for(var g=this.entBox.childNodes.length-3;g>=0;g--)k.insertBefore(this.entBox.childNodes[g],k.firstChild);this.entBox.style.position="relative";this.globalBox=this.entBox;this.entBox=k;k.grid=this;j.style.cssText+=
"border:0px solid red !important;";k.style.cssText+="border:0px solid red !important;";k.style.top="0px";k.style.position="absolute";j.style.position="absolute";j.style.top="0px";j.style.left="0px";j.style.zIndex=11;k.style.height=j.style.height=this.globalBox.clientHeight;this._fake=new dhtmlXGridObject(j);this._fake.setSkin("not_existing_skin");this.globalBox=this._fake.globalBox=this.globalBox;this._fake._fake=this;this._fake._realfake=!0;this._treeC=this.cellType._dhx_find("tree");this._fake.delim=
this.delim;this._fake.customGroupFormat=this.customGroupFormat;this._fake.imgURL=this.imgURL;this._fake._customSorts=this._customSorts;this._fake.noHeader=this.noHeader;this._fake._enbTts=this._enbTts;this._fake.clists=this.clists;this._fake.fldSort=[];this._fake.selMultiRows=this.selMultiRows;if((this._fake.multiLine=this.multiLine)||this._erspan){this.attachEvent("onCellChanged",this._correctRowHeight);var r=function(){this.forEachRow(function(a){this._correctRowHeight(a)})};this.attachEvent("onPageChanged",
r);this.attachEvent("onXLE",r);this.attachEvent("onResizeEnd",r);this._ads_count||this.attachEvent("onAfterSorting",r);this.attachEvent("onDistributedEnd",r)}this.attachEvent("onGridReconstructed",function(){this._fake.objBox.scrollTop=this.objBox.scrollTop});this._fake.loadedKidsHash=this.loadedKidsHash;if(this._h2)this._fake._h2=this._h2;this._fake._dInc=this._dInc;var m=[[],[],[],[],[],[],[]],o="hdrLabels,initCellWidth,cellType,cellAlign,cellVAlign,fldSort,columnColor".split(","),s="setHeader,setInitWidths,setColTypes,setColAlign,setColVAlign,setColSorting,setColumnColor".split(",");
this._fake.callEvent=function(){this._fake._split_event=!0;arguments[0]=="onGridReconstructed"&&this._fake.callEvent.apply(this,arguments);return this._fake.callEvent.apply(this._fake,arguments)};this._elmn&&this._fake.enableLightMouseNavigation(!0);(this.__cssEven||this._cssUnEven)&&this._fake.attachEvent("onGridReconstructed",function(){this._fixAlterCss()});this._fake._cssEven=this._cssEven;this._fake._cssUnEven=this._cssUnEven;this._fake._cssSP=this._cssSP;this._fake.isEditable=this.isEditable;
this._fake._edtc=this._edtc;this._sst&&this._fake.enableStableSorting(!0);this._fake._sclE=this._sclE;this._fake._dclE=this._dclE;this._fake._f2kE=this._f2kE;this._fake._maskArr=this._maskArr;this._fake._dtmask=this._dtmask;this._fake.combos=this.combos;for(var p=0,u=this.globalBox.offsetWidth,g=0;g<e;g++){for(var h=0;h<o.length;h++)this[o[h]]&&(m[h][g]=this[o[h]][g]),typeof m[h][g]=="string"&&(m[h][g]=m[h][g].replace(RegExp("\\"+this.delim,"g"),"\\"+this.delim));_isFF&&(m[1][g]*=1);this.cellWidthType==
"%"?(m[1][g]=Math.round(parseInt(this[o[1]][g])*u/100),p+=m[1][g]):p+=parseInt(this[o[1]][g]);this.setColumnHidden(g,!0)}for(h=0;h<o.length;h++){var t=m[h].join(this.delim);if(s[h]!="setHeader"){if(t!="")this._fake[s[h]](t)}else this._fake[s[h]](t,null,this._hstyles)}this._fake._strangeParams=this._strangeParams;this._fake._drsclmn=this._drsclmn;p=Math.min(this.globalBox.offsetWidth,p);k.style.left=p+"px";j.style.width=p+"px";k.style.width=Math.max(this.globalBox.offsetWidth-p,0);if(this._ecspn)this._fake._ecspn=
!0;this._fake.init();this.dragAndDropOff&&this.dragger.addDragLanding(this._fake.entBox,this);this._fake.objBox.style.overflow="hidden";this._fake.objBox.style.overflowX="scroll";this._fake._srdh=this._srdh||20;this._fake._srnd=this._srnd;this.hdr.rows.length>2&&n.call(this,2,this.hdr.rows,"_aHead",this._fake.hdr.rows);if(this.ftr)n.call(this,1,this.ftr.childNodes[0].rows,"_aFoot"),this._fake.ftr.parentNode.style.bottom=(_isFF?2:1)+"px";if(this.saveSizeToCookie)this.saveSizeToCookie=function(a,b){if(this._realfake)return this._fake.saveSizeToCookie.apply(this._fake,
arguments);if(!a)a=this.entBox.id;for(var d=[],c="cellWidthPX",i=0;i<this[c].length;i++)d[i]=i<e?this._fake[c][i]:this[c][i];d=d.join(",");this.setCookie(a,b,0,d);d=(this.initCellWidth||[]).join(",");this.setCookie(a,b,1,d);return!0},this.loadSizeFromCookie=function(a){if(!a)a=this.entBox.id;var b=this._getCookie(a,1);if(b){this.initCellWidth=b.split(",");var b=this._getCookie(a,0),d="cellWidthPX";this.cellWidthType="px";var c=0;if(b&&b.length)for(var b=b.split(","),i=0;i<b.length;i++)i<e?(this._fake[d][i]=
b[i],c+=b[i]*1):this[d][i]=b[i];this._fake.entBox.style.width=c+"px";this._fake.objBox.style.width=c+"px";var f=this.globalBox.childNodes[1];f.style.left=c-(_isFF?0:0)+"px";if(this.ftr)this.ftr.style.left=c-(_isFF?0:0)+"px";f.style.width=this.globalBox.offsetWidth-c+"px";this.setSizes();return!0}},this._fake.onRSE=this.onRSE;this.setCellTextStyleA=this.setCellTextStyle;this.setCellTextStyle=function(a,b,d){b<e&&this._fake.setCellTextStyle(a,b,d);this.setCellTextStyleA(a,b,d)};this.setRowTextBoldA=
this.setRowTextBold;this.setRowTextBold=function(a){this.setRowTextBoldA(a);this._fake.setRowTextBold(a)};this.setRowColorA=this.setRowColor;this.setRowColor=function(a,b){this.setRowColorA(a,b);this._fake.setRowColor(a,b)};this.setRowHiddenA=this.setRowHidden;this.setRowHidden=function(a,b){this.setRowHiddenA(a,b);this._fake.setRowHidden(a,b)};this.setRowTextNormalA=this.setRowTextNormal;this.setRowTextNormal=function(a){this.setRowTextNormalA(a);this._fake.setRowTextNormal(a)};this.getChangedRows=
function(a){function b(a){for(var b=0;b<a.childNodes.length;b++)if(a.childNodes[b].wasChanged)return d[d.length]=a.idd}var d=[];this.forEachRow(function(c){var e=this.rowsAr[c],f=this._fake.rowsAr[c];if(!(e.tagName!="TR"||f.tagName!="TR"))a&&e._added?d[d.length]=e.idd:b(e)||b(f)});return d.join(this.delim)};this.setRowTextStyleA=this.setRowTextStyle;this.setRowTextStyle=function(a,b){this.setRowTextStyleA(a,b);this._fake.rowsAr[a]&&this._fake.setRowTextStyle(a,b)};this.lockRowA=this.lockRow;this.lockRow=
function(a,b){this.lockRowA(a,b);this._fake.lockRow(a,b)};this.getColWidth=function(a){return a<e?parseInt(this._fake.cellWidthPX[a]):parseInt(this.cellWidthPX[a])};this.getColumnLabel=function(a){return this._fake.getColumnLabel.apply(a<e?this._fake:this,arguments)};this.setColWidthA=this._fake.setColWidthA=this.setColWidth;this.setColWidth=function(a,b){a*=1;a<e?this._fake.setColWidthA(a,b):this.setColWidthA(a,b);a+1<=e&&this._fake._correctSplit(Math.min(this._fake.objBox.offsetWidth,this._fake.obj.offsetWidth))};
this.adjustColumnSizeA=this.adjustColumnSize;this.setColumnLabelA=this.setColumnLabel;this.setColumnLabel=function(a,b,d,c){var i=this;if(a<e)i=this._fake;return this.setColumnLabelA.apply(i,[a,b,d,c])};this.adjustColumnSize=function(a,b){if(a<e){if(_isIE)this._fake.obj.style.tableLayout="";this._fake.adjustColumnSize(a,b);if(_isIE)this._fake.obj.style.tableLayout="fixed";this._fake._correctSplit()}else return this.adjustColumnSizeA(a,b)};var f="cells";this._bfs_cells=this[f];this[f]=function(){return arguments[1]<
e?this._fake.cells.apply(this._fake,arguments):this._bfs_cells.apply(this,arguments)};this._bfs_setColumnHidden=this.setColumnHidden;this.setColumnHidden=function(){return parseInt(arguments[0])<e?(this._fake.setColumnHidden.apply(this._fake,arguments),this._fake._correctSplit()):this._bfs_setColumnHidden.apply(this,arguments)};f="cells2";this._bfs_cells2=this[f];this[f]=function(){return arguments[1]<e?this._fake.cells2.apply(this._fake,arguments):this._bfs_cells2.apply(this,arguments)};f="cells3";
this._bfs_cells3=this[f];this[f]=function(a,b){if(arguments[1]<e&&this._fake.rowsAr[arguments[0].idd]){if(this._fake.rowsAr[a.idd]&&this._fake.rowsAr[a.idd].childNodes.length==0)return this._bfs_cells3.apply(this,arguments);arguments[0]=arguments[0].idd;return this._fake.cells.apply(this._fake,arguments)}else return this._bfs_cells3.apply(this,arguments)};f="changeRowId";this._bfs_changeRowId=this[f];this[f]=function(){this._bfs_changeRowId.apply(this,arguments);this._fake.rowsAr[arguments[0]]&&this._fake.changeRowId.apply(this._fake,
arguments)};this._fake.getRowById=function(a){var b=this.rowsAr[a];!b&&this._fake.rowsAr[a]&&(b=this._fake.getRowById(a));if(b){if(b.tagName!="TR"){for(var d=0;d<this.rowsBuffer.length;d++)if(this.rowsBuffer[d]&&this.rowsBuffer[d].idd==a)return this.render_row(d);if(this._h2)return this.render_row(null,b.idd)}return b}return null};if(this.collapseKids)this._fake._bfs_collapseKids=this.collapseKids,this._fake.collapseKids=function(a){return this._fake.collapseKids.apply(this._fake,[this._fake.rowsAr[a.idd]])},
this._bfs_collapseKids=this.collapseKids,this.collapseKids=function(){var a=this._bfs_collapseKids.apply(this,arguments);this._fake._h2syncModel();this._cssSP||this._fake._fixAlterCss()},this._fake._bfs_expandKids=this.expandKids,this._fake.expandKids=function(a){this._fake.expandKids.apply(this._fake,[this._fake.rowsAr[a.idd]]);this._cssSP||this._fake._fixAlterCss()},this._bfs_expandAll=this.expandAll,this.expandAll=function(){this._bfs_expandAll();this._fake._h2syncModel();this._cssSP||this._fake._fixAlterCss()},
this._bfs_collapseAll=this.collapseAll,this.collapseAll=function(){this._bfs_collapseAll();this._fake._h2syncModel();this._cssSP||this._fake._fixAlterCss()},this._bfs_expandKids=this.expandKids,this.expandKids=function(){var a=this._bfs_expandKids.apply(this,arguments);this._fake._h2syncModel();this._cssSP||this._fake._fixAlterCss()},this._fake._h2syncModel=function(){this._fake.pagingOn?this._fake._renderSort():this._renderSort()},this._updateTGRState=function(a){return this._fake._updateTGRState(a)};
if(this._elmnh)this._setRowHoverA=this._fake._setRowHoverA=this._setRowHover,this._unsetRowHoverA=this._fake._unsetRowHoverA=this._unsetRowHover,this._setRowHover=this._fake._setRowHover=function(){var a=this.grid;a._setRowHoverA.apply(this,arguments);var b=_isIE?event.srcElement:arguments[0].target;(b=a._fake.rowsAr[a.getFirstParentOfType(b,"TD").parentNode.idd])&&a._fake._setRowHoverA.apply(a._fake.obj,[{target:b.childNodes[0]},arguments[1]])},this._unsetRowHover=this._fake._unsetRowHover=function(){var a=
arguments[1]?this:this.grid;a._unsetRowHoverA.apply(this,arguments);a._fake._unsetRowHoverA.apply(a._fake.obj,arguments)},this._fake.enableRowsHover(!0,this._hvrCss),this.enableRowsHover(!1),this.enableRowsHover(!0,this._fake._hvrCss);this._updateTGRState=function(a){if(a.update&&a.id!=0){if(this.rowsAr[a.id].imgTag)this.rowsAr[a.id].imgTag.src=this.imgURL+a.state+".gif";if(this._fake.rowsAr[a.id]&&this._fake.rowsAr[a.id].imgTag)this._fake.rowsAr[a.id].imgTag.src=this.imgURL+a.state+".gif";a.update=
!1}};this.copy_row=function(a){var b=a.cloneNode(!0);b._skipInsert=a._skipInsert;var d=e;b._attrs={};b._css=a._css;if(this._ecspn)for(var c=d=0;d<b.childNodes.length&&c<e;c+=b.childNodes[d].colSpan||1)d++;for(;b.childNodes.length>d;)b.removeChild(b.childNodes[b.childNodes.length-1]);for(var i=d,c=0;c<i;c++)if(this.dragAndDropOff&&this.dragger.addDraggableItem(b.childNodes[c],this),b.childNodes[c].style.display=this._fake._hrrar?this._fake._hrrar[c]?"none":"":"",b.childNodes[c]._cellIndex=c,b.childNodes[c].combo_value=
a.childNodes[c].combo_value,b.childNodes[c]._clearCell=a.childNodes[c]._clearCell,b.childNodes[c]._cellType=a.childNodes[c]._cellType,b.childNodes[c]._brval=a.childNodes[c]._brval,b.childNodes[c]._attrs=a.childNodes[c]._attrs,b.childNodes[c].chstate=a.childNodes[c].chstate,a._attrs.style&&(b.childNodes[c].style.cssText+=";"+a._attrs.style),b.childNodes[c].colSpan>1)this._childIndexes=this._fake._childIndexes;if(this._h2&&this._treeC<e){var f=this._h2.get[a.idd];b.imgTag=b.childNodes[this._treeC].childNodes[0].childNodes[f.level];
b.valTag=b.childNodes[this._treeC].childNodes[0].childNodes[f.level+2]}b.idd=a.idd;b.grid=this._fake;return b};f="_insertRowAt";this._bfs_insertRowAt=this[f];this[f]=function(){var a=this._bfs_insertRowAt.apply(this,arguments);arguments[0]=this.copy_row(arguments[0]);var b=this._fake._insertRowAt.apply(this._fake,arguments);if(a._fhd)b.parentNode.removeChild(b),this._fake.rowsCol._dhx_removeAt(this._fake.rowsCol._dhx_find(b)),a._fhd=!1;return a};this._bfs_setSizes=this.setSizes;this.setSizes=function(){if(!this._notresize)this._bfs_setSizes(this,
arguments),this.sync_headers(),this.sync_scroll()&&this._ahgr&&this.setSizes(),this._fake.entBox.style.height=this.entBox.style.height,this._fake.objBox.style.height=this.objBox.style.height,this._fake.hdrBox.style.height=this.hdrBox.style.height,this._fake.objBox.scrollTop=this.objBox.scrollTop,this._fake.setColumnSizes(this._fake.entBox.clientWidth),this.globalBox.style.width=parseInt(this.entBox.style.width)+parseInt(this._fake.entBox.style.width),this.globalBox.style.height=this.entBox.style.height};
this.sync_scroll=this._fake.sync_scroll=function(a){var b=this.objBox.style.overflowX;if(this.obj.offsetWidth<=this.objBox.offsetWidth){if(!a)return this._fake.sync_scroll(!0);this.objBox.style.overflowX="hidden";this._fake.objBox.style.overflowX="hidden"}else this.objBox.style.overflowX="scroll",this._fake.objBox.style.overflowX="scroll";return b!=this.objBox.style.overflowX};this.sync_headers=this._fake.sync_headers=function(){if(!(this.noHeader||this._fake.hdr.scrollHeight==this.hdr.offsetHeight))for(var a=
1;a<this.hdr.rows.length;a++){var b=this.hdr.rows[a].scrollHeight,d=this._fake.hdr.rows[a].scrollHeight;if(b!=d)this._fake.hdr.rows[a].style.height=this.hdr.rows[a].style.height=Math.max(b,d)+"px";if(window._KHTMLrv)this._fake.hdr.rows[a].childNodes[0].style.height=this.hdr.rows[a].childNodes[e].style.height=Math.max(b,d)+"px"}};this._fake._bfs_setSizes=this._fake.setSizes;this._fake.setSizes=function(){this._fake._notresize||this._fake.setSizes()};f="_doOnScroll";this._bfs__doOnScroll=this[f];this[f]=
function(){this._bfs__doOnScroll.apply(this,arguments);this._fake.objBox.scrollTop=this.objBox.scrollTop;this._fake._doOnScroll.apply(this._fake,arguments)};f="selectAll";this._bfs__selectAll=this[f];this[f]=function(){this._bfs__selectAll.apply(this,arguments);this._bfs__selectAll.apply(this._fake,arguments)};f="doClick";this._bfs_doClick=this[f];this[f]=function(){this._bfs_doClick.apply(this,arguments);if(arguments[0].tagName=="TD"){var a=arguments[0]._cellIndex>=e;if(arguments[0].parentNode.idd){if(!a)arguments[0].className=
arguments[0].className.replace(/cellselected/g,"");this._fake.rowsAr[arguments[0].parentNode.idd]||this._fake.render_row(this.getRowIndex(arguments[0].parentNode.idd));arguments[0]=this._fake.cells(arguments[0].parentNode.idd,a?0:arguments[0]._cellIndex).cell;if(a)this._fake.cell=null;this._fake._bfs_doClick.apply(this._fake,arguments);a?this._fake.cell=this.cell:this.cell=this._fake.cell;this._fake.onRowSelectTime&&clearTimeout(this._fake.onRowSelectTime);a?(arguments[0].className=arguments[0].className.replace(/cellselected/g,
""),globalActiveDHTMLGridObject=this,this._fake.cell=this.cell):this.objBox.scrollTop=this._fake.objBox.scrollTop}}};this._fake._bfs_doClick=this._fake[f];this._fake[f]=function(){this._bfs_doClick.apply(this,arguments);if(arguments[0].tagName=="TD"){var a=arguments[0]._cellIndex<e;if(arguments[0].parentNode.idd&&(arguments[0]=this._fake._bfs_cells(arguments[0].parentNode.idd,a?e:arguments[0]._cellIndex).cell,this._fake.cell=null,this._fake._bfs_doClick.apply(this._fake,arguments),this._fake.cell=
this.cell,this._fake.onRowSelectTime&&clearTimeout(this._fake.onRowSelectTime),a))arguments[0].className=arguments[0].className.replace(/cellselected/g,""),globalActiveDHTMLGridObject=this,this._fake.cell=this.cell,this._fake.objBox.scrollTop=this.objBox.scrollTop}};this.clearSelectionA=this.clearSelection;this.clearSelection=function(a){a&&this._fake.clearSelection();this.clearSelectionA()};this.moveRowUpA=this.moveRowUp;this.moveRowUp=function(a){this._h2||this._fake.moveRowUp(a);this.moveRowUpA(a);
this._h2&&this._fake._h2syncModel()};this.moveRowDownA=this.moveRowDown;this.moveRowDown=function(a){this._h2||this._fake.moveRowDown(a);this.moveRowDownA(a);this._h2&&this._fake._h2syncModel()};this._fake.getUserData=function(){return this._fake.getUserData.apply(this._fake,arguments)};this._fake.setUserData=function(){return this._fake.setUserData.apply(this._fake,arguments)};this.getSortingStateA=this.getSortingState;this.getSortingState=function(){var a=this.getSortingStateA();return a.length!=
0?a:this._fake.getSortingState()};this.setSortImgStateA=this._fake.setSortImgStateA=this.setSortImgState;this.setSortImgState=function(a,b,d,c){this.setSortImgStateA(a,b,d,c);b*1<e?(this._fake.setSortImgStateA(a,b,d,c),this.setSortImgStateA(!1)):this._fake.setSortImgStateA(!1)};this._fake.doColResizeA=this._fake.doColResize;this._fake.doColResize=function(a,b,d,c,f){debugger;var g=-1,h=0;if(arguments[1]._cellIndex==e-1){g=this._initalSplR+(a.clientX-c);if(!this._initalSplF)this._initalSplF=arguments[3]+
this.objBox.scrollWidth-this.objBox.offsetWidth;if(this.objBox.scrollWidth==this.objBox.offsetWidth&&(this._fake.alter_split_resize||a.clientX-c>0))arguments[3]=this._initalSplF||arguments[3]}else if(this.obj.offsetWidth<this.entBox.offsetWidth)g=this.obj.offsetWidth;h=this.doColResizeA.apply(this,arguments);this._correctSplit(g);this.resized=this._fake.resized=1;return h};this._fake.changeCursorState=function(a){var b=a.target||a.srcElement;b.tagName!="TD"&&(b=this.getFirstParentOfType(b,"TD"));
if(!(b.tagName=="TD"&&this._drsclmn&&!this._drsclmn[b._cellIndex])){var d=(a.layerX||0)+(!_isIE&&a.target.tagName=="DIV"?b.offsetLeft:0),c=parseInt(this.getPosition(b,this.hdrBox));b.style.cursor=b.offsetWidth-(a.offsetX||(c-d)*-1)<(_isOpera?20:10)||this.entBox.offsetWidth-(a.offsetX?a.offsetX+b.offsetLeft:d)+this.objBox.scrollLeft-0<(_isOpera?20:10)?"E-resize":"default";if(_isOpera)this.hdrBox.scrollLeft=this.objBox.scrollLeft}};this._fake.startColResizeA=this._fake.startColResize;this._fake.startColResize=
function(a){var b=this.startColResizeA(a);this._initalSplR=this.entBox.offsetWidth;this._initalSplF=null;if(this.entBox.onmousemove){var d=this.entBox.parentNode;if(d._aggrid)return b;d._aggrid=d.grid;d.grid=this;this.entBox.parentNode.onmousemove=this.entBox.onmousemove;this.entBox.onmousemove=null}return b};this._fake.stopColResizeA=this._fake.stopColResize;this._fake.stopColResize=function(a){if(this.entBox.parentNode.onmousemove){var b=this.entBox.parentNode;b.grid=b._aggrid;b._aggrid=null;this.entBox.onmousemove=
this.entBox.parentNode.onmousemove;this.entBox.parentNode.onmousemove=null;this.obj.offsetWidth<this.entBox.offsetWidth&&this._correctSplit(this.obj.offsetWidth)}return this.stopColResizeA(a)};this.doKeyA=this.doKey;this._fake.doKeyA=this._fake.doKey;this._fake.doKey=this.doKey=function(a){if(!a)return!0;if(this._htkebl)return!0;if((a.target||a.srcElement).value!==window.undefined){var b=a.target||a.srcElement;if(!b.parentNode||b.parentNode.className.indexOf("editable")==-1)return!0}switch(a.keyCode){case 9:if(a.shiftKey)if(this._realfake){if(this.cell&&
this.cell._cellIndex==0){a.preventDefault&&a.preventDefault();if(c=this._fake.rowsBuffer[this._fake.getRowIndex(this.cell.parentNode.idd)-1]){this._fake.showRow(c.idd);for(d=this._fake._cCount-1;c.childNodes[d].style.display=="none";)d--;this._fake.selectCell(this._fake.getRowIndex(c.idd),d,!1,!1,!0)}return!1}}else{if(this.cell&&this.cell._cellIndex==e)return a.preventDefault&&a.preventDefault(),this._fake.selectCell(this.getRowIndex(this.cell.parentNode.idd),e-1,!1,!1,!0),!1}else if(this._realfake){if(this.cell&&
this.cell._cellIndex==e-1){a.preventDefault&&a.preventDefault();for(var d=e;this._fake._hrrar&&this._fake._hrrar[d];)d++;this._fake.selectCell(this._fake.getRowIndex(this.cell.parentNode.idd),d,!1,!1,!0);return!1}else var c=this.doKeyA(a);globalActiveDHTMLGridObject=this;return c}else if(this.cell){for(d=this.cell._cellIndex+1;this.rowsCol[0].childNodes[d]&&this.rowsCol[0].childNodes[d].style.display=="none";)d++;if(d==this.rowsCol[0].childNodes.length&&(a.preventDefault&&a.preventDefault(),c=this.rowsBuffer[this.getRowIndex(this.cell.parentNode.idd)+
1]))return this.showRow(c.idd),this._fake.selectCell(this._fake.getRowIndex(c.idd),0,!1,!1,!0),!1}}return this.doKeyA(a)};this.editCellA=this.editCell;this.editCell=function(){return this.cell&&this.cell.parentNode.grid!=this?this._fake.editCell():this.editCellA()};this.deleteRowA=this.deleteRow;this.deleteRow=function(a,b){if(this.deleteRowA(a,b)===!1)return!1;this._fake.rowsAr[a]&&this._fake.deleteRow(a)};this.clearAllA=this.clearAll;this.clearAll=function(){this.clearAllA();this._fake.clearAll()};
this.attachEvent("onAfterSorting",function(a){a>=e&&this._fake.setSortImgState(!1)});this._fake.sortField=function(a,b){this._fake.sortField.call(this._fake,a,b,this._fake.hdr.rows[0].cells[a]);if(this.fldSort[a]!="na"&&this._fake.fldSorted){var d=this._fake.getSortingState()[1];this._fake.setSortImgState(!1);this.setSortImgState(!0,a,d)}};this.sortTreeRowsA=this.sortTreeRows;this._fake.sortTreeRowsA=this._fake.sortTreeRows;this.sortTreeRows=this._fake.sortTreeRows=function(a,b,d,c){if(this._realfake)return this._fake.sortTreeRows(a,
b,d,c);this.sortTreeRowsA(a,b,d,c);this._fake._h2syncModel();this._fake.setSortImgStateA(!1);this._fake.fldSorted=null};this._fake._fillers=[];this._fake.rowsBuffer=this.rowsBuffer;this.attachEvent("onClearAll",function(){this._fake.rowsBuffer=this.rowsBuffer});this._add_filler_s=this._add_filler;this._add_filler=function(a,b,d,c){if(!c){if(!this._fake._fillers)this._fake._fillers=[];var e;if(d)if(d.idd)e=this._fake.rowsAr[d.idd];else if(d.nextSibling)e={},e.nextSibling=this._fake.rowsAr[d.nextSibling.idd],
e.parentNode=e.nextSibling.parentNode;this._fake._fillers.push(this._fake._add_filler(a,b,e))}return this._add_filler_s.apply(this,arguments)};this._add_from_buffer_s=this._add_from_buffer;this._add_from_buffer=function(){var a=this._add_from_buffer_s.apply(this,arguments);a!=-1&&(this._fake._add_from_buffer.apply(this._fake,arguments),this.multiLine&&this._correctRowHeight(this.rowsBuffer[arguments[0]].idd));return a};this._fake.render_row=function(a){var b=this._fake.render_row(a);return b==-1?
-1:b?this.rowsAr[b.idd]=this.rowsAr[b.idd]||this._fake.copy_row(b):null};this._reset_view_s=this._reset_view;this._reset_view=function(){this._fake._reset_view(!0);this._fake._fillers=[];this._reset_view_s()};this.moveColumn_s=this.moveColumn;this.moveColumn=function(a,b){if(b>=e)return this.moveColumn_s(a,b)};this.attachEvent("onCellChanged",function(a,b,d){if(this._split_event&&b<e&&this.rowsAr[a]){var c=this._fake.rowsAr[a];if(c){var c=c._childIndexes?c.childNodes[c._childIndexes[b]]:c.childNodes[b],
f=this.rowsAr[a].childNodes[b];f._treeCell&&f.firstChild.lastChild?f.firstChild.lastChild.innerHTML=d:f.innerHTML=c.innerHTML;f._clearCell=!1;f.chstate=c.chstate}}});this._fake.combos=this.combos;this.setSizes();this.rowsBuffer[0]&&this._reset_view();this.attachEvent("onXLE",function(){this._fake._correctSplit()});this._fake._correctSplit()};
dhtmlXGridObject.prototype._correctSplit=function(e){e=e||this.obj.scrollWidth-this.objBox.scrollLeft;e=Math.min(this.globalBox.offsetWidth,e);if(e>-1){this.entBox.style.width=e+"px";this.objBox.style.width=e+"px";var q=(this.globalBox.offsetWidth-this.globalBox.clientWidth)/2;this._fake.entBox.style.left=e+"px";this._fake.entBox.style.width=Math.max(0,this.globalBox.offsetWidth-e-(this.quirks?0:2)*q)+"px";if(this._fake.ftr)this._fake.ftr.parentNode.style.width=this._fake.entBox.style.width;if(_isIE){var n=
_isIE&&!window.xmlHttpRequest,q=this.globalBox.offsetWidth-this.globalBox.clientWidth;this._fake.hdrBox.style.width=this._fake.objBox.style.width=Math.max(0,this.globalBox.offsetWidth-(n?q:0)-e)+"px"}}};
dhtmlXGridObject.prototype._correctRowHeight=function(e){if(this.rowsAr[e]&&this._fake.rowsAr[e]){var q=this.rowsAr[e].offsetHeight,n=this._fake.rowsAr[e].offsetHeight,j=Math.max(q,n);if(j&&(this.rowsAr[e].style.height=this._fake.rowsAr[e].style.height=j+"px",window._KHTMLrv))this.rowsAr[e].childNodes[this._fake._cCount].style.height=this._fake.rowsAr[e].firstChild.style.height=j+"px"}};

//v.3.0 build 110707
