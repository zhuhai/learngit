package com.zhuhai.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA
 * User: hai
 * Date: 2016/6/28
 * Time: 21:22
 */
public class DateUtil {

    private static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static String date2String(Date date,String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }

    public static String date2String(Date date) {
        return date2String(date,DEFAULT_PATTERN);
    }
}
