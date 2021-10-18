<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>维修订单列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="watchname" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表类型</label>
                            <div class="layui-input-inline">
                                <select name="typeId" lay-filter="type" id="type">
                                    <option value=""></option>
                                    <c:forEach items="${typeList}" var="type">
                                        <option value="${type.id}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">腕表品牌</label>
                            <div class="layui-input-inline">
                                <select name="brandId" lay-filter="brand" id="brand">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 下单 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="refund">申请退款</a>
        </script>

    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${basePath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script type="text/html" id="statusBtn">
    {{# if(d.status=='0'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-danger" style="cursor:default" disabled>等待总店接收</button>
    {{# } }}
    {{# if(d.status=='1'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-normal" style="cursor:default" disabled>等待总店审核</button>
    {{# } }}
    {{# if(d.status=='2'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-normal" style="cursor:default" disabled>审核完成</button>
    {{# } }}
    {{# if(d.status=='3'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="status">待付款</button>
    {{# } }}
    {{# if(d.status=='4'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>已拒绝</button>
    {{# } }}
    {{# if(d.status=='5'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>已付款</button>
    {{# } }}
    {{# if(d.status=='6'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>退款中</button>
    {{# } }}
    {{# if(d.status=='7'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>已退款</button>
    {{# } }}
    {{# if(d.status=='8'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>待维修</button>
    {{# } }}
    {{# if(d.status=='9'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>维修中</button>
    {{# } }}
    {{# if(d.status=='10'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>维修完成</button>
    {{# } }}
    {{# if(d.status=='11'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="status">待收货</button>
    {{# } }}
    {{# if(d.status=='12'){ }}
    <button class="layui-btn layui-btn-xs layui-btn-warm" style="cursor:default" disabled>订单完成</button>
    {{# } }}
</script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

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

        table.render({
            elem: '#currentTableId',
            url: '${basePath}/customer/order/list/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {field: 'watchname', width: 120, title: '腕表名称'},
                {field: 'typename', width: 120, title: '维修类型', sort: true},
                {field: 'brandname', width: 120, title: '腕表品牌', sort: true},
                {field: 'fixprice', width: 130, title: '维修价格(元)', sort: true,templet:function (d){
                        if (d.fixprice==null){
                            return '等待总店定价';
                        }else {
                            return d.fixprice;
                        }
                    }},
                {field: 'username', width: 100, title: '持有者姓名'},
                {field: 'useraddress', width: 160, title: '持有者地址'},
                {field: 'usertel', width: 150, title: '持有者联系方式'},
                {field:'status',width:200,title:'订单(维修)状态',align:"center",templet:"#statusBtn"},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20],
            limit: 5,
            page: true,
            skin: 'line',
            parseData :function(res){//将原始数据解析成table组件所规定的数据，res为从url中get到的数据
                var result;
                if(this.page.curr){
                    result=res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
                }else{
                    result=res.data.slice(0,this.limit);
                }
                return {
                    "code":res.code,//解析接口状态
                    "msg":res.msg,//解析提示文本
                    "count":res.count,//解析数据长度
                    "data": result//解析数据列表
                };
            }
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    'watchname':data.field.watchname,
                    'typeId':data.field.typeId,
                    'brandId':data.field.brandId
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作

                var index = layer.open({
                    title: '添加腕表维修订单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['40%', '70%'],
                    content: '${basePath}/store/watch/add',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });

        //监听表格复选框选择
        /*table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });*/

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            //layer.alert(data.watchname)
            if (obj.event === 'edit') {
                if(data.status==0 || data.status==1 ){
                    var index = layer.open({
                        title: '编辑腕表',
                        type: 2,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: false,
                        area: ['35%', '80%'],
                        content: '${basePath}/store/watch/edit/'+data.id,
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                    return false;
                }else{
                    layer.alert("腕表已完成审核或进入修理，不可编辑",function (){
                        window.location.reload();
                        layer.close(index);
                    })
                }
            } else if (obj.event === 'refund') {
                if(data.status==5){
                    var index = layer.open({
                        title: '申请退款',
                        type: 2,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: false,
                        area: ['35%', '80%'],
                        content: '${basePath}/store/watch/refundpage/'+data.id
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                    return false;
                }else if(data.status==0 || data.status==1 || data.status==2 || data.status==3 || data.status==4){
                    layer.alert("未完成付款，不得退款",function (){
                        window.location.reload();
                        layer.close(index);
                    })
                }else if(data.status==6 || data.status==7){
                    layer.alert("正在退款流程中，请勿重复进行退款",function (){
                        window.location.reload();
                        layer.close(index);
                    })
                }else{
                    layer.alert("腕表已经下放到修理厂进行修理，不可退款",function (){
                        window.location.reload();
                        layer.close(index);
                    })
                }
            }else if (obj.event==='status'){
                if (data.status=='3')
                {
                    layer.confirm("确认付款吗",function (index){
                        $.ajax({
                            type:"get",
                            url:"${basePath}/store/watch/pay",
                            data:{"id":data.id,"fixprice":data.fixprice},
                            dataType:"json",
                            success:function(data){
                                if(data.code=="error"){
                                    layer.alert("付款失败!",function(){
                                        layer.closeAll();
                                    });
                                }else if(data.code=="ok"){
                                    layer.alert(data.msg,function(){
                                        window.location.reload();
                                    });
                                }else if(data.code=="question"){
                                    layer.alert(data.msg,function(){
                                        window.location.reload();
                                    });
                                }
                            }
                        });
                    });

                }else if(data.status=='11'){
                    layer.confirm("确认收货吗",function (index){
                        $.ajax({
                            type:"get",
                            url:"${basePath}/customer/watch/receive",
                            data:{"id":data.id},
                            dataType:"text",
                            success:function(data){
                                if(data=="error"){
                                    layer.alert("收货失败!",function(){
                                        layer.closeAll();
                                    });
                                }else if(data=="ok"){
                                    layer.alert("收货成功!",function(){
                                        layer.closeAll();
                                        window.location.reload();
                                    });
                                }
                            }
                        });
                    })
                }
            }
        });

    });
</script>

</body>
</html>