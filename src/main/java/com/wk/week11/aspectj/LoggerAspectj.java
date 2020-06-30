package com.wk.week11.aspectj;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * @author Wangkun
 * @date 2020/6/23
 * @description
 **/
/*@Component*/
/*@Aspect //切面*/
public class LoggerAspectj {


    Logger logger = LogManager.getLogger(LoggerAspectj.class);

   /* //切入点
    @Pointcut("execution(* com.wk.week11.biz..*(..))")
    public void f(){}
*/



    //前置通知
   /* @Before("f()")*/
    public  void beforeLogger(JoinPoint joinPoint){

        logger.info("调用了"+joinPoint.getSignature().getName()+"方法");

    }

    //异常通知
    /*@AfterThrowing(value = "f()",throwing = "ex")*/
    public void afterThrowing(JoinPoint joinPoint,Exception ex){
            logger.error("你有一个异常请注意查收："+ex.getMessage());
    }

}
