package com.zhuhai.entity;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/18
 * Time: 23:43
 */

public class Resource {
    private Long id;
    private String name;
    private ResourceType type;
    private String url;
    private Long parentId;
    private String parentIds;
    private String permission;
    private Boolean avaliable;

    public static enum ResourceType{
        menu("菜单"),
        button("按钮");

        private final String info;

        ResourceType(String info) {
            this.info = info;
        }
        public String getInfo() {
            return info;
        }
    }

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

    public ResourceType getType() {
        return type;
    }

    public void setType(ResourceType type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
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

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
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
        return getParentIds() + getParentId() +"/";
    }

}
