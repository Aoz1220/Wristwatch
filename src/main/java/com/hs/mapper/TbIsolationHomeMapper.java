package com.hs.mapper;

import com.hs.model.TbIsolationHome;

public interface TbIsolationHomeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbIsolationHome record);

    int insertSelective(TbIsolationHome record);

    TbIsolationHome selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbIsolationHome record);

    int updateByPrimaryKey(TbIsolationHome record);

    int updateByResidentId(TbIsolationHome record);
}