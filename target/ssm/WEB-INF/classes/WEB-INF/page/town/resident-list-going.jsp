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
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="relieve">解除隔离</a>
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
            url: '${basePath}/town/resident/going/data.json',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print',{
                title:'导出模板',
                layEvent:'template',
                icon:'layui-icon-template-1'
            }],
            cols: [[
                {type: 'numbers', width: 80, title: '序号', sort: true},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"},
                {field: 'start_time',title: '开始时间', width: 200, sort:true,templet:'<div>{{layui.util.toDateString(d.start_time,"yyyy-MM-dd HH:mm:ss")}}</div>'},
                {title: '已隔离天数', width: 150, sort:true,templet:function(d){
                    return Math.ceil((new Date()-d.start_time)/1000/60/60/24)+"天";
                    }},
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
                {field: 'id_number', width: 200, title: '身份证号'},
                {field: 'region_name', width: 100, title: '所属区'},
                {field: 'town_name', width: 100, title: '镇（街道）'},
                {field: 'address', width: 200, title: '现居住地'},
                {field: 'tel', width: 120, title: '手机号码'},
                {field: 'is_central_isolation', width: 110, title: '集中隔离', sort: true,templet:function(d){if(d.is_central_isolation == 1){return '是'}else{return '否'}}},
                {field: 'is_home_isolation', width: 110, title: '居家隔离', sort: true,sort: true,templet:function(d){if(d.is_home_isolation == 1){return '是'}else{return '否'}}},
                {field: 'back_date', width: 120,title: '归淮日期',templet:'<div>{{layui.util.toDateString(d.back_date,"yyyy-MM-dd")}}</div>'},
                {width: 150, title: '关联省市区',templet:function(d){
                    return d.relation_province+" "+d.relation_community;
                    }},
                {width: 150, title: '关联镇社区',templet:function(d){
                        return d.relation_town+" "+d.relation_community;
                    }},
                {field: 'nuclein_check_time', width: 200, title: '核酸检测时间',templet:'<div>{{layui.util.toDateString(d.nuclein_check_time,"yyyy-MM-dd HH:mm:ss")}}</div>'},
                {field: 'nuclein_result', width: 120, title: '核酸检测结果',templet:function(d){
                    if(d.nuclein_result == 1){
                        return '阳'
                    }else if(d.nuclein_result == 0){
                        return '阴'
                    }else{return '无'}
                }}
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


        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'relieve') {
                layer.confirm('真的解除隔离么', function (index) {
                    $.ajax({
                    	type:"post",
                    	url:"${basePath}/town/isolation/home/end",
                    	data:{'residentId':data.id},
                    	dataType:"text",
                    	success:function(data){
                    		if(data=="ok"){
                    			layer.alert("解除隔离成功!",function(){
                    				 window.location.reload();
                    			});
                    		}else{
                    			layer.alert("解除隔离失败!");
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