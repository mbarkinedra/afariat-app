import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/app_routing.dart';
import '../../model/filter.dart';
import '../../networking/api/autocomplete_api.dart';
import '../../networking/json/serach_suggestion.dart';
import '../../storage/AccountInfoStorage.dart';
import '../tap_home/search_viewcontroller.dart';

class SearchFormViewController extends GetxController {
  TextEditingController searchFiled = TextEditingController();

  RxBool onlyPhotolight = false.obs;

  String source;

  final AutocompleteSearchSuggestionApi _api =
      AutocompleteSearchSuggestionApi();

  @override
  void onInit() async {
    super.onInit();
    onlyPhotolight.value =
        Filter.has('onlyPhoto') ? Filter.get('onlyPhoto') : false;
  }

  @override
  void dispose() {
    searchFiled.dispose();
    super.dispose();
  }

  updateOnlyPhotoLight(v) {
    onlyPhotolight.value = v;
    if (v) {
      Filter.set('onlyPhoto', v);
    } else {
      Filter.remove('onlyPhoto');
    }
  }

  Future<List<SearchSuggestionJson>> getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    SearchSuggestionListJson result = await _api.getSuggestions(query);
    //add the filled user query as first suggestion
    result.data.insert(0, SearchSuggestionJson(name: query, id: '0'));
    return result.toList();
  }

  suggestionSelect(SearchSuggestionJson suggestionJson) async {
    if (suggestionJson.name != null) {
      Filter.set("search", suggestionJson.name);
    } else {
      Filter.remove('search');
    }
    _redirectToSource();
  }

  allCategories() async {
    //reset all filters
    Filter.clearExcept(AccountInfoStorage.keyLocalization);
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
