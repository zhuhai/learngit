package com.zhuhai.service.impl;

import com.zhuhai.mapper.UserMapper;
import com.zhuhai.pojo.User;
import com.zhuhai.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/16
 * Time: 15:16
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public void saveUser(User user) {
        userMapper.createUser(user);
    }
}
