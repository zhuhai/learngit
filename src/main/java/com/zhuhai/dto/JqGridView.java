package com.zhuhai.dto;

import java.io.Serializable;
import java.util.List;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/7/3
 * Time: 23:39
 */
public class JqGridView<T> implements Serializable {
    private static final long serialVersionUID = -5671925815510482631L;

    //total page
    private long total;
    //current page
    private long page;
    //total records
    private long records;
    // data list
    private List<T> rows;

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public long getPage() {
        return page;
    }

    public void setPage(long page) {
        this.page = page;
    }

    public long getRecords() {
        return records;
    }

    public void setRecords(long records) {
        this.records = records;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
