package com.hs.service.impl;

import com.hs.mapper.TbSysRegionMapper;
import com.hs.model.TbSysRegion;
import com.hs.service.RegionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegionServiceImpl implements RegionService {

    @Autowired
    private TbSysRegionMapper regionMapper;

    /**
     * 根据主键查询所属区
     * @param regionId
     * @return
     */
    @Override
    public TbSysRegion getRegionById(Integer regionId) {
        return regionMapper.selectByPrimaryKey(regionId);
    }

    /**
     * 根据行政区名称获取行政区ID
     * @param regionName
     * @return
     */
    @Override
    public int getRegionIdByRegionName(String regionName) {
        return regionMapper.selectRegionIdByRegionName(regionName);
    }
}
