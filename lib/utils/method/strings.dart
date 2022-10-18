/// 报名状态对照表
Map<int, String> postState = {
  1 : "待审核",
  2 : "重新提交",
  3 : "待缴费",
  4 : "缴费失败",
  5 : "待考试",
  6 : "考试失败",
  7 : "待考核",
  8 : "通过考试",
  9 : "未通过考试"
};

/// 订单状态对照表
Map<int, String> orderState = {
  1 : "待支付",
  2 : "待发货",
  3 : "已发货",
  4 : "已完成",
  5 : "已失效",
};

/// 订单退款状态对照表
Map<dynamic, String> orderRefundState = {
  0 : "",
  1 : "申请退款中",
  2 : "退款成功",
  3 : "拒绝退款",
};

/// 支付方式对照表
Map<int, String> payWay = {
  1 : "微信",
  2 : "支付宝",
};

/// 支付方式对照表
Map<int, String> sexStatus = {
  1 : "男",
  2 : "女",
  3 : "其他"
};

/// 订单类型对照表
Map<int, String> orderType = {
  1 : "考试报名",
  2 : "教材",
  3 : "教学视频",
  4 : "专家点评",
};

/// 专家点评状态对照表
String expertReviewState(int state, int hasComment) {
  var response;
  if(state == 1){
    response = '待支付';
  } else if(state == 3){
    response = '支付失败';
  } else if(state == 2 && hasComment == 2){
    response = '查看点评';
  } else {
    response = '待点评';
  }
  return response;
}

/// 1、2转换
oneToTwo(int index){
  if(index == 1){
    return 0;
  } else {
    return 1;
  }
}

/// 微信部分
String weixinAppId = "wxf0f0af5da83ea520";
String weixinAppSecret = "d9925943d065e748e4e3b1bb28fa8e14";
String weixinUniversalLink = "https://268a3f293d68d928a2fb03554224b5f4.share2dlink.com/";