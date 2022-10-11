import 'abstract_json_resource.dart';

class SearchSuggestionListJson extends AbstractJsonResource {
  List<SearchSuggestionJson> data = [];

  SearchSuggestionListJson({this.data});

  SearchSuggestionListJson.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      data = <SearchSuggestionJson>[];
      json['results'].forEach((v) {
        SearchSuggestionJson element = SearchSuggestionJson.fromJson(v);
        data.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['results'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<SearchSuggestionJson> toList() => data;
}

class SearchSuggestionJson extends AbstractJsonResource {
  String text;
  int categoryId;
  String categoryName;

  SearchSuggestionJson({this.text, this.categoryId, this.categoryName});

  SearchSuggestionJson.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }

  @override
  String toString() {
    return text ?? '';
  }

  bool isEqual(SearchSuggestionJson searchSuggestionJson) {
    return text == searchSuggestionJson.text &&
        categoryId == searchSuggestionJson.categoryId;
  }
}
