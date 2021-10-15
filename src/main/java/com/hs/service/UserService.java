package com.hs.service;

import com.hs.model.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserService {
    public int register(String username,String password,String realname,String tel);

    public User getUserByUsername(String username);

    public List<Role> getRoleAll();

    public List<Type> getTypeAll();

    public List<Map> getUserListByKeys(String username,Integer roleId,Integer typeId,Integer page,Integer limit);

    public int deleteUser(Integer id);

    public int deleteUsers(Integer[] ids);

    public int saveUser(User user);

    public int updateUser(User user);

    public int updateUserSetting(Integer id,String tel ,String realname);

    public int updateUserPassword(Integer id,String newpassword);

    public int updateUserBalance(Integer id,Integer money);

    public List<Brand> getBrandByTypeId(Integer typeId);

    public int afterPay(Integer id,Integer fixprice);

    public int afterRefund(Integer watchId,Integer fixprice);

    public int selectBalanceById(Integer id);
}
