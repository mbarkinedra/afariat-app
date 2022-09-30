import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

import 'link.dart';

class AdvertListJson extends AbstractJsonResource {
  int page;
  int limit;
  int pages;
  int total;
  Links links;
  Embedded embedded;

  AdvertListJson({
    this.page,
    this.limit,
    this.pages,
    this.total,
    this.embedded,
    this.links,
  });

  AdvertListJson.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
    links = Links.fromJson(json['_links']);
    embedded = Embedded.fromJson(json['_embedded']);
  }

  List<AdvertJson> adverts() => embedded?.adverts;
}

class Embedded {
  List<AdvertJson> adverts;

  Embedded({this.adverts});

  Embedded.fromJson(Map<String, dynamic> json) {
    adverts =
        List.from(json['adverts']).map((e) => AdvertJson.fromJson(e)).toList();
  }
}

class AdvertJson {
  int id;
  CategoryGroup categoryGroup;
  String photo;
  String description;
  String title;
  int price;
  Region region;
  City city;
  Town town;
  String modifiedAt;
  Links links;
  bool isFavorite;

  AdvertJson(
      {this.id,
      this.categoryGroup,
      this.photo,
      this.description,
      this.title,
      this.price,
      this.region,
      this.city,
      this.town,
      this.modifiedAt,
      this.links,
      this.isFavorite});

  AdvertJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGroup = CategoryGroup.fromJson(json['categoryGroup']);

    if (json['photo'] != null) {
      photo = SettingsApp.baseUrl + "/" + json['photo'];
    }

    description = json['description'];
    title = json['title'];
    price = json['price'];
    isFavorite = json['is_favorite'];

    region = Region.fromJson(json['region']);
    city = City.fromJson(json['city']);
    town = Town.fromJson(json['town']);
    modifiedAt = json['modified_at'];
    links = Links.fromJson(json['_links']);
  }
}

class CategoryGroup {
  CategoryGroup({
    this.id,
    this.name,
    this.order,
    this.links,
  });

  int id;
  String name;
  int order;
  Links links;

  CategoryGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }
}

class Region {
  int id;
  String name;
  String isoCode;
  String codeInsee;
  int order;
  Links links;

  Region({
    this.id,
    this.name,
    this.isoCode,
    this.codeInsee,
    this.order,
    this.links,
  });

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    codeInsee = json['code_insee'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }
}

class City {
  int id;
  String name;
  String isoCode;
  String codeInsee;
  int order;
  Links links;

  City({
    this.id,
    this.name,
    this.isoCode,
    this.codeInsee,
    this.order,
    this.links,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    codeInsee = json['code_insee'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }
}

class Town {
  int id;
  String name;
  String zipCode;
  String codeInsee;
  int order;
  Links links;

  Town({
    this.id,
    this.name,
    this.zipCode,
    this.codeInsee,
    this.order,
    this.links,
  });

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    zipCode = json['zip_code'];
    codeInsee = json['code_insee'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }
}
