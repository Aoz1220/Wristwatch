package com.hs.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

/**
 * 性别转换器
 */
public class GenderConverter implements Converter<Integer> {


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
        //return (Integer) ("男".equals(cellData.getStringValue())?1:0);
        Integer result=null;
        String gender=cellData.getStringValue();
        if("男".equals(gender)){
            result=1;
        }else if("女".equals(gender)){
            result=0;
        }
        return result;
    }

    @Override
    public CellData convertToExcelData(Integer gender, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
       // CellData data = new CellData((gender==1)?"男":"女");(参数Integer gender)
        //return data;
        String result=null;
        //判断属性名称
        if(excelContentProperty.getField().getName().equals("gender")){
            if(gender==1){
                result="男";
            }else {
                result="女";
            }
        }else{//其他属性直接输出，注意只能输出字符串，所以整型要转换成String
            if(gender==null){
                result="";
            }else{
                result=gender+"";
            }
        }
        CellData celldata = new CellData(result);
        return celldata;
    }
}
