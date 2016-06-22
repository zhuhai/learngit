package com.zhuhai.service.impl;

import com.zhuhai.entity.Organization;
import com.zhuhai.mapper.OrganizationMapper;
import com.zhuhai.service.OrganizationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/22
 * Time: 17:34
 */
@Service
public class OrganizationServiceImpl implements OrganizationService {
    @Resource
    private OrganizationMapper organizationMapper;

    @Override
    public List<Organization> findAll() {
        return organizationMapper.findAll();
    }
}
