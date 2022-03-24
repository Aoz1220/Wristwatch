package com.hs.web.store;

import com.github.pagehelper.PageInfo;
import com.hs.model.*;
import com.hs.service.UserService;
import com.hs.service.WatchService;
import com.hs.utils.ExcelUtils;
import com.hs.utils.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/store")
public class WatchController {

    @Autowired
    private UserService userService;
    @Autowired
    private WatchService watchService;
    /**
     * 跳转到腕表列表界面
     * @return
     */
    @RequestMapping("/watch/list")
    public String toWatchList(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);

        return "watch/watch-list";
    }

    /**
     * 跳转到腕表列表界面
     * @return
     */
    @RequestMapping("/watch/history")
    public String toWatchHistoryList(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);

        return "watch/watch-history";
    }
    /**
     * 跳转到腕表列表界面
     * @return
     */
    @RequestMapping("/watch/refuse/history")
    public String toWatchRefuseHistoryList(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);

        return "watch/watch-refuse-history";
    }
    /**
     * 跳转到腕表列表界面
     * @return
     */
    @RequestMapping("/watch/refund/history")
    public String toWatchRefundHistoryList(Model model){
        //腕表类型下拉框数据
        List<Type> typeList=userService.getTypeAll();
        //参数返回页面
        model.addAttribute("typeList",typeList);

        return "watch/watch-refund-history";
    }

    /**
     * 获取列表数据
     * @param watchname
     * @param typeId
     * @param brandId
     * @param page  当前要查询的页面
     * @param limit 分页，每一页显示的数量
     * @returnuser/delete
     */
    @RequestMapping("/watch/list/data.json")
    @ResponseBody
    public Map getWatchListData(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit){
        Map map=new HashMap();
        //查询列表数据
        List<Map> list=watchService.getWatchListByKeys(watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }

    @RequestMapping("/watch/history/data.json")
    @ResponseBody
    public Map getWatchHistoryData(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        List<Map> list=watchService.getHistoryListByKeys(watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
    @RequestMapping("/watch/refuse/history/data.json")
    @ResponseBody
    public Map getRefuseWatchHistoryData(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        List<Map> list=watchService.getRefuseHistoryListByKeys(watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }
    @RequestMapping("/watch/refund/history/data.json")
    @ResponseBody
    public Map getRefundWatchHistoryData(String watchname, Integer typeId, Integer brandId, Integer page, Integer limit) {
        Map map = new HashMap();
        List<Map> list=watchService.getRefundHistoryListByKeys(watchname,typeId,brandId,page,limit);
        PageInfo pageInfo=new PageInfo(list);
        //封装返回接口
        map.put("code","0");
        map.put("msg","");
        map.put("count",pageInfo.getTotal());
        map.put("data",pageInfo.getList());
        return map;
    }


    /**
     * 根据腕表类型查询腕表品牌列表
     * @param typeId
     * @return
     */
    @RequestMapping("/watch/list/brand.json")
    @ResponseBody
    public Map getBrand(Integer typeId){
        List<Brand> brands=watchService.getBrandByTypeId(typeId);
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("brands",brands);
        return map;
    }

    /**
     * 跳转到拒绝维修腕表界面
     * @return
     */
    @RequestMapping("/watch/refusepage/{id}")
    public String toWatchRefusePageList(Model model,@PathVariable("id") String id){
        Watch watch=watchService.getWatchById(id);
        model.addAttribute("watch",watch);
        return "watch/watch-refuse";
    }

    /**
     * 拒绝维修手表
     * @param
     * @return
     */
    @RequestMapping("/watch/refuse")
    @ResponseBody
    public String refuseWatch(Integer watchId,String refusereason) {
        int result=watchService.refuseWatch(watchId);
        result+=watchService.insertWatchOrderForRefuse(watchId,refusereason,new Date());
        System.out.println(result);
        if(result==2) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 跳转到腕表添加页面
     * @return
     */
    @RequestMapping("/watch/add")
    public String toWatchAdd(Model model){
        List<Type> typeList=userService.getTypeAll();
        model.addAttribute("typeList",typeList);
        return "customer/watch-order-add";
    }

    /**
     * 保存腕表信息
     * @param
     * @return
     */
    @RequestMapping("/watch/save")
    @ResponseBody
    public String saveWatch(String watchname, Integer type, Integer brand, String tel, String userAddress){
            //获取登录人修理腕表类型ID
            User user= (User) SessionUtil.getPrimaryPrincipal();
            //判断腕表是否已存在
            Watch hasWatch=watchService.getWatchByWatchname(watchname);
            if(hasWatch!=null){
                return "exist";
            }
            Watch watch=new Watch();
            //设置默认状态
            watch.setStatus(0);
            watch.setUserName(user.getRealname());
            watch.setWatchname(watchname);
            watch.setType(type);
            watch.setBrand(brand);
            watch.setUserTel(tel);
            watch.setUserAddress(userAddress);
            int result=watchService.saveWatch(watch);
            if(result==1){
                return "ok";
            }
            return "error";
    }

    /**
     * 跳转到腕表编辑页面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/watch/edit/{id}")
    public String editWatch(Model model,@PathVariable("id") String id){
        //查询腕表类型下拉框
        List<Type> typeList=userService.getTypeAll();
        Watch watch=watchService.getWatchById(id);
        Integer typeId=watch.getType();
        List<Brand> brandList=watchService.getBrandByTypeId(typeId);
        model.addAttribute("typeList",typeList);
        model.addAttribute("brandList",brandList);
        model.addAttribute("watch",watch);
        return "customer/watch-order-edit";
    }

    /**
     * 跳转到腕表编辑页面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/watch/setprice/{id}")
    public String setPriceWatch(Model model,@PathVariable("id") String id){
        //查询腕表类型下拉框
        List<Type> typeList=userService.getTypeAll();
        Watch watch=watchService.getWatchById(id);
        Integer typeId=watch.getType();
        List<Brand> brandList=watchService.getBrandByTypeId(typeId);
        model.addAttribute("typeList",typeList);
        model.addAttribute("brandList",brandList);
        model.addAttribute("watch",watch);
        return "watch/watch-setprice";
    }

    /**
     * 更新腕表信息
     * @return
     */
    @RequestMapping("/watch/update")
    @ResponseBody
    public String updateWatch(Watch watch){
        //判断腕表是否已存在
        Watch hasWatch=watchService.getWatchByWatchname(watch.getWatchname());
        if(hasWatch!=null && (hasWatch.getId()!=watch.getId())){
            return "exist";
        }
        int result=watchService.updateWatch(watch);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 更新腕表价格
     * @return
     */
    @RequestMapping("/watch/setprice")
    @ResponseBody
    public String updateWatchPrice(Watch watch){
        int result=watchService.updateWatchPrice(watch);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 下放到维修厂
     * @param ids
     * @return
     */
    @RequestMapping("/push/factory")
    @ResponseBody
    public Map pushFactory(Integer[] ids){
        Map map=new HashMap();
        //判断不能下放的腕表
        List<Integer> list=watchService.getWatchCannotPush(ids);
        Integer[] array=new Integer[ids.length-list.size()];
        int index=0;
        for(int i=0;i<ids.length;i++){
            if(list.contains(ids[i])){
                continue;
            }
            array[index]=ids[i];
            index++;

        }
        if(array.length!=0){
            int result=watchService.updateWatchForPushFactory(array);
            if(result>0){
                map.put("msg","成功下放"+array.length+"块腕表到修理厂，"+list.size()+"块腕表维修订单不在可下放状态，不可下放");
                map.put("code","ok");
                return map;
            }
            map.put("code","error");
            return map;
        }
        map.put("msg",list.size()+"块腕表维修订单不在可下放状态，不可下放");
        map.put("code","question");
        return map;
    }
    /**
     * 维修审核
     * @param id
     * @return
     */
    @RequestMapping("/watch/check")
    @ResponseBody
    public String checkWatch(Integer id){
        int result=watchService.checkWatch(id);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 订单付款
     * @param id,fixprice
     * @return
     */
    @RequestMapping("/watch/pay")
    @ResponseBody
    public Map payWatch(Integer id,Integer fixprice){
        Map map=new HashMap();
        //利用shiro获取当前登录用户信息
        User user= (User) SessionUtil.getPrimaryPrincipal();
        if(user.getBalance()>fixprice){
            //将表的状态改为已付款
            int result=watchService.payWatch(id);
            //将刚刚在网页上付的款在数据库用户的余额里减掉
            result+=userService.afterPay(user.getId(),fixprice);
            if(result==2){
                map.put("msg","付款成功！您所剩余额："+userService.selectBalanceById(user.getId())+"元。");
                map.put("code","ok");
                return map;
            }
            map.put("code","error");
            return map;
        }
        map.put("msg","余额不足，请先充值");
        map.put("code","question");
        return map;
    }

    /**
     * 跳转到申请退款界面
     * @return
     */
    @RequestMapping("/watch/refundpage/{id}")
    public String toWatchRefundPageList(Model model,@PathVariable("id") String id){
        Watch watch=watchService.getWatchById(id);
        model.addAttribute("watch",watch);
        return "customer/watch-refund";
    }

    /**
     * 跳转到确认申请退款界面
     * @return
     */
    @RequestMapping("/watch/checkrefundpage/{id}")
    public String toCheckWatchRefundPageList(Model model,@PathVariable("id") String id){
        OrderHistory orderHistory=watchService.getOrderHistoryByWatchId(id);
        Watch watch=watchService.getWatchById(id);
        model.addAttribute("watch",watch);
        model.addAttribute("orderHistory",orderHistory);
        return "watch/watch-checkrefund";
    }

    /**
     * 申请退款
     * @param id
     * @return
     */
    @RequestMapping("/watch/startrefund")
    @ResponseBody
    public Map startRefundWatch(Integer watchId,Integer fixprice,String refundreason) {
        Map map=new HashMap();
        int result = watchService.startRefundWatch(watchId);
        result+=watchService.insertWatchOrderForRefund(watchId,refundreason);
        if(result==2){
            map.put("msg","提交退款申请成功，请耐心等待总店回应");
            map.put("code","ok");
            return map;
        }
        map.put("code","error");
        return map;
    }

    /**
     * 申请退款
     * @param id
     * @return
     */
    @RequestMapping("/watch/checkrefund")
    @ResponseBody
    public Map checkRefundWatch(Integer watchId,Integer refundprice,Integer fixprice,String refundreason) {
        Map map=new HashMap();
        if(refundprice>fixprice){
            map.put("code","question");
            return map;
        }
        int result = watchService.checkRefundWatch(watchId);
        result+=watchService.updateWatchOrderForRefund(watchId,refundreason,refundprice,new Date());
        result+=userService.afterRefund(watchId,refundprice);
        if(result==3){
            map.put("msg","退款成功，已退回"+refundprice+"元");
            map.put("code","ok");
            return map;
        }
        map.put("code","error");
        return map;
    }

    /**
     * 腕表寄回给客户
     * @param ids
     * @return
     */
    @RequestMapping("/sendback")
    @ResponseBody
    public Map sendbackWatch(Integer[] ids){
        Map map=new HashMap();
        //判断不能下放的腕表
        List<Integer> list=watchService.getWatchCannotSendback(ids);
        Integer[] array=new Integer[ids.length-list.size()];
        int index=0;
        for(int i=0;i<ids.length;i++){
            if(list.contains(ids[i])){
                continue;
            }
            array[index]=ids[i];
            index++;

        }
        if(array.length!=0){
            int result=watchService.updateWatchForSendback(array);
            if(result>0){
                map.put("msg","根据用户填写收件人、地址、联系方式，成功寄出"+array.length+"块腕表，"+list.size()+"块腕表已寄出或还未完成维修或仍未开始订单流程，无法寄出");
                map.put("code","ok");
                return map;
            }
            map.put("code","error");
            return map;
        }
        map.put("msg",list.size()+"块腕表已寄出或还未完成维修或仍未开始订单流程，无法寄出");
        map.put("code","question");
        return map;
    }

    /**
     * 接收腕表
     * @param id
     * @return
     */
    @RequestMapping("/watch/instore")
    @ResponseBody
    public String instoreWatch(Integer id){
        int result=watchService.instoreWatch(id);
        if(result==1) {
            return "ok";
        }else {
            return "error";
        }
    }

    /**
     * 导出订单信息表模板
     * @param response
     * @param session
     */
    @RequestMapping("/watch/template")
    public void printExcelTemplate(HttpServletResponse response, HttpSession session){
        List<Watch> list=watchService.getAllWatchList();

        try{
            ExcelUtils.printEasyExcelTemplate(list,"watch-template",response,session);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
