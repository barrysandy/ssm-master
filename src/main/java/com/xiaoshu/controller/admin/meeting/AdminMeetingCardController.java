package com.xiaoshu.controller.admin.meeting;

import com.xiaoshu.entity.MeetingCard;
import com.xiaoshu.entity.Order;
import com.xiaoshu.service.MeetingCardService;
import com.xiaoshu.tools.ToolsDate;
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
@RequestMapping("/meetingCard")
public class AdminMeetingCardController {
    @Resource private MeetingCardService meetingCardService;


    /**
     * 分页查询
     * @param pager 分页
     * @param model model
     * @return view
     * @author XGB
     * @date 2018-05-19 11:00
     */
    @RequestMapping("/list")
    public String list(Pager pager, Model model, String search) {
        try{
            Map map = new HashMap(8);
            int startRow = (pager.getPageNo() - 1) * pager.getPageSize();
            int pageSize = pager.getPageSize();
            map.put("startRow", startRow);
            map.put("pageSize", pager.getPageSize());
            map.put("search", search);
            List<MeetingCard> list = meetingCardService.getList(startRow, pageSize, search);
            int totalNum = meetingCardService.getCountList(search);//统计总记录数
            pager.setFullListSize(totalNum);
            pager.setList(list);
            model.addAttribute("pager", pager);
            model.addAttribute("bean", list);
            model.addAttribute("search", search);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "admin/meeting/card/list";
    }


    /**
     * 预览
     * @param id
     * @param model
     * @return
     * @author XGB
     * @date 2018-05-19 11:00
     */
    @RequestMapping("/toView")
    public String toView(String id, Model model){
        try{
            if(id != null){
                MeetingCard bean = meetingCardService.getById(id);
                model.addAttribute("bean", bean);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return "admin/meeting/card/view";
    }

    /**
     * 编辑页面
     * @param id 主键ID
     * @return view
     * @author XGB
     * @date 2018-05-19 11:00
     */
    @RequestMapping("/toEdit")
    public String toEdit( Model model,String id){
        try{
            MeetingCard bean =  new MeetingCard("-1","", "", "", "", "", 1);
            if(StringUtils.isNotBlank(id) && !"-1".equals(id) && !"".equals(id)){
                bean = meetingCardService.getById(id);
            }
            model.addAttribute("bean", bean);
            model.addAttribute("id", id);
        }catch(Exception e){
            e.printStackTrace();
        }
        return "admin/meeting/card/edit";
    }


    /**
     * 保存操作
     * @param bean 实体类
     * @return String
     * @author XGB
     * @date 2018-05-19 11:00
     */
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public String saveOrUpdate(MeetingCard bean){
        try{
            if(bean != null){
                if(bean.getId() != null && !"".equals(bean.getId()) && !"-1".equals(bean.getId())){
                    meetingCardService.updateAll(bean);
                }else{
                    //生成签到码
                    meetingCardService.save(bean);
                }
            }
        }catch(Exception e){
            return JsonUtils.turnJson(false,"error" + e.getMessage(),e);
        }
        return JsonUtils.turnJson(true,"success",null);
    }


    /**
     * 删除
     * @param id 主键ID
     * @return String
     * @author XGB
     * @date 2018-05-19 11:00
     */
    @RequestMapping("/del")
    @ResponseBody
    public String del(String id){
        try{
            meetingCardService.deleteById(id);
        }catch(Exception e){
            return JsonUtils.turnJson(false,"error"+e.getMessage(),e);
        }
        return JsonUtils.turnJson(true,"success",null);
    }

    /**
     * meetingCard/listExcelAll
     * 导出全部到excel文档
     * @author XGB
     * @date 2018-05-28 9:23
     */
    @RequestMapping("/listExcelAll")
    public String listExcelAll(String search ,HttpServletResponse response) {
        try{
            Map map = new HashMap(8);
            int startRow = 0;
            int pageSize = meetingCardService.getCountList(search);
            map.put("startRow", 0);
            map.put("pageSize", pageSize);
            map.put("search", search);
            List<MeetingCard> list = meetingCardService.getList(startRow, pageSize, search);
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
    private static void createExcle(List<MeetingCard> list, HttpServletResponse response) {
        if(list != null){
            if(list.size() > 0) {
                // 第一步，创建一个webbook，对应一个Excel文件
                HSSFWorkbook wb = new HSSFWorkbook();
                // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
                HSSFSheet sheet = wb.createSheet("card");
                sheet.setColumnWidth(0,1500);
                sheet.setColumnWidth(1,3000);
                sheet.setColumnWidth(2,3000);
                sheet.setColumnWidth(3,3000);
                sheet.setColumnWidth(4,3000);
                sheet.setColumnWidth(5,3000);
                HSSFCellStyle cellStyle = wb.createCellStyle();
                cellStyle.setWrapText(true);

                // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
                HSSFRow row = sheet.createRow((short) 0);
                // 第四步，创建单元格，并设置值表头 设置表头居中
                HSSFCellStyle style = wb.createCellStyle();
                style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
                style.setWrapText(true);

                HSSFCell cell = row.createCell((short) 0);
                String[] title = {"编号","姓名","电话","地址","Openid","UserId"};
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
                        MeetingCard bean = list.get(i);
                        // 第四步，创建单元格，并设置值
                        String rowNumber = String.valueOf(i + 1);
                        String[] values = {rowNumber,bean.getName(),bean.getPhone(),bean.getAddress(),bean.getUserOpenid(),bean.getUserId()};
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
                    String fileName = "护照表.xls";// 文件名
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
