package com.hs.mapper;

import com.hs.model.TbResidentInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TbResidentInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteByArray(@Param("ids")Integer[] ids);

    int insert(TbResidentInfo record);

    int insertSelective(TbResidentInfo record);

    TbResidentInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbResidentInfo record);

    int updateByPrimaryKey(TbResidentInfo record);

    TbResidentInfo selectByIdNumber(String idNumber);

    List<TbResidentInfo> selectForPage(@Param("regionId") Integer regionId,@Param("name") String name,@Param("idNumber") String idNumber,@Param("townName") String townName);

    List<TbResidentInfo> selectForTown(@Param("regionId") Integer regionId,@Param("townId")Integer townId, @Param("name") String name,@Param("idNumber") String idNumber,@Param("townName") String townName,@Param("status")Integer status);

    List<Map> selectForGoingAndDone(@Param("regionId") Integer regionId, @Param("townId")Integer townId, @Param("name") String name, @Param("idNumber") String idNumber, @Param("townName") String townName, @Param("status")Integer status);

    List<TbResidentInfo> selectForTemplate(Integer regionId);

    int insertBatch(@Param("list") List<TbResidentInfo> list,@Param("regionName") String regionName);

    List<TbResidentInfo> selectByIdNumbers(String idNumbers);

    int updateForPushTownByIds(@Param("ids")Integer[] ids);

    int updateForPushIsolationByIds(@Param("ids")int[] ids,@Param("isolationId")Integer isolationId);

    List<Integer> selectCannotPushByIds(@Param("ids")Integer[] ids);

    List<Integer> selectCannotPushByIds(@Param("ids")int[] ids);


}