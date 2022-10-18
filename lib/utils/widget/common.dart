/// 原生
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 第三方包
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 本地
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

/// 通用页面头部
Widget customerHeader(Color headerColor, String centerText, {Widget? leftContent, Widget? rightContent}){
  return Container(
    color: headerColor,
    width: double.infinity,
    height: 34.dp,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.size.width/6,
              child: leftContent,
            ),
            SizedBox(
              width: Get.size.width*2/5,
              child: Center(
                child: singleTextWeight(centerText, c_00, 18.dp),
              ),
            ),
            SizedBox(
              width: Get.size.width/6,
              child: rightContent,
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.size.width/5,
              height: 5.dp,
            ),
            Container(
              width: Get.size.width/10,
              height: 5.dp,
              decoration: BoxDecoration(
                color: c_FDAE2D,
                borderRadius: BorderRadius.circular(10.dp)
              ),
            ),
            SizedBox(
              width: Get.size.width/5,
              height: 2.dp,
            ),
          ],
        ),
        Container(
          color: c_00,
          height: 0.1.dp,
          width: Get.size.width,
        )
      ],
    ),
  );
}

/// 通用获取安全顶部距离
Widget safePadding(BuildContext context, {Color color = Colors.white}){
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