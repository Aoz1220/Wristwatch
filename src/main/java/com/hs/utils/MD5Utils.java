package com.hs.utils;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;

public class MD5Utils {

    /**
     * MD5加密
     * @param str
     * @return
     */
    public static String getMD5(String str){
        if(StringUtils.isNotBlank(str)){
            SimpleHash simpleHash = new SimpleHash("MD5",str,null,1);
            return simpleHash.toString();
        }
        return null;
    }

}
