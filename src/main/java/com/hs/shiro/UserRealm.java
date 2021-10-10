package com.hs.shiro;

import com.hs.model.User;
import com.hs.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class UserRealm extends AuthorizingRealm {
    /**
     * 安全数据
     */
    @Autowired
    private UserService userService;

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取用户名
        //String account=(String)principalCollection.getPrimaryPrincipal();
        //根据用户名查询角色权限列表
        /*Set<String> roles=userService.getRoleByAccount(account);
        Set<String> permissions=userService.getPermissionsByAccount(account);
        SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();
        info.setRoles(roles);
        info.setStringPermissions(permissions);
        return info;*/
        return null;
    }

    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //根据用户名查询用户信息
        String username=(String)authenticationToken.getPrincipal();
        User user=userService.getUserByUsername(username);
        if(user!=null){
            SimpleAuthenticationInfo info=new SimpleAuthenticationInfo(user,user.getPassword(),this.getName());
            return info;
        }
        return null;
    }
}
