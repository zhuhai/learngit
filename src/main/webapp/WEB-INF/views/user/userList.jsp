<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <link rel="stylesheet" href="/static/css/ui.jqgrid.css" />
    <link rel="stylesheet" href="/static/css/bootstrap-multiselect.css"/>
</head>
<body>
    <div class="search-header">
        <form id="queryForm">
            <table class="table-condensed">

            </table>
        </form>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="well well-sm">
                <shiro:hasPermission name="user:create">
                    <a id="addButton" role="button" class="btn btn-primary btn-sm no-border" data-toggle="modal" data-target="#create-user-modal">添加</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="user:update">
                    <a id="editButton" role="button" class="btn btn-purple btn-sm no-border" data-toggle="modal">修改</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="user:update">
                    <a id="lockButton" role="button" class="btn btn-pink btn-sm no-border">锁定</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="user:update">
                    <a id="unLockButton" role="button" class="btn btn-info btn-sm no-border">解锁</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="user:delete">
                    <a id="delButton" role="button" class="btn btn-danger btn-sm no-border">删除</a>
                </shiro:hasPermission>
            </div>
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
            <!-- Modal -->
            <div id="create-user-modal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <form  id="createForm" class="form-horizontal" action="#">
                        <div class="modal-content">
                            <div class="modal-header no-padding">
                                <div class="table-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        <span class="white">&times;</span>
                                    </button>
                                    <p>添加用户</p>
                                </div>
                            </div>
                            <div class="modal-body" style="max-height: 600px;overflow-y: scroll;">
                                <div class="container-fluid">
                                    <div class="form-group">
                                        <label for="userName" class="col-xs-12 col-sm-3 control-label">用户名</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <input type="text" id="userName" class="form-control" name="userName">
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="col-xs-12 col-sm-3 control-label">密码</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <input type="password" id="password" name="password" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="organizationId" class="col-xs-12 col-sm-3 control-label">部门</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <select class="form-control" name="organizationId" id="organizationId">
                                                    <option value="">请选择</option>
                                                    <c:forEach items="${organizationList}" var="organization">
                                                        <option value="${organization.id}">${organization.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="roleIds" class="col-xs-12 col-sm-3 control-label">角色</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <select class="form-control multiselect" name="roleIds" id="roleIds" multiple="multiple">
                                                    <c:forEach items="${roleList}" var="role">
                                                        <option value="${role.id}">${role.description}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer no-margin-top">
                                <div class="text-center">
                                    <button id="submitAddButton" type="button" class="btn btn-primary no-border">
                                        <i class="ace-icon fa fa-floppy-o bigger-125"></i>
                                        保存
                                    </button>
                                    <button class="btn btn-pink no-border" data-dismiss="modal">
                                        <i class="ace-icon fa fa-times bigger-125"></i>
                                        关闭
                                    </button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </form>
                </div><!-- /.modal-dialog -->
            </div>

            <div id="edit-user-modal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog">
                    <form  id="updateForm" class="form-horizontal" action="#">
                        <input type="hidden" id="userId">
                        <div class="modal-content">
                            <div class="modal-header no-padding">
                                <div class="table-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                        <span class="white">&times;</span>
                                    </button>
                                    <p>修改用户</p>
                                </div>
                            </div>
                            <div class="modal-body" style="max-height: 600px;overflow-y: scroll;">
                                <div class="container-fluid">
                                    <div class="form-group">
                                        <label for="name" class="col-xs-12 col-sm-3 control-label">用户名</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <input type="text" id="name" class="form-control" name="userName">
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="organizationId" class="col-xs-12 col-sm-3 control-label">部门</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <select class="form-control" name="organizationId" id="organization">
                                                    <option value="">请选择</option>
                                                    <c:forEach items="${organizationList}" var="organization">
                                                        <option value="${organization.id}">${organization.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="role" class="col-xs-12 col-sm-3 control-label">角色</label>
                                        <div class="col-xs-12 col-sm-7">
                                            <div class="clearfix">
                                                <select class="form-control multiselect" name="roleIds" id="role" multiple="multiple">
                                                    <c:forEach items="${roleList}" var="role">
                                                        <option value="${role.id}">${role.description}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer no-margin-top">
                                <div class="text-center">
                                    <button id="updateBtn" type="button" class="btn btn-primary no-border">
                                        <i class="ace-icon fa fa-floppy-o bigger-125"></i>
                                        修改
                                    </button>
                                    <button class="btn btn-pink no-border" data-dismiss="modal">
                                        <i class="ace-icon fa fa-times bigger-125"></i>
                                        关闭
                                    </button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </form>
                </div><!-- /.modal-dialog -->
            </div>
        </div><!-- /.col -->
    </div>

    <script type="text/javascript" src="/static/js/system/user.js"></script>
</body>
</html>
