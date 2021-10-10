package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 *分类转换器
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
        String type=cellData.getStringValue();
        if("待处理".equals(type)){
            result=0;
        }else if("正常".equals(type)){
            result=1;
        }else if("待隔离".equals(type)){
            result=2;
        }else if("居家隔离中".equals(type)){
            result=3;
        }else if("解除居家隔离".equals(type)){
            result=4;
        }else if("集中隔离中".equals(type)){
            result=5;
        }else if("解除集中隔离".equals(type)){
            result=6;
        }else if("信息修正".equals(type)){
            result=7;
        }else {
            result=0;
        }
        return result;
    }

    @Override
    public CellData convertToExcelData(Integer data, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        String result=null;
        //判断属性名称
        if(excelContentProperty.getField().getName().equals("status")){
            if(data==0){
                result="待处理";
            }else if(data==1){
                result="正常";
            }else if(data==2){
                result="待隔离";
            }else if(data==3){
                result="居家隔离中";
            }else if(data==4){
                result="解除居家隔离";
            }else if(data==5){
                result="集中隔离中";
            }else if(data==6){
                result="解除集中隔离";
            }else if(data==7){
                result="信息修正";
            }else {
                result="待处理";
            }
        }else{//其他属性直接输出，注意只能输出字符串，所以整型要转换成String
            if(data==null){
                result="";
            }else{
                result=data+"";
            }
        }
        CellData celldata = new CellData(result);
        return celldata;
    }
}
