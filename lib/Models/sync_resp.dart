/// msg : "2 records added successfully"
/// statusCode : 1

class SyncResp {
  SyncResp({
      this.msg, 
      this.statusCode,});

  SyncResp.fromJson(dynamic json) {
    msg = json['msg'];
    statusCode = json['statusCode'];
  }
  String msg;
  int statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    map['statusCode'] = statusCode;
    return map;
  }

}