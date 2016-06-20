package com.zhuhai.mapper;

import com.zhuhai.entity.Role;

import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/19
 * Time: 0:34
 */
public interface RoleMapper {

    public void createRole(Role role);

    public void updateRole(Role role);

    public void deleteRole(long id);

    public Role findById(long id);

    public List<Role> findAll();

    public Set<String> findResourceIdsByIds(Long[] ids);

    public Set<String> findRolesByIds(Long[] ids);
}
