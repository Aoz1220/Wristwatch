<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加居民</title>
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
                    <label class="layui-form-label required">姓名<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.name}"  name="name" lay-verify="required" lay-reqtext="姓名不能为空" autocomplete="off" class="layui-input">
                        <input type="hidden" name="id" value="${residentInfo.id}">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label"> 身份证号<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.idNumber}" name="IdNumber" id="IdNumber" lay-verify="required|identity" lay-reqtext="身份证号不能为空" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-inline">
                        <input type="radio" name="gender" value="1" title="男" <c:if test="${residentInfo.gender==1}">checked</c:if>>
                        <input type="radio" name="gender" value="0" title="女" <c:if test="${residentInfo.gender==0}">checked</c:if>>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">年龄</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.age}" name="age" <%--lay-verify="number"--%> autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label"> 手机号码<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.tel}" name="tel" lay-verify="required|phone" lay-reqtext="手机号码不能为空" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">行政区<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <select name="regionName" lay-filter="region" id="region" lay-verify="required" lay-reqtext="行政区不能为空">
                            <option value=""></option>
                            <c:forEach items="${regionList}" var="region">
                                <option value="${region.regionName}" <c:if test="${region.regionName eq residentInfo.regionName}">selected</c:if>>${region.regionName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">镇（街道）<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <select name="townName" lay-filter="town" id="town">
                            <option value="" ></option>
                            <c:forEach items="${townList}" var="town">
                                <option value="${town.townName}" <c:if test="${town.townName eq residentInfo.townName}">selected</c:if>>${town.townName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">现居住地<span class="star">*</span></label>
                <div class="layui-input-block">
                    <input type="text" value="${residentInfo.address}" name="address" lay-verify="required" lay-reqtext="现居住地不能为空" autocomplete="off" class="layui-input layui-input-long">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">健康码<span class="star">*</span></label>
                    <div class="layui-input-inline">
                        <select name="type" lay-verify="required" lay-reqtext="健康码不能为空">
                            <option value=""></option>
                            <option value="0" <c:if test="${residentInfo.type==0}">selected</c:if>>绿码</option>
                            <option value="1" <c:if test="${residentInfo.type==1}">selected</c:if>>黄码</option>
                            <option value="2" <c:if test="${residentInfo.type==2}">selected</c:if>>红码</option>
                            <option value="3" <c:if test="${residentInfo.type==3}">selected</c:if>>未知</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">归淮日期</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.backDate}" name="backDate" id="backDate" readonly <%--lay-verify="date"--%> placeholder="请选择日期" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">关联地址</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.relationProvince}" name="relationProvince" placeholder="关联省" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.relationCity}" name="relationCity" placeholder="关联市" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.relationRegion}" name="relationRegion" placeholder="关联区" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.relationTown}" name="relationTown" placeholder="关联镇（街道）" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.relationCommunity}" name="relationCommunity" placeholder="关联社区" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">在重点地区情况</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入在重点地区情况" name="keyAreaInfo" class="layui-textarea">${residentInfo.keyAreaInfo}</textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">核算检测时间</label>
                    <div class="layui-input-inline"><%--${layui.util.toDateString(residentInfo.nucleinCheckTime,"yyyy-MM-dd HH:mm:ss")}--%>
                        <input type="text" value="residentInfo.nucleinCheckTime" name="nucleinCheckTime" id="nucleinCheckTime" readonly <%--lay-verify="datetime"--%> placeholder="请选择时间" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">检测结果</label>
                    <div class="layui-inline">
                        <input type="radio" name="nucleinResult" value="0" title="阴" <c:if test="${residentInfo.nucleinResult==0}">checked</c:if>>
                        <input type="radio" name="nucleinResult" value="1" title="阳" <c:if test="${residentInfo.nucleinResult==1}">checked</c:if>>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">镇（街道）干部姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.townLeader}" name="townLeader"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">镇（街道）干部电话</label>
                    <div class="layui-input-inline">
                        <input type="number" value="${residentInfo.townPhone}" name="townPhone" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">村（社区）干部姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.communityLeader}" name="communityLeader"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">村（社区）干部电话</label>
                    <div class="layui-input-inline">
                        <input type="number" value="${residentInfo.communityPhone}" name="communityPhone" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">民警姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.policeName}" name="policeName" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">民警电话</label>
                    <div class="layui-input-inline">
                        <input type="number" value="${residentInfo.policePhone}" name="policePhone" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">医务工作者姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.doctorName}" name="doctorName"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">医务工作者电话</label>
                    <div class="layui-input-inline">
                        <input type="number" value="${residentInfo.doctorPhone}" name="doctorPhone"  autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">网格员姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${residentInfo.gridName}" name="gridName"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">网格员电话</label>
                    <div class="layui-input-inline">
                        <input type="number" value="${residentInfo.gridPhone}" name="gridPhone"  autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" name="remarks" class="layui-textarea">${residentInfo.remarks}</textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>
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

        //归淮日期选择器
        laydate.render({
            elem:'#backDate'
            ,type:'date'
        });

        //核算检测时间选择器
        laydate.render({
            elem:'#nucleinCheckTime'
            ,type:'datetime'
        })

        /*给行政区下拉框绑定change事件*/
        form.on('select(region)',function(data){
            //清空镇（街道）和隔离点的下拉选项
            $("#town").html("<option value=''></option>");

            $.ajax({
                type:"post",
                url:"${basePath}/region/resident/list/town.json",
                data:{'regionName':data.value},
                dataType:"json",
                success:function(data){
                    if(data!=null){
                        //初始化镇（街道下拉菜单）
                        if(data.towns!=null && data.towns.length>0){
                            var towns=data.towns;
                            $.each(towns,function (index,item) {
                                $("#town").append(new Option(item.townName,item.townName))
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
                url:"${basePath}/region/resident/update",
                data:data.field,
                dataType:"text",
                success:function(data){
                    if(data=="ok"){
                        layer.alert("修改成功!",function(){
                            //刷新父页面
                            parent.window.location.reload();
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
</script>
</body>
</html>