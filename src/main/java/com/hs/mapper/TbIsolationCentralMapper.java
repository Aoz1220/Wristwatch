package com.hs.mapper;

import com.hs.model.TbIsolationCentral;

public interface TbIsolationCentralMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbIsolationCentral record);

    int insertSelective(TbIsolationCentral record);

    TbIsolationCentral selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbIsolationCentral record);

    int updateByPrimaryKey(TbIsolationCentral record);
}