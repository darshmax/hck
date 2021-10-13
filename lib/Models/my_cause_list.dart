/// details : [{"loc":"B","sr_no":"1","causelist_date":"29/09/2021","case_no":"COMAP 123/2021","list_no":"1","sit_code":"1567","bench_id":"3","judge_name":"THE HON`BLE JUSTICE ARAVIND KUMAR AND THE HON`BLE JUSTICE PRADEEP SINGH YERUR"},{"loc":"B","sr_no":"1","causelist_date":"29/09/2021","case_no":"RFA 1712/2013","list_no":"1","sit_code":"720","bench_id":"3","judge_name":"THE HON`BLE JUSTICE ARAVIND KUMAR"},{"loc":"D","sr_no":"28","causelist_date":"29/09/2021","case_no":"WP 103252/2021","list_no":"2","sit_code":"2334","bench_id":"3","judge_name":"THE HON`BLE JUSTICE S.R. KRISHNA KUMAR"},{"loc":"D","sr_no":"1","causelist_date":"29/09/2021","case_no":"WP 106403/2017","list_no":"1","sit_code":"2334","bench_id":"3","judge_name":"THE HON`BLE JUSTICE S.R. KRISHNA KUMAR"}]
/// status : 1
/// err_msg : ""

class MyCauseList {
  MyCauseList({
      List<Details> details, 
      int status, 
      String errMsg,}){
    _details = details;
    _status = status;
    _errMsg = errMsg;
}

  MyCauseList.fromJson(dynamic json) {
    if(json['details'] == null || json['details'] == ""){
      print("No Cause List");
    }
    else {
      _details = [];
      json['details'].forEach((v) {
        _details.add(Details.fromJson(v));
      });
    }
    _status = json['status'];
    _errMsg = json['err_msg'];
  }
  List<Details> _details;
  int _status;
  String _errMsg;

  List<Details> get details => _details;
  int get status => _status;
  String get errMsg => _errMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_details != null) {
      map['details'] = _details.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['err_msg'] = _errMsg;
    return map;
  }

}

/// loc : "B"
/// sr_no : "1"
/// causelist_date : "29/09/2021"
/// case_no : "COMAP 123/2021"
/// list_no : "1"
/// sit_code : "1567"
/// bench_id : "3"
/// judge_name : "THE HON`BLE JUSTICE ARAVIND KUMAR AND THE HON`BLE JUSTICE PRADEEP SINGH YERUR"

class Details {
  Details({
      String loc, 
      String srNo, 
      String causelistDate, 
      String caseNo, 
      String listNo, 
      String sitCode, 
      String benchId, 
      String judgeName,}){
    _loc = loc;
    _srNo = srNo;
    _causelistDate = causelistDate;
    _caseNo = caseNo;
    _listNo = listNo;
    _sitCode = sitCode;
    _benchId = benchId;
    _judgeName = judgeName;
}

  Details.fromJson(dynamic json) {
    _loc = json['loc'];
    _srNo = json['sr_no'];
    _causelistDate = json['causelist_date'];
    _caseNo = json['case_no'];
    _listNo = json['list_no'];
    _sitCode = json['sit_code'];
    _benchId = json['bench_id'];
    _judgeName = json['judge_name'];
  }
  String _loc;
  String _srNo;
  String _causelistDate;
  String _caseNo;
  String _listNo;
  String _sitCode;
  String _benchId;
  String _judgeName;

  String get loc => _loc;
  String get srNo => _srNo;
  String get causelistDate => _causelistDate;
  String get caseNo => _caseNo;
  String get listNo => _listNo;
  String get sitCode => _sitCode;
  String get benchId => _benchId;
  String get judgeName => _judgeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['loc'] = _loc;
    map['sr_no'] = _srNo;
    map['causelist_date'] = _causelistDate;
    map['case_no'] = _caseNo;
    map['list_no'] = _listNo;
    map['sit_code'] = _sitCode;
    map['bench_id'] = _benchId;
    map['judge_name'] = _judgeName;
    return map;
  }

}