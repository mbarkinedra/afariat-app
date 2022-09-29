import 'package:afariat/home/tap_home/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/Environment.dart';
import '../../model/filter.dart';
import '../../networking/json/localization_json.dart';
import '../../remote_widget/price_range_slider_viewcontroller.dart';
import '../../storage/AccountInfoStorage.dart';
import 'filter_app_bar_viewcontroller.dart';

class FilterViewController extends GetxController {
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();
  final PriceRangeSliderViewController priceRangeSliderViewController =
      PriceRangeSliderViewController();

  Rx<LocalizationListJson> localizationsJsonList = LocalizationListJson().obs;
  RxString categoryLabel = 'Choisissez une catégorie'.obs;

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
    if (localizationsJsonList.value.isEmpty()) {
      await loadLocalizationsFromStorage();
    }
    return localizationsJsonList;
  }

  loadLocalizationsFromStorage() async {
    dynamic json = await accountInfoStorage.readLocalization();
    if (json != null) {
      localizationsJsonList.value = LocalizationListJson.fromJson(json);
    }
  }

  clear(BuildContext context) async {
    //TODO: clean the filter
    await accountInfoStorage.removeLocalization();
    if(localizationsJsonList.value != null) {
      localizationsJsonList.value.clear();
    }
    Get.find<FilterAppBarViewController>().localizationLabel.value = Environment.allCountryLabel;
    Filter.clear();

    Get.find<SearchViewController>().makeSearch();
    Navigator.pop(context);
  }

}
