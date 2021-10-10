<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">客户名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" lay-reqtext="客户名称不能为空" placeholder="请输入客户名称" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">客户来源</label>
        <div class="layui-input-block">
            <select name="source" lay-filter="source" lay-verify="required" lay-reqtext="客户来源不能为空">
                <option value=""></option>
                <c:forEach items="${sourceDict}" var="source">
                	<option value="${source.id}">${source.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required" >所属行业</label>
        <div class="layui-input-block">
            <select name="industry" lay-filter="industry" lay-verify="required" lay-reqtext="所属行业不能为空">
                <option value=""></option>
                <c:forEach items="${industryDict}" var="source">
                	<option value="${source.id}">${source.name}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required" >客户级别</label>
        <div class="layui-input-block">
            <select name="level" lay-filter="level" lay-verify="required" lay-reqtext="客户级别不能为空">
                 <option value=""></option>
                 <c:forEach items="${levelDict}" var="source">
                	<option value="${source.id}">${source.name}</option>
                 </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">联系人</label>
        <div class="layui-input-block">
            <input type="text" name="linkman" placeholder="请输入联系人" value="" class="layui-input" lay-verify="required" lay-reqtext="联系人不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">固定电话</label>
        <div class="layui-input-block">
            <input type="text" name="phone" placeholder="请输入固定电话" value="" class="layui-input" lay-verify="required" lay-reqtext="固定电话不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">移动电话</label>
        <div class="layui-input-block">
            <input type="number" name="mobile" placeholder="请输入移动电话" value="" class="layui-input" lay-verify="required" lay-reqtext="移动电话不能为空">
        </div>
    </div>    
    <div class="layui-form-item">
        <label class="layui-form-label required">邮政编码</label>
        <div class="layui-input-block">
            <input type="number" name="zipcode" placeholder="请输入邮政编码" value="" class="layui-input" lay-verify="required" lay-reqtext="邮政编码不能为空">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label required"> 联系地址</label>
        <div class="layui-input-block">
            <textarea name="address" class="layui-textarea" placeholder="请输入联系地址" lay-verify="required" lay-reqtext="联系地址不能为空"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            $.ajax({
            	type:"post",
            	url:"${pageContext.request.contextPath}/customer/save",
            	data:data.field,
            	dataType:"text",
            	success:function(data){
            		if(data=="ok"){
            			layer.alert("添加成功!",function(){
            				//刷新父页面
            				parent.window.location.reload();
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