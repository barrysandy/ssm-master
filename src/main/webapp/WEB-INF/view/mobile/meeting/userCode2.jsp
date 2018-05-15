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
	<title></title>
	<%@ include file="/WEB-INF/common_andy.jsp" %>
	<script src="${path }/resources/js/plugins/layer/layer.min.js"></script>
	<script src="${path }/resources/layui/layui.js"></script>
	<script src="${path }/resources/layui/layuiUtil.js"></script>

	<script src="${path}/resources/js/jquery-1.8.3.min.js"></script>
	<title>我的会议签到码</title>
	<link rel="stylesheet" type="text/css" href="${path}/resources/azenui/css/ui.css">
	<!--=========引入Alert=========-->
	<script type="text/javascript" src="${path}/resources/alert/1.1/alertPopShow.js"></script>
	<script type="text/javascript" src="${path}/resources/alert/1.1/jquery-1.10.1.min.js"></script>
	<link rel="stylesheet" href="${path}/resources/alert/1.1/common.css">
</head>
<body>
<div class="aui-container">
	<div class="aui-page">
		<div class="aui-t-header">
			<div class="header">
				<div class="header-background"></div>
				<div class="toolbar statusbar-padding">
					<div class="header-title">
						<div class="title">${meeting.title }</div>
					</div>
				</div>
			</div>
		</div>
		<div class="aui-s-title b-line"></div>
		<div class="aui-s-title b-line">
			<div class="aui-s-content" style="margin-top: -3em;">
				<div align="center">
					<h2>签到编码：${meetingSign.signCode }</h2>
					<br>
					<span style="color: red;font-size: 1.6rem;">条形码</span>
					<br>
					<br>
					<img src="${code}" width="80%"/>
					<br>
					<br>
				</div>
			</div>

		</div>

		<input id="meetingId" type="hidden" value="${meeting.id }"/>
		<input id="meetingSignId" type="hidden" value="${meetingSign.id }"/>
		<input id="signCode" type="hidden" value="${meetingSign.signCode }"/>
	</div>
</div>
<script>
	var status = 0;

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
			}else {
                layuiUtilMsg(data);
			}

        });
    }
    $(function() {
        setInterval(function(){
            if(status == "0" || status == 0){
                getStatus();
			}else if(status == "1" || status == 1){
                layuiUtilMsg("扫描成功!!!!");
                status = 2;
            }
        }, 500);
    });
</script>
</body>
</html>