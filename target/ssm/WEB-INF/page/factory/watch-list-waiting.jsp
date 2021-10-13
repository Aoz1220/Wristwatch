<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>待修理列表</title>
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
                            <label class="layui-form-label">持有者姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表品牌</label>
                            <div class="layui-input-inline">
                                <select name="brandId" lay-filter="brand" id="brand">
                                    <option value=""></option>
                                    <c:forEach items="${brandListAll}" var="brand">
                                        <option value="${brand.id}">${brand.brandName}</option>
                                    </c:forEach>
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

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="fix">维修</a>
        </script>

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
            url: '${basePath}/factory/watch/waiting/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print',{
                title:'导出模板',
                layEvent:'template',
                icon:'layui-icon-template-1'
            }],
            cols: [[
                {type: 'numbers', width: 130, title: '序号', sort: true},
                {title: '操作', width: 150, toolbar: '#currentTableBar', align: "center"},
                {field: 'watchname', width: 200, title: '腕表名称', align: "center"},
                {field: 'typename', width: 200, title: '维修类型', sort: true},
                {field: 'brandname', width: 200, title: '腕表品牌', sort: true},
                {field: 'fixprice', width: 200, title: '维修价格(元)'},
                {field: 'username', width: 200, title: '持有者姓名'}
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

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    'watchname':data.field.watchname,
                    'username':data.field.username,
                    'brandId':data.field.brandId
                }
            }, 'data');

            return false;
        });


        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'fix') {
                layer.confirm('确认进行维修', function (index) {
                    $.ajax({
                    	type:"post",
                    	url:"${basePath}/factory/watch/fix/start",
                    	data:{'watchId':data.id},
                    	dataType:"text",
                    	success:function(data){
                    		if(data=="ok"){
                    			layer.alert("开始维修!",function(){
                    				/* obj.del();//移除该行
                                     layer.closeAll();*/
                    				window.location.reload();
                    			});
                    		}else{
                    			layer.alert("无法开始维修!");
                    		}
                    	}	
                    });
                });
            }
        });

    });
</script>

</body>
</html>