/// 第三方
import 'package:get/get.dart';
import 'package:member_management/core/base_controller.dart';

/// 本地资源
import '../../routes/app_pages.dart';

class SplashController extends BaseController {

  var x = 0.obs;
  @override
  void onInit() async {
    print('走这里了/？');
    x.value = 1;
    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(Routes.main);
    super.onInit();
  }
}
