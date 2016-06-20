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

    @ExceptionHandler(UnauthorizedException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public String processsUnAuthorizedException(UnauthorizedException e) {
        System.out.println("无权限-----------");
        return "home";
    }

}
