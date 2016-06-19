package com.zhuhai.dao;

import com.zhuhai.entity.Organization;
import com.zhuhai.mapper.OrganizationMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/19
 * Time: 12:41
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class OrganizationMapperTest {

    @Resource
    private OrganizationMapper organizationMapper;

    @Test
    public void testFindById() {
        long id = 2;
        Organization organization = organizationMapper.findById(id);
        System.out.println(organization.getId());
        System.out.println(organization.getName());
        System.out.println(organization.getAvaliable());
        System.out.println(organization.isRootNode());
        Assert.assertNotNull(organization);
    }

    @Test
    public void testSaveOrganization(){
        Organization organization = new Organization();
        organization.setName("分公司12");
        organization.setParentId(2l);
        organization.setParentIds("0/1/");
        organization.setParentIds(organization.makeSelfAsParentIds());
        organization.setAvaliable(true);
        organizationMapper.createOrganization(organization);
    }
}
