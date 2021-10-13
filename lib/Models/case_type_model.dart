/// case_types : [{"type_name":"AC","type_desc":"Arbitration Case"},{"type_name":"AP-EFA","type_desc":"Arbitration Petition(Enforcement of Foreign Arbitral Award)"},{"type_name":"AP.IM","type_desc":"Arbitration Petition-Interim Measure"},{"type_name":"CA","type_desc":"Company Application Matter"},{"type_name":"CAV_RSA","type_desc":"CAVEAT IN RSA"},{"type_name":"CAV_WP","type_desc":"Caveat Writ Petition"},{"type_name":"CCC","type_desc":"Civil Contempt Petition"},{"type_name":"CC(CIA)","type_desc":"Criminal Complaint (Commissions of Inquiry Act)"},{"type_name":"CEA","type_desc":"Central Excise Appeal"},{"type_name":"CMP","type_desc":"CIVIL MISC PETITION"},{"type_name":"COA","type_desc":"U/s 10(f) of the Companies Act"},{"type_name":"COMAP","type_desc":"Commercial Appeals"},{"type_name":"COM.APLN","type_desc":"Commercial Application"},{"type_name":"COMPA","type_desc":"Company Appeal"},{"type_name":"COP","type_desc":"Company Petition"},{"type_name":"CP","type_desc":"Civil Petition"},{"type_name":"CP.KLRA","type_desc":"CP On Karnataka Land Reforms Act"},{"type_name":"CRA","type_desc":"CROSS APPEALS"},{"type_name":"CRC","type_desc":"Civil Referred Case"},{"type_name":"CRL.A","type_desc":"Criminal Appeal"},{"type_name":"CRL.CCC","type_desc":"Criminal Contempt Petition"},{"type_name":"CRL.P","type_desc":"Criminal Petition"},{"type_name":"CRL.RC","type_desc":"Criminal Referred Case"},{"type_name":"CRL.RP","type_desc":"Criminal Revision Petition"},{"type_name":"CROB","type_desc":"Cross Objection"},{"type_name":"CRP","type_desc":"Civil Revision Petition"},{"type_name":"CSTA","type_desc":"Customs Appeal"},{"type_name":"EP","type_desc":"Election Petition"},{"type_name":"EX.FA","type_desc":"EXECUTION FIRST APPEAL"},{"type_name":"EX.SA","type_desc":"EXECUTION SECOND APPEAL"},{"type_name":"GTA","type_desc":"Gift Tax Appeal"},{"type_name":"HRRP","type_desc":"House Rent Rev. Petition"},{"type_name":"ITA","type_desc":"Income Tax Appeal"},{"type_name":"ITA.CROB","type_desc":"I.T Appeal CROSS Objection"},{"type_name":"ITRC","type_desc":"Income-tax referred case"},{"type_name":"LRRP","type_desc":"Land Reforms Revision Petition"},{"type_name":"LTRP","type_desc":"LUXURY TAX REVISION PETN."},{"type_name":"MFA","type_desc":"Miscl. First Appeal"},{"type_name":"MFA.CROB","type_desc":"MFA Cross Obj"},{"type_name":"MISC","type_desc":"MISC"},{"type_name":"MISC.CRL","type_desc":"Miscellaneous Case for Crml"},{"type_name":"MISC.CVL","type_desc":"Miscellaneous Case for Civil"},{"type_name":"MISC.P","type_desc":"Misc Petition"},{"type_name":"MISC.W","type_desc":"Miscellaneous Case for Writ"},{"type_name":"MSA","type_desc":"Miscl Second Appeal"},{"type_name":"MSA.CROB","type_desc":"MSA Cross Obj"},{"type_name":"OLR","type_desc":"Official Liquidator Report"},{"type_name":"OS","type_desc":"Original Suit"},{"type_name":"OSA","type_desc":"Original Side Appeal"},{"type_name":"OSA.CROB","type_desc":"OSA Cross Objection"},{"type_name":"PROB.CP","type_desc":"Probate Civil Petition"},{"type_name":"RA","type_desc":"Regular Appeal"},{"type_name":"RERA.A","type_desc":"RERA APPEALS"},{"type_name":"RFA","type_desc":"Regular First Appeal"},{"type_name":"RFA.CROB","type_desc":"RFA Cross Obj"},{"type_name":"RP","type_desc":"Review Petition"},{"type_name":"RPFC","type_desc":"Rev.Pet Family Court"},{"type_name":"RSA","type_desc":"Regular Second Appeal"},{"type_name":"RSA.CROB","type_desc":"RSA Cross Obj"},{"type_name":"SA","type_desc":"Second Appeal"},{"type_name":"SCLAP","type_desc":"SUPREME COURT LEAVE APPLICATION"},{"type_name":"STA","type_desc":"Sales Tax Appeal"},{"type_name":"STRP","type_desc":"Sale Tax Revision Petition"},{"type_name":"TAET","type_desc":"Tax Appeal on Entry Tax"},{"type_name":"TOS","type_desc":"Testamentory Original Suit"},{"type_name":"TRC","type_desc":"Tax referred cases"},{"type_name":"WA","type_desc":"Writ Appeal"},{"type_name":"WA.CROB","type_desc":"WA Cross Objection"},{"type_name":"WP","type_desc":"Writ Petition"},{"type_name":"WPCP","type_desc":"Civil Pet in Writ Side"},{"type_name":"WPHC","type_desc":"Habeas Corpus"},{"type_name":"WTA","type_desc":"Wealth Tax Appeal"}]
/// count : 72
/// status : 1

class CaseTypeModel {
  CaseTypeModel({
      this.caseTypes, 
      this.count,
      this.msg,
      this.status,});

  CaseTypeModel.fromJson(dynamic json) {
    if(json['case_types'] == null || json['case_types'] == ""){
      print("No Case Type");
    }
    if (json['case_types'] != null) {
      caseTypes = [];
      json['case_types'].forEach((v) {
        caseTypes.add(Case_types.fromJson(v));
      });
    }
    count = json['count'];
    status = json['status'];
    msg = json['mag'];
  }

  List<Case_types> caseTypes;
  int count;
  int status;
  String msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (caseTypes != null) {
      map['case_types'] = caseTypes.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    map['msg'] = msg;
    map['status'] = status;
    return map;
  }

}

/// type_name : "AC"
/// type_desc : "Arbitration Case"

class Case_types {
  Case_types({
      this.typeName, 
      this.typeDesc,});

  Case_types.fromJson(dynamic json) {
    typeName = json['type_name'];
    typeDesc = json['type_desc'];
  }
  String typeName;
  String typeDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_name'] = typeName;
    map['type_desc'] = typeDesc;
    return map;
  }

}