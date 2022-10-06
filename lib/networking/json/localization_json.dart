import 'dart:convert';

import 'package:afariat/networking/json/abstract_json_resource.dart';

/// Used to model an autocomplete json list result for localizations
/// Used for: Cities, Towns and regions
class LocalizationListJson extends AbstractJsonResource {
  List<LocalizationJson> data = [];

  LocalizationListJson({this.data});

  LocalizationListJson.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      data = <LocalizationJson>[];
      json['results'].forEach((v) {
        LocalizationJson element = LocalizationJson.fromJson(v);
        data.add(element);
      });
    }
  }

  add(LocalizationJson element) {
    data ??= [];
    if (!exists(element)) {
      data.add(element);
    }
  }

  remove(LocalizationJson element) {
    if (!exists(element)) {
      return;
    }
    data.remove(element);
  }

  removeAt(int index) {
    if (data == null) {
      return;
    }
    if (isEmpty()) {
      return;
    }
    if (!containsKey(index)) {
      return;
    }
    data.removeAt(index);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['results'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool isEmpty() {
    if (data == null) {
      return true;
    }
    return data.isEmpty;
  }

  bool isNotEmpty() => !isEmpty();

  int count() => isEmpty() ? 0 : data.length;

  void clear() => data?.clear();

  bool containsKey(int index) => data.asMap().containsKey(index);

  List<LocalizationJson> toList() => data;

  bool exists(LocalizationJson json) {
    if (isEmpty()) {
      return false;
    }
    for (LocalizationJson element in data) {
      if (element.isEqual(json)) {
        return true;
      }
    }
    return false;
  }

  String toFilter() {
    if(isEmpty()){
      return null ;
    }
    List<int> regions = [];
    List<int> cities = [];
    List<int> towns = [];
    for (LocalizationJson element in data) {
      switch (element.type) {
        case 'region':
          regions.add(element.id);
          break;
        case 'city':
          cities.add(element.id);
          break;
        case 'town':
          towns.add(element.id);
          break;
        default:
          break;
      }
    }
    return json.encode({'regions': regions, 'cities': cities, 'towns': towns});
  }
}

/// Used to model a single Localization json object for autocomplete. E.g: City, Region, Town
class LocalizationJson extends AbstractJsonResource {
  int id;
  String name;
  String typeLabel;
  String type;

  LocalizationJson({this.id, this.name, this.typeLabel, this.type});

  LocalizationJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeLabel = json['typeLabel'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['typeLabel'] = typeLabel;
    data['type'] = type;
    return data;
  }

  @override
  String toString() {
    return name ?? '';
  }

  bool isEqual(LocalizationJson refJson) {
    return id == refJson.id && type == refJson.type;
  }
}
