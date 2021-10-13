/// status : 1
/// cert_fresh : [{"case_type":"WP","cr_no":"300005","cr_year":"2021","caseno":"13943","caseyear":"2020","date_order":"21/12/2020","appli_name":"Puthige R Ramesh","date_fil":"02/01/2021","auto_decree":"A","no_of_pages_auto":"3","no_of_pages_decree":"","no_of_copies":"1","court_fee":"15","disp_yn":"Ready","judmnt_released_yn":"Y","scanned_yn":"Y","ready_date":"05/01/2021","date_scan":"30/12/2020","date_printed":"04/01/2021","payment_due":"0","addi_court_fee":"","date_addi_court_fee":"","date_delivery":"05/01/2021","delivery_mode":"By Email"}]

class CrnoModel {
  CrnoModel({
      this.status, 
      this.certFresh,});

  CrnoModel.fromJson(dynamic json) {
    status = json['status'];

    if(json['cert_fresh'] == null || json['cert_fresh'] == ""){
      print("no cert_fresh");
    }
    else {
      certFresh = [];
      json['cert_fresh'].forEach((v) {
        certFresh.add(Cert_fresh.fromJson(v));
      });
    }
  }
  int status;
  List<Cert_fresh> certFresh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (certFresh != null) {
      map['cert_fresh'] = certFresh.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// case_type : "WP"
/// cr_no : "300005"
/// cr_year : "2021"
/// caseno : "13943"
/// caseyear : "2020"
/// date_order : "21/12/2020"
/// appli_name : "Puthige R Ramesh"
/// date_fil : "02/01/2021"
/// auto_decree : "A"
/// no_of_pages_auto : "3"
/// no_of_pages_decree : ""
/// no_of_copies : "1"
/// court_fee : "15"
/// disp_yn : "Ready"
/// judmnt_released_yn : "Y"
/// scanned_yn : "Y"
/// ready_date : "05/01/2021"
/// date_scan : "30/12/2020"
/// date_printed : "04/01/2021"
/// payment_due : "0"
/// addi_court_fee : ""
/// date_addi_court_fee : ""
/// date_delivery : "05/01/2021"
/// delivery_mode : "By Email"

class Cert_fresh {
  Cert_fresh({
      this.caseType, 
      this.crNo, 
      this.crYear, 
      this.caseno, 
      this.caseyear, 
      this.dateOrder, 
      this.appliName, 
      this.dateFil, 
      this.autoDecree, 
      this.noOfPagesAuto, 
      this.noOfPagesDecree, 
      this.noOfCopies, 
      this.courtFee, 
      this.dispYn, 
      this.judmntReleasedYn, 
      this.scannedYn, 
      this.readyDate, 
      this.dateScan, 
      this.datePrinted, 
      this.paymentDue, 
      this.addiCourtFee, 
      this.dateAddiCourtFee, 
      this.dateDelivery, 
      this.deliveryMode,});

  Cert_fresh.fromJson(dynamic json) {
    caseType = json['case_type'];
    crNo = json['cr_no'];
    crYear = json['cr_year'];
    caseno = json['caseno'];
    caseyear = json['caseyear'];
    dateOrder = json['date_order'];
    appliName = json['appli_name'];
    dateFil = json['date_fil'];
    autoDecree = json['auto_decree'];
    noOfPagesAuto = json['no_of_pages_auto'];
    noOfPagesDecree = json['no_of_pages_decree'];
    noOfCopies = json['no_of_copies'];
    courtFee = json['court_fee'];
    dispYn = json['disp_yn'];
    judmntReleasedYn = json['judmnt_released_yn'];
    scannedYn = json['scanned_yn'];
    readyDate = json['ready_date'];
    dateScan = json['date_scan'];
    datePrinted = json['date_printed'];
    paymentDue = json['payment_due'];
    addiCourtFee = json['addi_court_fee'];
    dateAddiCourtFee = json['date_addi_court_fee'];
    dateDelivery = json['date_delivery'];
    deliveryMode = json['delivery_mode'];
  }
  String caseType;
  String crNo;
  String crYear;
  String caseno;
  String caseyear;
  String dateOrder;
  String appliName;
  String dateFil;
  String autoDecree;
  String noOfPagesAuto;
  String noOfPagesDecree;
  String noOfCopies;
  String courtFee;
  String dispYn;
  String judmntReleasedYn;
  String scannedYn;
  String readyDate;
  String dateScan;
  String datePrinted;
  String paymentDue;
  String addiCourtFee;
  String dateAddiCourtFee;
  String dateDelivery;
  String deliveryMode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['case_type'] = caseType;
    map['cr_no'] = crNo;
    map['cr_year'] = crYear;
    map['caseno'] = caseno;
    map['caseyear'] = caseyear;
    map['date_order'] = dateOrder;
    map['appli_name'] = appliName;
    map['date_fil'] = dateFil;
    map['auto_decree'] = autoDecree;
    map['no_of_pages_auto'] = noOfPagesAuto;
    map['no_of_pages_decree'] = noOfPagesDecree;
    map['no_of_copies'] = noOfCopies;
    map['court_fee'] = courtFee;
    map['disp_yn'] = dispYn;
    map['judmnt_released_yn'] = judmntReleasedYn;
    map['scanned_yn'] = scannedYn;
    map['ready_date'] = readyDate;
    map['date_scan'] = dateScan;
    map['date_printed'] = datePrinted;
    map['payment_due'] = paymentDue;
    map['addi_court_fee'] = addiCourtFee;
    map['date_addi_court_fee'] = dateAddiCourtFee;
    map['date_delivery'] = dateDelivery;
    map['delivery_mode'] = deliveryMode;
    return map;
  }

}