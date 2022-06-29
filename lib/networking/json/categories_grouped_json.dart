import 'package:afariat/networking/json/abstract_json_resource.dart';

/// represents a list of categoryGrouped json resource
class CategoriesGroupedJsonList extends AbstractJsonResource {
  List<CategoryGroupedJson> data;

  CategoriesGroupedJsonList({this.data});

  CategoriesGroupedJsonList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryGroupedJson>[];
      json['data'].forEach((v) {
        data.add(new CategoryGroupedJson.fromJson(v));
      });
    }
  }
}

/// represents a single categoryGrouped json resource
class CategoryGroupedJson {
  int id;
  String name;
  List<SubCategoryJson> subcategories;

  CategoryGroupedJson({this.id, this.name, this.subcategories});

  CategoryGroupedJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subcategories'] != null) {
      subcategories = <SubCategoryJson>[];
      json['subcategories'].forEach((v) {
        subcategories.add(new SubCategoryJson.fromJson(v));
      });
    }
  }
}

/// A single subcategory json resource
class SubCategoryJson {
  int id;
  String name;

  SubCategoryJson({this.id, this.name});

  SubCategoryJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
