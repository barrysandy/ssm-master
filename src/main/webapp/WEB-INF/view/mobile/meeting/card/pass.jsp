<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width">
    <meta name="viewport" content="initial-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="/WEB-INF/common_andy.jsp" %>
    <script src="${path}/resources/js/jquery-1.8.3.min.js"></script>
    <title>西行护照</title>

    <link rel="stylesheet" href="css/phone.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/weui.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/jquery-weui.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/demos.css">

    <!--=========引入Alert=========-->
    <script type="text/javascript" src="${path}/resources/alert/1.1/alertPopShow.js"></script>
    <script type="text/javascript" src="${path}/resources/alert/1.1/jquery-1.10.1.min.js"></script>
    <link rel="stylesheet" href="${path}/resources/alert/1.1/common.css">
    <style>
        .buttonDiv{
            height: 55px;width: 100%;background-color: #dd4230;color: white;position: fixed;bottom: 0;text-align: center;line-height: 55px;font-size: 18px;
        }
        .div1{
            width: 100%;height: 55px;
        }
        .image1{
            width: 100%;height: auto;
        }
    </style>
</head>
<body>
<div>
    <img src="${path}/resources/img/pass.jpg" class="image1">
    <div class="div1"></div>
</div>
<div class="buttonDiv" onclick="window.location.href='${path}/cardInUser/index?menuId=${menuId}'">立即申请</div>
</body>
</html>