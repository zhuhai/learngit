<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
</head>
<body>
    ${message}
    <form action="/login" method="post">
        用户名：<input type="text" name="userName"/><br>
        密码：<input type="password" name="password"/><br>
        <button type="submit">登录</button>
    </form>

</body>
</html>
