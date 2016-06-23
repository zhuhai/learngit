package com.zhuhai.service.impl;

import com.zhuhai.entity.Resources;
import com.zhuhai.mapper.ResourcesMapper;
import com.zhuhai.service.ResourcesService;
import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/23
 * Time: 10:55
 */
@Service
public class ResourcesServiceImpl implements ResourcesService {

    @Resource
    private ResourcesMapper resourcesMapper;


    @Override
    public void createResource(Resources resources) {
        resourcesMapper.createResource(resources);
    }

    @Override
    public void updateResource(Resources resources) {
        resourcesMapper.updateResource(resources);
    }

    @Override
    public void deleteResource(long id) {
        resourcesMapper.deleteResource(id);
    }

    @Override
    public Resources findById(long id) {
        return resourcesMapper.findById(id);
    }

    @Override
    public List<Resources> findAll() {
        return resourcesMapper.findAll();
    }

    @Override
    public List<Resources> findMenus(Set<String> permissions) {
        List<Resources> allResources = findAll();
        List<Resources> menus = new ArrayList<Resources>();
        for (Resources resource : allResources) {
            if (resource.isRootNode()) {
                continue;
            }
            if (Resources.ResourceType.menu != (resource.getType())) {
                continue;
            }
            if (!hasPermission(permissions,resource)) {
                continue;
            }
            menus.add(resource);
        }
        return menus;
    }

    private boolean hasPermission(Set<String> permissions,Resources resources) {
        if (StringUtils.isEmpty(resources.getPermission())) {
            return true;
        }
        for (String permission : permissions) {
            WildcardPermission p1 = new WildcardPermission(permission);
            WildcardPermission p2 = new WildcardPermission(resources.getPermission());
            if (p1.implies(p2) || p2.implies(p1)) {
                return true;
            }
        }
        return false;
    }
}
