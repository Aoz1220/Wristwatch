<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加用户</title>
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
    <div class="layui-form-item" id="demo1">
        <label class="layui-form-label required">角色类型</label>
        <div class="layui-input-block">
            <select name="roleId" lay-filter="role" lay-verify="required" lay-reqtext="角色类型不能为空">
                <option value=""></option>
                <c:forEach items="${roleList}" var="role">
                	<option value="${role.id}">${role.roleName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item" id="demo2" style="visibility: hidden">
        <label class="layui-form-label required">修理腕表类型</label>
        <div class="layui-input-block">
            <select name="typeId" lay-filter="type" lay-reqtext="修理类型不能为空">
                <option value=""></option>
                <c:forEach items="${typeList}" var="type">
                    <option value="${type.id}">${type.typeName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item" >
        <label class="layui-form-label required">手机号码</label>
        <div class="layui-input-block">
            <input type="text" name="tel" id="tel" lay-verify="required|phone" lay-reqtext="手机号码不能为空" placeholder="请输入手机号码" value="" class="layui-input" >
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

        /*给角色类型下拉框绑定change事件*/
        form.on('select(role)',function(data){
            var s1 = document.getElementsByName("roleId")[0];
            if(s1.value=="3"){
                document.getElementById("demo2").style.visibility="visible";
            }
            if(s1.value!="3"){
                document.getElementById("demo2").style.visibility="hidden";
            }
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