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

  bool checkComplete(){
    if(card!.isNotEmpty && name!.isNotEmpty && phone!.isNotEmpty) return true;
    return false;
  }

  void clear() {
    id = 0;
    card = '';
    count = 0;
    name = '';
    phone = '';
    address = '';
    note = '';
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