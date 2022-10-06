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
  String id;
  String name;

  SearchSuggestionJson({this.id, this.name});

  SearchSuggestionJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return name ?? '';
  }

  bool isEqual(SearchSuggestionJson searchSuggestionJson) {
    return name == searchSuggestionJson.name && id == searchSuggestionJson.id;
  }
}
