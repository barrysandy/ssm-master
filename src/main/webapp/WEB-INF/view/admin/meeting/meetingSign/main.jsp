﻿<!doctype html>
<html>
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>会议签到</title>
    <%@ include file="/WEB-INF/common_andy.jsp" %>
    <script src="${path }/resources/js/plugins/layer/layer.min.js"></script>
    <script src="${path }/resources/layui/layui.js"></script>
    <script src="${path }/resources/layui/layuiUtil.js"></script>

    <!--[if lt IE 9]>
    <script type="text/javascript" src="${path}/resources/meetingSign/lib/html5.js"></script>
    <script type="text/javascript" src="${path}/resources/meetingSign/lib/respond.min.js"></script>
    <script type="text/javascript" src="${path}/resources/meetingSign/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link href="${path}/resources/meetingSign/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/meetingSign/static/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/meetingSign/static/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/meetingSign/lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>

<input type="hidden" id="id" value="${id }" />
<div class="loginWraper">
    <div align="center" style="margin-top: 4.5%;font-size: 24px;color: slategray;"><span style="color: black">${bean.title}</span>会议签到</div>
    <div id="loginform" class="loginBox">
        <div class="form form-horizontal">
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                <div class="formControls col-xs-8">
                    <input id="signCode" type="text" placeholder="输入签到码/手机号码方式签到" class="input-text size-L">
                </div>
            </div>
        </div>
    </div>

    <div align="center" style="opacity:0.8;margin-left: 32.5%;height: 25%;margin-bottom: 10%;width: 35%;background-color: #8fb9d3;position: fixed;bottom: 0;">
        <div align="left" style="margin-top: 3.5%;margin-left: 20%;">
            <table>
                <tr>
                    <td style="font-size: 18px;">姓名：<span style="color: black" id="name">-- --</span></td>
                    <td style="font-size: 18px;">职位：<span style="color: black" id="position">-- --</span></td>
                </tr>

                <tr>
                    <td style="font-size: 18px;">机构：<span style="color: black" id="company">-- --</span></td>
                    <td style="font-size: 18px;">电话：<span style="color: black" id="phone">-- --</span></td>
                </tr>
                <tr>
                    <td style="font-size: 18px;">类型：<span style="color: black" id="personType">-- --</span></td>
                    <td style="font-size: 18px;">晚宴：<span style="color: black" id="joinDinner">-- --</span></td>
                </tr>
                <tr>
                    <td style="font-size: 18px;">签到码：<span style="color: black" id="signCode2">-- --</span></td>
                </tr>
                <tr>
                    <td style="font-size: 18px;">签到人数：<span style="color: black" id="total"> ${total} </span></td>
                </tr>
            </table>
            <img id="img" style="display: none;margin-top: 0%;margin-left: 0%;" src="${path}/resources/img/icon/yes.png" width=6%"/>
        </div>
    </div>
</div>
<div class="footer">Copyright 智胜西行 by xiaowuSCCC.admin.v1.0.0</div>
<script type="text/javascript" src="${path}/resources/meetingSign/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/meetingSign/static/h-ui/js/H-ui.js"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?080836300300be57b7f34f4b3e97d911";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F080836300300be57b7f34f4b3e97d911' type='text/javascript'%3E%3C/script%3E"));
</script>
<script>

    $(function() {// 初始化获取输入框
        init();
    });

    /** 重置SignCode */
    function init() {
        document.getElementById('signCode').focus();
        $("#signCode").val("");
    }

    function layuiUtilMsg(data) {
        LayuiUtil.msg(data);
    }

    function isNumber(val){

        var regPos = /^\d+(\.\d+)?$/; //非负浮点数
        var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
        if(regPos.test(val) || regNeg.test(val)){
            return true;
        }else{
            return false;
        }

    }

    $('input').keydown(function(e){
        if(e.keyCode==13){
            var signCode = $("#signCode").val();
            init();
            var id = $("#id").val();
            var booleanCode = isNumber(signCode);
            if(booleanCode){
                $.get('${path}/meeting/interfaceGetMeetingUser',{'signCode':signCode,'id':id},function(data){
                    if(data == "0"){
                        layuiUtilMsg("没有搜索到！");
                        document.getElementById('signCode').focus();
                        $("#signCode").val("");
                    }else{
                        var signCode = data.signCode ;
                        if(signCode.length > 0){
                            //view (signCode);
                            $("#name").text(data.name);
                            $("#position").text(data.position);
                            $("#company").text(data.company);
                            $("#phone").text(data.phone);
                            $("#personType").text(data.personType);
                            $("#signCode2").text(data.signCode);
                            if(data.joinDinner == 0){
                                $("#joinDinner").text("不参加");
                            }else if(data.joinDinner == 1){
                                $("#joinDinner").text("参加");
                            }
                            var id = data.id;
                            //延迟执行
                            setTimeout(function(){
                                //location.reload();
                                var url = "${path}/meeting/interfaceGetMeetingUpdateStatus";
                                $.get(url,{'id':id},function(data){
                                    if(data != ""){
                                        var array = data.split(",");
                                        if(array.length == 0){
                                            layuiUtilMsg("签到异常!!!" + data);
                                        }else {
                                            var info = array[0];
                                            var total = array[1];

                                            if(info == 1 || info == "1"){
                                                $("#total").text(" " + total + " ");
                                                $("#img").show();
                                                layuiUtilMsg("签到成功。");
                                                setTimeout(function(){
                                                    $("#img").hide();
                                                }, 500);
                                            }else{
                                                layuiUtilMsg("签到失败!!!");
                                                setTimeout(function(){
                                                    $("#img").hide();
                                                }, 500);
                                            }
                                        }
                                    }


                                });
                            }, 1200);

                        }else {
                            layuiUtilMsg("无效的签名码！");
                            initInput();
                        }
                    }
                });
            }else{
                //非数字作为名字查询
//                alert("名字查询！！");
                var url = "${path}/meeting/interfaceGetMeetingUserByName";
                $.get(url,{'signCode':signCode,'id':id},function(data){
//                    alert(data);
                    if(data == "0" || data == ""){
                        layuiUtilMsg("没有搜索到！");
                        initInput();
                    }else{
                        alertNewWin(signCode,id);
                    }
                });
            }

        }
    })

    function alertNewWin(signCode,id){
        layer.open({
            type: 2,
            title: '名字搜索结果',
            skin: 'layui-layer-rim',
            area: ['55%', '55%'],
            content: '${path}/meeting/interfaceGetMeetingUserByNameToPage?signCode=' + signCode + '&id=' + id
        });
    }

    function initInput() {
        document.getElementById('signCode').focus();
        $("#signCode").val("");
    }

    function view (signCode) {
        var id = $("#id").val();
        layer.open({
            type: 2,
            title: '签到详情',
            skin: 'layui-layer-rim',
            area: ['55%', '65%'],
            content: '${path}/meeting/toSignCodeView?signCode='+signCode + '&id='+id
        });
    }

</script>
</body>
</html>