class CustomResponse<T> {
  int Status;
  T Data;
  String Error;

  CustomResponse({this.Status, this.Data, this.Error});

  factory CustomResponse.fromJson(Map<String, dynamic> json) {
    return CustomResponse(
        Status: json['Status'],
        Error: json['Error'],
        Data: json['Data']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'Status': Status,
        'Error': Error,
        'Data': Data,
      };

}

class CustomRequest<T> {

  T Data;


  CustomRequest({this.Data});

  factory CustomRequest.fromJson(Map<String, dynamic> json) {
    return CustomRequest(


        Data: json['Data']
    );
  }

  Map<String, dynamic> toJson() =>
      {

        'Data': Data,
      };

}
