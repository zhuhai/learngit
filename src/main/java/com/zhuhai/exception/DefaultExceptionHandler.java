package com.zhuhai.exception;

import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/20
 * Time: 22:06
 */
@ControllerAdvice
public class DefaultExceptionHandler {

    /**
     * 无权限异常处理
     * @param e
     * @return
     */
    @ExceptionHandler(UnauthorizedException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public String processsUnAuthorizedException(UnauthorizedException e) {
        return "error/403";
    }

    /**
     * 全局异常处理
     * @param e
     * @return
     */
    /*@ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String processException(Exception e) {
        System.out.println(e.getMessage());
        if (e instanceof NullPointerException) {
            System.out.println("空指针异常");
        } else if (e instanceof NoHandlerFoundException) {
            System.out.println("404 NOT Found");
        } else if(e instanceof UnauthorizedException) {
            System.out.println("unauthorized");
        } else {
            System.out.println("runtime exception");
        }
        return "error";
    }*/

}
