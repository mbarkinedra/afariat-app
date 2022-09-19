import 'abstract_json_resource.dart';

class UserJson extends AbstractJsonResource {
  int id;
  String username;
  String email;
  String salt;
  String name;
  String slug;
  String phone;
  int type;
  bool autopublish;
  String updatedAt;
  String createddAt;
  City city;

  UserJson(
      {this.id,
      this.username,
      this.email,
      this.salt,
      this.name,
      this.slug,
      this.phone,
      this.type,
      this.autopublish,
      this.updatedAt,
      this.createddAt,
      this.city});

  UserJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    salt = json['salt'];
    name = json['name'];
    slug = json['slug'];
    phone = json['phone'];
    type = json['type'];
    autopublish = json['autopublish'];
    updatedAt = json['updated_at'];
    createddAt = json['created_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  /// form: if set to true, only needed fields for update will be serialized, otherwise, all fields.
  Map<String, dynamic> toJson({form = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (form != true) {
      data['id'] = this.id;
      data['username'] = this.username;
      data['email'] = this.email;
      data['slug'] = this.slug;
      data['autopublish'] = this.autopublish;
      data['updated_at'] = this.updatedAt;
      data['created_at'] = this.createddAt;
      data['salt'] = this.salt;
    }

    data['name'] = this.name;
    data['phone'] = this.phone;
    data['type'] = this.type;

    if (this.city != null) {
      if (form != true) {
        data['city'] = this.city.toJson();
      } else {
        data['city'] = this.city.id;
      }
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
