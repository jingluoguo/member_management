import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:member_management/core/base_controller.dart';
import 'package:member_management/data/model/member.dart';
import 'package:member_management/utils/method/sqflite.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// todo

class DetailController extends BaseController {

  SlidableController slidableController = SlidableController();

  RxList<MemberRecord> allRecord = RxList<MemberRecord>([]);

  late Member member;

  // 加载数据
  void initAllMember(int id) async {
    allRecord.clear();
    allRecord.value = await ATQueueData.searchRecordDates(id);
    allRecord.sort((a, b) {
      DateTime aT = DateTime.parse(a.recordTime!);
      DateTime bT = DateTime.parse(b.recordTime!);
      return bT.compareTo(aT);
    });
  }

  @override
  void onInit() async {
    var arguments = Get.arguments;
    member = arguments['member'];
    initAllMember(member.id);
    super.onInit();
  }
}