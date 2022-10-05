import 'package:get/get.dart';

import '../config/Environment.dart';
import '../config/Referentiel.dart';
import '../networking/json/categories_grouped_json.dart';
import '../networking/json/localization_json.dart';
import '../storage/AccountInfoStorage.dart';

class ParameterBag {
  Map<String, dynamic> data = {};

  ParameterBag([this.data]);

  factory ParameterBag.from(ParameterBag p) => ParameterBag(p.data);

  //Observable count to make it accessible from views
  RxInt count = 0.obs;

  String toHttpQuery() => Uri(
      queryParameters:
          data?.map((key, value) => MapEntry(key, value?.toString()))).query;

  set(k, v) {
    data ??= {};
    data[k] = v;
    count.value = data.length;
  }

  get(k) {
    if (data == null) {
      return null;
    }
    return data.containsKey(k) ? data[k] : null;
  }

  remove(k) {
    if (data[k] != null) {
      data.remove(k);
    }
    count.value = data.length;
  }

  clear() {
    data?.clear();
    count.value = 0;
  }

  clearExcept(k) {
    data?.removeWhere((key, value) => key == k);
    count.value = data?.length ?? 0;
  }

  has(k) {
    return data == null ? false : data.containsKey(k);
  }
}

class Filter {
  static Rx<ParameterBag> rxParameters = ParameterBag().obs;
  static RxString localizationLabel = Environment.allCountryLabel.obs;

  static RxInt length = 0.obs;

  static RxString search = ''.obs;
  static RxBool onlyPhoto = false.obs;
  static Rx<CategoryGroupedJson> categoryGroup = CategoryGroupedJson().obs;
  static Rx<SubCategoryJson> category = SubCategoryJson().obs;
  static Rx<LocalizationListJson> localization = LocalizationListJson().obs;
  static RxInt minPrice = Referential.priceMinId.obs;
  static RxInt maxPrice = Referential.priceMaxId.obs;

  static int count() {
    int cpt = 0;
    (search.value != null && search.value != '') ? cpt++ : cpt;
    (onlyPhoto.value != null && onlyPhoto.value == true) ? cpt++ : cpt;
    (categoryGroup.value != null && categoryGroup.value.id != null)
        ? cpt++
        : cpt;
    (category.value != null && category.value.id != null) ? cpt++ : cpt;
    (localization.value != null && localization.value.isNotEmpty())
        ? cpt++
        : cpt;
    (minPrice.value != null && minPrice.value > Referential.priceMinId)
        ? cpt++
        : cpt;
    (maxPrice.value != null && maxPrice.value < Referential.priceMaxId)
        ? cpt++
        : cpt;

    length.value = cpt;
    print(localization.value.isNotEmpty());
    return cpt;
  }

  static String toHttpQuery() {
    ParameterBag parameterBag = ParameterBag();

    if (search.value != null && search.value != '') {
      parameterBag.set('search', search.value);
    }
    if (onlyPhoto.value != null && onlyPhoto.value == true) {
      parameterBag.set('onlyPhoto', onlyPhoto.value);
    }
    if (categoryGroup.value != null && categoryGroup.value.id != null) {
      parameterBag.set('categoryGroup', categoryGroup.value.id);
    }
    if (category.value != null && category.value.id != null) {
      parameterBag.set('category', category.value.id);
    }
    if (localization.value != null && localization.value.isNotEmpty() != null) {
      parameterBag.set('localisation', localization.value.toFilter());
    }
    if (minPrice.value != null && minPrice.value > Referential.priceMinId) {
      parameterBag.set('minPrice', minPrice.value);
    }
    if (maxPrice.value != null && maxPrice.value < Referential.priceMaxId) {
      parameterBag.set('maxPrice', maxPrice.value);
    }
    return parameterBag.toHttpQuery();
  }

  static Future<void> setLocalizationList(
      LocalizationListJson localizationListJson) async {
    localization.value = localizationListJson;
    //save to storage
    await Get.find<AccountInfoStorage>()
        .saveLocalization(localizationListJson.toJson());

    updateLocalizationLabel();
    localization.refresh();
  }

  static Future<void> loadFromStorage() async {
    if (localization.value.isEmpty()) {
      dynamic json = await Get.find<AccountInfoStorage>().readLocalization();
      if (json != null) {
        localization.value = LocalizationListJson.fromJson(json);
      } else {
        localization.value = LocalizationListJson();
      }
    }

    updateLocalizationLabel();
    localization.refresh();
  }

  static updateLocalizationLabel() {
    switch (localization.value.count()) {
      case 0:
        localizationLabel.value = Environment.allCountryLabel;
        break;
      case 1:
        localizationLabel.value = localization.value.toList().first.name;
        break;
      default:
        localizationLabel.value = localization.value.toList().first.name +
            ' +' +
            (localization.value.count() - 1).toString();
        break;
    }
  }

  /// Set data to map searchData
  static set(k, v) => rxParameters.value.set(k, v);

  static get(k) => rxParameters.value.get(k);

  static has(k) => rxParameters.value.has(k);

  /// Delete data  from map searchData
  static remove(k) => rxParameters.value.remove(k);

  /// Clear the filter data
  static void clear() async {
    search.value = '';
    onlyPhoto.value = false;
    categoryGroup.value = CategoryGroupedJson();
    category.value = SubCategoryJson();
    localization.value = LocalizationListJson();
    minPrice.value = Referential.priceMinId;
    maxPrice.value = Referential.priceMaxId;

    await Get.find<AccountInfoStorage>().removeLocalization();

    updateLocalizationLabel();
    rxParameters.value.clear();
  }

  ///Clear all except the given index param
  static clearExcept(k) => rxParameters.value.clearExcept(k);
}
