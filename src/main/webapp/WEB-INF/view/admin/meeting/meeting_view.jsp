﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<html>
<head>
    <title>查看详细</title>
    <%@ include file="/WEB-INF/common_andy.jsp" %>

    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.6&key=barrysandy"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script>
        function cancel() {
//            window.parent.location.reload();
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        }
    </script>
</head>
<body>
<div class="g-layout">
    <div class="layout-center">
        <input type="hidden" id="mapPoint" name="mapPoint" value="${bean.mapPoint}"/>
        <div class="g-max f-p-xs f-p-t-n" id="PrintContentDiv">
            <table class="m-table-forms inline">
                <tr>
                    <td align="center" colspan="8" class="f-b-n" style="font-size:18px">会议详情</td>
                </tr>
                <tr>
                    <td class="table-header">会议标题</td>
                    <td colspan="7">&nbsp;${bean.title}</td>
                </tr>

                <tr>
                    <td class="table-header">会议封面</td>
                    <td colspan="7"><img src="${image}" height="40px" width="auto" style="margin-top: 4px;" onerror="this.src='${path}/resources/img/usermen.png'" ></td>
                </tr>
                <tr>
                    <td class="table-header">会议发起者姓名</td>
                    <td colspan="7">&nbsp;${bean.name}</td>
                </tr>
                <tr>
                    <td class="table-header">会议发起者电话</td>
                    <td colspan="7">&nbsp;${bean.phone}</td>
                </tr>
                <tr>
                    <td class="table-header">会议时间</td>
                    <td colspan="7">
                        &nbsp;${bean.beginTime} - &nbsp;${bean.endTime}
                    </td>
                </tr>
                <tr>
                    <td class="table-header">会议地址</td>
                    <td colspan="7">&nbsp;${bean.address}</td>
                </tr>

                <tr>
                    <td class="table-header">启用状态</td>
                    <td colspan="7">
                        <c:if test="${bean.status == 0}"><span style="color: red;">未启用</span></c:if>
                        <c:if test="${bean.status == 1}"><span style="color: green;">已启用</span></c:if>
                    </td>
                </tr>
                <tr>
                    <td class="table-header">地图显示初始点位<span style="color: red">*</span></td>
                    <td colspan="7">地图标点：
                        <div id="container" style="width: 50%;height: 200px;"></div>
                    </td>
                </tr>
                <script type="text/javascript">
                    var mapPoint = "[" + $("#mapPoint").val() + "]";
                    var positionCenter = eval(mapPoint);
                    //初始化地图对象，加载地图
                    map = new AMap.Map("container", {
                        resizeEnable: true,
                        center: positionCenter,//地图中心点
                        zoom: 13 //地图显示的缩放级别
                    });
                    markers = [];

                    addMarker(positionCenter,"0");

                    /**
                     * 移添加 Marker
                     */
                    function addMarker(position,type) {

                        if(type == "1"){
                            $(".amap-icon").remove();
                        }
                        new AMap.Marker({
                            map: map,
                            position: position,
                            icon: new AMap.Icon({
                                size: new AMap.Size(40, 50),  //图标大小
                                image: "http://webapi.amap.com/theme/v1.3/images/newpc/way_btn2.png",
                                imageOffset: new AMap.Pixel(0, -60)
                            })
                        });
                    }
                </script>
                <tr>
                    <td class="table-header">会议描述</td>
                    <td colspan="7">&nbsp;${bean.descM}</td>
                </tr>
                 
            </table>
        </div>


    </div>
    <div class="layout-foot f-b-t f-p-t-xs f-bg-light noprint" style="height:40px">
        <div class="f-right f-m-r-xs">
            <button type="button" class="u-btn" onClick="cancel()">关闭</button>
        </div>
    </div>
</div>
</body>
</html>
