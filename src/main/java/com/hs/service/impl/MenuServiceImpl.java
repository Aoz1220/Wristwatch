package com.hs.service.impl;

import com.hs.mapper.MenuMapper;
import com.hs.mapper.RoleMapper;
import com.hs.model.Role;
import com.hs.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private MenuMapper menuMapper;
    /**
     * 根据角色id查询菜单列表
     * @param roleId
     * @return
     */
    @Override
    public Map<String, Object> getMenuByRoleId(int roleId) {
        Map<String,Object> map=new HashMap<String, Object>();
        Map<String,Object> homeMap=new HashMap<String, Object>();
        Map<String,Object> logoMap=new HashMap<String, Object>();
        // 首页
        homeMap.put("title","首页");
        homeMap.put("href","page/welcome-1.html?t=1");
        map.put("homeInfo",homeMap);
        //logo
        logoMap.put("title","腕表修理系统");
        logoMap.put("image","images/logo.png");
        logoMap.put("href","");
        map.put("logoInfo",logoMap);
        //menu
        List<Map<String,Object>> pMenuList=new ArrayList<Map<String,Object>>();
        Map<String,Object> pMenuMap=new HashMap<String, Object>();
        //查询角色名称
        Role role= roleMapper.selectByPrimaryKey(roleId);
        //查询子菜单列表
        List<Map> menuList=menuMapper.selectByRoleId(roleId);
        pMenuMap.put("title",role.getRoleName());
        pMenuMap.put("href","");
        pMenuMap.put("icon","");
        pMenuMap.put("target","_self");
        pMenuMap.put("child",menuList);


        pMenuList.add(pMenuMap);
        map.put("menuInfo",pMenuList);
        return map;
    }
}
