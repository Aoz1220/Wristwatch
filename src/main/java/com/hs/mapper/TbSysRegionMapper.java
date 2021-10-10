package com.hs.mapper;

import com.hs.model.TbSysRegion;

import java.util.List;

public interface TbSysRegionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbSysRegion record);

    int insertSelective(TbSysRegion record);

    TbSysRegion selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbSysRegion record);

    int updateByPrimaryKey(TbSysRegion record);

    List<TbSysRegion> selectAll();

    int selectRegionIdByRegionName(String RegionName);
}