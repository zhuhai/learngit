package com.zhuhai.service;

import com.zhuhai.entity.User;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/16
 * Time: 15:15
 */
public interface UserService {

    public void saveUser(User user);
    public void updateUser(User user);
    public void deleteUser(Long userId);
    public User findUserById(Long userId);
    public List<User> findAll();
    public User findUserByUserName(String userName);
}
