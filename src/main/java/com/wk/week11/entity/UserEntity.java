package com.wk.week11.entity;

/**
 * @author Wangkun
 * @date 2020/6/24
 * @description
 **/

public class UserEntity {
    private int id;
    private String name;
    private String password;
    private String image;
    private String email;
    private String is_admin;

    public UserEntity(int id, String name, String password, String image, String email, String is_admin) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.image = image;
        this.email = email;
        this.is_admin = is_admin;
    }

    public UserEntity() {
    }

    @Override
    public String toString() {
        return "UserEntity{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", image='" + image + '\'' +
                ", email='" + email + '\'' +
                ", is_admin='" + is_admin + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIs_admin() {
        return is_admin;
    }

    public void setIs_admin(String is_admin) {
        this.is_admin = is_admin;
    }
}
