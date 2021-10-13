/// status : 1
/// copy_four_status : [{"cr_no":"39701","cr_year":"2019","case_type":"WP","appli_name":"SRI NAVEED AHMED ADV ","date_fil":"11/09/2019"},{"cr_no":"10987","cr_year":"2021","case_type":"WP","appli_name":"NAVEED AHAMED","date_fil":"15/03/2021"}]

class CrByCaseNo {
  CrByCaseNo({
      this.status, 
      this.copyFourStatus,});

  CrByCaseNo.fromJson(dynamic json) {
    status = json['status'];
    if(json['copy_four_status'] == null || json['copy_four_status'] == ""){
      print("no copy_four_status");
    }
    else {
      copyFourStatus = [];
      json['copy_four_status'].forEach((v) {
        copyFourStatus.add(Copy_four_status.fromJson(v));
      });
    }
  }
  int status;
  List<Copy_four_status> copyFourStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (copyFourStatus != null) {
      map['copy_four_status'] = copyFourStatus.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cr_no : "39701"
/// cr_year : "2019"
/// case_type : "WP"
/// appli_name : "SRI NAVEED AHMED ADV "
/// date_fil : "11/09/2019"

class Copy_four_status {
  Copy_four_status({
      this.crNo, 
      this.crYear, 
      this.caseType, 
      this.appliName, 
      this.dateFil,});

  Copy_four_status.fromJson(dynamic json) {
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