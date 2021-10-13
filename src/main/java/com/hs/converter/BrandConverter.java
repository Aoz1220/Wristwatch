package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 *分类转换器
 */
public class BrandConverter implements Converter<Integer> {


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
        return null;
    }


    @Override
    public CellData convertToExcelData(Integer data, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        String result=null;
        //判断属性名称
        if(excelContentProperty.getField().getName().equals("brand")){
            if(data==1){
                result="欧米茄";
            }else if(data==2){
                result="阿然表";
            }else if(data==3){
                result="周阳表";
            }else if(data==4){
                result="蒋一铭表";
            }else if(data==6){
                result="林澳表";
            }else if(data==7){
                result="电子表1号";
            }else if(data==8){
                result="机械手表1号";
            }else if(data==9){
                result="智能手表1号";
            }else if(data==10){
                result="智能手表2号";
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