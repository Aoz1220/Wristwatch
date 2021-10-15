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
            <label class="layui-form-label" style="width: 150px">申请退款理由</label>
            <div class="layui-input-block">
                <textarea name="refundReason" id="refundReason"   class="layui-textarea" disabled="disabled"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label required" style="width: 150px">原维修金额(元)<span class="star">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" name="fixprice" value="${watch.fixprice}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label required" style="width: 150px">退款金额(元)<span class="star">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" name="refundprice" lay-verify="required|number" lay-reqtext="退款金额不能为空" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <input  type="hidden" name="watchId" id="watchId" value="${watch.id}">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认退款</button>
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

        document.getElementById("refundReason").value="${orderHistory.refundReason}";


        //监听提交
        form.on('submit(saveBtn)', function (data) {
            layer.confirm('确认退款吗？', function (index) {
                $.ajax({
                    type:"post",
                    url:"${basePath}/store/watch/checkrefund",
                    data:data.field,
                    dataType:"json",
                    success:function(data){
                        if(data.code=="question"){
                            layer.alert("退款金额不能大于原维修金额",function(){
                                window.location.reload();
                                layer.close(index);
                            });
                        }else if(data.code=="error"){
                            layer.alert("退款失败!",function(){
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