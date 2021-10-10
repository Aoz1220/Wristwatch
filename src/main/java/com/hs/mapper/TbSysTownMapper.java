package com.hs.mapper;

import com.hs.model.TbSysTown;

import java.util.List;

public interface TbSysTownMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbSysTown record);

    int insertSelective(TbSysTown record);

    TbSysTown selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbSysTown record);

    int updateByPrimaryKey(TbSysTown record);

    List<TbSysTown> selectByRegionId(Integer regionId);

    List<TbSysTown> selectByRegionName(String regionName);

    List<TbSysTown> selectAllTown();
}