/// id : 1
/// name : "Court Hall No. 1"

class CourtHallModel {
  CourtHallModel({
      this.id, 
      this.name,});

  CourtHallModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int id;
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}