package com.hs.service.impl;

import com.github.pagehelper.PageHelper;
import com.hs.common.Constants;
import com.hs.mapper.BrandMapper;
import com.hs.mapper.FixHistoryMapper;
import com.hs.mapper.OrderHistoryMapper;
import com.hs.mapper.WatchMapper;
import com.hs.model.*;
import com.hs.service.WatchService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class WatchServiceImpl implements WatchService {

    @Autowired
    private WatchMapper watchMapper;
    @Autowired
    private BrandMapper brandMapper;
    @Autowired
    private FixHistoryMapper fixHistoryMapper;
    @Autowired
    private OrderHistoryMapper orderHistoryMapper;

    @Override
    public List<Map> getWatchListByKeys(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        //执行分页查询
        PageHelper.startPage(page,limit);
        return watchMapper.selectByKeys(watchname,typeId,brandId);
    }

    /**
     * 查询腕表品牌列表
     * @param typeId
     * @return
     */
    @Override
    public List<Brand> getBrandByTypeId(Integer typeId) {
        return brandMapper.selectByTypeId(typeId);
    }

    /**
     * 拒绝维修腕表
     * @param id
     * @return
     */
    @Override
    public int refuseWatch(Integer id) {
        return watchMapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据腕表名称查询腕表信息
     * @param watchname
     * @return
     */
    @Override
    public Watch getWatchByWatchname(String watchname) {
        if(StringUtils.isNotBlank(watchname)){
            return watchMapper.selectByWatchname(watchname);
        }
        return null;
    }

    /**
     * 根据id查询腕表信息
     * @param id
     * @return
     */
    @Override
    public Watch getWatchById(String id) {
        //参数合法性判断
        if(StringUtils.isNotBlank(id)) {
            return watchMapper.selectById(id);
        }
        return null;
    }

    /**
     * 保存腕表信息
     * @param watch
     * @return
     */
    @Override
    public int saveWatch(Watch watch) {
        return watchMapper.insertSelective(watch);
    }
    /**
     * 更新腕表信息
     * @param watch
     * @return
     */
    @Override
    public int updateWatch(Watch watch) {
        return watchMapper.updateByPrimaryKeySelective(watch);
    }

    /**
     * 更新腕表价格
     * @param watch
     * @return
     */
    @Override
    public int updateWatchPrice(Watch watch) {
        return watchMapper.updatePriceByPrimaryKeySelective(watch);
    }
    /**
     *  查询不能下放或已经在维修厂的腕表
     * @param ids
     * @return
     */
    @Override
    public List<Integer> getWatchCannotPush(Integer[] ids) {
        if(ids!=null){
            return watchMapper.selectCannotPushByIds(ids);
        }
        return null;
    }

    /**
     * 下放到维修厂
     * @param ids
     * @return
     */
    @Override
    public int updateWatchForPushFactory(Integer[] ids) {
        if(ids!=null){
            return watchMapper.updateForPushFactoryByIds(ids);
        }
        return 0;
    }

    /**
     * 腕表审核
     * @param id
     * @return
     */
    @Override
    public int checkWatch(Integer id) {
        return watchMapper.checkWatchById(id);
    }

    /**
     * 付款
     * @param id
     * @return
     */
    @Override
    public int payWatch(Integer id) {
        return watchMapper.payWatchById(id);
    }

    @Override
    public List<Watch> getWatchList(Integer typeId, String watchname, String username, Integer brandId, Integer status, Integer page, Integer limit) {
        List<Watch> list=null;
        try{
            PageHelper.startPage(page,limit);
            list=watchMapper.selectForType(typeId,watchname,username,brandId, status);
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 开始维修腕表
     * @param watchId
     * @param startTime
     * @return
     */
    @Override
    public int updateWatchFixForStart(Integer watchId, Date startTime) {
        //参数合法性判断
        int result=0;
        if (watchId != null) {
            //1.更新腕表维修状态
            Watch watch=new Watch();
            watch.setId(watchId);
            watch.setStatus(Constants.WATCH_STATUS_6);
            result+= watchMapper.updateByPrimaryKeySelective(watch);
            //2.保存腕表维修开始时间
            FixHistory fixHistory=new FixHistory();
            fixHistory.setStartTime(startTime);
            fixHistory.setWatchId(watchId);
            result+=fixHistoryMapper.insertSelective(fixHistory);
        }
        return result;
    }

    /**
     * 结束维修腕表
     * @param watchId
     * @param endTime
     * @return
     */
    @Override
    public int updateWatchFixForEnd(Integer watchId, Date endTime) {
        //参数合法性判断
        int result=0;
        if (watchId != null) {
            //1.更新腕表维修状态
            Watch watch=new Watch();
            watch.setId(watchId);
            watch.setStatus(Constants.WATCH_STATUS_7);
            result+= watchMapper.updateByPrimaryKeySelective(watch);
            //2.保存腕表维修结束时间
            FixHistory fixHistory=new FixHistory();
            fixHistory.setEndTime(endTime);
            fixHistory.setWatchId(watchId);
            result+=fixHistoryMapper.updateByWatchId(fixHistory);
        }
        return result;
    }

    @Override
    public List<Watch> getWatchListWithTime(Integer typeId, String watchname, String username, Integer brandId, Integer status, Integer page, Integer limit) {
        List<Watch> list=null;
        try{
            PageHelper.startPage(page,limit);
            list=watchMapper.selectForGoingAndDone(typeId,watchname,username,brandId, status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Map> getWatchListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        //执行分页查询
        PageHelper.startPage(page,limit);
        return watchMapper.selectByRealname(realname,watchname,typeId,brandId);
    }

    /**
     *  查询不能寄出的腕表
     * @param ids
     * @return
     */
    @Override
    public List<Integer> getWatchCannotSendback(Integer[] ids) {
        if(ids!=null){
            return watchMapper.selectCannotSendbackByIds(ids);
        }
        return null;
    }

    /**
     * 寄回腕表
     * @param ids
     * @return
     */
    @Override
    public int updateWatchForSendback(Integer[] ids) {
        if(ids!=null){
            return watchMapper.updateForSendbackByIds(ids);
        }
        return 0;
    }

    /**
     * 客户收货
     * @param id
     * @return
     */
    @Override
    public int updateWatchForReceive(Integer id) {
        if(id!=null){
            return watchMapper.updateForReceiveById(id);
        }
        return 0;
    }

    /**
     * 结束维修订单
     * @param id
     * @param endTime
     * @return
     */
    @Override
    public int updateWatchOrderForEnd(Integer id, Date endTime) {
        //参数合法性判断
        int result=0;
        if (id != null) {
            OrderHistory orderHistory=new OrderHistory();
            orderHistory.setFinishTime(endTime);
            orderHistory.setWatchId(id);
            result+=orderHistoryMapper.insertSelective(orderHistory);
        }
        return result;
    }

    @Override
    public List<Map> getOrderListByRealname(String realname,String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        //执行分页查询
        PageHelper.startPage(page,limit);
        return watchMapper.selectOrderByRealname(realname,watchname,typeId,brandId);
    }

    /**
     * 接收腕表
     * @param id
     * @return
     */
    @Override
    public int instoreWatch(Integer id) {
        return watchMapper.instoreWatchById(id);
    }

    @Override
    public List<Watch> getAllWatchList() {
        List<Watch> list=null;
        list=watchMapper.selectAll();
        return list;
    }
}
