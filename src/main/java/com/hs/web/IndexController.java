package com.hs.web;

import com.hs.model.Role;
import com.hs.model.Type;
import com.hs.model.User;
import com.hs.service.MenuService;
import com.hs.service.UserService;
import com.hs.utils.MD5Utils;
import com.hs.utils.SessionUtil;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {

    @Autowired
    private MenuService menuService;
    @Autowired
    private UserService userService;

    /**
     * 跳转首页
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "index";
    }

    @RequestMapping("/usersetting")
    public String usersetting(){
        return "user-setting";
    }

    /**
     * 获取菜单列表
     * @return
     */
    @RequestMapping("/menu.json")
    @ResponseBody
    public Map getMenus(){
        //从shiro的session中获取角色ID
        User user=(User)SessionUtil.getPrimaryPrincipal();
        Map<String,Object> map=menuService.getMenuByRoleId(user.getRoleId());
        return map;
    }

    /**
     * 修改密码页面
     * @return
     */
    @RequestMapping("/editpassword")
    public String EditPassword(){
        return "user-password";
    }

    /**
     * 修改密码
     * @param oldpassword
     * @param newpassword
     * @return
     */
    @RequestMapping("/passwordupdate")
    @ResponseBody
    public String passwordUpdate(String oldpassword,String newpassword){
        Map map=new HashMap();
        User user= (User) SessionUtil.getPrimaryPrincipal();
        if(MD5Utils.getMD5(oldpassword).equals(user.getPassword())){
            int result=userService.updateUserPassword(user.getId(),newpassword);
            if(result==1){
                return "ok";
            }else{
                return "no";
            }
        }else{
            return "error";
        }
    }

    /**
     * 充值页面
     * @return
     */
    @RequestMapping("/addbalance")
    public String AddBalance(){
        return "customer/addbalance";
    }

    /**
     * 客户充值
     * @param money
     * @return
     */
    @RequestMapping("/balanceupdate")
    @ResponseBody

    public Map balanceUpdate(Integer money){
        Map map=new HashMap();
        if(money>10000){
            map.put("code","question");
            return map;
        }
        //获取当前登录用户信息
        User user= (User) SessionUtil.getPrimaryPrincipal();
        //在数据库中给当前用户加钱
        int result=userService.updateUserBalance(user.getId(),money);
        if(result==1) {
            map.put("msg","充值成功！您所剩余额："+userService.selectBalanceById(user.getId())+"元");
            map.put("code","ok");
            return map;
        }
        map.put("code","error");
        return map;
    }
}
