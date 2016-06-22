<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>添加用户</title>
</head>
<body>
  <div style="width:400px;margin: 100px auto">
    <form action="/user/create" method="post">
      用户名：<input type="text" name="userName"/><br/>
      密码：<input type="password" name="password"/><br/>
      部门：<select name="organizationId">
        <c:forEach items="${organizationList}" var="organization">
          <option value="${organization.id}">${organization.name}</option>
        </c:forEach>
      </select>
      <button type="submit">提交</button>
    </form>

  </div>

</body>
</html>
