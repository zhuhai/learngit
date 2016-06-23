package com.zhuhai.service.impl;

import com.zhuhai.mapper.ResourcesMapper;
import com.zhuhai.mapper.RoleMapper;
import com.zhuhai.mapper.UserMapper;
import com.zhuhai.entity.User;
import com.zhuhai.service.UserService;
import com.zhuhai.utils.CommonUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private ResourcesMapper resourcesMapper;

    @Override
    public void saveUser(User user) {
        userMapper.createUser(user);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    @Override
    public void deleteUser(Long userId) {
        userMapper.deleteUser(userId);
    }

    @Override
    public User findUserById(Long userId) {
        return userMapper.findById(userId);
    }

    @Override
    public List<User> findAll() {
        return userMapper.findAll();
    }

    @Override
    public User findUserByUserName(String userName) {
        return userMapper.findByUserName(userName);
    }

    /**
     * 根据用户名获取角色id
     * @param userName
     * @return
     */
    @Override
    public Set<String> findRolesByUserName(String userName) {
        User user = userMapper.findByUserName(userName);
        if (user == null) {
            return Collections.EMPTY_SET;
        }
        String[] roleIds = user.getRoleIds().split(",");
        return roleMapper.findRolesByIds(CommonUtil.stringArray2LongArray(roleIds));
    }

    /**
     * 根据用户获取权限名称列表
     * @param userName
     * @return
     */
    @Override
    public Set<String> findPermissionsByUserName(String userName) {
        User user = userMapper.findByUserName(userName);
        if (user == null) {
            return Collections.EMPTY_SET;
        }
        String[] roleIds = user.getRoleIds().split(",");
        Set<String> resources = roleMapper.findResourceIdsByIds(CommonUtil.stringArray2LongArray(roleIds));
        Set<Long> resourceIdSet = new HashSet<Long>();
        for (String resource : resources) {
            String[] resourceIds = resource.split(",");
            for (String resourceId : resourceIds) {
                resourceIdSet.add(Long.valueOf(resourceId));
            }
        }
        return resourcesMapper.findPermissionsByIds(resourceIdSet.toArray(new Long[resourceIdSet.size()]));
    }

}
