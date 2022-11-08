/// 原生
import 'package:flutter/material.dart';

/// 第三方
import 'package:get/get.dart';
import 'package:member_management/core/base_page.dart';

/// 本地资源
import '../../theme/utils/export.dart';
import 'socket_controller.dart';

class SocketPage extends BasePage<SocketController> {
  SocketPage({Key? key}) : super(key: key);

  @override
  Widget buildBody(BuildContext context){
    return Column(
      children: [
        GestureDetector(
          onTap: ()=>controller.serviceBinding('192.168.4.72', 8090),
          child: Container(
            height: 48.dp,
            width: 100.dp,
            color: Colors.cyanAccent,
            child: const Center(
              child: Text("建立连接"),
            ),
          ),
        ),
        Get.getHeightBox(10.dp),
        GestureDetector(
          onTap: ()=>controller.clientConnect('ws://192.168.4.72:8090/ws'),
          child: Container(
            height: 48.dp,
            width: 100.dp,
            color: Colors.cyanAccent,
            child: const Center(
              child: Text("发送消息"),
            ),
          ),
        ),
        Get.getHeightBox(10.dp),
        Obx(()=>Text("服务端收到消息:${controller.serviceReceivedMsg.value}")),
        Get.getHeightBox(10.dp),
        Obx(()=>Text("客户端收到消息:${controller.clientReceivedMsg.value}")),
      ],
    );
  }
}
