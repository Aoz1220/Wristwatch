package com.hs.utils;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;

import com.hs.converter.GenderConverter;
import com.hs.converter.NucleinResultConverter;
import com.hs.converter.StatusConverter;
import com.hs.converter.TypeConverter;
import com.hs.model.TbResidentInfo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

public class ExcelUtils {

    /**
     * 导出模板
     * @param list
     * @param templateName
     * @param response
     * @param session
     * @throws IOException
     */
    public static <T> void printEasyExcelTemplate(List<T> list, String templateName, HttpServletResponse response, HttpSession session) throws IOException {
        //1.配置对象数据map
        //Map map = new HashMap();
        //2.配置下载属性
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        //下载时的名称
        String filename = URLEncoder.encode(templateName, "UTF-8");
        response.setHeader("Content-disposition", "attachment;filename=" + filename + ".xlsx");
        //3.获取模板路径
        String path = session.getServletContext().getRealPath("/")+"excel_template/"+templateName+".xlsx";
        //4.获取ExcelWrite对象
        ExcelWriter writer = EasyExcel.write(response.getOutputStream())
                .registerConverter(new GenderConverter())//注册性别转换器(有就加)
                .registerConverter(new TypeConverter())//注册分类转换器(有就加)
                .registerConverter(new NucleinResultConverter())//注册核算检测转换器(有就加)
                .registerConverter(new StatusConverter())//注册状态转换器(有就加)
                .head(TbResidentInfo.class) //指定头
                .withTemplate(path) //加载模板
                .build(); //构造write对象
        //5.获取WriterSheet对象
        WriteSheet sheet = EasyExcel.writerSheet().build();
        //6.填充列表，自动的创建数据行
        writer.fill(list,sheet);
        //7.填充对象数据
        //writer.fill(map,sheet);
        //8.释放资源，完成数据下载
        writer.finish();
    }

    /**
     * 导入excel
     * @param file
     * @return
     * @throws Exception
     */
    public static <T> List<T> importExcel(MultipartFile file, Class<T> clazz) throws Exception {

        //通过EasyExcel自动解析并获取数据
        List<T> list = EasyExcel.read(file.getInputStream())
                .head(clazz) //指定实体类
                .sheet(0) //指定解析的sheet
                .doReadSync();  //将解析结果封装为list集合返回
        return list;
    }
}
