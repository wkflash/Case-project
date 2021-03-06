<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2020/6/24
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台登录-X-admin2.0</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">x-admin2.0-管理登录</div>
    <div id="darkbannerwrap"></div>

    <form  class="layui-form" >
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="button">
        <hr class="hr20" >
    </form>
</div>

<script>
    // $(function  () {
    //     layui.use('form', function(){
    //         var form = layui.form;
    //         // layer.msg('玩命卖萌中', function(){
    //         //   //关闭后的操作
    //         //   });
    //         //监听提交
    //         form.on('submit(login)', function(data){
    //             // alert(888)
    //             layer.msg(JSON.stringify(data.field),function(){
    //                 location.href='index.html'
    //             });
    //             return false;
    //         });
    //     });
    // })

    $(function () {
        $(":input[type='button']").click(function () {

            var name=$(":input[name='username']").val();
            var password=$(":input[name='password']").val();


            $.ajax({
                url:"login.do",
                type:"post",
                data:{"name":name,"password":password},
                success:function (obj) {
                    if (obj.msg=="index_user"){
                        location.href="index_user.jsp";
                    }else if(obj.msg=="index_admin"){
                        location.href="index_admin.jsp";
                    }else {
                        alert(obj.result);
                    }
                }
            })
        })
    })


</script>
</body>
</html>