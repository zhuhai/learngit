<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
</head>
<body>

    欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>
    <shiro:hasPermission name="user:view">
        <a href="/user">查看用户列表</a>
    </shiro:hasPermission>
</body>
</html>