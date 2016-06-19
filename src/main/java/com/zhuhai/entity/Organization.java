package com.zhuhai.entity;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/18
 * Time: 23:58
 */
public class Organization {
    private Long id;
    private String name;
    private Long parentId;
    private String parentIds;
    private Boolean avaliable;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getParentIds() {
        return parentIds;
    }

    public void setParentIds(String parentIds) {
        this.parentIds = parentIds;
    }

    public Boolean getAvaliable() {
        return avaliable;
    }

    public void setAvaliable(Boolean avaliable) {
        this.avaliable = avaliable;
    }

    public boolean isRootNode() {
        return parentId == 0;
    }
    public String makeSelfAsParentIds() {
        return getParentIds() + getParentId() + "/";
    }
}
