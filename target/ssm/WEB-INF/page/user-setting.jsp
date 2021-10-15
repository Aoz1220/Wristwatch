<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
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
    <input id="roleId" value="<shiro:principal property="roleId"/>" type="hidden">
    <div class="layui-form-item">
        <label class="layui-form-label required">用户名称</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" lay-reqtext="用户名称不能为空" placeholder="请输入用户名称" value="<shiro:principal property="username"/>" class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item" >
        <label class="layui-form-label required">角色类型</label>
            <div class="layui-input-block">
                <input type="text" id="rolename" name="rolename"  class="layui-input" disabled="disabled">
            </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">手机号码</label>
        <div class="layui-input-block">
            <input type="text" name="tel" lay-verify="required|phone" placeholder="请输入手机号码" value="<shiro:principal property="tel"/>" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item" id="realnamearea" style="visibility: hidden">
        <label class="layui-form-label ">真实姓名</label>
        <div class="layui-input-block">
            <input type="text" id="realname" name="realname"   lay-verify="required" placeholder="请输入真实姓名" value="<shiro:principal property="realname"/>" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item" id="balancearea" style="visibility: hidden">
        <label class="layui-form-label ">所剩余额</label>
        <div class="layui-input-block">
            <input type="text" id="balance" name="balance"  value="<shiro:principal property="balance"/>" class="layui-input" disabled="disabled" >
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>
        </div>
    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;

        var s1 = document.getElementById("roleId");
        if(s1.value==1){
            document.getElementById("rolename").value="超级管理员";
        }else if(s1.value==2){
            document.getElementById("rolename").value="维修总店(客服)";
        }else if(s1.value==3){
            document.getElementById("rolename").value="维修工";
        }else if(s1.value==4){
            document.getElementById("rolename").value="客户";
            document.getElementById("realnamearea").style.visibility="visible"
            document.getElementById("balancearea").style.visibility="visible"
        }
        var s2=document.getElementById("balance");
        if(s2.value==""){
            document.getElementById("balance").value="0";
        }



        //监听提交
        form.on('submit(saveBtn)', function (data) {
            layer.confirm('确认保存吗', function (index) {
                $.ajax({
                    type:"get",
                    url:"${basePath}/manager/user/setting",
                    data:{"tel":data.field.tel,"realname":data.field.realname},
                    dataType:"text",
                    success:function(data){
                        if(data=="ok"){
                            layer.alert("修改成功，请重新登录",function(){
                                window.location = '${basePath}/logout';
                            });
                        }else{
                            layer.alert("修改失败!");
                        }
                    }
                });
                //很重要
                return false;
            });
        });
    });
</script>
</body>
</html>