package com.mjk.mapper;

import com.mjk.model.Statistics;

public interface StatisticsMapper {
    int deleteByPrimaryKey(Integer statisticsId);

    int insert(Statistics record);

    int insertSelective(Statistics record);

    Statistics selectByPrimaryKey(Integer statisticsId);

    int updateByPrimaryKeySelective(Statistics record);

    int updateByPrimaryKey(Statistics record);
}