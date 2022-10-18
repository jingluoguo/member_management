// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:member_management/data/model/member.dart';
import 'package:sqflite/sqflite.dart';

const _version = 1;//数据库版本号
const _databaseName = "member.db";//数据库名称
const _tableMember = "member_info";//表名称
const _memberId = "id";//主键
const _memberCard = "card";
const _memberName = "name";
const _memberCount = "count";
const _memberPhone = "phone";
const _memberAddress = "address";
const _memberNote = "note";

const _tableRecord = "member_record";
const _recordId = "id";
const _recordMemberId = "member_id";
const _recordCount = "record_count";
const _recordNote = "record_note";
const _recordCreateTime = "record_time";

class ATQueueData{

  ATQueueData.internal();

  //数据库句柄
  late Database _database;
  Future<Database> get database async {
    String path = await getDatabasesPath() + "/$_databaseName";
    _database = await openDatabase(path, version: _version,
      onCreate: (Database db, int version) async {
        _createTable(db, '''create table if not exists $_tableMember 
        ($_memberId integer primary key,
        $_memberCard text,$_memberName text,$_memberCount INTEGER,
        $_memberPhone text, $_memberAddress text, $_memberNote text)''');

        _createTable(db, '''create table if not exists $_tableRecord 
        ($_recordId integer primary key,
        $_recordMemberId INTEGER,$_recordCount INTEGER,$_recordNote text,
         $_recordCreateTime text)''');
      }
    );
    return _database;
  }

  /// 创建表
  void _createTable(Database db, String sql) async{
    var batch = db.batch();
    print(sql);
    batch.execute(sql);
    await batch.commit();
  }

  /// 添加记录
  static Future insertData(Member member) async{
    Database db = await ATQueueData.internal().open();
    db.transaction((txn) async{
      await txn.rawInsert('''insert or replace into $_tableMember (
        $_memberId,$_memberCard,$_memberName,$_memberCount,$_memberPhone,
        $_memberAddress,$_memberNote)
        values (null,?,?,?,?,?,?)''',
          [member.card, member.name, member.count, member.phone, member.address, member.note]);
    });
    await db.batch().commit();
    await ATQueueData.internal().close();
  }

  // 查询所有记录
  static Future<List<Member>> searchDates() async {
    Database db = await ATQueueData.internal().open();
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from $_tableMember");
    await ATQueueData.internal().close();
    List<Member> responseData = [];
    for (var item in maps) {
      var data = Member.fromJson(item);
      responseData.add(data);
    }
    return responseData;
  }

  // 查询该用户所有积分变更记录
  static Future<List<MemberRecord>> searchRecordDates(int id) async {
    Database db = await ATQueueData.internal().open();
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from $_tableRecord where $_recordMemberId = $id");
    await ATQueueData.internal().close();
    List<MemberRecord> responseData = [];
    for (var item in maps) {
      var data = MemberRecord.fromJson(item);
      responseData.add(data);
    }
    return responseData;
  }

  // 修改记录
  static Future updateDate(Member member, int changeCount, {String note = ""}) async {
    Database db = await ATQueueData.internal().open();
    db.transaction((txn) async{
      await txn.rawUpdate(
          '''update $_tableMember set $_memberCount = ? where id = ?''',
          [member.count, member.id]);
      await txn.rawInsert('''insert or replace into $_tableRecord (
        $_recordId,$_recordMemberId,$_recordCount,$_recordNote,$_recordCreateTime)
        values (null,?,?,?,?)''',
          [member.id, changeCount, note, formatDate(
              DateTime.now(),
              [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]
          )]);
    });
    await db.batch().commit();
    await ATQueueData.internal().close();
  }

  // 删除记录
  static Future<void> deleteData(int id) async{
    Database db = await ATQueueData.internal().open();
    db.transaction((txn) async{
      txn.rawDelete("delete from $_tableMember where $_memberId = ?",[id]);
      txn.rawDelete("delete from $_tableRecord where $_recordMemberId = ?",[id]);
    });
    await db.batch().commit();

    await ATQueueData.internal().close();
  }

  //打开
  Future<Database> open() async{
    return await database;
  }

  ///关闭
  Future<void> close() async {
    var db = await database;
    return db.close();
  }

  ///删除数据库文件
  static Future<void> deleteDataBaseFile() async {
    String path = await getDatabasesPath() + "/$_databaseName";
    File file = File(path);
    if(await file.exists()){
      file.delete();
    }
  }
}