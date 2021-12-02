import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

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
    print("_links  ${json['_links']}");
    links = Links.fromJson(json['_links']);
    embedded = Embedded.fromJson(json['_embedded']);
  }
}

class Links {
  Link self;
  Link first;
  Link last;
  Link next;

  Links({
    this.self,
    this.first,
    this.last,
    this.next,
  });

  Links.fromJson(Map<String, dynamic> json) {
    self = Link.fromJson(json['self']);
    /*first = Link.fromJson(json["first"]);
    last = Link.fromJson(json['last']);
    next = Link.fromJson(json['next']);*/

  }
}

class Link {
  Link({
    this.href,
  });

  String href;

  Link.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }
}

class Embedded {
  Embedded({
    this.adverts,
  });

  List<AdvertJson> adverts;

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

  AdvertJson({
    this.id,
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
  });

  AdvertJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGroup = CategoryGroup.fromJson(json['categoryGroup']);
    photo = SettingsApp.baseUrl +"/"+ json['photo'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
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
  Region({
    this.id,
    this.name,
    this.isoCode,
    this.codeInsee,
    this.order,
    this.links,
  });

  int id;
  String name;
  String isoCode;
  String codeInsee;
  int order;
  Links links;

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
  City({
    this.id,
    this.name,
    this.order,
    this.links,
  });

  int id;
  String name;
  int order;
  Links links;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['id'] = id;
//   data['name'] = name;
//   data['order'] = order;
//   data['_links'] = links.toJson();
//   return data;
// }
}

class Town {
  Town({
    this.id,
    this.name,
    this.order,
    this.links,
  });

  int id;
  String name;
  int order;
  Links links;

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }

}
