import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../../config/settings_app.dart';
import 'abstract_json_resource.dart';
import 'ref_json.dart';

class UserMinimalJson extends AbstractJsonResource {
  int id;
  String username;
  int totalAdsCount;
  String firstName;
  String lastName;
  String phone;
  int type;
  String photo;
  String createdAt;
  CityEntity city;

  UserMinimalJson({
    this.id,
    this.username,
    this.totalAdsCount,
    this.firstName,
    this.lastName,
    this.phone,
    this.type,
    this.photo,
    this.createdAt,
    this.city,
  });

  UserMinimalJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    totalAdsCount = json['totalAdsCount'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    type = json['type'];
    if (json['photo'] != null) {
      photo = json['photo_path'];
      photo = SettingsApp.baseUrl + json['photo'];
    }
    createdAt = json['created_at'];
    if (json['city'] != null) {
      city = CityEntity.fromJson(json['city']);
    }
  }

  toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['username'] = username;
    json['totalAdsCount'] = totalAdsCount;
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['phone'] = phone;
    json['type'] = type;
    json['photo'] = photo;
    json['createdAt'] = createdAt;
    if (city != null) {
      json['city'] = city.toJson();
    }
    return json;
  }

  @override
  String toString() => toJson();

  String memberSince() {
    DateTime _created = DateTime.parse(createdAt);
    DateFormat dateFormat = DateFormat.yMMMM('fr');
    return dateFormat.format(_created);
  }
}
