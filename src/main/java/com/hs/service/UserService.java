package com.hs.service;

import com.hs.model.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserService {
    public User getUserByUsername(String username);

    public List<Role> getRoleAll();

    public List<Type> getTypeAll();

    public List<Map> getUserListByKeys(String username,Integer roleId,Integer typeId,Integer page,Integer limit);

    public int deleteUser(Integer id);

    public int deleteUsers(Integer[] ids);

    public int saveUser(User user);

    public int updateUser(User user);

    public int updateUserPassword(User user);

    public List<Brand> getBrandByTypeId(Integer typeId);
}
