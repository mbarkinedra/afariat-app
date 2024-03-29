import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/search/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/Environment.dart';
import '../../../model/filter.dart';
import '../../../networking/api/autocomplete_api.dart';
import '../../../networking/json/categories_grouped_json.dart';
import '../../../networking/json/localization_json.dart';
import '../../../networking/json/serach_suggestion.dart';
import '../../../remote_widget/price_range_slider_viewcontroller.dart';
import '../../../storage/AccountInfoStorage.dart';
import 'filter_app_bar_viewcontroller.dart';

class FilterViewController extends GetxController {
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  final PriceRangeSliderViewController priceRangeSliderViewController =
      PriceRangeSliderViewController();

  String source;

  TextEditingController searchFiled = TextEditingController();

  RxBool isLoadingSuggestions = false.obs;

  final AutocompleteSearchSuggestionApi _searchSuggestionApi =
      AutocompleteSearchSuggestionApi();

  @override
  void onInit() async {
    initLocalizationsFromStorageIfEmpty();
    super.onInit();
  }

  @override
  void dispose() {
    accountInfoStorage.dispose();
    priceRangeSliderViewController.dispose();
    super.dispose();
  }

  Future<Rx<LocalizationListJson>> initLocalizationsFromStorageIfEmpty() async {
    //load saved localizations from local storage only if the list is empty(first time, screen back without saving )
    if (Filter.localization.value.isEmpty()) {
      await Filter.loadFromStorage();
    }
    return Filter.localization;
  }

  clear(BuildContext context) async {
    Filter.clear();
    Get.find<SearchViewController>().makeSearch();
    if (source == 'home') {
      //go to search page
      Get.toNamed(AppRouting.search);
    } else {
      Navigator.pop(context);
      if (source != null && source == 'searchForm') {
        //pop again to get back to search view
        Navigator.pop(context);
      }
    }
  }

  search(BuildContext context) async {
    Get.find<SearchViewController>().makeSearch();
    if (source == 'home') {
      //go to search page
      Get.toNamed(AppRouting.search);
    } else {
      Navigator.pop(context);
      if (source != null && source == 'searchForm') {
        //pop again to get back to search view
        Navigator.pop(context);
      }
    }
  }

  Future<List<SearchSuggestionJson>> getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    isLoadingSuggestions.value = true;
    SearchSuggestionListJson result =
        await _searchSuggestionApi.getSuggestions(query);
    //add the filled user query as first suggestion
    result.data.insert(
        result.data.length, SearchSuggestionJson(text: query, categoryId: 0));
    isLoadingSuggestions.value = false;
    return result.toList();
  }

  suggestionSelect(SearchSuggestionJson suggestionJson) async {
    searchFiled.text = suggestionJson.text;
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
  }
}
