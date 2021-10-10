<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="username" id="username" lay-verify="required" lay-reqtext="用户名不能为空" placeholder="请输入用户名" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">角色</label>
        <div class="layui-input-block">
            <select name="roleId" lay-filter="role" lay-verify="required" lay-reqtext="角色不能为空">
                <option value=""></option>
                <c:forEach items="${roleList}" var="role">
                	<option value="${role.id}">${role.roleName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required" >行政区</label>
        <div class="layui-input-block">
            <select name="regionId" lay-filter="region" lay-verify="required" lay-reqtext="行政区不能为空">
                <option value=""></option>
                <c:forEach items="${regionList}" var="region">
                	<option value="${region.id}">${region.regionName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label " >镇（街道）</label>
        <div class="layui-input-block">
            <select name="townId" lay-filter="town" id="town">
                 <option value=""></option>
                 <%--<c:forEach items="${townList}" var="town">
                	<option value="${town.id}">${town.townName}</option>
                 </c:forEach>--%>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label " >隔离点</label>
        <div class="layui-input-block">
            <select name="isolationId" lay-filter="isolation" id="isolation" >
                <option value=""></option>
                <%--<c:forEach items="${isolationList}" var="isolation">
                    <option value="${isolation.id}">${isolation.isolationName}</option>
                </c:forEach>--%>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;

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



        //监听提交
        form.on('submit(saveBtn)', function (data) {
            $.ajax({
            	type:"post",
            	url:"${basePath}/manager/user/save",
            	data:data.field,
            	dataType:"text",
            	success:function(data){
            		if(data=="ok"){
            			layer.alert("添加成功!",function(){
            				//刷新父页面
            				parent.window.location.reload();
            			});
            		}else if(data=="exist"){
                            var index=layer.alert("用户名已存在，请重新输入!",function(){
                            $("#username").focus();
                            layer.close(index);
                        });

                    }else{
            			layer.alert("添加失败!");
            		}
            	}	
            });
        	//很重要
            return false;
        });

    });
</script>
</body>
</html>