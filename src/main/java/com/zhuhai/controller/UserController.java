package com.zhuhai.controller;

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
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
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
        /*try {
            model.addAttribute("userList",userService.findAll());
        } catch (AuthorizationException e) {
            e.printStackTrace();
        }*/
        return "user/userList";
    }

    @RequiresPermissions("user:view")
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public String userList(HttpServletResponse response) {
        String result = null;
        try {
            List<User> userList = userService.findAll();
            List<UserDTO> userDTOList = new ArrayList<UserDTO>();
            for (User user : userList) {
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
            }

            ObjectMapper mapper = new ObjectMapper();
            result = mapper.writeValueAsString(userDTOList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }


    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String createUserForm(Model model) {
        List<Organization> organizationList = organizationService.findAll();
        model.addAttribute("organizationList", organizationList);
        return "user/userAdd";
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createUser(User user, RedirectAttributes redirectAttributes) {
        user.setPassword(DigestUtils.sha1Hex(Constant.SALT + user.getPassword()));
        user.setLocked(false);
        user.setRoleIds("2");
        userService.saveUser(user);
        redirectAttributes.addFlashAttribute("message", "添加成功");
        return "redirect:/user";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id:\\d+}/update", method = RequestMethod.GET)
    public String updateUserForm(@PathVariable long id, Model model) {
        User user = userService.findUserById(id);
        List<Organization> organizationList = organizationService.findAll();
        model.addAttribute("organizationList", organizationList);
        model.addAttribute("user", user);
        return "/user/userEdit";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateUser(User user, RedirectAttributes redirectAttributes) {
        user.setPassword(DigestUtils.sha1Hex(Constant.SALT + user.getPassword()));
        user.setLocked(false);
        userService.updateUser(user);
        redirectAttributes.addFlashAttribute("message", "修改成功");
        return "redirect:/user";
    }
}
