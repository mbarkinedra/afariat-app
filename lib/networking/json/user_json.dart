import 'abstract_json_resource.dart';

class UserJson extends AbstractJsonResource{
  String username;
  int id;
  String salt;
  String name;
  String slug;
  String phone;
  int type;
  bool autopublish;
  String updatedAt;
  City city;

  UserJson(
      {this.username,
        this.id,
        this.salt,
        this.name,
        this.slug,
        this.phone,
        this.type,
        this.autopublish,
        this.updatedAt,
        this.city});

  UserJson.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    salt = json['salt'];
    name = json['name'];
    slug = json['slug'];
    phone = json['phone'];
    type = json['type'];
    autopublish = json['autopublish'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.id;
    data['salt'] = this.salt;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['autopublish'] = this.autopublish;
    data['updated_at'] = this.updatedAt;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class City {
  int id;
  String name;
  int order;
  Links lLinks;

  City({this.id, this.name, this.order, this.lLinks});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  Region region;

  Links({this.region});

  Links.fromJson(Map<String, dynamic> json) {
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    return data;
  }
}

class Region {
  String href;

  Region({this.href});

  Region.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
