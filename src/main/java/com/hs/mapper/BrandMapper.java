package com.hs.mapper;

import com.hs.model.Brand;
import com.hs.model.Type;

import java.util.List;

public interface BrandMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Type record);

    int insertSelective(Type record);

    Type selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Type record);

    int updateByPrimaryKey(Type record);

    List<Brand> selectByTypeId(Integer TypeId);

}