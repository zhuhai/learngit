package com.zhuhai.mapper;

import com.zhuhai.entity.Resources;

import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 11:19
 */
public interface ResourcesMapper {

    public void createResource(Resources resources);

    public void updateResource(Resources resources);

    public void deleteResource(long id);

    public Resources findById(long id);

    public List<Resources> findAll();

    public Set<String> findPermissionsByIds(Long[] ids);
}
