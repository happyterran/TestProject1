<!-- #include virtual = "/Include/CodePage0.asp" -->
<!-- #include virtual = "/Include/Refresh.asp" -->
<!-- #include virtual = "/Include/Function.asp" -->
<!-- #include virtual = "/Include/Dbopen.asp" -->
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
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />

  <!-- Stylesheets -->
  <link href="style/bootstrap.css" rel="stylesheet">
  <link rel="stylesheet" href="style/font-awesome.css">
  <link href="style/style.css" rel="stylesheet">
  <link href="style/bootstrap-responsive.css" rel="stylesheet">
  
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->

  <!-- Favicon -->
  <link rel="shortcut icon" href="img/favicon/favicon.png">
	<SCRIPT LANGUAGE="JavaScript">
	function Login(This) {
		if(This.MemberID.value=="") {
			alert("아이디를 입력하세요");
			This.MemberID.focus();
			return false;
		}
		if(This.Password.value=="") {
			alert("비밀번호를 입력하세요");
			This.Password.focus();
			return false;
		}
	}
	</SCRIPT>
</head>

<body>

<!-- Form area -->
<div class="admin-form">
  <div class="container-fluid">

    <div class="row-fluid">
      <div class="span12">
        <!-- Widget starts -->
            <div class="widget">
              <!-- Widget head -->
              <div class="widget-head">
                <div class="pull-left"><%If Request.Querystring("LoginCheck")="" Then%><i class="icon-lock"></i> Login <%End If%></div>
                <div class="widget-icons pull-right">
                    <%If Request.Querystring("LoginCheck")<>"" Then%>
                        <h4 class="header red lighter bigger">
                            <i class="icon-lock bigger-110 red"></i>
                            <%=Request.Querystring("LoginCheck")%>
                        </h4>
                    <%Else%>
                        <h4 class="header blue lighter bigger">
                            <i class="icon-coffee green"></i>
                            로그인이 필요합니다
                        </h4>
                    <%End If%>
                </div>
                <div class="clearfix"></div>
              </div>

              <div class="widget-content">
                <div class="padd">

                  <!-- Login form -->
                  <%Dim MemberID, Password, SavePassword
                    MemberID = getParameter(Request.Cookies("MemberID"), "")
                    Password = getParameter(Request.Cookies("Password"), "")
                    SavePassword = getParameter(Request.Cookies("SavePassword"), "")
                  %>
                  <form class="form-horizontal" name="FrmLogin" method="post" action="/LoginOk.asp" onSubmit="javascript:return Login(document.FrmLogin);">
                    <!-- Email -->
                    <div class="control-group">
                      <label class="control-label" for="inputEmail">Member ID</label>
                      <div class="controls">
                        <input type="text" name="MemberID" id="MemberID" placeholder="Member ID" <%If SavePassword="1" And MemberID<>"" Then Response.Write "value='" & MemberID & "'"%>>
                      </div>
                    </div>
                    <!-- Password -->
                    <div class="control-group">
                      <label class="control-label" for="inputPassword">Password</label>
                      <div class="controls">
                        <input type="password" name="Password" id="Password" placeholder="Password">
                      </div>
                    </div>
                    <!-- Remember me checkbox and sign in button -->
                    <div class="control-group">
                      <div class="controls">
                        <label class="checkbox">
                          <input type="checkbox" name="SavePassword" value="1" <%If SavePassword="1" Then Response.Write "checked"%>> ID 저장
                        </label>
                        <br>
                        <button type="submit" class="btn">로그인</button>
                        <button type="button" class="btn" onclick="document.location.href='Register.asp'">회원가입</button>
                        
                      </div>
                    </div>
                  </form>

                </div>
                <div class="widget-foot" style="text-align: center;">※ &nbsp;IE10과 Chrome에 최적화 되어 있습니다.
                  <!-- Footer goes here -->
                </div>
              </div>
            </div>  
      </div>
    </div>
  </div> 
</div>
	
		

<!-- JS -->
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
document.FrmLogin.MemberID.focus();
//-->
</SCRIPT>
<!-- #include virtual = "/Include/Dbclose.asp" -->