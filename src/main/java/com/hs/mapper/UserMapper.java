package com.hs.mapper;

import com.hs.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteByArray(@Param("ids")Integer[] ids);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    int updateBalanceByPrimaryKey(@Param("id")Integer id, @Param("money")Integer money);

    int updateUserSetting(@Param("id")Integer id, @Param("tel")String tel, @Param("realname")String realname);

    int updateUserPassword(@Param("id") Integer id,@Param("newpassword")String newpassword);

    User selectByUsername(String username);

    List<Map> selectByKeys(@Param("username")String username, @Param("roleId")Integer roleId, @Param("typeId")Integer typeId);

    int PayWatchFix(@Param("id")Integer id,@Param("fixprice") Integer fixprice);

    int RefundWatch(@Param("id")Integer id,@Param("fixprice") Integer fixprice);

    int selectBalanceById(@Param("id")Integer id);
}