import 'dart:convert';

class DeviceInfoModel {
  String identifier;
  String name;
  String os;
  String platform;
  String model;
  String firebaseToken;

  DeviceInfoModel(
      {this.identifier,
      this.name,
      this.os,
      this.platform,
      this.model,
      this.firebaseToken});

  DeviceInfoModel.name(this.identifier, this.name, this.os, this.platform,
      this.model, this.firebaseToken);

  Map<String, dynamic> toMap() => {
        'identifier': identifier,
        'name': name,
        'os': os,
        'platform': platform,
        'model': model,
        'firebaseToken': firebaseToken
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return toMap().toString();
  }
}
