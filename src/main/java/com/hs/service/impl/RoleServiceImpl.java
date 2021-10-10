package com.hs.service.impl;

import com.hs.mapper.RoleMapper;
import com.hs.model.Role;
import com.hs.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有角色
     * @return
     */
    @Override
    public List<Role> getRoleAll() {
        return roleMapper.selectAll();
    }
}
