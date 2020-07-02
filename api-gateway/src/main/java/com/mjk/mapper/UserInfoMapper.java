package com.mjk.mapper;

import com.mjk.model.UserInfo;

public interface UserInfoMapper {
    int deleteByPrimaryKey(Integer infoId);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer infoId);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
}