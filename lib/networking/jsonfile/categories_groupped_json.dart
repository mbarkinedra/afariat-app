class CategoriesGrouppedJson {
  List<Categories> data;

  CategoriesGrouppedJson({this.data});

  CategoriesGrouppedJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Categories>[];
      json['data'].forEach((v) {
        data.add(new Categories.fromJson(v));
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

class Categories {
  int id;
  String name;
  List<Subcategories> subcategories;

  Categories({this.id, this.name, this.subcategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int id;
  String name;

  Subcategories({this.id, this.name});

  Subcategories.fromJson(Map<String, dynamic> json) {
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