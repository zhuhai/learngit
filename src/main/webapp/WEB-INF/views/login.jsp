<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>登录</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <!-- basic styles -->
  <link href="/static/assets/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/assets/css/font-awesome.min.css" />

  <!--[if IE 7]>
  <link rel="stylesheet" href="/static/assets/css/font-awesome-ie7.min.css" />
  <![endif]-->

  <!-- ace styles -->

  <link rel="stylesheet" href="/static/assets/css/ace.min.css" />
  <link rel="stylesheet" href="/static/assets/css/ace-rtl.min.css" />

  <!--[if lte IE 8]>
  <link rel="stylesheet" href="/static/assets/css/ace-ie.min.css" />
  <![endif]-->

  <!-- inline styles related to this page -->

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

  <!--[if lt IE 9]>
  <script src="/static/assets/js/html5shiv.js"></script>
  <script src="/static/assets/js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="login-layout" style="background: url('/static/img/bg.jpg') no-repeat">
<div class="main-container">
  <div class="main-content">
    <div class="row">
      <div class="col-sm-10 col-sm-offset-1">
        <div class="login-container">
          <div class="center">
            <h1>
              <i class="ace-icon fa fa-comments green"></i>
              <span class="red">微信</span>
              <span class="white">后台管理系统</span>
            </h1>
            <h4 class="blue">&copy; ChinaSea</h4>
          </div>

          <div class="space-6"></div>

          <div class="position-relative">
            <div id="login-box" class="login-box visible widget-box no-border" style="background-color: transparent">
              <div class="widget-body">
                <div class="widget-main">
                    <div class="red text-center"><b class="message">${message}</b></div>
                  <h4 class="header blue lighter bigger" style="margin-top: 8px">
                    <i class="ace-icon fa fa-coffee green"></i>
                    请输入登录信息
                  </h4>

                  <div class="space-6"></div>

                  <form id="fm" action="/login" method="post">
                    <fieldset>
                      <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="text" id="userName" name="userName" class="form-control" placeholder="用户名" autofocus/>
                            <i class="ace-icon fa fa-user"></i>
                        </span>
                      </label>

                      <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="password" id="pwd" name="password" class="form-control" placeholder="密码" />
                            <i class="ace-icon fa fa-lock"></i>
                        </span>
                      </label>

                      <div class="space"></div>

                      <div class="clearfix">
                        <%--<label class="inline">
                            <input type="checkbox" class="ace" />
                            <span class="lbl"> 记住我</span>
                        </label>--%>

                        <button type="button" id="btn" class="btn btn-block btn-primary no-border">
                          <i class="icon-key"></i>
                          登&nbsp;录
                        </button>
                      </div>

                      <div class="space-4"></div>
                    </fieldset>
                  </form>

                  <div class="social-or-login center">
                    <span class="bigger-110">Or Login Using</span>
                  </div>

                  <div class="social-login center">
                    <a class="btn btn-primary">
                      <i class="ace-icon fa fa-facebook"></i>
                    </a>

                    <a class="btn btn-info">
                      <i class="ace-icon fa fa-twitter"></i>
                    </a>

                    <a class="btn btn-danger">
                      <i class="ace-icon fa fa-google-plus"></i>
                    </a>
                  </div>
                </div><!-- /widget-main -->

                <div class="toolbar clearfix">
                  <div style="height: 30px;"></div>
                </div>
              </div><!-- /widget-body -->
            </div><!-- /login-box -->



          </div><!-- /position-relative -->
        </div>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div>
</div><!-- /.main-container -->

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/sha1.js"></script>
<script type="text/javascript">
  $(function(){
    function login(){
      $("#pwd").val(CryptoJS.SHA1($("#pwd").val()));
      $("#fm").submit();
    }
    $("#btn").click(function(){
      var userName = $("#userName").val();
      var password = $("#pwd").val();
      if(userName && password) {
        login();
      } else{
        $(".message").text("用户名或密码不能为空")
      }

    });

    $(document).keyup(function(event){
      if(event.keyCode == 13){
        login();
      }
    });


  });
</script>

</body>
</html>

