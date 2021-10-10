package com.hs.model;

public class TbSysIsolation {
    private Integer id;

    private String isolationName;

    private Integer regionId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIsolationName() {
        return isolationName;
    }

    public void setIsolationName(String isolationName) {
        this.isolationName = isolationName == null ? null : isolationName.trim();
    }

    public Integer getRegionId() {
        return regionId;
    }

    public void setRegionId(Integer regionId) {
        this.regionId = regionId;
    }
}