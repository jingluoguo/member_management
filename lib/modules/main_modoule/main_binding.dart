import 'package:get/get.dart';
import 'package:member_management/modules/main_modoule/main_controller.dart';

/// guoshijun created this file at 2022/10/3 22:42
///
///

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}