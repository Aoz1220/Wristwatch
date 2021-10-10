package com.hs.service.impl;

import com.github.pagehelper.PageHelper;
import com.hs.common.Constants;
import com.hs.mapper.TbIsolationHomeMapper;
import com.hs.mapper.TbResidentInfoMapper;
import com.hs.model.TbIsolationHome;
import com.hs.model.TbResidentInfo;
import com.hs.service.ResidentService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class ResidentServiceImpl implements ResidentService {

    @Autowired
    private TbResidentInfoMapper residentInfoMapper;

    @Autowired
    private TbIsolationHomeMapper isolationHomeMapper;
    /**
     * 保存居民信息
     * @param resident
     * @return
     */
    @Override
    public int saveResident(TbResidentInfo resident) {
        return residentInfoMapper.insertSelective(resident);
    }

    /**
     * 根据身份证号查询居民信息
     * @param idNumber
     * @return
     */
    @Override
    public TbResidentInfo getResidentByIdNumber(String idNumber) {
        //参数合法性判断
        if(StringUtils.isNotBlank(idNumber)) {
            return residentInfoMapper.selectByIdNumber(idNumber);
        }
        return null;
    }

    /**
     * 查询居民列表
     * @param regionId
     * @param name
     * @param idNumber
     * @param townName
     * @return
     */
    @Override
    public List<TbResidentInfo> getResidentList(Integer regionId, String name, String idNumber, String townName,Integer page,Integer limit) {
        List<TbResidentInfo> list=null;
        try{
            PageHelper.startPage(page,limit);
            list=residentInfoMapper.selectForPage(regionId,name,idNumber,townName);
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<TbResidentInfo> getResidentList(Integer regionId, Integer townId, String name, String idNumber, String townName,Integer status, Integer page, Integer limit) {
        List<TbResidentInfo> list=null;
        try{
            PageHelper.startPage(page,limit);
            list=residentInfoMapper.selectForTown(regionId,townId,name,idNumber,townName, status);
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Map> getResidentListWithTime(Integer regionId, Integer townId, String name, String idNumber, String townName, Integer status, Integer page, Integer limit) {
        List<Map> list=null;
        try{
            PageHelper.startPage(page,limit);
            list=residentInfoMapper.selectForGoingAndDone(regionId,townId,name,idNumber,townName, status);
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 根据所属区ID查询居民列表
     * @param regionId
     * @return
     */
    @Override
    public List<TbResidentInfo> getResidentList(Integer regionId) {
        return residentInfoMapper.selectForTemplate(regionId);
    }

    /**
     * 批量保存居民信息
     * @param list
     * @return
     */
    @Override
    public int saveResidentBatch(List<TbResidentInfo> list,String regionName) {
        if(list!=null && list.size()>0){
            return residentInfoMapper.insertBatch(list,regionName);
        }
        return 0;
    }


    /**
     * 筛选掉已存在的居民
     * @param list
     * @return
     */
    @Override
    public List<TbResidentInfo> screenResidents(List<TbResidentInfo> list) {
        if(list!=null && list.size()>0){
            List<TbResidentInfo> newList=new ArrayList<TbResidentInfo>();
            newList.addAll(list);
            StringBuilder idNumbers=new StringBuilder("");
            for(int i=0;i<list.size();i++){//1,2,3
                if(i==0){
                    idNumbers.append(list.get(i).getIdNumber());
                }else{
                    idNumbers.append(","+list.get(i).getIdNumber());
                }
            }
            //查询哪些居民已经存在于数据库
            List<TbResidentInfo> existList=residentInfoMapper.selectByIdNumbers(idNumbers.toString());
            //遍历已存在的数据
            for(TbResidentInfo existInfo:existList){
                for(TbResidentInfo resident:newList){
                    if(existInfo.getIdNumber().equals(resident.getIdNumber())){
                        list.remove(resident);
                    }
                }
            }
        }
        return list;
    }

    /**
     * 删除居民
     * @param id
     * @return
     */
    @Override
    public int deleteResident(Integer id) {
        return residentInfoMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除居民
     * @param ids
     * @return
     */
    @Override
    public int deleteResidents(Integer[] ids) {
        int result=0;
        if(ids.length>0){
            result=residentInfoMapper.deleteByArray(ids);
        }
        return result;
    }

    /**
     * 更新居民信息
     * @param residentInfo
     * @return
     */
    @Override
    public int updateResident(TbResidentInfo residentInfo) {
        return residentInfoMapper.updateByPrimaryKeySelective(residentInfo);
    }

    /**
     * 推送镇（街道）
     * @param ids
     * @return
     */
    @Override
    public int updateResidentForPushTown(Integer[] ids) {
        if(ids!=null){
            return residentInfoMapper.updateForPushTownByIds(ids);
        }
        return 0;
    }

    /**
     * 推送隔离点
     * @param ids
     * @param isolationId
     * @return
     */
    @Override
    public int updateResidentForPushIsolation(int[] ids, Integer isolationId) {
        if(ids!=null && isolationId!=null){
            return residentInfoMapper.updateForPushIsolationByIds(ids,isolationId);
        }
        return 0;
    }

    /**
     *  查询哪些居民正在隔离中
     * @param ids
     * @return
     */
    @Override
    public List<Integer> getResidentCannotPush(Integer[] ids) {
        if(ids!=null){
            return residentInfoMapper.selectCannotPushByIds(ids);
        }
        return null;
    }

    @Override
    public List<Integer> getResidentCannotPush(int[] ids) {
        if(ids!=null){
            return residentInfoMapper.selectCannotPushByIds(ids);
        }
        return null;
    }

    /**
     * 居家隔离开始
     * @param residentId
     * @param startTime
     * @return
     */
    @Override
    public int updateIsolationHomeInfoForStart(Integer residentId, Date startTime) {
        //参数合法性判断
        int result=0;
        if(residentId!=null){
            //1.更新居民状态
            TbResidentInfo residentInfo=new TbResidentInfo();
            residentInfo.setId(residentId);
            residentInfo.setStatus(Constants.RESIDENT_STATUS_3);//状态更新为居家隔离
            residentInfo.setIsHomeIsolation(1);//是否居家隔离设置为“1”
            result += residentInfoMapper.updateByPrimaryKeySelective(residentInfo);
            //2.保存居民居家隔离开始时间
            TbIsolationHome isolationHome=new TbIsolationHome();
            isolationHome.setStartTime(startTime);
            isolationHome.setResidentId(residentId);
            result += isolationHomeMapper.insertSelective(isolationHome);
        }
        return result;
    }

    /**
     * 居家隔离解除
     * @param residentId
     * @param endTime
     * @return
     */
    @Override
    public int updateIsolationHomeInfoForEnd(Integer residentId, Date endTime) {
        //参数合法性判断
        int result=0;
        if(residentId!=null){
            //1.更新居民状态
            TbResidentInfo residentInfo=new TbResidentInfo();
            residentInfo.setId(residentId);
            residentInfo.setStatus(Constants.RESIDENT_STATUS_4);
            result += residentInfoMapper.updateByPrimaryKeySelective(residentInfo);
            //2.保存居民居家隔离结束时间
            TbIsolationHome isolationHome=new TbIsolationHome();
            isolationHome.setEndTime(endTime);
            isolationHome.setResidentId(residentId);
            result += isolationHomeMapper.updateByResidentId(isolationHome);
        }
        return result;
    }


}
