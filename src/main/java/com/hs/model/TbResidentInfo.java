package com.hs.model;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import com.hs.converter.GenderConverter;
import com.hs.converter.NucleinResultConverter;
import com.hs.converter.StatusConverter;
import com.hs.converter.TypeConverter;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@ContentRowHeight(24)
@HeadRowHeight(50)
@ColumnWidth(25)
public class TbResidentInfo implements Serializable {

    @ExcelIgnore
    private Integer id;

    @ExcelProperty("姓名")
    private String name;

    @ExcelProperty(value = "性别",converter = GenderConverter.class)
    private Integer gender;

    @ExcelProperty("年龄")
    private Integer age;

    @ExcelProperty("身份证号码")
    private String idNumber;

    @ExcelProperty("电话号码")
    private String tel;

    @ExcelProperty("详细现住址")
    private String address;

    @ExcelIgnore
    private String regionName;

    @ExcelProperty("镇（街道）")
    private String townName;

    @ExcelProperty(value = "分类",converter = TypeConverter.class)
    private Integer type;

    @ExcelProperty(value = "状态",converter = StatusConverter.class)
    private Integer status;

    @ExcelIgnore
    private String reviewInfo;

    @ExcelProperty("归淮日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
   // @JsonFormat(pattern = "yyyy-MM-dd")
    private Date backDate;

    @ExcelProperty("关联省")
    private String relationProvince;

    @ExcelProperty("关联市")
    private String relationCity;

    @ExcelProperty("关联区")
    private String relationRegion;

    @ExcelProperty("关联镇")
    private String relationTown;

    @ExcelProperty("关联社区")
    private String relationCommunity;

    @ExcelProperty("集中隔离")
    private Integer isCentralIsolation;

    @ExcelIgnore
    private Integer isHomeIsolation;

    @ExcelIgnore
    private Integer isNucleinCheck;

    @ExcelProperty("核算检测时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date nucleinCheckTime;

    @ExcelProperty(value = "检测结果",converter = NucleinResultConverter.class)
    private Integer nucleinResult;

    @ExcelProperty("在重点地区情况")
    private String keyAreaInfo;

    @ExcelProperty("镇（街道）干部姓名")
    private String townLeader;

    @ExcelProperty("镇（街道）手机号码")
    private String townPhone;

    @ExcelProperty("社区干部姓名")
    private String communityLeader;

    @ExcelProperty("社区干部手机号码")
    private String communityPhone;

    @ExcelProperty("民警姓名")
    private String policeName;

    @ExcelProperty("民警手机号码")
    private String policePhone;

    @ExcelProperty("医务工作者姓名")
    private String doctorName;

    @ExcelProperty("医务工作者手机号码")
    private String doctorPhone;

    @ExcelProperty("网格员姓名")
    private String gridName;

    @ExcelProperty("网格员手机号码")
    private String gridPhone;

    @ExcelProperty("备注")
    private String remarks;

    @ExcelIgnore
    private Integer isTownPush;

    @ExcelIgnore
    private Integer isIsolationPush;

    @ExcelIgnore
    private Integer isolationId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber == null ? null : idNumber.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName == null ? null : regionName.trim();
    }

    public String getTownName() {
        return townName;
    }

    public void setTownName(String townName) {
        this.townName = townName == null ? null : townName.trim();
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getReviewInfo() {
        return reviewInfo;
    }

    public void setReviewInfo(String reviewInfo) {
        this.reviewInfo = reviewInfo == null ? null : reviewInfo.trim();
    }

    public Date getBackDate() {
        return backDate;
    }

    public void setBackDate(Date backDate) {
        this.backDate = backDate;
    }

    public String getRelationProvince() {
        return relationProvince;
    }

    public void setRelationProvince(String relationProvince) {
        this.relationProvince = relationProvince == null ? null : relationProvince.trim();
    }

    public String getRelationCity() {
        return relationCity;
    }

    public void setRelationCity(String relationCity) {
        this.relationCity = relationCity == null ? null : relationCity.trim();
    }

    public String getRelationRegion() {
        return relationRegion;
    }

    public void setRelationRegion(String relationRegion) {
        this.relationRegion = relationRegion == null ? null : relationRegion.trim();
    }

    public String getRelationTown() {
        return relationTown;
    }

    public void setRelationTown(String relationTown) {
        this.relationTown = relationTown == null ? null : relationTown.trim();
    }

    public String getRelationCommunity() {
        return relationCommunity;
    }

    public void setRelationCommunity(String relationCommunity) {
        this.relationCommunity = relationCommunity == null ? null : relationCommunity.trim();
    }

    public Integer getIsCentralIsolation() {
        return isCentralIsolation;
    }

    public void setIsCentralIsolation(Integer isCentralIsolation) {
        this.isCentralIsolation = isCentralIsolation;
    }

    public Integer getIsHomeIsolation() {
        return isHomeIsolation;
    }

    public void setIsHomeIsolation(Integer isHomeIsolation) {
        this.isHomeIsolation = isHomeIsolation;
    }

    public Integer getIsNucleinCheck() {
        return isNucleinCheck;
    }

    public void setIsNucleinCheck(Integer isNucleinCheck) {
        this.isNucleinCheck = isNucleinCheck;
    }

    public Date getNucleinCheckTime() {
        return nucleinCheckTime;
    }

    public void setNucleinCheckTime(Date nucleinCheckTime) {
        this.nucleinCheckTime = nucleinCheckTime;
    }

    public Integer getNucleinResult() {
        return nucleinResult;
    }

    public void setNucleinResult(Integer nucleinResult) {
        this.nucleinResult = nucleinResult;
    }

    public String getKeyAreaInfo() {
        return keyAreaInfo;
    }

    public void setKeyAreaInfo(String keyAreaInfo) {
        this.keyAreaInfo = keyAreaInfo == null ? null : keyAreaInfo.trim();
    }

    public String getTownLeader() {
        return townLeader;
    }

    public void setTownLeader(String townLeader) {
        this.townLeader = townLeader == null ? null : townLeader.trim();
    }

    public String getTownPhone() {
        return townPhone;
    }

    public void setTownPhone(String townPhone) {
        this.townPhone = townPhone == null ? null : townPhone.trim();
    }

    public String getCommunityLeader() {
        return communityLeader;
    }

    public void setCommunityLeader(String communityLeader) {
        this.communityLeader = communityLeader == null ? null : communityLeader.trim();
    }

    public String getCommunityPhone() {
        return communityPhone;
    }

    public void setCommunityPhone(String communityPhone) {
        this.communityPhone = communityPhone == null ? null : communityPhone.trim();
    }

    public String getPoliceName() {
        return policeName;
    }

    public void setPoliceName(String policeName) {
        this.policeName = policeName == null ? null : policeName.trim();
    }

    public String getPolicePhone() {
        return policePhone;
    }

    public void setPolicePhone(String policePhone) {
        this.policePhone = policePhone == null ? null : policePhone.trim();
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName == null ? null : doctorName.trim();
    }

    public String getDoctorPhone() {
        return doctorPhone;
    }

    public void setDoctorPhone(String doctorPhone) {
        this.doctorPhone = doctorPhone == null ? null : doctorPhone.trim();
    }

    public String getGridName() {
        return gridName;
    }

    public void setGridName(String gridName) {
        this.gridName = gridName == null ? null : gridName.trim();
    }

    public String getGridPhone() {
        return gridPhone;
    }

    public void setGridPhone(String gridPhone) {
        this.gridPhone = gridPhone == null ? null : gridPhone.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public Integer getIsTownPush() {
        return isTownPush;
    }

    public void setIsTownPush(Integer isTownPush) {
        this.isTownPush = isTownPush;
    }

    public Integer getIsIsolationPush() {
        return isIsolationPush;
    }

    public void setIsIsolationPush(Integer isIsolationPush) {
        this.isIsolationPush = isIsolationPush;
    }

    public Integer getIsolationId() {
        return isolationId;
    }

    public void setIsolationId(Integer isolationId) {
        this.isolationId = isolationId;
    }
}