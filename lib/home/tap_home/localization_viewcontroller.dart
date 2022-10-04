import 'package:afariat/home/tap_home/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/filter.dart';
import '../../networking/api/autocomplete_api.dart';
import '../../networking/json/localization_json.dart';
import '../../storage/AccountInfoStorage.dart';
import 'filter_app_bar_viewcontroller.dart';
import 'filter_viewcontroller.dart';

class LocalizationViewController extends GetxController {
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TextEditingController searchFiled = TextEditingController();

  //TODO: Init the list by the saved localizations in the storage
  Rx<LocalizationListJson> localizationsJsonList = LocalizationListJson().obs;
  final AutocompleteLocalizationApi _api = AutocompleteLocalizationApi();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

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
    if(localizationsJsonList.value.isEmpty()) {
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

  removeLocalization(LocalizationJson localizationJson) {
    localizationsJsonList.value.remove(localizationJson);
    localizationsJsonList.refresh();
  }

  removeLocalizationAt(int index) {
    localizationsJsonList.value.removeAt(index);
  }

  clearSearchField() => searchFiled.clear();

  save(BuildContext context) async {
    //TODO: Save the localization to local storage
    Map<String, List<int>> localization =
        localizationsJsonList.value.toFilter();

    await accountInfoStorage.saveLocalization(localizationsJsonList.value.toJson());

    if (localization.isNotEmpty) {
      Filter.set(AccountInfoStorage.keyLocalization, localizationsJsonList.value.toFilter());
    } else {
      Filter.remove(AccountInfoStorage.keyLocalization);
    }
    //update the label of localization
    Get.find<FilterAppBarViewController>().setLocalizationLabel();
    //refresh the list of the filter controller => does not work
    await Get.find<FilterViewController>().loadLocalizationsFromStorage();
    Get.find<FilterViewController>().localizationsJsonList.refresh();
    Navigator.pop(context);

    Get.find<SearchViewController>().makeSearch();
  }
}
