package com.zhuhai.mapper;

import com.zhuhai.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zhuhai
 * Date: 2016/6/16
 * Time: 15:18
 */
public interface UserMapper {

    public void createUser(User user);

    public void updateUser(User user);

    public void deleteUser(long userId);

    public User findById(long userId);

    public List<User> findAll();

    public User findByUserName(String userName);

    public void lockOrUnLockUser(@Param("ids") Long[] ids,@Param("lock") boolean lock);
}
