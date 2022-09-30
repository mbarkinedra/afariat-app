import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'link.dart';

/// Used to model a json list result with referential apis with attributes {id, name}
/// Used for: Cities, Towns, prices,...
class RefListJson extends AbstractJsonResource {
  List<RefJson> data;

  RefListJson({this.data});

  RefListJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RefJson>[];
      json['data'].forEach((v) {
        data.add(RefJson.fromJson(v));
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

  RefJson first() => isNotEmpty() ? data.first : null;

  RefJson last() => isNotEmpty() ? data.last : null;

  int length() => isNotEmpty() ? data.length : 0;
}

/// Used to model a single referential json object. E.g: City, Region, Price,...
class RefJson extends AbstractJsonResource {
  int id;
  String name;

  RefJson({this.id, this.name});

  RefJson.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return name ?? '';
  }

  bool isEqual(RefJson refJson) {
    return id == refJson.id;
  }

  setFromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

//Define the list of entities model that inherit from Ref
class JsonEntity extends RefJson {
  Links links;

  JsonEntity({int id, String name, this.links}) : super(id: id, name: name);

  JsonEntity.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }

  @override
  setFromJson(Map<String, dynamic> json) {
    super.setFromJson(json);
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }
}

class AdvertTypeEntity extends JsonEntity {
  AdvertTypeEntity.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }
}

class CategoryGroupEntity extends JsonEntity {
  CategoryGroupEntity.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }
}

class CategoryEntity extends JsonEntity {
  CategoryGroupEntity group;

  CategoryEntity.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }

  @override
  setFromJson(Map<String, dynamic> json) {
    super.setFromJson(json);
    group = json['group'] != null
        ? CategoryGroupEntity.fromJson(json['group'])
        : null;
  }
}

class LocalizationEntity extends JsonEntity {
  String codeInsee;

  LocalizationEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    codeInsee = json['code_insee'];
  }
}

class RegionEntity extends LocalizationEntity {
  String isoCode;

  RegionEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    isoCode = json['iso_code'];
  }
}

class CityEntity extends LocalizationEntity {
  String isoCode;

  CityEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    isoCode = json['iso_code'];
  }
}

class TownEntity extends JsonEntity {
  String zipCode;

  TownEntity.fromJson(Map<String, dynamic> json) {
    setFromJson(json);
  }

  @override
  setFromJson(Map<String, dynamic> json) {
    super.setFromJson(json);
    zipCode = json['zip_code'];
  }
}
