import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';

import '../../model/abstract_collection_list.dart';
import '../../model/advert_option_labels.dart';
import 'link.dart';
import 'ref_json.dart';

class AdvertOptionList extends AbstractCollectionList {}

class AdvertOption extends AbstractOption {
  AdvertOption({optionId, value}) : super(optionId: optionId, value: value);

  AdvertOption.fromJson(String id, Map<String, dynamic> json) {
    optionId = id;
    value = json['value'];
  }
}

class AdvertDetailsJson extends AbstractJsonResource {
  int id;
  String createdAt;
  String updatedAt;
  String modifiedAt;
  String title;
  String slug;
  String description;
  int price;
  bool showPhoneNumber;
  AdvertTypeEntity advertType;
  CategoryEntity category;
  RegionEntity region;
  CityEntity city;
  TownEntity town;
  List<Photos> photos = <Photos>[];
  String shortUrl;
  Links links;
  AdvertOptionList options = AdvertOptionList();
  int status;
  int userId;
  bool isRegistredUser;
  String username;
  String mobilePhoneNumber;
  bool isFavorite;

  AdvertDetailsJson(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.modifiedAt,
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
      this.links,
      this.options,
      this.status,
      this.userId,
      this.isRegistredUser,
      this.username,
      this.mobilePhoneNumber,
      this.isFavorite});

  AdvertDetailsJson.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    modifiedAt = json['modified_at'];
    id = json['id'];
    isFavorite = json['is_favorite'];

    username = json['username'];
    mobilePhoneNumber = json['mobilePhoneNumber'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    showPhoneNumber = json['show_phone_number'];
    isRegistredUser = json['isRegistredUser'];

    advertType = json['advert_type'] != null
        ? AdvertTypeEntity.fromJson(json['advert_type'])
        : null;
    category = json['category'] != null
        ? CategoryEntity.fromJson(json['category'])
        : null;
    region =
        json['region'] != null ? RegionEntity.fromJson(json['region']) : null;
    city = json['city'] != null ? CityEntity.fromJson(json['city']) : null;
    town = json['town'] != null ? TownEntity.fromJson(json['town']) : null;

    for (String optionId in AdvertOptionLabels.optionsIds.keys) {
      if (json.containsKey(optionId)) {
        json[optionId] is Map
            ? options.add(AdvertOption.fromJson(optionId, json[optionId]))
            : options.add(AdvertOption(
                optionId: optionId, value: json[optionId].toString()));
      }
    }
    status = json['status'];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    shortUrl = json['short_url'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['modified_at'] = modifiedAt;
    json['username'] = username;
    json['mobilePhoneNumber'] = mobilePhoneNumber;
    json['title'] = title;
    json['slug'] = slug;
    json['description'] = description;
    json['price'] = price;
    json['show_phone_number'] = showPhoneNumber;
    json['userId'] = userId;
    json['isRegistredUser'] = isRegistredUser;
    json['is_favorite'] = isFavorite;
    json['status'] = status;
    if (advertType != null) {
      json['advert_type'] = advertType.toJson();
    }
    if (category != null) {
      json['category'] = category.toJson();
    }
    if (region != null) {
      json['region'] = region.toJson();
    }
    if (city != null) {
      json['city'] = city.toJson();
    }
    if (town != null) {
      json['town'] = town.toJson();
    }
    if (photos != null) {
      json['photos'] = photos.map((v) => v.toJson()).toList();
    }
    json['short_url'] = shortUrl;
    if (links != null) {
      json['_links'] = links.toJson();
    }
    return json;
  }
}

class Photos {
  String path;

  Photos({this.path});

  Photos.fromJson(Map<String, dynamic> json) {
    path = SettingsApp.baseUrl + "/" + json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = this.path;
    return data;
  }
}
