<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>客户列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
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
                            <label class="layui-form-label">客户名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">客户来源</label>
                            <div class="layui-input-inline">
                            	<select name="source" lay-filter="source">
	                				<option value=""></option>
	                				<c:forEach items="${sourceDict}" var="source">
	                					<option value="${source.id}">${source.name}</option>
	                				</c:forEach>
	          		 			</select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属行业</label>
                            <div class="layui-input-inline">
                                <select name="industry" lay-filter="industry">
					                <option value=""></option>
					                <c:forEach items="${industryDict}" var="source">
					                	<option value="${source.id}">${source.name}</option>
					                </c:forEach>
					            </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">客户级别</label>
                            <div class="layui-input-inline">
                                            <select name="level" lay-filter="level">
								                 <option value=""></option>
								                 <c:forEach items="${levelDict}" var="source">
								                	<option value="${source.id}">${source.name}</option>
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
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/customer/list/data',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50},
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {field: 'name', width: 200, title: '客户名称'},
                {field: 'source', width: 200, title: '客户来源'},
                {field: 'industry', width: 200, title: '所属行业'},
                {field: 'level', width: 200,title: '客户级别', sort: true},
                {field: 'phone', width: 200, title: '固定电话'},
                {field: 'mobile', width: 200, title: '移动电话'},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
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
                    'name':data.field.name,
                    'source':data.field.source,
                    'industry':data.field.industry,
                    'level':data.field.level
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
                    title: '添加客户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['40%', '90%'],
                    content: '${pageContext.request.contextPath}/customer/add',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                //layer.alert(JSON.stringify(data));
                //拼接ID
               /*  var ids='';
                for(var i=0;i<data.length;i++){
                	if(i==data.length-1){
                		ids += data[i].id;
                	}else{
                		ids += data[i].id +",";
                	}
                } */
                
                
                /* $.ajax({
                	type:"get",
                	url:"${pageContext.request.contextPath}/customer/deleteAll",
                	data:{'ids':ids},
                	dataType:"text",
                	success:function(data){
                		if(data=="ok"){
                			layer.alert("删除成功!",function(){
                				 window.location.reload();
                			});
                		}else{
                			layer.alert("删除失败!",function(){
                				layer.closeAll();
                			});
                		}
                	}	
                }); */
                
                
                //拼接数组ID
                var ids = [];
                for(var i=0;i<data.length;i++){
                	ids.push(data[i].id);
                }
                
                $.ajax({
                	type:"get",
                	url:"${pageContext.request.contextPath}/customer/deleteArray",
                	data:{'ids':ids},
                	dataType:"text",
                	traditional:true,//传递数组参数
                	success:function(data){
                		if(data=="ok"){
                			layer.alert("删除成功!",function(){
                				 window.location.reload();
                			});
                		}else{
                			layer.alert("删除失败!",function(){
                				layer.closeAll();
                			});
                		}
                	}	
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['40%', '90%'],
                    content: '${pageContext.request.contextPath}/customer/edit/'+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                    	type:"post",
                    	url:"${pageContext.request.contextPath}/customer/delete",
                    	data:{'id':data.id},
                    	dataType:"text",
                    	success:function(data){
                    		if(data=="ok"){
                    			layer.alert("删除成功!",function(){
                    				 obj.del();//移除该行
                                     layer.closeAll();
                    			});
                    		}else{
                    			layer.alert("删除失败!");
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