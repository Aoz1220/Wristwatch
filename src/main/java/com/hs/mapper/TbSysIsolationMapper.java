package com.hs.mapper;

import com.hs.model.TbSysIsolation;

import java.util.List;

public interface TbSysIsolationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbSysIsolation record);

    int insertSelective(TbSysIsolation record);

    TbSysIsolation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbSysIsolation record);

    int updateByPrimaryKey(TbSysIsolation record);

    List<TbSysIsolation> selectByRegionId(Integer RegionId);
}