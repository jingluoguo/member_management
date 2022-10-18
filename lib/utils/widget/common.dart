/// 原生
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 第三方包
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 本地
import '../method/strings.dart';
import '../../theme/utils/export.dart';

/// toast信息
toastShow(msg){
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0
  );
}

/// 通用主题模板
customerTheme(bool inset, SystemUiOverlayStyle value, Widget body, {BoxDecoration? boxDecoration = const BoxDecoration(
    color: Colors.white
), Function()? onTap, bool willPop = false}){
  if(Platform.isAndroid){
    value = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
  }
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      child: Scaffold(
          resizeToAvoidBottomInset: inset,
          body: willPop ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: boxDecoration,
                child: body,
                margin: EdgeInsets.only(top: 10.dp),
              ),
            ),
          ) : GestureDetector(
            onTap: onTap,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: boxDecoration,
              child: Column(
                children: [
                  Get.getHeightBox(10.dp),
                  Expanded(child: body)
                ],
              ),
            ),
          )
      )
  );
}

/// 通用图标(可省略)+上文字+下文字+图标组件，包含可点击事件
customerIconTextSubTextIcon(BuildContext context, text, textSize, subText, subTextSize, {Function()? onTap, dynamic leftIcon, dynamic iconSize}){
  return customerContainer(58.dp, MediaQuery.of(context).size.width, c_FF, 10.dp,body: Row(
    children: [
      Get.getWidthBox(16.dp),
      leftIcon != null ? Image.asset(
        leftIcon,
        width: iconSize??28.dp,
        height: iconSize??28.dp,
      ) : Text(""),
      leftIcon != null ? Get.getWidthBox(10.dp) : Text(""),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          singleTextWeight("$text", c_00, textSize),
          Get.getHeightBox(6.dp),
          singleTextWeight("$subText", c_8592AD, subTextSize),
        ],
      ),
      Expanded(child: Text("")),
      Image.asset(
        R.imagesHomeNextIcon,
        width: 28.dp,
        height: 28.dp,
      ),
      Get.getWidthBox(16.dp),
    ],
  ), onTap: onTap);
}

/// 通用图标(可省略)+文字+图标组件，包含可点击事件
customerIconTextIcon(BuildContext context, text, textSize, {Function()? onTap, dynamic leftIcon, dynamic iconSize}){
  return customerContainer(58.dp, MediaQuery.of(context).size.width, c_FF, 10.dp,body: Row(
    children: [
      Get.getWidthBox(16.dp),
      leftIcon != null ? Image.asset(
        leftIcon,
        width: iconSize??28.dp,
        height: iconSize??28.dp,
      ) : Text(""),
      leftIcon != null ? Get.getWidthBox(10.dp) : Text(""),
      singleTextWeight("$text", c_00, textSize),
      Expanded(child: Text("")),
      Image.asset(
        R.imagesHomeNextIcon,
        width: iconSize??28.dp,
        height: iconSize??28.dp,
      ),
      Get.getWidthBox(16.dp),
    ],
  ), onTap: onTap);
}

/// 通用图标(可省略)+左文字+右文字+右图标(可省略)组件，包含可点击事件
customerLeftTextRightText(BuildContext context, lText, lTextSize, rText, rTextSize, {Function()? onTap, dynamic leftIcon, dynamic iconSize, dynamic rightIcon, rightColor}){
  return customerContainer(58.dp, MediaQuery.of(context).size.width, c_FF, 10.dp,body: Row(
    children: [
      Get.getWidthBox(16.dp),
      leftIcon != null ? Image.asset(
        leftIcon,
        width: iconSize??28.dp,
        height: iconSize??28.dp,
      ) : Text(""),
      leftIcon != null ? Get.getWidthBox(10.dp) : Text(""),
      singleTextWeight("$lText", c_00, lTextSize),
      Expanded(child: Text("")),
      singleTextWeight("$rText", rightColor??c_00, rTextSize),
      rightIcon != null ? Image.asset(
        rightIcon,
        width: iconSize??28.dp,
        height: iconSize??28.dp,
      ) : Text(""),
      Get.getWidthBox(16.dp),
    ],
  ), onTap: onTap);
}

/// 通用页面头部
Widget customerHeader(BuildContext context, Color headerColor, String centerText, {Widget? leftContent, Widget? rightContent}){
  return Container(
    color: headerColor,
    width: double.infinity,
    height: 34.dp,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/6,
              child: leftContent,
            ),
            Container(
              width: MediaQuery.of(context).size.width*2/5,
              child: Center(
                child: singleTextWeight(centerText, c_00, 18.dp),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/6,
              child: rightContent,
            ),
          ],
        ),
        Expanded(child: Text("")),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/5,
              height: 5.dp,
            ),
            Container(
              width: MediaQuery.of(context).size.width/10,
              height: 5.dp,
              decoration: BoxDecoration(
                color: c_FDAE2D,
                borderRadius: BorderRadius.circular(10.dp)
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/5,
              height: 2.dp,
            ),
          ],
        ),
        Container(
          color: c_00,
          height: 0.1.dp,
          width: MediaQuery.of(context).size.width,
        )
      ],
    ),
  );
}

/// 自定义容器
/// height：高
/// width：宽
/// color：颜色
/// circular：圆角
customerContainer(height, width, color, circular, {Function()? onTap, Widget? body, double boxShadow = 0.0, EdgeInsetsGeometry? margin}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(circular),
        ),
        boxShadow: [BoxShadow(color: c_656565.withOpacity(0.1), blurRadius: boxShadow)],
      ),
      child: body,
    ),
  );
}

/// 自定义上图标下文字及可点事件
Widget customerTopIconAndBottomText(String src, String title, Color color, {Function()? onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          src,
          width: 48.dp,
          height: 48.dp,
        ),
        Get.getHeightBox(10.dp),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
          ),
        )
      ],
    ),
  );
}

/// 通用获取安全顶部距离
Widget safePadding(BuildContext context, color){
  return Container(
    height: MediaQuery.of(context).padding.top,
    color: color,
  );
}

/// 通用简单text格式
singleTextWeight(text, color, fontSize, {FontWeight? fontWeight, TextOverflow? overflow=TextOverflow.ellipsis, TextAlign? textAlign}){
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    textAlign: textAlign??TextAlign.left,
    overflow: overflow,
  );
}

/// 用户头像
Widget userAvatar(img, size){
  return Padding(
    padding: EdgeInsets.all(10.dp),
    child: (img == null || img == "")
        ? Image.asset(
      "",
      height: size,
    )
        : CircleAvatar(
      radius: size/2,
      backgroundImage: NetworkImage(img),
    ),
  );
}

/// 暂无数据页面
Widget noDataPage(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(R.imagesCommonNoDataIcon),
      Center(
        child: singleTextWeight("暂无数据", c_656565, 16.dp),
      )
    ],
  );
}

/// 加载中
Widget loadingWidget(){
  return const Center(
    child: SizedBox(
      width: 32,
      height: 32,
      child: CircularProgressIndicator(),
    ),
  );
}

/// 弹出框
alertContainer(context, text){
  return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return RotatedBox(
          quarterTurns: 1,
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dp),
            ),
            children: <Widget>[
              Get.getWidthBox(MediaQuery.of(context).size.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Get.getHeightBox(20.dp),
                  singleTextWeight("警告", c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  singleTextWeight("$text", c_00, 16.dp),
                  Get.getHeightBox(10.dp),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: ()=>Get.back(result: {"status": false}),
                            child: singleTextWeight("取消", c_5ADBEA, 18.dp, fontWeight: FontWeight.normal)
                        ),
                        Container(
                          height: 60.dp,
                          color: c_FF,
                          width: 0.5.dp,
                        ),
                        GestureDetector(
                            onTap: ()=>Get.back(result: {"status": true}),
                            child: singleTextWeight("确认", c_757676, 18.dp, fontWeight: FontWeight.normal)
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
}

/// 三选项弹出框
alertThreeContainer(context, text){
  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return RotatedBox(
        quarterTurns: 1,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.dp),
          ),
          children: <Widget>[
            Get.getWidthBox(MediaQuery.of(context).size.width),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Get.getHeightBox(20.dp),
                singleTextWeight("警告", c_00, 18.dp, fontWeight: FontWeight.bold),
                Get.getHeightBox(10.dp),
                Container(
                  width: MediaQuery.of(context).size.width*2/3,
                  child: singleTextWeight("$text", c_00, 16.dp, overflow: TextOverflow.fade),
                ),
                Get.getHeightBox(10.dp),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: ()=>Get.back(result: {"status": 0}),
                        child: Container(
                          height: 60.dp,
                          child: Center(
                            child: singleTextWeight("取消", c_5ADBEA, 18.dp, fontWeight: FontWeight.normal),
                          ),
                        )
                      ),
                      GestureDetector(
                          onTap: ()=>Get.back(result: {"status": 1}),
                          child: Container(
                            height: 60.dp,
                            child: Center(
                              child: singleTextWeight("重录", c_757676, 18.dp, fontWeight: FontWeight.normal),
                            ),
                          )
                      ),
                      GestureDetector(
                          onTap: ()=>Get.back(result: {"status": 2}),
                          child: Container(
                            height: 60.dp,
                            child: Center(
                              child: singleTextWeight("提交", c_757676, 18.dp, fontWeight: FontWeight.normal),
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}

/// 提示框
alertContainerOnlyQuit(context, text){
  return showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return RotatedBox(
        quarterTurns: 1,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.dp),
          ),
          children: <Widget>[
            Get.getWidthBox(MediaQuery.of(context).size.width),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Get.getHeightBox(20.dp),
                singleTextWeight("警告", c_00, 18.dp, fontWeight: FontWeight.bold),
                Get.getHeightBox(10.dp),
                singleTextWeight("$text", c_00, 16.dp),
                Get.getHeightBox(10.dp),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: ()=>Get.back(result: {"status": true}),
                          child: Container(
                            height: 60.dp,
                            child: Center(
                              child: singleTextWeight("确认", c_757676, 18.dp, fontWeight: FontWeight.normal),
                            ),
                        )
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}

/// 展示考试须知底部弹窗
showExamBottomView(BuildContext context){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context){
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: c_FF,
          padding: EdgeInsets.only(top: 40.dp, left: 16.dp, right: 16.dp),
          child: Column(
            children: [
              singleTextWeight("拍摄要求", c_00, 22.dp, fontWeight: FontWeight.bold),
              Get.getHeightBox(5.dp),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      singleTextWeight("ⓘ以下内容非常重要，请认真仔细阅读", c_FDAE2D, 12.dp),
                      Get.getHeightBox(5.dp),
                      customerContainer(1.dp, MediaQuery.of(context).size.width, c_656565.withOpacity(0.1), 0.dp),
                      Get.getHeightBox(5.dp),
                      singleTextWeight("1、使用手机后置摄像头横屏拍摄(请勿使用平板);", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("2、支持安卓5.0以上版本，苹果IOS9以上版本;", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("3、在Wi-Fi环境，开启飞行模式; \n使用手机流量上网的环境下，开启勿扰模式", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("4、使用考级app前，在手机设置中确认'网络'、'麦克风'和'照相机'权限已打开;", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("5、在拍摄过程中，请勿进行任何的手机操作，如：切换软件到后台运行、点击手机的返回键【苹果(home)】和锁屏键等;", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("6、在拍摄过程中，如遇手机的消息推送时，如微信，短信等弹出时，请勿理会，不要惦记，直接忽略即可，因点击导致视频录制的终端，将直接终止考试;", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("7、请根据各专业乐器或站立引导框拍摄，录制换面只允许出现考生一人，全程不得离开画面，不可背对镜头;", c_00, 16.dp, overflow: TextOverflow.visible),
                      Get.getHeightBox(10.dp),
                      singleTextWeight("8、录制完成后，请勿直接关闭退出app，请等待视频上传结束后，根据系统提示再退出;", c_00, 16.dp, overflow: TextOverflow.visible),
                      customerContainer(46.dp, MediaQuery.of(context).size.width, c_FDAE2D, 10.dp, body: Center(
                        child: singleTextWeight("进入考级页面", c_FF, 16.dp),
                      ), margin: EdgeInsets.only(bottom: 16.dp, left: 16.dp, right: 16.dp, top: 16.dp),
                          onTap: ()=>Get.back(result: true)
                      )
                    ],
                  )
                )
              )
            ],
          ),
        );
      }
  );
}