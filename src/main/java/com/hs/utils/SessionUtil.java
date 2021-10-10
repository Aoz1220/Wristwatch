package com.hs.utils;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;

public class SessionUtil {
    /**
     * 获取登录人信息
     * @return
     */
    public static Object getPrimaryPrincipal(){
        Session session=SecurityUtils.getSubject().getSession();
        SimplePrincipalCollection principalCollection=(SimplePrincipalCollection)session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
        // SysUser user=(SysUser)principalCollection.getPrimaryPrincipal();
        return principalCollection.getPrimaryPrincipal();
    }
}
