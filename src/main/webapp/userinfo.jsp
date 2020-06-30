<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2020/6/24
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body >
<div class="x-body">
    <form  class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>账号id
            </label>
            <div class="layui-input-inline">
                <label lay-verify="required" autocomplete="off" class="layui-input">${user.id}</label>
            </div>
        </div>

        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>用户昵称
            </label>
            <div class="layui-input-inline">
                <label lay-verify="required" autocomplete="off" class="layui-input">${user.name}</label>
            </div>
        </div>

        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <label lay-verify="required" autocomplete="off" class="layui-input">${user.email}</label>
            </div>
        </div>

        <div class="layui-form-item">
            <label  class="layui-form-label">
                <span class="x-red">*</span>头像
            </label>
            <div class="layui-input-inline">
                <img with="80px" height="80px" src="${user.image}" />
<%--                <button id="download" type="button" class="layui-icon-down">点击下载</button>--%>
                <a href="download.do?fileName=${fileName}" class="layui-icon-down">点击下载</a>
            </div>
        </div>

<%--        <div class="layui-form-item">--%>
<%--            <button  class="layui-btn" lay-submit="" lay-filter="add">增加</button>--%>
<%--        </div>--%>
    </form>
</div>

</body>

<script>
 /*   $(function () {
        $("#download").click(function () {
            var filePath=$("img").attr("src");
            var fileName=filePath.substr(filePath.lastIndexOf("\\")+1);
            console.info(fileName);
            $.ajax({
                url:"download.do",
                type:"post",
                data:{"fileName":fileName},
                success:function(mr) {

                }
            });

        });
    })*/
</script>

</html>