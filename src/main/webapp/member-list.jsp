<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2020/6/24
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="css/font.css">
    <link rel="stylesheet" href="css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
<%--        <a href="">演示</a>--%>
<%--        <a><cite>导航元素</cite></a>--%>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
<%--    <div class="layui-row">--%>
<%--        <form class="layui-form layui-col-md12 x-so">--%>
<%--            <input class="layui-input" placeholder="开始日" name="start" id="start">--%>
<%--            <input class="layui-input" placeholder="截止日" name="end" id="end">--%>
<%--            <input type="text" name="username"  placeholder="请输入用户名" autocomplete="off" class="layui-input">--%>
<%--            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>--%>
<%--        </form>--%>
<%--    </div>--%>
    <xblock>
<%--        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>--%>
        <button class="layui-btn" onclick="x_admin_show('添加用户','./regist.jsp',600,400)"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">本页共有数据：${pageInfo.size} 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>ID</th>
            <th>头像</th>
            <th>用户名</th>
            <th>密码</th>
            <th>邮箱</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${userList}" var="ul">
        <tr>
            <td>
                <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
            </td>

            <td>${ul.id}</td>
            <td><img width="30" height="30" src="${ul.image}"></td>
            <td>${ul.name}</td>
            <td>${ul.password}</td>
            <td>${ul.email}</td>
            <td class="td-manage">
                <a title="编辑"  onclick="upd(${ul.id})"  href="javascript:void(0)">
                    <i class="layui-icon">&#xe642;</i>
                </a>
                <a title="编辑"  onclick="x_admin_show('编辑','upd2.do?id=${ul.id}',600,400)" href="javascript:;">
                    <i class="layui-icon">&#xe642;</i>
                </a>
                <a title="删除" onclick="member_del(this,${ul.id})" href="javascript:;">
                    <i class="layui-icon">&#xe640;</i>
                </a>
            </td>
        </tr>
        </c:forEach>

        </tbody>
    </table>
    <div class="page">

            <c:if test="${pageInfo.hasPreviousPage}">
                <a class="num" href="query.do?pageNum=${pageInfo.navigateFirstPage}&pageSize=4">首页</a>
                <a class="prev"  href="query.do?pageNum=${pageInfo.prePage}&pageSize=4">&lt;&lt;</a>
            </c:if>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pin">
                <a  href="query.do?pageNum=${pin}&pageSize=4">${pin}</a>
            </c:forEach>
            <c:if test="${pageInfo.hasNextPage}">
                <a class="next" href="query.do?pageNum=${pageInfo.nextPage}&pageSize=4">&gt;&gt;</a>
                <a class="num" href="query.do?pageNum=${pageInfo.navigateLastPage}&pageSize=4">尾页</a>
            </c:if>

    </div>

</div>

</body>

<script>
    //删除
    function member_del(obj,id) {
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                url:"del.do",
                type:"post",
                data:{"id":id},
                success:function (mr) {
                    if (mr.msg=="delSuccess"){
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!',{icon:1,time:1000});
                        // location.href="query.do";
                    }else{
                        layer.msg(mr.result,{icon:1,time:1000});
                        // alert(mr.result);
                    }
                }
            })
        });
    }

    //编辑
    function upd(id) {

        $.ajax({
            url:"upd.do",
            type:"post",
            data:{"id":id},
            success:function (mr) {
                if (mr.msg=="getOneUser"){
                    location.href="member-edit.jsp";
                }else{
                    alert(mr.result);
                }
            }
        })

    }
    /*    layui.use('laydate', function(){
            var laydate = layui.laydate;

            //执行一个laydate实例
            laydate.render({
                elem: '#start' //指定元素
            });

            //执行一个laydate实例
            laydate.render({
                elem: '#end' //指定元素
            });
        });*/

    /*
        /!*用户-删除*!/
        function member_del(obj,id){
            layer.confirm('确认要删除吗？',function(index){
                //发异步删除数据
                $(obj).parents("tr").remove();
                layer.msg('已删除!',{icon:1,time:1000});
            });
        }



        function delAll (argument) {

            var data = tableCheck.getData();

            layer.confirm('确认要删除吗？'+data,function(index){
                //捉到所有被选中的，发异步进行删除
                layer.msg('删除成功', {icon: 1});
                $(".layui-form-checked").not('.header').parents('tr').remove();
            });
        }*/
</script>

</html>
