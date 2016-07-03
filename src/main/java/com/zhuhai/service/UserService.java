package com.zhuhai.service;

import com.github.pagehelper.PageInfo;
import com.zhuhai.entity.User;

import java.util.Set;

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
    public PageInfo<User> findAll(String sidx, String sord, Integer pageNo, Integer pageSize);
    public User findUserByUserName(String userName);
    public Set<String> findRolesByUserName(String userName);
    public Set<String> findPermissionsByUserName(String userName);
}
