package com.zhuhai.controller;

import com.zhuhai.pojo.User;
import com.zhuhai.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/17
 * Time: 14:53
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String createUser() {
        User user = new User();
        user.setUserName("张三");
        user.setPassword("1234");
        userService.saveUser(user);
        return "userList";
    }
}
