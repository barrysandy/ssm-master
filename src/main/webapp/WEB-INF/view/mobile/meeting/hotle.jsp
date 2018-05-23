<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width">
	<meta name="viewport" content="initial-scale=1.0,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<%@ include file="/WEB-INF/common_andy.jsp" %>
	<script src="${path }/resources/js/plugins/layer/layer.min.js"></script>
	<script src="${path }/resources/layui/layui.js"></script>
	<script src="${path }/resources/layui/layuiUtil.js"></script>

	<script src="${path}/resources/js/jquery-1.8.3.min.js"></script>
	<title>酒店预定</title>
</head>
<body style="width: 90%;margin-right: 5%;margin-left: 5%;">
<div>
	<div style="margin-top: 50px;margin-bottom: 20px;">
		<div>
			<b>成都温江皇冠假日酒店</b><br/>
			星级：5星<br/>
			地址：成都市温江区凤凰北大街619号<br/>
			距离会场：本酒店二楼大宴会厅<br/>
			预订电话：<a href="tel:028 8268 8888">028 8268 8888</a><br/>
			预订邮箱：reservation@cpwenjiang.com<br/>
			预订时间：09:00-18:00电话预订，18:00后邮件方式订房<br/>
			协议价：458元，早餐按照已实际登记人数为准，每间房最多含2份早。<br/>
		</div>
		<div style="margin-top: 15px;">
			<b>成都温江温泉智选假日酒店</b><br/>
			星级：3星<br/>
			地址：成都市温江区凤凰北大街619号<br/>
			距离会场：0.5km, 步行5分钟<br/>
			预订电话：<a href="tel:028 8268 6666">028 8268 6666</a><br/>
			预订邮箱：reservation@cpwenjiang.com<br/>
			预订时间：09:00-18:00电话预订，18:00后邮件方式订房<br/>
			协议价：268元，早餐按照已实际登记人数为准，每间房最多含2份早。
		</div>
	</div>
</div>

<input id="meetingId" type="hidden" value="${meeting.id }"/>
<input id="meetingSignId" type="hidden" value="${meetingSign.id }"/>
<input id="signCode" type="hidden" value="${meetingSign.signCode }"/>
<input id="idStatus" type="hidden" value="${meetingSign.status }"/>
<script>
	var status = $("#idStatus").val();
    function layuiUtilMsg(data) {
        LayuiUtil.msg(data);
    }
    function getStatus() {
        var id = $("#meetingId").val();
        var signCode = $("#signCode").val();
        var url = "${path}/meeting/myCodeStatusNoUser";
        $.get(url,{'id':id ,'code':signCode },function(data){
            if(data == "1" || data == 1){
                status = 1;
                $("#status0").hide();
                $("#status1").show();
			}else {
//                layuiUtilMsg(data);
			}

        });
    }
    $(function() {
        if(status == "0" || status == 0){
            $("#status0").show();
            $("#status1").hide();
            $("#status2").hide();
            setInterval(function(){
                if(status == "0" || status == 0){
                    getStatus();
                }else if(status == "1" || status == 1){
                    layuiUtilMsg("签到成功!!!!");
                    status = 2;
                    setTimeout(function(){
                        var id = $("#meetingId").val();
                        window.location.href = "${path}/meeting/myMeetingNoUser?id=" +  id ;
                    }, 1000);
                }
            }, 500);
		}else if(status == "1" || status == 1){
            $("#status0").hide();
            $("#status1").hide();
            $("#status2").show();
            setTimeout(function(){
                var id = $("#meetingId").val();
                window.location.href = "${path}/meeting/myMeetingNoUser?id=" +  id ;
            }, 1000);
		}
    });
</script>
</body>
</html>