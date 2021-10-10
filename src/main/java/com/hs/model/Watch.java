package com.hs.model;

public class Watch {
    private Integer id;

    private String watchname;

    private Integer brand;

    private Integer type;

    private Integer fixprice;

    private Integer status;

    private String userAddress;

    private String userName;

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