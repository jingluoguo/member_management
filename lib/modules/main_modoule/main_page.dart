import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:member_management/core/base_page.dart';

import 'main_controller.dart';
import 'package:member_management/routes/app_pages.dart';
import 'package:member_management/theme/utils/export.dart';
import 'package:member_management/data/model/member.dart';
import 'package:member_management/utils/widget/common.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// 会员列表及相关操作

class MainPage extends BasePage<MainController>{
  const MainPage({Key? key}) : super(key: key);

  @override
  // TODO: implement body
  Widget get body => Stack(
    children: [
      Column(
        children: [
          // safePadding(context, Colors.white),
          customerHeader(Colors.white, Translation.memberList),
          Get.getHeightBox(10.dp),
          SizedBox(
            width: Get.width * 0.9,
            child: TextField(
              onChanged: (v){
                controller.searchMember(v);
              },
              decoration: InputDecoration.collapsed(
                  hintText: Translation.searchHintText,
                  hintStyle: TextStyle(
                      color: c_AA,
                      fontSize: 16.sp
                  )
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Obx(()=>Column(
              children: [
                for(var member in controller.resultMember)
                  memberCard(member),
              ],
            )),
          ))
        ],
      ),
      Positioned(
          bottom: 50.dp,
          right: 20.dp,
          child: FloatingActionButton(
            onPressed: () async{
              controller.temAddMember.clear();
              await _addMember(Get.context);
            },
            child: const Icon(Icons.add),
          )
      ),
    ],
  );

  Widget memberCard(Member member){
    return Padding(
      padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
      child: GestureDetector(
        onTap: ()=>Get.toNamed(Routes.detail, arguments: {"member": member}),
        onDoubleTap: ()=>_addOrReduceMemberCount(Get.context, member: member),
        onLongPress: ()=>_deleteMember(Get.context),
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),//滑出选项的面板 动画
          actionExtentRatio: 0.25,
          controller: controller.slidableController,
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
                    child: Text("${member.card}"),
                  )
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: Get.width * 0.2,
                        child: singleTextWeight("${member.name}", Colors.black, 16.dp),
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: singleTextWeight("${member.phone}", Colors.black, 16.dp, textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        width: Get.width * 0.2,
                        child: singleTextWeight("${member.count}", Colors.black, 16.dp, textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          secondaryActions: <Widget>[//右侧按钮列表
            GestureDetector(
              onTap: () async {
                controller.slidableController.activeState = null;
                _addOrReduceMemberCount(Get.context, member: member);
              },
              child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Center(
                    child: singleTextWeight(Translation.add, Colors.black, 16.dp),
                  )
              ),
            ),
            GestureDetector(
              onTap: () async {
                controller.slidableController.activeState = null;
                _addOrReduceMemberCount(Get.context, member: member, add: false);
              },
              child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Center(
                    child: singleTextWeight(Translation.exchange, Colors.black, 16.dp),
                  )
              ),
            ),
            GestureDetector(
              onTap: () async {
                controller.slidableController.activeState = null;
                bool result = await _deleteMember(Get.context)??false;
                if(result){
                  controller.deleteMember(member.id);
                }
              },
              child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xfff77f88),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Center(
                    child: singleTextWeight(Translation.delete, Colors.black, 16.dp),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 添加会员
  _addMember(context){
    return
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dp),
            ),
            children: <Widget>[
              Get.getWidthBox(MediaQuery.of(context).size.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Get.getHeightBox(20.dp),
                  singleTextWeight(Translation.addMember, c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text("${Translation.name}：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (v){
                            controller.temAddMember.name = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: Translation.nameHintText,
                              hintStyle: TextStyle(
                                  color: c_AA,
                                  fontSize: 16.sp
                              )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text("${Translation.cardNumber}：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (v){
                            controller.temAddMember.card = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: Translation.cardHintText,
                              hintStyle: TextStyle(
                                  color: c_AA,
                                  fontSize: 16.sp
                              )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text("${Translation.phone}：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.number, //设置键盘为数字
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))//设置只允许输入数字
                          ],
                          onChanged: (v){
                            controller.temAddMember.phone = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: Translation.phoneHintText,
                              hintStyle: TextStyle(
                                  color: c_AA,
                                  fontSize: 16.sp
                              )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: const Text("地址：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (v){
                            controller.temAddMember.address = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: '请输入地址',
                              hintStyle: TextStyle(
                                  color: c_AA,
                                  fontSize: 16.sp
                              )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Text("${Translation.count}：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.number, //设置键盘为数字
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))//设置只允许输入数字
                          ],
                          onChanged: (v){
                            if(v.isNotEmpty) {
                              controller.temAddMember.count = int.parse(v);
                            } else {
                              controller.temAddMember.count = 0;
                            }
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: Translation.countHintText,
                              hintStyle: TextStyle(
                                  color: c_AA,
                                  fontSize: 16.sp
                              )
                          ),
                        ))
                      ],
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: singleTextWeight(Translation.cancel, c_757676, 18.dp, fontWeight: FontWeight.normal)
                        ),
                        Container(
                          height: 60.dp,
                          color: c_FF,
                          width: 0.5.dp,
                        ),
                        GestureDetector(
                            onTap: () {
                              if(controller.temAddMember.checkComplete()){
                                controller.addMember();
                                Navigator.of(context).pop();
                              } else {
                                Get.snackbar('提示', '填写不全,已填写信息:${controller.temAddMember.toJson()}');
                              }
                            },
                            child: singleTextWeight(Translation.confirm, c_5ADBEA, 18.dp, fontWeight: FontWeight.normal)
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
      );
  }

  // 增加或兑换积分
  _addOrReduceMemberCount(context, {required Member member, bool add = true}){
    int changeValue = 0;
    String note = "";
    return
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dp),
            ),
            children: <Widget>[
              Get.getWidthBox(MediaQuery.of(context).size.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Get.getHeightBox(20.dp),
                  singleTextWeight(Translation.changePoints, c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      keyboardType: TextInputType.text, //设置键盘为数字
                      onChanged: (v){
                        note = v;
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: Translation.changePointsReason,
                          hintStyle: TextStyle(
                              color: c_AA,
                              fontSize: 16.sp
                          )
                      ),
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      keyboardType: TextInputType.number, //设置键盘为数字
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))//设置只允许输入数字
                      ],
                      onChanged: (v){
                        if(v.isEmpty) {
                          changeValue = 0;
                          return;
                        }
                        var value = int.parse(v);
                        changeValue = value.abs();
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "请输入${add ? "新增" : "兑换"}积分，默认为0",
                          hintStyle: TextStyle(
                              color: c_AA,
                              fontSize: 16.sp
                          )
                      ),
                    ),
                  ),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: singleTextWeight("取消", c_757676, 18.dp, fontWeight: FontWeight.normal)
                        ),
                        Container(
                          height: 60.dp,
                          color: c_FF,
                          width: 0.5.dp,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(add){
                              member.count = member.count + changeValue;
                            } else {
                              if(member.count - changeValue < 0){
                                toastShow("积分不足");
                                Navigator.of(context).pop();
                                return;
                              }
                              member.count = member.count - changeValue;
                            }
                            controller.updateMember(member, add? changeValue : (-changeValue), note: note);
                            Navigator.of(context).pop();
                          },
                          child: singleTextWeight("确定", c_5ADBEA, 18.dp, fontWeight: FontWeight.normal)
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
      );
  }

  Future<bool?> _deleteMember(context){
    return
      showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dp),
            ),
            children: <Widget>[
              Get.getWidthBox(MediaQuery.of(context).size.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Get.getHeightBox(20.dp),
                  singleTextWeight("删除", c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  singleTextWeight("确认要删除这张会员卡吗？", c_00, 16.dp),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: singleTextWeight("取消", c_5ADBEA, 18.dp, fontWeight: FontWeight.normal)
                        ),
                        Container(
                          height: 60.dp,
                          color: c_FF,
                          width: 0.5.dp,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: singleTextWeight("删除", c_757676, 18.dp, fontWeight: FontWeight.normal)
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        },
      );
  }
}