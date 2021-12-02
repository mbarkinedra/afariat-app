
class AdvertsJson {




  AdvertsJson({
    this.page,
    this.limit,
    this.pages,
    this.total,
    this.embedded,
    this.links,
  });
  int page;
  int limit;
  int pages;
  int total;
  Links links;
  Embedded embedded;


  AdvertsJson.fromJson(Map<String, dynamic> json){
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
    total = json['total'];
    print("_links  ${json['_links']}");
    links = Links.fromJson(json['_links']);
    embedded = Embedded.fromJson(json['_embedded']);
  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['page'] = page;
//   data['limit'] = limit;
//   data['pages'] = pages;
//   data['total'] = total;
//   data['_links'] = links.toJson();
//   data['_embedded'] = embedded.toJson();
//   return data;
// }
}

class Links {
  Links({
    this.self,
    this.first,
    this.last,
    this.next,
  });
  Self  self;
  First  first;
  Last  last;
  Next  next;

  Links.fromJson(Map<String, dynamic>   json){

    self = Self.fromJson(json    ['self']);
    first = First.fromJson(json    ["first"]);
    last = Last.fromJson(json     ['last']);
    next = Next.fromJson(json     ['next']);
  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['self'] = self.toJson();
//   data['first'] = first.toJson();
//   data['last'] = last.toJson();
//   data['next'] = next.toJson();
//   return data;
// }
}

class Self {
  Self({
    this.href,
  });
  String href;

  Self.fromJson(Map<String, dynamic> json){
    href = json['href'];
  }


}

class First {
  First({
    this.href,
  });
  String  href;

  First.fromJson(Map<String, dynamic>   json){
    // href = json  ['href'];
  }

}

class Last {
  Last({
    this.href,
  });
  String href;

  Last.fromJson(Map<String, dynamic> json){
    // href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Next {
  Next({
    this.href,
  });
  String href;

  Next.fromJson(Map<String, dynamic> json){
    //   href = json['href'];
  }


}

class Embedded {
  Embedded({
    this.adverts,
  });
  List<Adverts> adverts;

  Embedded . fromJson(Map<String, dynamic>  json){
    adverts = List.from(json ['adverts']).map((e)=>Adverts.fromJson(e)).toList();

  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['adverts'] = adverts.map((e)=>e.toJson()).toList();
//   return data;
// }
}

class Adverts {
  Adverts({
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

  Adverts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryGroup = CategoryGroup.fromJson(json['categoryGroup']);
    photo = "https://afariat.com/" +json['photo'];
    description = json['description'];
    title = json['title'];
    price = json['price'];
    region = Region.fromJson(json['region']);
    city = City.fromJson(json['city']);
    town = Town.fromJson(json['town']);
    modifiedAt = json['modified_at'];
    links = Links.fromJson(json['_links']);
  }

// Map<String, dynamic> toJson() {
//   final _data = <String, dynamic>{};
//   _data['id'] = id;
//   _data['categoryGroup'] = categoryGroup.toJson();
//   _data['photo'] = photo;
//   _data['description'] = description;
//   _data['title'] = title;
//   _data['price'] = price;
//   _data['region'] = region.toJson();
//   _data['city'] = city.toJson();
//   _data['town'] = town.toJson();
//   _data['modified_at'] = modifiedAt;
//   _data['_links'] = links.toJson();
//   return _data;
// }
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
  Links  links;

  CategoryGroup.fromJson(Map<String, dynamic> json){
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
//   data['_links'] = links!.toJson();
//   return data;
// }
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
  Links  links;

  Region.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isoCode = json['iso_code'];
    codeInsee = json['code_insee'];
    order = json['order'];
    links = Links.fromJson(json['_links']);
  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['id'] = id;
//   data['name'] = name;
//   data['iso_code'] = isoCode;
//   data['code_insee'] = codeInsee;
//   data['order'] = order;
//   data['_links'] = links.toJson();
//   return data;
// }
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
  Links  links;

  City.fromJson(Map<String, dynamic> json){
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
  Links  links;

  Town.fromJson(Map<String, dynamic> json){
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