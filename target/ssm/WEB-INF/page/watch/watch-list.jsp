<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>腕表列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="watchname" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表类型</label>
                            <div class="layui-input-inline">
                                <select name="typeId" lay-filter="type" id="type">
                                    <option value=""></option>
                                    <c:forEach items="${typeList}" var="type">
                                        <option value="${type.id}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表品牌</label>
                            <div class="layui-input-inline">
                                <select name="brandId" lay-filter="brand" id="brand">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm " id="importExcel"> 批量导入 </button>
                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="pushTown"> 下发维修厂 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="refuse">拒绝维修</a>
        </script>

    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        /*给腕表类型下拉框绑定change事件*/
        form.on('select(type)',function(data){
            //清空品牌下拉框
            $("#brand").html("<option value=''></option>");

            $.ajax({
                type:"get",
                url:"${basePath}/store/watch/list/brand.json",
                data:{'typeId':data.value},
                dataType:"json",
                success:function(data){
                    if(data!=null){
                        //初始化品牌下拉框
                        if(data.brands!=null && data.brands.length>0){
                            var brands=data.brands;
                            $.each(brands,function (index,item) {
                                $("#brand").append(new Option(item.brandName,item.id))
                            })
                        }
                    }
                    //重新初始化select组件
                    form.render('select');
                }
            });
        });

        table.render({
            elem: '#currentTableId',
            url: '${basePath}/store/watch/list/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50},
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {field: 'watchname', width: 120, title: '腕表名称'},
                {field: 'typename', width: 120, title: '维修类型', sort: true},
                {field: 'brandname', width: 120, title: '腕表品牌', sort: true},
                {field: 'fixprice', width: 120, title: '维修价格(元)'},
                {field: 'status', width: 110, title: '维修状态', sort: true,templet:function(d){
                        if(d.status==0){
                            return '维修审核中';
                        }else if(d.status==1){
                            return '待维修';
                        }else if(d.status==2){
                            return '维修中';
                        }else if(d.status==3){
                            return '维修完成';
                        }else if(d.status==4){
                            return '已寄回';
                        }
                    }},
                {field: 'username', width: 100, title: '持有者姓名'},
                {field: 'useraddress', width: 160, title: '持有者地址'},
                {field: 'usertel', width: 150, title: '持有者联系方式'},
                {title: '操作', minWidth: 120, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20],
            limit: 5,
            page: true,
            skin: 'line',
            parseData :function(res){//将原始数据解析成table组件所规定的数据，res为从url中get到的数据
                var result;
                if(this.page.curr){
                    result=res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
                }else{
                    result=res.data.slice(0,this.limit);
                }
                return {
                    "code":res.code,//解析接口状态
                    "msg":res.msg,//解析提示文本
                    "count":res.count,//解析数据长度
                    "data": result//解析数据列表
                };
            }
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    'watchname':data.field.watchname,
                    'typeId':data.field.typeId,
                    'brandId':data.field.brandId
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加腕表',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['40%', '70%'],
                    content: '${basePath}/store/watch/add',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            //layer.alert(data.watchname)
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑腕表',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['35%', '80%'],
                    content: '${basePath}/store/watch/edit/'+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'refuse') {
                var index = layer.open({
                    title: '拒绝维修腕表',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['35%', '80%'],
                    content: '${basePath}/store/watch/refusepage/'+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });

    });
</script>

</body>
</html>