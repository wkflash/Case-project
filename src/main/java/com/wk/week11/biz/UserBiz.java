package com.wk.week11.biz;

import com.wk.week11.entity.UserEntity;

import java.util.List;

/**
 * @author Wangkun
 * @date 2020/6/24
 * @description
 **/
public interface UserBiz {

    /**
     * 登录查询
     * @param userEntity
     * @return
     */
    public UserEntity login(UserEntity userEntity);

    /**
     * 用户名校验
     * @param name
     * @return
     */
    public UserEntity findUserByName(String name);

    /**
     * 邮箱校验
     * @param email
     * @return
     */
    public UserEntity findUserByEmail(String email);

    /**
     * 注册新用户
     * @param userEntity
     * @return
     */
    public  boolean addUser(UserEntity userEntity);

    /**
     * 分页查询
     * @return
     */
    public List<UserEntity> getUserList();

    /**
     * 删除
     * @param id
     * @return
     */
   public boolean delUser(int id);

    /**
     * 改之前要先查
     * @param id
     * @return
     */
   public UserEntity getUserById(Integer id);

    /**
     * 修改
     * @param userEntity
     * @return
     */
   public boolean updUser(UserEntity userEntity);

}
