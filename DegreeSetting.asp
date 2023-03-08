<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/LoginCheck.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- #include virtual = "/Include/Head.asp" -->
</head>

<body style="padding-top:0;">

<!-- GNB starts -->
	<!-- #include virtual = "/Include/GNB.asp" -->
<!-- GNB ends -->

<!-- Header starts -->
	<!-- include virtual = "/Include/Header.asp" -->
<!-- Header ends -->

<!-- Main content starts -->

<div class="content">

  	<!-- Sidebar -->
	    <!-- #include virtual = "/Include/Sidebar.asp" -->
  	<!-- Sidebar ends -->

  	<!-- Main bar -->
  	<div class="mainbar">

      <!-- Page heading -->
      <div class="page-head">
        <h2 class="pull-left"><i class="icon-wrench"></i> ȯ�� ����</h2>
        <!-- Breadcrumb -->
        <div class="bread-crumb pull-right">
          <a href="/Login.asp"><i class="icon-home"></i> Home</a> 
          <!-- Divider -->
          <span class="divider">/</span> 
          <a href="/DegreeSetting.asp" class="bread-current">ȯ�� ����</a>
        </div>
        <div class="clearfix"></div>
      </div>
      <!-- Page heading ends -->

	    <!-- Matter -->

	    <div class="matter" style="min-height: 700px;">
        <div class="container-fluid">



          <div class="row-fluid">
            <div class="span4">



                <form class="form-horizontal uni" METHOD="POST" ACTION="DegreeSettingOk.asp" name="FormDegreeSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">���� ����</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>����, ����, ��ϱ����� �����ϰ� "�߰�"��ư�� Ŭ���ϼ���. �߰��� ������ ���� ��� �Էº��� ����˴ϴ�.</h6>
                        <hr />
                        <label>�����ñ� ���� ����</label>
                        <div class='file-checkbox'>
                            <%'##########  ����  ##########
                            Dim StrSql, Rs11
                            Set Rs11 = Server.CreateObject("ADODB.Recordset")
                            StrSql	=				"select Division0, count(*) as count "
                            StrSql = StrSql & vbCrLf & "from SubjectTable "
                            StrSql = StrSql & vbCrLf & "where Division0<>'' "
                            StrSql = StrSql & vbCrLf & "group by Division0 "
                            StrSql = StrSql & vbCrLf & "order by Division0"
                            'Response.Write StrSql & "<BR>"
                            Rs11.Open StrSql, Dbcon
                            Dim DivisionTemp
                            If Rs11.BOF = false Then%>
                                <SELECT NAME="Division0" style="width: 190px;">
                                    <option value="">�����ñ� ����</option>
                                    <%do Until Rs11.EOF
                                        DivisionTemp = Rs11("Division0")%>
                                        <option value="<%=DivisionTemp%>"><%=DivisionTemp%></option>
                                        <%Rs11.MoveNext%>
                                    <%Loop%>
                                </SELECT>
                            <%End If%>
                            <%Rs11.Close%>
                            <%'##########  ����  ##########
                            Set Rs11 = Server.CreateObject("ADODB.Recordset")
                            StrSql	=				"select ISNULL(Max(Degree),0) DegreeTemp"
                            StrSql = StrSql & vbCrLf & "from RegistRecord "
                            'Response.Write StrSql & "<BR>"
                            Rs11.Open StrSql, Dbcon
                            Dim DegreeTemp, i
                            i=1
                            If Rs11.BOF = false Then%>
                                <SELECT NAME="Degree" style="width: 190px;">
                                    <option value="">���� ����</option>
									<option value="0">0</option>
                                    <%do Until i = DegreeTemp + 5
                                        DegreeTemp = Rs11("DegreeTemp")%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <%i=i+1%>
                                    <%Loop%>
                                </SELECT>
                            <%End If%>
                            <%Rs11.Close
                            Set Rs11 = Nothing%>
                        </div>
                        <hr />
                        <label>��ϱ��� ����</label>
                        <div id="datetimepicker1" class="input-append">
                            <input data-format="yyyy-MM-dd" type="text" name="RefundDay1" style="width: 155px; height: 22px; border-radius: 4px 0 0 4px; " value="<%=Date()+1%>" readonly>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar" id="RefundDay1Icon" style="cursor: pointer"></i>
                            </span>
                        </div>
                        <div id="datetimepicker2" class="input-append">
                            <input data-format="hh:mm:ss" type="text" name="RefundDay2" style="width: 155px; height: 22px; border-radius: 4px 0 0 4px; " value="16:00:00" readonly>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar" style="cursor: pointer"></i>
                            </span>
                        </div>
                        <hr />
                        <button type="button" class="btn btn-primary" style="width: 190px;" onclick="BulkDegreeSetting(this.form);"> �������� �߰� </button>
                        <hr />
                        <%Dim Rs
                        Dim Division0cct
                        Set Rs = Server.CreateObject("ADODB.Recordset")
                        StrSql =       "select D.*, cct.Division0 Division0cct"
                        StrSql = StrSql & vbCrLf & "from Degree2 D"
                        StrSql = StrSql & vbCrLf & "left outer join ( select distinct Division0 from SubjectTable ) cct"
                        StrSql = StrSql & vbCrLf & "on D.Division0 = cct.Division0"
                        StrSql = StrSql & vbCrLf & "Order by D.IDX desc"
                        'PrintSql StrSql
                        'Response.End
                        Rs.Open StrSql, Dbcon%>
                        <%If Rs.EOF Then%>
                            <label>������ ������ �����ϴ�</label>
                        <%Else%>
                            <label>���� ����� ����</label>
                            <%do Until Rs.eof%>
                                <ul class="task">
                                    <li>
                                        <%Division0cct = getParameter(Rs("Division0cct"), "")
                                        If Division0cct="" Then%>
                                            <%=Rs("Division0")%>����&nbsp; ��� <%=Rs("Degree")%>��&nbsp; ������Դϴ�.
                                        <%Else%>
                                            <%=Rs("Division0")%>����&nbsp; ��� <%=Rs("Degree")%>��&nbsp; <!-- ��ϱ��� <%=Rs("RegistrationYear")%>��  --><%=Rs("RegistrationMonth")%>�� <%=Rs("RegistrationDay")%>�� <%=Rs("RegistrationHour")%>�� <%=Rs("RegistrationMinute")%>��
                                        <%End If%>
                                      <a href="javascript: if (confirm('<%=Rs("Division0")%>���� ���������� �����ұ��?')){document.location.href='DegreeDeleteOk.asp?IDX=<%=Rs("IDX")%>'}" class="pull-right"><i class="icon-remove"></i></a>
                                    </li>                                                                                               
                                </ul>
                                <%Rs.MoveNext
                            loop%>
                        <%End If%>
                        <%Rs.Close
                        Set Rs = Nothing%>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>
                </form>

				

                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">���ø�� �ٿ�ε�</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>���Ϸ� ���ε� ��ɿ� ���Ǵ� ���� �����Դϴ�.</h6>
                        <h6>XLS, TXT ���� ��� ��� �����մϴ�.</h6>
                        <hr />
                        <button type="button" class="btn btn-info" style="width: 190px;" onclick="FileUploadSample()"> ���ø�� �ٿ�ε�</button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  



                <form class="form-horizontal" METHOD="POST" ACTION="DegreeDatabaseBackupOk.asp" name="FormDatabaseBackup">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�����ͺ��̽� ���</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>Database�� ������ �̹��� ���·� ��� �մϴ�.</h6>
                        <h6>��� �̹����� 14�ϰ� ���� �� �ڵ� ���˴ϴ�</h6>
                        <hr />
                        <button type="button" class="btn btn-warning" style="width: 190px;" onclick="DatabaseBackup(this.form)"> �����ͺ��̽� ��� </button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  
                </form>



                <form class="form-horizontal" METHOD="POST" ACTION="DegreeDatabaseResetOk.asp" name="FormDatabaseReset">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�����ͺ��̽� ����</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>Database�� ��� �ڷ�� ���������� �����մϴ�.</h6>
                        <h6>������ �����ʹ� ������ �Ұ����մϴ�.</h6>
                        <hr />
                        <button type="button" class="btn btn-danger" style="width: 190px;" onclick="DatabaseReset(this.form)"> �����ͺ��̽� ���� </button>
                      </div>
                      <div class="widget-foot">
                        <!-- Footer goes here -->
                      </div>
                    </div>
                  </div>  
                </form>


		    </div><!-- span4 -->





            <div class="span4">


                <%'Dim StrSql, Rs
                Set Rs = Server.CreateObject("ADODB.Recordset")
                StrSql = "select top 1 * From SettingTable order by IDX desc"
                Rs.Open StrSql, Dbcon, 1, 1
                Dim SMSConfirm,UniversityName,CallBack,SMSAutoConfirm,SMSBodyRegistrationFee,SMSBodyAccountNumber,SMSBodyRegistrationTime, AutoAbandon
                SMSConfirm = Rs("SMSConfirm")
                UniversityName = Rs("UniversityName")
                CallBack = Rs("CallBack")
                SMSAutoConfirm = Rs("SMSAutoConfirm")
                SMSBodyRegistrationFee = Rs("SMSBodyRegistrationFee")
                SMSBodyAccountNumber = Rs("SMSBodyAccountNumber")
                SMSBodyRegistrationTime = Rs("SMSBodyRegistrationTime")
				AutoAbandon = Rs("AutoAbandon")
                Rs.Close
                Set Rs = Nothing%>
                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                <form class="form-horizontal" METHOD="POST" ACTION="DegreeSMSSettingOk.asp" name="FormSMSSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�Ϲ� SMS ����</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>������ �߼��ϴ� SMS�� �߼ۿ��� �����Դϴ�.</h6>
                        <hr />
                        <h5>SMS �߼ۿ���</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSConfirm" value="1" <%If SMSConfirm="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <h5>SMS ȸ�Ź�ȣ</h5>
                        <input type="text" name="CallBack" value="<%=CallBack%>" style="width: 175px;" placeholder="">
                        <hr />
                        <button type="button" class="btn btn-primary" style="width: 190px;" onclick="SMSSetting(this.form)"> �Ϲ� SMS ���� ���� </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>



                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
                <FORM class="form-horizontal uni" METHOD="POST" ACTION="DegreeSMSSettingTestSend.asp" name="FormSMSSettingTestSend">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�׽�Ʈ SMS �߼�</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>���� �ԷµǾ� �ִ� �а�����, ����������, ��������, SMS������ �̿��Ͽ�, �Ʒ��� �ڵ��� ��ȣ�� �׽�Ʈ�߼� �մϴ�. ��� ������ �غ� �Ǿ� �־�� �մϴ�</h6>
                        <hr />
                        <label>�׽�Ʈ �߼� �ڵ��� ��ȣ </label>
                        <input type="text" name="TestDestination" value="" style="width: 175px;" placeholder="">
                        <hr />
                        <label>�׽�Ʈ �߼� �����ñ� ����</label>
                        <%'##########  ����  ##########
                        Set Rs11 = Server.CreateObject("ADODB.Recordset")
                        StrSql	=				"select Division0, count(*) as count "
                        StrSql = StrSql & vbCrLf & "from SubjectTable "
                        StrSql = StrSql & vbCrLf & "where Division0<>'' "
                        StrSql = StrSql & vbCrLf & "group by Division0 "
                        StrSql = StrSql & vbCrLf & "order by Division0"
                        'Response.Write StrSql & "<BR>"
                        Rs11.Open StrSql, Dbcon
                        If Rs11.BOF = false Then%>
                            <SELECT NAME="TestDivision0" style="width: 190px;" >
                                <option value="">�����ñ� ����</option>
                                <%do Until Rs11.EOF
                                    DivisionTemp = Rs11("Division0")%>
                                    <option value="<%=DivisionTemp%>"><%=DivisionTemp%></option>
                                    <%Rs11.MoveNext%>
                                <%Loop%>
                            </SELECT>
                        <%End If%>
                        <%Rs11.Close
                        Set Rs11 = Nothing%>
                        <hr />
                        <label>�׽�Ʈ ��ȭ��� ����</label>
                        <label><input name='TestResult' type='radio' value='��Ͽ���' />��Ͽ���</label>
                        <label><input name='TestResult' type='radio' value='����' />����</label>
                        <hr />
                        <button type="button" class="btn btn-success" style="width: 190px;" onclick="SMSSettingTestSend(this.form)"> �׽�Ʈ �߼� </button>

                      </div>
                      <div class="widget-foot">
                      </div>

                    </div>
                  </div>
                </form>
                <%'="FormSEndURL: " & Request("FormSEndURL") & "<br>"%>
                <Iframe src="<%=Request.QueryString("FormSEndURL")%>" name="StudentDetailSMSSEnd" width="0" height="0" border="0" style="border:0;"></Iframe>


		    </div><!-- span4 -->



            <div class="span4">
                



                <!-- Form starts. Don't forget the class "uni" to add cool styles -->
				<!--
                <FORM class="form-horizontal" METHOD="POST" ACTION="DegreeSMSSettingOk.asp" name="FormSMSSetting">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�ڵ��߼� SMS ����</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>��ȭ��ȭ ���� �ڵ����� �߼��ϴ� SMS�� �����Դϴ�.</h6>
                        <hr />
                        <h5>SMS �ڵ��߼ۿ���</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSAutoConfirm" value="1" <%If SMSAutoConfirm="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>SMS�� ǥ���� �б���</label>
                        <input type="text" name="UniversityName" value="<%=UniversityName%>" style="width: 175px;" placeholder="">
                        <hr />
                        <label>��ϱ� �ݾ� �ȳ����� ����</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyRegistrationFee" value="1" <%If SMSBodyRegistrationFee="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>���¹�ȣ �ȳ����� ����</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyAccountNumber" value="1" <%If SMSBodyAccountNumber="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <label>��ϱ��� �ȳ����� ����</label>
                        <div class="info-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="SMSBodyRegistrationTime" value="1" <%If SMSBodyRegistrationTime="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
                        <button type="button" class="btn btn-danger" style="width: 190px;" onclick="SMSSetting2(this.form)"> �ڵ��߼� SMS ���� ���� </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>
				-->

                <form class="form-horizontal" METHOD="POST" ACTION="DegreeAutoAbandonSettingOk.asp" name="FormAutoAbandon">
                  <div class="widget">
                    <div class="widget-head">
                      <div class="pull-left">�������� �ڵ����� ����</div>
                      <div class="widget-icons pull-right">
                        <a href="#" class="wminimize"><i class="icon-chevron-up"></i></a> 
                        <a href="#" class="wclose"><i class="icon-remove"></i></a>
                      </div>  
                      <div class="clearfix"></div>
                    </div>
                    <div class="widget-content">
                      <div class="padd">
                        <h6>���������� �ڵ����� ���� �����Դϴ�.</h6>
                        <hr />
                        <h5>�ڵ����� ����</h5>
                        <div class="warning-toggle-button">
                            <input id="toogle-checkbox" type="checkbox" name="AutoAbandon" value="1" <%If AutoAbandon="1" Then%>checked="checked"<%End If%>>
                        </div>
                        <hr />
						<button type="button" class="btn btn-info" style="width: 190px;" onclick="AutoAbandonSetting(this.form)"> �ڵ����� ���� ���� </button>
                      </div>
                      <div class="widget-foot">
                      </div>
                    </div>
                  </div>
                </form>
		    
			</div><!-- span4 -->

          </div><!-- row-fluid -->




          <div class="row-fluid">
            <div class="span4">
		    </div><!-- span4 -->
            <div class="span4">
		    </div><!-- span4 -->
            <div class="span4">
		    </div><!-- span4 -->
          </div><!-- row-fluid -->




<!-- myModalRoot -->
<div id="myModalRoot" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalRootLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
        <a href="#myModalRoot" id="myModalRootButton"role="button" class="btn btn-primary" data-toggle="modal" style="width:0px; height:0px;"></a>
        <h3 id="myModalRootLabel">���â �����Դϴ�.</h3>
        <!-- myModalRootButton -->
    </div>
    <div class="modal-body">
        <p id="myModalRootMessage">�̰��� ������ ǥ�õ˴ϴ�.</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    </div>
</div>








		</div>
        </div>

		<!-- Matter ends -->

    </div>

   <!-- Mainbar ends -->	    	
   <div class="clearfix"></div>

</div>
<!-- Content ends -->

<!-- Footer starts -->
<footer>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
            <!-- Copyright info -->
            <p class="copy">Copyright &copy; 2013 | <a href="#">MetisSoft, Inc.</a> </p>
      </div>
    </div>
  </div>
</footer> 	

<!-- Footer ends -->

<!-- Scroll to top -->
<span class="totop"><a href="#"><i class="icon-chevron-up"></i></a></span> 

<!-- JS -->
<script src="js/jquery.js"></script> <!-- jQuery -->
<script src="js/bootstrap.js"></script> <!-- Bootstrap -->
<script src="js/jquery-ui-1.9.2.custom.min.js"></script> <!-- jQuery UI -->
<script src="js/fullcalendar.min.js"></script> <!-- Full Google Calendar - Calendar -->
<script src="js/jquery.rateit.min.js"></script> <!-- RateIt - Star rating -->
<script src="js/jquery.prettyPhoto.js"></script> <!-- prettyPhoto -->

<!-- jQuery Flot -->
<script src="js/excanvas.min.js"></script>
<script src="js/jquery.flot.js"></script>
<script src="js/jquery.flot.resize.js"></script>
<script src="js/jquery.flot.pie.js"></script>
<script src="js/jquery.flot.stack.js"></script>

<!-- jQuery Notification - Noty -->
<script src="js/jquery.noty.js"></script> <!-- jQuery Notify -->
<script src="js/themes/default.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/bottom.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/topRight.js"></script> <!-- jQuery Notify -->
<script src="js/layouts/top.js"></script> <!-- jQuery Notify -->
<!-- jQuery Notification ends -->

<script src="js/sparklines.js"></script> <!-- Sparklines -->
<script src="js/jquery.cleditor.min.js"></script> <!-- CLEditor -->
<script src="js/bootstrap-datetimepicker.min.js"></script> <!-- Date picker -->
<script src="js/jquery.uniform.min.js"></script> <!-- jQuery Uniform -->
<script src="js/jquery.toggle.buttons.js"></script> <!-- Bootstrap Toggle -->
<script src="js/filter.js"></script> <!-- Filter for support page -->
<script src="js/custom.js"></script> <!-- Custom codes -->
<script src="js/charts.js"></script> <!-- Charts & Graphs -->
<script type="text/javascript">
    function myModalRootClick(myModalRootLabel,myModalRootMessage){
        $("#myModalRootLabel").text(myModalRootLabel);
        $("#myModalRootMessage").html(myModalRootMessage);
        $("#myModalRootButton").click();
    }
    function BulkDegreeSetting(obj1){
        var myform = obj1;
        if (myform.Division0.value==""){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("��������","�����ñ⸦ �����ϼ���");
            return false;
        }
        if (myform.Degree.value==""){
            //alert("������ ������ ��Ź�ϼ���.");
            myModalRootClick("��������","������ ������ ��Ź�ϼ���");
            return false;
        }
        if (myform.RefundDay1.value==""){
            //alert("������ ������ ��Ź�ϼ���.");
            myModalRootClick("��������","��ϱ����� ��Ź�ϼ���");
            return false;
        }
        //if (confirm("���� ������ ������ڸ� �����մϴ�. �۾��� ��ο��� ������ ����ϴ�. ����Ͻðڽ��ϱ�?")==true){
            obj1.submit();
        //}
    }
    function DatabaseBackup(){
        //if (confirm("�����ͺ��̽��� ����մϴ�.  ����Ͻðڽ��ϱ�?")==true){
            document.FormDatabaseBackup.submit();
        //}
    }
    function DatabaseReset(){
        if (confirm("�����ͺ��̽��� �����մϴ�.  ����Ͻðڽ��ϱ�?")==true){
            document.FormDatabaseReset.submit();
        }
    }
    function SMSSetting(f){
        if (f.CallBack.value==""){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("�Ϲ� SMS ����","ȸ�Ź�ȣ�� �Է��ϼ���");
            return false;
        }
        f.submit();
    }
    function SMSSetting2(f){
        if (f.UniversityName.value==""){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("�ڵ��߼� SMS ����","�б����� �Է��ϼ���");
            return false;
        }
        f.submit();
    }
    function SMSSettingTestSend(f){
        if (f.TestDestination.value==""){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("�׽�Ʈ SMS �߼�","�ڵ��� ��ȣ�� �Է��ϼ���.");
            return false;
        }
        if (f.TestDivision0.value==""){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("�׽�Ʈ SMS �߼�","�����ñ⸦ �����ϼ���.");
            return false;
        }
        if (!getRadioValue(f.TestResult)){
            //alert("���� ������ ������ �����ϼ���.");
            myModalRootClick("�׽�Ʈ SMS �߼�","�׽�Ʈ ����� �Է��ϼ���.");
            return false;
        }
        f.submit();
    }
	function AutoAbandonSetting(f){
		f.submit();
    }
	function FileUploadSample() {
		document.location.href = "/Images/METIS ���̺� ���̾ƿ� ����.rar";
	}
    function getRadioValue(radioName){
        var obj = radioName;
        for(var i=0; i<obj.length;i++){
            //alert(obj[i].value + " : " +obj[i].checked);
            if (obj[i].checked){
                getName = obj[i].value;
                return getName;
            }
        }
        return null;
    }

</script>

</body>
</html>
<!-- #include virtual = "/Include/Dbclose.asp" -->

<!-- ��� ���� Notification -->
<%If Request.Querystring("Message")<>"" Then
    Dim MessageType, Message
    MessageType=getParameter(Request.Querystring("MessageType"),"success")
    Message    =getParameter(Request.Querystring("Message"),"")%>
    <script language='javascript'>
        noty({text: '<br><%=Message%><br>&nbsp;',layout:'top',type:'<%=MessageType%>',timeout:7000});
    </script>
<%End If%>
