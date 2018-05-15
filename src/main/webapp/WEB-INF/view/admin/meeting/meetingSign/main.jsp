<!doctype html>
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
    <div align="center" style="margin-top: 10%;font-size: 24px;color: slategray;">会议签到系统</div>
    <div id="loginform" class="loginBox">
        <div class="form form-horizontal">
            <div class="row cl">
                <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                <div class="formControls col-xs-8">
                    <input id="signCode" type="text" placeholder="签到码" class="input-text size-L">
                </div>
            </div>
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
        document.getElementById('signCode').focus();
        $("#signCode").val("");
    });

    function layuiUtilMsg(data) {
        LayuiUtil.msg(data);
    }

    $('input').keydown(function(e){
        if(e.keyCode==13){
            var signCode = $("#signCode").val();
            var id = $("#id").val();
            //alert(signCode);
            $.get('${path}/meeting/interfaceGetMeetingUser',{'signCode':signCode,'id':id},function(data){
                if(data == "0"){
                    layuiUtilMsg("没有搜索到！")
                    document.getElementById('signCode').focus();
                    $("#signCode").val("");
                }else{
                    //layuiUtilMsg(data.name + data.company);
                    var signCode = data.signCode ;
                    if(signCode.length > 0){
                        view (signCode);
                    }else {
                        layuiUtilMsg("无效的签名码！")
                        document.getElementById('signCode').focus();
                        $("#signCode").val("");
                    }
                }
            });
        }
    })


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