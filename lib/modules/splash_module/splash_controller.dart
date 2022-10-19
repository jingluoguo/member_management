/// 第三方
import 'package:get/get.dart';
import 'package:member_management/core/base_controller.dart';

/// 本地资源
import '../../routes/app_pages.dart';

class SplashController extends BaseController {

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(Routes.main);
    super.onInit();
  }
}
