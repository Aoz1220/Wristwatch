package com.hs.mapper;

import com.hs.model.OrderHistory;
import com.hs.model.Watch;
import org.apache.ibatis.annotations.Param;

public interface OrderHistoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderHistory record);

    int insertSelective(OrderHistory record);

    int insertWatchOrderForRefund(OrderHistory record);

    int insertWatchOrderForRefuse(OrderHistory record);

    OrderHistory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderHistory record);

    int updateByPrimaryKey(OrderHistory record);

    OrderHistory selectByWatchId(String id);

    int updateWatchOrderForRefund(OrderHistory record);
}