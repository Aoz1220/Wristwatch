<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>申请退款</title>
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
    <form class="layui-form" action="">
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">申请退款理由*</label>
            <div class="layui-input-block">

                <textarea name="refundreason" id="refundreason" placeholder="请输入退款理由" lay-verify="required" lay-reqtext="拒绝理由不能为空" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <input  type="hidden" name="watchId" id="watchId" value="${watch.id}">
                <input  type="hidden" name="fixprice" value="${watch.fixprice}">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认申请退款</button>
            </div>
        </div>
    </form>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;


        //监听提交
        form.on('submit(saveBtn)', function (data) {
            layer.confirm('真的退款吗？', function (index) {
                $.ajax({
                    type:"post",
                    url:"${basePath}/store/watch/startrefund",
                    data:data.field,
                    dataType:"json",
                    success:function(data){
                        if(data.code=="error"){
                            layer.alert("退款申请提交失败!",function(){
                                window.location.reload();
                                layer.close(index);
                            });
                        }else if(data.code=="ok"){
                            layer.alert(data.msg,function(){
                                parent.window.location.reload();
                            });
                        }
                    }
                });
            });
            //很重要
            return false;
        });

    });
</script>
</body>
</html>