<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加腕表</title>
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
        .layui-textarea{
            width:90%;
        }
        .layui-input-long{
            width:90%;
        }
        .star{
            color:red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label required">腕表名称<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <input type="text" name="watchname" lay-verify="required" lay-reqtext="腕表名称不能为空" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">维修类型<span class="star">*</span></label>
                        <div class="layui-input-inline">
                            <select name="type" lay-filter="type" lay-verify="required" lay-reqtext="维修类型不能为空">
                                <option value=""></option>
                                <c:forEach items="${typeList}" var="type">
                                    <option value="${type.id}">${type.typeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">腕表品牌<span class="star">*</span></label>
                        <div class="layui-input-inline">
                            <select name="brand" id="brand" lay-verify="required" lay-reqtext="腕表品牌不能为空">
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">总店获取方式<span class="star">*</span></label>
                <div class="layui-input-inline">
                    <select name="instore" id="instore" lay-verify="required" lay-reqtext="到店方式不能为空">
                        <option value=""></option>
                        <option value="快递寄出">快递寄出</option>
                        <option value="到店给出">到店给出</option>
                        <option value="上门获取">上门获取</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label required">持有者联系方式<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <input type="text" name="userTel" lay-verify="required|phone" lay-reqtext="持有者联系方式不能为空" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">持有者地址<span class="star">*</span></label>
                <div class="layui-input-block">
                    <input type="text" name="userAddress" lay-verify="required" lay-reqtext="持有者地址不能为空" autocomplete="off" class="layui-input layui-input-long">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="saveBtn">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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


        /*给腕表类型下拉框绑定change事件*/
        form.on('select(type)',function(data){
            //清空品牌下拉框
            $("#brand").html("<option value=''></option>");

            $.ajax({
                type:"get",
                url:"${basePath}/store/watch/list/brand.json",
                data:{'typeId':data.value},
                dataType:"json",
                success:function(data){
                    if(data!=null){
                        //初始化品牌下拉框
                        if(data.brands!=null && data.brands.length>0){
                            var brands=data.brands;
                            $.each(brands,function (index,item) {
                                $("#brand").append(new Option(item.brandName,item.id))
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
                url:"${basePath}/store/watch/save",
                data:{"watchname":data.field.watchname,"type":data.field.type,"brand":data.field.brand,"tel":data.field.userTel,"userAddress":data.field.userAddress},
                dataType:"text",
                success:function(data){
                    if(data=="ok"){
                        layer.alert("添加成功!",function(){
                            //刷新父页面
                            parent.window.location.reload();
                        });
                    }else if(data=="exist"){
                        var index=layer.alert("腕表已存在，请重新输入!",function(){
                            $("#watchname").focus();
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