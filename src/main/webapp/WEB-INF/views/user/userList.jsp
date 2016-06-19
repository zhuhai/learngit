<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                </tr>
            </c:forEach>
        </table>
    </div>

</body>
</html>

</body>
</html>
