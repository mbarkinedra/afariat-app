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

    links = Links.fromJson(json['_links']);
    embedded = Embedded.fromJson(json['_embedded']);
  }

  List<AdvertJson> adverts() {
    return embedded != null ? embedded.adverts : null;
  }
}

class Links {
  Link self;
  Link first;
  Link last;
  Link next;
  Link previous;

  Links({this.self, this.first, this.last, this.next, this.previous});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Link.fromJson(json['self']) : null;
    first = json['first'] != null ? Link.fromJson(json['first']) : null;
    last = json['last'] != null ? Link.fromJson(json['last']) : null;
    next = json['next'] != null ? Link.fromJson(json['next']) : null;
    previous =
        json['previous'] != null ? Link.fromJson(json['previous']) : null;
  }

  String getFirstUrl() {
    return (first != null) ? first.href : null;
  }

  String getNextUrl() {
    return (next != null) ? next.href : null;
  }

  String getPreviousUrl() {
    return (previous != null) ? previous.href : null;
  }

  String getLastUrl() {
    return (last != null) ? last.href : null;
  }

  String getSelfUrl() {
    return (self != null) ? self.href : null;
  }
}

class Link {
  Link({
    this.href,
  });

  String href;

  Link.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    href = json['href'];
  }
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
  bool is_favorite;

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
      this.is_favorite});

  AdvertJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGroup = CategoryGroup.fromJson(json['categoryGroup']);

    if (json['photo'] != null) {
      photo = SettingsApp.baseUrl + "/" + json['photo'];
    }

    description = json['description'];
    title = json['title'];
    price = json['price'];
    is_favorite = json['is_favorite'];

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
