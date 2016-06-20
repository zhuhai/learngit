package com.zhuhai.mapper;

import com.zhuhai.entity.Resource;

import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 11:19
 */
public interface ResourceMapper {

    public void createResource(Resource resource);

    public void updateResource(Resource resource);

    public void deleteResource(long id);

    public Resource findById(long id);

    public List<Resource> findAll();

    public Set<String> findPermissionsByIds(Long[] ids);
}
