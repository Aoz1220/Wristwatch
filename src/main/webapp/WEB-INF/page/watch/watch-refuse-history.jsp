<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>被拒绝订单记录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
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
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>


    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            upload=layui.upload;


        table.render({
            elem: '#currentTableId',
            url: '${basePath}/store/watch/refuse/history/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print',{
                title:'导出模板',
                layEvent:'template',
                icon:'layui-icon-template-1'
            }],
            cols: [[
                {type: 'numbers', width: 130, title: '序号', sort: true},
                {field: 'finishtime', width: 200,  title: '拒绝时间',sort: true,templet:'<div>{{ layui.util.toDateString(d.finishtime, "yyyy-MM-dd HH:mm:ss") }}</div>'},
                {field: 'watchname', width: 200, title: '腕表名称', align: "center"},
                {field: 'typename', width: 200, title: '维修类型', sort: true},
                {field: 'brandname', width: 200, title: '腕表品牌', sort: true},
                {field: 'refusereason', width: 250, title: '拒绝理由'},
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
            },
        });

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
    });
</script>

</body>
</html>