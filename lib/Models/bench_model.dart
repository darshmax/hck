/// bench : "Bengaluru"
/// id : "B"

class BenchModel {
  String bench;
  String id;

  BenchModel({
      this.bench, 
      this.id});

  BenchModel.fromJson(dynamic json) {
    bench = json['bench'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['bench'] = bench;
    map['id'] = id;
    return map;
  }

}