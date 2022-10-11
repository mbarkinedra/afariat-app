import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/app_routing.dart';
import '../../model/filter.dart';
import '../../networking/api/autocomplete_api.dart';
import '../../networking/json/categories_grouped_json.dart';
import '../../networking/json/serach_suggestion.dart';
import '../../storage/AccountInfoStorage.dart';
import 'search_viewcontroller.dart';

class SearchFormViewController extends GetxController {
  TextEditingController searchFiled = TextEditingController();

  String source;

  RxBool isLoadingSuggestions = false.obs;

  final AutocompleteSearchSuggestionApi _api =
      AutocompleteSearchSuggestionApi();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    searchFiled.dispose();
    super.dispose();
  }

  Future<List<SearchSuggestionJson>> getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    isLoadingSuggestions.value = true;
    SearchSuggestionListJson result = await _api.getSuggestions(query);
    //add the filled user query as last suggestion
    result.data.insert(
        result.data.length, SearchSuggestionJson(text: query, categoryId: 0));
    isLoadingSuggestions.value = false;
    return result.toList();
  }

  suggestionSelect(SearchSuggestionJson suggestionJson) async {
    if (suggestionJson.text != null) {
      Filter.search.value = suggestionJson.text;
    } else {
      Filter.search.value = null;
    }
    if (suggestionJson.categoryId != null && suggestionJson.categoryId != 0) {
      Filter.category.value.id = suggestionJson.categoryId;
      Filter.category.value.name = suggestionJson.categoryName;
    } else {
      Filter.category.value = SubCategoryJson();
    }
    _redirectToSource();
  }

  allCategories() async {
    //reset all filters
    Filter.clear(exceptLocalization: true);
    await _redirectToSource();
  }

  _redirectToSource() async {
    //refresh the search page to get new results
    SearchViewController searchViewController =
        Get.find<SearchViewController>();
    await searchViewController.makeSearch();
    //get back to search page
    if (source == AppRouting.search) {
      Get.back();
    } else {
      Get.toNamed(AppRouting.search);
    }
  }
}
