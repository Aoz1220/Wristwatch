package com.hs.service;

import com.hs.model.TbSysRegion;


public interface RegionService {

    public TbSysRegion getRegionById(Integer regionId);

    public int getRegionIdByRegionName(String regionName);

}
