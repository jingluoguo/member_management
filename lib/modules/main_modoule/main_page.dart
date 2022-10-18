import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:member_management/modules/main_modoule/main_controller.dart';
import 'package:member_management/routes/app_pages.dart';

import '../../utils/widget/common.dart';
import '../../theme/utils/export.dart';
import 'package:member_management/data/model/member.dart';

/// guoshijun created this file at 2022/10/3 22:41
///
/// todo

class MainPage extends GetWidget<MainController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customerTheme(
        false,
        SystemUiOverlayStyle.dark,
        Stack(
          children: [
            Column(
              children: [
                safePadding(context, Colors.white),
                customerHeader(context, Colors.white, "会员列表"),
                Get.getHeightBox(10.dp),
                SizedBox(
                  width: Get.width * 0.9,
                  child: TextField(
                    onChanged: (v){
                      controller.searchMember(v);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: "编号/姓名/手机号",
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
                  await _addMember(context);
                  // controller.addMember(Member(id: 1, card: "X0001", name: "jingluo", phone: "13111111111"));
                },
                child: const Icon(Icons.add),
              )
            ),
          ],
        ),
      onTap: ()=>{
        FocusScope.of(context).requestFocus(FocusNode())
      }
    );
  }

  Widget memberCard(Member member){
    return Padding(
      padding: EdgeInsets.only(top: 10.dp, bottom: 10.dp),
      child: GestureDetector(
        onTap: ()=>Get.toNamed(Routes.detail, arguments: {"id": member.id}),
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
                    child: singleTextWeight("积分", Colors.black, 16.dp),
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
                    child: singleTextWeight("兑换", Colors.black, 16.dp),
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
          String name = "";
          String card = "";
          String phone = "";
          int count = 0;
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
                  singleTextWeight("添加用户", c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: const Text("姓名：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (v){
                            name = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "请输入姓名",
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
                            child: const Text("卡号：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (v){
                            card = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "请输入卡号",
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
                            child: const Text("手机号：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.number, //设置键盘为数字
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))//设置只允许输入数字
                          ],
                          onChanged: (v){
                            phone = v;
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "请输入手机号",
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
                            child: const Text("积分：",textAlign: TextAlign.right,)
                        ),
                        Expanded(child: TextField(
                          keyboardType: TextInputType.number, //设置键盘为数字
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))//设置只允许输入数字
                          ],
                          onChanged: (v){
                            if(v.isNotEmpty) {
                              count = int.parse(v);
                            } else {
                              count = 0;
                            }
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "请输积分，默认为0",
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
                            child: singleTextWeight("取消", c_757676, 18.dp, fontWeight: FontWeight.normal)
                        ),
                        Container(
                          height: 60.dp,
                          color: c_FF,
                          width: 0.5.dp,
                        ),
                        GestureDetector(
                            onTap: () {
                              if(name.isNotEmpty && card.isNotEmpty && phone.isNotEmpty){
                                Member member = Member(id: 0, card: card, name: name, phone: phone, count: count);
                                controller.addMember(member);
                                Navigator.of(context).pop();
                              }
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

  // 增加或兑换积分
  _addOrReduceMemberCount(context, {required Member member, bool add = true}){
    return
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          int changeValue = 0;
          String note = "";
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
                  singleTextWeight("变更积分", c_00, 18.dp, fontWeight: FontWeight.bold),
                  Get.getHeightBox(10.dp),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      keyboardType: TextInputType.text, //设置键盘为数字
                      onChanged: (v){
                        note = v;
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: "请输入变更原因",
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
                        changeValue = int.parse(v).abs();
                        if(add){
                          print("新增积分:$v");
                        } else {
                          print("减少积分:$v");
                        }
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