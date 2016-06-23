<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主页</title>
</head>
<body>
    欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>
    <div>
        功能菜单<br/>
        <c:forEach items="${menus}" var="m">
            <a href="${pageContext.request.contextPath}${m.url}">${m.name}</a><br/>
        </c:forEach></div>

</body>
</html>