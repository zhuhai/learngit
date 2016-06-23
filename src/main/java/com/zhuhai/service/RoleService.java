package com.zhuhai.service;

import com.zhuhai.entity.Role;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 15:04
 */
public interface RoleService {

    public void createRole(Role role);

    public void updateRole(Role role);

    public void deleteRole(long id);

    public Role findById(long id);

    public List<Role> findAll();

}
