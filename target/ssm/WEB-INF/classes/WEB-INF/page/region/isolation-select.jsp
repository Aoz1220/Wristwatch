<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>选择隔离点</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
        .layui-form-label{
            width: 140px;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">隔离点</label>
                    <div class="layui-input-inline">
                        <select name="isolationId" lay-filter="isolationId" lay-verify="required" lay-reqtext="隔离点不能为空">
                            <option value=""></option>
                            <c:forEach items="${list}" var="isolation">
                                <option value="${isolation.id}">${isolation.isolationName}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="ids" name="ids">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="saveBtn">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.jquery,
            laydate=layui.laydate;
        //监听提交
        form.on('submit(saveBtn)', function (data) {
           /* var stringIds=$("#ids").val();
            var ids=stringIds.split(",");
            var isolationId=data.field.isolationId;*/
            $.ajax({
                type:"post",
                url:"${basePath}/region/push/isolation",
                data:data.field/*{'ids':ids,'isolationId':isolationId}*/,
                dataType:"json",
                success:function(data){
                    if(data.code=="error"){
                        layer.alert("推送失败!",function(){
                            layer.closeAll();

                        });
                    }else if(data.code=="ok"){
                        layer.alert(data.msg,function(){
                            parent.window.location.reload();
                        });
                    }else if(data.code=="question"){
                        layer.alert(data.msg,function(){
                            parent.window.location.reload();
                        });
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