package com.zhuhai.utils;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/22
 * Time: 13:36
 */
public class Constant {

    public static final String SALT = "xajf@#afs$@2wefsjf#@ljs2#$@34jf**&8$%#2jisjfe";

    public static void main(String[] args) {
        //System.out.println(DigestUtils.sha1Hex(SALT + "7c4a8d09ca3762af61e59520943dc26494f8941b"));
        String str = "1,2,3,4";
        String[] ids = str.split(",");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < ids.length; i++) {
            sb.append(ids[i]);
            if (i<ids.length-1){
                sb.append(",");
            }
        }

        System.out.println(sb.toString());
    }
}
