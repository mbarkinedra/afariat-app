import '../../config/settings_app.dart';
import 'abstract_json_resource.dart';
import 'link.dart';
import 'ref_json.dart';

class AdvertMinimalJson extends AbstractJsonResource {
  int id;
  String createdAt;
  String updatedAt;
  CategoryGroupEntity categoryGroup;
  String photo;
  String description;
  String title;
  int price;
  RegionEntity region;
  CityEntity city;
  TownEntity town;
  String modifiedAt;
  Links links;
  bool isFavorite;

  AdvertMinimalJson(
      {this.id,
      this.createdAt,
      this.updatedAt,
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

  AdvertMinimalJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryGroup = CategoryGroupEntity.fromJson(json['categoryGroup']);

    if (json['photo'] != null) {
      photo = SettingsApp.baseUrl + "/" + json['photo'];
    }

    description = json['description'];
    title = json['title'];
    price = json['price'];
    isFavorite = json['is_favorite'];

    region = RegionEntity.fromJson(json['region']);
    city = CityEntity.fromJson(json['city']);
    town = TownEntity.fromJson(json['town']);
    modifiedAt = json['modified_at'];
    links = Links.fromJson(json['_links']);
  }

  toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    json['modified_at'] = modifiedAt;
    json['updated_at'] = updatedAt;
    if (categoryGroup != null) {
      json['categoryGroup'] = categoryGroup.toJson();
    }
    json['photo'] = photo;
    json['description'] = description;
    json['title'] = title;
    json['price'] = price;
    if (region != null) {
      json['region'] = region.toJson();
    }
    if (city != null) {
      json['city'] = city.toJson();
    }
    if (town != null) {
      json['town'] = town.toJson();
    }
    json['is_favorite'] = isFavorite;
    if (links != null) {
      json['_links'] = links.toJson();
    }
    return json;
  }
}
