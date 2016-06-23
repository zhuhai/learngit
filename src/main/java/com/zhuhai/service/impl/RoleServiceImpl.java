package com.zhuhai.service.impl;

import com.zhuhai.entity.Role;
import com.zhuhai.mapper.RoleMapper;
import com.zhuhai.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/23
 * Time: 14:17
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Resource
    private RoleMapper roleMapper;


    @Override
    public void createRole(Role role) {
        roleMapper.createRole(role);
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateRole(role);
    }

    @Override
    public void deleteRole(long id) {
        roleMapper.deleteRole(id);
    }

    @Override
    public Role findById(long id) {
        return roleMapper.findById(id);
    }

    @Override
    public List<Role> findAll() {
        return roleMapper.findAll();
    }
}
