package com.hs.service.impl;

import com.github.pagehelper.PageHelper;
import com.hs.mapper.*;
import com.hs.model.*;
import com.hs.service.UserService;
import com.hs.utils.MD5Utils;
import jdk.nashorn.internal.codegen.TypeMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    //注入Mapper接口动态代理对象
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private TypeMapper typeMapper;
    @Autowired
    private BrandMapper brandMapper;
    @Value("#{properties['user.password']}")
    private String defaultPassword;

    /**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
    @Override
    public User getUserByUsername(String username) {
        if(StringUtils.isNotBlank(username)){
            return userMapper.selectByUsername(username);
        }
        return null;
    }

    @Override
    public List<Role> getRoleAll() {
        return roleMapper.selectAll();
    }

    @Override
    public List<Type> getTypeAll() {
        return typeMapper.selectAllType();
    }

    @Override
    public List<Map> getUserListByKeys(String username, Integer roleId, Integer typeId, Integer page, Integer limit) {
        //执行分页查询
        PageHelper.startPage(page,limit);
        return userMapper.selectByKeys(username,roleId,typeId);
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @Override
    public int deleteUser(Integer id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除用户
     * @param ids
     * @return
     */
    @Override
    public int deleteUsers(Integer[] ids) {
        int result=0;
        if(ids.length>0) {
            result=userMapper.deleteByArray(ids);
        }
        return result;
    }

    /**
     * 保存用户
     * @param user
     * @return
     */
    @Override
    public int saveUser(User user) {
        //设置默认密码并加密
        user.setPassword(MD5Utils.getMD5(defaultPassword));
        return userMapper.insert(user);
    }

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    @Override
    public int updateUser(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 更新用户基本资料
     * @param id
     * @param tel
     * @param realname
     * @return
     */
    @Override
    public int updateUserSetting(Integer id,String tel,String realname) {
        return userMapper.updateUserSetting(id,tel,realname);
    }

    /**
     * 修改密码
     * @param user
     * @return
     */
    @Override
    public int updateUserPassword(Integer id,String newpassword) {
        return userMapper.updateUserPassword(id,MD5Utils.getMD5(newpassword));
    }

    /**
     * 客户充值
     * @param id
     * @param money
     * @return
     */
    @Override
    public int updateUserBalance(Integer id,Integer money) {
        return userMapper.updateBalanceByPrimaryKey(id,money);
    }

    /**
     * 查询品牌列表
     * @param typeId
     * @return
     */
    @Override
    public List<Brand> getBrandByTypeId(Integer typeId) {
        return brandMapper.selectByTypeId(typeId);
    }

    @Override
    public int  afterPay(Integer id, Integer fixprice) {
        return userMapper.PayWatchFix(id,fixprice);
    }
    @Override
    public int  afterRefund(Integer id, Integer fixprice) {
        return userMapper.RefundWatch(id,fixprice);
    }

    @Override
    public int selectBalanceById(Integer id){
        return userMapper.selectBalanceById(id);
    }
}
