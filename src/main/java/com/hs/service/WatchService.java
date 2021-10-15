package com.hs.service;


import com.hs.model.Brand;
import com.hs.model.OrderHistory;
import com.hs.model.Watch;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface WatchService {
    public Watch getWatchByWatchname(String watchname);

    public List<Map> getWatchListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Map> getHistoryListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Map> getRefuseHistoryListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Map> getRefundHistoryListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);


    public List<Watch> getAllWatchList();

    public List<Map> getWatchListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Brand> getBrandByTypeId(Integer typeId);

    public int refuseWatch(Integer id);

    public int startRefundWatch(Integer id);

    public int checkRefundWatch(Integer id);

    public Watch getWatchById(String id);

    public OrderHistory getOrderHistoryByWatchId(String id);

    public int saveWatch(Watch watch);

    public int updateWatch(Watch watch);

    public int updateWatchPrice(Watch watch);

    public List<Integer> getWatchCannotPush(Integer[] ids);

    public List<Integer> getWatchCannotSendback(Integer[] ids);

    public int updateWatchForPushFactory(Integer[] ids);

    public int checkWatch(Integer id);

    public int payWatch(Integer id);

    public List<Watch> getWatchList(Integer typeId, String watchname, String username, Integer brandId,Integer status, Integer page, Integer limit);

    public List<Watch> getWatchListWithTime(Integer typeId, String watchname, String username, Integer brandId,Integer status, Integer page, Integer limit);

    public int updateWatchFixForStart(Integer watchId, Date startTime);

    public int insertWatchOrderForRefund(Integer watchId, String refundreason);

    public int insertWatchOrderForRefuse(Integer watchId, String refusereason,Date date);

    public int updateWatchOrderForRefund(Integer watchId, String refundreason,Integer refundprice,Date date);

    public int updateWatchFixForEnd(Integer watchId, Date endTime);

    public int updateWatchForSendback(Integer[] ids);

    public int updateWatchForReceive(Integer id);

    public int updateWatchOrderForEnd(Integer id, Date endTime);

    public List<Map> getOrderListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Map> getRefundOrderListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public List<Map> getRefuseOrderListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit);

    public int instoreWatch(Integer id);

    public int scoreOrder(String watchname,String score);
}
