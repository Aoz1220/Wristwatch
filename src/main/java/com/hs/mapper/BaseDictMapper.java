package com.hs.mapper;

import java.util.List;

import com.hs.model.BaseDict;

public interface BaseDictMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BaseDict record);

    int insertSelective(BaseDict record);

    BaseDict selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BaseDict record);

    int updateByPrimaryKey(BaseDict record);
    
    List<BaseDict> selectByCode(String code);
}