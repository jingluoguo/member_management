/// 第三方
import 'package:get/get.dart';

/// 本地资源
import 'splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
