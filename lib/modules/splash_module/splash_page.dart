/// 原生
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 第三方
import 'package:get/get.dart';

/// 本地资源
import 'splash_controller.dart';
import '../../theme/utils/export.dart';
import '../../utils/widget/common.dart';

class SplashPage extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return customerTheme(
        false,
        SystemUiOverlayStyle.dark,
        Text(""),
        boxDecoration: BoxDecoration(
            color: c_1C9BD5
        )
    );
  }
}
