package com.xiaoshu.tools.single;

import java.util.HashMap;
import java.util.Map;

/**
 * 单例MapPublicNumber
 */
public class MapGroupId {

	private static MapGroupId instance = null;
    private static Map<String, String> map = null;
    private MapGroupId(){}
      
    public static MapGroupId getInstance() {
        if(instance == null){//懒汉式  
            instance = new MapGroupId();
            map = new HashMap<String,String>();
        }
        return instance;  
    }

    /**
     * 获取map
     * @return
     */
    public Map<String, String> getMap() {
        return map;
    }
}
