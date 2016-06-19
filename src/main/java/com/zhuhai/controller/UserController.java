package com.zhuhai.controller;

import com.zhuhai.entity.User;
import com.zhuhai.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public String getUserList(Model model) {
        model.addAttribute("userList",userService.findAll());
        return "/user/userList";
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String createUser(User user) {
        userService.saveUser(user);
        return "user/userList";
    }

    @RequestMapping(value = "/view/{id:\\d+}",method = RequestMethod.GET)
    public String viewUser(@PathVariable long id) {
        User user = userService.findUserById(id);
        logger.info("userName:{}",user.getUserName());
        return null;
    }
}
