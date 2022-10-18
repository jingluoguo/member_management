import 'package:get/get.dart';
import 'package:member_management/modules/detail_module/detail_controller.dart';

/// guoshijun created this file at 2022/10/3 22:42
///
///

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
  }
}