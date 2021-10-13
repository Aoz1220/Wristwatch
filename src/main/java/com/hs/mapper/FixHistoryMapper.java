package com.hs.mapper;

import com.hs.model.FixHistory;

public interface FixHistoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(FixHistory record);

    int insertSelective(FixHistory record);

    FixHistory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(FixHistory record);

    int updateByPrimaryKey(FixHistory record);

    int updateByWatchId(FixHistory record);
}