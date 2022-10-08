import 'package:afariat/networking/json/abstract_json_resource.dart';

/// represents a list of categoryGrouped json resource
class CategoriesGroupedJsonList extends AbstractJsonResource {
  List<CategoryGroupedJson> data;

  CategoriesGroupedJsonList({this.data});

  CategoriesGroupedJsonList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryGroupedJson>[];
      json['data'].forEach((v) {
        data.add(CategoryGroupedJson.fromJson(v));
      });
    }
  }

  bool isNotEmpty() {
    if (data != null) {
      return data.isNotEmpty;
    }
    return false;
  }

  int length() => isNotEmpty() ? data.length : 0;

  List<CategoryGroupedJson> toList() => data;
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


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (id != null) {
      json['id'] = id;
    }
    if (name != null) {
      json['name'] = name;
    }
    return json;
  }
}
