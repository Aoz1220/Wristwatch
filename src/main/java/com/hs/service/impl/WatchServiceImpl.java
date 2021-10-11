package com.hs.service.impl;

import com.github.pagehelper.PageHelper;
import com.hs.mapper.BrandMapper;
import com.hs.mapper.WatchMapper;
import com.hs.model.Brand;
import com.hs.model.TbResidentInfo;
import com.hs.model.Watch;
import com.hs.service.WatchService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WatchServiceImpl implements WatchService {

    @Autowired
    private WatchMapper watchMapper;
    @Autowired
    private BrandMapper brandMapper;

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
     * @param username
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
     * @param watch
     * @return
     */
    @Override
    public int checkWatch(Integer id) {
        return watchMapper.checkWatchById(id);
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
}
