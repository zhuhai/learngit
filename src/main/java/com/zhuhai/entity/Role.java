package com.zhuhai.entity;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/18
 * Time: 23:55
 */

public class Role {

    private Long id;
    private String role;
    private String description;
    private String resourceIds;
    private Boolean avaliable;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResourceIds() {
        return resourceIds;
    }

    public void setResourceIds(String resourceIds) {
        this.resourceIds = resourceIds;
    }

    public Boolean getAvaliable() {
        return avaliable;
    }

    public void setAvaliable(Boolean avaliable) {
        this.avaliable = avaliable;
    }


}
