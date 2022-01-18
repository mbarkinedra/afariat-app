import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

class ModifAdsJson extends AbstractJsonResource{
  String createdAt;
  int id;
  String username;
  String mobilePhoneNumber;
  String title;
  String slug;
  String description;
  int price;
  bool showPhoneNumber;
  AdvertType advertType;
  Category category;
  Region region;
  Group city;
  Group town;
  List<Photos> photos;
  String shortUrl;
  Links lLinks;

  ModifAdsJson(
      {this.createdAt,
        this.id,
        this.username,
        this.mobilePhoneNumber,
        this.title,
        this.slug,
        this.description,
        this.price,
        this.showPhoneNumber,
        this.advertType,
        this.category,
        this.region,
        this.city,
        this.town,
        this.photos,
        this.shortUrl,
        this.lLinks});

  ModifAdsJson.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    username = json['username'];
    mobilePhoneNumber = json['mobilePhoneNumber'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    showPhoneNumber = json['show_phone_number'];
    advertType = json['advert_type'] != null
        ? new AdvertType.fromJson(json['advert_type'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    city = json['city'] != null ? new Group.fromJson(json['city']) : null;
    town = json['town'] != null ? new Group.fromJson(json['town']) : null;
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    shortUrl = json['short_url'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
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
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['short_url'] = this.shortUrl;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
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
  int id;
  String name;
  Group group;
  Links lLinks;

  Category({this.id, this.name, this.group, this.lLinks});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Group {
  int id;
  String name;
  Links lLinks;

  Group({this.id, this.name, this.lLinks});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  Self self;
  Self search;

  Links({this.self, this.search});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    search = json['search'] != null ? new Self.fromJson(json['search']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.search != null) {
      data['search'] = this.search.toJson();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Region {
  int id;
  String name;
  String isoCode;
  String codeInsee;
  Links lLinks;

  Region({this.id, this.name, this.isoCode, this.codeInsee, this.lLinks});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    codeInsee = json['code_insee'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso_code'] = this.isoCode;
    data['code_insee'] = this.codeInsee;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Photos {
  String path;

  Photos({this.path});

  Photos.fromJson(Map<String, dynamic> json) {
    path =SettingsApp.baseUrl +"/"+ json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}


