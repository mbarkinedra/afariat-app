class CitiesJson {
  List<Citie> data;

  CitiesJson({this.data});

  CitiesJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Citie>[];
      json['data'].forEach((v) {
        data.add(Citie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Citie {
  int id;
  String name;

  Citie({this.id, this.name});

  Citie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
