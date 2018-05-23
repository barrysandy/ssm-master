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
	<script src="${path}/resources/js/jquery-1.8.3.min.js"></script>

	<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.6&key=788bad321f49e4d9f41a987617ef58a6"></script>
	<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>


	<style type="text/css">
		img {
			height: auto;
			width: auto \9;
			width: 100%;
		}

		.icon{
			height: 20px;
			width: 20px;
		}
		/* demo */
		.demo{width:100%;margin:0 auto;}
		.demo div{margin:40px 0 0 0;}
	</style>
	<title>会议流程</title>
</head>
<body style="width: 90%;margin-right: 5%;margin-left: 5%;">

<div>
	<div align="center"><h4 style="margin-top: 2rem;color: grey;font-size: 1.25rem;height: 20px;">${meeting.title }</h4></div>
	<div>
		<img style="margin-top: 0.5rem;" src="${meeting.image}" width="100%"/>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2018年5月25日-27日，中国（温江）首届西行起点旅游博览会开幕式将在成都温江举行。这是关于文化，旅游，商贸，科技等融合发展，产业互动的盛会，旨在搭建一个信息互通，资源共享的平台，探讨文化旅游发展的新模式新业态，助推地方文化旅游产业经济发展。 同时，广大市民可以在温江珠江广场参与首届西行起点旅游博览会的展会，为暑期出行定制假期，感受西部旅游人文风情，民俗特色，地方文化。</div>
		</div>
		<div style="margin-top: 20px;margin-bottom: 10px;">
			<div><b style="color: black">大会时间：</b><br/>2018年5月25日 09:30--20:00<br/>(大会签到时间：09:00--09:30)</div>
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<div><b style="color: black">外展时间：</b><br/>2018年5月25日--2018年5月27日 10:00--18:00</div>
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<div><b style="color: black">大会主会场</b></div>
			<div>地址：成都温江皇冠假日酒店二楼宴会厅</div>
		</div>
		<div id="container" style="width: 100%;height: 200px;"></div>
		<script type="text/javascript">
            //初始化地图对象，加载地图
            map = new AMap.Map("container", {
                resizeEnable: true,
                center: [103.890081,30.685566],//地图中心点
                zoomEnable:false,
                dragEnable: false,
                zoom: 13 //地图显示的缩放级别
            });
            AMap.plugin(['AMap.Geocoder','AMap.ToolBar','AMap.OverView'],
                function(){
                    map.addControl(new AMap.ToolBar());
                    map.addControl(new AMap.Geocoder({radius: 1000,extensions: "all"}));
                    map.addControl(new AMap.OverView({isOpen:false}));
                });
            addMarker([103.890081,30.685566]);
            /**
             * 移添加 Marker
             */
            function addMarker(position) {
                var marker = new AMap.Marker({
                    map: map,
                    position: position,
                    icon: new AMap.Icon({
                        size: new AMap.Size(50, 50),  //图标大小
                        image: "http://www.daxi51.com/ssm/resources/img/coordinate.png",
                        imageOffset: new AMap.Pixel(0, 0)
                    })

                });

                //Maker 点击事件
                marker.on('click', function() {
                    var address = "成都温江皇冠假日酒店";
                    marker.markOnAMAP({
                        name:address,
                        position:marker.getPosition()
                    })
                });
//                markers.push(marker);
            }
		</script>

		<div style="margin-top: 20px;margin-bottom: 20px;">
			<div><b style="color: black">外场展会</b></div>
			<div>地址：珠江广场(光华大道三段)</div>
		</div>
		<div id="container2" style="width: 100%;height: 200px;"></div>
		<script type="text/javascript">
            //初始化地图对象，加载地图
            map2 = new AMap.Map("container2", {
                resizeEnable: true,
                center: [103.85784,30.688412],//地图中心点
                zoomEnable:false,
                dragEnable: false,
                zoom: 13 //地图显示的缩放级别
            });
            AMap.plugin(['AMap.Geocoder','AMap.ToolBar','AMap.OverView'],
                function(){
                    map2.addControl(new AMap.ToolBar());
                    map2.addControl(new AMap.Geocoder({radius: 1000,extensions: "all"}));
                    map2.addControl(new AMap.OverView({isOpen:false}));
                });
            addMarker2([103.85784,30.688412]);
            /**
             * 移添加 Marker
             */
            function addMarker2(position) {
                var marker2 = new AMap.Marker({
                    map: map2,
                    position: position,
                    icon: new AMap.Icon({
                        size: new AMap.Size(50, 50),  //图标大小
                        image: "http://www.daxi51.com/ssm/resources/img/coordinate.png",
                        imageOffset: new AMap.Pixel(0, 0)
                    })

                });

                //Maker 点击事件
                marker2.on('click', function() {
                    var address = "珠江广场(光华大道三段)";
                    marker2.markOnAMAP({
                        name:address,
                        position:marker2.getPosition()
                    })
                });
//                markers.push(marker2);
            }
		</script>

	</div>
</div>
<div>
	<div style="margin-top: 1rem;">
		${meeting.descM}
	</div>
	<div align="center">
	<%--<div>--%>
		<div style="margin-top: 1rem;">
			温馨提示
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<div style="color: blue" onclick="location='${path}/meeting/myHotelNoUser'"><b>酒店预定方式</b></div>
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
			<c:forEach var="weatherVo" items="${weatherVo}" varStatus="status">
				<div style="width: 25%;display: inline-block;justify-content: space-around;">
					<div style="width: 100%">${weatherVo.week }
						<c:if test="${ status.index == 0}"><span style="color: green;">今天</span></c:if>
						<c:if test="${ status.index == 1}"><span style="color: darkmagenta;">明天</span></c:if>
						<c:if test="${ status.index == 2}"><span style="color: orchid;">后天</span></c:if>
					</div>
					<div style="width: 100%;"><img class="icon" style="vertical-align:middle;margin-top: 0px;" src="${path}/resources/img/icon/weathercnAlibabaWeather/${weatherVo.img }.png"></div>
					<div style="width: 100%;">${weatherVo.weather }</div>
					<div style="width: 100%;">${weatherVo.templow }°C ~ <span style="color: red;">${weatherVo.temphigh }°C</span></div>
				</div>
			</c:forEach>
		</div>
		<%--<div style="margin-top: 10px;margin-bottom: 10px;">--%>
			<%--<c:forEach var="weatherVo" items="${weatherVo}" varStatus="status">--%>
				<%--<div style="color: #407dca">${weatherVo.city } ${weatherVo.temp }° (${weatherVo.templow }° ~ ${weatherVo.temphigh }°) ${weatherVo.weather }--%>
					<%--<img class="icon" style="vertical-align:middle;margin-top: -5px;" src="${path}/resources/img/icon/weathercnAlibabaWeather/${weatherVo.img }.png">--%>
				<%--</div>--%>
			<%--</c:forEach>--%>
		<%--</div>--%>
		<%--<div class="demo" style="width: 100%;margin-top: -30px;">--%>
			<%--&lt;%&ndash;<div>&ndash;%&gt;--%>
				<%--&lt;%&ndash;<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=7" style="border:solid 1px #7ec8ea" width="225" height="90" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>&ndash;%&gt;--%>
			<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
			<%--<div>--%>
				<%--<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=19" width="100%;" height="auto" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>--%>
			<%--</div>--%>
		<%--</div>--%>
		<div style="height: 30px;"></div>
	</div>
</div>

<script>

</script>
</body>
</html>