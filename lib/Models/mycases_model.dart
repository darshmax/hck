class UserDetails {
  final int id;
  final String casetype, caseno, caseyear,loc,mobile;

  UserDetails({this.id, this.casetype, this.caseno, this.caseyear, this.loc, this.mobile});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['caseId'],
      casetype: json['caseType'],
      caseno: json['caseNo'],
      caseyear: json['caseYear'],
      loc: json['location'],
      mobile: json['mobile'],
    );
  }
}