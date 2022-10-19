/// 第三方
import 'package:get/get.dart';

/// 本地资源
import 'socket_controller.dart';

class SocketBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SocketController());
  }
}
