<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>居民列表</title>
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
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">身份证号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="idNumber" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">镇街道</label>
                            <div class="layui-input-inline">
                                <select name="townName" lay-filter="town" id="town">
                                    <option value=""></option>
                                    <c:forEach items="${townListAll}" var="town">
                                        <option value="${town.townName}">${town.townName}</option>
                                    </c:forEach>
                                </select>
                                  <%-- <input type="text" name="townName" autocomplete="off" class="layui-input">--%>
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
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
                <button class="layui-btn layui-btn-sm " id="importExcel"> 批量导入 </button>
                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="pushTown"> 推送镇（街道） </button>
                <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="pushIsolation"> 推送隔离点 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
            upload=layui.upload;


        table.render({
            elem: '#currentTableId',
            url: '${basePath}/region/resident/list/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print',{
                title:'导出模板',
                layEvent:'template',
                icon:'layui-icon-template-1'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {field: 'isTownPush', width: 140, title: '推送镇（街道）',templet:function(d){if(d.isTownPush == 1){return '是'}else{return '否'}}},
                {field: 'isIsolationPush', width: 100, title: '推送隔离点',templet:function(d){if(d.isIsolationPush == 1){return '是'}else{return '否'}}},
                {field: 'status', width: 80, title: '状态', sort: true,templet:function(d){
                    if(d.status==0){
                        return '待处理';
                    }else if(d.status==1){
                        return '正常';
                    }else if(d.status==2){
                        return '待隔离';
                    }else if(d.status==3){
                        return '居家隔离中';
                    }else if(d.status==4){
                        return '解除居家隔离';
                    }else if(d.status==5){
                        return '集中隔离中';
                    }else if(d.status==6){
                        return '集中隔离解除';
                    }else if(d.status==7){
                        return '信息修正';
                    }
                    }},
                {field: 'type', width: 100, title: '健康码', sort: true,templet:function(d){
                    if(d.type==0){
                        return '绿码';
                    }else if(d.type==1){
                        return '黄码';
                    }else if(d.type==2){
                        return '红码';
                    }else if(d.type==3){
                        return '未知';
                    }
                    }},
                {field: 'name', width: 100, title: '姓名'},
                {field: 'gender', width: 80, title: '性别',templet:function(d){if(d.gender == 1){return '男'}else{return '女'}}},
                {field: 'age', width: 80, title: '年龄'},
                {field: 'idNumber', width: 200, title: '身份证号'},
                {field: 'regionName', width: 100, title: '所属区'},
                {field: 'townName', width: 100, title: '镇（街道）'},
                {field: 'address', width: 200, title: '现居住地'},
                {field: 'tel', width: 120, title: '手机号码'},
                {field: 'isCentralIsolation', width: 110, title: '集中隔离', sort: true},
                {field: 'isHomeIsolation', width: 110, title: '居家隔离', sort: true},
                {field: 'backDate', width: 120,title: '归淮日期',templet:'<div>{{layui.util.toDateString(d.backDate,"yyyy-MM-dd")}}</div>'},
                {field: 'backPcr', width: 150, title: '关联省市区'},
                {field: 'backTc', width: 150, title: '关联镇社区'},
                {field: 'nucleinCheckTime', width: 200, title: '核算检测时间',templet:'<div>{{layui.util.toDateString(d.backDate,"yyyy-MM-dd HH:mm:ss")}}</div>'},
                {field: 'nucleinResult', width: 120, title: '核算检测结果',templet:function(d){
                    if(d.nucleinResult == 1){
                        return '阳'
                    }else if(d.nucleinResult == 0){
                        return '阴'
                    }else{return '无'}
                }},
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
            },
            done:function(res,curr,count){
                upload.render({
                    elem:'#importExcel',//上传组件绑定的元素ID
                    size:10*1024,//最大上传文件，单位kb
                    accept:'file',//接收上传数据类型
                    field:'file',//上传数据变量名称
                    acceptMime: 'application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',//规定可以选择的文件类型
                    exts:'xls|xlsx',//允许上传的文件后缀名
                    url:'${basePath}/region/resident/import',//上传的服务器地址
                    before:function(){
                        layer.msg('上传中',{
                            icon:16,
                            shade:0.01
                        });
                    },
                    done:function(res){
                        layer.close(layer.index);//关闭loading
                        if(parseInt(res.code)==0){
                            layer.msg(/*"成功导入"+res.data+"条记录"*/res.msg,function(){
                                //重新加载表格
                                //table.reload();
                                window.location.reload();
                            });
                        }
                    },
                    error:function(){
                        layer.alert("导入失败,请检查模板及数据");
                    }
                })
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
                    'name':data.field.name,
                    'idNumber':data.field.idNumber,
                    'townName':data.field.townName
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
                    title: '添加居民',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['100%', '100%'],
                    content: '${basePath}/region/resident/add',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                //layer.alert(JSON.stringify(data));
                //拼接ID
               /*  var ids='';
                for(var i=0;i<data.length;i++){
                	if(i==data.length-1){
                		ids += data[i].id;
                	}else{
                		ids += data[i].id +",";
                	}
                } */

                /* $.ajax({
                	type:"get",
                	url:"{basePath}/customer/deleteAll",
                	data:{'ids':ids},
                	dataType:"text",
                	success:function(data){
                		if(data=="ok"){
                			layer.alert("删除成功!",function(){
                				 window.location.reload();
                			});
                		}else{
                			layer.alert("删除失败!",function(){
                				layer.closeAll();
                			});
                		}
                	}
                }); */


                //拼接数组ID
                var ids = [];
                for(var i=0;i<data.length;i++){
                	ids.push(data[i].id);
                }
                $.ajax({
                	type:"get",
                	url:"${basePath}/region/resident/deleteArray",
                	data:{'ids':ids},
                	dataType:"text",
                	traditional:true,//传递数组参数
                	success:function(data){
                		if(data=="ok"){
                			layer.alert("删除成功!",function(){
                				 window.location.reload();
                                //table.reload();
                			});
                		}else{
                			layer.alert("删除失败!",function(){
                				layer.closeAll();
                			});
                		}
                	}
                });
            }else if(obj.event==='template'){
                window.location.href='${basePath}/region/resident/template';
            }else if (obj.event === 'pushTown') {  // 监听推送镇（街道）操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                //拼接数组ID
                var ids = [];
                for(var i=0;i<data.length;i++){
                    ids.push(data[i].id);
                }
                if(ids.length==0){
                    layer.alert("请选择要推送的居民");
                    return;
                }
                layer.confirm("确定推送吗?",{btn:['确定','取消']},function(){
                    $.ajax({
                        type:"get",
                        url:"${basePath}/region/push/town",
                        data:{'ids':ids},
                        dataType:"json",
                        traditional:true,//传递数组参数
                        success:function(data){
                            if(data.code=="error"){
                                layer.alert("推送失败!",function(){
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
                },function(){})

            }else if (obj.event === 'pushIsolation') {  // 监听推送给隔离点
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                //拼接数组ID
                var ids = [];
                for(var i=0;i<data.length;i++){
                    ids.push(data[i].id);
                }
                if(ids.length==0){
                    layer.alert("请选择要推送的居民");
                    return;
                }
                layer.open({
                    title:'选择隔离点',
                    type:2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['30%', '50%'],
                    content:'${basePath}/region/isolation/select',
                    success:function(layero,index){
                        var body=layer.getChildFrame('body',index);//少了这个是不能从子页面传值的,获取子页面对象
                        body.contents().find("#ids").val(ids.toString());//JSON.stringify(ids)这个多了一个[]
                    }
                });

            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            //layer.alert(data.username)
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: false,
                    area: ['100%', '100%'],
                    content: '${basePath}/region/resident/edit/'+data.idNumber,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                    	type:"post",
                    	url:"${basePath}/region/resident/delete",
                    	data:{'id':data.id},
                    	dataType:"text",
                    	success:function(data){
                    		if(data=="ok"){
                    			layer.alert("删除成功!",function(){
                    				 obj.del();//移除该行
                                     layer.closeAll();
                    			});
                    		}else{
                    			layer.alert("删除失败!");
                    		}
                    	}	
                    });
                });
            }
        });

    });
</script>

</body>
</html>