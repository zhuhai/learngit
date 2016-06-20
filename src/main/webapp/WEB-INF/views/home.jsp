<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
</head>
<body>
    <shiro:guest>
        欢迎游客访问，<a href="${pageContext.request.contextPath}/login.jsp">登录</a>
    </shiro:guest>
    <shiro:user>
        欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>
    </shiro:user>
    <shiro:hasPermission name="user:create">
        <a href="/user">添加</a>
    </shiro:hasPermission>
</body>
</html>