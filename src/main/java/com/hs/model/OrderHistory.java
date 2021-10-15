package com.hs.model;

import java.util.Date;

public class OrderHistory {

    private Integer id;

    private Date finishTime;

    private Integer watchId;

    private String refundReason;

    private Integer refundPrice;

    private String refuseReason;

    private String score;

    private Date scoreTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Date finishTime) {
        this.finishTime = finishTime;
    }

    public Integer getWatchId() {
        return watchId;
    }

    public void setWatchId(Integer watchId) {
        this.watchId = watchId;
    }

    public String getRefundReason() {
        return refundReason;
    }

    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }

    public Integer getRefundPrice() {
        return refundPrice;
    }

    public void setRefundPrice(Integer refundPrice) {
        this.refundPrice = refundPrice;
    }

    public String getRefuseReason() {
        return refuseReason;
    }

    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public Date getScoreTime() {
        return scoreTime;
    }

    public void setScoreTime(Date scoreTime) {
        this.scoreTime = scoreTime;
    }
}
