package com.xiaoshu.controller.frontend.meeting;

import com.xgb.springrabbitmq.dto.DtoMessage;
import com.xgb.springrabbitmq.publish.DeadLetterPublishService;
import com.xiaoshu.api.Set;
import com.xiaoshu.entity.Meeting;
import com.xiaoshu.entity.MeetingSign;
import com.xiaoshu.enumeration.EnumsMQName;
import com.xiaoshu.service.MeetingService;
import com.xiaoshu.service.MeetingSignService;
import com.xiaoshu.service.MessageRecordService;
import com.xiaoshu.tools.*;
import com.xiaoshu.tools.ssmImage.ToolsImage;
import com.xiaoshu.util.JsonUtils;
import com.xiaoshu.util.Pager;
import com.xiaoshu.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

@Controller
@RequestMapping("/meeting")
public class MeetingController {

    @Autowired private DeadLetterPublishService deadLetterPublishService;
    @Resource private MeetingService meetingService;
    @Resource private MeetingSignService meetingSignService;
    @Resource private MessageRecordService messageRecordService;

    /**
     * meeting/myCodeNoUser?id=&code=
     * 用户条形码访问页面
     * @param id
     * @param code
     * @author XGB
     * @date 2018-05-14 15:42
     */
    @RequestMapping("myCodeNoUser")
    public String myCodeNoUser(HttpServletRequest request, String id, String code){
        System.out.println("id:" + id + " code:" + code);
        String url = "";
        try{
            if(id != null && code != null){
                Meeting meeting = meetingService.getById(id);
                MeetingSign meetingSign = meetingSignService.getBySignCode(code,id);
                if(meeting != null && meetingSign != null){
                    request.setAttribute("meeting",meeting);
                    request.setAttribute("meetingSign",meetingSign);
                    String signCode = meetingSign.getSignCode() + meetingSign.getSignCode();
                    signCode = ToolsBarcodeRelease.getbarCodeAddLast(signCode);
                    String path = Set.SYSTEM_URL + "/upfile/signCode/" + id + "/" + File.separator + signCode + ".jpeg";//服务器保存文件路径
                    request.setAttribute("code", path);
                    url = "mobile/meeting/userCode";
                }
            }
            System.out.println("url:" + url );
        }catch (Exception e){
            e.printStackTrace();
        }
        return url;
    }

    /**
     * meeting/myCodeStatusNoUser?id=&code=
     * 用户条形码状态 是否被扫描了
     * @param id
     * @param code
     * @author XGB
     * @date 2018-05-14 15:42
     */
    @RequestMapping(value = "/myCodeStatusNoUser", method = RequestMethod.GET)
    @ResponseBody
    public String myCodeStatusNoUser(HttpServletRequest request, String id, String code){
        try{
            if(id != null && code != null){
                Integer status = meetingSignService.getStatusBySignCode(code,id);
                if(status != null){
                    System.out.println("myCodeStatusNoUser status:" + status);
                    return String.valueOf(status);
                }
            }
        }catch (Exception e){
            System.out.println("myCodeStatusNoUser status: e" + e);
            e.printStackTrace();
            return "0";
        }
        System.out.println("myCodeStatusNoUser status:0");
        return "0";
    }
}
