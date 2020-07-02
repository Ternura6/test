package com.mjk.mapper;

import com.mjk.model.RoleAuthority;

public interface RoleAuthorityMapper {
    int deleteByPrimaryKey(Integer relationId);

    int insert(RoleAuthority record);

    int insertSelective(RoleAuthority record);

    RoleAuthority selectByPrimaryKey(Integer relationId);

    int updateByPrimaryKeySelective(RoleAuthority record);

    int updateByPrimaryKey(RoleAuthority record);
}