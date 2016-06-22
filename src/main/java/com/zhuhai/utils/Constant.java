package com.zhuhai.utils;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/22
 * Time: 13:36
 */
public class Constant {

    public static final String SALT = "xajf@#afs$@2wefsjf#@ljs2#$@34jf**&8$%#2jisjfe";

    public static void main(String[] args) {
        System.out.println(DigestUtils.sha1Hex(SALT + "12345"));
    }
}
