<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>添加用户</title>
</head>
<body>
  <div class="container">
    <form  id="createForm" class="form-horizontal">
      <div class="form-group">
        <label for="userName" class="col-xs-3 control-label">用户名</label>
        <div class="col-xs-7">
          <input type="text" id="userName" class="form-control" name="userName">
        </div>
      </div>
      <div class="form-group">
        <label for="password" class="col-xs-3 control-label">密码</label>
        <div class="col-xs-7">
          <input type="password" id="password" name="password" class="form-control">
        </div>
      </div>
      <button class="btn" type="submit">提交</button>
    </form>

  </div>
  <script type="text/javascript" src="/static/js/jquery-1.12.4.min.js"></script>
  <script type="text/javascript" src="/static/js/sha1.js"></script>
  <script src="/static/js/jquery.validate.min.js"></script>
  <script>
    $(function(){
      $("#createForm").validate({
        errorElement:'div',
        errorClass:'help-block',
        rules:{
          userName:{
            required:true
          },
          password:{
            required:true,
            rangelength:[6,18]
          },
          organizationId:{
            required:true
          },
          roleIds:{
            required:true
          }
        },
        messages:{
          userName:{
            required:'请输入用户名'
          },
          password:{
            required:'请输入密码',
            rangelength:'密码长度为6~18位'
          },
          organizationId:{
            required:'请选择部门'
          },
          roleIds:{
            required:'请选择角色'
          }

        },
        highlight:function(e){
          $(e).closest(".form-group").addClass("has-error");
        },
        success:function(e){
          $(e).closest(".form-group").removeClass("has-error");
          $(e).remove();
        },
        errorPlacement:function(error,element){
          console.log(element);
          if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
            var controls = element.closest('div[class*="col-"]');
            if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
            else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
          } else if(element.is('.select2')) {
            error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
          } else if(element.is('.chosen-select')) {
            error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
          } else {
            error.insertAfter(element.parent());
          }
        },
        submitHandler:function(form){
          var userName = $("#userName").val();
          var password = CryptoJS.SHA1($("#password").val());
          var organizationId = $("#organizationId").val();
          var roleIds = $("#roleIds").val();
          if(!roleIds) {
            alertErrorNotice("请选择角色！");
            return ;
          }

        }



      });
    });
  </script>
</body>
</html>
