package com.xiaoshu.wechat.robot;

import com.xiaoshu.api.Api;
import com.xiaoshu.tools.ToolsASCIIChang;
import com.xiaoshu.tools.ToolsHttpRequest;
import com.xiaoshu.tools.ToolsString;
import com.xiaoshu.tools.ToolsInterface;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 公众号自动匹配关键字
 * @author XGB
 */
public class Robot {
	private static Logger logger = LoggerFactory.getLogger(Robot.class);
	/**
	 * 用户输入的内容匹配数据库关键字
	 * @param content 输入的内容
	 * @return
	 */
	public static String RobotAnser(String menuId,String content){
		content = ToolsASCIIChang.stringToAscii(content);
		String jsonstr = ToolsHttpRequest.sendGet(Api.GET_KEYWORRDS_BYMID_AND_KEY, "menuId="+menuId+"&keyes="+content);
		logger.info("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		logger.info("Robot.RobotAnser jsonstr is:" + jsonstr);
		System.out.println("Robot.RobotAnser jsonstr is:" + jsonstr);
		logger.info("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		return ToolsString.getStrRemoveBracket(jsonstr);
	}
	
	 /**
	  * 查询本期的文章
	  * @param menuId
	  * @return
	  */
	public static String robotGetFinalArt(String menuId){
		String respContent = ToolsHttpRequest.sendGet(Api.FINAL_ART, "menuId=" + menuId);
		if("null".equals(respContent)){//如果数据库没有查询到
			respContent = ToolsInterface.getSetInterface("AUTO_REPLY");
		}
		return respContent;
	}
	
	/**
	  * 按期目查询文章
	  * @param current 第几期的文章
	  * @return
	  */
	public static String robotGetArtByPeriod(String menuId,Integer current){
		String respContent = ToolsHttpRequest.sendGet(Api.SELECT_ART_BY_PERIOD, "menuId=" + menuId + "&current=" + current);
		System.out.println("===>>respContent: " + respContent);
		if("null".equals(respContent)){//如果数据库没有查询到
			respContent = ToolsInterface.getSetInterface("AUTO_REPLY");
		}
		return respContent;
	}
}
