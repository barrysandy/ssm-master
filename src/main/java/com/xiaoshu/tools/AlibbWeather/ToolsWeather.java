package com.xiaoshu.tools.AlibbWeather;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import java.util.*;

/**
 * 天气查询接口，使用阿里云接口
 * 接口地址：https://market.aliyun.com/products/57126001/cmapi014302.html?spm=5176.2020520132.101.22.HdfKKM&accounttraceid=f429ab2c-d77c-44e2-959c-06c5b195b337#sku=yuncode830200000
 * @author xugongbin
 * @data 2018-05-23 10:33
 */
public class ToolsWeather {
    private static final String URL ="http://jisutqybmf.market.alicloudapi.com";
    private static final String PATH ="/weather/query";
    private static final String METHOD ="GET";
    private static final String APPCODE ="d6220d9bd158415eade03e38143a9ec7";

    public static String getWeather(String cityName){
        Map<String, String> headers = new HashMap<String, String>();
        //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
        headers.put("Authorization", "APPCODE " + APPCODE);
        Map<String, String> querys = new HashMap<String, String>();
        querys.put("city", cityName);
        try {
            /**
             * 重要提示如下:
             * HttpUtils请从
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
             * 下载
             * 相应的依赖请参照
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
             */
            HttpResponse response = HttpUtils.doGet(URL, PATH, METHOD, headers, querys);
            System.out.println(response.toString());
//	    	获取response的body
            String body = EntityUtils.toString(response.getEntity());
//            System.out.println(body);
            return body;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static WeatherVo getInstance(String cityName){
        WeatherVo weatherVo = new WeatherVo();
        String status ;
        String msg ;
        String json = ToolsWeather.getWeather(cityName);
        System.out.println("json: " + json);
        if(json != null){
            if(!"".equals(json)){
                JSONObject object = JSONObject.fromObject(json);
                status = (String) object.get("status");
                msg = (String) object.get("msg");
                if(status != null && msg != null){
                    if("0".equals(status) && "ok".equals(msg)){
                        System.out.println("status: " + status);
                        System.out.println("msg: " + msg);
                        JSONObject objectResult = JSONObject.fromObject(object.get("result"));
                        String city = (String) objectResult.get("city");
                        String weather = (String) objectResult.get("weather");
                        String temp = (String) objectResult.get("temp");
                        String temphigh = (String) objectResult.get("temphigh");
                        String templow = (String) objectResult.get("templow");
                        String img  = (String) objectResult.get("img");
                        weatherVo.setCity(city);
                        weatherVo.setWeather(weather);
                        weatherVo.setTemp(temp);
                        weatherVo.setTemphigh(temphigh);
                        weatherVo.setTemplow(templow);
                        weatherVo.setImg(img);
                    }
                }


            }
        }
        return weatherVo;
    }


    public static List<WeatherVo> getListInstance(String cityName,int limit){
        int total = 0;
        List<WeatherVo> list = new ArrayList<WeatherVo>();
        WeatherVo weatherVo = new WeatherVo();
        String status ;
        String msg ;
        String json = ToolsWeather.getWeather(cityName);
        System.out.println("json: " + json);
        if(json != null){
            if(!"".equals(json)){
                JSONObject object = JSONObject.fromObject(json);
                status = (String) object.get("status");
                msg = (String) object.get("msg");
                if(status != null && msg != null){
                    if("0".equals(status) && "ok".equals(msg)){
                        System.out.println("status: " + status);
                        System.out.println("msg: " + msg);
                        JSONObject objectResult = JSONObject.fromObject(object.get("result"));
                        String city = (String) objectResult.get("city");
                        String weather = (String) objectResult.get("weather");
                        String temp = (String) objectResult.get("temp");
                        String temphigh = (String) objectResult.get("temphigh");
                        String templow = (String) objectResult.get("templow");
                        String img  = (String) objectResult.get("img");
                        weatherVo.setCity(city);
                        weatherVo.setWeather(weather);
                        weatherVo.setTemp(temp);
                        weatherVo.setTemphigh(temphigh);
                        weatherVo.setTemplow(templow);
                        weatherVo.setImg(img);
                        JSONArray objectIndex = JSONArray.fromObject(objectResult.get("daily"));
                        if(objectIndex != null){
                            if(objectIndex.size() > 0){
                                Iterator<JSONObject> iterator = objectIndex.iterator();
                                while(iterator.hasNext()){
                                    JSONObject iteratorObject = iterator.next();
                                    WeatherVo weatherVoTemp = new WeatherVo();
                                    String weekTemp = (String) iteratorObject.get("week");
                                    String dateTemp = (String) iteratorObject.get("date");
                                    JSONObject day = JSONObject.fromObject(iteratorObject.get("day"));//白天
                                    JSONObject night = JSONObject.fromObject(iteratorObject.get("night"));//夜晚
                                    String weatherTemp = (String) day.get("weather");
                                    String temphighTemp = (String) day.get("temphigh");
                                    String imgTemp  = (String) day.get("img");
                                    String templowTemp = (String) night.get("templow");
                                    weatherVoTemp.setWeek(weekTemp);
                                    weatherVoTemp.setDate(dateTemp);
                                    weatherVoTemp.setCity(city);
                                    weatherVoTemp.setWeather(weatherTemp);
                                    weatherVoTemp.setTemphigh(temphighTemp);
                                    weatherVoTemp.setTemplow(templowTemp);
                                    weatherVoTemp.setImg(imgTemp);
                                    total ++ ;
                                    if(total <= limit){
                                        list.add(weatherVoTemp);
                                        System.out.println("weatherVoTemp: " + weatherVoTemp );
                                    }
                                }
                            }
                        }
                    }
                }


            }
        }
        return list;
    }

    public static void main(String[] args) {
//        System.out.println(ToolsWeather.getInstance("成都"));

        ToolsWeather.getListInstance("成都",4);

    }

}
