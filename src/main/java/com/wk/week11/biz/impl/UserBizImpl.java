package com.wk.week11.biz.impl;

import com.wk.week11.biz.UserBiz;
import com.wk.week11.entity.UserEntity;
import com.wk.week11.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Wangkun
 * @date 2020/6/24
 * @description
 **/
@Service
public class UserBizImpl implements UserBiz {
    @Autowired
    UserMapper userMapper;

    /**
     * 登录
     * @param userEntity
     * @return
     */
    @Override
    public UserEntity login(UserEntity userEntity) {
        return userMapper.login(userEntity);
    }

    /**
     * 用户名校验
     * @param name
     * @return
     */
    @Override
    public UserEntity findUserByName(String name) {
        return userMapper.findUserByName(name);
    }

    /**
     * 邮箱校验
     * @param email
     * @return
     */
    @Override
    public UserEntity findUserByEmail(String email) {
        return userMapper.findUserByEmail(email);
    }

    /**
     * 注册
     * @param userEntity
     * @return
     */
    @Override
    public boolean addUser(UserEntity userEntity) {
        return userMapper.addUser(userEntity);
    }

    /**
     * 分页查找
     * @return
     */
    @Override
    public List<UserEntity> getUserList() {
        return userMapper.getUserList();
    }


    /**
     * 删除
     * @param id
     * @return
     */
    @Override
    public boolean delUser(int id) {
        return userMapper.delUser(id);
    }


    /**
     * 改之前要先查
     * @param id
     * @return
     */
    @Override
    public UserEntity getUserById(Integer id) {
        return userMapper.getUserById(id);
    }

    /**
     * 修改
     * @param userEntity
     * @return
     */
    @Override
    public boolean updUser(UserEntity userEntity) {
        return userMapper.updUser(userEntity);
    }

}
