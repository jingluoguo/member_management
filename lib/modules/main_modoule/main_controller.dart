import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:member_management/core/base_controller.dart';
import 'package:member_management/data/model/member.dart';
import 'package:member_management/utils/method/sqflite.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// todo

class MainController extends BaseController {

  SlidableController slidableController = SlidableController();

  List<Member> allMember = [];

  Member temAddMember = Member(id: 0, card: "", name: "");

  RxList<Member> resultMember = RxList<Member>([]);

  // 加载数据
  void initAllMember() async {
    allMember.clear();
    allMember = await ATQueueData.searchDates();
    resultMember.clear();
    for(Member member in allMember){
      resultMember.add(member);
    }
  }

  // 添加数据
  void addMember() async {
    await ATQueueData.insertData(temAddMember);
    initAllMember();
    temAddMember.clear();
  }

  // 删除数据
  void deleteMember(int id) async {
    await ATQueueData.deleteData(id);
    initAllMember();
  }

  // 筛选数据
  void searchMember(String key) {
    resultMember.clear();
    resultMember.value = allMember.where((member) => member.checkContainKey(key)).toList();
  }

  // 修改数据
  void updateMember(Member member, int changeCount, {String note = ""}) async {
    await ATQueueData.updateDate(member, changeCount, note: note);
    initAllMember();
  }

  @override
  void onInit() async {
    initAllMember();
    super.onInit();
  }
}