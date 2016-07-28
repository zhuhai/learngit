var scripts = [null,'/static/js/common.js','/static/js/bootstrap-multiselect.js','/static/js/sha1.js','/static/js/bootbox.min.js',null];
ace.load_ajax_scripts(scripts,function(){
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
        height: '300',
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

//添加用户
    $("#submitAddButton").click(function(){
        $("#createForm").submit();
    });

    $("#createForm").validate({
        errorElement:'div',
        errorClass:'help-block',
        //使多选框验证生效
        //ignore:':hidden:not(".multiselect")',
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
            var roleIds = $("#roleIds").val();
            if(!roleIds) {
                alertErrorNotice("请选择角色！");
                return;
            }
            $.ajax({
                url:'/user/create',
                type:'post',
                data:{userName:userName,password:password,organizationId:organizationId,roleIds:roleIds.toString()},
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
        $("#roleIds").multiselect('refresh');
    });

//修改用户
    $("#editButton").click(function(){
        $("#role").multiselect('deselectAll',false);
        $("#role").multiselect('updateButtonText');
        //var id = $(grid_selector).jqGrid('getGridParam','selrow');
        var userIds = $(grid_selector).jqGrid('getGridParam','selarrrow');
        if(userIds.length != 1){
            alertErrorNotice("请选择需要修改的一条数据！");
        }else{
            var rowData = $(grid_selector).jqGrid('getRowData',userIds);
            var organization = rowData.organization;
            var roleNames = rowData.roleName.split(",");
            $("#name").val(rowData.userName);
            $("#userId").val(rowData.id);
            $("#organization option").each(function(){
                if ($(this).text() == organization) {
                    $(this).attr('selected', true);
                }
            });
            for(var i=0;i<roleNames.length;i++){
                $("#role option").each(function(){
                    if($(this).text() == roleNames[i]) {
                        $("#role").multiselect('select',$(this).val());
                    }
                });
            }

            $("#edit-user-modal").modal('toggle');

        }

        //var name = $(grid_selector).jqGrid('getCell',id,'userName');

    });

    $("#updateBtn").click(function(){
        $("#updateForm").submit();
    });
    $("#updateForm").validate({
        errorElement:'div',
        errorClass:'help-block',
        rules:{
            userName:{
                required:true
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
            var userId = $("#userId").val();
            var userName = $("#name").val();
            var organizationId = $("#organization").val();
            var roleIds = $("#role").val();
            if(!roleIds){
                alertErrorNotice("请选择角色！");
                return;
            }
            $.ajax({
                url:'/user/'+userId+'/update',
                type:'post',
                dataType:'json',
                data:{userName:userName,organizationId:organizationId,roleIds:roleIds.toString()},
                success:function(result){
                    if(result && result.success){
                        $("#edit-user-modal").modal('hide');
                        $(grid_selector).jqGrid().trigger('reloadGrid');
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

    /**
     * 锁定用户
     */
    $("#lockButton").click(function(){
        var ids = $(grid_selector).jqGrid('getGridParam','selarrrow');
        if(ids.length == 0) {
            alertErrorNotice("请至少选择一条数据！");
        } else {
            bootbox.setLocale("zh_CN");
            bootbox.confirm('确定要锁定吗？',function(result){
                if (result) {
                    $.ajax({
                        url:'/user/lock',
                        type:'POST',
                        dataType:'json',
                        data:{ids:ids,lock:true},
                        success:function(result){
                            if (result && result.success) {
                                alertSuccessNotice(result.msg,1000);
                                $(grid_selector).jqGrid().trigger('reloadGrid');
                            }else{
                                alertErrorNotice(result.msg);
                            }
                        },
                        error:function(){
                            alertErrorNotice("系统异常，锁定失败！")
                        }
                    });
                }
            });

        }
    });

    /**
     * 解锁用户
     */
    $("#unLockButton").click(function(){
        var ids = $(grid_selector).jqGrid('getGridParam','selarrrow');
        if(ids.length == 0) {
            alertErrorNotice("请至少选择一条数据！");
        } else {
            $.ajax({
                url:'/user/lock',
                type:'POST',
                dataType:'json',
                data:{ids:ids,lock:false},
                success:function(result){
                    if (result && result.success) {
                        alertSuccessNotice(result.msg,1000);
                        $(grid_selector).jqGrid().trigger('reloadGrid');
                    }else{
                        alertErrorNotice(result.msg);
                    }
                },
                error:function(){
                    alertErrorNotice("系统异常，解锁失败！")
                }
            });
        }
    });


});
