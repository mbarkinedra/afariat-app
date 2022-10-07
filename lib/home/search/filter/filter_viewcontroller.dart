import 'package:afariat/home/search/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/Environment.dart';
import '../../../model/filter.dart';
import '../../../networking/api/autocomplete_api.dart';
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
    Navigator.pop(context);
    if(source != null && source=='searchForm'){ //pop again to get back to search view
      Navigator.pop(context);
    }
  }

  search(BuildContext context) async {
    Get.find<SearchViewController>().makeSearch();
    Navigator.pop(context);
    if(source != null && source=='searchForm'){ //pop again to get back to search view
      Navigator.pop(context);
    }
  }

  Future<List<SearchSuggestionJson>> getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    SearchSuggestionListJson result =
        await _searchSuggestionApi.getSuggestions(query);
    //add the filled user query as first suggestion
    result.data.insert(0, SearchSuggestionJson(name: query, id: '0'));
    return result.toList();
  }
}
