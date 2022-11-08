import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:member_management/core/base_page.dart';
import 'package:member_management/modules/detail_module/detail_controller.dart';
import 'package:member_management/modules/main_modoule/main_controller.dart';

import '../../utils/widget/common.dart';
import '../../theme/utils/export.dart';
import 'package:member_management/data/model/member.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// todo

class DetailPage extends BasePage<DetailController> {
  const DetailPage({Key? key}) : super(key: key);


  Widget memberInfo(Member member) {
    return Container(
      width: Get.width * 0.9,
      height: 160.dp,
      padding: EdgeInsets.all(10.dp),
      decoration: BoxDecoration(
        color: Colors.white,
        // gradient:
        //     LinearGradient(colors: [Color(0xFF22FF9A), Color(0xFF24A1FF)]),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              blurRadius: 10.0.dp,
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: -5.dp),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
              child: singleTextWeight(
                  '${member.card}-${member.name}', Colors.black, 24.dp,
                  fontWeight: FontWeight.bold)),
          Positioned(
              top: 48.dp,
              child: singleTextWeight(
                  '${member.phone}', Colors.black, 16.dp)),
          Positioned(
              top: 78.dp,
              child: singleTextWeight(
                  (member.address == null ||
                      member.address!.isEmpty)
                      ? '暂无地址...'
                      : member.address,
                  Colors.grey,
                  16.dp)),
          Positioned(
              top: 110.dp,
              child: singleTextWeight(
                  (member.note == null ||
                      member.note!.isEmpty)
                      ? '暂无备注...'
                      : member.note,
                  Colors.grey,
                  16.dp)),
          Positioned(
              right: 10,
              child: ClipOval(
                child: Container(
                  width: 68.dp,
                  height: 68.dp,
                  color: Colors.greenAccent,
                  child: Center(
                    child: singleTextWeight(
                        controller.member.count.toString(),
                        Colors.black,
                        24.dp),
                  ),
                ),
              ))
        ],
      ),
    ).paddingOnly(top: 10.dp, bottom: 10.dp);
  }

  Widget memberRecordCard(MemberRecord record) {
    return Padding(
        padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
        child: Container(
          width: Get.width * 0.9,
          height: 100.dp,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 4, style: BorderStyle.none),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10.0.dp,
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: -5.dp),
              ],
              color: Colors.white),
          // color: Colors.black,
          child: Stack(
            children: [
              Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: singleTextWeight(
                        "${record.recordTime}", Colors.black, 16.dp,
                        textAlign: TextAlign.end),
                  )),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Container(
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        color: record.recordCount! >= 0
                            ? Colors.greenAccent
                            : Colors.red,
                        child: Center(
                          child: singleTextWeight(
                              "${record.recordCount}", Colors.black, 16.dp,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Get.getWidthBox(10.dp),
                    Expanded(
                        child: Text(
                      "${record.recordNote}",
                      style: TextStyle(color: Colors.black, fontSize: 16.dp),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            customerHeader(Colors.white, Translation.pointsRecord,
                leftContent: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 28.dp,
                  ),
                )),
            memberInfo(controller.member),
            Expanded(
                child: SingleChildScrollView(
                  child: Obx(() => Column(
                    children: [
                      for (var record in controller.allRecord)
                        memberRecordCard(record),
                    ],
                  )),
                ))
          ],
        ),
      ],
    );
  }
}
