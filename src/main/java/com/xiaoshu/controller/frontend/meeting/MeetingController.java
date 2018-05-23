package com.xiaoshu.controller.frontend.meeting;

import com.xiaoshu.api.Set;
import com.xiaoshu.entity.Meeting;
import com.xiaoshu.entity.MeetingCoordinate;
import com.xiaoshu.entity.MeetingSign;
import com.xiaoshu.service.MeetingCoordinateService;
import com.xiaoshu.service.MeetingService;
import com.xiaoshu.service.MeetingSignService;
import com.xiaoshu.tools.*;
import com.xiaoshu.tools.AlibbWeather.ToolsWeather;
import com.xiaoshu.tools.AlibbWeather.WeatherVo;
import com.xiaoshu.tools.single.MapMeetingCache;
import com.xiaoshu.tools.ssmImage.ToolsImage;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.*;

@Controller
@RequestMapping("/meeting")
public class MeetingController {

    public static final String MEETING_URL2 = "meeting/myCodeNoUser?id=";

    @Resource private MeetingService meetingService;
    @Resource private MeetingSignService meetingSignService;
    @Resource private MeetingCoordinateService meetingCoordinateService;

    @RequestMapping("myCodeNoUser")
    public String myCodeNoUser(HttpServletRequest request, String id, String code){
        String url = "mobile/meeting/userCode";
        try{
            if(id != null && code != null){
                Meeting meeting = meetingService.getById(id);
                MeetingSign meetingSign = meetingSignService.getBySignCode(code,id);
                if(meeting != null && meetingSign != null){
                    request.setAttribute("meeting",meeting);
                    request.setAttribute("meetingSign",meetingSign);
                    String path = Set.SYSTEM_URL + "/resources/upfile/signCode/" + id + "/" + File.separator + code + ".jpeg";//服务器保存文件路径
                    request.setAttribute("code", path);
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
    public String myCodeStatusNoUser(String id, String code){
        try{
            if(id != null && code != null){
                Integer status = meetingSignService.getStatusBySignCode(code,id);
                if(status != null){
                    return String.valueOf(status);
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            return "0";
        }
        return "0";
    }


    /**
     * meeting/myMeetingNoUser?id=
     * 会议页面
     * @param id
     * @author XGB
     * @date 2018-05-15 9:22
     */
    @RequestMapping("myMeetingNoUser")
    public String myMeetingNoUser(HttpServletRequest request, String id){
        Meeting meeting ;
        if(id != null){
            Map map = MapMeetingCache.getInstance().getMap();
            try{
                if(map.get(id) != null){
                    meeting = (Meeting) map.get(id);
                    request.setAttribute("meeting",meeting);
                    System.out.println(" Get it in Map!!!");
                }else{
                    meeting = meetingService.getById(id);
                    if(meeting != null){
                        if(meeting.getImage() != null){
                            String url = ToolsImage.getImageUrlByServer(meeting.getImage());
                            meeting.setImage(url);
                        }
                        map.put(id,meeting);
                        request.setAttribute("meeting",meeting);
                    }
                }

                List<MeetingCoordinate> listMap = meetingCoordinateService.getListByMeetingId(id);
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("[");
                if(listMap != null){
                    if(listMap.size() > 0){
                        for(int i = 0;i < listMap.size();i ++){
                            if(i + 1 < listMap.size()){
                                stringBuffer.append("[");
                                stringBuffer.append(listMap.get(i).getX());
                                stringBuffer.append(",");
                                stringBuffer.append(listMap.get(i).getY());
                                stringBuffer.append("]");
                                if(listMap.size() > 1){
                                    stringBuffer.append(",");
                                }
                            }
                            if(i + 1 == listMap.size()){
                                stringBuffer.append("[");
                                stringBuffer.append(listMap.get(i).getX());
                                stringBuffer.append(",");
                                stringBuffer.append(listMap.get(i).getY());
                                stringBuffer.append("]");
                            }

                        }
                    }
                }
                stringBuffer.append("]");
                request.setAttribute("listMap",listMap);
                request.setAttribute("positions",stringBuffer.toString());
            }catch (Exception e){
                e.printStackTrace();
            }

//            WeatherVo weatherVo = new WeatherVo();
//            if(map.get("weather") != null){
//                String weather = (String) map.get("weather");
//                if(weather != null){
//                    if(!"".equals(weather)){
//                        Long date = (Long) map.get("weatherDate");
//                        Long date2 = new Date().getTime();
//                        if(((date2 - date) / 1000) >= 3600){ //数据保存一小时
//                            System.out.println(" Get Data in Map,But Data expired,must Refresh!!!");
//                            weatherVo = ToolsWeather.getInstance("成都");
//                        }else {
//                            weatherVo = JSONUtils.toBean(weather,WeatherVo.class);
//                            System.out.println(" Get Data in Map!!!" + weatherVo);
//                        }
//                    }
//                }
//            }else{
//                weatherVo = ToolsWeather.getInstance("成都");
//                String json = JSONUtils.toJSONString(weatherVo);
//                json = ToolsString.getStrRemoveBracket(json);
//                System.out.println(" Get Data from Interface !!!" + json);
//                map.put("weather",json);
//                map.put("weatherDate",new Date().getTime());
//            }


            final String addresee = "温江";
            List<WeatherVo> weatherVo = new ArrayList<WeatherVo>();
            if(map.get("weather") != null){
                String weather = (String) map.get("weather");
                if(weather != null){
                    if(!"".equals(weather)){
                        Long date = (Long) map.get("weatherDate");
                        Long date2 = new Date().getTime();
                        if(((date2 - date) / 1000) >= 360){ //数据保存一小时/超时刷新天气数据
                            System.out.println(" Get Data in Map,But Data expired,must Refresh!!!" );
                            weatherVo = ToolsWeather.getListInstance(addresee,3);
                            if(weatherVo != null){
                                String json = JSONUtils.toJSONString(weatherVo);
                                System.out.println(" Get Data from Interface !!!json = " + json);
                                map.put("weather",json);
                                map.put("weatherDate",new Date().getTime());
                            }

                        }else {
                            weatherVo = JSONUtils.toList(weather,WeatherVo.class);
                            System.out.println(" Get Data in Map!!!weatherVo = " + weatherVo);
                        }
                    }
                }
            }else{
                weatherVo = ToolsWeather.getListInstance(addresee,3);
                String json = JSONUtils.toJSONString(weatherVo);
                System.out.println(" Get Data from Interface !!!" + weatherVo);
                map.put("weather",json);
                map.put("weatherDate",new Date().getTime());
            }

            int isInit = 1;
            if(weatherVo != null ){
                if(weatherVo.size() > 0 ){
                    Iterator<WeatherVo> iterator = weatherVo.iterator();
                    while(iterator.hasNext()){
                        WeatherVo bean = iterator.next();
                        if(bean != null){
//                            System.out.println(" bean !!!" + bean);
                            String data = bean.getDate();
                            if(data != null){
//                                System.out.println("data length: " + data.length() );
                                if(data.length() == 10 ){
                                    //2018-05-23
                                    if("0".equals(data.charAt(5))){
                                        data = "" + data.charAt(6) + "月" +data.charAt(8) +data.charAt(9) + "日";
                                    }else{
                                        data = "" + data.charAt(5) + data.charAt(6) + "月" +data.charAt(8) +data.charAt(9) + "日";
                                    }
                                    bean.setDate(data);
//                                    System.out.println("data " + data);
                                }


                            }
                        }
                    }
                }else{
                    isInit = 0;
                    weatherVo = getList(addresee);
                    System.out.println(" Get Data in InitFuncation!!!" );
                }
            }
            else{
                isInit = 0;
                weatherVo = getList(addresee);
                System.out.println(" Get Data in InitFuncation!!!" );
            }
            request.setAttribute("isInit",isInit);
            request.setAttribute("weatherVo",weatherVo);
        }
        return "mobile/meeting/userMeeting";
    }


    private static List<WeatherVo> getList(String cityName){
        List<WeatherVo> list = new ArrayList<WeatherVo>();
        list.add(new WeatherVo(cityName, "", "", "5月25日", "星期五", "多云", "", "29", "18", "1", "", "", "", "", "", "" ));
        list.add(new WeatherVo(cityName, "", "", "5月26日", "星期日", "小雨", "", "26", "17", "7", "", "", "", "", "", "" ));
        list.add(new WeatherVo(cityName, "", "", "5月27日", "星期天", "多云", "", "28", "16", "1", "", "", "", "", "", "" ));

        return  list;
    }

    /**
     * meeting/myMeetingNoUserMap?id=
     * 会议页面
     * @param id
     * @author XGB
     * @date 2018-05-21 17:14
     */
    @RequestMapping("myMeetingNoUserMap")
    public String myMeetingNoUserMap(HttpServletRequest request, String id){
        Meeting meeting ;
        if(id != null){
            try{
                Map map = MapMeetingCache.getInstance().getMap();
                if(map.get(id) != null){
                    meeting = (Meeting) map.get(id);
                    request.setAttribute("meeting",meeting);
                    System.out.println(" Get it in Map!!!");
                }else{
                    meeting = meetingService.getById(id);
                    if(meeting != null){
                        if(meeting.getImage() != null){
                            String url = ToolsImage.getImageUrlByServer(meeting.getImage());
                            meeting.setImage(url);
                        }
                        map.put(id,meeting);
                        request.setAttribute("meeting",meeting);
                        System.out.println(" Get it in databases!!!" + meeting);
                    }
                }

                List<MeetingCoordinate> listMap = meetingCoordinateService.getListByMeetingId(id);
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("[");
                if(listMap != null){
                    if(listMap.size() > 0){
                        for(int i = 0;i < listMap.size();i ++){
                            if(i + 1 < listMap.size()){
                                stringBuffer.append("[");
                                stringBuffer.append(listMap.get(i).getX());
                                stringBuffer.append(",");
                                stringBuffer.append(listMap.get(i).getY());
                                stringBuffer.append("]");
                                if(listMap.size() > 1){
                                    stringBuffer.append(",");
                                }
                            }
                            if(i + 1 == listMap.size()){
                                stringBuffer.append("[");
                                stringBuffer.append(listMap.get(i).getX());
                                stringBuffer.append(",");
                                stringBuffer.append(listMap.get(i).getY());
                                stringBuffer.append("]");
                            }

                        }
                    }
                }
                stringBuffer.append("]");
                System.out.println("positions:" + stringBuffer.toString());
                request.setAttribute("listMap",listMap);
                request.setAttribute("positions",stringBuffer.toString());
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return "mobile/meeting/userMeetingMap";
    }



    /**
     * meeting/getCoordinateNameNoUser
     * 获取坐标点的名称
     * @param position
     * @author XGB
     * @date 2018-05-14 15:42
     */
    @RequestMapping("getCoordinateNameNoUser")
    @ResponseBody
    public String getCoordinateNameNoUser(String position,HttpServletResponse response){
        try{
            Map map = MapMeetingCache.getInstance().getMap();
            if(map.get(position) != null){
                String name = (String) map.get(position);
                System.out.println(" Get it in Map!!!name:" + name);
                response.getWriter().print(name);
            }else{
                MeetingCoordinate meetingCoordinate = meetingCoordinateService.getNameByPosition(position);
                if(meetingCoordinate != null){
                    if(meetingCoordinate.getCoordinate() != null){
                        map.put(position,meetingCoordinate.getName());
                        System.out.println(" Get it in databases!!!" + meetingCoordinate);
                        response.getWriter().print(meetingCoordinate.getName());
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            return "0";
        }
        return null;
    }


    @RequestMapping("myHotelNoUser")
    public String myHotelNoUser(){
        return "mobile/meeting/hotle";
    }

}
