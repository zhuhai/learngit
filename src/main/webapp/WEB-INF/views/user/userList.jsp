<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>用户列表</title>
  <link rel="stylesheet" href="/static/assets/css/bootstrap.min.css" />
  <link rel="stylesheet" href="/static/assets/css/font-awesome.min.css" />
  <link rel="stylesheet" href="/static/assets/css/datepicker.css" />
  <link rel="stylesheet" href="/static/assets/css/ui.jqgrid.css" />
  <link rel="stylesheet" href="/static/assets/css/ace.min.css" />
  <link rel="stylesheet" href="/static/assets/css/ace-rtl.min.css" />
  <link rel="stylesheet" href="/static/assets/css/ace-skins.min.css" />
    <style>
        html{
            overflow-x: hidden;
        }
    </style>
</head>
<body style="background-color: transparent">
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
                <a id="addButton" role="button" class="btn btn-primary btn-sm no-border" data-toggle="modal">添加</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="user:update">
                <a id="editButton" role="button" class="btn btn-purple btn-sm no-border" data-toggle="modal">修改</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="user:delete">
                <a id="delButton" role="button" class="btn btn-danger btn-sm no-border">删除</a>
            </shiro:hasPermission>

        </div>
        <table id="grid-table"></table>
        <div id="grid-pager"></div>
    </div><!-- /.col -->
</div>
    <script src="/static/assets/js/jquery.min.js"></script>
    <script src="/static/assets/js/bootstrap.min.js"></script>
    <script src="/static/assets/js/typeahead-bs2.min.js"></script>

    <!-- page specific plugin scripts -->

    <script src="/static/assets/js/date-time/bootstrap-datepicker.min.js"></script>
    <script src="/static/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
    <script src="/static/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript">
        jQuery(function($) {
            var grid_selector = "#grid-table";
            var pager_selector = "#grid-pager";

            jQuery(grid_selector).jqGrid({
                url:"/user/list",
                datatype: "json",
                mtype:"POST",
                height: 250,
                colNames:['编号','用户名','部门','角色','创建时间'],
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
    </script>
</body>
</html>
