package com.hs.web.customer;

import com.github.pagehelper.PageInfo;
import com.hs.common.Constants;
import com.hs.model.Brand;
import com.hs.model.Type;
import com.hs.model.User;
import com.hs.model.Watch;
import com.hs.service.UserService;
import com.hs.service.WatchService;
import com.hs.utils.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class OrderController {

    @Autowired
    private UserService userService;
    @Autowired
    private WatchService watchService;

    /**
     * 跳转到腕表列表界面
     * @return
     */
    @RequestMapping("/order/list")
    public String toWatchList(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);

        return "customer/watch-order-list";
    }

    /**
     * 获取当前客户维修腕表订单列表数据
     * @param watchname
     * @param typeId
     * @param brandId
     * @param page  当前要查询的页面
     * @param limit 分页，每一页显示的数量
     * @returnuser/delete
     */
    @RequestMapping("/order/list/data.json")
    @ResponseBody
    public Map getWatchListDataByRealname(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit){
        Map map=new HashMap();
        //获取登录人修理腕表类型ID
        User user= (User) SessionUtil.getPrimaryPrincipal();
        //查询列表数据
        List<Map> list=watchService.getWatchListByRealname(user.getRealname(),watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
    /**
     * 客户收货
     * @param id
     * @return
     */
    @RequestMapping("/watch/receive")
    @ResponseBody
    public String watchReceive(Integer id){
        int result=watchService.updateWatchForReceive(id);
        result+=watchService.updateWatchOrderForEnd(id,new Date());
        if(result==2){
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 跳转到订单记录页面
     * @return
     */
    @RequestMapping("/order/history")
    public String toOrderHistory(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);
        return "customer/watch-order-history";
    }

    @RequestMapping("/order/history/data.json")
    @ResponseBody
    public Map getOrderHistoryData(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        //获取登录人修理腕表类型id
        User user = (User) SessionUtil.getPrimaryPrincipal();
        //查询列表数据
        List<Map> list=watchService.getOrderListByRealname(user.getRealname(),watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
}
