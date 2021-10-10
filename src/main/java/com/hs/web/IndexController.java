package com.hs.web;

import com.hs.model.Role;
import com.hs.model.Type;
import com.hs.model.User;
import com.hs.service.MenuService;
import com.hs.service.UserService;
import com.hs.utils.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
     * @param user
     * @return
     */
    @RequestMapping("/passwordupdate")
    @ResponseBody
    public String passwordUpdate(User user){
        int result=userService.updateUserPassword(user);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }
}
