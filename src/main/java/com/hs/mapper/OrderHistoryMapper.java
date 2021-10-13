package com.hs.mapper;

import com.hs.model.OrderHistory;

public interface OrderHistoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderHistory record);

    int insertSelective(OrderHistory record);

    OrderHistory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderHistory record);

    int updateByPrimaryKey(OrderHistory record);
}