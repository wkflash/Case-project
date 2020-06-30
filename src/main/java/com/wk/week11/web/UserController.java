package com.wk.week11.web;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wk.week11.biz.UserBiz;
import com.wk.week11.entity.MsgResultEntity;
import com.wk.week11.entity.UserEntity;
import com.wk.week11.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.UUID;

/**
 * @author Wangkun
 * @date 2020/6/24
 * @description
 **/
@Controller
public class UserController {
    Utils utils=new Utils();
    MsgResultEntity mr=new  MsgResultEntity();
    @Autowired
    UserBiz userBiz;

    /**
     * 登录
     * @param userEntity
     * @param request
     * @return
     */
    @RequestMapping("/login.do")
    @ResponseBody
    public MsgResultEntity login(UserEntity userEntity, HttpServletRequest request){

        String name = userEntity.getName();
        String password = userEntity.getPassword();

        if (utils.isEmpty(name)||utils.isEmpty(password)){
            mr.setMsg("isNull");
            mr.setResult("不能为空");
            return mr;
        }

        UserEntity user = userBiz.login(userEntity);

        if (user!=null){
            if (user.getName().equals(name)&&user.getPassword().equals(password)){
                if ("是".equals(user.getIs_admin())){
                    mr.setMsg("index_admin");
                    request.getSession().setAttribute("admin",user);

                    return mr;

                }else{
                    mr.setMsg("index_user");
                    request.getSession().setAttribute("user",user);
                    String filePath = user.getImage();
                    String fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
                    request.getSession().setAttribute("fileName",fileName);
                    return mr;
                }
            }else {
                mr.setMsg("loginWorng");
                mr.setResult("用户名或密码错误");
                return mr;
            }

        }else {
            mr.setMsg("loginNull");
            mr.setResult("用户不存在");
            return mr;
        }



    }

    /**
     * 分页查找
     * @param pageNum
     * @param pageSize
     * @param request
     * @return
     */
    @RequestMapping("/query.do")
    public  String queryUserList(String pageNum, String pageSize, HttpServletRequest request){
        if (utils.isEmpty(pageNum)){
            pageNum="1";
        }else {
            pageNum=pageNum;
        }


        if (utils.isEmpty(pageSize)){
            pageSize="4";
        }else {
            pageSize=pageSize;
        }

        PageHelper.startPage(Integer.parseInt(pageNum),Integer.parseInt(pageSize));
        List<UserEntity> userList = userBiz.getUserList();
        request.getSession().setAttribute("userList",userList);

        PageInfo<UserEntity> pageInfo=new PageInfo<UserEntity>(userList);
        request.setAttribute("pageInfo",pageInfo);

        return "member-list";
    }



    @RequestMapping("/del.do")
    @ResponseBody
    public MsgResultEntity delUser(int id){
        if (utils.isEmpty(String.valueOf(id))){
            mr.setMsg("isNull");
            mr.setResult("不能为空");
            return mr;
        }

        boolean isOK = userBiz.delUser(id);
        if (isOK){
            mr.setMsg("delSuccess");
            return mr;
        }else {
            mr.setMsg("delFail");
            mr.setResult("删除失败");
            return mr;
        }


    }


    /**
     * 修改
     * @param id
     * @param flg
     * @param userEntity
     * @param request
     * @return
     */
/*    @RequestMapping("/upd.do")
    @ResponseBody
    public MsgResultEntity updUser(Integer id,String flg,UserEntity userEntity,HttpServletRequest request){

        if (utils.isEmpty(String.valueOf(id))){
            mr.setMsg("idIsNull");
            mr.setResult("当前id为空");
            return mr;
        }
        if (flg==null){
            UserEntity userOne = userBiz.getUserById(id);
            if (userOne!=null){
                request.getSession().setAttribute("userOne",userOne);
                mr.setMsg("getOneUser");
                return mr;
            }else {
                mr.setMsg("getOneUserFail");
                mr.setResult("要修改的数据显示失败");
                return mr;
            }

        }else {
            String name = userEntity.getName();
            String password = userEntity.getPassword();
            String email = userEntity.getEmail();

            if (utils.isEmpty(name)||utils.isEmpty(password)||utils.isEmpty(email)){
                mr.setMsg("updIsNull");
                mr.setResult("不能为空");
                return mr;
            }

            boolean isOK = userBiz.updUser(userEntity);
            if (isOK){
                mr.setMsg("updSuccess");
                return mr;
            }else {
                mr.setMsg("updFail");
                mr.setResult("修改失败");
                return mr;
            }

        }

    }*/
    /**
     * 回魂
     * @param id
     * @param
     * @param
     * @param request
     * @return
     */
    @RequestMapping("/upd2.do")
    public String getUser(Integer id,HttpServletRequest request){

        if (utils.isEmpty(String.valueOf(id))){
            return "";
        }

            UserEntity userOne = userBiz.getUserById(id);
            if (userOne!=null){
                request.getSession().setAttribute("userOne",userOne);
                return "member-edit";
            }else {
                return "";
            }

    }

    @RequestMapping("/upd3.do")
    @ResponseBody
    public MsgResultEntity updUser(UserEntity userEntity,HttpServletRequest request){
        int id = userEntity.getId();
        String name = userEntity.getName();
        String password = userEntity.getPassword();
        String email = userEntity.getEmail();

        if (utils.isEmpty(String.valueOf(id))||utils.isEmpty(name)||utils.isEmpty(password)||utils.isEmpty(email)){
            mr.setMsg("updIsNull");
            mr.setResult("不能为空");
            return mr;
        }

        boolean isOK = userBiz.updUser(userEntity);
        if (isOK){
            mr.setMsg("updSuccess");
            return mr;
        }else {
            mr.setMsg("updFail");
            mr.setResult("修改失败");
            return mr;
        }
    }



    /**
     * 用户名唯一校验
     * @param name
     * @return
     */
    @RequestMapping("/findUser.do")
    @ResponseBody
    public MsgResultEntity findUserByUname(String name){

        if (utils.isEmpty(name)){
            mr.setMsg("userNameNull");
            mr.setResult("用户名不能为空");
            return mr;
        }


        UserEntity user = userBiz.findUserByName(name);

        if(user!=null){

            mr.setMsg("userExist");
            mr.setResult("×用户已存在,换一个试试");
            return mr;
        }else {
            mr.setMsg("userNotExist");
            mr.setResult("√用户名可用");
            return mr;
        }

    }


    /**
     * 邮箱唯一校验
     * @param email
     * @return
     */
    @RequestMapping("/findUserEmail.do")
    @ResponseBody
    public MsgResultEntity findUserByEamil(String email){

        if (utils.isEmpty(email)){
            mr.setMsg("userEmailNull");
            mr.setResult("邮箱不能为空");
            return mr;
        }

        UserEntity user = userBiz.findUserByEmail(email);

        if(user!=null){
            mr.setMsg("emailExist");
            mr.setResult("×邮箱已注册");
            return mr;
        }else {
            mr.setMsg("emailNotExist");
            mr.setResult("√邮箱可用");
            return mr;
        }

    }

   /**
     * 两次密码校验
     * @param repass
     * @param password
     * @return
     */

    @RequestMapping("/checkPassword.do")
    @ResponseBody
    public MsgResultEntity checkPassword(String repass,String password){

        if (utils.isEmpty(repass)){
            mr.setMsg("passwordNull");
            mr.setResult("不能为空");
            return mr;
        }

        if (!repass.equals(password)){
            mr.setMsg("passwordNotSame");
            mr.setResult("×两次密码不相等");
            return mr;
        }else {
            mr.setMsg("passwordSame");
            mr.setResult("√两次密码相等");
            return mr;
        }


    }

    /**
     * 注册新用户
     * @param userEntity
     * @param request
     * @return
     */
    @RequestMapping("/regist.do")
    public String regist(MultipartFile headImage, UserEntity userEntity,  HttpServletRequest request) throws IOException {

        if (utils.isEmpty(String.valueOf(headImage))||utils.isEmpty(userEntity.getName())||utils.isEmpty(userEntity.getPassword())||utils.isEmpty(userEntity.getEmail())){
            request.getSession().setAttribute("msg","不能为空");
            return "regist";
        }
        InputStream is = headImage.getInputStream(); //文件的输入流

        //指定一个文件上传的路径 ;上传到tomcat部署的位置; 获取我们代码所在的真实路径
        String path = request.getSession().getServletContext().getRealPath("upload");

        //如果当前获取的路径不存在,咱们就创建一个目录
        File file = new File(path);
        if(!file.exists()){
            file.mkdir();
        }

        //指定图片名称;
        String filename = headImage.getOriginalFilename();
        long size = headImage.getSize();
        String suffix = filename.substring(filename.lastIndexOf("."));
        String newName = UUID.randomUUID().toString().replace("-","") + suffix;

        //使用新的文件名,构建一个输出流
        FileOutputStream fos = new FileOutputStream(path+File.separator+newName);

        //将输入流里面的信息,通过指定的输入流的写到目的文件
        FileCopyUtils.copy(is,fos);

        //保存图片路径;
        String savePath = "upload"+File.separator+newName;
        userEntity.setImage(savePath);


            boolean isOK = userBiz.addUser(userEntity);
            if (isOK){
                request.setAttribute("msg", "添加成功");
                request.getSession().setAttribute("filename", filename);
                return "login";

            }else {
                request.setAttribute("msg", "添加失败");
            }


        return "login";
    }

    /**
     * 下载
     * @param fileName
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/download.do")
//    @ResponseBody
    public  void download(String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String path = request.getSession().getServletContext().getRealPath("upload");
        FileInputStream fs = new FileInputStream(path+File.separator+fileName);
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);

        //将输入流的数据写出到输出流中
        ServletOutputStream sos = response.getOutputStream();
        byte[] buff = new byte[1024 * 8];
        int len = 0;
        while((len = fs.read(buff)) != -1){
            sos.write(buff,0,len);
        }

        fs.close();
    }

}
