/// dailyorder_details : [{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.G.PANDIT","daily_order":"(Through V.C.)\r\n\r\n \r\nORDER\r\n\r\n\tMemo dated 05.11.2020 is filed by Sri A.M. Vijay, learned counsel, seeking leave to retire from the case on behalf of 4th respondent. \r\n\r\nSince Sri C.V. Kiran, learned counsel has filed power for respondent No.4, memo dated 05.11.2020 is accepted and Sri A.M. Vijay, learned counsel is permitted to retire from the case.","date_of_order":"15/02/2021"},{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.G.PANDIT","daily_order":"A week's time is granted to learned counsel Sri.C.V.Kiran for rectification of objections raised n vakalath. List week after next.","date_of_order":"28/01/2021"},{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.SUNIL DUTT YADAV","daily_order":"Petitioners are permitted to implead the Bengaluru Development Authority as an additional respondent. Sri. A.M. VIjay, learned counsel is directed to accept notice for BDA. List the matter on 27.03.2019.","date_of_order":"25/03/2019"},{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.SUNIL DUTT YADAV","daily_order":"List in orders list for consideration of interim prayer on 25.03.2019.","date_of_order":"19/03/2019"},{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.SUNIL DUTT YADAV","daily_order":"No representation for the petitioners.\nList these matters next week.","date_of_order":"14/02/2019"},{"title":"WP 1/2019","case_type":"WP","case_no":"1","case_year":"2019","judge_name":"S.SUNIL DUTT YADAV","daily_order":"List these matters on 08.02.2019.","date_of_order":"05/02/2019"}]
/// status : 1
/// msg : ""

class DailyOrderModel {
  DailyOrderModel({
      this.dailyorderDetails, 
      this.status, 
      this.msg,});

  DailyOrderModel.fromJson(dynamic json) {
    if(json['dailyorder_details'] == null || json['dailyorder_details'] == ""){
      print("No Daily Order Found");
    }
    else {
      dailyorderDetails = [];
      json['dailyorder_details'].forEach((v) {
        dailyorderDetails.add(Dailyorder_details.fromJson(v));
      });
    }
    status = json['status'];
    msg = json['msg'];
  }
  List<Dailyorder_details> dailyorderDetails;
  int status;
  String msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dailyorderDetails != null) {
      map['dailyorder_details'] = dailyorderDetails.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }

}

/// title : "WP 1/2019"
/// case_type : "WP"
/// case_no : "1"
/// case_year : "2019"
/// judge_name : "S.G.PANDIT"
/// daily_order : "(Through V.C.)\r\n\r\n \r\nORDER\r\n\r\n\tMemo dated 05.11.2020 is filed by Sri A.M. Vijay, learned counsel, seeking leave to retire from the case on behalf of 4th respondent. \r\n\r\nSince Sri C.V. Kiran, learned counsel has filed power for respondent No.4, memo dated 05.11.2020 is accepted and Sri A.M. Vijay, learned counsel is permitted to retire from the case."
/// date_of_order : "15/02/2021"

class Dailyorder_details {
  Dailyorder_details({
      this.title, 
      this.caseType, 
      this.caseNo, 
      this.caseYear, 
      this.judgeName, 
      this.dailyOrder, 
      this.dateOfOrder,});

  Dailyorder_details.fromJson(dynamic json) {
    title = json['title'];
    caseType = json['case_type'];
    caseNo = json['case_no'];
    caseYear = json['case_year'];
    judgeName = json['judge_name'];
    dailyOrder = json['daily_order'];
    dateOfOrder = json['date_of_order'];
  }
  String title;
  String caseType;
  String caseNo;
  String caseYear;
  String judgeName;
  String dailyOrder;
  String dateOfOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['case_type'] = caseType;
    map['case_no'] = caseNo;
    map['case_year'] = caseYear;
    map['judge_name'] = judgeName;
    map['daily_order'] = dailyOrder;
    map['date_of_order'] = dateOfOrder;
    return map;
  }

}