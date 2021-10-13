/// status : 1
/// copy3_status : [{"cr_no":"15508","cr_year":"2020","case_type":"WP","appli_name":"harish h v","date_fil":"30/12/2020"},{"cr_no":"20566","cr_year":"2018","case_type":"WP","appli_name":"NISHANTH A V","date_fil":"03/11/2018"},{"cr_no":"1","cr_year":"2019","case_type":"WP","appli_name":"NISHANTH A V","date_fil":"02/01/2019"}]

class CcaThreeCaseno {
  CcaThreeCaseno({
      this.status, 
      this.copy3Status,});

  CcaThreeCaseno.fromJson(dynamic json) {
    status = json['status'];
    if(json['copy3_status'] == null || json['copy3_status'] == ""){
      print("no copy3_status");
    }
    else {
      copy3Status = [];
      json['copy3_status'].forEach((v) {
        copy3Status.add(Copy3_status.fromJson(v));
      });
    }
  }
  int status;
  List<Copy3_status> copy3Status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (copy3Status != null) {
      map['copy3_status'] = copy3Status.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cr_no : "15508"
/// cr_year : "2020"
/// case_type : "WP"
/// appli_name : "harish h v"
/// date_fil : "30/12/2020"

class Copy3_status {
  Copy3_status({
      this.crNo, 
      this.crYear, 
      this.caseType, 
      this.appliName, 
      this.dateFil,});

  Copy3_status.fromJson(dynamic json) {
    crNo = json['cr_no'];
    crYear = json['cr_year'];
    caseType = json['case_type'];
    appliName = json['appli_name'];
    dateFil = json['date_fil'];
  }
  String crNo;
  String crYear;
  String caseType;
  String appliName;
  String dateFil;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cr_no'] = crNo;
    map['cr_year'] = crYear;
    map['case_type'] = caseType;
    map['appli_name'] = appliName;
    map['date_fil'] = dateFil;
    return map;
  }

}