package com.zhuhai.mapper;

import com.zhuhai.entity.Organization;

import java.util.List;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/19
 * Time: 12:44
 */
public interface OrganizationMapper {

    public void createOrganization(Organization organization);

    public void updateOrganization(Organization organization);

    public void deleteOrganization(Long id);

    public Organization findById(Long id);

    public List<Organization> findAll();
}
