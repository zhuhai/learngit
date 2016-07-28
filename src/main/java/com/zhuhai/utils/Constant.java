package com.zhuhai.utils;

import java.math.BigDecimal;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/22
 * Time: 13:36
 */
public class Constant {

    public static final String SALT = "xajf@#afs$@2wefsjf#@ljs2#$@34jf**&8$%#2jisjfe";

    public static final String UPDATE_SUCCESS = "修改成功！";

    public static final String SYSTEM_ERROR = "系统异常！";

    public static final String DATA_ERROR = "数据异常！";

    public static final String ADD_SUCCESS = "添加成功！";

    public static final String ERROR_USERNAME_EXISTS = "用户名已存在！";

    public static final String LOCK_SUCCESS = "用户锁定成功！";

    public static final String UNLOCK_SUCCESS = "用户解锁成功!";

    public static void main(String[] args) {
        BigDecimal b1 = new BigDecimal(0);
        BigDecimal b2 = new BigDecimal(1.0);
        System.out.println(b1.compareTo(b2));
    }

}
