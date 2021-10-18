<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>腕表修理系统</title>
    <meta name="keywords" content="layuimini,layui,layui模板,layui后台,后台模板,admin,admin模板,layui mini">
    <meta name="description" content="layuimini基于layui的轻量级前端后台管理框架，最简洁、易用的后台框架模板，面向所有层次的前后端程序,只需提供一个接口就直接初始化整个框架，无需复杂操作。">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="images/favicon.ico">
    <link rel="stylesheet" href="${basePath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}/css/layuimini.css?v=2.0.4.2" media="all">
    <link rel="stylesheet" href="${basePath}/css/themes/default.css" media="all">
    <link rel="stylesheet" href="${basePath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style id="layuimini-bg-color">

    </style>
    <style>
        .container { position:relative; }
        .container video {
            position:relative;
            z-index:0;
        }
        .overlay {
            position:absolute;
            top:20px;
            left:150px;
            z-index:1;
        }
        .overlay1 {
            position:absolute;
            top:60px;
            left:95px;
            z-index:1;
        }
    </style>
</head>
<body class="layui-layout-body layuimini-all">
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
        <div class="layui-logo layuimini-logo"></div>

        <div class="layuimini-header-content">
            <a>
                <div class="layuimini-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
            </a>

            <!--电脑端头部菜单-->
            <ul class="layui-nav layui-layout-left layuimini-header-menu layuimini-menu-header-pc layuimini-pc-show">
            </ul>

            <!--手机端头部菜单-->
            <ul class="layui-nav layui-layout-left layuimini-header-menu layuimini-mobile-show">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                    <dl class="layui-nav-child layuimini-menu-header-mobile">
                    </dl>
                </li>
            </ul>

            <ul class="layui-nav layui-layout-right">

                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" data-clear="清理" class="layuimini-clear"><i class="fa fa-trash-o"></i></a>
                </li>
                <li class="layui-nav-item mobile layui-hide-xs" lay-unselect>
                    <a href="javascript:;" data-check-screen="full"><i class="fa fa-arrows-alt"></i></a>
                </li>
                <li class="layui-nav-item layuimini-setting">
                    <input id="roleId" value="<shiro:principal property="roleId"/>" type="hidden" />
                    <a href="javascript:;"><shiro:principal property="username"/></a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="javascript:;" layuimini-content-href="${basePath}/usersetting" data-title="基本资料" data-icon="fa fa-gears">基本资料</span></a>
                        </dd>
                        <dd>
                            <a href="javascript:;" layuimini-content-href='${basePath}/editpassword' data-title="修改密码" data-icon="fa fa-gears">修改密码</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" id="chongzhi" layuimini-content-href='${basePath}/addbalance' data-title="充值" data-icon="fa fa-gears" style="visibility: hidden" >充值</a>
                        </dd>
                        <dd>
                            <hr>
                        </dd>
                        <dd>
                            <a href="${basePath}/logout;" class="login-out">退出登录</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item layuimini-select-bgcolor" lay-unselect>
                    <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
                </li>
            </ul>
        </div>
    </div>

    <!--无限极左侧菜单-->
    <div class="layui-side layui-bg-black layuimini-menu-left">
    </div>

    <!--初始化加载层-->
    <div class="layuimini-loader">
        <div class="layuimini-loader-inner"></div>
    </div>

    <!--手机端遮罩层-->
    <div class="layuimini-make"></div>

    <!-- 移动导航 -->
    <div class="layuimini-site-mobile"><i class="layui-icon"></i></div>

    <div class="layui-body">

        <div class="layuimini-tab layui-tab-rollTool layui-tab" lay-filter="layuiminiTab" lay-allowclose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" id="layuiminiHomeTabId" lay-id=""></li>
            </ul>
            <div class="layui-tab-control">
                <li class="layuimini-tab-roll-left layui-icon layui-icon-left"></li>
                <li class="layuimini-tab-roll-right layui-icon layui-icon-right"></li>
                <li class="layui-tab-tool layui-icon layui-icon-down">
                    <ul class="layui-nav close-box">
                        <li class="layui-nav-item">
                            <a href="javascript:;"><span class="layui-nav-more"></span></a>
                            <dl class="layui-nav-child">
                                <dd><a href="javascript:;" layuimini-tab-close="current">关 闭 当 前</a></dd>
                                <dd><a href="javascript:;" layuimini-tab-close="other">关 闭 其 他</a></dd>
                                <dd><a href="javascript:;" layuimini-tab-close="all">关 闭 全 部</a></dd>
                            </dl>
                        </li>
                    </ul>
                </li>
            </div>
            <div class="layui-tab-content">
                <div id="" class="layui-tab-item layui-show">
                    <div class="container">
                        <video id="video" controls src="images/index.mp4" style="width: 100%; height:100%; object-fit: fill" autoplay="autoplay">

                        </video>
                        <div  class="overlay">
                            <h1 style="color: white">欢迎使用</h1>
                        </div>
                        <div  class="overlay1">
                            <h1 style="color: white">雄鹰腕表修理系统</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="${basePath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${basePath}/js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    layui.use(['jquery', 'layer', 'miniAdmin','miniTongji'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniAdmin = layui.miniAdmin,
            miniTongji = layui.miniTongji;

            var s1 = document.getElementById("roleId");
            if(s1.value==4){
                document.getElementById("chongzhi").style.visibility="visible";
            }

        var options = {
            iniUrl: "${basePath}/menu.json",    // 初始化接口
            clearUrl: "${basePath}/api/clear.json", // 缓存清理接口
            urlHashLocation: true,      // 是否打开hash定位
            bgColorDefault: false,      // 主题默认配置
            multiModule: true,          // 是否开启多模块
            menuChildOpen: false,       // 是否默认展开菜单
            loadingTime: 0,             // 初始化加载时间
            pageAnim: true,             // iframe窗口动画
            maxTabNum: 20,              // 最大的tab打开数量
        };
        miniAdmin.render(options);

        // 百度统计代码，只统计指定域名
        miniTongji.render({
            specific: true,
            domains: [
                '99php.cn',
                'layuimini.99php.cn',
                'layuimini-onepage.99php.cn',
            ],
        });

        $('.login-out').on("click", function () {
            layer.msg('退出登录成功', function () {
                window.location = '${basePath}/page/login-3.html';
            });
        });
    });
</script>
</body>
</html>
