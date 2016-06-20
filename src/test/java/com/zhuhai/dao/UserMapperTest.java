package com.zhuhai.dao;

import com.zhuhai.entity.User;
import com.zhuhai.mapper.UserMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 13:32
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class UserMapperTest {

    @Resource
    private UserMapper userMapper;

    @Test
    public void testFindBy() {
        String userName = "admin";
        User user = userMapper.findByUserName(userName);
        System.out.println(user.getId());
        System.out.println(user.getUserName());
        System.out.println(user.getUpdateTime());
        Assert.assertNotNull(user);

    }

}
