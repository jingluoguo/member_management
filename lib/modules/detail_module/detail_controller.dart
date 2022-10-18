import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:member_management/data/model/member.dart';
import 'package:member_management/utils/method/sqflite.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// todo

class DetailController extends GetxController {

  SlidableController slidableController = SlidableController();

  RxList<MemberRecord> allRecord = RxList<MemberRecord>([]);

  // 加载数据
  void initAllMember(int id) async {
    allRecord.clear();
    print('这里的值：$id');
    allRecord.value = await ATQueueData.searchRecordDates(id);
  }

  @override
  void onInit() async {
    var arguments = Get.arguments;
    int id = arguments['id'];
    initAllMember(id);
    super.onInit();
  }
}