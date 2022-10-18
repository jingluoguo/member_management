class Member {
  late int id;
  String? card;
  late int count;
  String? name;
  String? phone;
  String? address;
  String? note;

  Member(
      {required this.id,
        required this.card,
        this.count = 0,
        required this.name,
        this.phone = "",
        this.address = "",
        this.note = ""});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    card = json['card'];
    count = json['count'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['card'] = card;
    data['count'] = count;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['note'] = note;
    return data;
  }

  String toInsert() {
    return '''insert or replace into member_info (
        id,card,name,count,phone,
        address,note)
        values (null,$card,$name,$count,$phone,$address,$note)''';
  }

  bool checkContainKey(String key) {
    if(key == ""){
      return true;
    }
    if(card!.contains(key)
        || (name!=null && name!.contains(key))
        || (phone != null && phone!.contains(key))){
      return true;
    }
    return false;
  }
}

class MemberRecord {
  int? id;
  int? memberId;
  int? recordCount;
  String? recordNote;
  String? recordTime;

  MemberRecord(
      {this.id,
        this.memberId,
        this.recordCount,
        this.recordNote,
        this.recordTime});

  MemberRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    recordCount = json['record_count'];
    recordNote = json['record_note'];
    recordTime = json['record_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['member_id'] = memberId;
    data['record_count'] = recordCount;
    data['record_note'] = recordNote;
    data['record_time'] = recordTime;
    return data;
  }
}