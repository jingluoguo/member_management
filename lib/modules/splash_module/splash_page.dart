/// 原生
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 第三方
import 'package:get/get.dart';
import 'package:member_management/core/base_page.dart';

/// 本地资源
import 'splash_controller.dart';
import '../../theme/utils/export.dart';
import '../../utils/widget/common.dart';

class SplashPage extends BasePage<SplashController> {
  SplashPage({Key? key}) : super(key: key);


  @override
  BoxDecoration boxDecoration = BoxDecoration(
      color: c_1C9BD5
  );

  @override
  Color get statusBgColor => c_1C9BD5;

  @override
  Widget buildBody(BuildContext context) {
    return const SizedBox();
  }
}
