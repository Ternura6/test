package com.mjk.model;

import java.util.Date;

public class Channel {
    private Integer channelId;

    private String channelName;

    private String channelLogo;

    private String channelCover;

    private String channelBackground;

    private Integer channelType;

    private Integer channelWay;

    private String channelBrief;

    private String channelClick;

    private Integer channelPath;

    private Date channelBtime;

    private Date channelEtime;

    private String channelVcard;

    private String channelPattern;

    private String channelRecord;

    private Integer channelMaxpersion;

    private Integer channelSpeak;

    public Integer getChannelId() {
        return channelId;
    }

    public void setChannelId(Integer channelId) {
        this.channelId = channelId;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName == null ? null : channelName.trim();
    }

    public String getChannelLogo() {
        return channelLogo;
    }

    public void setChannelLogo(String channelLogo) {
        this.channelLogo = channelLogo == null ? null : channelLogo.trim();
    }

    public String getChannelCover() {
        return channelCover;
    }

    public void setChannelCover(String channelCover) {
        this.channelCover = channelCover == null ? null : channelCover.trim();
    }

    public String getChannelBackground() {
        return channelBackground;
    }

    public void setChannelBackground(String channelBackground) {
        this.channelBackground = channelBackground == null ? null : channelBackground.trim();
    }

    public Integer getChannelType() {
        return channelType;
    }

    public void setChannelType(Integer channelType) {
        this.channelType = channelType;
    }

    public Integer getChannelWay() {
        return channelWay;
    }

    public void setChannelWay(Integer channelWay) {
        this.channelWay = channelWay;
    }

    public String getChannelBrief() {
        return channelBrief;
    }

    public void setChannelBrief(String channelBrief) {
        this.channelBrief = channelBrief == null ? null : channelBrief.trim();
    }

    public String getChannelClick() {
        return channelClick;
    }

    public void setChannelClick(String channelClick) {
        this.channelClick = channelClick == null ? null : channelClick.trim();
    }

    public Integer getChannelPath() {
        return channelPath;
    }

    public void setChannelPath(Integer channelPath) {
        this.channelPath = channelPath;
    }

    public Date getChannelBtime() {
        return channelBtime;
    }

    public void setChannelBtime(Date channelBtime) {
        this.channelBtime = channelBtime;
    }

    public Date getChannelEtime() {
        return channelEtime;
    }

    public void setChannelEtime(Date channelEtime) {
        this.channelEtime = channelEtime;
    }

    public String getChannelVcard() {
        return channelVcard;
    }

    public void setChannelVcard(String channelVcard) {
        this.channelVcard = channelVcard == null ? null : channelVcard.trim();
    }

    public String getChannelPattern() {
        return channelPattern;
    }

    public void setChannelPattern(String channelPattern) {
        this.channelPattern = channelPattern == null ? null : channelPattern.trim();
    }

    public String getChannelRecord() {
        return channelRecord;
    }

    public void setChannelRecord(String channelRecord) {
        this.channelRecord = channelRecord == null ? null : channelRecord.trim();
    }

    public Integer getChannelMaxpersion() {
        return channelMaxpersion;
    }

    public void setChannelMaxpersion(Integer channelMaxpersion) {
        this.channelMaxpersion = channelMaxpersion;
    }

    public Integer getChannelSpeak() {
        return channelSpeak;
    }

    public void setChannelSpeak(Integer channelSpeak) {
        this.channelSpeak = channelSpeak;
    }
}