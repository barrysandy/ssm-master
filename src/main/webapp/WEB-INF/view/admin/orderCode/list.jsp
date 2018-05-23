<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<head>
    <title>订单核销码列表</title>
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

    </style>
    <script>


        function layuiUtilMsg(data) {
            LayuiUtil.msg(data);
        }

        /**
         *提交表单
         */
        function sumitForm() {
            $("#listForm").submit();
        }
    </script>
</head>
<body>
<div class="g-max">
    <input type="hidden" id="pageNo" value="${pager.pageNumber}">
    <input type="hidden" id="pageSize" value="${pager.pageSize}">
    <div class="m-tabs head-top style01" id="tabs" an-tabs>
        <div class="m-tabs-content">
            <div class="item f-p-xs activate">
                <div class="g-h-max">
                    <form id="listForm" method="post" action="${path}/order/listOrderCode">
                        <div class="g-layout m-panel u-datagrid f-b f-b-n-b">
                            <div class="layout-head panel-head">
                                <div class=" panel-head-btnbar">
                                    <a class="u-btn sm success" type="button" href="${path}/order/list">
                                        <i class="iconfont">&#xe60b;</i> 刷新重载
                                    </a>
                                </div>
                            </div>
                            <div class="layout-center">
                                <table class="m-table" id="table1" an-datagrid style="width:100%">
                                    <thead>
                                    <tr>
                                        <th align="center" style="width:30px">序号</th>
                                        <th style="width:80px" align="center">ID</th>
                                        <th style="width:80px" align="center">订单ID / 订单编号</th>
                                        <th style="width:65px" align="center">核销码</th>
                                        <th style="width:15%" align="center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="bean" items="${list}" varStatus="status">
                                        <tr>
                                            <td align="center">${status.index+1}</td>
                                            <td align="center">${bean.id}</td>
                                            <td align="center">${bean.orderId} / ${bean.orderNo}</td>
                                            <td align="center">${bean.useCode}<br>
                                                <img src="http://qr.liantu.com/api.php?text=${bean.useCode}" height="40px" width="auto" style="margin-top: 4px;" onerror="this.src='${path}/resources/img/usermen.png'" >
                                            </td>
                                            <td align="center">
                                                暂无
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
