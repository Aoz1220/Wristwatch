package com.hs.mapper;

import com.hs.model.Type;

import java.util.List;

public interface TypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Type record);

    int insertSelective(Type record);

    Type selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Type record);

    int updateByPrimaryKey(Type record);

    List<Type> selectByRoleId(Integer regionId);

    List<Type> selectByRoleName(String regionName);

    List<Type> selectAllType();
}