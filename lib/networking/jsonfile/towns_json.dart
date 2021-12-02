class TownsJson {
  List<Town> data;

  TownsJson({this.data});

  TownsJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Town>();
      json['data'].forEach((v) {
        data.add(new Town.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Town {
  int id;
  String name;

  Town({this.id, this.name});

  Town.fromJson(Map<String, dynamic> json) {
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