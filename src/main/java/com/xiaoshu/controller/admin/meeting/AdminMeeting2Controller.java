package com.xiaoshu.controller.admin.meeting;

import com.xiaoshu.entity.Meeting;
import com.xiaoshu.entity.MeetingSign;
import com.xiaoshu.service.MeetingService;
import com.xiaoshu.service.MeetingSignService;
import com.xiaoshu.tools.JSONUtils;
import com.xiaoshu.tools.ToolsString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/meeting")
/**
 * 此为备用签到策略
 */
public class AdminMeeting2Controller {
    private final Logger log = LoggerFactory.getLogger(AdminMeeting2Controller.class);

    @Resource private MeetingService meetingService;
    @Resource private MeetingSignService meetingSignService;


    /**
     * 签到首页页面
     * @param id 主键ID
     * @return view
     * @author XGB
     * @date 2018-5-15 9:42
     */
    @RequestMapping("/signIndex2")
    public String signIndex2( Model model,String id){
        System.out.println("id: " + id );
        try{
            Meeting bean =  meetingService.getById(id);
            Integer total = meetingSignService.getCountStatusByMeetingId(id,1);
            model.addAttribute("bean", bean);
            model.addAttribute("id", id);
            model.addAttribute("total", total);
        }catch(Exception e){
            e.printStackTrace();
        }
        return "admin/meeting/meetingSign/main2";
    }


    /**
     * meeting/interfaceGetMeetingUser2?signCode=
     * 签到条形码查询（纯数字查询）
     * @author XGB
     * @date 2018-05-14 15:16
     */
    @RequestMapping(value = "/interfaceGetMeetingUser2", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String interfaceGetMeetingUser(String signCode,String id){
        if(signCode != null && id != null){
            if("".equals(signCode) || "".equals(id)){
                return "0";
            }
        }
        System.out.println("signCode:" + signCode + " id:" + id);
        try{
            MeetingSign meetingSign = null;
            if(signCode.length() == 6){
                meetingSign = meetingSignService.getBySignCode(signCode,id);
            }
            else if(signCode.length() == 11){
                meetingSign = meetingSignService.getByPone(signCode,id);
            }
            else if(signCode.length() == 12){
                signCode = signCode.substring(5,11);
                log.info("------------ [LOG2] meetingSign 12 : " + signCode + " ------------");
                meetingSign = meetingSignService.getBySignCode(signCode,id);
            }
            else if(signCode.length() == 13){
                signCode = signCode.substring(1,7);
                System.out.println("signCode:" + signCode);
                meetingSign = meetingSignService.getBySignCode(signCode,id);
            }
            if(meetingSign != null){
                String json = JSONUtils.toJSONString(meetingSign);
                json = ToolsString.getStrRemoveBracket(json);
                System.out.println("json: " + json);
                return json;
            }else if(meetingSign == null){
                return "0";
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 预览签到人信息
     * @param signCode
     * @return
     * @author XGB
     * @date 2018-05-15 10:50
     */
    @RequestMapping("/toSignCodeView2")
    public String toSignCodeView2(String signCode,String id, HttpServletRequest request){
        try{
            if(signCode != null){
                MeetingSign bean = null;
                if(signCode.length() == 6){
                    bean = meetingSignService.getBySignCode(signCode,id);
                }
                else if(signCode.length() == 11){
                    bean = meetingSignService.getByPone(signCode,id);
                }
                else if(signCode.length() == 12){
                    signCode = signCode.substring(5,11);
                    log.info("------------ [LOG] meetingSign 12 : " + signCode + " ------------");
                    bean = meetingSignService.getBySignCode(signCode,id);
                }
                else if(signCode.length() == 13){
                    signCode = signCode.substring(0,6);
                    bean = meetingSignService.getBySignCode(signCode,id);
                }
                request.setAttribute("bean", bean);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "admin/meeting/meetingSign/meetingSignCode_view";
    }


}
