package com.zhuhai.controller;

import com.zhuhai.dto.ResultJson;
import com.zhuhai.dto.TreeDTO;
import com.zhuhai.entity.Organization;
import com.zhuhai.service.OrganizationService;
import com.zhuhai.utils.Constant;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    private static final Logger logger = LoggerFactory.getLogger(OrganizationController.class);
    @Resource
    private OrganizationService organizationService;

    /**
     * 一次性加载树
     * @param model
     * @return
     */
    @RequiresPermissions("organization:view")
    @RequestMapping(method = RequestMethod.GET)
    public String getOrganizationList(Model model) {
        List<Organization> organizationList = organizationService.findAll();
        model.addAttribute("organizationList", organizationList);
        return "organization/organizationList";
    }

    /**
     * 异步加载树
     * @param id
     * @return
     */
    @RequiresPermissions("organization:view")
    @RequestMapping(value = "/load/list", method = RequestMethod.GET)
    @ResponseBody
    public List<TreeDTO> loadOrganizations(@RequestParam(value = "id", required = false, defaultValue = "0") long id) {
        List<TreeDTO> treeDTOList = null;
        try {
            List<Organization> organizationList = organizationService.findChildOrganizations(id);
            treeDTOList = new ArrayList<TreeDTO>();
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

        } catch (Exception e) {
            e.printStackTrace();
        }
        return treeDTOList;
    }

    /**
     * 修改organization
     * @param id
     * @param name
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public ResultJson<Organization> updateOrganization(long id, String name) throws IOException {
        ResultJson<Organization> result;
        try {
            Organization organization = organizationService.findById(id);
            if (organization != null) {
                organization.setName(name);
                organizationService.updateOrganization(organization);
                result = new ResultJson<Organization>(true, Constant.UPDATE_SUCCESS);
            } else {
                result = new ResultJson<Organization>(false, Constant.DATA_ERROR);
            }
        } catch (Exception e) {
            logger.error("update organization error", e);
            result = new ResultJson<Organization>(false, Constant.SYSTEM_ERROR);
        }

        return result;

    }
}
