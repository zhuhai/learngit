<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>组织机构</title>
    <link rel="stylesheet" href="/static/css/zTree/zTreeStyle.css"/>
</head>
<body>
<div class="row">
    <div class="col-xs-12">
        <div class="col-xs-4">
            <div id="tree" class="ztree"></div>

        </div>
        <div class="col-xs-6">
            <form class="form-horizontal" role="form">
                <input type="hidden" value="" id="id_input"/>
                <input type="hidden" value="" id="parentIds_input"/>

                <div class="form-group">
                    <label for="name_input" class="col-sm-3 control-label">名称</label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="name_input" value=""/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-10">
                        <shiro:hasPermission name="organization:create">
                            <button type="button" class="btn btn-sm btn-primary no-border" id="add">添加子节点</button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="organization:update">
                            <button type="button" class="btn btn-sm btn-primary no-border" id="modify">修改</button>
                        </shiro:hasPermission>

                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
<script type="text/javascript">
    var scripts = [null, "/static/js/jquery.ztree.all.min.js", null];
    ace.load_ajax_scripts(scripts, function () {
        $(function () {
            var zNodes;
            var setting = {
                /*async:{
                 enable:true,
                 url:'/organization/load/list',
                 autoParam:['id'],
                 type:'GET'
                 },*/
                data: {
                    simpleData: {
                        enable: true,
                        idKey: "id",
                        pIdKey: "pId",
                        rootPId: 0
                    }
                },
                callback: {
                    onClick: function (event, treeId, treeNode) {
                        $("#name_input").val(treeNode.name);
                        $("#id_input").val(treeNode.id);
                        $("#parentIds_input").val(treeNode.parentIds);
                    }
                }
            };
            <c:if test="${organizationList != null && organizationList.size() > 0}">
            zNodes = [
                <c:forEach items="${organizationList}" var="organization">
                {
                    id:${organization.id},
                    pId:${organization.parentId},
                    name: "${organization.name}",
                    'parentIds': "${organization.parentIds}"
                },
                </c:forEach>
            ];
            </c:if>
            var zTreeObj = $.fn.zTree.init($("#tree"), setting, zNodes);
            zTreeObj.expandAll(true);

            $("#modify").click(function () {
                var nodes = zTreeObj.getSelectedNodes();
                if (nodes == null || nodes.length == 0) {
                    alertErrorNotice("请先选择左侧需要修改的数据!");
                } else if ($("#name_input").val().trim() == '') {
                    alertErrorNotice("名称不能为空!");
                } else {
                    var id = $("#id_input").val();
                    var name = $("#name_input").val();
                    $.ajax({
                        url:'/organization/update',
                        data:{id:id,name:name},
                        type:'POST',
                        dataType:'json',
                        success:function(result){
                            if (result && result.success) {
                                nodes[0].name = $("#name_input").val();
                                zTreeObj.updateNode(nodes[0]);
                                alertSuccessNotice(result.msg);
                            }else {
                                alertErrorNotice(result.msg);
                            }
                        },
                        error:function(){
                            alertErrorNotice("系统异常，修改失败！")
                        }

                    });
                }


            });

            function alertErrorNotice(msg) {
                $.gritter.add({
                    title: "系统提示",
                    text: msg,
                    class_name: "gritter-error gritter-center"
                });
            }

            function alertSuccessNotice(msg) {
                $.gritter.add({
                    title: "系统提示",
                    text: msg,
                    class_name: "gritter-info gritter-center"
                });
            }



        });
    });
</script>
</body>
</html>
