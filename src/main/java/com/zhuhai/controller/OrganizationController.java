package com.zhuhai.controller;

import com.zhuhai.dto.ResultJson;
import com.zhuhai.dto.TreeDTO;
import com.zhuhai.entity.Organization;
import com.zhuhai.service.OrganizationService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/7/5
 * Time: 11:05
 */
@Controller
@RequestMapping("/organization")
public class OrganizationController {

    @Resource
    private OrganizationService organizationService;

    @RequiresPermissions("organization:view")
    @RequestMapping(method = RequestMethod.GET)
    public String getOrganizationList(Model model) {
        List<Organization> organizationList = organizationService.findAll();
        model.addAttribute("organizationList",organizationList);
        return "organization/organizationList";
    }

    @RequiresPermissions("organization:view")
    @RequestMapping(value = "/load/list",method = RequestMethod.GET)
    @ResponseBody
    public String loadOrganizations(@RequestParam(value = "id",required = false,defaultValue = "0") long id) {
        String result = null;
        try {
            List<Organization> organizationList = organizationService.findChildOrganizations(id);
            List<TreeDTO> treeDTOList = new ArrayList<TreeDTO>();
            for (Organization organization : organizationList) {
                TreeDTO tree = new TreeDTO();
                tree.setId(organization.getId());
                tree.setpId(organization.getParentId());
                tree.setName(organization.getName());
                if (!CollectionUtils.isEmpty(organizationService.findChildOrganizations(organization.getId()))) {
                    tree.setIsParent(true);
                }
                treeDTOList.add(tree);
            }
            ObjectMapper objectMapper = new ObjectMapper();
            result = objectMapper.writeValueAsString(treeDTOList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public String updateOrganization(long id,String name) throws IOException {
       ResultJson<Organization> result;
        try {
            Organization organization = organizationService.findById(id);
            if (organization != null) {
                organization.setName(name);
                organizationService.updateOrganization(organization);
                result = new ResultJson<Organization>(true,"修改成功!");
            } else {
                result = new ResultJson<Organization>(false,"不存在该id的数据!");
            }
        } catch (Exception e) {
            result = new ResultJson<Organization>(false,"服务器异常!");
        }
        ObjectMapper objectMapper = new ObjectMapper();
        return  objectMapper.writeValueAsString(result);

    }
}
