/// 第三方
import 'dart:io';

import 'package:get/get.dart';
import 'package:member_management/core/base_controller.dart';

class SocketController extends BaseController {

  /// 服务端变量
  HttpServer? server;
  WebSocket? serviceSocket;
  var serviceReceivedMsg = '暂无消息'.obs;

  /// 服务端操作
  void serviceBinding(String ip, int port) async {
    if(server != null) return;
    server = await HttpServer.bind(ip, port);
    print('-------------服务器绑定成功-------------');

    server?.listen((HttpRequest req) async {
      await WebSocketTransformer.upgrade(req).then((webSocket) {
        webSocket.listen(handleMsg);
        serviceSocket = webSocket;
      });
    });
  }

  void handleMsg(dynamic msg){
    print('收到客户端消息:$msg');
    serviceReceivedMsg.value = msg;
  }

  void serviceSendMsg(String msg) {
    if(msg.isEmpty || serviceSocket == null){
      return;
    }
    serviceSocket?.add(msg);
  }

  void servicesSendMsgBytes(List<int> bytes) {
    if(bytes.isEmpty || serviceSocket == null){
      return;
    }
    serviceSocket?.addUtf8Text(bytes);
  }

  void serverSendVideoFrameSteam(var dataBytes) {
    if(dataBytes == null || serviceSocket == null) {
      return;
    }
    var msg = Stream.value(dataBytes);

    serviceSocket?.addStream(msg).then((value) => null);
  }

  /// 客户端变量
  WebSocket? clientSocket;
  var clientReceivedMsg = '暂无消息'.obs;

  /// 客户端操作
  void clientConnect(String ip) async {
    clientSocket = await WebSocket.connect(ip);
    print('-------------客户端连接成功-------------');
    clientSocket?.listen(clientReceived);
    clientSocket?.add(DateTime.now().toString());
  }
  void clientReceived(msg) {
    print('收到服务端消息:$msg');
    clientReceivedMsg.value = msg;
  }

  @override
  void onClose() {
    serviceSocket?.close();
    clientSocket?.close();
    server?.close();
    super.onClose();
  }
}
