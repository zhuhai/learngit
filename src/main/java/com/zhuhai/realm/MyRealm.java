package com.zhuhai.realm;

import com.zhuhai.entity.User;
import com.zhuhai.service.UserService;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/20
 * Time: 15:56
 */
@Component
public class MyRealm extends AuthorizingRealm {
    @Resource
    private UserService userService;

    /**
     * 权限认证
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String loginName = (String) principalCollection.fromRealm(getName()).iterator().next();
        User user = userService.findUserByUserName(loginName);
        if (user != null) {
            SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
            authorizationInfo.setRoles(userService.findRolesByUserName(user.getUserName()));
            authorizationInfo.setStringPermissions(userService.findPermissionsByUserName(user.getUserName()));
            return authorizationInfo;
        }
        return null;
    }

    /**
     * 登录认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        User user = userService.findUserByUserName(token.getUsername());
        if (user == null) {
            throw new UnknownAccountException("用户不存在");
        } else {
            if (user.getLocked()) {
                throw new LockedAccountException("用户已被锁定");
            }else if (!String.valueOf(token.getPassword()).equals(user.getPassword())) {
                throw new AccountException("用户名或密码不正确");
            }
            return new SimpleAuthenticationInfo(user.getUserName(),user.getPassword(),getName());
        }

    }
}
