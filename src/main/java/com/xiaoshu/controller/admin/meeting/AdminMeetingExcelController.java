package com.xiaoshu.controller.admin.meeting;

import com.xiaoshu.entity.MeetingCard;
import com.xiaoshu.entity.MeetingSign;
import com.xiaoshu.service.MeetingCardService;
import com.xiaoshu.service.MeetingService;
import com.xiaoshu.service.MeetingSignService;
import com.xiaoshu.util.JsonUtils;
import com.xiaoshu.util.Pager;
import com.xiaoshu.util.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/meeting")
public class AdminMeetingExcelController {
    @Resource private MeetingSignService meetingSignService;

    /**
     * meetingCard/listExcelAll
     * 导出全部到excel文档
     * @author XGB
     * @date 2018-05-28 11:20
     */
    @RequestMapping("/listExcelAll")
    public String listExcelAll(String id ,HttpServletResponse response) {
        try{
            Map map = new HashMap(8);
            int startRow = 0;
            int pageSize = meetingSignService.getCountByMeetingId(id);
            map.put("startRow", 0);
            map.put("pageSize", pageSize);
            map.put("search", "");
            List<MeetingSign> list = meetingSignService.getListByMeetingId(startRow,pageSize,id);
            createExcle(list, response);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 导出excel
     * @param list 导出的数据
     * @param response HttpServletResponse
     */
    private static void createExcle(List<MeetingSign> list, HttpServletResponse response) {
        if(list != null){
            if(list.size() > 0) {
                // 第一步，创建一个webbook，对应一个Excel文件
                HSSFWorkbook wb = new HSSFWorkbook();
                // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
                HSSFSheet sheet = wb.createSheet("meeting");
                sheet.setColumnWidth(0,1500);
                sheet.setColumnWidth(1,3000);
                sheet.setColumnWidth(2,3000);
                sheet.setColumnWidth(3,3000);
                sheet.setColumnWidth(4,3000);
                sheet.setColumnWidth(5,3000);
                sheet.setColumnWidth(6,3000);
                sheet.setColumnWidth(7,3000);
                sheet.setColumnWidth(8,3000);
                HSSFCellStyle cellStyle = wb.createCellStyle();
                cellStyle.setWrapText(true);

                // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
                HSSFRow row = sheet.createRow((short) 0);
                // 第四步，创建单元格，并设置值表头 设置表头居中
                HSSFCellStyle style = wb.createCellStyle();
                style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
                style.setWrapText(true);

                HSSFCell cell = row.createCell((short) 0);
                String[] title = {"编号","姓名","电话","公司","类型","职位","晚宴","签到","签到码"};
                for(int i =0;i<title.length;i++) {
                    cell.setCellValue(title[i]);
                    cell.setCellStyle(style);
                    cell = row.createCell((short) i + 1);
                }
                // 第五步，写入实体数据 实际应用中这些数据从数据库得到，
                Double total = 0.00;
                synchronized (total){
                    for (int i = 0; i < list.size(); i++){
                        row = sheet.createRow(i + 1);
                        MeetingSign bean = list.get(i);
                        // 第四步，创建单元格，并设置值
                        String rowNumber = String.valueOf(i + 1);
                        Integer join = bean.getJoinDinner();
                        String joinDinner = "不参加";
                        if(join != null){
                            if(join == 1){
                                joinDinner = "参加";
                            }
                        }
                        Integer statusInt = bean.getStatus();
                        String status = "未签到";
                        if(statusInt != null){
                            if(statusInt == 1){
                                status = "已签到";
                            }
                        }

                        String[] values = {rowNumber,bean.getName(),bean.getPhone(),bean.getCompany(),bean.getPersonType(),bean.getPosition(),joinDinner,status,bean.getSignCode()};
                        for (int j = 0; j < values.length ; j++) {
                            row.createCell((short) j).setCellValue(values[j]);
                            row.setRowStyle(cellStyle);
                        }

                    }
                }
                row.setHeight((short) 300);
                OutputStream out = null;
                try {
                    out = response.getOutputStream();
                    String fileName = "签到表.xls";// 文件名
                    response.setContentType("application/x-msdownload");
                    response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
                    wb.write(out);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        out.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

}
