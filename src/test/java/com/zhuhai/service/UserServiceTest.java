package com.zhuhai.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 15:19
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class UserServiceTest {
    @Resource
    private UserService userService;

    @Test
    public void testFindRolesByUserName(){
        String userName = "admin";
        Set<String> roles = userService.findRolesByUserName(userName);
        for (String role : roles) {
            System.out.println(role);
        }
    }

    @Test
    public void testFindPermissionByUserName() {
        String userName = "root";
        Set<String> permissions = userService.findPermissionsByUserName(userName);
        for (String permission : permissions) {
            System.out.println(permission);
        }
    }

}
