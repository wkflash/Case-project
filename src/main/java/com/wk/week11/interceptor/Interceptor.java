package com.wk.week11.interceptor;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @author Wangkun
 * @date 2020/6/26
 * @description
 **/

public class Interceptor implements HandlerInterceptor {
    Logger logger = LogManager.getLogger(Interceptor.class);
    //放行的请求
    String path="login.do&findUser.do&findUserEmail.do&checkPassword.do&regist.do";

    //请求执行前 进行运行;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (request.getSession().getAttribute("user")==null&&request.getSession().getAttribute("admin")==null){

            if (path.contains(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1))){
                return true;
            }else {
                response.sendRedirect("login.jsp");
                return false;
            }

        }else {
            return true;
        }
    }
/*
    //执行请求完毕,但是没有响应用户,进行运行;
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {


        modelAndView.setViewName("index_admin");

    }

    //响应用户的时候,Dispatcherservlet执行完
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {

        System.out.println("最终返回响应的时候");
    }*/
}
