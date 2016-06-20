package com.zhuhai.dao;

import com.zhuhai.entity.Resource;
import com.zhuhai.mapper.ResourceMapper;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 13:33
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class ResourceMapperTest {

    @Autowired
    private ResourceMapper resourceMapper;

    @Test
    public void testFindAll() {
        List<Resource> list =  resourceMapper.findAll();
        for (Resource resource : list) {
            System.out.println(resource.getId());
            System.out.println(resource.getName());
            System.out.println(resource.getParentId());
        }
        Assert.assertNotNull(list);
    }

    @Test
    public void testFindByIds(){
        Set<String> sets =  resourceMapper.findPermissionsByIds(new Long[]{2l,3l,4l,5l,6l});
        for (String set : sets) {
            System.out.println(set);
        }
    }
}
