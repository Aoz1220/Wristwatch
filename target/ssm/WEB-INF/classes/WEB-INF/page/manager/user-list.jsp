<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>账户列表</title>
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
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">行政区</label>
                            <div class="layui-input-inline">
                            	<select name="regionId" lay-filter="region" id="region">
	                				<option value=""></option>
	                				<c:forEach items="${regionList}" var="region">
	                					<option value="${region.id}">${region.regionName}</option>
	                				</c:forEach>
	          		 			</select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">镇街道</label>
                            <div class="layui-input-inline">
                                <select name="townId" lay-filter="town" id="town">
					                <option value=""></option>
					                <%--<c:forEach items="${townList}" var="town">
					                	<option value="${town.id}">${town.townName}</option>
					                </c:forEach>--%>
					            </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">隔离点</label>
                            <div class="layui-input-inline">
                                <select name="isolationId" lay-filter="isolation" id="isolation">
                                     <option value=""></option>
                                     <%--<c:forEach items="${isolationList}" var="isolation">
                                        <option value="${isolation.id}">${isolation.isolationName}</option>
                                     </c:forEach>--%>
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
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        /*给行政区下拉框绑定change事件*/
        form.on('select(region)',function(data){
            //清空镇（街道）和隔离点的下拉选项
            $("#town").html("<option value=''></option>");
            $("#isolation").html("<option value=''></option>");

            $.ajax({
                type:"get",
                url:"${basePath}/manager/user/list/townAndIsolation.json",
                data:{'regionId':data.value},
                dataType:"json",
                success:function(data){
                    if(data!=null){
                        //初始化镇（街道下拉菜单）
                        if(data.towns!=null && data.towns.length>0){
                            var towns=data.towns;
                            $.each(towns,function (index,item) {
                                $("#town").append(new Option(item.townName,item.id))
                            })
                        }
                        //初始化隔离点下拉菜单
                        if(data.isolations!=null && data.isolations.length>0){
                            var isolations=data.isolations;
                            $.each(isolations,function (index,item) {
                                $("#isolation").append(new Option(item.isolationName,item.id))
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
            url: '${basePath}/manager/user/list/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50},
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {field: 'username', width: 100, title: '用户名'},
                {field: 'realname', width: 100, title: '姓名'},
                {field: 'rolename', width: 100, title: '角色类型', sort: true},
                {field: 'regionname', width: 200, title: '行政区'},
                {field: 'townname', width: 150,title: '镇（街道）'},
                {field: 'isolationname', width: 200, title: '隔离点'},
                {field: 'tel', width: 120, title: '手机号码'},
                {title: '操作', minWidth: 80, toolbar: '#currentTableBar', align: "center"}
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
                    'username':data.field.username,
                    'regionId':data.field.regionId,
                    'townId':data.field.townId,
                    'isolationId':data.field.isolationId
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
                    title: '添加用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['40%', '70%'],
                    content: '${basePath}/manager/user/add',
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
                	url:"${basePath}/customer/deleteAll",
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
                	url:"${basePath}/manager/user/deleteArray",
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
            //layer.alert(data.username)
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['35%', '80%'],
                    content: '${basePath}/manager/user/edit/'+data.username,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                    	type:"post",
                    	url:"${basePath}/manager/user/delete",
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