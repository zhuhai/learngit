package com.zhuhai.controller;

import com.zhuhai.entity.User;
import com.zhuhai.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;

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
    public String login(User user, RedirectAttributes redirectAttributes) {
        try {
            SecurityUtils.getSubject().login(new UsernamePasswordToken(user.getUserName(),user.getPassword()));
            return "redirect:home";
        } catch (UnknownAccountException e) {
            redirectAttributes.addFlashAttribute("message",e.getMessage());
        } catch (LockedAccountException e) {
            redirectAttributes.addFlashAttribute("message",e.getMessage());
        } catch (AccountException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
        } catch (AuthenticationException e) {
            redirectAttributes.addFlashAttribute("message","系统异常");

        }
        return "redirect:login";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(){
        SecurityUtils.getSubject().logout();
        return "redirect:login";
    }

}
