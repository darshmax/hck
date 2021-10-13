/// status : 1
/// copy3 : [{"caseno":"1","caseyear":"2019","cr_no":"300001","cr_year":"2020","case_type":"WP","appli_name":"Rohit","disp_type":"Pending","court_fee":"15","date_disp":"","date_delivery":"","no_of_copies":"","addi_court_fee":"0","total_fee_required":"","date_fil":"17/07/2020","payment_due":"15","date_addi_court_fee":"30/09/2020"}]
/// cert_interim : [{"type_of_request":"ENTIRE ORDER SHEET-01/01/2020","date_requested":"21/07/2020","date_request_fulfill":"29/09/2020","cancelled_by_advocate":"","remarks":"","no_of_copies":"1"},{"type_of_request":"INTERIM ORDER DATED-01/01/2020","date_requested":"17/07/2020","date_request_fulfill":"29/09/2020","cancelled_by_advocate":"","remarks":"","no_of_copies":"1"}]

class CcaThreeCrno {
  CcaThreeCrno({
      this.status, 
      this.copy3, 
      this.certInterim,});

  CcaThreeCrno.fromJson(dynamic json) {
    status = json['status'];
    if(json['copy3'] == null || json['copy3'] == ""){
      print("no copy3");
    }
    else {
      copy3 = [];
      json['copy3'].forEach((v) {
        copy3.add(Copy3.fromJson(v));
      });
    }
    if (json['cert_interim'] != null) {
      certInterim = [];
      json['cert_interim'].forEach((v) {
        certInterim.add(Cert_interim.fromJson(v));
      });
    }
  }
  int status;
  List<Copy3> copy3;
  List<Cert_interim> certInterim;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (copy3 != null) {
      map['copy3'] = copy3.map((v) => v.toJson()).toList();
    }
    if (certInterim != null) {
      map['cert_interim'] = certInterim.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type_of_request : "ENTIRE ORDER SHEET-01/01/2020"
/// date_requested : "21/07/2020"
/// date_request_fulfill : "29/09/2020"
/// cancelled_by_advocate : ""
/// remarks : ""
/// no_of_copies : "1"

class Cert_interim {
  Cert_interim({
      this.typeOfRequest, 
      this.dateRequested, 
      this.dateRequestFulfill, 
      this.cancelledByAdvocate, 
      this.remarks, 
      this.noOfCopies,});

  Cert_interim.fromJson(dynamic json) {
    typeOfRequest = json['type_of_request'];
    dateRequested = json['date_requested'];
    dateRequestFulfill = json['date_request_fulfill'];
    cancelledByAdvocate = json['cancelled_by_advocate'];
    remarks = json['remarks'];
    noOfCopies = json['no_of_copies'];
  }
  String typeOfRequest;
  String dateRequested;
  String dateRequestFulfill;
  String cancelledByAdvocate;
  String remarks;
  String noOfCopies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_of_request'] = typeOfRequest;
    map['date_requested'] = dateRequested;
    map['date_request_fulfill'] = dateRequestFulfill;
    map['cancelled_by_advocate'] = cancelledByAdvocate;
    map['remarks'] = remarks;
    map['no_of_copies'] = noOfCopies;
    return map;
  }

}

/// caseno : "1"
/// caseyear : "2019"
/// cr_no : "300001"
/// cr_year : "2020"
/// case_type : "WP"
/// appli_name : "Rohit"
/// disp_type : "Pending"
/// court_fee : "15"
/// date_disp : ""
/// date_delivery : ""
/// no_of_copies : ""
/// addi_court_fee : "0"
/// total_fee_required : ""
/// date_fil : "17/07/2020"
/// payment_due : "15"
/// date_addi_court_fee : "30/09/2020"

class Copy3 {
  Copy3({
      this.caseno, 
      this.caseyear, 
      this.crNo, 
      this.crYear, 
      this.caseType, 
      this.appliName, 
      this.dispType, 
      this.courtFee, 
      this.dateDisp, 
      this.dateDelivery, 
      this.noOfCopies, 
      this.addiCourtFee, 
      this.totalFeeRequired, 
      this.dateFil, 
      this.paymentDue, 
      this.dateAddiCourtFee,});

  Copy3.fromJson(dynamic json) {
    caseno = json['caseno'];
    caseyear = json['caseyear'];
    crNo = json['cr_no'];
    crYear = json['cr_year'];
    caseType = json['case_type'];
    appliName = json['appli_name'];
    dispType = json['disp_type'];
    courtFee = json['court_fee'];
    dateDisp = json['date_disp'];
    dateDelivery = json['date_delivery'];
    noOfCopies = json['no_of_copies'];
    addiCourtFee = json['addi_court_fee'];
    totalFeeRequired = json['total_fee_required'];
    dateFil = json['date_fil'];
    paymentDue = json['payment_due'];
    dateAddiCourtFee = json['date_addi_court_fee'];
  }
  String caseno;
  String caseyear;
  String crNo;
  String crYear;
  String caseType;
  String appliName;
  String dispType;
  String courtFee;
  String dateDisp;
  String dateDelivery;
  String noOfCopies;
  String addiCourtFee;
  String totalFeeRequired;
  String dateFil;
  String paymentDue;
  String dateAddiCourtFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['caseno'] = caseno;
    map['caseyear'] = caseyear;
    map['cr_no'] = crNo;
    map['cr_year'] = crYear;
    map['case_type'] = caseType;
    map['appli_name'] = appliName;
    map['disp_type'] = dispType;
    map['court_fee'] = courtFee;
    map['date_disp'] = dateDisp;
    map['date_delivery'] = dateDelivery;
    map['no_of_copies'] = noOfCopies;
    map['addi_court_fee'] = addiCourtFee;
    map['total_fee_required'] = totalFeeRequired;
    map['date_fil'] = dateFil;
    map['payment_due'] = paymentDue;
    map['date_addi_court_fee'] = dateAddiCourtFee;
    return map;
  }

}