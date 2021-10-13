package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 * 分类转换器
 */
public class StatusConverter implements Converter<Integer> {


    @Override
    public Class supportJavaTypeKey() {
        return Integer.class;
    }

    @Override
    public CellDataTypeEnum supportExcelTypeKey() {
        return CellDataTypeEnum.STRING;
    }

    @Override
    public Integer convertToJavaData(CellData cellData, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
       Integer result=null;
       String status= cellData.getStringValue();
       if("待处理".equals(status)){
           result=0;
       }else if ("正常".equals(status)){
           result=1;
       }else if ("待隔离".equals(status)){
           result=2;
       }else if ("居家隔离中".equals(status)){
           result=3;
       }else if ("解除居家隔离".equals(status)){
           result=4;
       }else if ("集中隔离中".equals(status)){
           result=5;
       }else if ("集中隔离解除".equals(status)){
           result=6;
       }else if ("信息修正".equals(status)){
           result=7;
       }
        return result;
    }

    @Override
    public CellData convertToExcelData(Integer data, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        String result = "";
        if (excelContentProperty.getField().getName().equals("status")){
            if (data == 0) {
                result = "等待总店接单";
            } else if (data == 1) {
                result = "待付款";
            } else if (data == 2) {
                result = "待接收";
            } else if (data == 3) {
                result = "等待审核";
            }else if (data == 4) {
                result = "审核成功";
            }else if (data == 5) {
                result = "待维修";
            }else if (data == 6) {
                result = "维修中";
            }else if (data == 7) {
                result = "维修完成";
            }else if (data == 8) {
                result = "待收货";
            }else if (data == 9) {
                result = "订单完成";
            }
        } else{//其他属性直接输出，注意只能双输出字符串，所以整型要转成String
            if (data==null){
                result="";
            }else {
                result=data+"";
            }
        }
        CellData cellData = new CellData(result);
        return cellData;
    }
}
