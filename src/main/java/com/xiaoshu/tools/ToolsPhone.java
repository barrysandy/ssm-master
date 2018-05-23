package com.xiaoshu.tools;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ToolsPhone {

    public static boolean isMobileNO(String mobiles) {
//        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
        Pattern p = Pattern.compile("^((13[0-9])|(14[0-9])|(17[0-9])|(13[^4,\\D])|(14[^4,\\D])|(15[^4,\\D])|(17[^4,\\D])|(18[0,5-9])|(14[0,5-9])|(17[0,5-9]))\\d{8}$");
        Matcher m = p.matcher(mobiles);
        return m.matches();
    }

//    public static void main(String[] args) throws IOException {
//        System.out.println(ToolsPhone.isMobileNO("18781917461"));
//    }
}