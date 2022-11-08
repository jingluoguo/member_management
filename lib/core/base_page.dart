import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:member_management/utils/widget/common.dart';

import 'base_controller.dart';
import 'package:member_management/theme/utils/export.dart';

abstract class BasePage<T extends BaseController> extends GetView<T> {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Platform.isAndroid
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            )
          : systemUIOverlayStyle,
      child: WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            drawer: drawer,
            body: Builder(
              builder: (BuildContext context){
                return GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: boxDecoration,
                    child: Column(
                      children: [
                        safePadding(context, color: statusBgColor),
                        Expanded(child: buildBody(context))
                      ],
                    ),
                  ),
                );
              },
            )),
        onWillPop: onWillPop,
      ),
    );
  }

  bool get resizeToAvoidBottomInset => false;

  SystemUiOverlayStyle get systemUIOverlayStyle {
    return SystemUiOverlayStyle.dark;
  }

  BoxDecoration get boxDecoration => const BoxDecoration();

  void Function()? get onTap => () {
        return Get.hideKeyboard(Get.context!);
      };

  WillPopCallback get onWillPop => () async {
        return Get.global(null).currentState?.canPop() == true;
      };

  void Function(BuildContext context) get onScaffoldTap => (BuildContext context){};

  Widget? get drawer => null;

  Widget buildBody(BuildContext context);

  Color get statusBgColor => Colors.white;
}
