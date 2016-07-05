package com.zhuhai.dto;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/7/5
 * Time: 14:01
 */
public class TreeDTO {

    private long id;
    private long pId;
    private String name;
    private boolean isParent;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getpId() {
        return pId;
    }

    public void setpId(long pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getIsParent() {
        return isParent;
    }

    public void setIsParent(boolean isParent) {
        this.isParent = isParent;
    }
}
