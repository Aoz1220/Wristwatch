<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/layuimini.css?v=2.0.4.2" media="all">
    <link rel="stylesheet" href="${basePath}/css/themes/default.css" media="all">
    <link rel="stylesheet" href="${basePath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <form class="layui-form layui-form-pane" action="">
            <div class="layui-form layuimini-form">
                <div class="layui-form-item">
                    <label class="layui-form-label required">原密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="old_password" lay-verify="required" lay-reqtext="旧的密码不能为空" placeholder="请输入旧的密码"  value="" class="layui-input">

                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label required">新密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="new_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label required">新密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="again_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请再次输入新的密码"  value="" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">修改完成</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${basePath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','miniTab'], function () {
        var $ = layui.jquery,
            form = layui.form,
            layer = layui.layer,
            miniTab = layui.miniTab;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var old_password=data.field.old_password;
            var new_password=data.field.new_password;
            var again_password=data.field.again_password;
                $.ajax({
                    type:"get",
                    url:"${basePath}/passwordupdate",
                    data:{"oldpassword":data.field.old_password,"newpassword":data.field.new_password},
                    dataType:"text",
                    success:function (data) {
                        if(new_password!=again_password){
                            layer.alert("两次新密码输入不一致");
                        }else if(old_password==new_password){
                            layer.alert("新密码与旧密码不能相同");
                        }else if(data=="ok"){
                            layer.msg("修改成功，请重新登录",function () {
                                window.location = '${basePath}/logout';
                            });
                        }else if(data=="error"){
                            layer.alert("原密码错误，请重新输入");
                        }else if(data=="no"){
                            layer.alert("系统异常，联系管理员");
                        }
                    }
                })
                return false;
        });
    });
</script>
</body>
</html>