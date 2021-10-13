/// Status : {"status":1,"msg":"Succes"}

class LoginStatus {
  LoginStatus({
      this.status,});

  LoginStatus.fromJson(dynamic json) {
    status = json['Status'] != null ? Status.fromJson(json['Status']) : null;
  }
  Status status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (status != null) {
      map['Status'] = status.toJson();
    }
    return map;
  }

}

/// status : 1
/// msg : "Succes"

class Status {
  Status({
      this.status, 
      this.msg,});

  Status.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
  }
  int status;
  String msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }

}