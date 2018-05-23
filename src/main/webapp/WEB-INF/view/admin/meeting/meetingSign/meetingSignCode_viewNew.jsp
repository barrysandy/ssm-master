<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<html>
<head>
    <title>搜索结果</title>
    <%@ include file="/WEB-INF/common_andy.jsp" %>
    <script src="${path }/resources/js/plugins/layer/layer.min.js"></script>
    <script src="${path }/resources/layui/layui.js"></script>
    <script src="${path }/resources/layui/layuiUtil.js"></script>
    <style>
        .m-table tbody tr td {
            padding: 0 !important;
            vertical-align: middle;
        }

        .status i {
            color: #CCCCCC;
            font-size: 26px;
            width: 26px;
            height: 18px;
            display: block
        }

        /*双日期*/
        .calender-d {  width:auto; display:inline-block; float:left }
        .calender-d .clabel {float:left;height:25px;line-height: 25px; width: auto;margin-right: 10px}
        .calender-d .cstart-span {float:left;margin-right:10px;width: 130px;}
        .calender-d .cline {float:left;margin-right:10px;width: auto;line-height: 22px}
        .calender-d .cend-span {float:left;width: 130px;}

        /*下拉框*/
        .select-combo-s {width:150px; display:inline-block; float:left;margin-left: 20px;}
        .select-combo-s .clabel {float:left;height:25px;line-height: 25px; width: 60px;}
        .select-combo-s .cselect {width:200px;height:25px;line-height: 25px;border: 1px solid #C6C6C6;border-radius: 3px;}

        /*搜索框*/
        .search-s {width:200px; display:inline-block; float:left;margin: 1px 20px 0px 20px}
        .search-s .c-input{line-height: 25px !important;width: 140px}
        .search-s .c-btn{line-height: 25px !important;}

        table {
            table-layout: fixed;
        }

        #table1 td {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        #table1 td:hover{
            text-overflow: clip;
            white-space: normal;
            overflow:visible;
        }

        *{padding:0px;margin:0px;}
        .pop {  display: none;  width: 95%; height:80%;  position: absolute;  top: 0;  left: 0;  bottom: 0;  right: 0;  margin: auto;  padding: 25px;  z-index: 130;  border-radius: 8px;  background-color: #fff;  box-shadow: 0 3px 18px rgba(100, 0, 0, .5);  }
        .pop-top{  height:40px;  width:100%;  border-bottom: 1px #E5E5E5 solid;  }
        .pop-top h2{  float: left;  display:black}
        .pop-top span{  float: right;  cursor: pointer;  font-weight: bold; display:black}
        .pop-foot{  height:50px;  line-height:50px;  width:100%;  border-top: 1px #E5E5E5 solid;  text-align: right;  }
        .pop-cancel, .pop-ok {  padding:8px 15px;  margin:15px 5px;  border: none;  border-radius: 5px;  background-color: #337AB7;  color: #fff;  cursor:pointer;  }
        .pop-cancel {  background-color: #FFF;  border:1px #CECECE solid;  color: #000;  }
        .pop-content{  height: 380px;  }
        .pop-content-left{  float: left;  }
        .pop-content-right{  width:310px;  float: left;  padding-top:20px;  padding-left:20px;  font-size: 16px;  line-height:35px;  }
        .bgPop{  display: none;  position: absolute;  z-index: 129;  left: 0;  top: 0;  width: 100%;  height: 100%;  background: rgba(0,0,0,.2);  }
    </style>

</head>
<body>
<div class="g-layout">
    <div class="layout-center">
        <div class="g-max f-p-xs f-p-t-n" id="PrintContentDiv">

            <input type="hidden" id="alertWindow" class="click_pop" />
            <!--遮罩层-->
            <div class="bgPop"></div>
            <!--弹出框-->
            <div class="pop">
                <div class="pop-content">
                    <div class="pop-content-left">
                        <img src="" alt="" class="teathumb">
                    </div>
                    <div id="box" class="pop-content-right" style="width: auto;background-color: white;">
                        <table class="m-table" id="table1" an-datagrid style="width:100%">
                            <thead>
                            <tr>
                                <th align="center">序号</th>
                                <th align="center">姓名</th>
                                <th align="center">职位</th>
                                <th align="center">机构</th>
                                <th align="center">类型</th>
                                <th align="center">签到码</th>
                                <th align="center">电话</th>
                                <th align="center">晚宴</th>
                                <th align="center">状态</th>
                                <th align="center">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="bean" items="${list}" varStatus="status">
                                <tr>
                                    <td align="center" style="width: 5%;font-size: 12px;">${status.index+1}</td>
                                    <td align="center" style="font-size: 12px;">${bean.name}</td>
                                    <td align="center" style="font-size: 12px;">${bean.position}</td>
                                    <td align="center" style="font-size: 12px;">${bean.company}</td>
                                    <td align="center" style="font-size: 12px;">${bean.personType}</td>
                                    <td align="center" style="font-size: 12px;">${bean.signCode}</td>
                                    <td align="center" style="font-size: 12px;">${bean.phone}</td>
                                    <td align="center" style="font-size: 12px;">
                                        <c:if test="${bean.joinDinner == 1}"><span style="color: green;">参加</span></c:if>
                                        <c:if test="${bean.joinDinner == 0}"><span style="color: red;">不参加</span></c:if>
                                    </td>
                                    <td align="center" style="font-size: 12px;">
                                        <c:if test="${bean.status == 1}"><span style="color: green;">已签到</span></c:if>
                                        <c:if test="${bean.status == 0}"><span style="color: red;">未签到</span></c:if>
                                    </td>
                                    <td align="center" style="font-size: 12px;">
                                        <button class="u-btn sm texture f-m-l-xs" title="签到" type="button" onClick="signIt('${bean.id}')">
                                            <i class="iconfont" style="color: blue;">&#xe700;</i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    $('.pop-close').click(function () {
                        $('.bgPop,.pop').hide();
                    });
                    $('.click_pop').click(function () {
                        $('.bgPop,.pop').show();
                    });
                })

            </script>
        </div>


    </div>
    <div class="layout-foot f-b-t f-p-t-xs f-bg-light noprint" style="height:40px">
        <div class="f-right f-m-r-xs">
            <button type="button" class="u-btn" onClick="cancel()">关闭</button>
        </div>
    </div>
</div>
<%--<input type="hidden" id="id" value="${bean.id}"/>--%>
<script>
    function layuiUtilMsg(data) {
        LayuiUtil.msg(data);
    }

    $(function() {// 初始化内容
        $("#alertWindow").click();
    });

    function cancel() {
        window.parent.location.reload();
//            var index = parent.layer.getFrameIndex(window.name);
//            parent.layer.close(index);
    }

    function signIt(id) {
        layer.open({
            type: 1,
            title: '提示',
            skin: 'layui-layer-rim',
            area: ['400px', '200px'],
            content: '<div style="padding: 42px 112px; font-size: 16px; color: #808080;" >确认签到?</div>',
            btn: ['确认','取消'],
            yes: function(){
                layer.closeAll();
                signYes(id);
            },
            btn2: function(){
                console.log('no');
            }
        });
    }

    function signYes(id) {
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
    }
</script>
</body>
</html>
