package com.xiaoshu.tools.AlibbWeather;

/**
 * Created by Administrator on 2018/5/23.
 */
public class WeatherVo {

    private String city;
    private String cityid;
    private String citycode;
    private String date;
    private String week;
    private String weather;
    private String temp;
    private String temphigh;
    private String templow;
    private String img;
    private String humidity;
    private String pressure;
    private String windspeed;
    private String winddirect;
    private String windpower;
    private String updatetime;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getCitycode() {
        return citycode;
    }

    public void setCitycode(String citycode) {
        this.citycode = citycode;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public String getTemp() {
        return temp;
    }

    public void setTemp(String temp) {
        this.temp = temp;
    }

    public String getTemphigh() {
        return temphigh;
    }

    public void setTemphigh(String temphigh) {
        this.temphigh = temphigh;
    }

    public String getTemplow() {
        return templow;
    }

    public void setTemplow(String templow) {
        this.templow = templow;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getHumidity() {
        return humidity;
    }

    public void setHumidity(String humidity) {
        this.humidity = humidity;
    }

    public String getPressure() {
        return pressure;
    }

    public void setPressure(String pressure) {
        this.pressure = pressure;
    }

    public String getWindspeed() {
        return windspeed;
    }

    public void setWindspeed(String windspeed) {
        this.windspeed = windspeed;
    }

    public String getWinddirect() {
        return winddirect;
    }

    public void setWinddirect(String winddirect) {
        this.winddirect = winddirect;
    }

    public String getWindpower() {
        return windpower;
    }

    public void setWindpower(String windpower) {
        this.windpower = windpower;
    }

    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }

    public WeatherVo() { }

    public WeatherVo(String city, String cityid, String citycode, String date, String week, String weather, String temp, String temphigh, String templow, String img, String humidity, String pressure, String windspeed, String winddirect, String windpower, String updatetime) {
        this.city = city;
        this.cityid = cityid;
        this.citycode = citycode;
        this.date = date;
        this.week = week;
        this.weather = weather;
        this.temp = temp;
        this.temphigh = temphigh;
        this.templow = templow;
        this.img = img;
        this.humidity = humidity;
        this.pressure = pressure;
        this.windspeed = windspeed;
        this.winddirect = winddirect;
        this.windpower = windpower;
        this.updatetime = updatetime;
    }

    @Override
    public String toString() {
        return "WeatherResultVo{" +
                "city='" + city + '\'' +
                ", cityid='" + cityid + '\'' +
                ", citycode='" + citycode + '\'' +
                ", date='" + date + '\'' +
                ", week='" + week + '\'' +
                ", weather='" + weather + '\'' +
                ", temp='" + temp + '\'' +
                ", temphigh='" + temphigh + '\'' +
                ", templow='" + templow + '\'' +
                ", img='" + img + '\'' +
                ", humidity='" + humidity + '\'' +
                ", pressure='" + pressure + '\'' +
                ", windspeed='" + windspeed + '\'' +
                ", winddirect='" + winddirect + '\'' +
                ", windpower='" + windpower + '\'' +
                ", updatetime='" + updatetime + '\'' +
                '}';
    }
}
