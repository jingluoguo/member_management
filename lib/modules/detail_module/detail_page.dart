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

  @override
  Widget get body => Stack(
    children: [
      Column(
        children: [
          customerHeader(
              Colors.white,
              Translation.pointsRecord,
              leftContent: GestureDetector(
                onTap: ()=>Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 28.dp,
                ),
              )
          ),
          Expanded(child: SingleChildScrollView(
            child: Obx(()=>Column(
              children: [
                for(var record in controller.allRecord)
                  memberRecordCard(record),
              ],
            )),
          ))
        ],
      ),
    ],
  );

  Widget memberRecordCard(MemberRecord record){
    return Padding(
      padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
      child: Container(
        width: Get.width * 0.9,
        height: 100.dp,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF22FF9A), Color(0xFF24A1FF)]),
          borderRadius: const BorderRadius.all(
              Radius.circular(10)),
          border: Border.all(width: 4, style: BorderStyle.none),
        ),
        // color: Colors.black,
        child: Stack(
          children: [
            Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: singleTextWeight("${record.recordTime}", Colors.black, 16.dp, textAlign: TextAlign.end),
                )
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width * 0.2,
                    child: singleTextWeight("${record.recordCount}", Colors.black, 16.dp,
                        textAlign: TextAlign.center
                    ),
                  ),
                  Expanded(child: Text(
                    "${record.recordNote}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.dp
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}