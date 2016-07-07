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
                    <a id="delButton" role="button" class="btn btn-danger btn-sm no-border">锁定</a>
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
        </div><!-- /.col -->
    </div>

    <script type="text/javascript">
        var scripts = [null,'/static/js/common.js','/static/js/bootstrap-multiselect.js','/static/js/sha1.js',null];
        ace.load_ajax_scripts(scripts,function(){

            $(function(){
                var grid_selector = "#grid-table";
                var pager_selector = "#grid-pager";
                //resize to fit page size
                $(window).on('resize.jqGrid', function () {
                    $(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
                });
                //resize on sidebar collapse/expand
                var parent_column = $(grid_selector).closest('[class*="col-"]');
                $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
                    if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                        //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                        setTimeout(function() {
                            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                        }, 0);
                    }
                });
                $(grid_selector).jqGrid({
                    url:"/user/list",
                    datatype: "json",
                    mtype:"GET",
                    //height: 250,
                    colNames:['编号','用户名','部门','角色','是否锁定','创建时间'],
                    colModel:[
                        {
                            key:true,
                            name:'id',
                            index:'id',
                            width:40
                        },
                        {
                            name:'userName',
                            width:90,
                            sortable:false
                        },
                        {
                            name:'organization',
                            width:90,
                            sortable:false
                        },
                        {
                            name:'roleName',
                            width:90,
                            sortable:false
                        },
                        {
                            name:'locked',
                            width:90,
                            sortable:false,
                            formatter: function (cellvalue,options,rowObject) {
                                var screenValue = '';
                                switch (cellvalue) {
                                    case false:
                                        screenValue = '正常';
                                        break;
                                    case true:
                                        screenValue = '<span style="color:red">锁定</span>';
                                        break;
                                    default :
                                        screenValue = '正常';
                                }
                                return screenValue;
                            }
                        },
                        {
                            name:'createTime',
                            index:'create_time',
                            width:90,
                            sortable:true

                        }

                    ],
                    viewrecords : true,
                    rowNum:10,
                    rowList:[10,20,30],
                    pager : pager_selector,
                    altRows: true,
                    //第一个参数表示是否显示排序图标，第二个参数表示图标排序方式，vertical:垂直，horizontal：水平
                    //第三个参数指单击功 能，true：单击列可排序，false：单击图标排序。
                    viewsortcols:[true,'vertical',true],
                    multiselect: true,
                    multiselectWidth:30,
                    //multikey: "ctrlKey",
                    multiboxonly: true,
                    loadComplete : function() {
                        var table = this;
                        setTimeout(function(){
                            styleCheckbox(table);
                            updateActionIcons(table);
                            updatePagerIcons(table);
                            enableTooltips(table);
                        }, 0);
                    },

                    autowidth: true

                });
                //trigger window resize to make the grid get the correct size
                $(window).triggerHandler('resize.jqGrid');

                $("#editButton").click(function(){
                    var selr = $(grid_selector).jqGrid('getGridParam','selrow');
                    var rowData = $(grid_selector).jqGrid('getRowData',selr);
                    var name = $(grid_selector).jqGrid('getCell',selr,'userName');
                    console.log(selr);
                    console.log(rowData);
                    console.log(name);
                });


                $(".multiselect").multiselect({
                    enableFiltering: true,
                    buttonClass: 'btn btn-white btn-primary',
                    buttonWidth:'100%',
                    templates: {
                        button: '<button type="button" class="multiselect dropdown-toggle" data-toggle="dropdown"></button>',
                        ul: '<ul class="multiselect-container dropdown-menu"></ul>',
                        filter: '<li class="multiselect-item filter"><div class="input-group"><span class="input-group-addon"><i class="fa fa-search"></i></span><input class="form-control multiselect-search" type="text"></div></li>',
                        filterClearBtn: '<span class="input-group-btn"><button class="btn btn-default btn-white btn-grey multiselect-clear-filter" type="button"><i class="fa fa-times-circle red2"></i></button></span>',
                        li: '<li><a href="javascript:void(0);"><label></label></a></li>',
                        divider: '<li class="multiselect-item divider"></li>',
                        liGroup: '<li class="multiselect-item group"><label class="multiselect-group"></label></li>'
                    }
                });
                $("#submitAddButton").click(function(){
                    $("#createForm").submit();
                });
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
                        var password = CryptoJS.SHA1($("#password").val())+"";
                        var organizationId = $("#organizationId").val();
                        var roleIds = $("#roleIds").val().toString();
                        console.log(roleIds);
                        if(!roleIds) {
                            alertErrorNotice("请选择角色！");
                            return ;
                        }
                        $.ajax({
                            url:'/user/create',
                            type:'post',
                            data:{userName:userName,password:password,organizationId:organizationId,roleIds:roleIds},
                            dataType:'json',
                            success:function(result) {
                                if (result && result.success) {
                                    $("#create-user-modal").modal('hide');
                                    $(grid_selector).jqGrid().trigger("reloadGrid");
                                } else {
                                    alertErrorNotice(result.msg)
                                }
                            },
                            error:function() {
                                alertErrorNotice("系统异常，添加失败！");
                            }
                        });
                    }

                });

                //模态框关闭，清空表单内容
                $("#create-user-modal").on('hidden.bs.modal',function(){
                    $("#createForm")[0].reset();
                });

            });

        });

    </script>
</body>
</html>
