import 'dart:convert';

import 'package:afariat/config/settings_app.dart';
import 'package:afariat/networking/json/abstract_json_resource.dart';
import 'package:afariat/networking/json/user_minimal_json.dart';

import '../../model/abstract_collection_list.dart';
import '../../model/advert_option_labels.dart';
import 'advert_minimal_json.dart';
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
  String defaultPhoto;
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
  UserMinimalJson user;
  List<AdvertMinimalJson> relatedAdverts = <AdvertMinimalJson>[];
  List<AdvertMinimalJson> userSameAdverts = <AdvertMinimalJson>[];

  AdvertDetailsJson({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.modifiedAt,
    this.title,
    this.slug,
    this.description,
    this.price,
    this.defaultPhoto,
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
    this.isFavorite,
    this.user,
    this.relatedAdverts,
    this.userSameAdverts,
  });

  AdvertDetailsJson.fromJson(Map<String, dynamic> jsonAdvert) {
    userId = jsonAdvert['userId'];
    createdAt = jsonAdvert['created_at'];
    updatedAt = jsonAdvert['updated_at'];
    modifiedAt = jsonAdvert['modified_at'];
    id = jsonAdvert['id'];
    isFavorite = jsonAdvert['is_favorite'];

    username = jsonAdvert['username'];
    mobilePhoneNumber = jsonAdvert['mobilePhoneNumber'];
    title = jsonAdvert['title'];
    slug = jsonAdvert['slug'];
    description = jsonAdvert['description'];
    price = jsonAdvert['price'];
    showPhoneNumber = jsonAdvert['show_phone_number'];
    isRegistredUser = jsonAdvert['isRegistredUser'];

    defaultPhoto = jsonAdvert['photo'] != null
        ? SettingsApp.baseUrl + "/" + jsonAdvert['photo']
        : null;

    advertType = jsonAdvert['advert_type'] != null
        ? AdvertTypeEntity.fromJson(jsonAdvert['advert_type'])
        : null;
    category = jsonAdvert['category'] != null
        ? CategoryEntity.fromJson(jsonAdvert['category'])
        : null;
    region = jsonAdvert['region'] != null
        ? RegionEntity.fromJson(jsonAdvert['region'])
        : null;
    city = jsonAdvert['city'] != null
        ? CityEntity.fromJson(jsonAdvert['city'])
        : null;
    town = jsonAdvert['town'] != null
        ? TownEntity.fromJson(jsonAdvert['town'])
        : null;

    for (String optionId in AdvertOptionLabels.optionsIds.keys) {
      if (jsonAdvert.containsKey(optionId)) {
        jsonAdvert[optionId] is Map
            ? options.add(AdvertOption.fromJson(optionId, jsonAdvert[optionId]))
            : options.add(AdvertOption(
                optionId: optionId, value: jsonAdvert[optionId].toString()));
      }
    }
    status = jsonAdvert['status'];
    if (jsonAdvert['photos'] != null) {
      jsonAdvert['photos'].forEach((v) {
        photos.add(Photos.fromJson(v));
      });
    }
    shortUrl = jsonAdvert['short_url'];
    links = jsonAdvert['_links'] != null
        ? Links.fromJson(jsonAdvert['_links'])
        : null;
    user = jsonAdvert['user'] != null
        ? UserMinimalJson.fromJson(jsonAdvert['user'])
        : null;
    if (jsonAdvert['json_related_adverts'] != null &&
        jsonAdvert['json_related_adverts'].toString().isNotEmpty) {
      List<dynamic> related = jsonDecode(jsonAdvert['json_related_adverts']);
      for (var element in related) {
        relatedAdverts.add(AdvertMinimalJson.fromJson(element));
      }
    }
    if (jsonAdvert['json_same_user_adverts'] != null &&
        jsonAdvert['json_same_user_adverts'].toString().isNotEmpty) {
      List<dynamic> sameAds = jsonDecode(jsonAdvert['json_same_user_adverts']);
      for (var element in sameAds) {
        userSameAdverts.add(AdvertMinimalJson.fromJson(element));
      }
    }
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
    json['photo'] = defaultPhoto;
    json['show_phone_number'] = showPhoneNumber;
    json['userId'] = userId;
    json['isRegistredUser'] = isRegistredUser;
    json['is_favorite'] = isFavorite;
    json['status'] = status;
    if (advertType != null) {
      json['advert_type'] = advertType.toJson();
    }
    if (user != null) {
      json['user'] = user.toJson();
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
    if (relatedAdverts != null) {
      json['json_related_adverts'] =
          relatedAdverts.map((v) => v.toJson()).toList();
    }
    if (userSameAdverts != null) {
      json['json_same_user_adverts'] =
          userSameAdverts.map((v) => v.toJson()).toList();
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
