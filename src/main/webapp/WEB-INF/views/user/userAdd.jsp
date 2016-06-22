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
    <form id="fm" action="/user/create" method="post">
      用户名：<input type="text" name="userName"/><br/>
      密码：<input id="pwd" type="password" name="password"/><br/>
      部门：<select name="organizationId">
        <c:forEach items="${organizationList}" var="organization">
          <option value="${organization.id}">${organization.name}</option>
        </c:forEach>
      </select><br/>
      <button type="button" id="btn">提交</button>
    </form>

  </div>
  <script type="text/javascript" src="/static/js/jquery-3.0.0.min.js"></script>
  <script type="text/javascript" src="/static/js/sha1.js"></script>
  <script>
    $(function(){
      $("#btn").click(function(){
        $("#pwd").val(CryptoJS.SHA1($("#pwd").val()));
        $("#fm").submit();
      });
    });
  </script>
</body>
</html>
