class PricesJson {
  List<Prices> data;

  PricesJson({this.data});

  PricesJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Prices>[];
      json['data'].forEach((v) {
        data.add(Prices.fromJson(v));
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

class Prices {
  int id;
  String name;

  Prices({this.id, this.name});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}