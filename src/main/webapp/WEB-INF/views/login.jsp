<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
</head>
<body>
    ${message}
    <form id="fm" action="/login" method="post">
        用户名：<input type="text" name="userName"/><br>
        密码：<input id="pwd" type="password" name="password"/><br>
        <button type="button" id="btn">登录</button>
    </form>
    <script type="text/javascript" src="//cdn.bootcss.com/jquery/3.0.0/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/sha1.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#btn").click(function(){
                console.log("hehheheh");
                $("#pwd").val(CryptoJS.SHA1($("#pwd").val()));
                $("#fm").submit();
            });


        });
    </script>
</body>
</html>
