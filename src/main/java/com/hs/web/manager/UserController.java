package com.hs.web.manager;

import com.github.pagehelper.PageInfo;
import com.hs.model.*;
import com.hs.utils.SessionUtil;
import org.springframework.web.bind.annotation.PathVariable;
import com.hs.service.RoleService;
import com.hs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/manager")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    /**
     * 跳转到客户列表界面
     * @return
     */
    @RequestMapping("/user/list")
    public String toUserList(Model model){
        //查询行政区 下拉列表
        List<Role> roleList=userService.getRoleAll();
        //参数返回页面
        model.addAttribute("roleList",roleList);

        return "manager/user-list";
    }

    /**
     * 获取列表数据
     * @param username
     * @param roleId
     * @param page  当前要查询的页面
     * @param limit 分页，每一页显示的数量
     * @returnuser/delete
     */
    @RequestMapping("/user/list/data.json")
    @ResponseBody
    public Map getUserListData(String username, Integer roleId,Integer typeId,Integer page,Integer limit){
        Map map=new HashMap();
        //查询列表数据
        List<Map> list=userService.getUserListByKeys(username,roleId,typeId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }

    /**
     * 删除客户
     * @param id
     * @return
     */
    @RequestMapping("/user/delete")
    @ResponseBody
    public String deleteUser(Integer id) {
        int result=userService.deleteUser(id);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 批量删除用户
     * @param ids
     * @return
     */
    @RequestMapping("/user/deleteArray")
    @ResponseBody
    public String deleteArrayUser(Integer[] ids) {
        int result=userService.deleteUsers(ids);
        if(result>0) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 跳转到用户添加页面
     * @return
     */
    @RequestMapping("/user/add")
    public String toUserAdd(Model model){
        //查询行政区、角色 下拉列表
        List<Role> roleList=userService.getRoleAll();
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("roleList",roleList);
        model.addAttribute("typeList",typeList);
        return "manager/user-add";
    }

    /**
     * 保存用户
     * @param user
     * @return
     */
    @RequestMapping("/user/save")
    @ResponseBody
    public String saveUser(User user){
        //判断用户名是否已存在
        User hasUser=userService.getUserByUsername(user.getUsername());
        if(hasUser!=null){
            return "exist";
        }
        int result=userService.saveUser(user);
        if(result==1){
            return "ok";
        }
        return "error";
    }

    /**
     * 跳转到用户编辑页面
     * @param model
     * @param username
     * @return
     */
    @RequestMapping("/user/edit/{username}")
    public String editUser(Model model,@PathVariable("username")String username){
        List<Role> roleList=userService.getRoleAll();
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("roleList",roleList);
        model.addAttribute("typeList",typeList);
        User user=userService.getUserByUsername(username);
        //获取地区iD，方便编辑页面获取镇（街道）、隔离点
        Integer roleId=user.getRoleId();
        model.addAttribute("typeList",typeList);
        model.addAttribute("user",user);
        return "manager/user-edit";
    }

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    @RequestMapping("/user/update")
    @ResponseBody
    public String updateUser(User user){
        //判断用户名是否已存在
        User hasUser=userService.getUserByUsername(user.getUsername());
        if(hasUser!=null && (hasUser.getId()!=user.getId())){
            return "exist";
        }
        int result=userService.updateUser(user);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 更新基本资料
     * @param tel
     * @param realname
     * @return
     */
    @RequestMapping("/user/setting")
    @ResponseBody
    public String updateUsersetting(String tel,String realname){
        User user= (User) SessionUtil.getPrimaryPrincipal();
        int result=userService.updateUserSetting(user.getId(),tel,realname);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }
}
