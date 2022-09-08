import 'package:afariat/networking/json/abstract_json_resource.dart';

/// Used to model a json list result with referential apis with attributes {id, name}
/// Used for: Cities, Towns, prices,...
class RefListJson extends AbstractJsonResource {
  List<RefJson> data;

  RefListJson({this.data});

  RefListJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RefJson>[];
      json['data'].forEach((v) {
        data.add(new RefJson.fromJson(v));
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

  bool isEmpty() {
    if (data == null) {
      return true;
    }
    return data.isEmpty;
  }

  bool isNotEmpty() {
    if (data != null) {
      return data.isNotEmpty;
    }
    return false;
  }
}

/// Used to model a signle refrential json object. E.g: City, Region, Price,...
class RefJson extends AbstractJsonResource {
  int id;
  String name;

  RefJson({this.id, this.name});

  RefJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return name ?? '';
  }

  bool isEqual(RefJson refJson) {
    return this.id == refJson.id;
  }
}
