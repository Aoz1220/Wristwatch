package com.hs.web;


import com.google.code.kaptcha.Constants;
import com.hs.model.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    /**
     * 跳转到登录页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * 登录
     * @return
     */
    @RequestMapping("/login/do")
    @ResponseBody
    public String doLogin(User user, String captcha, boolean rememberMe, HttpSession session){
        //判断验证码是否正确
        String realKaptcha= (String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
        if(!realKaptcha.equals(captcha)){
            return "kaptcha";
        }
        //登录验证
        //获取主体
        Subject subject=SecurityUtils.getSubject();
        //生成登录令牌token
        UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(),user.getPassword(),rememberMe);
        //执行登录
        try{
            subject.login(token);
        }catch(Exception e){
            e.printStackTrace();
            System.out.println("登录认证失败");
        }
        //将登录用户的信息保存到shiro的session中
        if(subject.isAuthenticated()){
            //获取登录人信息
            User u=(User)subject.getPrincipal();
            //获取shiro session
            session.setAttribute("user",u);
            return "ok";
        }
        return "error";
    }
}
