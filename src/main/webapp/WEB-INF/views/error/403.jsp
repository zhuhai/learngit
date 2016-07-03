<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>错误页</title>
</head>
<body>
    对不起，你没有访问权限，3秒钟自动跳转到首页
    <script type="text/javascript">
        var scripts = [null,null];
        ace.load_ajax_scripts(scripts,function(){
            setTimeout(function(){
                window.location.href="/";
            },3000);
        });

    </script>

</body>
</html>
