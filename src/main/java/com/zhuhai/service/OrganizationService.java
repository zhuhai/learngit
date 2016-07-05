package com.zhuhai.service;

import com.zhuhai.entity.Organization;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/22
 * Time: 17:33
 */
public interface OrganizationService {

    public void createOrganization(Organization organization);

    public void updateOrganization(Organization organization);

    public void deleteOrganization(long id);

    public Organization findById(long id);

    public List<Organization> findAll();

    public List<Organization> findChildOrganizations(long pid);
}
