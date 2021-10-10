package com.hs.service;


import com.hs.model.Brand;
import com.hs.model.Watch;

import java.util.List;
import java.util.Map;

public interface WatchService {
    public Watch getWatchByWatchname(String watchname);

    public List<Map> getWatchListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Brand> getBrandByTypeId(Integer typeId);

    public int refuseWatch(Integer id);

    public Watch getWatchById(String id);

    public int saveWatch(Watch watch);

    public int updateWatch(Watch watch);
}
