package com.hs.web.factory;

import com.github.pagehelper.PageInfo;
import com.hs.common.Constants;
import com.hs.model.*;
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
@RequestMapping("/factory")
public class FactoryController {


    @Autowired
    private UserService userService;

    @Autowired
    private WatchService watchService;

    /**
     * 跳转到待维修腕表列表页面
     * @return
     */
    @RequestMapping("/watch/waiting")
    public String toWatchWaiting(Model model){
        User user=(User) SessionUtil.getPrimaryPrincipal();
        List<Brand> brandListAll=userService.getBrandByTypeId(user.getTypeId());
        model.addAttribute("brandListAll",brandListAll);
        return "factory/watch-list-waiting";
    }

    /**
     * 待修理列表数据查询
     * @param watchname
     * @param username
     * @param brandId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/watch/waiting/data.json")
    @ResponseBody
    public Map getWatchWaitingData(String watchname, String username, Integer brandId, Integer page, Integer limit){
        Map map=new HashMap();
        //获取登录人修理腕表类型ID
        User user= (User)SessionUtil.getPrimaryPrincipal();
        //查询该类型腕表列表
        List<Watch> list=watchService.getWatchList(user.getTypeId(),watchname,username,brandId, Constants.WATCH_STATUS_5,page,limit);
        PageInfo<Watch> pageInfo=new PageInfo<Watch>(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }

    /**
     * 开始维修腕表
     * @param watchId
     * @return
     */
    @RequestMapping("/watch/fix/start")
    @ResponseBody
    public String startWatchFix(Integer watchId){
        int result=watchService.updateWatchFixForStart(watchId,new Date());
        if (result == 2) {
            return "ok";
        }
        return "error";
    }

    /**
     * 跳转到维修中腕表列表页面
     * @return
     */
    @RequestMapping("/watch/going")
    public String toWatchGoing(Model model){
        User user=(User) SessionUtil.getPrimaryPrincipal();
        List<Brand> brandListAll=userService.getBrandByTypeId(user.getTypeId());
        model.addAttribute("brandListAll",brandListAll);
        return "factory/watch-list-going";
    }

    @RequestMapping("/watch/going/data.json")
    @ResponseBody
    public Map getWatchGoingData(String watchname, String username, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        //获取登录人修理腕表类型id
        User user = (User) SessionUtil.getPrimaryPrincipal();
        //查询该类型腕表列表
        List<Watch> list = watchService.getWatchListWithTime(user.getTypeId(),watchname,username,brandId, Constants.WATCH_STATUS_6,page,limit);
        PageInfo<Watch> pageInfo = new PageInfo<Watch>(list);

        //封装返回接口
        map.put("code", "0");
        map.put("msg", "");
        map.put("count", pageInfo.getTotal());
        map.put("data", pageInfo.getList());

        return map;
    }

    /**
     * 结束维修腕表
     * @param watchId
     * @return
     */
    @RequestMapping("/watch/fix/end")
    @ResponseBody
    public String endWatchFix(Integer watchId){
        int result=watchService.updateWatchFixForEnd(watchId,new Date());
        if (result == 2) {
            return "ok";
        }
        return "error";
    }

    /**
     * 跳转到维修记录页面
     * @return
     */
    @RequestMapping("/watch/history")
    public String toWatchHistory(Model model){
        User user=(User) SessionUtil.getPrimaryPrincipal();
        List<Brand> brandListAll=userService.getBrandByTypeId(user.getTypeId());
        model.addAttribute("brandListAll",brandListAll);
        return "factory/watch-list-history";
    }

    @RequestMapping("/watch/history/data.json")
    @ResponseBody
    public Map getWatchHistoryData(String watchname, String username, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        //获取登录人修理腕表类型id
        User user = (User) SessionUtil.getPrimaryPrincipal();
        //查询该类型腕表记录
        List<Watch> list = watchService.getWatchListWithTime(user.getTypeId(),watchname,username,brandId, Constants.WATCH_STATUS_7,page,limit);
        PageInfo<Watch> pageInfo = new PageInfo<Watch>(list);

        //封装返回接口
        map.put("code", "0");
        map.put("msg", "");
        map.put("count", pageInfo.getTotal());
        map.put("data", pageInfo.getList());

        return map;
    }
}
