package com.zhuhai.controller;

import com.github.pagehelper.PageInfo;
import com.zhuhai.dto.JqGridView;
import com.zhuhai.dto.ResultJson;
import com.zhuhai.dto.UserDTO;
import com.zhuhai.entity.Organization;
import com.zhuhai.entity.Role;
import com.zhuhai.entity.User;
import com.zhuhai.service.OrganizationService;
import com.zhuhai.service.RoleService;
import com.zhuhai.service.UserService;
import com.zhuhai.utils.Constant;
import com.zhuhai.utils.DateUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/17
 * Time: 14:53
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;
    @Resource
    private OrganizationService organizationService;
    @Resource
    private RoleService roleService;


    @RequiresPermissions("user:view")
    @RequestMapping(method = RequestMethod.GET)
    public String getUserList(Model model) {
        List<Organization> organizationList = organizationService.findAll();
        List<Role> roleList = roleService.findAll();
        model.addAttribute("organizationList", organizationList);
        model.addAttribute("roleList",roleList);
        return "user/userList";
    }

    @RequiresPermissions("user:view")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public JqGridView<UserDTO> userList(@RequestParam(value = "sidx",required = false,defaultValue = "create_time") String sidx,
                           @RequestParam(value = "sord",required = false,defaultValue = "asc") String sord,
                           @RequestParam(value = "rows",required = false,defaultValue = "10") Integer pageSize,
                           @RequestParam(value = "page",required = false,defaultValue = "1") Integer pageNo)  {
        JqGridView<UserDTO> jqGridView = new JqGridView<UserDTO>();
        try {
            PageInfo<User> pageInfo = userService.findAllByPage(sidx, sord, pageNo, pageSize);
            List<UserDTO> userDTOList = new ArrayList<UserDTO>();
            for (User user : pageInfo.getList()) {
                UserDTO userDTO = new UserDTO();
                userDTO.setId(user.getId());
                userDTO.setUserName(user.getUserName());
                Organization organization = organizationService.findById(user.getOrganizationId());
                if (organization != null) {
                    userDTO.setOrganization(organization.getName());
                }
                String[] roleIds = user.getRoleIds().split(",");
                StringBuilder roleNames = new StringBuilder();
                for (int i = 0; i < roleIds.length; i++) {
                    Role role = roleService.findById(Long.valueOf(roleIds[i]));
                    roleNames.append(role.getDescription());
                    if (i < roleIds.length - 1) {
                        roleNames.append(",");
                    }
                }
                userDTO.setRoleName(roleNames.toString());
                userDTO.setLocked(user.getLocked());
                userDTO.setCreateTime(DateUtil.date2String(user.getCreateTime()));
                userDTOList.add(userDTO);
                jqGridView.setPage(pageInfo.getPageNum());
                jqGridView.setTotal(pageInfo.getPages());
                jqGridView.setRecords(pageInfo.getTotal());
                jqGridView.setRows(userDTOList);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jqGridView;
    }


    @RequiresPermissions("user:view")
    @RequestMapping(value = "/findByName", method = RequestMethod.GET)
    @ResponseBody
    public ResultJson<User> findByName(String userName) {
        try {
            User user = userService.findUserByUserName(userName);
            if (user == null) {
               return new ResultJson<User>(true,"用户名不存在");
            }else {
                return new ResultJson<User>(false,"用户名已存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultJson<User>(false,Constant.SYSTEM_ERROR);
        }

    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public ResultJson<User> createUser(User user) {
        try {
            User checkUser = userService.findUserByUserName(user.getUserName());
            if (checkUser == null) {
                user.setPassword(DigestUtils.sha1Hex(Constant.SALT + user.getPassword()));
                user.setLocked(false);
                userService.saveUser(user);
                return new ResultJson<User>(true,Constant.ADD_SUCCESS);
            }else {
                return new ResultJson<User>(false,Constant.ERROR_USERNAME_EXISTS);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new ResultJson<User>(false,Constant.SYSTEM_ERROR);
        }
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id:\\d+}/update", method = RequestMethod.POST)
    @ResponseBody
    public ResultJson<User> updateUserForm(@PathVariable long id, String userName,Long organizationId,String roleIds) {
        try {
            User user = userService.findUserById(id);
            User checkUser = userService.findUserByUserName(userName);
            if(checkUser !=null && !checkUser.getId().equals(user.getId())) {
                return new ResultJson<User>(false,Constant.ERROR_USERNAME_EXISTS);
            }
            user.setUserName(userName);
            user.setOrganizationId(organizationId);
            user.setRoleIds(roleIds);
            userService.updateUser(user);
            return new ResultJson<User>(true,Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultJson<User>(false,Constant.SYSTEM_ERROR);
        }

    }

    /**
     * 锁定或解锁用户
     * @param ids
     * @param lock
     * @return
     */
    @RequiresPermissions("user:update")
    @RequestMapping(value = "/lock",method = RequestMethod.POST)
    @ResponseBody
    public ResultJson<User> lockOrUnLockUser(@RequestParam("ids[]") Long[] ids,@RequestParam("lock") Boolean lock) {
        try {
            userService.lockOrUnLockUser(ids, lock);
            if (lock) {
                return new ResultJson<User>(true,Constant.LOCK_SUCCESS);
            }else {
                return new ResultJson<User>(true,Constant.UNLOCK_SUCCESS);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new ResultJson<User>(false,Constant.SYSTEM_ERROR);
        }
    }


}
