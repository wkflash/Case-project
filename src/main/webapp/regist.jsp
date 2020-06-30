<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2020/6/24
  Time: 11:48
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

<body>
<div class="x-body layui-anim layui-anim-up">
    <form class="layui-form" action="regist.do" method="post" enctype="multipart/form-data">

        <div class="layui-form-item">
            <label for="L_username" class="layui-form-label">
                <span class="x-red">*</span>用户名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_username" name="name" required="" lay-verify="nikename"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>将会成为您唯一的登入名
            </div>
            <div class="layui-form-mid layui-word-aux">
                <label id="ulb" style="font-size: 5px"></label>
            </div>

        </div>
        <div class="layui-form-item">
            <label for="L_email" class="layui-form-label">
                <span class="x-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_email" name="email" required="" lay-verify="email"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <label id="elb" style="font-size: 5px"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <span class="x-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_pass" name="password" required="" lay-verify="pass"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                6到16个字符
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red">*</span>确认密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_repass" name="repass" required="" lay-verify="repass"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <label id="plb" style="font-size: 5px"></label>
            </div>

        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red">*</span>头像
            </label>
            <div class="layui-input-inline">
                <input type="file"  name="headImage" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button  class="layui-btn" lay-filter="add" lay-submit="">
                注册
            </button><label >${regist}</label>
        </div>

    </form>
</div>
<script>

    $(function(){
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
            var form = layui.form
                ,layer = layui.layer;
            //自定义验证规则
            form.verify({
                nikename: function(value){
                    if(value.length < 5){
                        return '昵称至少得5个字符啊';
                    }
                },
                pass: [/(.+){6,12}$/, '密码必须6到12位'],
                repass: function(value){
                    if($('#L_pass').val()!=$('#L_repass').val()){
                        return '两次密码不一致';
                    }
                }
            });

        $(":input[name='name']").focus(function(){
            $("#ulb").text("");
        });

        $(":input[name='email']").focus(function(){
            $("#elb").text("");
        });

        $(":input[name='rePassword']").focus(function(){
            $("#plb").text("");
        });

        //用户名唯一校验
        $(":input[name='name']").blur(function(){

            $.ajax({
                url:"findUser.do",
                data:{"name":$(this).val()},
                type:"post",
                success:function(obj){
                    if(obj.msg=="userExist"){
                        $("#ulb").text(obj.result);
                        $("#ulb").css({"color":"red"});
                    }else {
                        $("#ulb").text(obj.result);
                        $("#ulb").css({"color":"green"});
                    }
                }
            });
        });


        //邮箱唯一校验
        $(":input[name='email']").blur(function(){

            $.ajax({
                url:"findUserEmail.do",
                data:{"email":$(this).val()},
                type:"post",
                success:function(obj){
                    if(obj.msg=="emailExist"){
                        $("#elb").text(obj.result);
                        $("#elb").css({"color":"red"});
                    }else {
                        $("#elb").text(obj.result);
                        $("#elb").css({"color":"green"});
                    }
                }
            });
        });

        //密码确认
        $(":input[name='repass']").blur(function(){

            $.ajax({
                url:"checkPassword.do",
                data:{"repass":$(this).val(),"password":$(":input[name='password']").val()},
                type:"post",
                success:function(obj){
                    if(obj.msg=="passwordNotSame"){
                        $("#plb").text(obj.result);
                        $("#plb").css({"color":"red"});
                    }else{
                        $("#plb").text(obj.result);
                        $("#plb").css({"color":"green"});
                    }
                }
            });
        });

        });


    });

    // layui.use(['form','layer'], function(){
    //     $ = layui.jquery;
    //     var form = layui.form
    //         ,layer = layui.layer;
    //
    //     //自定义验证规则
    //     form.verify({
    //         nikename: function(value){
    //             if(value.length < 5){
    //                 return '昵称至少得5个字符啊';
    //             }
    //         }
    //         ,pass: [/(.+){6,12}$/, '密码必须6到12位']
    //         ,repass: function(value){
    //             if($('#L_pass').val()!=$('#L_repass').val()){
    //                 return '两次密码不一致';
    //             }
    //         }
    //     });
    //
    //     //监听提交
    //     form.on('submit(add)', function(data){
    //         console.log(data);
    //         //发异步，把数据提交给php
    //         layer.alert("增加成功", {icon: 6},function () {
    //             // 获得frame索引
    //             var index = parent.layer.getFrameIndex(window.name);
    //             //关闭当前frame
    //             parent.layer.close(index);
    //         });
    //         return false;
    //     });
    //
    //
    // });
</script>
</body>

</html>