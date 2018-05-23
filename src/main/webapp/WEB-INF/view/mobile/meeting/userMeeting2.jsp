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
		/* demo */
		.demo{width:100%;margin:0 auto;}
		.demo div{margin:40px 0 0 0;}
	</style>
	<title>会议流程</title>
</head>
<body>

<div align="center">
	<input type="hidden" id="positions" value="${positions}"/>
	<input type="text" id="mapPoint" value="${meeting.mapPoint}" style="display: none;"/>
	<input type="hidden" id="address" value=""/>
	<h4 style="margin-top: 2rem;color: grey;font-size: 1.4rem;height: 20px;">${meeting.title }</h4>
	<div>
		<div class="demo" style="width: 100%;margin-top: -30px;">
			<div>
				<iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=7" style="border:solid 1px #7ec8ea" width="225" height="90" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
			</div>
		</div>
		<img style="margin-top: 0.5rem;" src="${meeting.image}" width="100%"/>
		<%--<div>--%>
			<%--<img style="margin-top: 2px;position: relative;" src="${path}/resources/img/map.jpg" width="100%" onclick="toOne()"/>--%>
			<%--<div style="background-color: deeppink;width: 50%;height: 16rem;margin-right: 50%;margin-top: -18rem;position:relative;" onclick="toTow()"></div>--%>
		<%--</div>--%>

		<div id="container" style="width: 100%;height: 0px;"></div>
		<script type="text/javascript">
            address = "0";
            var positionsStr = $("#positions").val();
            var positions = eval(positionsStr);

            var mapPoint = "[" + $("#mapPoint").val() + "]";
            var positionCenter = eval(mapPoint);


            //初始化地图对象，加载地图
            map = new AMap.Map("container", {
                resizeEnable: true,
                center: positionCenter,//地图中心点
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
            markers = [];
            for(var i = 0, marker; i < positions.length; i++) {
                addMarker(positions[i],"0");
            }

            function naviGation() {
                marker.markOnAMAP({
                    name:address,
                    position:marker.getPosition()
                })
            }



//
//            function toOne() {
//                alert("toOne");
//
//            }
//            function toTow() {
//                alert("toTow");
//            }


            /**
             * 移添加 Marker
             */
            function addMarker(position,type) {
                var addressName1 = "<br/>点击图标前往导航";
                var addressName2 = "";
                var url = "${path}/meeting/getCoordinateNameNoUser";
                var add = position.toString();
                $.get(url,{'position':add },function(data){
                    if(data != "0" || data != 0){
                        addressName2 = data;
                        var content= "<div style='width: auto;color: #6a6a6d;'>"+addressName2 + addressName1 +"</div>";
                        var marker = new AMap.Marker({
                            map: map,
                            position: position,
                            icon: new AMap.Icon({
                                size: new AMap.Size(50, 50),  //图标大小
                                image: "http://www.daxi51.com/ssm/resources/img/coordinate.png",
                                imageOffset: new AMap.Pixel(0, 0)
                            })

                        });

                        var marker2 = new AMap.Marker({
                            map: map,
                            position: position,
                            content: content,
                            offset: new AMap.Pixel(-20,10)
                        });

                        //Maker 点击事件
                        marker.on('click', function(position) {
                            var positions = position.lnglat;
                            regeocoder(positions);
                            //延迟刷新
                            address = $("#address").val();
                            if(address == 0 || address == "0"){
                                setTimeout(function(){
                                    address = $("#address").val();
                                    regeocoder(positions);
                                    if(address == 0 || address == "0"){
                                        setTimeout(function(){
                                            address = $("#address").val();
                                            marker.markOnAMAP({
                                                name:address,
                                                position:marker.getPosition()
                                            })
                                        }, 500);
                                    }else {
                                        marker.markOnAMAP({
                                            name:address,
                                            position:marker.getPosition()
                                        })
                                    }

                                }, 1000);
                            }else {
                                marker.markOnAMAP({
                                    name:address,
                                    position:marker.getPosition()
                                })
                            }

                        });
                        markers.push(marker);
                    }

                });


            }

            //逆地理编码
            function regeocoder(lnglatXY) {
                var geocoder = new AMap.Geocoder({
                    radius: 1000,
                    extensions: "all"
                });
                geocoder.getAddress(lnglatXY, function(status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                        geocoder_CallBack(result);
                    }
                });
            }
            function geocoder_CallBack(data) {
                address = data.regeocode.formattedAddress; //返回地址描述
                $("#address").val(address);
            }

		</script>
		<div style="margin-top: 1rem;">
			${meeting.descM}
		</div>
	</div>
</div>
</body>
</html>