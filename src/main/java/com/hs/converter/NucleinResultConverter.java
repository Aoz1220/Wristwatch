package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 * 核算检测结果转换器
 */
public class NucleinResultConverter implements Converter<Integer> {


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
        String nucleinResult=cellData.getStringValue();
        if("阴".equals(nucleinResult)){
            result=0;
        }else if("阳".equals(nucleinResult)){
            result=1;
        }
        return result;
    }

    @Override
    public CellData convertToExcelData(Integer nucleinResult, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        String result=null;
        //判断属性名称
        if(excelContentProperty.getField().getName().equals("nucleinResult")){
            if(nucleinResult==1){
                result="阳";
            }else {
                result="阴";
            }
        }else{//其他属性直接输出，注意只能输出字符串，所以整型要转换成String
            if(nucleinResult==null){
                result="";
            }else{
                result=nucleinResult+"";
            }
        }
        CellData celldata = new CellData(result);
        return celldata;
    }
}

