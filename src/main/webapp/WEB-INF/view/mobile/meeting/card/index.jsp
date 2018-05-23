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
    <title>个人信息</title>

    <link rel="stylesheet" href="css/phone.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/weui.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/jquery-weui.css">
    <link rel="stylesheet" type="text/css" href="${path}/resources/css/userCenterBingPhonePage/css/demos.css">

    <!--=========引入Alert=========-->
    <script type="text/javascript" src="${path}/resources/alert/1.1/alertPopShow.js"></script>
    <script type="text/javascript" src="${path}/resources/alert/1.1/jquery-1.10.1.min.js"></script>
    <link rel="stylesheet" href="${path}/resources/alert/1.1/common.css">
</head>
<body style="background-color: white;">
<div>
    <c:if test="${exit == 1 }">
        <div style="height: 3rem;background-color:white">
            <div align="center" style="margin-top: 0rem;background-color:#e1e6f6;height:3rem;" >
                <div style="padding-top: 0.5rem;font-size:1.2rem;" >你已经申请成功了</div>
            </div>
        </div>
    </c:if>
    <c:if test="${exit == 0 }">
        <div style="height: 3rem;background-color:white;display: none" id="topShow">
            <div align="center" style="margin-top: 0rem;background-color:#e1e6f6;height:3rem;" >
                <div style="padding-top: 0.5rem;font-size:1.2rem;" >你已经申请成功了</div>
            </div>
        </div>
    </c:if>
    <div align="center">
        <img src="${path}/resources/img/passcard.png" style="width: 40%;margin-top: 10%;">
    </div>
    <div style="width: 80%;margin-left: 10%;margin-left: 10%;margin-top: 15%;">
        <input class="weui_input" style="border: double;border:0.5px solid #d8d8d8;height: 45px;color: grey;" type="name" id="name" value="${bean.name}" placeholder=" 姓名" maxlength="11" />
        <input class="weui_input" style="border: double;border:0.5px solid #d8d8d8;height: 45px;color: grey;margin-top: 10px;" type="tel" id="phone" value="${bean.phone}" placeholder=" 电话" maxlength="11" />
        <c:if test="${exit == 0 }">
            <button class="weui_btn weui_btn_primary" style="margin-top:20px;background-color: #f64347;" id="buttonSub1" onclick="sub()">提交</button>
            <button class="weui_btn weui_btn_primary" style="margin-top:20px;background-color: grey;display: none;" id="buttonSub2">提交</button>
        </c:if>
        <c:if test="${exit == 1 }">
            <button class="weui_btn weui_btn_primary" style="margin-top:20px;background-color: grey;">提交</button>
        </c:if>
    </div>
</div>
<script type="text/javascript" src="${path}/resources/css/userCenterBingPhonePage/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">

    function sub() {
        var name = $("#name").val();
        var phone = $("#phone").val();
        var menuId = '${menuId}';
        if(name == ""){
            webToast("请输入你的姓名","middle",1000);//top middle bottom 控制显示位置
            return false;
        }
        if(phone == ""){
            webToast("请输入你的电话","middle",1000);//top middle bottom 控制显示位置
            return false;
        }
        if(phone != ""){
            if(!isPoneAvailable(phone)){
                webToast("请输入正确的手机号码","middle",1000);//top middle bottom 控制显示位置
                return false;
            }
        }

        $.post("${path}/cardInUser/saveCard",{'menuId':menuId,'name':name,'phone':phone,'address':''},function(info){
            if(info == "0"){
                webToast("申请护照失败","middle",2000);//top middle bottom 控制显示位置
            }
            if(info == "1"){
                webToast("申请护照成功","middle",2000);//top middle bottom 控制显示位置
                $("#topShow").show();
                window.location.href='${path}/cardInUser/pass?menuId=${menuId}';
            }
            if(info == "-1"){
                webToast("参数校验失败","middle",2000);//top middle bottom 控制显示位置
            }
            if(info == "-2"){
                webToast("登录超时，请刷新重试","middle",2000);//top middle bottom 控制显示位置
            }
            if(info == "-3"){
                $("#buttonSub1").hide();
                $("#buttonSub2").show();
                $("#topShow").show();
            }else{
                webToast("申请成功" ,"middle",2000);//top middle bottom 控制显示位置
            }
        });


    }

    function clickButton(obj) {
        var phone = $("#phone").val();
        if(!isPoneAvailable(phone)){
            webToast("请输入正确的手机号码","middle",1000);//top middle bottom 控制显示位置
            return false;
        }
    }


    /**
     * 手机号码验证
     * @param input
     * @returns {boolean}
     */
    function isPoneAvailable(input) {
        var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (!reg.test(input)) {
            return false;
        } else {
            return true;
        }
    }

</script>
</body>
</html>