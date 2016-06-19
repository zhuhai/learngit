package com.zhuhai.dao;

import com.zhuhai.entity.Role;
import com.zhuhai.mapper.RoleMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/19
 * Time: 18:29
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class RoleMapperTest {
    @Resource
    private RoleMapper roleMapper;
    @Test
    public void findById(){
        long roleId = 1;
        Role role = roleMapper.findById(roleId);
        System.out.println(role.getRole());
        Assert.assertNotNull(role);
    }

}
