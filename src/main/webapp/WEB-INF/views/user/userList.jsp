<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>用户列表</title>
</head>
<body>
    <div>
        <table>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.userName}</td>
                    <td>${user.roleIds}</td>
                    <shiro:hasPermission name="user:update">
                        <td><a href="/user/${user.id}/update">修改</a></td>
                    </shiro:hasPermission>
                </tr>
            </c:forEach>
        </table>
        <shiro:hasPermission name="user:create">
            <a href="/user/create">添加用户</a>
        </shiro:hasPermission>
    </div>

    <script type="text/javascript">
        window.onload = function () {
            var message = '${message}';
            if(message) {
                alert(message);
            }
        }
    </script>
</body>
</html>
