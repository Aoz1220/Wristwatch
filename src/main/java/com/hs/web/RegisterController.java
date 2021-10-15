package com.hs.web;

import com.google.code.kaptcha.Constants;
import com.hs.model.User;
import com.hs.service.UserService;
import com.hs.utils.MD5Utils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class RegisterController {


    @Autowired
    private UserService userService;

    /**
     * 跳转注册页面
     * @return
     */
    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    /**
     * 客户注册
     * @return
     */
    @RequestMapping("/register/do")
    @ResponseBody
    public String doRegister(String username,String password,String realname,String tel, String captcha,HttpSession session){
        //判断验证码是否正确
        String realKaptcha= (String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
        if(!realKaptcha.equals(captcha)){
            System.out.println("kaptcha");
            return "kaptcha";
        }
        //判断用户名是否已存在
        User hasUser=userService.getUserByUsername(username);
        if(hasUser!=null){
            System.out.println("exist");
            return "exist";
        }
        if(password.length()<6 || password.length()>16){
            System.out.println("question");
            return "question";
        }
        int result=userService.register(username,password,realname,tel);
        if(result==1){
            System.out.println("ok");
            return "ok";
        }else{
            System.out.println("error");
            return "error";
        }
    }
}
