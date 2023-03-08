<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck_NewWin.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/Include/ace-header.asp" -->
</head>
<body>
<FORM ID="SubjectUploadForm" METHOD="post" NAME="SubjectUploadForm" action="">
<div class="navbar">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a href="#" class="brand">
            <small>
            <i class="icon-leaf"></i>
            등록결과 데이터 가져오기
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
                            대학의 데이터베이스에 명단을 준비한 후 가져오기 하시면 됩니다.
                        </li>
                        <li>
                            <i class="icon-ok green"></i>
                            데이터베이스 연동 방식으로 수험번호, 이름, 석차, 전화번호 등을 입력하는 기능입니다.
                        </li>
                    </ul>
                    <div class="widget-box">
                        <div class="widget-header widget-header-flat">
                            <h4 class="smaller">
                            가져올 등록결과
                            </h4>
                            <div class="widget-toolbar">
                                <%'전형구분 선택
                                Dim RsO, FormDivision0
                                Set RsO = Server.CreateObject("ADODB.Recordset")
                                Dim StrSql
								StrSql = "select * from openquery(SCHOOLDB, 'SELECT Division0, count(*) FROM METIS.LINKTABLE1 group by Division0 order by Division0')"
                                'response.write StrSql
                                'response.end
                                RsO.Open StrSql, Dbcon%>
                                <SELECT id="FormDivision0" NAME="FormDivision0" style="width: 130px; height: 33px; margin-bottom: 2px;">
                                <option value="">전형구분선택</option>
                                <%do until RsO.eof%>
                                <option value="<%=RsO("Division0")%>" <%if RsO("Division0") = FormDivision0 then response.write "selected"%>><%=RsO("Division0")%></option>
                                <%RsO.MoveNext
                                loop%>
                                </SELECT>&nbsp;&nbsp;
                                <%'차수 선택
                                RsO.Close
                                Dim FormDegree
								StrSql = "select * from openquery(SCHOOLDB, 'SELECT Degree1, count(*) FROM METIS.LINKTABLE3 group by Degree1 order by Degree1')"
                                'response.write StrSql
                                'response.end
                                RsO.Open StrSql, Dbcon%>
                                <SELECT id="FormDegree" NAME="FormDegree" style="width: 130px; height: 33px; margin-bottom: 2px;">
                                <option value="">차수선택</option>
                                <%do until RsO.eof%>
                                <option value="<%=RsO("Degree1")%>" <%if RsO("Degree1") = FormDivision0 then response.write "selected"%>><%=RsO("Degree1")%></option>
                                <%RsO.MoveNext
                                loop%>
                                </SELECT>&nbsp;&nbsp;
                                <%RsO.Close
                                Set RsO = Nothing%>
                                <INPUT class="input" TYPE="button" value=" 레코드 확인 " style="height: 33px;" onclick="searchGetInfo();" style="cursor: pointer;" onFocus="blur();">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <div class="widget-box transparent" style="margin-top: 30px;">
                        <div class="widget-header widget-header-small">
                            <h4 class="blue smaller">
                            <i class="icon-rss orange"></i>
                            입력하는 등록결과 수에 따라 몇 분 걸릴 수 있습니다.
                            </h4>
                            <div class="widget-toolbar action-buttons">
                                &nbsp; &nbsp;
                                <a href="javascript: location.reload();" data-action="reload" >
                                <i class="icon-refresh blue bigger-180"></i>
                                </a>
                                &nbsp; &nbsp;
                                <a href="javascript: self.close();" class="pink">
                                <i class="icon-trash red bigger-180"></i>
                                </a>
                                &nbsp; &nbsp;
                                <a href="javascript: RegistUploadDataBaseSave();" class="pink" title="저장">
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
<!-- include virtual = "/Include/footer-basic-scripts.asp" -->
</body>
</FORM>
<script>
    var MyDhtmlxGrid
    MyDhtmlxGrid = new dhtmlXGridObject('gridbox');
    MyDhtmlxGrid.setImagePath("./DHX3Pro/dhtmlxGrid/codebase/imgs/");
    MyDhtmlxGrid.setHeader("모집코드,수험번호,차수,결과,입력시각");
    MyDhtmlxGrid.setInitWidths("95,95,85,85,150")
    MyDhtmlxGrid.setColAlign("center,center,center,center,left")
    MyDhtmlxGrid.setColTypes("ed,ed,ed,coro,ro");
    MyDhtmlxGrid.getCombo(3).put("2","등록완료");
    MyDhtmlxGrid.getCombo(3).put("3","포기");
    MyDhtmlxGrid.getCombo(3).put("4","미결정");
    MyDhtmlxGrid.getCombo(3).put("5","미연결");
    MyDhtmlxGrid.getCombo(3).put("6","등록예정");
    MyDhtmlxGrid.getCombo(3).put("7","미등록");
    MyDhtmlxGrid.getCombo(3).put("10","환불");
    MyDhtmlxGrid.setColSorting("str,str,str,int,date")
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
        Loading = false
        var count=MyDhtmlxGrid.getRowsNum();
        if (count>0){
            if (MyDhtmlxGrid.cellByIndex(0, 2).getValue().toString().toLowerCase()=="타임아웃"){
                alert("로그인이 필요합니다.");
                opener.document.location.href="/Login.asp";
                opener.focus();
                self.close();
            }
            if (MyDhtmlxGrid.cellByIndex(0, 1).getValue().toString().substring(0,5)=="--StrSql"){
                alert(MyDhtmlxGrid.cellByIndex(0, 1).getValue().toString());
            }
        }
    }
    function myErrorHandler(type, desc, erData){
        alert(erData[0].status)
    }
    dhtmlxError.catchError("ALL",function(a,b,data){
    alert("입력파일에 문제가 있습니다.\n에러타입:"+data[0].status);
    });
    var RecordChecked = false
    var Loading = false;
    function searchGetInfo(){
        if (document.getElementById("FormDivision0").value==""){
            alert("가져올 전형구분을 선택해 주세요")
            return;
        }
        if (Loading){
            alert("로딩중입니다. 잠시 기다리세요.");
            return;
        }
        RecordChecked = true
        var url = "process/RegistUploadDatabaseGet.asp?func=0"
        url = url + '&BursaryStatus2=<%=Session("BursaryStatus2")%>'
        url = url + '&FormResult1=<%=Session("Result1")%>'
        url = url + '&FormDivision0=' + escape(document.getElementById("FormDivision0").value);
        url = url + '&FormDegree=' + escape(document.getElementById("FormDegree").value);
        //window.open(url);
        MyDhtmlxGrid.clearAndLoad(url);
        document.getElementById("Prog").style.display = "block";
        Loading = true;
        if (SubjectUploadForm.FormDivision0.value==""){
            alert("가져올 전형을 선택해 주세요")
            return;
        }
        if (Uploading){
            alert("레코드 확인중입니다. 잠시 기다리세요.");
            return;
        }
        SavedFileName = SubjectUploadForm.FormDivision0.value;
        loadXML(SavedFileName, FormDegree1);
        document.getElementById("Prog").style.display = "block";
        Uploading = true
    }
    function RegistUploadDataBaseSave(){
        if(RecordChecked==false){
            alert("레코드 확인을 먼저 하세요.");
            return;
        }
        if (MyDhtmlxGrid.getRowsNum() == 0){
            alert("가져올 레코드가 없습니다.");
            return;
        }
        var url = "process/RegistUploadSave.asp?func=0"
        url = url + '&BursaryStatus2=<%=Session("BursaryStatus2")%>'
        url = url + '&FormResult1=<%=Session("Result1")%>'
        url = url + '&FormDivision0=' + escape(document.getElementById("FormDivision0").value);
        url = url + '&FormDegree=' + escape(document.getElementById("FormDegree").value);
        document.location.href=url;
        opener.document.location.reload();
    }
</script>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->
