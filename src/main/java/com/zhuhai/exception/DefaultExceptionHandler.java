package com.zhuhai.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;

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
   /* @ExceptionHandler(UnauthorizedException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public String processsUnAuthorizedException(UnauthorizedException e) {
        return "redirect:/403";
    }*/

    /**
     * 全局异常处理
     * @param e
     * @return
     */
    /*@ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String processException(Exception e) {
        if (e instanceof NullPointerException) {
            return "error/500";
        } else if (e instanceof NoHandlerFoundException) {
            return "error/404";
        } else if(e instanceof UnauthorizedException) {
           return "redirect:/403";
        } else {
            return "error/500";
        }
    }*/

}
