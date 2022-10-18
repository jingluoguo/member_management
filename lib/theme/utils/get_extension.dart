import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_interface.dart';


extension GetExtension on GetInterface {

  /// 获取高度占位
  SizedBox getHeightBox(double height){
    return SizedBox(height: height, width: 1,);
  }

  /// 获取宽度占位
  SizedBox getWidthBox(double width){
    return SizedBox(height: 1, width: width,);
  }

  /// 隐藏软键盘
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
