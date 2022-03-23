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
    print('self: ${links.self.href}');
    print('next: ${links.next.href}');
    print('first: ${links.first.href}');
    print('last: ${links.last.href}');
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
  Links linkss;

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
    this.linkss,
  });

  AdvertJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGroup = CategoryGroup.fromJson(json['categoryGroup']);
    photo = SettingsApp.baseUrl + "/" + json['photo'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
    region = Region.fromJson(json['region']);
    city = City.fromJson(json['city']);
    town = Town.fromJson(json['town']);
    modifiedAt = json['modified_at'];
    linkss = Links.fromJson(json['_links']);
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

// import 'package:afariat/networking/json/abstract_json_resource.dart';
//
// class AdvertListJson  extends AbstractJsonResource{
//   int page;
//   int limit;
//   int pages;
//   int total;
//   Links lLinks;
//   Embedded eEmbedded;
//
//   AdvertListJson(
//       {this.page,
//         this.limit,
//         this.pages,
//         this.total,
//         this.lLinks,
//         this.eEmbedded});
//
//   AdvertListJson.fromJson(Map<String, dynamic> json) {
//     page = json['page'];
//     limit = json['limit'];
//     pages = json['pages'];
//     total = json['total'];
//     lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//     eEmbedded = json['_embedded'] != null
//         ? new Embedded.fromJson(json['_embedded'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['page'] = this.page;
//     data['limit'] = this.limit;
//     data['pages'] = this.pages;
//     data['total'] = this.total;
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks.toJson();
//     }
//     if (this.eEmbedded != null) {
//       data['_embedded'] = this.eEmbedded.toJson();
//     }
//     return data;
//   }
// }
//
// class Links {
//   Self self;
//   Self first;
//   Self last;
//   Self next;
//
//   Links({this.self, this.first, this.last, this.next});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     self = json['self'] != null ? new Self.fromJson(json['self']) : null;
//
//     first = json['first'] != null ? new Self.fromJson(json['first']) : null;
//     last = json['last'] != null ? new Self.fromJson(json['last']) : null;
//     print(last);
//
//     next = json['next'] != null ? new Self.fromJson(json['next']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self.toJson();
//     }
//     if (this.first != null) {
//       data['first'] = this.first.toJson();
//
//     }
//     if (this.last != null) {
//       data['last'] = this.last.toJson();
//     }
//     if (this.next != null) {
//       data['next'] = this.next.toJson();
//     }
//     return data;
//   }
// }
//
// class Self {
//   String href;
//
//   Self({this.href});
//
//   Self.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     return data;
//   }
// }
//
// class Embedded {
//   List<Adverts> adverts;
//
//   Embedded({this.adverts});
//
//   Embedded.fromJson(Map<String, dynamic> json) {
//     if (json['adverts'] != null) {
//       adverts = <Adverts>[];
//       json['adverts'].forEach((v) {
//         adverts.add(new Adverts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.adverts != null) {
//       data['adverts'] = this.adverts.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Adverts {
//   String createdAt;
//   int id;
//   CategoryGroup categoryGroup;
//   String photo;
//   String description;
//   String title;
//   int price;
//   Region region;
//   CategoryGroup city;
//   CategoryGroup town;
//   String modifiedAt;
//   Links lLinks;
//
//   Adverts(
//       {this.createdAt,
//         this.id,
//         this.categoryGroup,
//         this.photo,
//         this.description,
//         this.title,
//         this.price,
//         this.region,
//         this.city,
//         this.town,
//         this.modifiedAt,
//         this.lLinks});
//
//   Adverts.fromJson(Map<String, dynamic> json) {
//     createdAt = json['created_at'];
//     id = json['id'];
//     categoryGroup = json['categoryGroup'] != null
//         ? new CategoryGroup.fromJson(json['categoryGroup'])
//         : null;
//     photo = json['photo'];
//     description = json['description'];
//     title = json['title'];
//     price = json['price'];
//     region =
//     json['region'] != null ? new Region.fromJson(json['region']) : null;
//     city =
//     json['city'] != null ? new CategoryGroup.fromJson(json['city']) : null;
//     town =
//     json['town'] != null ? new CategoryGroup.fromJson(json['town']) : null;
//     modifiedAt = json['modified_at'];
//     lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     if (this.categoryGroup != null) {
//       data['categoryGroup'] = this.categoryGroup.toJson();
//     }
//     data['photo'] = this.photo;
//     data['description'] = this.description;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     if (this.region != null) {
//       data['region'] = this.region.toJson();
//     }
//     if (this.city != null) {
//       data['city'] = this.city.toJson();
//     }
//     if (this.town != null) {
//       data['town'] = this.town.toJson();
//     }
//     data['modified_at'] = this.modifiedAt;
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks.toJson();
//     }
//     return data;
//   }
// }
//
// class CategoryGroup {
//   int id;
//   String name;
//   int order;
//   Links lLinks;
//
//   CategoryGroup({this.id, this.name, this.order, this.lLinks});
//
//   CategoryGroup.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     order = json['order'];
//     lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['order'] = this.order;
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks.toJson();
//     }
//     return data;
//   }
// }
//
// class Linkss {
//   Self self;
//   Self search;
//
//   Linkss({this.self, this.search});
//
//   Linkss.fromJson(Map<String, dynamic> json) {
//     self = json['self'] != null ? new Self.fromJson(json['self']) : null;
//     search = json['search'] != null ? new Self.fromJson(json['search']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self.toJson();
//     }
//     if (this.search != null) {
//       data['search'] = this.search.toJson();
//     }
//     return data;
//   }
// }
//
// class Region {
//   int id;
//   String name;
//   String isoCode;
//   String codeInsee;
//   int order;
//   Links lLinks;
//
//   Region(
//       {this.id,
//         this.name,
//         this.isoCode,
//         this.codeInsee,
//         this.order,
//         this.lLinks});
//
//   Region.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     isoCode = json['iso_code'];
//     codeInsee = json['code_insee'];
//     order = json['order'];
//     lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['iso_code'] = this.isoCode;
//     data['code_insee'] = this.codeInsee;
//     data['order'] = this.order;
//     if (this.lLinks != null) {
//       data['_links'] = this.lLinks.toJson();
//     }
//     return data;
//   }
// }
//
// /*class Links {
//   Self self;
//
//   Links({this.self});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     self = json['self'] != null ? new Self.fromJson(json['self']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self.toJson();
//     }
//     return data;
//   }
// }*/
