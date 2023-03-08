<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
  <meta charset="euc-kr">
  <!-- Title and other stuffs -->
  <title>Project METIS 2.0</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="author" content="">
  <meta http-equiv="X-UA-Compatible" content="IE=9" />

  <!-- Stylesheets -->
  <link href="style/bootstrap.css" rel="stylesheet">
  <link rel="stylesheet" href="style/font-awesome.css">
  <link href="style/style.css" rel="stylesheet">
  <link href="style/bootstrap-responsive.css" rel="stylesheet">
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

  <!-- parseJSON ����ϱ� ���� ���� �ö�Դ� -->
  <script src="js/jquery.js"></script>

  <!-- Favicon -->
  <link rel="shortcut icon" href="img/favicon/favicon.png">
  <script type="text/javascript">
    
    var obj
    function checkMemberID(MemberID) {
        var FrmRegist = document.FrmRegist;
        FrmRegist.isValidID.value="0";

        if(MemberID.value == ""){
            $("#MemberIDGroup").removeClass("error");
            $("#MemberIDLabel").empty();
            return ;
        }

        if (!IsAlphaNum(MemberID)){
            $("#MemberIDGroup").addClass("error");
            $("#MemberIDLabel").html("����,���ڸ� ����");
            return ;
        }

        if(MemberID.value.length < "4"){
            $("#MemberIDGroup").addClass("error");
            $("#MemberIDLabel").html("4�� �̻� �ʼ�");
            return ;
        }

        var post_data = "MemberID="+MemberID.value;
        $.ajax({
            type: 'POST',
            url: '/MemberIDCheck.asp',
            data: post_data,
            dataType: 'html',
            success: function(Html, textStatus) {
            obj = $.parseJSON(Html);
                document.FrmRegist.isValidID.value=obj.Code;
                if (obj.Code=="1"){
                    $("#MemberIDLabel").show();
                    $("#MemberIDGroup").removeClass("error");
                    $("#MemberIDLabel").html(obj.Message)
                    FrmRegist.isValidID.value="1";
                }else{
                    $("#MemberIDLabel").show();
                    $("#MemberIDGroup").addClass("error");
                    $("#MemberIDLabel").html(obj.Message)
                    FrmRegist.isValidID.value="0";
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                //alert('An error occurred! ' + ( errorThrown ? errorThrown : xhr.status ) );
            }
        });

        
    }

    function checkPassword(Password,Password1) {
        var FrmRegist = document.FrmRegist;

        if(Password.value == ""){
            $("#PasswordGroup").removeClass("error");
            $('#PasswordLabel').hide('fast');
            $("#PasswordLabel").empty();
            FrmRegist.isValidPassword.value="0";
            return ;
        }

        if(Password.value.length < "4"){
            $("#PasswordGroup").addClass("error");;
            $('#PasswordLabel').show('fast');
            $("#PasswordLabel").html("4�� �̻� �ʼ�");
            FrmRegist.isValidPassword.value="0";
            return ;
        }
        $("#PasswordGroup").removeClass("error");
        //$('#PasswordLabel').hide('fast');
        $("#PasswordLabel").html("��� ����");
        FrmRegist.isValidPassword.value="1";

        if(Password1.value == ""){
            $("#PasswordGroup1").removeClass("error");
            $('#PasswordLabel1').hide('fast');
            $("#PasswordLabel1").empty();
            FrmRegist.isValidPassword1.value="0";
            return ;
        }

        if(Password1.value.length < "4"){
            $("#PasswordGroup1").addClass("error");;
            $('#PasswordLabel1').show('fast');
            $("#PasswordLabel1").html("4�� �̻� �ʼ�");
            FrmRegist.isValidPassword1.value="0";
            return ;
        }

        if(Password1.value != Password.value){
            $("#PasswordGroup1").addClass("error");;
            $('#PasswordLabel1').show('fast');
            $("#PasswordLabel1").html("��й�ȣ ����ġ");
            FrmRegist.isValidPassword1.value="0";
            return ;
        }
        $("#PasswordGroup").removeClass("error");
        //$('#PasswordLabel').hide('fast');
        //$("#PasswordLabel").empty();
        $("#PasswordLabel").html("��� ����");
        FrmRegist.isValidPassword.value="1";
        $("#PasswordGroup1").removeClass("error");
        //$('#PasswordLabel1').hide('fast');
        //$("#PasswordLabel1").empty();
        $("#PasswordLabel1").html("��й�ȣ ��ġ");
        FrmRegist.isValidPassword1.value="1";
    }
    var statusForm;
    function CheckRegist(This){
        if (statusForm)
        {
            alert("������ �ڷ� ���� ���Դϴ�.\r\r��� ��ٷ� �ּ���.");
            return false;
        }
        if (This.MemberName.value==""){
            SetAlertAndFocus(This.MemberName,"�̸��� �Է��ϼ���");
            return false;
        }
        if (This.MemberID.value==""){
            SetAlertAndFocus(This.MemberID,"���̵� �Է��ϼ���");
            return false;
        }
        if (This.isValidID.value=="0"){
            SetAlertAndFocus(This.MemberID,"���̵� �����ϼ���");
            return false;
        }
        if (This.MemberID.value.length < 2)
        {
            SetAlertAndFocus(This.MemberID,"ID�� �α�¥ �̻��̾�� �մϴ�");
            return false;
        }
        if (This.MemberID.value.length>=15){
            SetAlertAndFocus(This.MemberID,"���̵�� 15�� ���Ϸ� �Է����ּ���");
            return false;
        }	
        if (This.Password.value==""){
            SetAlertAndFocus(This.Password,"��й�ȣ�� �Է��ϼ���");
            return false;
        }
        if (This.isValidPassword.value=="0"){
            SetAlertAndFocus(This.Password,"��й�ȣ�� �����ϼ���");
            return false;
        }
        if (This.Password1.value==""){
            SetAlertAndFocus(This.Password1,"��й�ȣ�� �ѹ� �� �Է��ϼ���");
            return false;
        }
        if (This.isValidPassword1.value=="0"){
            SetAlertAndFocus(This.Password1,"��й�ȣ�� �����ϼ���");
            return false;
        }
        if ((This.Password.value)!=(This.Password1.value)){
            SetAlertAndFocus(This.Password1,"������ ��й�ȣ�� �Է��Ͽ� �ֽʽÿ�");
            return false;
        }
        if (This.agreement.checked==false){
            SetAlertAndFocus(This.agreement,"�̿����� �������ּ���.");
            return false;
        }
        statusForm = true
    }
    /**
     * �Է°��� ���ĺ�,���ڷ� �Ǿ��ִ��� üũ
     * @param obj   Object
     * @return true ���ĺ�,���ڷ� �Ǿ��ִ� ���
     */
    function IsAlphaNum(obj) {
			var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
			return ContainsCharsOnly(obj,chars);
    }

    /**
     * �Է°��� Ư�� ����(chars)������ �Ǿ��ִ��� üũ
     * Ư�� ���ڸ� ����Ϸ� �� �� ���
     * ex) if (!containsCharsOnly(form.blood,"ABO")) {
     *         Alert("������ �ʵ忡�� A,B,O ���ڸ� ����� �� �ֽ��ϴ�.");
     *     }
     * @param obj   Object
     * @return true Ư�� ���ڰ� ���� ���
     */
    function ContainsCharsOnly(obj,chars) {
			for (var inx = 0; inx < obj.value.length; inx++) {
				if (chars.indexOf(obj.value.charAt(inx)) == -1)
				return false;
			}
			return true;
    }
    function SetAlertAndFocus(This,MSG) {
        alert(MSG);
        This.focus();
        This.select();
    }
  </script>
</head>

<body>

<div class="admin-form">
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <!-- Widget starts -->
            <div class="widget">
              <div class="widget-head">
                <i class="icon-lock"></i> Register 
              </div>
              <div class="widget-content">
                <div class="padd">
                  
                  <form class="form-horizontal" method="post" name="FrmRegist" action="RegisterOk.asp" onSubmit="return CheckRegist(document.FrmRegist);">
                  <input type="hidden" name="isValidID" value="0"><!--//���̵� �ߺ�üũ-->
                  <input type="hidden" name="isValidPassword" value="0"><!--//��й�ȣ ����üũ-->
                  <input type="hidden" name="isValidPassword1" value="0"><!--//��й�ȣ1 ����üũ-->
                  <!-- Registration form starts -->

                      <!-- Name -->
                      <div class="control-group">
                        <label class="control-label" for="name">�̸�</label>
                        <div class="controls">
                          <input type="text" name="MemberName" class="input-large" id="name" placeholder="������ �̸�">
                        </div>
                      </div>   
                      <!-- Email --><!-- 
                      <div class="control-group">
                        <label class="control-label" for="email">Email</label>
                        <div class="controls">
                          <input type="text" name="email" class="input-large" id="email">
                        </div>
                      </div> -->
                      <!-- Select box --><!-- 
                      <div class="control-group">
                        <label class="control-label">Drop Down</label>
                        <div class="controls">                               
                            <select>
                            <option>&nbsp;</option>
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            </select>  
                        </div>
                      </div> --> 
                      <!-- Username -->
                      <div class="control-group" id="MemberIDGroup">
                        <label class="control-label" for="username">Member ID</label>
                        <div class="controls">
                          <input type="text" name="MemberID" class="input-large" id="username" placeholder="4�� �̻��� �ѱ�, ����, ����" onkeyup="checkMemberID(this);">
                          <span class="help-inline" id="MemberIDLabel" style=""></span>
                        </div>
                      </div>
                      <!-- Password -->
                      <div class="control-group" id="PasswordGroup">
                        <label class="control-label" for="email">Password</label>
                        <div class="controls">
                          <input type="Password" name="Password" class="input-large" id="Password" placeholder="4�� �̻��� ����, ����" onkeyup="checkPassword(this,this.form.Password1);">
                          <span class="help-inline" id="PasswordLabel" style=""></span>
                        </div>
                      </div>
                      <!-- Password1 -->
                      <div class="control-group" id="PasswordGroup1">
                        <label class="control-label" for="email">Password</label>
                        <div class="controls">
                          <input type="Password" name="Password1" class="input-large" id="Password1" placeholder="4�� �̻��� ����, ����" onkeyup="checkPassword(this.form.Password,this);">
                          <span class="help-inline" id="PasswordLabel1" style=""></span>
                        </div>
                      </div>
                      <!-- Accept box and button s-->
                      <div class="control-group">
                        <div class="controls">
                          <label class="checkbox">
                            <input type="checkbox" name="agreement"> Project METIS 2.0 �̿� ����� ����
                          </label>
                          <br>
                          <button type="submit" class="btn">ȸ������</button>
                          <button type="reset" class="btn"> ���� </button>
                        </div>
                      </div>
                  </form>



                </div>
                <div class="widget-foot">
                  <!-- Footer goes here -->
                </div>
              </div>
            </div>  
      </div>
    </div>
  </div> 
</div>
	
		

<!-- JS -->
<!-- <script src="js/jquery.js"></script> -->
<script src="js/bootstrap.js"></script>
</body>
</html>