package com.zhuhai.controller;

import com.zhuhai.entity.User;
import com.zhuhai.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/17
 * Time: 21:46
 */
@Controller
@RequestMapping("/")
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    @Resource
    private UserService userService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home() {
        logger.info("首页");
        return "home";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm() {
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, HttpSession httpSession) {
        logger.info("登录用户名：{}", user.getUserName());
        logger.info("登录密码：{}", user.getPassword());
        httpSession.setAttribute("user",user);
        return "redirect:home";
    }

}
