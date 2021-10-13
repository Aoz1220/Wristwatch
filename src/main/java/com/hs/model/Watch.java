package com.hs.model;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import com.hs.converter.BrandConverter;
import com.hs.converter.StatusConverter;
import com.hs.converter.TypeConverter;

@ContentRowHeight(24)
@HeadRowHeight(50)
@ColumnWidth(25)
public class Watch {
    @ExcelIgnore
    private Integer id;
    @ExcelProperty("腕表名称")
    private String watchname;
    @ExcelProperty(value = "腕表品牌",converter = BrandConverter.class)
    private Integer brand;
    @ExcelProperty(value = "腕表类型",converter = TypeConverter.class)
    private Integer type;
    @ExcelProperty("维修价格（元）")
    private Integer fixprice;
    @ExcelProperty(value = "订单（维修）状态",converter = StatusConverter.class)
    private Integer status;
    @ExcelProperty("持有者地址")
    private String userAddress;
    @ExcelProperty("持有者姓名")
    private String userName;
    @ExcelProperty("持有者联系方式")
    private String userTel;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWatchname() {
        return watchname;
    }

    public void setWatchname(String watchname) {
        this.watchname = watchname;
    }

    public Integer getBrand() {
        return brand;
    }

    public void setBrand(Integer brand) {
        this.brand = brand ;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getFixprice() {
        return fixprice;
    }

    public void setFixprice(Integer fixprice) {
        this.fixprice = fixprice;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress == null ? null : userAddress.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel == null ? null : userTel.trim();
    }
}