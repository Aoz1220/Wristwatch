package com.hs.service;

import com.hs.model.TbResidentInfo;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ResidentService {
    public int saveResident(TbResidentInfo resident);

    public TbResidentInfo getResidentByIdNumber(String idNumber);

    public List<TbResidentInfo> getResidentList(Integer regionId,String name,String idNumber,String townName,Integer page,Integer limit);

    public List<TbResidentInfo> getResidentList(Integer regionId,Integer townId,String name,String idNumber,String townName,Integer status,Integer page,Integer limit);

    public List<Map> getResidentListWithTime(Integer regionId, Integer townId, String name, String idNumber, String townName, Integer status, Integer page, Integer limit);

    public List<TbResidentInfo> getResidentList(Integer regionId);

    public int saveResidentBatch(List<TbResidentInfo> list,String regionName);

    public List<TbResidentInfo> screenResidents(List<TbResidentInfo> list);

    public int deleteResident(Integer id);

    public int deleteResidents(Integer[] ids);

    public int updateResident(TbResidentInfo residentInfo);

    public int updateResidentForPushTown(Integer[] ids);

    public int updateResidentForPushIsolation(int[] ids,Integer isolationId);

    public List<Integer> getResidentCannotPush(Integer[] ids);

    public List<Integer> getResidentCannotPush(int[] ids);

    public int updateIsolationHomeInfoForStart(Integer residentId, Date startTime);

    public int updateIsolationHomeInfoForEnd(Integer residentId, Date endTime);
}
