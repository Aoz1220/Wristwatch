package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 *分类转换器
 */
public class TypeConverter implements Converter<Integer> {


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
        if("绿码".equals(type)){
            result=0;
        }else if("黄码".equals(type)){
            result=1;
        }else if("红码".equals(type)){
            result=2;
        }else {
            result=3;
        }
        return result;
    }

    @Override
    public CellData convertToExcelData(Integer data, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        String result=null;
        //判断属性名称
        if(excelContentProperty.getField().getName().equals("type")){
            if(data==0){
                result="绿码";
            }else if(data==1){
                result="黄码";
            }else if(data==2){
                result="红码";
            }else {
                result="未知";
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
