package com.hs.mapper;

import com.hs.model.Watch;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WatchMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Watch record);

    int insertSelective(Watch record);

    List<Watch> selectAll();

    Watch selectByPrimaryKey(Integer id);

    Watch selectByWatchname(String watchname);

    int updateByPrimaryKeySelective(Watch record);

    int updatePriceByPrimaryKeySelective(Watch record);

    int updateByPrimaryKey(Watch record);

    List<Map> selectByKeys(@Param("watchname") String watchname, @Param("typeId") Integer typeId, @Param("brandId") Integer brandId);

    List<Map> selectByRealname(@Param("realname") String realname,@Param("watchname") String watchname, @Param("typeId") Integer typeId, @Param("brandId") Integer brandId);

    Watch selectById(String id);

    List<Integer> selectCannotPushByIds(@Param("ids") Integer[] ids);

    int updateForPushFactoryByIds(@Param("ids") Integer[] ids);

    int checkWatchById(Integer id);

    int payWatchById(Integer id);

    List<Watch> selectForType(@Param("typeId") Integer typeId, @Param("watchname") String watchname, @Param("username") String username, @Param("brandId") Integer brandId, @Param("status") Integer status);

    List<Watch> selectForGoingAndDone(@Param("typeId") Integer typeId, @Param("watchname") String watchname, @Param("username") String username, @Param("brandId") Integer brandId, @Param("status") Integer status);

    List<Integer> selectCannotSendbackByIds(@Param("ids") Integer[] ids);

    int updateForSendbackByIds(@Param("ids") Integer[] ids);

    int updateForReceiveById(Integer id);

    List<Map> selectOrderByRealname(@Param("realname") String realname,@Param("watchname") String watchname, @Param("typeId") Integer typeId, @Param("brandId") Integer brandId);

    int instoreWatchById(Integer id);
}