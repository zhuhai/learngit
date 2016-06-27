package com.zhuhai.controller;

import com.zhuhai.entity.Resources;
import com.zhuhai.entity.User;
import com.zhuhai.service.ResourcesService;
import com.zhuhai.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

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
    @Resource
    private ResourcesService resourcesService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(Model model) {
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        Set<String> permissions = userService.findPermissionsByUserName(user.getUserName());
        List<Resources> menus = resourcesService.findMenus(permissions);
        model.addAttribute("menus",menus);
        model.addAttribute("user",user);
        return "home";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm() {

        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, boolean rememberMe,RedirectAttributes redirectAttributes) {
        try {
            logger.info("登录用户名：{}",user.getUserName());
            logger.info("登录密码：{}",user.getPassword());
            logger.info("记住我：{}",rememberMe);
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(),user.getPassword(),rememberMe);
            SecurityUtils.getSubject().login(token);
            return "redirect:home";
        } catch (UnknownAccountException e) {
            redirectAttributes.addFlashAttribute("message","用户名或密码错误");
        } catch (LockedAccountException e) {
            redirectAttributes.addFlashAttribute("message","用户被锁定");
        } catch (ExcessiveAttemptsException e) {
            redirectAttributes.addFlashAttribute("message","失败次数过多，账号被锁定，请10分钟后再试！");
        } catch (IncorrectCredentialsException e){
            redirectAttributes.addFlashAttribute("message","用户名或密码错误");
        } catch (AccountException e) {
            redirectAttributes.addFlashAttribute("message", "用户名或密码错误");
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
