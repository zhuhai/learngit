package com.zhuhai.mapper;

import com.zhuhai.entity.Role;

import java.util.List;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/19
 * Time: 0:34
 */
public interface RoleMapper {

    public void createRole(Role role);

    public void updateRole(Role role);

    public void deleteRole(Long id);

    public Role findById(Long id);

    public List<Role> findAll();
}
