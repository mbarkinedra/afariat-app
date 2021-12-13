import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class AdvertDetails  extends AbstractJsonResource{
  String createdAt;
  int id;
  String username;
  String mobilePhoneNumber;
  String title;
  String slug;
  String description;
  int price;
  bool showPhoneNumber;
  int area;
  AdvertType advertType;
  Category category;
  Region region;
  Category city;
  Category town;
  RoomsNumber roomsNumber;
  List<Photos> photos;
  String shortUrl;
  Links lLinkss;

  AdvertDetails(
      {this.createdAt,
        this.id,
        this.username,
        this.mobilePhoneNumber,
        this.title,
        this.slug,
        this.description,
        this.price,
        this.showPhoneNumber,
        this.area,
        this.advertType,
        this.category,
        this.region,
        this.city,
        this.town,
        this.roomsNumber,
        this.photos,
        this.shortUrl,
        this.lLinkss});

  AdvertDetails.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    username = json['username'];
    mobilePhoneNumber = json['mobilePhoneNumber'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    showPhoneNumber = json['show_phone_number'];
    area = json['area'];
    advertType = json['advert_type'] != null
        ? new AdvertType.fromJson(json['advert_type'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    city = json['city'] != null ? new Category.fromJson(json['city']) : null;
    town = json['town'] != null ? new Category.fromJson(json['town']) : null;
    roomsNumber = json['rooms_number'] != null
        ? new RoomsNumber.fromJson(json['rooms_number'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
        json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    shortUrl = json['short_url'];
    lLinkss = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['username'] = this.username;
    data['mobilePhoneNumber'] = this.mobilePhoneNumber;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['price'] = this.price;
    data['show_phone_number'] = this.showPhoneNumber;
    data['area'] = this.area;
    if (this.advertType != null) {
      data['advert_type'] = this.advertType.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.town != null) {
      data['town'] = this.town.toJson();
    }
    if (this.roomsNumber != null) {
      data['rooms_number'] = this.roomsNumber.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['short_url'] = this.shortUrl;
    if (this.lLinkss != null) {
      data['_links'] = this.lLinkss.toJson();
    }
    return data;
  }
}

class AdvertType {
  String name;

  AdvertType({this.name});

  AdvertType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Category {
  String name;
  Links lLinks;

  Category({this.name, this.lLinks});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  Search search;

  Links({this.search});

  Links.fromJson(Map<String, dynamic> json) {
    search =
    json['search'] != null ? new Search.fromJson(json['search']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search.toJson();
    }
    return data;
  }
}

class Search {
  String href;

  Search({this.href});

  Search.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Region {
  String name;
  String isoCode;
  String codeInsee;
  Links lLinks;

  Region({this.name, this.isoCode, this.codeInsee, this.lLinks});

  Region.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isoCode = json['iso_code'];
    codeInsee = json['code_insee'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso_code'] = this.isoCode;
    data['code_insee'] = this.codeInsee;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class RoomsNumber {
  String value;

  RoomsNumber({this.value});

  RoomsNumber.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Photos {
  String path;

  Photos({this.path});

  Photos.fromJson(Map<String, dynamic> json) {
    path = SettingsApp.baseUrl +"/"+json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}

class Linkss {
  Search self;

  Linkss({this.self});

  Linkss.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Search.fromJson(json['self']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    return data;
  }
}
