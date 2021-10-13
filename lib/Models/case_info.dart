/// case_details : [{"case_type":"CMP","sub_type":"","sub_sub_type":"","case_no":"34","case_year":"2021","cino":"KAHC010359782020","petitioner":"DBL MUNDARGI HARAPANAHALLI TOLLWAYS LTD","respondent":"KARNATAKA ROAD DEVELOPMENT CORPORATION LIMITED","court_no":"1567","judge":"ARAVIND KUMAR AND PRADEEP SINGH YERUR","petitioner_advocate":"KADIRA RAMI REDDY","respondent_advocate":"","status":"pending","filing_date":"21/11/2020 13:17:09","decision_date":"","date_next_list":"27/01/2021","tentative_date":"","purpose_next":"1","purpose_name":"ADMISSION","causelist_type":"Daily cause List/1","short_order":"0","order_name":"Null Action","date_action":"27/01/2021","defective":"Y","disp_nature":"0","disposal_type":"","fil_type":"AC","fil_no":"2","fil_year":"2020"}]
/// status : 1
/// msg : ""

class CaseInfo {
  CaseInfo({
      this.caseDetails, 
      this.status, 
      this.msg,});

  CaseInfo.fromJson(dynamic json) {
    if(json['case_details'] == null || json['case_details']==""){
        print("No Data in Case details");

      }

      else{
        caseDetails = [];
        json['case_details'].forEach((v) {
          caseDetails.add(Case_details.fromJson(v));
        });
    }
    // if (json['case_details'] != null) {
    //
    //   caseDetails = [];
    //   json['case_details'].forEach((v) {
    //     caseDetails.add(Case_details.fromJson(v));
    //   });
    // }


    status = json['status'];
    msg = json['msg'];
  }
  List<Case_details> caseDetails;
  int status;
  String msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (caseDetails != null) {
      map['case_details'] = caseDetails.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }

}

/// case_type : "CMP"
/// sub_type : ""
/// sub_sub_type : ""
/// case_no : "34"
/// case_year : "2021"
/// cino : "KAHC010359782020"
/// petitioner : "DBL MUNDARGI HARAPANAHALLI TOLLWAYS LTD"
/// respondent : "KARNATAKA ROAD DEVELOPMENT CORPORATION LIMITED"
/// court_no : "1567"
/// judge : "ARAVIND KUMAR AND PRADEEP SINGH YERUR"
/// petitioner_advocate : "KADIRA RAMI REDDY"
/// respondent_advocate : ""
/// status : "pending"
/// filing_date : "21/11/2020 13:17:09"
/// decision_date : ""
/// date_next_list : "27/01/2021"
/// tentative_date : ""
/// purpose_next : "1"
/// purpose_name : "ADMISSION"
/// causelist_type : "Daily cause List/1"
/// short_order : "0"
/// order_name : "Null Action"
/// date_action : "27/01/2021"
/// defective : "Y"
/// disp_nature : "0"
/// disposal_type : ""
/// fil_type : "AC"
/// fil_no : "2"
/// fil_year : "2020"

class Case_details {
  Case_details({
      this.caseType, 
      this.subType, 
      this.subSubType, 
      this.caseNo, 
      this.caseYear, 
      this.cino, 
      this.petitioner, 
      this.respondent, 
      this.courtNo, 
      this.judge, 
      this.petitionerAdvocate, 
      this.respondentAdvocate, 
      this.status, 
      this.filingDate, 
      this.decisionDate, 
      this.dateNextList, 
      this.tentativeDate, 
      this.purposeNext, 
      this.purposeName, 
      this.causelistType, 
      this.shortOrder, 
      this.orderName, 
      this.dateAction, 
      this.defective, 
      this.dispNature, 
      this.disposalType, 
      this.filType, 
      this.filNo, 
      this.filYear,});

  Case_details.fromJson(dynamic json) {
    caseType = json['case_type'];
    subType = json['sub_type'];
    subSubType = json['sub_sub_type'];
    caseNo = json['case_no'];
    caseYear = json['case_year'];
    cino = json['cino'];
    petitioner = json['petitioner'];
    respondent = json['respondent'];
    courtNo = json['court_no'];
    judge = json['judge'];
    petitionerAdvocate = json['petitioner_advocate'];
    respondentAdvocate = json['respondent_advocate'];
    status = json['status'];
    filingDate = json['filing_date'];
    decisionDate = json['decision_date'];
    dateNextList = json['date_next_list'];
    tentativeDate = json['tentative_date'];
    purposeNext = json['purpose_next'];
    purposeName = json['purpose_name'];
    causelistType = json['causelist_type'];
    shortOrder = json['short_order'];
    orderName = json['order_name'];
    dateAction = json['date_action'];
    defective = json['defective'];
    dispNature = json['disp_nature'];
    disposalType = json['disposal_type'];
    filType = json['fil_type'];
    filNo = json['fil_no'];
    filYear = json['fil_year'];
  }
  String caseType;
  String subType;
  String subSubType;
  String caseNo;
  String caseYear;
  String cino;
  String petitioner;
  String respondent;
  String courtNo;
  String judge;
  String petitionerAdvocate;
  String respondentAdvocate;
  String status;
  String filingDate;
  String decisionDate;
  String dateNextList;
  String tentativeDate;
  String purposeNext;
  String purposeName;
  String causelistType;
  String shortOrder;
  String orderName;
  String dateAction;
  String defective;
  String dispNature;
  String disposalType;
  String filType;
  String filNo;
  String filYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['case_type'] = caseType;
    map['sub_type'] = subType;
    map['sub_sub_type'] = subSubType;
    map['case_no'] = caseNo;
    map['case_year'] = caseYear;
    map['cino'] = cino;
    map['petitioner'] = petitioner;
    map['respondent'] = respondent;
    map['court_no'] = courtNo;
    map['judge'] = judge;
    map['petitioner_advocate'] = petitionerAdvocate;
    map['respondent_advocate'] = respondentAdvocate;
    map['status'] = status;
    map['filing_date'] = filingDate;
    map['decision_date'] = decisionDate;
    map['date_next_list'] = dateNextList;
    map['tentative_date'] = tentativeDate;
    map['purpose_next'] = purposeNext;
    map['purpose_name'] = purposeName;
    map['causelist_type'] = causelistType;
    map['short_order'] = shortOrder;
    map['order_name'] = orderName;
    map['date_action'] = dateAction;
    map['defective'] = defective;
    map['disp_nature'] = dispNature;
    map['disposal_type'] = disposalType;
    map['fil_type'] = filType;
    map['fil_no'] = filNo;
    map['fil_year'] = filYear;
    return map;
  }

}