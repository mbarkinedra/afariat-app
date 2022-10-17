import 'abstract_json_resource.dart';

class UserJson extends AbstractJsonResource {
  int id;
  String username;
  String email;
  String salt;
  String firstName;
  String lastName;
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
      this.firstName,
      this.lastName,
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
    firstName = json['firstName'];
    lastName = json['lastName'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (form != true) {
      data['id'] = id;
      data['username'] = username;
      data['email'] = email;
      data['slug'] = slug;
      data['autopublish'] = autopublish;
      data['updated_at'] = updatedAt;
      data['created_at'] = createddAt;
      data['salt'] = salt;
    }

    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['type'] = type;

    if (city != null) {
      if (form != true) {
        data['city'] = city.toJson();
      } else {
        data['city'] = city.id;
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
