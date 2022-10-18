/// 第三方
import 'package:get/get.dart';

/// 本地资源
import '../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed(Routes.main);
  }
}
