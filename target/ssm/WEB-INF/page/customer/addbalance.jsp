<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>客户充值</title>
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
                    <label class="layui-form-label required" style="width: 200px">充值金额（元）<=10000</label>
                    <div class="layui-input-inline">
                        <input type="text" name="money" id="money" lay-verify="required|number" lay-reqtext="充值金额不能为空" placeholder="请输入充值金额"  class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label required" style="width: 200px">充值密码</label>
                    <div class="layui-input-inline">
                        <input type="password" name="balancepassword" lay-verify="required" lay-reqtext="充值密码不能为空" placeholder="请输入充值密码"  class="layui-input">
                        <label value="单次充值不能超过10000元"></label>
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">充值</button>
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
            var balancepassword=data.field.balancepassword;
            var money=parseInt(data.field.money);
            $.ajax({
                type:"get",
                url:"${basePath}/balanceupdate",
                data:{"money":money},
                dataType:"json",
                success:function (data) {
                    if(data.code=="question"){
                        layer.alert("单次充值数额不能超过10000元");
                    } else if(balancepassword!="123"){
                        layer.alert("充值密码错误");
                    }else if(data.code=="ok"){
                        layer.alert(data.msg,function(){
                            layer.closeAll();
                        });
                    }else if(data.code=="error"){
                        layer.alert("系统异常，请联系管理员");
                    }
                }
            })
            return false;
        });

    });
</script>
</body>
</html>