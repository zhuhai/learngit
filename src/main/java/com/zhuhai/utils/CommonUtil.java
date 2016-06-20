package com.zhuhai.utils;


/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 14:44
 */
public class CommonUtil {
    
    public static Long[] stringArray2LongArray(String[] strs){
        if (strs == null) {
            return null;
        }
        Long[] longs = new Long[strs.length];
        for (int i = 0; i <strs.length ; i++) {
            longs[i] = Long.valueOf(strs[i]);
        }
        return longs;
    }


}
