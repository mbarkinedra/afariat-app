import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/search/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/filter.dart';
import '../../../networking/api/autocomplete_api.dart';
import '../../../networking/json/localization_json.dart';
import '../../../storage/AccountInfoStorage.dart';
import '../filter/filter_app_bar_viewcontroller.dart';
import '../filter/filter_viewcontroller.dart';

class LocalizationViewController extends GetxController {
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TextEditingController searchFiled = TextEditingController();

  //TODO: Init the list by the saved localizations in the storage
  Rx<LocalizationListJson> localizationsJsonList = LocalizationListJson().obs;
  final AutocompleteLocalizationApi _api = AutocompleteLocalizationApi();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

  String source;

  @override
  void onInit() async {
    loadLocalizationsFromStorage();
    super.onInit();
  }

  @override
  void dispose() {
    searchFiled.dispose();
    super.dispose();
  }

  Future<Rx<LocalizationListJson>> loadLocalizationsFromStorage() async {
    //load saved localizations from local storage only if the list is empty(first time, screen back without saving )
    if (localizationsJsonList.value.isEmpty()) {
      dynamic json = await accountInfoStorage.readLocalization();
      if (json != null) {
        localizationsJsonList.value = LocalizationListJson.fromJson(json);
      }
    }
    return localizationsJsonList;
  }

  Future<List<LocalizationJson>> getSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }
    _api.search = query;
    LocalizationListJson result = await _api.getList();
    return result.toList();
  }

  addLocalization(LocalizationJson localizationJson) {
    localizationsJsonList.value.add(localizationJson);
  }

  /*removeLocalization(LocalizationJson localizationJson) {
    localizationsJsonList.value.remove(localizationJson);
    localizationsJsonList.refresh();
  }*/

  removeLocalizationAt(int index) async {
    localizationsJsonList.value.removeAt(index);
    //update the search list
    Filter.setLocalizationList(localizationsJsonList.value);
    await Filter.loadFromStorage();
    Filter.localization.refresh();

    Get.find<SearchViewController>().makeSearch();
  }

  clearSearchField() => searchFiled.clear();

  save(BuildContext context) async {
    //TODO: Save the localization to local storage
    Filter.setLocalizationList(localizationsJsonList.value);

    //refresh the list of the filter controller => does not work
    await Filter.loadFromStorage();
    Filter.localization.refresh();

    Get.find<SearchViewController>().makeSearch();

    if (source != null && source == 'home') {
      // go to search page
      Get.toNamed(AppRouting.search);
    } else {
      // get back
      Get.back();
    }
  }
}
