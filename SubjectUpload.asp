<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck_NewWin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/Include/ace-header.asp" -->
<script src="assets/js/FileUploadFunction.js"></script>
<script src="assets/js/jquery.js"></script>
<script src="assets/js/jquery.form.js"></script>
<script src="assets/js/general.js"></script>
<script type="text/javascript">
$(document).ajaxError(function(info,xhr){
if(xhr.status==500)
alert("데이터 저장시 오류가 발생하였습니다.");
}
);
var SavedFileName = "";
function FileuploadCallback(data,state){
    if (data=="error"){
        alert("파일전송중 오류가 발생하였습니다.\n다시한번 시도해주세요.");
        return false;
    }
    SavedFileName = data;
    loadXML(SavedFileName);
}
$(function(){
var frm=$('#frmFile');
frm.ajaxForm(FileuploadCallback);
frm.submit(function(){return false; });
});
var Uploading = false
function FileUpload(){
    if (Uploading){
        alert("업로드중입니다. 잠시 기다리세요.");
        return;
    }
    if(!$("#callbackfile").val()){
        alert("파일을 선택하세요.");
        $("#callbackfile").focus();
        return;
    }
    var imgPath = $("#callbackfile").val();
    var src = FileUtil.getFileExtension(imgPath);
    if((src.toLowerCase() != "xls" && src.toLowerCase() != "txt")){
        alert("엑셀 또는, 텍스트파일만 업로드가 가능합니다.");
        return;
    }
    var frm;
    frm = $('#frmFile');
    frm.attr("action","/fileupload.asp");
    frm.submit();
    document.getElementById("Prog").style.display = "block";
    Uploading = true
}
function SubjectUploadSave(){
    if(SavedFileName==""){
        alert("파일을 먼저 업로드 하세요.");
        return;
    }
    var url = "process/SubjectUploadSave.asp"
    document.location.href=url;
    opener.document.location.reload();
}
</script>
</head>
<body>
<FORM ENCTYPE="multipart/form-data" ID="frmFile" METHOD="post" NAME="frmFile" action="fileupload.asp">
<div class="navbar">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a href="#" class="brand">
            <small>
            <i class="icon-leaf"></i>
            모집단위 파일 업로드
            </small>
            </a><!--/.brand-->
        </div>
        <!--/.container-fluid-->
    </div>
    <!--/.navbar-inner-->
</div>
<div class="main-container container-fluid">
    <!-- include virtual = "/Include/SideBar.asp" -->
    <div class="main-content" style="margin-left:0;">
        <!-- include virtual = "/Include/nav-search.asp" -->
        <div class="page-content">
            <div class="row-fluid">
                <div class="span12">
                    <!-- ######################################################################################### -->
                    <!--PAGE CONTENT BEGINS-->
                    <!-- ######################################################################################### -->
                    <ul class="unstyled spaced">
                        <li>
                            <i class="icon-bell purple"></i>
                            양식에 따라 엑셀 파일을 작성한 후 업로드 하시면 됩니다. (파일양식 : 모집단위파일)
                        </li>
                        <li>
                            <i class="icon-ok green"></i>
                            엑셀 형태의 파일을 업로드하여 모집단위명, 등록금, 모집인원 등을 입력하는 기능입니다.
                        </li>
                    </ul>
                    <div class="widget-box">
                        <div class="widget-header widget-header-flat" style="margin: 0px; padding-right: 0px; padding-bottom: 0px">
                            <h4 class="smaller">
                            <input type="file" name="callbackfile" id="callbackfile" style="width: 460px; margin: 0px; padding: 0px; padding: 0px; border: 1px solid; height: 25px;"/>
                            </h4>
                            <div class="widget-toolbar">
                                <button class="btn btn-mini btn-success" onclick="FileUpload(); return false;">
                                <i class="icon-ok bigger-110"></i>
                                모집단위파일 확인
                                </button>
                            </div>
                        </div>
                        <div class="widget-body">
                            <div class="widget-main" style="padding: 0;">
                                <!-- 그리드 -->
                                <DIV CLASS="pop_tblBox" ID="gridbox" NAME="gricbox" STYLE="WIDTH: 100%; HEIGHT: 295px"></DIV>
                                <!--넓이에서 패딩 20px과 보더값 2px 빼기 (-22px)-->
                                <DIV id="pagingArea" align="" STYLE="WIDTH: 616px; HEIGHT: 30px"></DIV>
                                <!-- 그리드 -->
                            </div>
                        </div>
                    </div>
                    <div style="position: absolute; z-index:100; display: none; border:0px solid black; top: 240px; left: 0px; width: 99%; text-align: center;" id="Prog" name="Prog" >
                        <img src="/Images/AjaxLoding.gif" width="32" height="32" border="0" alt="">
                    </div>
                    <div class="widget-box transparent" style="margin-top: 12px; padding-bottom: 0px; margin-bottom: 0px; ">
                        <div class="widget-header widget-header-small" style="padding-bottom: 0px; margin-bottom: 0px; ">
                            <h4 class="blue smaller">
                            <i class="icon-rss orange"></i>
                            입력하는 모집단위 수에 따라 몇 분 걸릴 수 있습니다.
                            </h4>
                            <div class="widget-toolbar action-buttons" style="padding-bottom: 0px; margin-bottom: 0px;">
                                &nbsp; &nbsp;
                                <a href="javascript: location.reload();" data-action="reload" >
                                <i class="icon-refresh blue bigger-180"></i>
                                </a>
                                &nbsp; &nbsp;
                                <a href="javascript: self.close();" class="pink">
                                <i class="icon-trash red bigger-180"></i>
                                </a>
                                &nbsp; &nbsp;
                                <a href="javascript: SubjectUploadSave();" class="pink" title="저장">
                                <i class="icon-save skyblue bigger-180"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- ######################################################################################### -->
                    <!--PAGE CONTENT ENDS-->
                    <!-- ######################################################################################### -->
                </div>
                <!--/.span -->
            </div>
            <!--/.row-fluid -->
        </div>
        <!--/.page-content -->
        <!-- include virtual = "/Include/ace-settings-container.asp" -->
    </div>
    <!--/.main-content-->
</div>
<!--/.main-container-->
<!--basic scripts-->
<!--[if !IE]>-->
<script type="text/javascript">
window.jQuery || document.write("<%=chr(60)%>script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>
<!--<![endif]-->
<!--[if IE]>
        <script type="text/javascript">
            window.jQuery || document.write("<%=chr(60)%>script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
        </script>
        <![endif]-->
<script type="text/javascript">
if("ontouchend" in document) document.write("<%=chr(60)%>script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="assets/js/bootstrap.min.js"></script>
<!--page specific plugin scripts-->
<!--ace scripts-->
<script src="assets/js/ace-elements.min.js"></script>
<script src="assets/js/ace.min.js"></script>
<!--inline scripts related to this page-->
</body>
</FORM>
<script>
    var MyDhtmlxGrid
    MyDhtmlxGrid = new dhtmlXGridObject('gridbox');
    MyDhtmlxGrid.setImagePath("./DHX3Pro/dhtmlxGrid/codebase/imgs/");
    MyDhtmlxGrid.setHeader("모집코드,모집,모집단위,구분1,구분2,구분3,정원,가용,총계,입력시각");
    MyDhtmlxGrid.setInitWidths("80,60,116,90,60,60,40,40,70,146")
    MyDhtmlxGrid.setColAlign("left,left,left,left,left,left,right,right,right,center")
    MyDhtmlxGrid.setColTypes("ed,ed,ed,ed,ed,ed,ed,ed,edn,ro");
    MyDhtmlxGrid.setNumberFormat("0,000", 8);
    MyDhtmlxGrid.setNumberFormat("0,000", 9);
    MyDhtmlxGrid.setNumberFormat("0,000", 10);
    MyDhtmlxGrid.setNumberFormat("0,000", 11);
    MyDhtmlxGrid.setNumberFormat("0,000", 12);
    MyDhtmlxGrid.setNumberFormat("0,000", 13);
    MyDhtmlxGrid.setNumberFormat("0,000", 14);
    MyDhtmlxGrid.setNumberFormat("0,000", 15);
    MyDhtmlxGrid.setNumberFormat("0,000", 16);
    MyDhtmlxGrid.setNumberFormat("0,000", 17);
    MyDhtmlxGrid.setNumberFormat("0,000", 18);
    MyDhtmlxGrid.setDateFormat("%Y-%m-%d");
    MyDhtmlxGrid.setColSorting("int,str,str,str,str,str,int,int,int,int,int,int,int,int,int,int,int,int,int,date")
    MyDhtmlxGrid.enablePaging(true, 10, 10, "pagingArea", true, "recinfoArea");
    MyDhtmlxGrid.setPagingSkin("toolbar", "dhx_web");
    MyDhtmlxGrid.setPagingWTMode(true,true,false,false);
    MyDhtmlxGrid.setSkin("dhx_blue");
    MyDhtmlxGrid.attachEvent("onKeyPress", onKeyPressed);
    MyDhtmlxGrid.enableBlockSelection();
    function onKeyPressed(code, ctrl, shift){
        if (code == 67 && ctrl){
            if (!MyDhtmlxGrid._selectionArea)
                MyDhtmlxGrid.setCSVDelimiter("\t");
            MyDhtmlxGrid.copyBlockToClipboard();
        }
        if (code == 86 && ctrl){
            MyDhtmlxGrid.pasteBlockFromClipboard();
        }
        return true;
    }
    function protocolIt(str){
        var p = document.getElementById("protocol");
        p.innerHTML = "<li style='height:auto;'>" + str + "</li>" + p.innerHTML
    }
    function doOnRowSelected(id){
    }
    MyDhtmlxGrid.init();
    MyDhtmlxGrid.attachEvent("onXLE", DoOnXLE);
    function DoOnXLE(id,count){
        document.getElementById("Prog").style.display = "none";
        Uploading = false
        if (count>0){
            if (MyDhtmlxGrid.cellByIndex(0, 2).getValue().toString().toLowerCase()=="타임아웃"){
                alert("로그인이 필요합니다.");
                opener.document.location.href="/Login.asp";
                opener.focus();
                self.close();
            }
        }
    }
    function myErrorHandler(type, desc, erData){
        alert(erData[0].status)
    }
    dhtmlxError.catchError("ALL",function(a,b,data){
    alert("입력파일에 문제가 있습니다.\n에러타입:"+data[0].status);
    });
    MyDhtmlxDataProcessor = new dataProcessor("process/SubjectUploadUpdate.asp");
    MyDhtmlxDataProcessor.init(MyDhtmlxGrid);
    function loadXML(SavedFileName){
        //window.open("process/SubjectUploadGet.asp?SavedFileName="+SavedFileName);
        MyDhtmlxGrid.clearAndLoad("process/SubjectUploadGet.asp?SavedFileName="+SavedFileName);
    }
</script>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
