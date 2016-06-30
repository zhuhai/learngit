package com.zhuhai.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/30
 * Time: 21:57
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @RequiresPermissions("resource:view")
    @RequestMapping(method = RequestMethod.GET)
    public String getResourceList() {
        return "resource/resourceList";
    }


}
