<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>资源列表</title>
  <link rel="stylesheet" href="/static/css/ui.jqgrid.css" />

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
            <div class="modal-dialog modal-lg">
                <form id="editForm">
                    <div class="modal-content">
                        <div class="modal-header no-padding">
                            <div class="table-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    <span class="white">&times;</span>
                                </button>
                                <p>添加用户</p>
                            </div>
                        </div>
                        <div class="modal-body" style="max-height: 500px;overflow-y: scroll;">


                        </div>

                        <div class="modal-footer no-margin-top">
                            <div class="text-center">

                                <button id="submitEditButton" type="button" class="btn btn-primary no-border">
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
            </div>

        </div><!-- /.modal-dialog -->
    </div>
    </div><!-- /.col -->
</div>

    <script type="text/javascript">
        var scripts = [null,null];
        ace.load_ajax_scripts(scripts,function(){

            $(function(){
                var grid_selector = "#grid-table";
                var pager_selector = "#grid-pager";
                //resize to fit page size
                $(window).on('resize.jqGrid', function () {
                    $(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width() );
                })
                //resize on sidebar collapse/expand
                var parent_column = $(grid_selector).closest('[class*="col-"]');
                $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
                    if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                        //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                        setTimeout(function() {
                            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                        }, 0);
                    }
                })

                jQuery(grid_selector).jqGrid({
                    url:"/user/list",
                    datatype: "json",
                    mtype:"POST",
                    height: 250,
                    colNames:['编号','用户名','部门','角色','是否锁定','创建时间'],
                    colModel:[
                        {
                            key:true,
                            name:'id',
                            index:'id',
                            width:60,
                            sorttype:"int"
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
                                        screenValue = '未锁定';
                                        break;
                                    case true:
                                        screenValue = '锁定';
                                        break;
                                    default :
                                        screenValue = '未锁定';
                                }
                                return screenValue;
                            }
                        },
                        {
                            name:'createTime',
                            index:'createTime',
                            width:90,
                            sorttype:"date"

                        }

                    ],
                    viewrecords : true,
                    rowNum:10,
                    rowList:[10,20,30],
                    pager : pager_selector,
                    altRows: true,
                    //toppager: true,

                    multiselect: true,
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

                //it causes some flicker when reloading or navigating grid
                //it may be possible to have some custom formatter to do this as the grid is being created to prevent this
                //or go back to default browser checkbox styles for the grid
                function styleCheckbox(table) {
                    /**
                     $(table).find('input:checkbox').addClass('ace')
                     .wrap('<label />')
                     .after('<span class="lbl align-top" />')


                     $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
                     .find('input.cbox[type=checkbox]').addClass('ace')
                     .wrap('<label />').after('<span class="lbl align-top" />');
                     */
                }


                //unlike navButtons icons, action icons in rows seem to be hard-coded
                //you can change them like this in here if you want
                function updateActionIcons(table) {
                    /**
                     var replacement =
                     {
                         'ui-icon-pencil' : 'icon-pencil blue',
                         'ui-icon-trash' : 'icon-trash red',
                         'ui-icon-disk' : 'icon-ok green',
                         'ui-icon-cancel' : 'icon-remove red'
                     };
                     $(table).find('.ui-pg-div span.ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
                     */
                }

                //replace icons with FontAwesome icons like above
                function updatePagerIcons(table) {
                    var replacement =
                    {
                        'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                        'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                        'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                        'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                    };
                    $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                        var icon = $(this);
                        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                        if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
                    })
                }

                function enableTooltips(table) {
                    $('.navtable .ui-pg-button').tooltip({container:'body'});
                    $(table).find('.ui-pg-div').tooltip({container:'body'});
                }

                //var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
            });
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        });

    </script>
</body>
</html>
